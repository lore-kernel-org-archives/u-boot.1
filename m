Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870EDC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E54D871AB;
	Sun, 12 Nov 2023 01:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O74tRj55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0227D86F93; Sun, 12 Nov 2023 01:09:34 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC9E686F42
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a67f447bf0so125763839f.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747769; x=1700352569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zOZGm1DB+FSqqEEZWw12TzyzShs1slwAa9PWYXUZ83w=;
 b=O74tRj55aW6e7LOxpcBO2lvFuUETEwoix4aoH038KOdaHs1m864Mt1uXmoFSPc1IN7
 Jqq+aS3myNbPvzAPtGy+0nolLLRBeZFTdWLRuLQULflN6UFQTOoxP+yEoCK5WukMfw4Z
 5UPHbqCA33llRLDmVprhowcKgLfvsPSQral78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747769; x=1700352569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOZGm1DB+FSqqEEZWw12TzyzShs1slwAa9PWYXUZ83w=;
 b=Qc61Yog0xj12Sl+SJP3YNcGU5jfPuc9wh05wjCkE6C2V8mRyQwVOwnIFzXswzTZcTk
 sX4+ng8FwnRFfIcjEBJsezRYPoEelUn39h0dXqVpG59KelfLYyEm7XIxH/Ab7W7JhfM8
 iFEWds9i6l0k2K+pWjt+m8pVT1aat272kUlz4pIQ5l6xjRXu0TMiEM+swGC9uo6Eglh9
 93c9nf21w5R4x0OplG3gSZsVyM3q7JLilWQvAqoQxQr+9sdu/ov58pHEGx6G5cX50T+x
 AbuFL0Lcx0fev6sTra5itHloXCRQij3UKspuiPcBvCVKX+C1EUyGyszSiPc8yVXktz/+
 3Cbw==
X-Gm-Message-State: AOJu0YzlgjoYYK4Fm4XqqvqBsSfWtoEbCMuY3Ai6W/2heZuQshZvXOrQ
 7ZoQrCVX8hl+th6MRCzJixm+x1vpHRacykGA93wAYA==
X-Google-Smtp-Source: AGHT+IHgpvB2JmMn/QlhhT6LQxMxP7GoiTrv+rjW8vRtwpnHlZ+dZFSa6yvDa9pBoa2hiRPqJFzuKg==
X-Received: by 2002:a05:6e02:1a22:b0:359:9efa:3afc with SMTP id
 g2-20020a056e021a2200b003599efa3afcmr4566531ile.7.1699747769140; 
 Sat, 11 Nov 2023 16:09:29 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Fabio Estevam <festevam@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Qu Wenruo <wqu@suse.com>, Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefano Babic <sbabic@denx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 00/29] bootm: Refactoring to reduce reliance on CMDLINE (part
 A)
Date: Sat, 11 Nov 2023 17:08:45 -0700
Message-ID: <20231112000923.73568-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

It would be useful to be able to boot an OS when CONFIG_CMDLINE is
disabled. This could allow reduced code size.

Standard boot provides a way to handle programmatic boot, without
scripts, so such a feature is possible. The main impediment is the
inability to use the booting features of U-Boot without a command line.
So the solution is to avoid passing command arguments and the like to
code in boot/

A similar process has taken place with filesystems, for example, where
we have (somewhat) separate Kconfig options for the filesystem commands
and the filesystems themselves.

This series starts the process of refactoring the bootm logic so that
it can be called from standard boot without using the command line.
Mostly it removes the use of argc, argv and cmdtbl from the internal
logic.

Some limited tidy-up is included, but this is kept to smaller patches,
rather than trying to remove all #ifdefs etc. Some function comments
are added, however.

A simple programmatic boot is provided as a starting point.

This work will likely take many series, so this is just the start.

Size growth with this series for firefly-rk3288 (Thumb2) is:

       arm: (for 1/1 boards) all +23.0 rodata -49.0 text +72.0

This should be removed by:

   https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/11

but it is not included in this series as it is already large enough.

No functional change is intended in this series.


Simon Glass (29):
  arm: x86: Drop discarding of command linker-lists
  mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
  treewide: Tidy up semicolon after command macros
  bootstd: Add missing header file from bootdev.h
  bootstd: Introduce programmable boot
  bootm: Drop arguments from bootm_start()
  bootm: Simplify arguments for bootm_pre_load()
  bootm: Move boot_get_kernel() higher in the file
  image: Tidy up genimg_get_kernel_addr_fit()
  bootm: Reduce arguments to boot_get_kernel()
  image: Document error codes from fit_image_load()
  bootm: Adjust boot_get_kernel() to return an error
  bootm: Use the error return from boot_get_kernel()
  bootstage: Drop BOOTSTAGE_ID_FIT_KERNEL_INFO
  bootm: Move error printing out of boot_get_kernel()
  bootm: Reduce arguments to boot_find_os()
  bootm: Reduce arguments to boot_get_ramdisk()
  fdt: Allow use of fdt_support inside if() statements
  bootm: Drop #ifdef in bootm_find_images()
  bootm: Pass image buffer to boot_get_fdt()
  bootm: Reduce arguments to boot_get_fdt()
  bootm: Reduce arguments to boot_get_fpga()
  bootm: Reduce arguments to boot_get_loadables()
  bootm: Simplify Android ramdisk addr in bootm_find_images()
  bootm: efi: Drop special call to bootm_find_other()
  bootm: optee: Drop special call to bootm_find_other()
  bootm: Adjust the parameters of bootm_find_images()
  bootm: Add a function to check overlap
  bootm: Reduce arguments to bootm_find_other()

 arch/arm/cpu/u-boot.lds      |   3 -
 arch/x86/cpu/u-boot-64.lds   |   4 -
 arch/x86/cpu/u-boot-spl.lds  |   4 -
 arch/x86/cpu/u-boot.lds      |   4 -
 board/freescale/common/vid.c |   2 +-
 board/xilinx/common/fru.c    |   2 +-
 board/xilinx/versal/cmds.c   |   2 +-
 board/xilinx/zynqmp/cmds.c   |   2 +-
 boot/Kconfig                 |  11 +
 boot/Makefile                |   2 +
 boot/bootm.c                 | 576 +++++++++++++++++++----------------
 boot/bootm_os.c              |  16 -
 boot/image-board.c           |  67 +---
 boot/image-fdt.c             |  39 +--
 boot/prog_boot.c             |  51 ++++
 cmd/booti.c                  |   4 +-
 cmd/bootz.c                  |   4 +-
 cmd/btrfs.c                  |   2 +-
 cmd/eeprom.c                 |   2 +-
 cmd/ext2.c                   |   4 +-
 cmd/fs.c                     |   8 +-
 cmd/pinmux.c                 |   2 +-
 cmd/qfw.c                    |   2 +-
 common/main.c                |   9 +
 env/mmc.c                    |   2 +-
 include/bootdev.h            |   1 +
 include/bootm.h              |  26 +-
 include/bootstage.h          |   1 -
 include/bootstd.h            |   9 +
 include/command.h            |   2 +-
 include/fdt_support.h        |   5 +-
 include/image.h              | 127 ++++++--
 32 files changed, 550 insertions(+), 445 deletions(-)
 create mode 100644 boot/prog_boot.c

-- 
2.42.0.869.gea05f2083d-goog

