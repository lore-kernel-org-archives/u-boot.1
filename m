Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919D8C79F9F
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56EF83DEB;
	Mon,  5 Jan 2026 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eAsIX+/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A122839DE; Mon,  5 Jan 2026 16:06:36 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BDF28003E
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso68375e9.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767625594; x=1768230394; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nd1s9fcMl/9cGf6pkoUT5hrtuYBzmXpcW0XMTgxjijg=;
 b=eAsIX+/q3KgSBRhTHG7fVCAsK+hknIDu+fyiqc7r14k203rxlo/U17m1vlv4rHU7mg
 rOjn0gtuZO4ulAFIobQ0RX7ynWNs3kGdYsDIftRDtfergQ0GXbAEO+nC6Ccgr1wUP3v0
 i/iXpBjxcWGgXEvhl9++1wdE0WwPsNX4UNfQegLT9vsMQiLsm7bbOD/f0wJxXmkTMswn
 N0kx3vCcmDy7TZ2y+EkT+priyo8XtM0gjSDZ2H6rwnW85wWMFbFDPKUU/IeT0HeoVINm
 MPVSMKIS4JfxcFfj8K7umQTZ7r+HXv++MNuKc9xO/qJKlsEAUH/hoyAauYruMpaiQDr3
 Dkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767625594; x=1768230394;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nd1s9fcMl/9cGf6pkoUT5hrtuYBzmXpcW0XMTgxjijg=;
 b=QS2rAmmGq2w20UkQaQ9K/cACmyRhkVDCPHaOyNRk6bWAYATBdhjAwY9UP3T61ORo5V
 Jq3/i3hQkeOYd1ez+TUr8FwO/NY35aDW11HCYb68+pU/RgFu/AM4S4PVV8uOiUHzhLYM
 d+KXYGYosmgsKz9r0IqChSmihfiQA7SfAH8d2FpE2Q7SM+R4KXQfVFgUu1p4rk5mchV3
 KUVuLW21SovtvfmK5odw1suPcvIVLSXF4IYpsFVQhAxgsgF00owkDLdY+8D5J7WVQ7q+
 +h5XQPp5S7MCalVb99YqVmVbbtRgqKjGjtsxsl2xzQKXuHUOU9Xwnv1EqvpSwCkvZpK5
 YxEw==
X-Gm-Message-State: AOJu0Yy/UOUfA5izY3KsbOmwf55jsZE73rjcuPH9qPwMhea/1DxeSgV0
 b4Bn8CI1K66Ex0fWtuVM+q1j+DVkYAOGjrgLHZBjYzP9NqxbwidRrSX9
X-Gm-Gg: AY/fxX6zw3FFi5AxT01iIRSHKtzzU8bpCAB4xTEylYE9iH5LJ+oFYxiFKsTTVjcWrOm
 jvM71SOCRyJGjzXsU9614Z7Kg7WHRnDeQWQXL5R+uL6B0G1oRBS8btwRn6zNq/78EE2NP2NXOnv
 ky6wqo8KUyTntO8g91eQc4279qAJNCQsWDAyXHJe8ql3ZozZZGDDF2qg1YN5REe3VB1sM5b2mXA
 ehXXssrlCTjZVSxh1fknjYc0Sg1CJwOvFJlqnEUHhf0c0FUHkeZaZ9ikWVR13DAdGCb6VhEOdN2
 cizDQ/unPEQhkO44HxSvIGyp5/qlowXFrXQjuhzgYYQT6wSwM5c950NCumz1Ll6pLxehZ36d1W6
 8GALcJru+n5+E53sCdoGTjbfLQUncAyf4trxN4WVKgbIbLxreFS+mDAno3SOkB/W+SZZH9Q/n3l
 goX2ySwPdzy8tYZS0vQEq0aIFO4DhV38suypwbMgj3VzNkwWxiejp3LS269ixh8xzBhw==
X-Google-Smtp-Source: AGHT+IFIooxEGohTd1wyKcCEi+wPU/fSlzeDfdXG9Qzh/iFLcUuvfXauOR/IEUwpU8T0xvoSf6/TPg==
X-Received: by 2002:a05:600c:4511:b0:477:af74:ed64 with SMTP id
 5b1f17b1804b1-47d19593992mr601557625e9.27.1767625593703; 
 Mon, 05 Jan 2026 07:06:33 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6c08f9b7sm57955335e9.11.2026.01.05.07.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 07:06:32 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 05 Jan 2026 19:05:38 +0400
Subject: [PATCH v2 3/3] rockchip: spl: Add support for booting from UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-rk3576-ufs-v2-3-caba979a0d6b@gmail.com>
References: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
In-Reply-To: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5674; i=alchark@gmail.com;
 h=from:subject:message-id; bh=ce4cse6obQHFK5q42DizlGxIUtVnElQUTj4rFTBUr84=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRGXw5JFfOb77bhj3r4+90Cs//0Kj/JfCMwbQPv/6CeA
 5/M2hJjOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZjqK/MZ/hkKOudJHdi067SJW/mXVbcnNxsXK32f/8C0Iqr/5i8NsV2MDDMLHOX
 +OvlpXipdIrUopO+7jiwH28mos8vP11yxjIh5wQUA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Mon, 05 Jan 2026 16:18:24 +0100
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

Add the required architecture-specific lookups to enable U-boot SPL to
load images from UFS storage devices on Rockchip RK3576, which has a
boot ROM capable of loading the SPL image from UFS.

This also requires the DM_RESET framework to be available in SPL, as
the UFS driver uses it.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm/dts/rk3576-u-boot.dtsi              | 13 ++++++++++++-
 arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
 arch/arm/mach-rockchip/Kconfig               |  3 +++
 arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++++++++
 drivers/reset/Kconfig                        |  9 +++++++++
 drivers/reset/Makefile                       |  2 +-
 7 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index dc3771b556a3..84d9f39fd407 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -12,7 +12,7 @@
 	};
 
 	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci, &ufshc;
 	};
 
 	dmc {
@@ -81,6 +81,12 @@
 	bootph-some-ram;
 };
 
+&gpio4 {
+	/* Used for resetting the UFS device during initialization */
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &ioc_grf {
 	bootph-all;
 };
@@ -176,6 +182,11 @@
 	bootph-pre-ram;
 };
 
+&ufshc {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &xin24m {
 	bootph-all;
 };
diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
index b15938c021d6..f9ecb6858f04 100644
--- a/arch/arm/include/asm/arch-rockchip/bootrom.h
+++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
@@ -51,6 +51,7 @@ enum {
 	BROM_BOOTSOURCE_SPINOR = 3,
 	BROM_BOOTSOURCE_SPINAND = 4,
 	BROM_BOOTSOURCE_SD = 5,
+	BROM_BOOTSOURCE_UFS = 7,
 	BROM_BOOTSOURCE_I2C = 8,
 	BROM_BOOTSOURCE_SPI = 9,
 	BROM_BOOTSOURCE_USB = 10,
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 92bb4aa62f11..483a2f7c4ab2 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -436,6 +436,9 @@ config ROCKCHIP_RK3576
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_CLK
 	imply SPL_DM_SEQ_ALIAS
+	imply SPL_DM_GPIO if UFS_ROCKCHIP && SPL_UFS_SUPPORT
+	imply SPL_DM_RESET if UFS_ROCKCHIP && SPL_UFS_SUPPORT
+	imply SPL_GPIO if UFS_ROCKCHIP && SPL_UFS_SUPPORT
 	imply SPL_FIT_SIGNATURE
 	imply SPL_LOAD_FIT
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index a1e8a7572fa4..46cf60dc77c7 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -46,6 +46,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
 	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
+	[BROM_BOOTSOURCE_UFS] = "/soc/ufshc@2a2d0000",
 };
 
 static struct mm_region rk3576_mem_map[] = {
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 6572dde29f65..d2dd5e10935f 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -76,6 +76,9 @@ static int spl_node_to_boot_device(int node)
 	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;
 
+	if (!uclass_find_device_by_of_offset(UCLASS_UFS, node, &parent))
+		return BOOT_DEVICE_UFS;
+
 	return -1;
 }
 
@@ -231,6 +234,17 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 		return -ENODEV;
 	}
 
+	if (boot_device == BOOT_DEVICE_UFS) {
+		ret = uclass_find_device(UCLASS_UFS, 0, &dev);
+		if (ret) {
+			debug("%s: could not find device for UFS: %d\n",
+			      __func__, ret);
+			return ret;
+		}
+
+		return ofnode_get_path(dev_ofnode(dev), buf, buflen);
+	}
+
 #if CONFIG_IS_ENABLED(BLK)
 	dev_num = (boot_device == BOOT_DEVICE_MMC1) ? 0 : 1;
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 74c267dfc4e5..d35f3904e404 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -99,6 +99,15 @@ config RESET_ROCKCHIP
 	  though is that some reset signals, like I2C or MISC reset multiple
 	  devices.
 
+config SPL_RESET_ROCKCHIP
+	bool "SPL reset controller driver for Rockchip SoCs"
+	depends on SPL_DM_RESET && ARCH_ROCKCHIP && CLK
+	default y
+	help
+	  Support for the reset controller on Rockchip SoCs in SPL. Select this
+	  if you observe any reset-related warnings or errors when booting SPL,
+	  such as when using UFS storage
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on DM_RESET && TARGET_HSDK
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index ee5b009d1341..dc7d3b610e6e 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
-obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
+obj-$(CONFIG_$(PHASE_)RESET_ROCKCHIP) += reset-rockchip.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o

-- 
2.51.2

