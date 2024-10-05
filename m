Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E439CFA756
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82FA5889C3;
	Sat,  5 Oct 2024 18:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CP6zy71I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31FA9889C5; Sat,  5 Oct 2024 18:44:46 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA6F889BD
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20b4a0940e3so29772025ad.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728146682; x=1728751482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bygjjYhZgVtuaJrx5VH3+I4AF6AurVUIyYYz8JbkCp4=;
 b=CP6zy71IW6oRBNa2NjpcvtmlqUR0T+yIlHRFUpO/AwK0NHZg2WvyYGdNq9dD//OwYi
 1+hVwhPUAVDNJJ2hFFA3jcN44eo1eY9HNfXuLA99M2JGoBbIPR8ZoE2xGujdT/S4aPHf
 6nwvjtog3AUVTRwjRq+d5yTna5fmOVvi6YRuUV7itR/ZoU1nNlWx7wGoGfDsvyvQjhza
 fprCZKcwV90aApZsKnAZ6zPmsfgHGwpc7TwCh6AEpSwz3Qx9Jqc+exd9QE2hH3aonIgB
 vF3EBc00gpiLT3VaBkCUo0Tzipj6nswsv59UldtbezgSEJBvoM1F76WaAOJn7Mbm7SXH
 JpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728146682; x=1728751482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bygjjYhZgVtuaJrx5VH3+I4AF6AurVUIyYYz8JbkCp4=;
 b=LqhaDvQOGBjn3WYgMdoPHIztByYk9d+4mk+hjsRYSpiK3w8pGU02QP57hd6eV4LFmC
 t9ZKZkqDr8rwNMQW+KGWBwzJPBE8mz5114k4Oil7eOUxH7Ok6Z+qaCDdDYSsHZVIwl2r
 o56pJpSgdy5uy80zWVv9DTbp9afYj6cT4IwxU3sGcEAYAaHbB6TKX6L8VR3x59jSks9e
 RiCQm5ltCsPIkVfldxLBaUuXRV4NB/m3ef/mffHGsxTMOor153v3LLWn3ubb/bfKfh5c
 7qAWozwkj8cMDgPYDHgcwO7xeTAN70LpAyfHJnUWl1ctmwIbQ7RzqDy1i0pgqu2bofz+
 pwDQ==
X-Gm-Message-State: AOJu0YyAran2cVtFZlf+W5awwEVkv3C4/z81ic6LIIgql1gJB5tXszDE
 20JxDs1ezVvkNhRa0rZJ8CZ3yVilsZaH009SlwiID8dyYYLHdTD2
X-Google-Smtp-Source: AGHT+IFRvgE8NSXV8QY+ayVEq+2lOlC7oIsiS3T8ys1FDRtxJ3S1tuhr6hYZZTKesoxq6SiH/7ZR3Q==
X-Received: by 2002:a17:903:1c1:b0:206:c12d:abad with SMTP id
 d9443c01a7336-20bfe04d596mr88257495ad.34.1728146682011; 
 Sat, 05 Oct 2024 09:44:42 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a990:ca6c:4a16:562b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13994f84sm15000185ad.290.2024.10.05.09.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 09:44:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20241005
Date: Sat,  5 Oct 2024 13:44:38 -0300
Message-Id: <20241005164438.2065748-1-festevam@gmail.com>
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

The following changes since commit 00292c6b39b3f7dcb34e8c3ae6ef276ac862a146:

  Merge tag 'u-boot-dfu-next-20241003' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next (2024-10-03 16:09:40 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20241005

for you to fetch changes up to ef815d75514da91dd98f9e3278d810439fd1f1ea:

  lxr2: Add DA9063 watchdog support (2024-10-04 09:55:26 -0300)

u-boot-imx-next-20241005
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22526

- Add DA9063 watchdog support for the imx6q-lxr2 board.
- Add support for DH electronics i.MX8M Plus DHCOM PicoITX
- Add DH i.MX8MP DHCOM SoM on DRC02 carrier board
- Several fsl_esdhc_imx improvements.
- Pas no-mmc-hs400 to mmc2 on imx8mm-cl-iot-gate.
----------------------------------------------------------------
Fabio Estevam (2):
      da9063: Add watchdog support
      lxr2: Add DA9063 watchdog support

Marek Vasut (3):
      arm64: dts: imx8mp: Add support for DH electronics i.MX8M Plus DHCOM PicoITX
      arm64: dts: imx8mp: Add DH i.MX8MP DHCOM SoM on DRC02 carrier board
      ARM: imx: Drop bogus newline

Peng Fan (2):
      mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk API
      mmc: fsl_esdhc_imx: Reset tuning logic

Vitor Soares (1):
      arm: imx: imx8m: soc: Fix VPU fdt disable fixup

Ye Li (4):
      gpio: adp5585: Add SPL config for ADP5585 driver
      mmc: fsl_esdhc_imx: Send 80 clocks before IDLE command
      mmc: fsl_esdhc_imx: Fix host_caps issue for non-DM driver
      mmc: fsl_esdhc_imx: Avoid resource leak

Ying-Chun Liu (PaulLiu) (1):
      arch: arm: dts: imx8mm-cl-iot-gate.dts: add no-mmc-hs400 to mmc2

 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/imx8mm-cl-iot-gate.dts           |   1 +
 arch/arm/dts/imx8mp-dhcom-drc02-u-boot.dtsi   |   6 +
 arch/arm/dts/imx8mp-dhcom-drc02.dts           | 230 +++++++++++++++++++++
 arch/arm/dts/imx8mp-dhcom-picoitx-u-boot.dtsi |   6 +
 arch/arm/dts/imx8mp-dhcom-picoitx.dts         | 152 ++++++++++++++
 arch/arm/mach-imx/cmd_mfgprot.c               |   2 +-
 arch/arm/mach-imx/imx8m/soc.c                 |   1 +
 configs/imx8mp_dhcom_drc02_defconfig          | 277 ++++++++++++++++++++++++++
 configs/imx8mp_dhcom_picoitx_defconfig        | 273 +++++++++++++++++++++++++
 configs/lxr2_defconfig                        |   3 +
 drivers/gpio/Kconfig                          |   6 +
 drivers/gpio/Makefile                         |   2 +-
 drivers/mmc/fsl_esdhc_imx.c                   |  44 +++-
 drivers/power/pmic/da9063.c                   |  12 +-
 drivers/watchdog/Kconfig                      |   6 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/da9063-wdt.c                 | 149 ++++++++++++++
 include/fsl_esdhc_imx.h                       |   1 +
 19 files changed, 1159 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-dhcom-drc02-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mp-dhcom-drc02.dts
 create mode 100644 arch/arm/dts/imx8mp-dhcom-picoitx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mp-dhcom-picoitx.dts
 create mode 100644 configs/imx8mp_dhcom_drc02_defconfig
 create mode 100644 configs/imx8mp_dhcom_picoitx_defconfig
 create mode 100644 drivers/watchdog/da9063-wdt.c
