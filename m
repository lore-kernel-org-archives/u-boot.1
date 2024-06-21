Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7694FC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3AB78854E;
	Fri, 21 Jun 2024 21:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GQxVRJPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0FB884B2; Fri, 21 Jun 2024 21:52:14 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C17588059
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-7eeea388a8eso92245639f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999530; x=1719604330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rWXAlwLFSQoE2MnuuTeSuI1f4Vpi7Iz4DtOLJT94zt8=;
 b=GQxVRJPhNZ5ekirz84q1nIyXz5pkjvuSxRTioaKt3BHg7eBe1GfZwPn4PQujj2bevf
 EFtV7VD95qJysEePcnxFXmhnWtvpB3K6mPSsnsSVn/oE1lkgRQDWgDjfy+LX0NmDgRaj
 LV/3xhbkf2twc3mCBgc5zG5MP8XZH7p9lQAfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999530; x=1719604330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rWXAlwLFSQoE2MnuuTeSuI1f4Vpi7Iz4DtOLJT94zt8=;
 b=s5rvXjFUsatzoJT9i17Li//LhiRB7/8Ipejz23v5Rq0QvrtJVtgmEBfHSa1ItzxbCo
 QUmxuATWplkf5C0WyyRNIK938/xcIZqEqx9N5dHsBI61xrrJPDsIfkv3exLAjpZm35P8
 mzGpqpzDatYOTCK2IzFEJtt9F8BhKWJzmg+wIoOgzrrm4hCDYe6zgKfGoP/KBfIoZgMa
 IH7buK6fTT5Lax1azsBE3ew+4AkrypLY8VCqTzbgBlJfxJNCI+W8Pfg+ROAOowJAUH6Q
 ka/jzdxgM+YVudH6PHh62rYfXIFr62jUIMz9wklaLkMPy2rqBpDBsKLbJfBifzewwhON
 36UA==
X-Gm-Message-State: AOJu0YzLlOb1scL4DamMn8QEeU+PEDS8USktjouy/GVlwNHaqZ5ceTFk
 dfl13DD1ZFpN6txgNa1fAZidZpu/ajM4E3yVIyanNpiAzqZ6qLw7qsvjU3hQSlZCZqnw7ibjtpW
 mNH6C
X-Google-Smtp-Source: AGHT+IHIg3eQXnzqstg5Ug8zV2MJtM6sGNjpo2e8qDgxbUt3fe8hGVDmZVKMtxTTfX6N05Wvzig9Rg==
X-Received: by 2002:a05:6602:1607:b0:7eb:b36f:b4e2 with SMTP id
 ca18e2360f4ac-7f13ee475camr1119493939f.10.1718999529977; 
 Fri, 21 Jun 2024 12:52:09 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 00/43] labgrid: Provide an integration with Labgrid
Date: Fri, 21 Jun 2024 13:51:21 -0600
Message-Id: <20240621195204.2675252-1-sjg@chromium.org>
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

Changes in v2:
- Only disable echo if a terminal is detected
- Add new patch to update u-boot.cfg with CFG_... options
- Avoid running a docker image for skipped lab tests

Simon Glass (43):
  trace: Update test to tolerate different trace-cmd version
  binman: efi: Correct entry docs
  binman: Regenerate nxp docs
  binman: ti: Regenerate entry docs
  binman: Update the entrydocs header
  buildman: Make mrproper an argument to _reconfigure()
  buildman: Make mrproper an argument to _config_and_build()
  buildman: Make mrproper an argument to run_commit()
  buildman: Avoid rebuilding when --mrproper is used
  buildman: Add a flag to force mrproper on failure
  buildman: Retry the build for current source
  buildman: Add a way to limit the number of buildmans
  dm: core: Enhance comments on bind_drivers_pass()
  initcall: Correct use of relocation offset
  am33xx: Provide a function to set up the debug UART
  sunxi: Mark scp as optional
  google: Disable TPMv2 on most Chromebooks
  meson: Correct driver declaration for meson_axg_gpio
  test: Allow signaling that U-Boot is ready
  test: Make bootstd init run only on sandbox
  test: Use a constant for the test timeout
  test: Pass stderr to stdout
  test: Release board after tests complete
  log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
  test: Allow connecting to a running board
  test: Decode exceptions only with sandbox
  test: Avoid failing skipped tests
  test: dm: Show failing driver name
  test: Check help output
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
  Update u-boot.cfg to include CFG also
  CI: Allow running tests on sjg lab

 .gitlab-ci.yml                                | 153 +++++++++++++++++
 arch/arm/dts/sunxi-u-boot.dtsi                |   1 +
 arch/arm/mach-omap2/am33xx/board.c            |  18 +-
 configs/chromebook_link64_defconfig           |   1 +
 configs/chromebook_link_defconfig             |   1 +
 configs/chromebook_samus_defconfig            |   1 +
 configs/chromebook_samus_tpl_defconfig        |   1 +
 configs/nyan-big_defconfig                    |   4 +-
 configs/snow_defconfig                        |   1 +
 drivers/core/lists.c                          |  16 ++
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |   2 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c     |   4 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.h     |   2 +-
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |   4 +-
 lib/initcall.c                                |   6 +-
 scripts/Makefile.autoconf                     |   2 +-
 test/py/conftest.py                           |  86 ++++++++--
 test/py/tests/test_dm.py                      |   5 +-
 test/py/tests/test_help.py                    |   6 +-
 test/py/tests/test_log.py                     |  11 +-
 test/py/tests/test_trace.py                   |   6 +-
 test/py/tests/test_ut.py                      |   1 +
 test/py/u_boot_console_base.py                | 154 ++++++++++++------
 test/py/u_boot_console_exec_attach.py         |  31 +++-
 test/py/u_boot_console_sandbox.py             |   2 +-
 test/py/u_boot_spawn.py                       | 126 ++++++++++++--
 test/test-main.c                              |  16 +-
 tools/binman/entries.rst                      | 115 +++++++++----
 tools/binman/entry.py                         |   2 +-
 tools/binman/etype/efi_capsule.py             |  40 ++---
 tools/binman/etype/efi_empty_capsule.py       |  22 +--
 tools/binman/etype/ti_secure.py               |  45 ++---
 tools/buildman/builder.py                     |  18 +-
 tools/buildman/builderthread.py               |  44 +++--
 tools/buildman/buildman.rst                   |   8 +-
 tools/buildman/cmdline.py                     |   6 +-
 tools/buildman/control.py                     | 141 +++++++++++++++-
 tools/buildman/pyproject.toml                 |   6 +-
 tools/buildman/test.py                        | 121 ++++++++++++++
 tools/u_boot_pylib/terminal.py                |   7 +-
 40 files changed, 1009 insertions(+), 227 deletions(-)

-- 
2.34.1

