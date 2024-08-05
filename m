Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2017C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 21:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4818895B;
	Mon,  5 Aug 2024 23:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8U97qCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5A488955; Mon,  5 Aug 2024 23:25:25 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E1E8867B
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 23:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso68791875e9.2
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722893123; x=1723497923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77iYSLeL0R+OxfGqh93qmEQlj5zyjP28IAC8Bfg6d9Y=;
 b=m8U97qCQMmyXJpvNNLGcoHlWXVWpBg4p/mwvIRRYCS1TvmUW0DMlFpVn5PdXnFAlXn
 c+4k+nNXheXImkorhWXcpEkB4PxWTWdZj+73S1Qe2M9atMHHNxIM2wgBGxZtlRLC/1nF
 SY4UN4FJuDTLig2kKcYIWw2h/zDWgyJQWzxxXqo7dj1SSxwmKzmAOvhjTLE1VHVSnZ4V
 OJzcPicPBtmXMxwUZOzfI5y6bQLVE0KpW1CZpxBJF4SN6IAwKlc+96HAXLHI0k9ldXNL
 AcuzSm+XvKO2jNpDNA0fArkhsNkwP1Q6TReHIR//gL/bG87vDDbXGH8DhkMULwtEyzUa
 UNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722893123; x=1723497923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77iYSLeL0R+OxfGqh93qmEQlj5zyjP28IAC8Bfg6d9Y=;
 b=WMrc1vKPT7RZb4xFUK4KWF5FLWfUG2X5BNV63OR6aJcd2Bk3TOdtqJ3mozchiNM8iV
 Uz/ln5NinZ/ZVjwUR/f4yFkVhVZMQtlnwYRz1URSpRPE4NSjrV6wI6YXqg54hqEs5HWw
 2CFU/Jj5jc21UrS4LqGljN9LeXqoDUj8uoLCmeoOi3OMy62mhdhpsDBtYXp2PJwqB3aZ
 VBt2pu5Lmr3O1uKQQGjXcy3YbVtZ92Ymp5XQs1j5suxJYwRAnFHNrLhrGexkx16icJ5g
 7p0XJZ7vBjtfovRRrSVKQCW4OyCcg+TxfEsgMK+PBRjdbtxSdJoIi1r8CS/Y2iW1bTMJ
 4qVg==
X-Gm-Message-State: AOJu0YyBcqHBvF3YrTMYtOW8qLvAgzsMlN6ChGt5lui3ZMiulPJfGo++
 yRlwTDHj1kKMTSaHuYOh/i9wxbGkRLk8QcYzBCU6dsOcE7SlID3FoEdmoA==
X-Google-Smtp-Source: AGHT+IHVnCzeKkHxL5mviiNdDAzSdprcC75KbLAqZ+xkvrsXkPUCPcd5crl/H99glLeTrcj0zcOBwQ==
X-Received: by 2002:a5d:69ca:0:b0:368:35a7:b4f with SMTP id
 ffacd0b85a97d-36bbc0dcf6amr7794005f8f.16.1722893122905; 
 Mon, 05 Aug 2024 14:25:22 -0700 (PDT)
Received: from p1g2.lan ([2001:861:3201:3d10:ab7b:e9dd:27f4:647d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c33bsm11018351f8f.22.2024.08.05.14.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 14:25:22 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH v2 5/5] imx8ulp_evk: enable binman support
Date: Mon,  5 Aug 2024 23:25:11 +0200
Message-ID: <20240805212511.653667-6-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805212511.653667-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805212511.653667-1-bisson.gary@gmail.com>
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

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi |  2 +
 arch/arm/mach-imx/imx8ulp/Kconfig    |  1 +
 configs/imx8ulp_evk_defconfig        |  3 +-
 doc/board/nxp/imx8ulp_evk.rst        | 79 ++++++++++++++++++++++++++++
 doc/board/nxp/index.rst              |  1 +
 5 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/nxp/imx8ulp_evk.rst

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 5034ce65fff..ca390f5d702 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2021 NXP
  */
 
+#include "imx8ulp-u-boot.dtsi"
+
 / {
 	mu@27020000 {
 		compatible = "fsl,imx8ulp-mu";
diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ulp/Kconfig
index 49ea25250a3..fbca241e106 100644
--- a/arch/arm/mach-imx/imx8ulp/Kconfig
+++ b/arch/arm/mach-imx/imx8ulp/Kconfig
@@ -23,6 +23,7 @@ choice
 
 config TARGET_IMX8ULP_EVK
 	bool "imx8ulp_evk"
+	select BINMAN
 	select IMX8ULP
 	select SUPPORT_SPL
 	select IMX8ULP_DRAM
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index b302df1f351..0f0748b6792 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x400000
-CONFIG_IMX_CONFIG=""
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx8ulp/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8ulp-evk"
 CONFIG_SPL_TEXT_BASE=0x22020000
@@ -38,6 +38,7 @@ CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx8ulp/container.cfg"
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
diff --git a/doc/board/nxp/imx8ulp_evk.rst b/doc/board/nxp/imx8ulp_evk.rst
new file mode 100644
index 00000000000..db0d9ba698b
--- /dev/null
+++ b/doc/board/nxp/imx8ulp_evk.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx8ulp_evk
+=======================
+
+U-Boot for the NXP i.MX 8ULP EVK board
+
+Quick Start
+-----------
+
+- Get and Build the ARM Trusted firmware
+- Get the uPower firmware
+- Get the M33 firmware
+- Get ahab-container.img
+- Build U-Boot
+- Boot
+
+Get and Build the ARM Trusted firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.10
+
+.. code-block:: bash
+
+   $ unset LDFLAGS
+   $ make PLAT=imx8ulp bl31
+   $ cp build/imx8ulp/release/bl31.bin $(srctree)
+
+Get the uPower firmware
+--------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-upower-1.3.1.bin
+   $ chmod +x firmware-upower-1.3.1.bin
+   $ ./firmware-upower-1.3.1.bin
+   $ cp firmware-upower-1.3.1/upower_a1.bin $(srctree)/upower.bin
+
+Get the M33 firmware
+--------------------
+
+.. code-block:: bash
+
+   $ wget http://www.nxp.com/lgfiles/NMG/MAD/YOCTO/imx8ulp-m33-demo-2.14.1.bin
+   $ chmod +x imx8ulp-m33-demo-2.14.1.bin
+   $ ./imx8ulp-m33-demo-2.14.1.bin
+   $ cp imx8ulp-m33-demo-2.14.1/imx8ulp_m33_TCM_power_mode_switch.bin $(srctree)/m33_image.bin
+
+Get ahab-container.img
+---------------------------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-0.1.2-4ed450a.bin
+   $ chmod +x firmware-ele-imx-0.1.2-4ed450a.bin
+   $ ./firmware-ele-imx-0.1.2-4ed450a.bin
+   $ cp firmware-ele-imx-0.1.2-4ed450a/mx8ulpa2-ahab-container.img $(srctree)
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx8ulp_evk_defconfig
+   $ make
+
+Burn the flash.bin to MicroSD card offset 32KB:
+
+.. code-block:: bash
+
+   $ dd if=flash.bin of=/dev/sd[x] bs=1024 seek=32 conv=notrunc
+
+Boot
+----
+
+Set Boot switch to SD boot
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 94687730544..5f1e878508e 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -11,6 +11,7 @@ NXP Semiconductors
    imx8mp_evk
    imx8mq_evk
    imx8qxp_mek
+   imx8ulp_evk
    imx93_11x11_evk
    imxrt1020-evk
    imxrt1050-evk
-- 
2.43.0

