Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE00C7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5868C88960;
	Thu, 29 Aug 2024 00:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vndq9F+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B22888D4; Thu, 29 Aug 2024 00:08:56 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1287F8641A
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d22965434so3411905ab.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882929; x=1725487729; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WQZnygCAFK5m6MwA+ltE8WU7Qui+uEvKcS5noRZnXjM=;
 b=Vndq9F+hCWC0X4o3IxvZxrpsgIRC28M7mXYXZuPg1cQVyTb2bu7EwSuBq1YPABFp0u
 m4ei4tGyn0X6CKL6z+NEmeRFYj/fdzeXAJ/tlgMbgcnAisqZkoXGMHvcv/izBWDTsoPJ
 1FklaQ18ySG65aUfSMTx0eWyin31+zjG5jUmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882929; x=1725487729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQZnygCAFK5m6MwA+ltE8WU7Qui+uEvKcS5noRZnXjM=;
 b=ilmOb9bQYSZ1z8hle/hiuAPFtwlI4vAVXSJqdFmMWUFIvcEH51SaLk67SFvdPigewL
 TjNgFrYbr5xtEyL+0wBjZBWf2QYCglpd2svIRDVymiXffa9wsPaL872lz/lXUBz5SfCS
 nSHa9SJl36Kzuav8LoTcX8z289ZnojMWdscG9KTOpaf0a4zRSdcr29g1t/8WFyLOIGXN
 DaS1o0p/3rewO4/tSPSshfrmPP3LjKM8hsXKAr76FbCWKdCKBBwTStHm+O2a0FqgGoLg
 sJt154SBTZFs3lex5Wv32zJqzZOidE9poBHbbbFKoWHk2ITweAL+9OTO1btztIlUuuus
 04bg==
X-Gm-Message-State: AOJu0YwGTtz2bBzjl/9sgm1m6XBE1sPOJH0STotZKpQmEldrJoiZcUzp
 FhZGT9j9VO96UirhauGiSolBOq7AeHsRu2csjp0Wms2Dlnr/cnxgFvCaZZjwYaUVYJd2wwcUWAY
 =
X-Google-Smtp-Source: AGHT+IHxe4qyhCW0BftvzZcou8nsCVmHTMr0FdKmN0eVNOP9FC/EziNv+Clb3heFPzq7VV9vKieysA==
X-Received: by 2002:a05:6e02:1a4c:b0:39d:3b72:8781 with SMTP id
 e9e14a558f8ab-39f38b68e5fmr4255575ab.11.1724882929622; 
 Wed, 28 Aug 2024 15:08:49 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 00/20] labgrid: Provide an integration with Labgrid
Date: Wed, 28 Aug 2024 16:08:26 -0600
Message-Id: <20240828220846.1205813-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Labgrid provides access to a hardware lab in an automated way. It is
possible to boot U-Boot on boards in the lab without physically touching
them. It relies on relays, USB UARTs and SD muxes, among other things.

By way of background, about 4 years ago I wrong a thing called Labman[1]
which allowed my lab of about 30 devices to be operated remotely, using
tbot for the console and build integration. While it worked OK and I
used it for many bisects, I didn't take it any further.

It turns out that there was already an existing program, called Labgrid,
which I did not know about at time (thank you Tom for telling me). It is
more rounded than Labman and has a number of advantages:

- does not need udev rules, mostly
- has several existing users who rely on it
- supports multiple machines exporting their devices

It lacks a 'lab check' feature and a few other things, but these can be
remedied.

On and off over the past several weeks I have been experimenting with
Labgrid. I have managed to create an initial U-Boot integration (this
series) by adding various features to Labgrid[2] and the U-Boot test
hooks.

I hope that this might inspire others to set up boards and run tests
automatically, rather than relying on infrequent, manual test. Perhaps
it may even be possible to have a number of labs available.

Included in the integration are a number of simple scripts which make it
easy to connect to boards and run tests:

ub-int <target>
    Build and boot on a target, starting an interactive session

ub-cli <target>
    Build and boot on a target, ensure U-Boot starts and provide an interactive
    session from there

ub-smoke <target>
    Smoke test U-Boot to check that it boots to a prompt on a target

ub-bisect <target>
    Bisect a git tree to locate a failure on a particular target

ub-pyt <target> <testspec>
    Run U-Boot pytests on a target

Some of these help to provide the same tbot[4] workflow which I have
relied on for several years, albeit much simpler versions.

The goal here is to create some sort of script which can collect
patches from the mailing list, apply them and test them on a selection
of boards. I suspect that script already exists, so please let me know
what you suggest.

I hope you find this interesting and take a look!

[1] https://github.com/sjg20/u-boot/tree/lab6a
[2] https://github.com/labgrid-project/labgrid/pull/1411
[3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
[4] https://tbot.tools/index.html

Changes in v5:
- Add a few more comments
- Comment out the debugging, which might be useful later
- Add a patch to support testing with two board-builds

Changes in v4:
- Expand the commit message

Changes in v3:
- Split out most patches into two new series and update cover letter

Changes in v2:
- Only disable echo if a terminal is detected
- Avoid running a docker image for skipped lab tests

Simon Glass (20):
  test: Allow signaling that U-Boot is ready
  test: Use a constant for the test timeout
  test: Pass stderr to stdout
  test: Release board after tests complete
  test: Allow connecting to a running board
  test: Avoid failing skipped tests
  test: Create a common function to get the config
  test: Introduce the concept of a role
  test: Move the receive code into a function
  test: Separate out the exception handling
  test: Detect dead connections
  test: Tidy up remaining exceptions
  test: Introduce lab mode
  test: Improve handling of sending commands
  test: Fix mulptiplex_log typo
  test: Avoid double echo when starting up
  test: Try to shut down the lab console gracefully
  test: Add a section for closing the connection
  test: Support testing with two board-builds
  CI: Allow running tests on sjg lab

 .gitlab-ci.yml                        | 153 +++++++++++++++++++++++++
 test/py/conftest.py                   | 119 +++++++++++++++++---
 test/py/u_boot_console_base.py        | 154 ++++++++++++++++++--------
 test/py/u_boot_console_exec_attach.py |  31 ++++--
 test/py/u_boot_spawn.py               | 120 +++++++++++++++++---
 test/test-main.c                      |  16 ++-
 6 files changed, 503 insertions(+), 90 deletions(-)

-- 
2.34.1

