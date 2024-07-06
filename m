Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ABDC2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9249B8813A;
	Sat,  6 Jul 2024 22:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JQpDSEfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5CD58813F; Sat,  6 Jul 2024 22:45:55 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A37387EDC
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c86869685aso494656a91.1
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298752; x=1720903552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rl6ighJtWS7P0ZsW2LlilC3T33mMzVPSHa7DnIYAuq4=;
 b=JQpDSEfR9Ye6fFqSUyMDmJpfeIkP+dBls9Ugr1vI2zeJwc9wgOaKxsr0cOOKp2y6w6
 SwpilxDwGcta5GmjPlMM+9QW84psWsqPwskcK1aGCY6VpMqkK8Md6uq9bs+/CYsjHRvQ
 0FeIV5yZcg7FlZFkOCGxOzsLQbjIAyJovat3M9XWsC4JbSUzkLzdLKJtf94G2K2rIDVm
 6b3NHVguPQxfElYb8XQsNad/Bn3M/mMqsbtgWvYhDuxmkJ8BSG7hqMSwbDfTuQCDSMiB
 WY50UTQEnVCOT63/Pcow79ehA4Krg2/LMWR1eX6k0UswVRoHG63SBMwyqyCE4m/wCs5R
 JFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298752; x=1720903552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rl6ighJtWS7P0ZsW2LlilC3T33mMzVPSHa7DnIYAuq4=;
 b=OYa9Wfe/+JFnVwpas/1Wx3/PvFM0cvUhooY5DDrH7Rk6bCI4g2mz/IW8zT0w4nUnLS
 eliBqFosSp40LB28cwG3K+dGnXJLPaHvafcsN3XGGSkJ53nm4s/O7E1TPXnxfbID2x5P
 z/ICqWekMCMdXhq0/XiO/Q/1SUHZJk5E0wRoM1qa4DroLzuDB678Ltbcumag+6KkHd92
 I1YsO+tahJ7qgWPtmc8Y6Q/BAIC2vHTXvDg+45w9fbrew9CVLv9pOGrUgPv9hdzCKOf7
 KD5S7ND5DAmZjZfU0MXueKJygpsTeYoTeqaQs03glEBnLICjrWvfjKEFG7ZCWBHDCBIa
 2V6w==
X-Gm-Message-State: AOJu0Yy3kPHPm8/jfUiLHKIRFgeRg4AfaiczWdMKsJUN2RYDUFZu6zUr
 Pz+aRWOmkOU0lkg9CgXrBIMItxYie2dITjF26szuJy6F8Booi7otb7nl/w==
X-Google-Smtp-Source: AGHT+IHOj6S4lGzMNvQ0OYDQ7hhUEUXzCwTTzPKSlx5EzehBTJK15CzCgSo+0OayJ0vusR+uHKSkwg==
X-Received: by 2002:a05:6a21:3384:b0:1bc:e9ce:d8bc with SMTP id
 adf61e73a8af0-1c0ccb3d96emr8913992637.6.1720298751502; 
 Sat, 06 Jul 2024 13:45:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a9f6:e08b:9827:22f9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6a8df09fsm12836581a12.34.2024.07.06.13.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 13:45:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240706
Date: Sat,  6 Jul 2024 17:45:47 -0300
Message-Id: <20240706204547.15708-1-festevam@gmail.com>
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

The following changes since commit fd46ea0e701920eb205c2bce9d527bf0dec10b59:

  Merge branch '2024-07-05-assorted-updates' (2024-07-05 16:36:43 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240706

for you to fetch changes up to 3d4c29258f8b4c4a5cf4ce79fb1ac80f66e4cf65:

  clk: imx: add mux ops for i.MX8M composite clk (2024-07-06 15:40:04 -0300)

u-boot-imx-master-20240706
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/21504

- Fixes for i.MX8M and i.MX93 clk-composite.
- Set CAN oscillator frequency based on model on verdin-imx8mm.
- Enable CAAM for phycore-imx8mp_defconfig.
- Miscellaneous improvements for Gateworks i.MX8M boards.
- Fix initramfs boot on msc_sm2s_imx8mp.
- Fixe EQoS on imx8mp-beacon-kit.
- Fix error message in fsl_esdhc_imx.
----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: imx8mp-beacon-kit-u-boot: Drop EQoS clock work-around

Alexander Stein (1):
      mmc: fsl_esdhc_imx: Fix error message

Fabio Estevam (1):
      msc_sm2s_imx8mp: Adjust the initrd_addr location

Leonard Anderweit (1):
      configs: phycore-imx8mp_defconfig: Initialize caam

Marek Vasut (4):
      ARM: imx: verdin-imx8mm: Set CAN oscillator frequency based on model
      ARM: imx: Enable cat and xxd commands on DH i.MX8M Plus DHCOM
      ARM: imx: Enable PCA953x driver on DH i.MX8MP DHCOM PDK2
      ARM: imx: Update Fast ethernet PHY MDIO addresses to match DH i.MX8MP DHCOM rev.200

Michael Trimarchi (4):
      clk: imx: Fix wrong flags assignment clk-composite-8m
      clk: imx: Fix wrong flags assignment clk-composite-93
      clk: clk-mux: Make public the clk_fetch_parent_index
      clk: imx: add mux ops for i.MX8M composite clk

 arch/arm/dts/Makefile                            |  1 +
 arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi       |  6 ----
 arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts |  5 +++
 arch/arm/dts/imx8mp-dhcom-som.dtsi               |  8 ++---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c      | 29 +++++++++++++++++
 configs/imx8mp_dhcom_pdk2_defconfig              |  3 ++
 configs/imx8mp_dhcom_pdk3_defconfig              |  2 ++
 configs/phycore-imx8mp_defconfig                 |  5 ++-
 drivers/clk/clk-mux.c                            |  5 ++-
 drivers/clk/imx/clk-composite-8m.c               | 41 +++++++++++++++++++++---
 drivers/clk/imx/clk-composite-93.c               |  2 --
 drivers/mmc/fsl_esdhc_imx.c                      |  4 +--
 include/configs/msc_sm2s_imx8mp.h                |  4 +--
 include/linux/clk-provider.h                     |  1 +
 14 files changed, 92 insertions(+), 24 deletions(-)
