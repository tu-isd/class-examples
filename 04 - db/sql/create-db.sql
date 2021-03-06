DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS photo;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS account;

CREATE TABLE member
(
  email      VARCHAR(100) NOT NULL
    CONSTRAINT user_pkey
    PRIMARY KEY,
  first_name VARCHAR(40)  NOT NULL,
  last_name  VARCHAR(40)  NOT NULL,
  password   VARCHAR(25)  NOT NULL
);
CREATE UNIQUE INDEX user_email_uindex
  ON member (email);
COMMENT ON TABLE member
IS 'System user';

CREATE TABLE photo
(
  id           SERIAL NOT NULL
    CONSTRAINT photo_pkey
    PRIMARY KEY,
  file_path    VARCHAR(255) NOT NULL DEFAULT 'bogus-path',
  member_email VARCHAR(100) NOT NULL
    CONSTRAINT photo_member_email_fk
    REFERENCES member
);

CREATE TABLE comment
(
  id     SERIAL       NOT NULL
    CONSTRAINT comment_pkey
    PRIMARY KEY,
  body   TEXT         NOT NULL,
  member VARCHAR(100) NOT NULL
    CONSTRAINT member_email_fk
    REFERENCES member (email)
);
CREATE UNIQUE INDEX comment_id_uindex
  ON comment (id);
COMMENT ON TABLE comment
IS 'Comments from a user';

CREATE TABLE account
(
  id      SERIAL      NOT NULL
    CONSTRAINT account_pkey
    PRIMARY KEY,
  name    VARCHAR(64) NOT NULL,
  balance REAL        NOT NULL
);
CREATE UNIQUE INDEX account_id_uindex
  ON account (id);

-- Make sure sequence numbers are larger than any initial data.
ALTER SEQUENCE account_id_seq RESTART WITH 100;
ALTER SEQUENCE comment_id_seq RESTART WITH 100;
