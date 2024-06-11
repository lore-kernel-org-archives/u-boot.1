Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7516C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E71688708;
	Tue, 11 Jun 2024 22:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b0xG7qfp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C388A886DA; Tue, 11 Jun 2024 22:02:04 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30E968859A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-37597eba356so14067525ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136121; x=1718740921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s397MnDEzIM2f+WkCWDxc3WSNOk4Q2DB5KGZZ+JOfkc=;
 b=b0xG7qfp6WudDRmhTm9gNhBTb0Y+VbkzXXIQVF/vjPb2JkoYUvlXs3EXH/EPYsZjkM
 7Fme6+GwoJlJAaBh8R9jpdO+7KQXQZlGo96w4JNk0J6dcl8QLqqV1bFdgifNeFnFOpAk
 7DCqZplYpoSpQGOIODrzvqEpD5IyJBsHTulW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136121; x=1718740921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s397MnDEzIM2f+WkCWDxc3WSNOk4Q2DB5KGZZ+JOfkc=;
 b=ve0y0brOTSfrcYHYuL31QTcRzc/BYZ3u7mSgznKDIMXr52QIn2QnTSj6TmMYQP4dD9
 BabLiJ9nOcB3qG7yTKqfITfI87f4zkxSGDjcbuO5ydyoTyxvRNL2lSQaUBf6xN7+h0bH
 hWPthp+38gIrGW9HKUFXi/1Q3z7zjbq3F7NzcE8BA4WZcpThtoj9NVGYCyMA3HbT2tPT
 Bal4wZ0QItfDbHJgRa7kgYw8MZcclGrD3ONc5dkFLQRQKxrv8I1gUFNiooqiu3i+APmy
 C2UVVMXD+chQMryF5hsgk2996octbCXM1cSMze/9nRSnR7ISrMi74jamhFUt4EfIGXUc
 2YbA==
X-Gm-Message-State: AOJu0Yyic4Csj7QUnmtM3yX932uVoE1SDnXgoUSkMHR9JsI5be9BvzQs
 LQ1KX61P+mmT8rZnoH1UCK8004IB6hAnpHL9+qUr/6WHVXW+CJiNDRitzvZUg6rUqM6124htURO
 9m1F/
X-Google-Smtp-Source: AGHT+IELJe2U4VS/SCDovtNFhycOWtfnokBOCCp8hWBInvyVwts7nXs1Bk96pvjqBvu41u9wEGNDGQ==
X-Received: by 2002:a05:6e02:1a84:b0:375:a50d:7f45 with SMTP id
 e9e14a558f8ab-375a50d82b5mr79572235ab.1.1718136120638; 
 Tue, 11 Jun 2024 13:02:00 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Allen Martin <amartin@nvidia.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Andrew Davis <afd@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot-amlogic@groups.io
Subject: [PATCH 00/42] labgrid: Provide an integration with Labgrid
Date: Tue, 11 Jun 2024 14:01:14 -0600
Message-Id: <20240611200156.2245525-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Jun 2024 22:08:37 +0200
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


Simon Glass (42):
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
  CI: Allow running tests on sjg lab

 .gitlab-ci.yml                                | 151 +++++++++++++++++
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
 test/py/conftest.py                           |  86 ++++++++--
 test/py/tests/test_dm.py                      |   5 +-
 test/py/tests/test_help.py                    |   6 +-
 test/py/tests/test_log.py                     |  11 +-
 test/py/tests/test_trace.py                   |   6 +-
 test/py/tests/test_ut.py                      |   1 +
 test/py/u_boot_console_base.py                | 154 ++++++++++++------
 test/py/u_boot_console_exec_attach.py         |  31 +++-
 test/py/u_boot_console_sandbox.py             |   2 +-
 test/py/u_boot_spawn.py                       | 123 ++++++++++++--
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
 39 files changed, 1003 insertions(+), 226 deletions(-)

-- 
2.34.1

