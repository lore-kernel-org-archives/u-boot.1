Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AE4D1CA07
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1F288ECC;
	Mon,  4 Nov 2024 23:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DbPVqaFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBD588E96; Mon,  4 Nov 2024 23:46:01 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 621E688D29
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-83ab21c26f1so194422339f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760356; x=1731365156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dIH4/HqUQ86JekoNoaOntmlr0lMBmiErm8zlQgdO4t8=;
 b=DbPVqaFkRrUmLRiSXTV+kZfecJlhgIycKpo+aZf4jfkMOLgoSaqBm2A2/wHBpgMqRw
 vv0JLZkXV1Ni9xXBiLkW6JU72HF/fsN81MDmxtkGRq+JUAIpAxNgpyc9rKE+ucQLj+xJ
 Ph3y8fd7cczV/d7qa22Q7W/mtLH7XBZaeouck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760356; x=1731365156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIH4/HqUQ86JekoNoaOntmlr0lMBmiErm8zlQgdO4t8=;
 b=JBqok8vIP958wtZ72ykzpCmYUwRfm4iPuRJIo9jeiKHA5855FGv5C+jfI3410h/20L
 sYpl+MKBXTVXQxRTggm+PTmNYNG8E5LC8AMUPdh0Tm4tQz0P/mCkftOz+QN7vGXxsiPh
 wHEafFSiQnjMoK8X8xoXuje/+a0lIJAPl+Z0UxGz0U3f/CEEK50qNnqIBsGFIdAHWK06
 7j45iLuyCv6fSVTJYjGjfVxB9knxTtgENjXQx0l20ahH9v60/ipU4IQeVNXYKydB9Gim
 ezTKqvRCIAuMIdGqBdCpkyfQETVko7/WGAl9kYtEH2I6JhgpXIdxefMpABcDG3+S4Mlf
 4VYQ==
X-Gm-Message-State: AOJu0YyETX0MscpfZCA2Ph2+e4It8ObVHsp3m2EwORu7N/kw4UucUoMT
 sDfw6CeOD8bIKmfAMAeF0hWH4IdVVb/sQ88uIWSMFLEUQii78TpfR+ruzgaMExRRoSllcUXbDsY
 =
X-Google-Smtp-Source: AGHT+IFzk/0sy6ocJ0QkvoYECPFByZSzud+mwRKjH9XzQ43oRc9Dd22TDtwD+1uuQaPVYQCZqvEGPQ==
X-Received: by 2002:a05:6e02:1383:b0:3a4:e99a:cffc with SMTP id
 e9e14a558f8ab-3a5e2512f34mr233142295ab.20.1730760356503; 
 Mon, 04 Nov 2024 14:45:56 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:45:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Love Kumar <love.kumar@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v8 00/11] labgrid: Provide an integration with Labgrid
Date: Mon,  4 Nov 2024 15:45:27 -0700
Message-ID: <20241104224550.677442-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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
2.43.0

