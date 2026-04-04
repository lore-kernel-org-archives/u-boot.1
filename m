Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F069E88D8B
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 11:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD81840AA;
	Sat,  4 Apr 2026 13:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qCDxqiE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E2D7840B0; Sat,  4 Apr 2026 13:21:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BAAE83642
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 13:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9840bc8030so35194366b.1
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775301692; x=1775906492; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5RdjIKhtQP1zWY5CLrhfgaZ47zFWxzOWJKOPB7dYO0c=;
 b=qCDxqiE9HlOnWd6svIIu4aXWC2LVrxMC3PAoOoPVXkY4yE7z991e1qcuoU0KisuAx7
 j3XlzUtGZ6DsXFV1g/qALr1v/O/ZBKCWdHNxtleXP9jxWd1n2aVMa9LhgzqgaIeL6Pvl
 cyTblltCdH45JSaw7/tPNR0WYfvBsCPDma09+dxtInd/KyvKIxQhuOvChrzZtQ9sPab1
 f5+0S56cK+O210fRVszcUziuuoeYNX7xZA/MS9FbZ7wPTRk5woRXps6giAnJCSDy51wF
 YwM48DR+WbtnmXkD/q7AUByaqUOrMFHBkzivNrMcHzvE3k7JdzdgMEGCWL/lz+vSVwkJ
 gfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775301692; x=1775906492;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RdjIKhtQP1zWY5CLrhfgaZ47zFWxzOWJKOPB7dYO0c=;
 b=auw89hVoXbns9joJeIIWpSblv2nsbqdPCddOvVLUMU39qGEkj20vfmuAcqHU4JUM1v
 pBpP+lLvMpYufwDAkdwzwxd9v2C/fj1ILEApgVT1AJf0mWI7tDpB0DQmbDUgR+rRqJmd
 2cQluj7Er1pwz1KNiP+6MGcMCwnnksGV1AAchHQacAOc+B43fkuahPuPdvvjgr7PXIvY
 EFYkYwXzU+KxXO+eDiZdtlq2b2PQvAJR9xkluJnW7/u/03wvm6a/ql6bjQwVWwKA/1k2
 hKgLzLJyPDSDF82RjiIfxGl02EcsIZSLMWqw94ooLK06kdTy4KtbsCGIJjTk273VWFqx
 v0cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU/ywrLnt2XZ1HleVGBfSCJYyv2f6W5287C0Ig6NJktkFLyLyFZqhHzMCZXdxtO/ziAyI1k7k=@lists.denx.de
X-Gm-Message-State: AOJu0YxOs0QhbAnzj8AOnLvjP07InSokW09kd8roLLFwHfPtY1yfIT3E
 gvDYDCZnW47N0Rrod8zQgA0jG/kTPRnifk3fqcCpcLnTMVI4y9+p1Ejo
X-Gm-Gg: AeBDieuzy98CWdV7z75d0hkq0mxAIfhvJGhxsp9mMo9U9RS9CZEnrqJYi4hhMfSis2A
 788d7d8uIvOtYk2a/kBk0ynKL6AWDVMo8mZJwb/bDHYVUjNM/kD1RLcVcSIeD4lEdOHvjukuFts
 iqOUSZ1JW4nL3xTsTxL7GCPPXsxD8odpcAxaD9zbZ2BsqEU/4FGJ0Usk1+vOoLWDXssd75OSW8M
 K7pY7IlIKXQAviM6GCIbJ3qbAQnbb/gyYQQD1UVijLdW8rn2HM6hqG+LwhVsWCjC7KOd9l/u87h
 nV15Y7i80va0Asz7zaXkZWpZyPSFyTzLSDCmVfb+xs/HqALsPmXone6wXyB2E0c9w/JF7ueaZLM
 rAKJRjKKZpjJJetbNeBS0hslWd8gfRy2sqgW1JIeC+4I9Qz1/2r6juh+I++L0yRKi435+TpoZNp
 lLFGJxnez02v3dmcqva0Q2ddEf3ANsECRCUsMuxi6x5l9ohlOMnu6tn9fYu2cklg==
X-Received: by 2002:a05:6402:34c4:b0:66e:a6a2:5e0 with SMTP id
 4fb4d7f45d1cf-66ea6a20724mr122234a12.6.1775301692276; 
 Sat, 04 Apr 2026 04:21:32 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66e033a787fsm2301860a12.14.2026.04.04.04.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 04:21:31 -0700 (PDT)
Message-ID: <3a5148a1-4e12-4924-92b5-51837ab8ffbc@gmail.com>
Date: Sat, 4 Apr 2026 13:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/2] usb: phy: remove rockchip_usb2_phy.c
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <a3aaa5dc-b959-4301-8d35-f295a019823a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <a3aaa5dc-b959-4301-8d35-f295a019823a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Remove rockchip_usb2_phy.c and replace it by phy-rockchip-usb2.c
Adjust defconfigs. Enable CONFIG_DM_RESET where needed to compile
th phy driver. Add grf bind function for usbphy node.
Remove a variable no longer needed from an include file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
Add grf bind function
Restyle
---
 arch/arm/mach-rockchip/board.c                |  28 -----
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c |  26 ++++
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c |  26 ++++
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c |  26 ++++
 configs/chromebit_mickey_defconfig            |   2 +-
 configs/chromebook_jerry_defconfig            |   2 +-
 configs/chromebook_minnie_defconfig           |   2 +-
 configs/chromebook_speedy_defconfig           |   2 +-
 configs/evb-rk3288-rk808_defconfig            |   2 +-
 configs/firefly-rk3288_defconfig              |   4 +-
 configs/miqi-rk3288_defconfig                 |   4 +-
 configs/mk808_defconfig                       |   2 +-
 configs/phycore-rk3288_defconfig              |   3 +-
 configs/popmetal-rk3288_defconfig             |   3 +-
 configs/rock-pi-n8-rk3288_defconfig           |   2 +-
 configs/rock2_defconfig                       |   3 +-
 configs/rock_defconfig                        |   3 +-
 configs/tinker-rk3288_defconfig               |   4 +-
 configs/tinker-s-rk3288_defconfig             |   4 +-
 configs/vyasa-rk3288_defconfig                |   2 +-
 drivers/usb/phy/Kconfig                       |   3 -
 drivers/usb/phy/Makefile                      |   1 -
 drivers/usb/phy/rockchip_usb2_phy.c           | 113 ------------------
 include/usb/dwc2_udc.h                        |   1 -
 24 files changed, 102 insertions(+), 166 deletions(-)
 delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 2e6bb38b9235..1538f4fef081 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -269,34 +269,6 @@ int board_usb_init(int index, enum usb_init_type init)
 	}
 	otg_data.regs_otg = ofnode_get_addr(node);

-#ifdef CONFIG_ROCKCHIP_USB2_PHY
-	int ret;
-	u32 phandle, offset;
-	ofnode phy_node;
-
-	ret = ofnode_read_u32(node, "phys", &phandle);
-	if (ret)
-		return ret;
-
-	node = ofnode_get_by_phandle(phandle);
-	if (!ofnode_valid(node)) {
-		debug("Not found usb phy device\n");
-		return -ENODEV;
-	}
-
-	phy_node = ofnode_get_parent(node);
-	if (!ofnode_valid(node)) {
-		debug("Not found usb phy device\n");
-		return -ENODEV;
-	}
-
-	otg_data.phy_of_node = phy_node;
-	ret = ofnode_read_u32(node, "reg", &offset);
-	if (ret)
-		return ret;
-	otg_data.regs_phy =  offset +
-		(u32)syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-#endif
 	return dwc2_udc_probe(&otg_data);
 }

diff --git a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
index ff269b53b542..3514e547d523 100644
--- a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
@@ -5,10 +5,33 @@
  */

 #include <dm.h>
+#include <dm/lists.h>
 #include <log.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>

+#if CONFIG_IS_ENABLED(OF_REAL) && IS_ENABLED(CONFIG_PHY_ROCKCHIP_USB2)
+static int rk3066_syscon_bind(struct udevice *dev)
+{
+	if (dev->driver_data == ROCKCHIP_SYSCON_GRF) {
+		ofnode subnode = ofnode_find_subnode(dev_ofnode(dev), "usbphy");
+
+		if (ofnode_valid(subnode)) {
+			struct udevice *usbphy_dev;
+			int ret;
+
+			ret = device_bind_driver_to_node(dev, "rockchip_usbphy", "usbphy",
+							 subnode, &usbphy_dev);
+			if (ret)
+				return ret;
+
+			usbphy_dev->driver_data = usbphy_dev->driver->of_match->data;
+		}
+	}
+
+	return 0;
+}
+#endif
 static const struct udevice_id rk3066_syscon_ids[] = {
 	{ .compatible = "rockchip,rk3066-noc", .data = ROCKCHIP_SYSCON_NOC },
 	{ .compatible = "rockchip,rk3066-grf", .data = ROCKCHIP_SYSCON_GRF },
@@ -20,6 +43,9 @@ U_BOOT_DRIVER(syscon_rk3066) = {
 	.name = "rk3066_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3066_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL) && IS_ENABLED(CONFIG_PHY_ROCKCHIP_USB2)
+	.bind = rk3066_syscon_bind,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
index 6df054e5b27d..1c4a2b8680ae 100644
--- a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
@@ -9,6 +9,29 @@
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>

+#if CONFIG_IS_ENABLED(OF_REAL) && IS_ENABLED(CONFIG_PHY_ROCKCHIP_USB2)
+static int rk3188_syscon_bind(struct udevice *dev)
+{
+	if (dev->driver_data == ROCKCHIP_SYSCON_GRF) {
+		ofnode subnode = ofnode_find_subnode(dev_ofnode(dev), "usbphy");
+
+		if (ofnode_valid(subnode)) {
+			struct udevice *usbphy_dev;
+			int ret;
+
+			ret = device_bind_driver_to_node(dev, "rockchip_usbphy", "usbphy",
+							 subnode, &usbphy_dev);
+			if (ret)
+				return ret;
+
+			usbphy_dev->driver_data = usbphy_dev->driver->of_match->data;
+		}
+	}
+
+	return 0;
+}
+#endif
+
 static const struct udevice_id rk3188_syscon_ids[] = {
 	{ .compatible = "rockchip,rk3188-noc", .data = ROCKCHIP_SYSCON_NOC },
 	{ .compatible = "rockchip,rk3188-grf", .data = ROCKCHIP_SYSCON_GRF },
@@ -20,6 +43,9 @@ U_BOOT_DRIVER(syscon_rk3188) = {
 	.name = "rk3188_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3188_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL) && IS_ENABLED(CONFIG_PHY_ROCKCHIP_USB2)
+	.bind = rk3188_syscon_bind,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
index 6413d0a88a16..86bc0927502a 100644
--- a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
@@ -12,6 +12,29 @@
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>

+#if CONFIG_IS_ENABLED(OF_REAL) && IS_ENABLED(CONFIG_PHY_ROCKCHIP_USB2)
+static int rk3288_syscon_bind(struct udevice *dev)
+{
+	if (dev->driver_data == ROCKCHIP_SYSCON_GRF) {
+		ofnode subnode = ofnode_find_subnode(dev_ofnode(dev), "usbphy");
+
+		if (ofnode_valid(subnode)) {
+			struct udevice *usbphy_dev;
+			int ret;
+
+			ret = device_bind_driver_to_node(dev, "rockchip_usbphy", "usbphy",
+							 subnode, &usbphy_dev);
+			if (ret)
+				return ret;
+
+			usbphy_dev->driver_data = usbphy_dev->driver->of_match->data;
+		}
+	}
+
+	return 0;
+}
+#endif
+
 static const struct udevice_id rk3288_syscon_ids[] = {
 	{ .compatible = "rockchip,rk3288-noc", .data = ROCKCHIP_SYSCON_NOC },
 	{ .compatible = "rockchip,rk3288-grf", .data = ROCKCHIP_SYSCON_GRF },
@@ -24,6 +47,9 @@ U_BOOT_DRIVER(syscon_rk3288) = {
 	.name = "rk3288_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3288_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL) && IS_ENABLED(CONFIG_PHY_ROCKCHIP_USB2)
+	.bind = rk3288_syscon_bind,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 60ceae8f1531..b574f8bceebd 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -82,6 +82,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -102,7 +103,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index 5e89311affe3..9f0d4d94cbca 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -82,6 +82,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -106,7 +107,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 6e0158fd4a9e..ae8c1d3fc9a1 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -83,6 +83,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -107,7 +108,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index 86f1399c0e3c..7b4258f18427 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -83,6 +83,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -107,7 +108,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/evb-rk3288-rk808_defconfig b/configs/evb-rk3288-rk808_defconfig
index 2112e475ad31..5244c42b7b4e 100644
--- a/configs/evb-rk3288-rk808_defconfig
+++ b/configs/evb-rk3288-rk808_defconfig
@@ -71,6 +71,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -85,7 +86,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_VIDEO=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 54e3c41f3ccf..0999bf03d60a 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -62,11 +62,12 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -82,7 +83,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 4cbd4b97172a..827f1ae159e1 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -59,11 +59,12 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -79,7 +80,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index b983128e1def..3b63e5f930bb 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -92,6 +92,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -111,7 +112,6 @@ CONFIG_TPL_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index a374f90982e0..bafe49818637 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-phycore-rdk"
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -68,6 +69,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -82,7 +84,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_SMSC95XX=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index 52d38f4108c3..a4d0bd705fdf 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-popmetal"
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -64,6 +65,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -78,7 +80,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_SMSC95XX=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index 242aa89bcce0..71749c3b8741 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -63,6 +63,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -81,7 +82,6 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 # CONFIG_USB_KEYBOARD_FN_KEYS is not set
 CONFIG_USB_GADGET=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index 025b55e2171b..6ebda3a36992 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-rock2-square"
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -65,6 +66,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -80,7 +82,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index 71e504713c16..753deb349afd 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3188-radxarock"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3188=y
 # CONFIG_ROCKCHIP_STIMER is not set
 CONFIG_TARGET_ROCK=y
@@ -53,6 +54,7 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -68,7 +70,6 @@ CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_ROCKCHIP_TIMER=y
 CONFIG_USB=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_RANDOM_UUID=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 2e701a5ff722..a1d8acc70e3c 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -62,11 +62,12 @@ CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -81,7 +82,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 816903c8430e..902742b73bf0 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -62,11 +62,12 @@ CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -81,7 +82,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index 1d7e22653608..a0e160e6d70c 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -72,6 +72,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -87,7 +88,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index c505862f1e15..9c91f63786ac 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -7,6 +7,3 @@ comment "USB Phy"

 config TWL4030_USB
 	bool "TWL4030 PHY"
-
-config ROCKCHIP_USB2_PHY
-	bool "Rockchip USB2 PHY"
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index b67a70bbe8ed..cf6109dee610 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -4,4 +4,3 @@
 # Tom Rix <Tom.Rix@windriver.com>

 obj-$(CONFIG_TWL4030_USB) += twl4030.o
-obj-$(CONFIG_ROCKCHIP_USB2_PHY) += rockchip_usb2_phy.o
diff --git a/drivers/usb/phy/rockchip_usb2_phy.c b/drivers/usb/phy/rockchip_usb2_phy.c
deleted file mode 100644
index bdbd0d44813a..000000000000
--- a/drivers/usb/phy/rockchip_usb2_phy.c
+++ /dev/null
@@ -1,113 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-#include <hang.h>
-#include <log.h>
-#include <asm/io.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-
-#include "../gadget/dwc2_udc_otg_priv.h"
-
-#define BIT_WRITEABLE_SHIFT	16
-
-struct usb2phy_reg {
-	unsigned int offset;
-	unsigned int bitend;
-	unsigned int bitstart;
-	unsigned int disable;
-	unsigned int enable;
-};
-
-/**
- * struct rockchip_usb2_phy_cfg: usb-phy port configuration
- * @port_reset: usb otg per-port reset register
- * @soft_con: software control usb otg register
- * @suspend: phy suspend register
- */
-struct rockchip_usb2_phy_cfg {
-	struct usb2phy_reg port_reset;
-	struct usb2phy_reg soft_con;
-	struct usb2phy_reg suspend;
-};
-
-struct rockchip_usb2_phy_dt_id {
-	char		compatible[128];
-	const void	*data;
-};
-
-static const struct rockchip_usb2_phy_cfg rk3066a_pdata = {
-	.port_reset	= {0x00, 12, 12, 0, 1},
-	.soft_con	= {0x08, 2, 2, 0, 1},
-	.suspend	= {0x08, 8, 3, (0x01 << 3), (0x2A << 3)},
-};
-
-static const struct rockchip_usb2_phy_cfg rk3288_pdata = {
-	.port_reset     = {0x00, 12, 12, 0, 1},
-	.soft_con       = {0x08, 2, 2, 0, 1},
-	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
-};
-
-static struct rockchip_usb2_phy_dt_id rockchip_usb2_phy_dt_ids[] = {
-	{ .compatible = "rockchip,rk3066a-usb-phy", .data = &rk3066a_pdata },
-	{ .compatible = "rockchip,rk3188-usb-phy", .data = &rk3288_pdata },
-	{ .compatible = "rockchip,rk3288-usb-phy", .data = &rk3288_pdata },
-	{}
-};
-
-static void property_enable(struct dwc2_plat_otg_data *pdata,
-				  const struct usb2phy_reg *reg, bool en)
-{
-	unsigned int val, mask, tmp;
-
-	tmp = en ? reg->enable : reg->disable;
-	mask = GENMASK(reg->bitend, reg->bitstart);
-	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
-
-	writel(val, pdata->regs_phy + reg->offset);
-}
-
-void otg_phy_init(struct dwc2_udc *dev)
-{
-	struct dwc2_plat_otg_data *pdata = dev->pdata;
-	struct rockchip_usb2_phy_cfg *phy_cfg = NULL;
-	struct rockchip_usb2_phy_dt_id *of_id;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(rockchip_usb2_phy_dt_ids); i++) {
-		of_id = &rockchip_usb2_phy_dt_ids[i];
-		if (ofnode_device_is_compatible(pdata->phy_of_node,
-						of_id->compatible)){
-			phy_cfg = (struct rockchip_usb2_phy_cfg *)of_id->data;
-			break;
-		}
-	}
-	if (!phy_cfg) {
-		debug("Can't find device platform data\n");
-
-		hang();
-		return;
-	}
-	pdata->priv = phy_cfg;
-	/* disable software control */
-	property_enable(pdata, &phy_cfg->soft_con, false);
-
-	/* reset otg port */
-	property_enable(pdata, &phy_cfg->port_reset, true);
-	mdelay(1);
-	property_enable(pdata, &phy_cfg->port_reset, false);
-	udelay(1);
-}
-
-void otg_phy_off(struct dwc2_udc *dev)
-{
-	struct dwc2_plat_otg_data *pdata = dev->pdata;
-	struct rockchip_usb2_phy_cfg *phy_cfg = pdata->priv;
-
-	/* enable software control */
-	property_enable(pdata, &phy_cfg->soft_con, true);
-	/* enter suspend */
-	property_enable(pdata, &phy_cfg->suspend, true);
-}
diff --git a/include/usb/dwc2_udc.h b/include/usb/dwc2_udc.h
index aa37e957b47c..c8610ef8c98a 100644
--- a/include/usb/dwc2_udc.h
+++ b/include/usb/dwc2_udc.h
@@ -15,7 +15,6 @@

 struct dwc2_plat_otg_data {
 	void		*priv;
-	ofnode		phy_of_node;
 	int		(*phy_control)(int on);
 	uintptr_t	regs_phy;
 	uintptr_t	regs_otg;
--
2.39.5

