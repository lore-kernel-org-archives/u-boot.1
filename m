Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE32C54E49
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EF487CB1;
	Sat, 24 Feb 2024 23:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KTVKQ6Tq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC4987C66; Sat, 24 Feb 2024 23:21:26 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 615C087CB1
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dbd81000b6so6743605ad.0
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 14:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708813281; x=1709418081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AJ/0NDQa8+q3Wj/OX2fmMTVVJ65GPzVeyIjJYbpyKFY=;
 b=KTVKQ6TqZIdG7HuMeUfMBCNv3skZAzXZh0ewwEPU4lkO7gwpN2w1dDxJ5octDfABgW
 k+Bt54c2qYc61TRFCHlMkTzYzIAbSUYED75g4gk3k+300P+I2ec6wuTi1a9BOeVCjz/i
 IpKake+O+5wWGJFs3w7PkXkw2Ke3ODxSADx99tefRMWqKsacMYw+SwRM4zjrscPzF/57
 xlnKB+XTfVon6T9ayTmeL/TWv0epPo2NyeoKSlU63sNsF44ztcjEjffmJK+nSxmjceN3
 LKzi4dq/LzTKeZC4GOVk1neXROT5N8g/2Cd1nDVtE8lvSQc/Uozu+ijBrsunE7SbO0rK
 R89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708813281; x=1709418081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJ/0NDQa8+q3Wj/OX2fmMTVVJ65GPzVeyIjJYbpyKFY=;
 b=gPRlNXU06eO/yD3PVqzjvGJB6l6gYWNszlRj4H0kAfo3/DFhD949Gg2mNeGK3FQ+8O
 xcNGG+N9LPoDQJ98MT7BZBpSl0PpnZLvcbWuDxLPboxEtOxQbzhMKcPUdGNNM4bfzqSw
 NX6Nu9IKlKWcutU4yXmSmh+B6g151ubfDkQXAFcKmd4Wdm4MESShnaiTenskYCSl0li1
 ewmAuB+YcByY0eJq0beeHuQjKwZ1evSpqf+IBzVHpt2dZP7gmB/q8icA9Fe8QONtHyHz
 do7dBbafmtMjHD2uZ9SdcV5lErg9EnxfpKO+5eGVmcBgmWFCZIQ2Xp3KVcxPpn+bty+f
 5H6g==
X-Gm-Message-State: AOJu0YzP9J8Du4uWpx6cjOKPA4CbcE7sv/lkHTDoivkG/M74mgNg6zWs
 utQZ8p8D+I+RgvQ0h1Y79lzIEVr3Pyzpqq+K+N5WpRkS8JJz9coYsST1XNGK
X-Google-Smtp-Source: AGHT+IFOtdzXj/Z5UK2TmR14CeyB83TXAOz/dsawkVEzuxUNdAl9bNOku4tXBUqFc+echoIMz0gX1A==
X-Received: by 2002:a17:902:fe0c:b0:1db:ce31:96b1 with SMTP id
 g12-20020a170902fe0c00b001dbce3196b1mr3940749plj.6.1708813281611; 
 Sat, 24 Feb 2024 14:21:21 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b6f1:4f9f:6ec0:4244])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a17090322d100b001db9493104fsm1424017plg.79.2024.02.24.14.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 14:21:21 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240224
Date: Sat, 24 Feb 2024 19:21:17 -0300
Message-Id: <20240224222117.1504690-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Please pull from u-boot-imx, thanks.

The following changes since commit bb9d6c7f4f6a598e8856b2e19e58c7de078a0d6e:

  Merge tag 'u-boot-amlogic-fixes-20240223' of https://source.denx.de/u-boot/custodians/u-boot-amlogic (2024-02-23 12:54:03 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240224

for you to fetch changes up to 7c76b1b91bf67cd09fdf5dbd71590f9e580590fa:

  opos6uldev: Convert to watchdog driver model (2024-02-24 16:29:24 -0300)

u-boot-imx-master-20240224
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19725

- Enable the thermal driver for the imx8m phycore boards.
- Convert imx53-qsb to watchdog driver to fix the 'reset' command.
- Remove multiline string from imx6dl-sielaff.
- Add SPI boot support for imxrt1050-evk.
- Convert opos6uldev to watchdog driver to fix the 'reset' command.
----------------------------------------------------------------
Benjamin Hahn (3):
      phycore-imx8mp_defconfig: Enable CONFIG_IMX_TMU
      phycore-imx8mm_defconfig: Enable CONFIG_IMX_TMU
      imx8mm-phygate-tauri-l_defconfig: Enable CONFIG_IMX_TMU

Fabio Estevam (1):
      imx53-qsb: Convert to watchdog driver model

Frieder Schrempf (1):
      board: imx6dl-sielaff: spl.c: Remove multiline string

Jesse Taube (2):
      imx: imxrt1050-evk: Add support for SPI flash booting
      imx: imxrt1050-evk: Add documentation for SPI boot

Mathieu Othacehe (4):
      arm: dts: imx93: Add USB support.
      arm: dts: imx93-var-som-symphony: Add USB support.
      configs: imx93_var_som: Add USB support.
      configs: imx93_var_som: Add fastboot support.

Sébastien Szymanski (1):
      opos6uldev: Convert to watchdog driver model

 arch/arm/dts/imx53-qsb-u-boot.dtsi             |  13 ++++
 arch/arm/dts/imx6ul-opos6ul-u-boot.dtsi        |  10 +++
 arch/arm/dts/imx93-var-som-symphony.dts        |  18 +++++
 arch/arm/dts/imx93.dtsi                        |  58 ++++++++++++++
 arch/arm/dts/imxrt1020-evk-u-boot.dtsi         |   4 +
 arch/arm/dts/imxrt1050-evk-u-boot.dtsi         |  31 ++++++++
 arch/arm/dts/imxrt1170-evk-u-boot.dtsi         |   4 +
 arch/arm/mach-imx/imxrt/Kconfig                |   1 +
 board/freescale/imxrt1050-evk/MAINTAINERS      |   1 +
 board/freescale/imxrt1050-evk/imximage-nor.cfg |  41 ++++++++++
 board/freescale/imxrt1050-evk/imximage.cfg     |  10 ++-
 board/freescale/imxrt1050-evk/imxrt1050-evk.c  |   7 +-
 board/sielaff/imx6dl-sielaff/spl.c             |   4 +-
 configs/imx8mm-phygate-tauri-l_defconfig       |   1 +
 configs/imx93_var_som_defconfig                |  15 ++++
 configs/imxrt1050-evk_defconfig                |   8 +-
 configs/imxrt1050-evk_fspi_defconfig           | 100 +++++++++++++++++++++++++
 configs/mx53loco_defconfig                     |   3 +
 configs/opos6uldev_defconfig                   |   3 +
 configs/phycore-imx8mm_defconfig               |   1 +
 configs/phycore-imx8mp_defconfig               |   1 +
 doc/board/nxp/imxrt1050-evk.rst                |  30 ++++++++
 include/configs/imxrt1050-evk.h                |   6 ++
 23 files changed, 362 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/imx53-qsb-u-boot.dtsi
 create mode 100644 board/freescale/imxrt1050-evk/imximage-nor.cfg
 create mode 100644 configs/imxrt1050-evk_fspi_defconfig
