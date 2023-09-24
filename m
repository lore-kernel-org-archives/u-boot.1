Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5CCCE7A91
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 00:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4619886B0D;
	Mon, 25 Sep 2023 02:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UU6pprrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591F986A38; Sun, 24 Sep 2023 22:40:24 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065BA86A43
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35140cc9187so853925ab.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588018; x=1696192818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JRbLQkKNVodEaf+rEGPwgM3yWxwi0ZcnnEKENf0uc1Y=;
 b=UU6pprrDpXeqCJfAF3r92U1CxsfPOo/D77D5njvG6Aia3/18bpQWwKYqo7dWkzOI4d
 +XAuqMdis7BR2reABYStVBBgBcsFSeIyWhb6OIAHM5y86NEvl/tqZ/TpiJImO/6rImJq
 LUvKxRZdZyStmpV69OMvNgzBIAq59AvAkgadI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588018; x=1696192818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRbLQkKNVodEaf+rEGPwgM3yWxwi0ZcnnEKENf0uc1Y=;
 b=BsEgMZRlMcMDzqo6t8+uygVDw5gDjSxNS3j9wezi5EB2thHmdnsZAMTaWuaDUaDB9e
 W5ntvc3FKv6i+pCNc8GC3lvLW2cJhvFcZ+MOjYgFIVJ3619Tca8dBr662TvHW0V9Qhst
 VXrcZmyo4rqV90LSNIBbTtrygFPl1FSjBuoJEm+e3s2eAIDl1Yj39i/PUHcMcZRHC/eW
 5FRQOrBhtE7ecAa9d8P3vz6GYZ33u3x2kmi3lY14lQIzSfm6N8Zz5k1FZ3bYrFN1X7JW
 /uw1Gl62dwTFJ2hjb3gLrM1st6c5/kNiHRo6g6MOZro1xOBGRB5t6J3rvuiWTcA6ftcY
 gUNg==
X-Gm-Message-State: AOJu0YwnkTfDgz8lgWm4C6Iey7RB4Nbw/bVwO6EYWZ5v68omk2AS8GOJ
 i0bXo7sE7bKy2ak7jhXhha6skOj2xlgapACmaLw=
X-Google-Smtp-Source: AGHT+IGSWtDj8QdjL6Im7BYt1omjIV2qnUG5XmlkoabIW5US7/AAvHmrYqsmNuSEMdG6Fd6Im1SL/g==
X-Received: by 2002:a92:c5cb:0:b0:34d:f0b9:97fd with SMTP id
 s11-20020a92c5cb000000b0034df0b997fdmr5562840ilt.8.1695588018630; 
 Sun, 24 Sep 2023 13:40:18 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rick Chen <rick@andestech.com>, Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefano Babic <sbabic@denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, Tom Warren <twarren@nvidia.com>,
 Troy Kisky <troykiskyboundary@gmail.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/25] Tidy up use of CONFIG_CMDLINE
Date: Sun, 24 Sep 2023 14:39:18 -0600
Message-ID: <20230924203953.1829820-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 Sep 2023 02:53:48 +0200
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

It should be possible to disable CONFIG_CMDLINE and have all commands
and related functionality dropped from U-Boot. This is useful when
trying to reduce the size of U-Boot.

Recent changes have stopped this from working.

This series repairs the feature for sandbox and adds a test to stop it
breaking again.

Note that quite a lot of functionality is lost of CONFIG_CMDLINE is
disabled, e.g. networking and most booting options. Further work is
needed to make the option more generally useful.


Simon Glass (25):
  buildman: Use oldconfig when adjusting the config
  bootstd: Correct dependencies on CMDLINE
  autoboot: Correct dependencies on CMDLINE
  cmd: Add a few more dependencies on CMDLINE
  treewide: Correct use of long help
  test: Make UNIT_TEST depend on CMDLINE
  tegra: Change #ifdef for nop
  fastboot: Avoid depending on CMDLINE
  cli: Always build cli_getch
  cmd: Use an #ifdef around run_commandf()
  Move bootmenu_conv_key() into its own file
  armffa: Correct command help condition
  pxe: Depend on CMDLINE
  env: Split out non-command code into a new file
  console: Move SYS_PBSIZE into common/
  bootm: Allow building when cleanup functions are missing
  fdt: Move working_fdt into fdt_support
  net: Depend on CONFIG_CMDLINE
  log: Allow use without CONFIG_CMDLINE
  video: Allow use without CONFIG_CMDLINE
  video: Dont require the font command
  efi: Depend on CMDLINE for efi_loader
  cmd: Make all commands depend on CMDLINE
  sandbox: Avoid requiring cmdline
  sandbox: Add a test for disabling CONFIG_CMDLINE

 arch/Kconfig                               |   6 +-
 arch/arm/lib/bootm.c                       |   2 +
 arch/arm/mach-imx/cmd_dek.c                |   3 +-
 arch/arm/mach-imx/cmd_mfgprot.c            |   3 +-
 arch/arm/mach-imx/imx8/snvs_security_sc.c  |  10 ++
 arch/arm/mach-stm32mp/cmd_stm32key.c       |   2 +
 board/freescale/common/cmd_esbc_validate.c |   3 +-
 board/kontron/sl28/cmds.c                  |   2 +
 boot/Kconfig                               |  42 ++++---
 boot/bootm.c                               |  10 +-
 boot/fdt_support.c                         |   5 +
 cmd/Kconfig                                |  25 ++--
 cmd/Makefile                               |   2 +-
 cmd/adc.c                                  |   2 +
 cmd/arm/exception.c                        |   2 +
 cmd/arm/exception64.c                      |   2 +
 cmd/armffa.c                               |   2 +
 cmd/axi.c                                  |   2 +
 cmd/blob.c                                 |   2 +
 cmd/cyclic.c                               |   2 +
 cmd/fdt.c                                  |   5 -
 cmd/mux.c                                  |   2 +
 cmd/nvedit.c                               | 122 +------------------
 cmd/osd.c                                  |   2 +
 cmd/pcap.c                                 |   2 +
 cmd/riscv/exception.c                      |   2 +
 cmd/sandbox/exception.c                    |   2 +
 cmd/scp03.c                                |   2 +
 cmd/wdt.c                                  |   2 +
 cmd/x86/exception.c                        |   2 +
 common/Kconfig                             |   5 +
 common/Makefile                            |   3 +-
 common/cli.c                               |   2 +
 common/cli_getch.c                         |   1 +
 common/log.c                               |   4 +-
 common/menu.c                              |  40 -------
 common/menu_key.c                          |  49 ++++++++
 drivers/fastboot/fb_command.c              |   3 +-
 drivers/fastboot/fb_common.c               |  15 ++-
 drivers/video/Kconfig                      |   2 +-
 drivers/video/console_truetype.c           |   4 +
 env/Makefile                               |   1 +
 env/env_set.c                              | 132 +++++++++++++++++++++
 include/bootm.h                            |  15 ++-
 include/env_internal.h                     |  23 ++++
 include/k210/pll.h                         |   2 +-
 lib/efi_loader/Kconfig                     |   2 +
 net/Kconfig                                |   1 +
 test/Kconfig                               |   1 +
 test/py/tests/test_sandbox_opts.py         |  20 ++++
 tools/buildman/builder.py                  |   2 +-
 tools/buildman/builderthread.py            |   6 +
 tools/buildman/func_test.py                |   4 +-
 53 files changed, 388 insertions(+), 221 deletions(-)
 create mode 100644 common/menu_key.c
 create mode 100644 env/env_set.c
 create mode 100644 test/py/tests/test_sandbox_opts.py

-- 
2.42.0.515.g380fc7ccd1-goog

