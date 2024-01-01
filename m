Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7640C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 21:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC9B8780C;
	Mon,  1 Jan 2024 22:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704143225;
	bh=3Lvk/NFfcktnOgVMyGz/GAp65+YhUeXxwggIKS266N8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KfIrQj1tML2jCGvwwX+Z5owUhoF/nAV06FCsEY24pbLCs1VnJepzoIS0Q51Zb4+vA
	 w69bytAxo2l/L8K5Ddezf97UsvxXsAaYuvzRucnHYywaPmNF/pv9ZABNS1615JmKAo
	 GgcrTAytr/JKa4cCrf7LggQgpusWAG7n/hd9UOzgmEMqEPTyePcnIiI2nX5HZh9qFd
	 XUBs55/ECvB2881dagNoA2BnVgtuh6TyC+xQCDX+SFGxjoo2PlKJgkCUPR2Nhf1JI4
	 F0pxchTM9rELCBZMGRB2/OVBEx/nB17fzSz8uicsLpvaoSuxK6oXv8y7Mh6F42+Ptl
	 PBW7vzH7TWdFg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 173A5877EC;
 Mon,  1 Jan 2024 22:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704143224;
 bh=3Lvk/NFfcktnOgVMyGz/GAp65+YhUeXxwggIKS266N8=;
 h=From:To:Cc:Subject:Date:From;
 b=Ln0+6L6MdjIsLWG15W21fKS6LT6feadu/IAcbyMkJe5GmMdHcSJASxzfZ9FFTc25V
 XKEuLq1RCHTp2mmN9JCJQBGVQ8SspbgcySYFyaQYOQZBAcMZsyZ+vXNOJCSRKET5AD
 EKad4XZIbbdb7t7xj+7CNpLd6ggJCDO65gQJBCKZxlCWy3K/TRhcFqZxAaQ9t03j+x
 GK+Sl4jNG5GXpxogIluk0Fc6iRtcuQRk/Uo+kK7RtSE2rT0S7aZ3cLzf7suFKfvexH
 zb9sDO4BAMfTAxj2N9S3IqBPZaSeiMlIGXsyKftcH3c+a8PTWzxFrxW3tzd3x45Ge4
 9/W4Qh3nQ/8xg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Auto-detect PHY on Data Modul i.MX8M Mini/Plus eDM
 SBC
Date: Mon,  1 Jan 2024 22:05:54 +0100
Message-ID: <20240101210650.87314-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Implement fdtdec_board_setup() auto-detection of ethernet PHY.
This uses properties of the hardware and pull resistor placement.

If GPIO1_16 RGMII_MDC is HIGH, then R530 (MX8MM eDM SBC) or
R390 (MX8MP eDM SBC) is populated. R530 or R390 is populated
only on boards with AR8031 PHY.

If GPIO1_16 RGMII_MDC is LOW, then the in-SoM pull down is the
dominant pull resistor. This is the case on boards with BCM54213PE
PHY.

In case AR8031 PHY is populated, the PHY MDIO address is 0, in
case BCM54213PE PHY is populated, the PHY MDIO address is 1, the
fdtdec_board_setup() is used to patch the correct address into
the U-Boot control DT.

Enable broadcom PHY support to support both PHYs.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 .../dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |  6 ---
 .../imx8mm_data_modul_edm_sbc.c               | 42 ++++++++++++++++
 .../imx8mp_data_modul_edm_sbc.c               | 50 +++++++++++++++++++
 configs/imx8mm_data_modul_edm_sbc_defconfig   |  1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig   |  1 +
 5 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
index a2b5976b6bd..cb6ea356fd7 100644
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
@@ -51,12 +51,6 @@
 	};
 };
 
-&eqos {
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	/delete-property/ assigned-clock-rates;
-};
-
 &gpio1 {
 	bootph-pre-ram;
 };
diff --git a/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c b/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
index ff89333b732..bfb2bddc1d1 100644
--- a/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
+++ b/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
@@ -5,9 +5,11 @@
 
 #include <common.h>
 #include <asm/arch/clock.h>
+#include <asm/arch/imx8mm_pins.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <dm/device-internal.h>
+#include <linux/bitfield.h>
 #include <malloc.h>
 #include <spl.h>
 
@@ -34,3 +36,43 @@ int board_late_init(void)
 
 	return 0;
 }
+
+int fdtdec_board_setup(const void *fdt_blob)
+{
+	const void __iomem *mux = (void __iomem *)IOMUXC_BASE_ADDR +
+		FIELD_GET(MUX_CTRL_OFS_MASK, IMX8MM_PAD_ENET_MDC_GPIO1_IO16);
+	const char *phy_compat = "ethernet-phy-ieee802.3-c22";
+	bool is_bcmphy;
+	int phy_node;
+	int ret;
+
+	/* Do nothing if not i.MX8MM eDM SBC */
+	ret = fdt_node_check_compatible(fdt_blob, 0, "dmo,imx8mm-data-modul-edm-sbc");
+	if (ret)
+		return 0;
+
+	/*
+	 * If GPIO1_16 RGMII_MDC is HIGH, then R530 is populated.
+	 * R530 is populated only on boards with AR8031 PHY.
+	 *
+	 * If GPIO1_16 RGMII_MDC is LOW, then the in-SoM pull down
+	 * is the dominant pull resistor. This is the case on boards
+	 * with BCM54213PE PHY.
+	 */
+	setbits_le32(mux, IOMUX_CONFIG_SION);
+	is_bcmphy = !(readl(GPIO1_BASE_ADDR) & BIT(16));
+	clrbits_le32(mux, IOMUX_CONFIG_SION);
+
+	phy_node = fdt_node_offset_by_compatible(fdt_blob, -1, phy_compat);
+	if (phy_node < 0)
+		return 0;
+
+	/*
+	 * Update PHY MDC address in control DT based on the populated
+	 * PHY type. AR8031 is at address 0, BCM54213PE is at address 1.
+	 */
+	fdt_setprop_inplace_u32((void *)fdt_blob, phy_node,
+				"reg", is_bcmphy ? 1 : 0);
+
+	return 0;
+}
diff --git a/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c b/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
index 9fbbbc1b77e..f0f373aa280 100644
--- a/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
+++ b/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
@@ -5,11 +5,13 @@
 
 #include <common.h>
 #include <asm/arch/clock.h>
+#include <asm/arch/imx8mp_pins.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <env.h>
 #include <env_internal.h>
+#include <linux/bitfield.h>
 #include <malloc.h>
 #include <net.h>
 #include <spl.h>
@@ -65,3 +67,51 @@ int board_late_init(void)
 
 	return 0;
 }
+
+int fdtdec_board_setup(const void *fdt_blob)
+{
+	const void __iomem *mux = (void __iomem *)IOMUXC_BASE_ADDR +
+		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_ENET_MDC__ENET_QOS_MDC);
+	const char *phy_compat = "ethernet-phy-ieee802.3-c22";
+	bool is_bcmphy;
+	int phy_node;
+	int ret;
+
+	/* Do nothing if not i.MX8MP eDM SBC */
+	ret = fdt_node_check_compatible(fdt_blob, 0, "dmo,imx8mp-data-modul-edm-sbc");
+	if (ret)
+		return 0;
+
+	/*
+	 * If GPIO1_16 RGMII_MDC is HIGH, then R390 is populated.
+	 * R390 is populated only on boards with AR8031 PHY.
+	 *
+	 * If GPIO1_16 RGMII_MDC is LOW, then the in-SoM pull down
+	 * is the dominant pull resistor. This is the case on boards
+	 * with BCM54213PE PHY.
+	 */
+	setbits_le32(mux, IOMUX_CONFIG_SION);
+	is_bcmphy = !(readl(GPIO1_BASE_ADDR) & BIT(16));
+	clrbits_le32(mux, IOMUX_CONFIG_SION);
+
+	phy_node = fdt_node_offset_by_compatible(fdt_blob, -1, phy_compat);
+	if (phy_node < 0)
+		return 0;
+
+	/*
+	 * Update PHY MDC address in control DT based on the populated
+	 * PHY type. AR8031 is at address 0, BCM54213PE is at address 1.
+	 */
+	fdt_setprop_inplace_u32((void *)fdt_blob, phy_node,
+				"reg", is_bcmphy ? 1 : 0);
+
+	/* Apply the same modification to EQoS PHY */
+	phy_node = fdt_node_offset_by_compatible(fdt_blob, phy_node, phy_compat);
+	if (phy_node < 0)
+		return 0;
+
+	fdt_setprop_inplace_u32((void *)fdt_blob, phy_node,
+				"reg", is_bcmphy ? 1 : 0);
+
+	return 0;
+}
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index 6a4244e3084..3f3a79e55af 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -197,6 +197,7 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_ATHEROS=y
+CONFIG_PHY_BROADCOM=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_FEC_MXC=y
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index f5914ac2a80..c4e39ff9cb8 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -209,6 +209,7 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_ATHEROS=y
+CONFIG_PHY_BROADCOM=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_MDIO=y
-- 
2.43.0

