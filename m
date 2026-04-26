Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69306FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE56284105;
	Sun, 26 Apr 2026 17:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NRTes1PR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F26F840ED; Sun, 26 Apr 2026 17:47:32 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA74C839D9
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so7389102f8f.3
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218449; x=1777823249;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ay5BWKMwp9o/rxZeYsRX2pfTyaEApr2HS5FZb4AfA/Y=;
 b=NRTes1PRSaNutw3evhvrOC7H+D0TixpJP9nGzvlW9Qsrjyixmx80zSh3wFrRHAcfSJ
 FNdlydqwOpQbZ1I94Nk10yhfmV0xlriLncvaV5OI25xnC6KPvm2hl4cKOysm5YZ4Rxqa
 2nCwYBVGFPimeaeaassN520N7P9SJgOPixVp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218449; x=1777823249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ay5BWKMwp9o/rxZeYsRX2pfTyaEApr2HS5FZb4AfA/Y=;
 b=bGNuL/pVn3VknoPTNjWh2Z9vJAheB73YiRo4M65xEszMlI+Dk+TOiycnMWQG8h/d7y
 nt9QTd3gD/Vs6k2FfoP9o3Oo7+EKeoRwRAcr2kNOexORfN8gx0k1BKHjYs5y0egNVIw3
 b0etAhuMxYp8pg714foUsdAAyY4e6xst90K63sYb95WkUxbnOvL6KUaUns9SeuwusYOV
 lRRRRDLtxYoVWzU7VsJJFQ2Dwg8BgybW1pXfFuQ8yksR0MbN5x4VY3dhUafKQMyu/nF8
 hkQEGQ8zWIyk04bBBcOwOTg1GKIrq4GLEd8bVCogN/X5dGzx0x0hqJ2W/eg8VgyZmAWK
 n89w==
X-Gm-Message-State: AOJu0YwADtueL+qDwzm6buzxFEGyJKf1pWiEUeJwjOpN3C5o4qqXBlkE
 nXc5sNtNywEP63oS09TrY02YIBPYPBj52GBA/JKnzUng1r8mTKo9cSxooP0L6V44CCqgxjFzcQJ
 Ea+tW
X-Gm-Gg: AeBDiesrctwXKohgnX/41ww809efA6x6Q/M48gzchmWN3bhp7GJcJraPD3bWrt/hC+E
 ilQsXK8fStgL4ZglhVHVtTYGt7TIUuBJqLo2Yo8Bto9ZkBY1C4nDmi4ncOqQuPhsYlIgogGPYjK
 4/d71FEjgJFPbpmcmOG5uJ1msqcX39wuMg+AW+uU6X1tTAusP1C9aLvN8a0B2nIISU4c0zYoYW4
 5gT76Wdlm2g4efKzjF3AVuhhiHF11ohUAifB17Xil3+p0B34sceFEMkgR5MgoPlpGBbu09f/qNP
 01Uz9MXb58RcXauSKMhP86XsnvreE2X0uTKXnyLqt/J32u4lXv7TbqfLH6H5/UT495+cvbdEBgH
 GKHoaSPMfRpRt6qrmlQN68LkVD1bu8NXsUH/nKu+uTRV3dxmfj4UIuvvYseVt3F2HAL4TbFEEg6
 BkQNkFC/03Z1G5wFja7X/qikZi2LuYo7CqgKMVIul382DKN5qkytHmcBhHZhu82zxo5FozEKppK
 a5fD6gQAzCZzoOpEjaVuXZ/XckXeV/CANIR0ynU/m+hkP8zbQKGnyxRnXSettg/o1AnOrv5CJl/
 q4QZP9+zUYjPWwr7DIETUTpMf7Rr8A==
X-Received: by 2002:a05:6000:25c4:b0:43b:8f56:1e1d with SMTP id
 ffacd0b85a97d-43fe3dc10demr61510778f8f.13.1777218448919; 
 Sun, 26 Apr 2026 08:47:28 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm34489985f8f.15.2026.04.26.08.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:47:28 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Bin Meng <bmeng.cn@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jonathan GUILLOT <jonathan@joggee.fr>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v7 0/8] Support metadata-driven A/B boot for STM32MP25
Date: Sun, 26 Apr 2026 17:46:53 +0200
Message-ID: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
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

This series, the mainline version of [1], provides the necessary changes
in U-Boot to support the metadata-driven A/B update flow for STM32MP25
boards. It implements the logic required to dynamically select the boot
bank based on FWU metadata.

These changes are designed to be backward compatible while providing
the necessary infrastructure for the A/B scheme.

The series has been tested on the STM32MP257F-EV1 board.

Additionally, some patches in the series propose changes with
general-purpose utility:

 1/7 lib: uuid: add partition type GUID for extended bootloader
 4/7 cmd: part: support lookup by UUID in 'part number'
 6/7 fwu: add helper to get image GUID by type and bank index

[1] https://github.com/STMicroelectronics/u-boot/pull/6

Changes in v7:
- Add Reviewed-by of Simon Glass for patc 7/8 of "test: dm:
  fwu_mdata: add test for fwu_mdata_get_image_guid".

Changes in v6:
- Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
  tests for part command"

Changes in v5:
- Update doc/usage/cmd/part.rst to reflect the changes related to the
  part command.
- Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
  image GUID by type and bank index"

Changes in v4:
- Place the part command tests in the cmd suite rather than the dm
  suite.
- Order the include files according the U-Boot coding style.
- Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid

Changes in v3:
- Wrap lines exceeding 80 columns in test/cmd/part.c file.
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
- Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
  in fwu.h.
- Add log_warning() messages to fwu_platform_hook() to catch inconsistent
  FWU metadata (boot GUID found but root GUID missing or viceversa), as
  suggested by Simon Glass.

Changes in v2:
- Add links to the XBOOTLDR specification in the commit message of patch
   1/7 lib: uuid: add partition type GUID for extended bootloader.
- Update help for 'part start', 'part size' to mention UUID.
- Add kerneldoc comment for fwu_mdata_get_image_guid().
- Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
- Add patches:
   5/7 test: cmd: part: add UUID lookup tests
   3/7 test: cmd: add unit tests for part command
   2/7 test: dm: part: add test for part_get_info_by_uuid

Dario Binacchi (8):
  lib: uuid: add partition type GUID for extended bootloader
  test: dm: part: add test for part_get_info_by_uuid
  test: cmd: add unit tests for part command
  cmd: part: support lookup by UUID
  test: cmd: part: add UUID lookup tests
  fwu: add helper to get image GUID by type and bank index
  test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
  board: st: stm32mp25: support dynamic A/B bank bootup

 board/st/stm32mp2/stm32mp2.c          |  32 ++++
 cmd/part.c                            |  12 +-
 doc/README.gpt                        |   2 +
 doc/usage/cmd/part.rst                |   6 +-
 include/configs/stm32mp25_st_common.h |  15 ++
 include/fwu.h                         |  11 ++
 include/part_efi.h                    |   3 +
 lib/fwu_updates/fwu.c                 |  33 ++++
 lib/uuid.c                            |   1 +
 test/cmd/Makefile                     |   1 +
 test/cmd/part.c                       | 209 ++++++++++++++++++++++++++
 test/dm/fwu_mdata.c                   |  48 ++++++
 test/dm/part.c                        |  53 +++++++
 13 files changed, 419 insertions(+), 7 deletions(-)
 create mode 100644 test/cmd/part.c

-- 
2.43.0

base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
branch: fwupdate-ab
