Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B335CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE428341A;
	Wed, 13 May 2026 16:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="qsk/Q7E7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CFC18465A; Wed, 13 May 2026 16:12:08 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD7A80F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de46b8e432so6477881a34.1
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778681525; x=1779286325;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s2EMl2iaVpVzsU/tZHvH0HMcnOr09k365gIY9ngPyKg=;
 b=qsk/Q7E7Kz04yjCqpkg/7sddFa/zSgomT1cR/XAzWT0gSdlX7aN8Oirz9xnUYKTOnq
 UD20V0aFJBHOQaXHVOE9Dmtr02cB9YW3I1owlC4gft6X3ZVyvUnE3TY+gR1qDl2MJ0Nz
 2OAyS3uzRr0TMtTYvnhklW1fMyymhfsOJ2iyFoSgNzds8Ubk8aTB5q8mNwwm4dFAfCwE
 /jgAuaC/1JiUU/+hLBWOyg5hYxDZ7JupIjE4vOR1n1HPS+7goQMsqMPrdRZFTon2Wb3O
 HCOprPHN4GcTDZTy8sezBBX95vUooGr6PkkN4f9SZi0Z3JA70z1Ku1aO64YQxIDRppoT
 c7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778681525; x=1779286325;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2EMl2iaVpVzsU/tZHvH0HMcnOr09k365gIY9ngPyKg=;
 b=SExu/aN/S1piky8f2m3B/mG5qIY5jnQaEHFXMJEvuyIp2ZHYN/6kljlLM0ToNjDn8K
 4cc3yretThc3HchPI+znpjk6qaMKiWNZqagiwGWrz0EQLXfiDnzbPnkukgbAkFZ1JCvr
 mXhWdb73Xn+J3FA+Pd3Dy+EtNvioNLn5i7hIok6phNmlrhS/K3TvtU21MlZJqpR6ag4P
 sRfpCMDIx0wpBAQRMpOxpeLO5+EYiChctKYNo2UX1H3tablEMmcXZfhOZ4S7cyL+Ybbo
 CxrFD9Ej605+SVlxa8Fts1xUlpLtB1fsXJcv+9A8U+Y9LUxOSs2t5BZF6oZAHokFkbJB
 xGFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+03sPV9UXpYNwjDn8n4li8nUeoYic0mLFBEnDKDVlMYUiTi+4K9zMltutnedMMdP93SRJ3H5w=@lists.denx.de
X-Gm-Message-State: AOJu0YxQa021MvdpOiOemAu9862bVqMTUyI09wBiB4QK2O7PIjvfKcMx
 UsYU2mWHcJ+J1Jszf+lVjnYJVkNOv7S1960kfMxTd3c+o3yFJ5pWKui7Ugg6ZQctKSE=
X-Gm-Gg: Acq92OHi41+hBA3OSruRcE51Pud1xqDL2ZYvxQTBZ9nEqt/M3nwMx8N/jCxmf/TfMxS
 myIFCiND7KGLWyuL79r6Q0+yWG/b2KV0WIqShPR7dkwHOW9MvDetHc3DgLuZRHXFP9o9P2Bvgc0
 OkfQKcj7XOKxDycnhG0CRsVhyZ1Z2QfIUjvTM3F2AdBDZYqg9qsZi7EcER1zopJIXfPyzWu1LAV
 h5aKVzfjqWsXAher9IUAOctNm7tVwxpTc5M4UZkF3XLWP7E/wxj/EkJ/2ZQEUFkFgUUG10OgP9c
 daycC8GzE/Bh44RVsajnoI1eVNKHSq+w/IUdOLt9RVbM9/FNedt+8+gNfhSP1s5vP9BQ74O3Z/+
 YQX5Ot2FIbIG+EmnjzC6K36fFraYdrj41rkF0DAIYJTQ7PmoR52jdBmm3mlwsl4I7KxeL1VOWcU
 dH7Ld4fG56Mdsfti6uQBFXU6ccYyeU
X-Received: by 2002:a05:6830:8284:b0:7dc:cb67:cb57 with SMTP id
 46e09a7af769-7e3dc876a87mr1986847a34.16.1778681524673; 
 Wed, 13 May 2026 07:12:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:597d:f2e2:6bf1:a5e9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4fde9sm10989901a34.13.2026.05.13.07.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:12:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 13 May 2026 09:11:52 -0500
Subject: [PATCH] phy: Kconfig: use bool instead of tristate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqEMAxA4atI1hOw9Qf0KjILrVGj0EpTRRHvb
 p1Zfov3LhDyTAJ1coGnnYWdjVCfBMzU2pGQ+2jQqS7TQmW4TicuxtmBR7QOg2cJbSAsVWd0n+l
 c5RXEevU08PE7N9+/ZetmMuHdwX0/I3OulHsAAAA=
X-Change-ID: 20260513-phy-kconfig-no-tristate-61bc2d324149
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7868; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=G5HPxaZl8s5oimOTJTCiSt+yi63WEqWbWbYwhFeeDHY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqBIatRHAyq3XJku3rQdn2T+eIpZy1Q6aUPNr3A
 9wmJID2oMaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagSGrRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AAIEH/ReEJMdlCqqEmAqOfNk0K/AgZdMVl8pVGoMqKgP
 Z03XUAhitqtlmj0ZWeg+QcOao933hIyAQNPdUtz8kT3jff/ocurfO5VF5iw4kuSU57HkpdBEZ6x
 DvGkB8lvjaBaslhvXTCYQJPb0k4fmByKGWBcblJcspZTriu0ttCCiBUWzVDF8/NEVusVGalJn50
 oDMLWTB2Jm/VFrBRxdmn6GEFpNzvlKzoD9O2M7toEkw0ps2C3X1G/CiiBUIGS/jpAX64Ngdiqi7
 YztnKz/kzZcodjtNCF1l2mHEpYK5sPL+dAaDqFZWXvClOgUjoteFTOXbwWLvHV63oCkhUUgw7NN
 uhJY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change all uses of tristate in the PHY Kconfigs to bool. U-Boot does
not support modules, so tristate does not make sense here.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/phy/Kconfig          | 14 +++++++-------
 drivers/phy/cadence/Kconfig  |  4 ++--
 drivers/phy/qcom/Kconfig     | 16 ++++++++--------
 drivers/phy/renesas/Kconfig  |  6 +++---
 drivers/phy/rockchip/Kconfig |  2 +-
 drivers/phy/ti/Kconfig       |  2 +-
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8ec2b146f..eafa82fe494 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -114,7 +114,7 @@ config BCM_SR_PCIE_PHY
 	  If unsure, say N.
 
 config PHY_DA8XX_USB
-	tristate "TI DA8xx USB PHY Driver"
+	bool "TI DA8xx USB PHY Driver"
 	depends on PHY && ARCH_DAVINCI
 	help
 	  Enable this to support the USB PHY on DA8xx SoCs.
@@ -138,7 +138,7 @@ config SPL_PIPE3_PHY
 	  and omap5
 
 config AM654_PHY
-	tristate "TI AM654 SERDES support"
+	bool "TI AM654 SERDES support"
 	depends on PHY && ARCH_K3
 	select REGMAP
 	select SYSCON
@@ -155,7 +155,7 @@ config STI_USB_PHY
 	  STiH407 SoC families.
 
 config PHY_RCAR_GEN2
-	tristate "Renesas R-Car Gen2 USB PHY"
+	bool "Renesas R-Car Gen2 USB PHY"
 	depends on PHY && RCAR_GEN2
 	help
 	  Support for the Renesas R-Car Gen2 USB PHY. This driver operates the
@@ -163,7 +163,7 @@ config PHY_RCAR_GEN2
 	  allows configuring the module multiplexing.
 
 config PHY_RCAR_GEN3
-	tristate "Renesas R-Car Gen3 USB PHY"
+	bool "Renesas R-Car Gen3 USB PHY"
 	depends on PHY && CLK && DM_REGULATOR && (RCAR_GEN3 || RZG2L)
 	default y if (RCAR_GEN3 || RZG2L)
 	help
@@ -171,7 +171,7 @@ config PHY_RCAR_GEN3
 	  PHY connected to EHCI USB module and controls USB OTG operation.
 
 config PHY_STM32_USBPHYC
-	tristate "STMicroelectronics STM32 SoC USB HS PHY driver"
+	bool "STMicroelectronics STM32 SoC USB HS PHY driver"
 	depends on PHY && ARCH_STM32MP
 	help
 	  Enable this to support the High-Speed USB transceiver that is part of
@@ -283,7 +283,7 @@ config PHY_MTK_TPHY
 	  so you can easily distinguish them by banks layout.
 
 config PHY_MTK_UFS
-	tristate "MediaTek UFS M-PHY driver"
+	bool "MediaTek UFS M-PHY driver"
 	depends on ARCH_MEDIATEK
 	depends on PHY
 	help
@@ -337,7 +337,7 @@ config PHY_IMX8M_PCIE
 	  This PHY is found on i.MX8M devices supporting PCIe.
 
 config PHY_XILINX_ZYNQMP
-	tristate "Xilinx ZynqMP PHY driver"
+	bool "Xilinx ZynqMP PHY driver"
 	depends on PHY && ARCH_ZYNQMP
 	help
 	  Enable this to support ZynqMP High Speed Gigabit Transceiver
diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 8c0ab80fbbc..f5f096889fe 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -1,11 +1,11 @@
 config PHY_CADENCE_SIERRA
-	tristate "Cadence Sierra PHY Driver"
+	bool "Cadence Sierra PHY Driver"
 	depends on DM_RESET
 	help
 	  Enable this to support the Cadence Sierra PHY driver
 
 config PHY_CADENCE_TORRENT
-	tristate "Cadence Torrent PHY Driver"
+	bool "Cadence Torrent PHY Driver"
 	depends on DM_RESET
 	help
 	  Enable this to support the Cadence Torrent PHY driver
diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 49f830abf01..7094903d869 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -7,7 +7,7 @@ config MSM8916_USB_PHY
 	  This PHY is found on qualcomm dragonboard410c development board.
 
 config PHY_QCOM_IPQ4019_USB
-	tristate "Qualcomm IPQ4019 USB PHY driver"
+	bool "Qualcomm IPQ4019 USB PHY driver"
 	depends on PHY && ARCH_IPQ40XX
 	help
 	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
@@ -21,26 +21,26 @@ config PHY_QCOM_QMP_COMBO
 	  PHY (USB3 + DisplayPort). Currently only USB3 mode is supported.
 
 config PHY_QCOM_QMP_PCIE
-	tristate "Qualcomm QMP PCIe PHY driver"
+	bool "Qualcomm QMP PCIe PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
 	  Enable this to support the PCIe QMP PHY on various Qualcomm chipsets.
 
 config PHY_QCOM_QMP_UFS
-	tristate "Qualcomm QMP UFS PHY driver"
+	bool "Qualcomm QMP UFS PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
 	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
 
 config PHY_QCOM_QUSB2
-	tristate "Qualcomm USB QUSB2 PHY driver"
+	bool "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
 	  Enable this to support the Super-Speed USB transceiver on various
 	  Qualcomm chipsets.
 
 config PHY_QCOM_USB_SNPS_FEMTO_V2
-	tristate "Qualcomm SNPS FEMTO USB HS PHY v2"
+	bool "Qualcomm SNPS FEMTO USB HS PHY v2"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
 	  Enable this to support the Qualcomm Synopsys DesignWare Core 7nm
@@ -48,7 +48,7 @@ config PHY_QCOM_USB_SNPS_FEMTO_V2
 	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
 
 config PHY_QCOM_SNPS_EUSB2
-	tristate "Qualcomm Synopsys eUSB2 High-Speed PHY"
+	bool "Qualcomm Synopsys eUSB2 High-Speed PHY"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
 	  Enable this to support the Qualcomm Synopsys DesignWare eUSB2
@@ -56,7 +56,7 @@ config PHY_QCOM_SNPS_EUSB2
 	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
 
 config PHY_QCOM_USB_HS_28NM
-	tristate "Qualcomm 28nm High-Speed PHY"
+	bool "Qualcomm 28nm High-Speed PHY"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
 	  Enable this to support the Qualcomm Synopsys DesignWare Core 28nm
@@ -65,7 +65,7 @@ config PHY_QCOM_USB_HS_28NM
 	  IPs on MSM SOCs.
 
 config PHY_QCOM_USB_SS
-	tristate "Qualcomm USB Super-Speed PHY driver"
+	bool "Qualcomm USB Super-Speed PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
 	  Enable this to support the Super-Speed USB transceiver on various
diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
index affbee0500c..3358d454e59 100644
--- a/drivers/phy/renesas/Kconfig
+++ b/drivers/phy/renesas/Kconfig
@@ -3,19 +3,19 @@
 # Phy drivers for Renesas platforms
 
 config PHY_R8A779F0_ETHERNET_SERDES
-	tristate "Renesas R-Car S4-8 Ethernet SERDES driver"
+	bool "Renesas R-Car S4-8 Ethernet SERDES driver"
 	depends on RCAR_64 && PHY
 	help
 	  Support for Ethernet SERDES found on Renesas R-Car S4-8 SoCs.
 
 config PHY_R8A78000_ETHERNET_PCS
-	tristate "Renesas R-Car X5H Ethernet PCS driver"
+	bool "Renesas R-Car X5H Ethernet PCS driver"
 	depends on RCAR_64 && PHY
 	help
 	  Support for Ethernet PCS found on Renesas R-Car X5H SoCs.
 
 config PHY_R8A78000_MP_PHY
-	tristate "Renesas R-Car X5H Multi-Protocol PHY driver"
+	bool "Renesas R-Car X5H Multi-Protocol PHY driver"
 	depends on RCAR_64 && PHY
 	help
 	  Support for Multi-Protocol PHY on Renesas R-Car X5H SoCs.
diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 80128335d52..6f3d7ebe29e 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -49,7 +49,7 @@ config PHY_ROCKCHIP_SNPS_PCIE3
 	  also be able splited into multiple combinations of lanes.
 
 config PHY_ROCKCHIP_USBDP
-	tristate "Rockchip USBDP COMBO PHY Driver"
+	bool "Rockchip USBDP COMBO PHY Driver"
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index df750b26d66..fe96eb6806f 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -1,5 +1,5 @@
 config PHY_J721E_WIZ
-	tristate "TI J721E WIZ (SERDES Wrapper) support"
+	bool "TI J721E WIZ (SERDES Wrapper) support"
 	depends on ARCH_K3
 	help
 	  This option enables support for WIZ module present in TI's J721E

---
base-commit: e3e651c480c46b332f16a7555b97c6c6fd640a40
change-id: 20260513-phy-kconfig-no-tristate-61bc2d324149

Best regards,
--  
David Lechner <dlechner@baylibre.com>

