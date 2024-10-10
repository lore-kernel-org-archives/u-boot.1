Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FD8CEDDB1
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6DF88EFB;
	Thu, 10 Oct 2024 03:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dyoeWzgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF8388EFB; Thu, 10 Oct 2024 03:51:54 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470D288DD4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3a3a7d5a156so1356605ab.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 18:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728525111; x=1729129911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=70YzwuENjxz4biUlmKBEHqvpXAIji5hIjXt5v6H4A0o=;
 b=dyoeWzgOu7HlzhRFQWIaVI7Xaid7yPu3IA6N+93QnAZe/hOX93vZBtjFz0m1phJnGN
 uFDCeCJrJiP5PoT067f/X1UltAUXlEugc2pdB7ZCf2R/cph8fJBaO7Q41l3+LXn598qj
 sdZ7TyJB0iupG3Pnnt15hCYO5YRnUID2K7ox8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728525111; x=1729129911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=70YzwuENjxz4biUlmKBEHqvpXAIji5hIjXt5v6H4A0o=;
 b=R0adDllHEP27K9pPV+KuQv4A7pgERMEbsDKaOnJrsQ+AOZ+okkZzicC+a1fnnGc6bo
 2GCtTEART/4WrKCTCiHmkR/YXzFWCwJsHXopXZOHy0bop/6kbdWBxhKvM34ornq8/0g/
 7pjvukPOvHEzrbbhZhevjX9mHOL7VETsOWra+0dFXlKVsyjm79C3v2G4oE6AKowD+Rje
 DAEUL8/Fe051BSBL85zjdtSgOymX76YtLSOjUzEghUqUokf8cjlLWrACljCam6sj49nt
 F4mhN1i/OWS0GRcMCe0Sg1Y4qmaw4PZ7+4GfYSrxi+P0yJJqLzlXJ94hvQxXPveYi8cE
 SlUQ==
X-Gm-Message-State: AOJu0YxVXjE7Jcidn7uGdT5RNdv7BvRqeHCVrh2w6wjulDqsoVgZSGcm
 en6hPKWNv01UZooL9vkXQQzAEyRqZhDaRpmei68UBOx2JhYMonKId+0Kvppplm1XGkt+1/PSzfi
 epeyZ
X-Google-Smtp-Source: AGHT+IH4LJ8u44XJ/Dyd8bqZjznXKKnD0vFpF1XptxrLUtCWzP5XjYAqV2aoVsAyyKe7740N4Toe8g==
X-Received: by 2002:a05:6e02:20c3:b0:3a3:6045:f8bb with SMTP id
 e9e14a558f8ab-3a397ce586dmr40035745ab.10.1728525110898; 
 Wed, 09 Oct 2024 18:51:50 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaa947fsm61870173.126.2024.10.09.18.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 18:51:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 00/11] labgrid: Provide an integration with Labgrid
Date: Wed,  9 Oct 2024 19:51:34 -0600
Message-Id: <20241010015145.1977999-1-sjg@chromium.org>
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

Changes in v7:
- Rebase on testb series
- Expand commit message
- Rename option to --use-running-system
- Rebase on broken-out testb series

Changes in v6:
- Rebase without an earlier patch
- Avoid doing the special shutdown unless USE_LABGRID is enabled
- Drop patch 'test: Pass stderr to stdout'

Changes in v5:
- Add a few more comments
- Comment out the debugging, which might be useful later
- Add a patch to support testing with two board-builds

Changes in v3:
- Split out most patches into two new series and update cover letter

Changes in v2:
- Only disable echo if a terminal is detected
- Avoid running a docker image for skipped lab tests

Simon Glass (11):
  test: Allow signaling that U-Boot is ready
  test: Release board after tests complete
  test: Allow connecting to a running board
  test: Introduce the concept of a role
  test: Introduce lab mode
  test: Improve handling of sending commands
  test: Avoid double echo when starting up
  test: Try to shut down the lab console gracefully
  test: Add a section for closing the connection
  test: Support testing with two board-builds
  CI: Allow running tests on sjg lab

 .gitlab-ci.yml                        | 153 ++++++++++++++++++++++++++
 test/py/conftest.py                   |  73 ++++++++++--
 test/py/u_boot_console_base.py        | 123 +++++++++++++++------
 test/py/u_boot_console_exec_attach.py |  31 ++++--
 test/py/u_boot_spawn.py               |  36 +++++-
 5 files changed, 363 insertions(+), 53 deletions(-)

-- 
2.34.1

