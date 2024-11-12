Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A51D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A8489445;
	Tue, 12 Nov 2024 15:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T8YaK7s1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7660689447; Tue, 12 Nov 2024 15:13:34 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53328918E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a4c303206eso21189645ab.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420810; x=1732025610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LtlKdvlS718P9nwcBLn9Q+fCbi7ntU392pkdds9NhYk=;
 b=T8YaK7s1y+KTk7knj6Jr+WVOqNhP8+XBgcwuAg2Wr3pdgJDlBjAqXoirOhg4f209x3
 AEbHbxcDzVq8SlVOCZKAO8H4wEjHJj4ZazO5eyvywNAgnnKQ9EfKQ9Xkrlq68KhgFchV
 V5pYWzJfVukPIE8F6KKnKjlt7bYkXNc94NEWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420810; x=1732025610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LtlKdvlS718P9nwcBLn9Q+fCbi7ntU392pkdds9NhYk=;
 b=XdrFSU/jODzhW4VBZkpddNcvXJaQrRMx5Ff2kp4Jd/IGuEHATRka/+RJHc5SwOzpSW
 gGP5GrFiX+EcxnHuEVFtjfBuretumAuHKphdcAPnaVMdFT2AHLn4HYwxrfroFq7B8EGV
 B27u8YwaomiAROXKt2BWGH7e8hGc6kHR1EpzEy/UIiz251uoqfOvfN+lf8Z5bKo+DCHc
 EEWgQr4KYiyaoTVeGxqtEQekays4+GpLJEm/xRvEDNzBu2kJuPmE41rzO80zGlqzDwYc
 HPbSLPDhFmaaFdv7vig913/ERvXu199miIHr5mnVK1QT8cTHC23j2msKE9sZyhunZ2gO
 8DhA==
X-Gm-Message-State: AOJu0YxpaUhxDK9jm/pM+AZNxwoDI6HvAQKYZADI/gQ2t0ZINInZEoNt
 NkAJUAJ9TGEehP/Q+/N8oPqMfzXMVtz7mhQzjWo93tPK4LqEuGwr1qFFQIRV0D+1J4Gtntvm6YE
 =
X-Google-Smtp-Source: AGHT+IEQuDGM3JW/gVU1E++5Glka0MjO7/XOVn4urLWVBlZAkcMgsIhUPOf1Ee9XEPvwkbOIxgNPeg==
X-Received: by 2002:a05:6e02:1985:b0:3a6:a9bd:84bc with SMTP id
 e9e14a558f8ab-3a6f1a6eceemr162181775ab.18.1731420809728; 
 Tue, 12 Nov 2024 06:13:29 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Love Kumar <love.kumar@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v9 00/12] labgrid: Provide an integration with Labgrid
Date: Tue, 12 Nov 2024 07:13:14 -0700
Message-Id: <20241112141326.643128-1-sjg@chromium.org>
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

Changes in v9:
- Update commit message to explain the risks
- Expand the commit message to explain the value of a 'role'
- Add more details about the duplicated 'banner-finding' logic
- Support use of --capture=tee-sys
- Expand the commit message to explain graceful-shutdown better
- Correct explanation of how the two builds are used

Changes in v8:
- Use USE_LABGRID_SJG for graceful shutdown

Changes in v7:
- Rebase on testb series
- Expand commit message
- Rename option to --use-running-system
- Update --role help and get_details() comment to mention Labgrid-sjg
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
- Add new patch to correct a regex string in test_spi
- Avoid running a docker image for skipped lab tests

Simon Glass (12):
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
  test: Correct regex string in test_spi
  CI: Allow running tests on sjg lab

 .gitlab-ci.yml                        | 155 ++++++++++++++++++++++++++
 test/py/conftest.py                   |  73 ++++++++++--
 test/py/tests/test_spi.py             |   2 +-
 test/py/u_boot_console_base.py        | 123 ++++++++++++++------
 test/py/u_boot_console_exec_attach.py |  31 ++++--
 test/py/u_boot_spawn.py               |  44 +++++++-
 6 files changed, 374 insertions(+), 54 deletions(-)

-- 
2.34.1

