Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3CDD3B9AB
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 22:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 145B983CEE;
	Wed, 10 Dec 2025 23:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TE71w/3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A58283CAA; Wed, 10 Dec 2025 21:11:41 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B1568042F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-37d96f97206so1230681fa.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765397498; x=1766002298; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AtNp4yHRTipQnwXHJ8be61wiy6KHJ3aEMx3l6PBIQrI=;
 b=TE71w/3aFLRhWNjJslM43c/zO4TRXXULFs1JiUYmvqKs9u18L1JdX8v+U4Tbb1E8+J
 8XJ5C0XLFtiWiXVecTPY7JaTMyyIlhKH8UCVPebJ5mwCYjjvuIACyfpNIewjmR1j2R8t
 JZChW/rzk/3/HjqENouixDs+FFAXI/6Qyzq3aAq2pmXCdJRmDbvhCvKSJxQGjXFIemxF
 dcLxlT22ITtJCJne+N/IXlpoT2R1UPspiy7wmjTJzxSAVU0k0AJKg1JoE56DY673Twjd
 nNghI7aFWkKUebf47N2gAW1yrA3yLItRcCrDuAlcZ84klbmWkIqvZygV/GQh0+YN67xP
 yK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765397498; x=1766002298;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AtNp4yHRTipQnwXHJ8be61wiy6KHJ3aEMx3l6PBIQrI=;
 b=M0a9q5MWhvWZtObHcqEMe++YlKQ7ZODR584TEafT9qG0x/Hmat9V9KJEegEIBrKvNW
 oJUMlLyNIv/p+4LeriOjvXeyNZIivNpPKKQgOwQKGrbNDlcGN9p/LC6lB0v+f2RSQwmO
 1Zd8Xy1PE9V54yUYvBwvN/l3ujbJXVgWa5Nbfw1ABoxcR3AWOmJO7L9srurXbm+6iWbM
 rp/Kpmg9HDawOtBioN6REGJBU2lsACgLIJRXsAbeVjMDhrZZJdC2IXJK5oDMk4a8W/t8
 +UY99eD0ifAJeqvEMEeZnmW/D4mxu0x7HvCHBWwcz0mg+koyaCrPJyjzD387F8I0GO25
 Y0Ug==
X-Gm-Message-State: AOJu0YzXt7Tp/ft3WwOqBL6YPfU1sfOevEUpTJImbqUrgbys25OLXtQm
 1IDIkKpSSXfrF6juaaGhHp/njJd9NONkXeVFY4ytpYOVS5q0BtfeY2mV
X-Gm-Gg: AY/fxX5iQUrVRhzoWcnbodbrwHxMSUpiE+EMfBhjCX2rRBZoC8obt3rKxHUm9F4hKZx
 og8Ur/LYCRU124OpAycDOhGQlD9/U04z9ycWcyQ8K3Ab52A4NfXSJhXjGiEePb7ATw5qB9VSvHC
 71n1q/lGv6NMZAALiOqsneinqEA1SlwJRe6uK5V2BdaVYAC6APbEodNBmQG5VbMnM47jrgr/xNP
 oeErbMku3SrJv0hjsgoMwc8fy4Fgwc3pLF0erjce4Km4oYFbp5jBaEBxmSurFTRiJ9pebnGmTyg
 fv7KacxiQ2uN90CRkLIHDIikCtub2SM1XDKCDhWq79RrK5hJjujgUK/K2gKDirANeben+rWFyQo
 T+GqLnQvLjMP0jq4hBG85sOdluWHxT0NwbbIRD0BqrdhdZTRqhLrE77xpSdz1lr+qsjENQIekxz
 Tnyf9VJanT8526oSlFKWo+k2lm
X-Google-Smtp-Source: AGHT+IGalXm0fZLyF/vyW9gPgjKTFCQ1P+SSXOWNffNzsXAEnSdD09gLZetA+x0LO4xEudcoLHRsUA==
X-Received: by 2002:a05:6512:3b99:b0:597:d777:837 with SMTP id
 2adb3069b0e04-598ee4f5b1emr1396405e87.22.1765397497454; 
 Wed, 10 Dec 2025 12:11:37 -0800 (PST)
Received: from alchark-surface.localdomain ([31.173.84.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-598f2f45bbbsm134986e87.45.2025.12.10.12.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:11:36 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 10 Dec 2025 23:10:50 +0300
Subject: [PATCH 4/4] rockchip: spl: Add support for booting from UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-rk3576-ufs-v1-4-a3f9e76eb66e@gmail.com>
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
In-Reply-To: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anurag Dutta <a-dutta@ti.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Sam Edwards <cfsworks@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Randolph <randolph@andestech.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5674; i=alchark@gmail.com;
 h=from:subject:message-id; bh=oAHFtNySofXzOj2yobL6+fIzLlfZ9Nm9O2Q/jjlZtgw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRaXn7umPrQ2uXqhdupN1xkZT2EXa9nbWHd93xSNXt8D
 rP9spQrHaUsDGJcDLJiiixzvy2xnWrEN2uXh8dXmDmsTCBDGLg4BWAin+UY/idw3LJP8HglH39u
 q/M5sZkry9ytNr47wtJSUtnz8Ir1wdOMDJ+0o+ZNmNZe8rUhcsZJZYEd5b32M6O22hld+sVbdug
 5IxsA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 10 Dec 2025 23:28:32 +0100
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
index f78eaf52c2ad..18261ff99d58 100644
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
index 1ea1033b5eac..a886aa1306c7 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -75,6 +75,9 @@ static int spl_node_to_boot_device(int node)
 	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;
 
+	if (!uclass_find_device_by_of_offset(UCLASS_UFS, node, &parent))
+		return BOOT_DEVICE_UFS;
+
 	return -1;
 }
 
@@ -223,6 +226,17 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
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
2.49.1

