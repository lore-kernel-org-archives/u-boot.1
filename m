Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39957C83F38
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A96183426;
	Thu, 17 Jul 2025 18:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="debA6Vo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F40048343B; Thu, 17 Jul 2025 18:28:17 +0200 (CEST)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663DD833C0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5313a2566f9so983352e0c.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752769694; x=1753374494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0zTESkNJvLxMAHcA2ujHb2N2cPMZlQCfQ2ea0ijfsM=;
 b=debA6Vo/7bqacyddywDBzryj//6g3BBNu4kAezSD4XA9Rdi6Ukh2gONAY7Obp1P21Y
 NQkAHhOj3ToFTWQBQpHfO+/L898OiaFa5Jr8cphyv0LHmij6WzFRnskCi72qTi5LLtjd
 Z0zrSr9YCk76tUUbTOqVD3HGpo82QBHvvX2grDSw3SSkT9l5x8aq1LQDyPh3zY0hhBM7
 sC+922RqY8yrJLiJaE+0avwNfvG0WGtUOG2/OutmzQse/O1VgcJArwxMEuaPhd9iF8av
 nkohDdNLxh9d0Y5ZZN90dHAfTRtUbyTMHFPlkKhDpYdGHxkfA3Yi+VOwTjJz8trBYy/O
 k9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752769694; x=1753374494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y0zTESkNJvLxMAHcA2ujHb2N2cPMZlQCfQ2ea0ijfsM=;
 b=woMOC57id8/2uiSiMIAf8tFv0Z6tKhK35EthQBbwfk+U8f2GwB3EU4RiVd10EF0u3F
 1MPGYRAoLgBmrRHUK+BpBKZysUaI9NqgwLbeXSLkR3/uHcOfXR8z/zmg/GS58Tc0v5ut
 XbBEeQNHRp/XzHQF7VS5PMwlk9DYhCy5sEGt8dq0/KgSP7FL59s36m5h+x8whmLcLC7z
 mTUKpKCD/EyWGSx5OtN9XGq1XaaQmVq1oH6eQOgqePtiqcaaLPFEbICHw8z71rov+Fth
 ZX90hDE+2ZJZzVKWTrh1NB/GDlJ37CGZcE0F8uSldvGBLEaDHN82Imi0hfY0oQx9WZ3q
 ssmg==
X-Gm-Message-State: AOJu0YxB3I4aVmAndFq1Dsrn6bn6riAXsBpZEKtCU/cth4DsYI24V62T
 iE4d+Q9F54+vNannZEPieKE/dAj71W/R2+4eyly2+9vGE6qQE5pyB5bfw635+Q==
X-Gm-Gg: ASbGncvgyxla+aFepty/CXI6agvlerRztKQj0EGDPjGc+KmcucmOECMP79e/HVWGo3o
 ELZMM711PUnb7dlVE8DfTHTxR7Hg+fQKJ0K2ajqgkyzwqLWJkpasBWz8RLEQ5Rs1v1o20OMNDuk
 6KTgHORKz3uFOMa6OAmTMfwef5DFpdimK2F9oDqbMEjQqNsk9PBlUpoCrYd/UmEVBH47TD/+Sjw
 Sj7WLvOZtD6jGZ1ikFTf8ck2GmV3Nq1Xdo4YkNn6Y9ts/JF1rUTJOH8HPms5IFCtozAqENogIYv
 DeR59ypQB7ViawAA+LNuQeTvRYF5832flanQexPtQeyqAvNASQGQw09nn8jCIBSqhjN4yeyMyDX
 qZEi848DQFu+anZFgVuqntFhjUELlmccSeQ==
X-Google-Smtp-Source: AGHT+IEStq3tFQLSepEY85K665LtkuKrQtJWnTEeNwn9PRgdzkXsz/XFLfAuSbQbBdmn4W+29Quz3A==
X-Received: by 2002:a05:6122:4b17:b0:531:2906:7525 with SMTP id
 71dfb90a1353d-5373e307cf7mr4886094e0c.6.1752769693973; 
 Thu, 17 Jul 2025 09:28:13 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:53f5:3615:c860:88])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-535e721252asm4731084e0c.6.2025.07.17.09.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:28:13 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250717
Date: Thu, 17 Jul 2025 13:28:10 -0300
Message-Id: <20250717162810.2243435-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 3b4604a40b9fd61b87e9d059fc56f04d36f1a380:

  board: vexpress_ca9x4: Enable D-cache and MMU (2025-07-16 10:56:28 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250717

for you to fetch changes up to 6dc91a840810b7a35c78ac14e9868db462ae2039:

  venice: display DRAM MR registers and decoding if debug enabled (2025-07-17 09:58:42 -0300)

u-boot-imx-master-20250717
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27088

- Add support for the i.MX95 B0 version.
- Enable standard boot for phycore-imx8mp.
- Kconfig fixes for i.MX MMC and FSL_SEC_MON.
- Support 4Gb single die variant of the i.MX8MM Venice board.
----------------------------------------------------------------
Alice Guo (2):
      tools: imx8image: Add 2 new commands CMD_CNTR_VERSION and CMD_DUMMY_DDR
      imx95_evk: Add i.MX95 B0 support

David Zang (1):
      soc: imx8ulp: Add celsius unit for temperature

Holger Brunck (1):
      armv8: ls1043a: make some erratas dependent from USB

Leonard Anderweit (1):
      phycore-imx8mp: Enable standard boot

Tim Harvey (4):
      venice: lpddr4_timing_imx8mm: add DDRC_ADDRMAP7 config
      venice: lpddr4_timing_imx8mm: add 4gb single die support
      venice: lpddr4_timing_imx8mm: update ddr phy config for mscale_v3.10
      venice: display DRAM MR registers and decoding if debug enabled

Tom Rini (3):
      brppt2: Use the correct MMC driver
      arm: imx: Remove unused mxcmmc driver
      nxp: Move FSL_SEC_MON related options to arch/Kconfig.nxp

Ye Li (2):
      arm: imx: Update ELE get_info structure for i.MX94
      spl: imx: Add support for new PQC container

 arch/Kconfig.nxp                               |  22 ++
 arch/arm/cpu/armv8/fsl-layerscape/Kconfig      |   6 +-
 arch/arm/dts/imx95-u-boot.dtsi                 |   8 +-
 arch/arm/include/asm/arch-mx27/imx-regs.h      |   5 -
 arch/arm/include/asm/mach-imx/ele_api.h        |   2 +
 arch/arm/mach-imx/image-container.c            |   2 +-
 arch/arm/mach-imx/imx8ulp/soc.c                |   2 +-
 arch/arm/mach-imx/imx9/Kconfig                 |   1 +
 arch/arm/mach-imx/imx9/scmi/container.cfg      |   1 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg       |   5 +-
 board/gateworks/venice/eeprom.c                |   6 +-
 board/gateworks/venice/eeprom.h                |   5 +-
 board/gateworks/venice/lpddr4_timing.h         |   3 +-
 board/gateworks/venice/lpddr4_timing_imx8mm.c  | 195 +++------
 board/gateworks/venice/lpddr4_timing_imx8mn.c  |  14 +-
 board/gateworks/venice/lpddr4_timing_imx8mp.c  |  13 +-
 board/gateworks/venice/spl.c                   |  91 ++++-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env |  78 +---
 common/spl/Kconfig                             |   7 +
 configs/brppt2_defconfig                       |   2 +-
 configs/phycore-imx8mp_defconfig               |  17 +-
 doc/board/nxp/imx95_evk.rst                    |  12 +-
 drivers/misc/Kconfig                           |  22 --
 drivers/mmc/Kconfig                            |   9 -
 drivers/mmc/Makefile                           |   1 -
 drivers/mmc/mxcmmc.c                           | 523 -------------------------
 include/imx8image.h                            |   6 +
 include/imx_container.h                        |  11 +
 tools/imx8image.c                              |  57 ++-
 29 files changed, 296 insertions(+), 830 deletions(-)
 delete mode 100644 drivers/mmc/mxcmmc.c
