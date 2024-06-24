Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A21C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE83988381;
	Mon, 24 Jun 2024 15:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eo/ie8Y/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7415A8839C; Mon, 24 Jun 2024 15:36:02 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB4B4882BE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fa42ad2701so735205ad.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719236158; x=1719840958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PN3b/Hfr72XOvICSFhPHrEAogt85FIIc3rI2QIapeZ4=;
 b=eo/ie8Y/rbGxT5k9Aew/t/dUzD7l+fa/JRWcd+NCkHcjaqlt9RG9v66HXXMpfkQzvy
 n8NBG3Ku2cH++dAiKl3u9yw1FruSx+A5XIJw5uB2HOFSHHZCj/srk5pzMTk6Q2q5Qity
 XmizPxDdlBmxlCSkuQaltZHBg39o410fFLlUAjGQLsAnrs3LvBVX4JyxBGx4bjYeLzcJ
 JUUTcC+2jkBMDf3sVFExKLMrYpPjebA/5D55qFZwpSUGUfY7D7UQnig4a/I26s1hUd8v
 s7JRY2SXxZriN/ecb/4lz4I3og0NiU3lIGGoxVRra9Cml2/Dp0msdM8IPyDQFDnWoU5G
 JAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236158; x=1719840958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PN3b/Hfr72XOvICSFhPHrEAogt85FIIc3rI2QIapeZ4=;
 b=FM9QXOrevUvSGWnjpHtTdJ730df2hY39Avy0WsF9fBxKAZp9NMP+0og1w8MEc+v+Uw
 hK57zANkSD/8BXt4gbdcu2OZR7uFPOAXS62ujcY3Ixk5ioS4QEW+H0l7ztBg1FllaOAi
 ePcTzfs6/gxvg38gyQdFLAGRe2bBztyrgVKV4GEWdOR1pjEwTs54qnWwBeLsMO2qg/EF
 0WZ3XIV+aQmsVp52wtwuLzEcH3CV7AGYFnLH7OAS/oEOQZQjU6Dvhm+JEg4xHx1Ycc/Y
 ewOhUAw53IxIMy1/kOHnGnZvulm7w2xSpZPUKR1K2RJNL/y+6v67A+/bihr7lz3kFRsu
 ULEw==
X-Gm-Message-State: AOJu0YzIACYgfX+RQxSALSHfA0P7ehe8aTDmu00QwEsxrWPdLAZoXf3U
 r9djm2us09vKIMrfzM5Fc6TfdC0AC+3W7FYrqtDiG49aBk/Xo/Xs3ghzHg==
X-Google-Smtp-Source: AGHT+IHxZikOSQSu9PHvu5cFKALDv4p/VwzLCaZKWHpBDZUJ+aa20GPknnlwFoDNghENnTaGzzLd6w==
X-Received: by 2002:a17:902:e541:b0:1f9:bde7:ee1b with SMTP id
 d9443c01a7336-1fa0d82164fmr67529385ad.5.1719236158055; 
 Mon, 24 Jun 2024 06:35:58 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8646:5399:6c64:98bd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb2f094dsm62884215ad.55.2024.06.24.06.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 06:35:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240624
Date: Mon, 24 Jun 2024 10:35:53 -0300
Message-Id: <20240624133553.104708-1-festevam@gmail.com>
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

Please pull from u-boot-imx/next, thanks.

The following changes since commit 81e2b69880566a90e909a7e2c02dff0c39a8c1e5:

  Merge patch series "boot: fix crash in bootflow menu with EFI BOOTMGR support + typos" (2024-06-20 11:41:43 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240624

for you to fetch changes up to b7f677dc40429a8172c7ba5edcf3b426097e2881:

  ARM: imx: Enable SPL DTO application support for i.MX8MP DHCOM PDK2 (2024-06-24 09:24:16 -0300)

u-boot-imx-next-20240624
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/21310

- Enable SPL DTO application support for i.MX8MP DHCOM PDK2.
- Migrate imx8mn_bsh_smm_s2 and imx6ulz_bsh_smm_m2 to OF_UPSTREAM.
- Drop redundant imports with dts/upstream.
- Miscellaneous improvements for Gateworks i.MX8M boards.
----------------------------------------------------------------
Marek Vasut (1):
      ARM: imx: Enable SPL DTO application support for i.MX8MP DHCOM PDK2

Patrick Barsanti (2):
      arm: fsl: imx8mn_bsh_smm_s2: Migrate to OF_UPSTREAM
      arm: fsl: imx6ulz_bsh_smm_m2: Migrate to OF_UPSTREAM

Sumit Garg (1):
      dt-bindings: imx: Drop redundant imports with dts/upstream

Tim Harvey (7):
      board: gateworks: venice: enable GSC supervisor for new board models
      board: gateworks: venice: delay before reading GSC EEPROM
      board: gateworks: venice: add print for GPY111 PHY name
      imx8m{m,p}_venice: add NVMe to boot devices
      imx8mp-venice-gw74xx: default USB1 to host mode
      imx8mp-venice-gw702x: Drop EQos clock workaround
      board: gateworks: venice: Simplify Ethernet initialization

 arch/arm/dts/Makefile                         |   3 -
 arch/arm/dts/imx6ulz-bsh-smm-m2.dts           | 146 ------
 arch/arm/dts/imx8mn-bsh-smm-s2-common.dtsi    | 426 -----------------
 arch/arm/dts/imx8mn-bsh-smm-s2.dts            |  48 --
 arch/arm/dts/imx8mn-bsh-smm-s2pro.dts         | 170 -------
 arch/arm/dts/imx8mp-venice-gw702x-u-boot.dtsi |   6 -
 arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi |   5 +
 arch/arm/mach-imx/imx8m/Kconfig               |   2 +
 arch/arm/mach-imx/mx6/Kconfig                 |   1 +
 board/gateworks/venice/spl.c                  |  21 +-
 board/gateworks/venice/venice.c               |  22 +-
 configs/imx6ulz_smm_m2_defconfig              |   2 +-
 configs/imx8mn_bsh_smm_s2_defconfig           |   2 +-
 configs/imx8mn_bsh_smm_s2pro_defconfig        |   2 +-
 configs/imx8mp_dhcom_pdk2_defconfig           |   3 +-
 include/configs/imx8mm_venice.h               |   1 +
 include/configs/imx8mp_venice.h               |   1 +
 include/dt-bindings/clock/imx5-clock.h        | 219 ---------
 include/dt-bindings/clock/imx6qdl-clock.h     | 278 -----------
 include/dt-bindings/clock/imx6sl-clock.h      | 178 --------
 include/dt-bindings/clock/imx6sll-clock.h     | 210 ---------
 include/dt-bindings/clock/imx6sx-clock.h      | 281 ------------
 include/dt-bindings/clock/imx6ul-clock.h      | 262 -----------
 include/dt-bindings/clock/imx7d-clock.h       | 456 -------------------
 include/dt-bindings/clock/imx7ulp-clock.h     | 119 -----
 include/dt-bindings/clock/imx8mm-clock.h      | 286 ------------
 include/dt-bindings/clock/imx8mn-clock.h      | 262 -----------
 include/dt-bindings/clock/imx8mp-clock.h      | 401 ----------------
 include/dt-bindings/clock/imx8mq-clock.h      | 431 ------------------
 include/dt-bindings/clock/imx8ulp-clock.h     | 258 -----------
 include/dt-bindings/clock/imx93-clock.h       | 209 ---------
 include/dt-bindings/clock/imxrt1050-clock.h   |  72 ---
 include/dt-bindings/interconnect/fsl,imx8mp.h |  59 ---
 include/dt-bindings/interconnect/imx8mm.h     |  50 --
 include/dt-bindings/interconnect/imx8mn.h     |  41 --
 include/dt-bindings/interconnect/imx8mq.h     |  48 --
 include/dt-bindings/phy/phy-imx8-pcie.h       |  14 -
 include/dt-bindings/pinctrl/pins-imx8mq.h     | 632 --------------------------
 include/dt-bindings/power/fsl,imx93-power.h   |  15 -
 include/dt-bindings/power/imx7-power.h        |  13 -
 include/dt-bindings/power/imx8mm-power.h      |  31 --
 include/dt-bindings/power/imx8mn-power.h      |  20 -
 include/dt-bindings/power/imx8mp-power.h      |  59 ---
 include/dt-bindings/power/imx8mq-power.h      |  24 -
 include/dt-bindings/power/imx8ulp-power.h     |  26 --
 include/dt-bindings/reset/imx7-reset.h        |  52 ---
 include/dt-bindings/reset/imx8mp-reset.h      |  50 --
 include/dt-bindings/reset/imx8mq-reset.h      |  67 ---
 include/dt-bindings/reset/imx8ulp-pcc-reset.h |  59 ---
 include/dt-bindings/sound/fsl-imx-audmux.h    |  64 ---
 50 files changed, 37 insertions(+), 6070 deletions(-)
 delete mode 100644 arch/arm/dts/imx6ulz-bsh-smm-m2.dts
 delete mode 100644 arch/arm/dts/imx8mn-bsh-smm-s2-common.dtsi
 delete mode 100644 arch/arm/dts/imx8mn-bsh-smm-s2.dts
 delete mode 100644 arch/arm/dts/imx8mn-bsh-smm-s2pro.dts
 delete mode 100644 include/dt-bindings/clock/imx5-clock.h
 delete mode 100644 include/dt-bindings/clock/imx6qdl-clock.h
 delete mode 100644 include/dt-bindings/clock/imx6sl-clock.h
 delete mode 100644 include/dt-bindings/clock/imx6sll-clock.h
 delete mode 100644 include/dt-bindings/clock/imx6sx-clock.h
 delete mode 100644 include/dt-bindings/clock/imx6ul-clock.h
 delete mode 100644 include/dt-bindings/clock/imx7d-clock.h
 delete mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
 delete mode 100644 include/dt-bindings/clock/imx8mm-clock.h
 delete mode 100644 include/dt-bindings/clock/imx8mn-clock.h
 delete mode 100644 include/dt-bindings/clock/imx8mp-clock.h
 delete mode 100644 include/dt-bindings/clock/imx8mq-clock.h
 delete mode 100644 include/dt-bindings/clock/imx8ulp-clock.h
 delete mode 100644 include/dt-bindings/clock/imx93-clock.h
 delete mode 100644 include/dt-bindings/clock/imxrt1050-clock.h
 delete mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h
 delete mode 100644 include/dt-bindings/interconnect/imx8mm.h
 delete mode 100644 include/dt-bindings/interconnect/imx8mn.h
 delete mode 100644 include/dt-bindings/interconnect/imx8mq.h
 delete mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h
 delete mode 100644 include/dt-bindings/pinctrl/pins-imx8mq.h
 delete mode 100644 include/dt-bindings/power/fsl,imx93-power.h
 delete mode 100644 include/dt-bindings/power/imx7-power.h
 delete mode 100644 include/dt-bindings/power/imx8mm-power.h
 delete mode 100644 include/dt-bindings/power/imx8mn-power.h
 delete mode 100644 include/dt-bindings/power/imx8mp-power.h
 delete mode 100755 include/dt-bindings/power/imx8mq-power.h
 delete mode 100644 include/dt-bindings/power/imx8ulp-power.h
 delete mode 100644 include/dt-bindings/reset/imx7-reset.h
 delete mode 100644 include/dt-bindings/reset/imx8mp-reset.h
 delete mode 100755 include/dt-bindings/reset/imx8mq-reset.h
 delete mode 100644 include/dt-bindings/reset/imx8ulp-pcc-reset.h
 delete mode 100644 include/dt-bindings/sound/fsl-imx-audmux.h
