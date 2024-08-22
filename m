Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA25C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FDA88C94;
	Thu, 22 Aug 2024 04:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i0db+HZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BF088C94; Thu, 22 Aug 2024 04:56:43 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF5088C7F
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81fbbd4775bso15038239f.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295399; x=1724900199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LTzuYN1gXg7GDoaGCyhSQL5Seb2gaxh16RjnCPGsUkQ=;
 b=i0db+HZf6dr1pkIYYNUBJoJiDwFYnU807IB2ukwxJYnIHpcKWY9v8CasyurRa5+qBP
 2oocy85Lu/dIoN0/xRbN9LGVl3p6yLY+4vn8vgkUAWLH7MJPOhjn7iAdmmTXwNkBNsFT
 hgw3fVSW97EPy/KU+Z5tpDF51IlPnh9WYqOmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295399; x=1724900199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LTzuYN1gXg7GDoaGCyhSQL5Seb2gaxh16RjnCPGsUkQ=;
 b=v7VcySab9+W/n8pKW6VEQ70t1jkPVUVYMYlF0eXRqf9RCRdk6QnbFAU5ZTKpBLJlA/
 BS9OU/wjaKS4PHyUAlh2M66fVwLUZ6QPVAuTUs9pjfLAp8tYlK4Wz+Nco7vKqIu7mYdT
 TKn4HY4iOhRo0bGFx0tuFtzqozJxfup3juiSq9wHEAf5UKO1CsIN/3yEw95CNN+byGX0
 cR7p/wLAdVTgMBYZhGGGcMUYKpLCq5PUGcIAF3xHGcB7pZTQ+EfonQ22SnrF0Pcj+N+p
 kWESLK+Lx+MT3Y63TJbxy5DHcZJmfGuOssA+fIdsiXmZ1zYe/nhLR27bX6UBFC3SNeNL
 4vAQ==
X-Gm-Message-State: AOJu0YwOKcQ/Mmpl74I74wyHC/fGRr8H0SbW+PjxJgIw3z0fqSFaYJ8Y
 Fq0k2Uui6KsNbWTkR7R/gmkGaAE9GBX+ixTW4p8ZLFgUtrlJihC9Ggoe5avcU+5YJQwNC7NY/m4
 =
X-Google-Smtp-Source: AGHT+IHDwKlJGBbG4EHNjTtxIAoJvudfFv8AvpQUi+XmpfkDFMN6Q6JDf3/EtGGSERXVj9RpO/qibA==
X-Received: by 2002:a05:6602:29c1:b0:81f:8f5d:6e19 with SMTP id
 ca18e2360f4ac-825318a33f5mr505807039f.2.1724295398632; 
 Wed, 21 Aug 2024 19:56:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 00/19] labgrid: Provide an integration with Labgrid
Date: Wed, 21 Aug 2024 20:56:12 -0600
Message-Id: <20240822025631.1838434-1-sjg@chromium.org>
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

ub-bisect
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

Changes in v4:
- Expand the commit message

Changes in v3:
- Split out most patches into two new series and update cover letter

Changes in v2:
- Only disable echo if a terminal is detected
- Avoid running a docker image for skipped lab tests

Simon Glass (19):
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
  CI: Allow running tests on sjg lab

 .gitlab-ci.yml                        | 153 +++++++++++++++++++++++++
 test/py/conftest.py                   |  86 +++++++++++---
 test/py/u_boot_console_base.py        | 154 ++++++++++++++++++--------
 test/py/u_boot_console_exec_attach.py |  31 ++++--
 test/py/u_boot_spawn.py               | 120 +++++++++++++++++---
 test/test-main.c                      |  16 ++-
 6 files changed, 470 insertions(+), 90 deletions(-)

-- 
2.34.1

