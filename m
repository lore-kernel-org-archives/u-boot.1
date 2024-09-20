Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3B9CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D9389332;
	Fri, 20 Sep 2024 08:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mafNktu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03BEF8932E; Fri, 20 Sep 2024 08:03:02 +0200 (CEST)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DF3890EC
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-a9018103214so211366266b.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812178; x=1727416978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xN8aZulPTo3ehnzcXb2p/sM0gmHybjajm/xX+JTQFNI=;
 b=mafNktu6N9sYgxTkS0Dynf4uLHrcPwpLSpETmK4lQxcvzT5ymHKZ9jWT1QlhB/75XE
 NZTYafXNTe6rVa20o4Gld1lG8ukcbBYptHZUAL9bXF7d9JYBuP1QZ/BH4NoWHROKdy+/
 uxMe2nfoSvM1LlmnITK0qJxbV4INPcph+Tf0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812178; x=1727416978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xN8aZulPTo3ehnzcXb2p/sM0gmHybjajm/xX+JTQFNI=;
 b=GYfI/Zfh45Zdk7bmvsyNojoI8sf+0kNZ8dlnG64G+3nbmCAm6/g8vawBjxfOtrc6LE
 +soJrnqVrZjVd+QhKykkExlGLimaDyfhixRN6kh41SZGv9yTmKbn6muh8D1U83HXkGJM
 beX5SATLBDNPuep5E2GaskemvkfW3KtDD6rFwFnj5DvDvLTB53HSS96YeFZhJ/4tTwgs
 D8nOoAie7S4u1rE33MUO//UfHyEdK12PCh2BYxuuI+levSJTT9T+P9YlmCMg4Fg9fsXU
 V7pgt5+cAoC2PpEXalCdwscK2DNO2JixlBqibDJYIo8+LXFNlZWtp37uPpzzyoqGcDqe
 eh4w==
X-Gm-Message-State: AOJu0YxDUTrx7OBHeK2i+SCXyOKypUwJ5JKk/Xyl6VMJWjzTaEihSBl6
 cCNQE5CfigI42SBmFLqQtp03vNT3di0WkZKf9amrBT48a4D//XGD6QsthsA9dN0Rz+DOZ0Eb014
 dhwj2HqE=
X-Google-Smtp-Source: AGHT+IFTHwWLAxfpG5blMeTZHgaZAEt7KEit0bj8n0TtIP6fePckJZbg+Uw68qSYE7o1alqbMUqE+g==
X-Received: by 2002:a17:907:94d4:b0:a8b:6ee7:ba1b with SMTP id
 a640c23a62f3a-a90d56d8d57mr110517666b.15.1726812177343; 
 Thu, 19 Sep 2024 23:02:57 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:02:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 00/19] labgrid: Provide an integration with Labgrid
Date: Fri, 20 Sep 2024 08:01:35 +0200
Message-ID: <20240920060158.106612-1-sjg@chromium.org>
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

Changes in v6:
- Rebase without an earlier patch
- Avoid doing the special shutdown unless USE_LABGRID is enabled
- Drop patch 'test: Pass stderr to stdout'

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

Simon Glass (19):
  test: Allow signaling that U-Boot is ready
  test: Use a constant for the test timeout
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
 test/py/u_boot_spawn.py               | 124 ++++++++++++++++++---
 test/test-main.c                      |  16 ++-
 6 files changed, 506 insertions(+), 91 deletions(-)

-- 
2.43.0

