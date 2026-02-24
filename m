Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8781EE9B265
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2583783DEB;
	Tue, 24 Feb 2026 14:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="bCE0rcxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F70B83BC9; Tue, 24 Feb 2026 12:04:28 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D471E82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 12:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=airoha.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ar701363@airoha.com
X-UUID: 8e16783c117011f1bcd7499a721e883d-20260224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=NKR6mbUSXkmlf9Hq9n9UA1oybw1G5AEay+5Bu6q4HOk=; 
 b=bCE0rcxq6lF7o+5S3WgiUG4mHQlpiU7eYNo2RbLXjkcJ0ScwA/En+qllrU6vuG+hLXnBk71LHxSIhGAzXK/HfxoeaIHjEyNgStQfQ5ZVHgZKAT2a1K10wcq4S5muuY72g0WDhzqmHmQzeyx8N8+lG1OHMpdGxGXDnGYrGYGHMIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:e7dbac9c-b3a8-4223-b45b-74558a521f5b, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:-45
X-CID-META: VersionHash:89c9d04, CLOUDID:cb34f4f0-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
 0,EDM:1,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,O
 SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e16783c117011f1bcd7499a721e883d-20260224
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <ar701363@airoha.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 80581575; Tue, 24 Feb 2026 19:04:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Feb 2026 19:04:13 +0800
Received: from mediatek.com (172.18.153.125) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Tue, 24 Feb 2026 19:04:13 +0800
Received: by arhtenbupstream01.localdomain (Postfix, from userid 1003)
 id 098E61405E5; Tue, 24 Feb 2026 19:04:13 +0800 (CST)
From: Tommy Shih <tommy.shih@airoha.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Joe Hershberger <joe.hershberger@ni.com>, "Lucien
 . Jheng" <lucienzx159@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, <daniel@makrotopia.org>,
 <frank-w@public-files.de>, <u-boot@lists.denx.de>
CC: Lucien Jheng <lucien.jheng@airoha.com>, Tommy Shih <tommy.shih@airoha.com>
Subject: [PATCH v1] net: phy: air_en8811: add support for Airoha AN8811HB PHY
Date: Tue, 24 Feb 2026 19:02:50 +0800
Message-ID: <20260224110403.418941-1-tommy.shih@airoha.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 24 Feb 2026 14:56:44 +0100
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

Add support for the Airoha AN8811HB 2.5 Gigabit PHY to the existing
en8811h driver. This PHY supports 10/100/1000/2500 Mbps speeds.

Update the driver to recognize the AN8811HB PHY ID and handle its
specific firmware loading requirements. The firmware loading mechanism
remains consistent with the existing implementation.

This driver is based on:
  - Linux upstream PHY subsystem (v7.0-rc1)
  - air_an8811hb v0.0.4 out-of-tree uboot driver written by
    "Lucien.Jheng <lucien.jheng@airoha.com>"

Tested on MT7987 RFB board.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6f1769ec5892ac41d82e820d94dcdc68e904aa99
Link: https://patchwork.kernel.org/project/netdevbpf/patch/20260122071601.1057083-3-bjorn@mork.no/
Signed-off-by: Tommy Shih <tommy.shih@airoha.com>
Reviewed-by: Lucien.Jheng <lucienzx159@gmail.com>

---

 drivers/net/phy/airoha/Kconfig      |   2 +-
 drivers/net/phy/airoha/air_en8811.c | 695 ++++++++++++++++++++++++++--
 2 files changed, 652 insertions(+), 45 deletions(-)

diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
index 999564e4848..fcace9a24ac 100644
--- a/drivers/net/phy/airoha/Kconfig
+++ b/drivers/net/phy/airoha/Kconfig
@@ -8,4 +8,4 @@ config PHY_AIROHA_EN8811
 	select FW_LOADER
 	help
 	  AIROHA EN8811H supported.
-
+	  AIROHA AN8811HB supported.
diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
index 1a628ede82b..974887da33d 100644
--- a/drivers/net/phy/airoha/air_en8811.c
+++ b/drivers/net/phy/airoha/air_en8811.c
@@ -1,46 +1,37 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Driver for the Airoha EN8811H 2.5 Gigabit PHY.
+ * Driver for the Airoha EN8811H and AN8811HB 2.5 Gigabit PHY.
  *
- * Limitations of the EN8811H:
+ * Limitations:
  * - Only full duplex supported
  * - Forced speed (AN off) is not supported by hardware (100Mbps)
  *
  * Source originated from linux air_en8811h.c
  *
- * Copyright (C) 2025 Airoha Technology Corp.
+ * Copyright (C) 2025, 2026 Airoha Technology Corp.
  */
-
 #include <phy.h>
 #include <errno.h>
 #include <log.h>
 #include <env.h>
 #include <malloc.h>
+#include <fs.h>
 #include <fw_loader.h>
 #include <asm/unaligned.h>
+#include <version.h>
+#include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/compat.h>
+#include <linux/kernel.h>
 #include <dm/device_compat.h>
 #include <u-boot/crc.h>
 
-#define EN8811H_PHY_ID		0x03a2a411
-
-#define AIR_FW_ADDR_DM		0x00000000
-#define AIR_FW_ADDR_DSP		0x00100000
-
-#define EN8811H_MD32_DM_SIZE	0x4000
-#define EN8811H_MD32_DSP_SIZE	0x20000
-
-#define EN8811H_FW_CTRL_1		0x0f0018
-#define EN8811H_FW_CTRL_1_START		0x0
-#define EN8811H_FW_CTRL_1_FINISH	0x1
-#define EN8811H_FW_CTRL_2		0x800000
-#define EN8811H_FW_CTRL_2_LOADING	BIT(11)
-
 /* MII Registers */
 #define AIR_AUX_CTRL_STATUS		0x1d
 #define AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
+#define AIR_AUX_CTRL_STATUS_SPEED_10	0x0
 #define AIR_AUX_CTRL_STATUS_SPEED_100	0x4
 #define AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
 #define AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
@@ -49,6 +40,7 @@
 #define AIR_PHY_PAGE_STANDARD		0x0000
 #define AIR_PHY_PAGE_EXTENDED_4		0x0004
 
+#define AIR_PBUS_MODE_ADDR_HIGH		0x1c
 /* MII Registers Page 4 */
 #define AIR_BPBUS_MODE			0x10
 #define AIR_BPBUS_MODE_ADDR_FIXED	0x0000
@@ -63,8 +55,16 @@
 #define AIR_BPBUS_RD_DATA_LOW		0x18
 
 /* Registers on MDIO_MMD_VEND1 */
-#define EN8811H_PHY_FW_STATUS		0x8009
-#define EN8811H_PHY_READY		0x02
+#define AIR_PHY_MCU_CMD_1		0x800c
+#define AIR_PHY_MCU_CMD_1_MODE1		0x0
+#define AIR_PHY_MCU_CMD_2		0x800d
+#define AIR_PHY_MCU_CMD_2_MODE1		0x0
+#define AIR_PHY_MCU_CMD_3		0x800e
+#define AIR_PHY_MCU_CMD_3_MODE1		0x1101
+#define AIR_PHY_MCU_CMD_3_DOCMD		0x1100
+#define AIR_PHY_MCU_CMD_4		0x800f
+#define AIR_PHY_MCU_CMD_4_MODE1		0x0002
+#define AIR_PHY_MCU_CMD_4_INTCLR	0x00e4
 
 /* Registers on MDIO_MMD_VEND2 */
 #define AIR_PHY_LED_BCR			0x021
@@ -77,7 +77,7 @@
 
 #define AIR_PHY_LED_DUR_BLINK		0x023
 
-#define AIR_PHY_LED_ON(i)	       (0x024 + ((i) * 2))
+#define AIR_PHY_LED_ON(i)		(0x024 + ((i) * 2))
 #define AIR_PHY_LED_ON_MASK		(GENMASK(6, 0) | BIT(8))
 #define AIR_PHY_LED_ON_LINK1000		BIT(0)
 #define AIR_PHY_LED_ON_LINK100		BIT(1)
@@ -90,7 +90,7 @@
 #define AIR_PHY_LED_ON_POLARITY		BIT(14)
 #define AIR_PHY_LED_ON_ENABLE		BIT(15)
 
-#define AIR_PHY_LED_BLINK(i)	       (0x025 + ((i) * 2))
+#define AIR_PHY_LED_BLINK(i)		(0x025 + ((i) * 2))
 #define AIR_PHY_LED_BLINK_1000TX	BIT(0)
 #define AIR_PHY_LED_BLINK_1000RX	BIT(1)
 #define AIR_PHY_LED_BLINK_100TX		BIT(2)
@@ -104,21 +104,101 @@
 #define AIR_PHY_LED_BLINK_2500TX	BIT(10)
 #define AIR_PHY_LED_BLINK_2500RX	BIT(11)
 
+/* Registers on BUCKPBUS */
+#define AIR_PHY_CONTROL			0x3a9c
+#define AIR_PHY_CONTROL_SURGE_5R	BIT(3)
+#define AIR_PHY_CONTROL_INTERNAL	BIT(11)
+
+/* Led definitions */
+#define EN8811H_LED_COUNT		3
+
+/* Firmware registers */
+#define AIR_FW_ADDR_DM			0x00000000
+#define AIR_FW_ADDR_DSP			0x00100000
+#define EN8811H_FW_CTRL_1		0x0f0018
+#define EN8811H_FW_CTRL_1_START		0x0
+#define EN8811H_FW_CTRL_1_FINISH	0x1
+#define EN8811H_FW_CTRL_2		0x800000
+#define EN8811H_FW_CTRL_2_LOADING	BIT(11)
+#define EN8811H_PHY_FW_STATUS		0x8009
+#define EN8811H_PHY_READY		0x02
+#define AIR_PHY_FW_STATUS		0x8009
+#define AIR_PHY_READY			0x02
+
+#define AIR_PHY_FW_CTRL_1		0x0f0018
+#define AIR_PHY_FW_CTRL_1_START		0x0
+#define AIR_PHY_FW_CTRL_1_FINISH	0x1
+
+/* EN8811H */
+#define EN8811H_PHY_ID			0x03a2a411
+#define EN8811H_MD32_DM_SIZE		0x4000
+#define EN8811H_MD32_DSP_SIZE		0x20000
 #define EN8811H_FW_VERSION		0x3b3c
 
 #define EN8811H_POLARITY		0xca0f8
 #define EN8811H_POLARITY_TX_NORMAL	BIT(0)
 #define EN8811H_POLARITY_RX_REVERSE	BIT(1)
-
 #define EN8811H_CLK_CGM			0xcf958
 #define EN8811H_CLK_CGM_CKO		BIT(26)
 #define EN8811H_HWTRAP1			0xcf914
 #define EN8811H_HWTRAP1_CKO		BIT(12)
 
-#define clear_bit(bit, bitmap)	__clear_bit(bit, bitmap)
-
-/* Led definitions */
-#define EN8811H_LED_COUNT	3
+/* AN8811HB */
+#define AN8811HB_PHY_ID			0xc0ff04a0
+#define AIR_MD32_DM_SIZE		0x8000
+#define AIR_MD32_DSP_SIZE		0x20000
+#define AIR_PHY_MD32FW_VERSION		0x3b3c
+
+#define AN8811HB_GPIO_OUTPUT		0x5cf8b8
+#define AN8811HB_GPIO_OUTPUT_MASK	GENMASK(15, 0)
+#define AN8811HB_GPIO_OUTPUT_345	(BIT(3) | BIT(4) | BIT(5))
+#define AN8811HB_GPIO_OUTPUT_0115	(BIT(0) | BIT(1) | BIT(15))
+#define AN8811HB_GPIO_SEL_1		0x5cf8bc
+#define AN8811HB_GPIO_SEL_1_0_MASK	GENMASK(2, 0)
+#define AN8811HB_GPIO_SEL_1_1_MASK	GENMASK(6, 4)
+#define AN8811HB_GPIO_SEL_1_0		FIELD_PREP(AN8811HB_GPIO_SEL_1_0_MASK, 1)
+#define AN8811HB_GPIO_SEL_1_1		FIELD_PREP(AN8811HB_GPIO_SEL_1_1_MASK, 0)
+#define AN8811HB_GPIO_SEL_2		0x5cf8c0
+#define AN8811HB_GPIO_SEL_2_15_MASK	GENMASK(30, 28)
+#define AN8811HB_GPIO_SEL_2_15		FIELD_PREP(AN8811HB_GPIO_SEL_2_15_MASK, 2)
+
+#define AN8811HB_CRC_PM_SET1		0xf020c
+#define AN8811HB_CRC_PM_MON2		0xf0218
+#define AN8811HB_CRC_PM_MON3		0xf021c
+#define AN8811HB_CRC_DM_SET1		0xf0224
+#define AN8811HB_CRC_DM_MON2		0xf0230
+#define AN8811HB_CRC_DM_MON3		0xf0234
+#define AN8811HB_CRC_RD_EN		BIT(0)
+#define AN8811HB_CRC_ST			(BIT(0) | BIT(1))
+#define AN8811HB_CRC_CHECK_PASS		BIT(0)
+
+#define AN8811HB_TX_POLARITY		0x5ce004
+#define AN8811HB_TX_POLARITY_NORMAL	BIT(7)
+#define AN8811HB_RX_POLARITY		0x5ce61c
+#define AN8811HB_RX_POLARITY_NORMAL	BIT(7)
+
+#define AN8811HB_HWTRAP1		0x5cf910
+#define AN8811HB_HWTRAP2		0x5cf914
+#define AN8811HB_HWTRAP2_CKO		BIT(28)
+#define AN8811HB_HWTRAP2_PKG		(BIT(12) | BIT(13) | BIT(14))
+#define AN8811HB_PRO_ID			0x5cf920
+#define AN8811HB_PRO_ID_VERSION		GENMASK(3, 0)
+
+#define AN8811HB_CLK_DRV		0x5cf9e4
+#define AN8811HB_CLK_DRV_CKO_MASK	GENMASK(14, 12)
+#define AN8811HB_CLK_DRV_CKOPWD		BIT(12)
+#define AN8811HB_CLK_DRV_CKO_LDPWD	BIT(13)
+#define AN8811HB_CLK_DRV_CKO_LPPWD	BIT(14)
+
+#define AN8811HB_MCU_SW_RST		0x5cf9f8
+#define AN8811HB_MCU_SW_RST_HOLD	BIT(16)
+#define AN8811HB_MCU_SW_RST_RUN		(BIT(16) | BIT(0))
+#define AN8811HB_MCU_SW_START		0x5cf9fc
+#define AN8811HB_MCU_SW_START_EN	BIT(16)
+
+#define clear_bit(bit, bitmap)		__clear_bit(bit, bitmap)
+
+#define SCRIPT_NAME(name)		#name "_load_firmware"
 
 struct led {
 	unsigned long rules;
@@ -191,11 +271,48 @@ enum air_led_trigger_netdev_modes {
 #define AIR_PHY_LED_DUR (AIR_PHY_LED_DUR_UNIT << AIR_PHY_LED_DUR_BLINK_64MS)
 
 struct en8811h_priv {
-	int firmware_version;
+	u32		firmware_version;
 	bool		mcu_needs_restart;
 	struct led	led[EN8811H_LED_COUNT];
+	u32		pro_id;
+	u32		pkg_sel;
+	u32		mem_size;
+	const char	*script_name;
 };
 
+static int air_pbus_reg_write(struct phy_device *phydev,
+			      u32 pbus_reg, u32 pbus_data)
+{
+	int pbus_addr = (phydev->addr) + 8;
+	struct mii_dev *bus = phydev->bus;
+	int ret;
+
+	ret = bus->write(bus, pbus_addr, MDIO_DEVAD_NONE,
+			 AIR_EXT_PAGE_ACCESS,
+			 (pbus_reg >> 16));
+	if (ret < 0)
+		return ret;
+
+	ret = bus->write(bus, pbus_addr, MDIO_DEVAD_NONE,
+			 AIR_PBUS_MODE_ADDR_HIGH,
+			 ((pbus_reg & GENMASK(15, 6)) >> 6));
+	if (ret < 0)
+		return ret;
+
+	ret = bus->write(bus, pbus_addr, MDIO_DEVAD_NONE,
+			 ((pbus_reg & GENMASK(5, 2)) >> 2),
+			 (pbus_data & GENMASK(15, 0)));
+	if (ret < 0)
+		return ret;
+
+	ret = bus->write(bus, pbus_addr, MDIO_DEVAD_NONE, 0x10,
+			 ((pbus_data & GENMASK(31, 16)) >> 16));
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
 static int air_buckpbus_reg_write(struct phy_device *phydev,
 				  u32 pbus_address, u32 pbus_data)
 {
@@ -359,8 +476,8 @@ restore_page:
 static int air_write_buf(struct phy_device *phydev, unsigned long address,
 			 unsigned long array_size, const unsigned char *buffer)
 {
-	unsigned int offset;
 	int ret, saved_page;
+	u32 offset;
 	u16 val;
 
 	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
@@ -419,18 +536,144 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 	return ret;
 }
 
-int en8811h_read_fw(void **fw, size_t *fwsize)
+static int an8811hb_check_crc(struct phy_device *phydev,
+			      u32 set1, u32 mon2, u32 mon3)
+{
+	int ret, retry = 10;
+	u32 pbus_value;
+
+	/* Configure CRC */
+	ret = air_buckpbus_reg_modify(phydev, set1, AN8811HB_CRC_RD_EN,
+				      AN8811HB_CRC_RD_EN);
+	if (ret < 0)
+		return ret;
+
+	ret = air_buckpbus_reg_read(phydev, set1, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	debug("%d: reg 0x%x val 0x%x!\n", __LINE__, set1, pbus_value);
+
+	do {
+		mdelay(300);
+
+		ret = air_buckpbus_reg_read(phydev, mon2, &pbus_value);
+		if (ret < 0)
+			return ret;
+
+		debug("%d: reg 0x%x val 0x%x!\n", __LINE__, mon2, pbus_value);
+
+		if (pbus_value & AN8811HB_CRC_ST) {
+			ret = air_buckpbus_reg_read(phydev, mon3, &pbus_value);
+			if (ret < 0)
+				return ret;
+
+			debug("%d: reg 0x%x val 0x%x!\n", __LINE__, mon3,
+			      pbus_value);
+
+			if (pbus_value & AN8811HB_CRC_CHECK_PASS)
+				debug("CRC Check PASS!\n");
+			else
+				dev_err(phydev->dev, "CRC Check FAIL!(0x%lx)\n",
+					pbus_value & AN8811HB_CRC_CHECK_PASS);
+
+			break;
+		}
+
+		if (!retry) {
+			dev_err(phydev->dev,
+				"CRC Check is not ready.(Status %u)\n",
+				pbus_value);
+			return -ENODEV;
+		}
+	} while (--retry);
+
+	ret = air_buckpbus_reg_modify(phydev, set1, AN8811HB_CRC_RD_EN, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = air_buckpbus_reg_read(phydev, set1, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	debug("%d: reg 0x%x val 0x%x!\n", __LINE__, set1, pbus_value);
+
+	return ret;
+}
+
+static int an8811hb_mcu_assert(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
+				 AN8811HB_MCU_SW_RST_HOLD);
+	if (ret < 0)
+		return ret;
+
+	ret = air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
+	if (ret < 0)
+		return ret;
+
+	debug("MCU asserted\n");
+	mdelay(50);
+
+	return ret;
+}
+
+static int an8811hb_mcu_deassert(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START,
+				 AN8811HB_MCU_SW_START_EN);
+	if (ret < 0)
+		return ret;
+
+	ret = air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
+				 AN8811HB_MCU_SW_RST_RUN);
+	if (ret < 0)
+		return ret;
+
+	debug("MCU deasserted\n");
+	mdelay(50);
+
+	return ret;
+}
+
+static int an8811hb_surge_protect_cfg(struct phy_device *phydev)
+{
+	ofnode node = phy_get_ofnode(phydev);
+	int ret = 0;
+
+	if (!ofnode_read_bool(node, "airoha,surge-5r")) {
+		debug("Surge Protection mode - 0R\n");
+		return ret;
+	}
+
+	ret = air_buckpbus_reg_modify(phydev, AIR_PHY_CONTROL,
+				      AIR_PHY_CONTROL_SURGE_5R,
+				      AIR_PHY_CONTROL_SURGE_5R);
+	if (ret < 0)
+		return ret;
+
+	debug("Surge Protection mode - 5R\n");
+
+	return ret;
+}
+
+static int en8811h_read_fw(void **fw, size_t *fwsize, struct en8811h_priv *priv)
 {
+	const char *script_name = priv->script_name;
+	u32 mem_size = priv->mem_size;
 	void *buffer;
 	int ret;
 
-	buffer = malloc(EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
+	buffer = malloc(mem_size);
 	if (!buffer)
 		return -ENOMEM;
 
-	ret = request_firmware_into_buf_via_script(buffer,
-						   EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE,
-						   "en8811h_load_firmware", fwsize);
+	ret = request_firmware_into_buf_via_script(buffer, mem_size,
+						   script_name, fwsize);
 	if (ret) {
 		free(buffer);
 		return ret;
@@ -450,7 +693,10 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	void *buffer;
 	int ret;
 
-	ret = en8811h_read_fw(&buffer, &fw_size);
+	priv->script_name = SCRIPT_NAME(en8811h);
+	priv->mem_size = EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE;
+
+	ret = en8811h_read_fw(&buffer, &fw_size, priv);
 	if (ret < 0) {
 		dev_err(phydev->dev, "Failed to get firmware data\n");
 		return -EINVAL;
@@ -496,9 +742,12 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 		goto en8811h_load_firmware_out;
 
 	ret = en8811h_wait_mcu_ready(phydev);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
 
 	air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
 			      &priv->firmware_version);
+
 	dev_info(phydev->dev, "MD32 firmware version: %08x\n",
 		 priv->firmware_version);
 
@@ -510,6 +759,130 @@ en8811h_load_firmware_out:
 	return ret;
 }
 
+static int an8811hb_load_firmware(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret, retry = 10;
+	size_t fw_size;
+	void *buffer;
+	u32 reg_val;
+
+	ret = an8811hb_mcu_assert(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = an8811hb_mcu_deassert(phydev);
+	if (ret < 0)
+		return ret;
+
+	priv->script_name = SCRIPT_NAME(an8811hb);
+	priv->mem_size = AIR_MD32_DM_SIZE + AIR_MD32_DSP_SIZE;
+
+	ret = en8811h_read_fw(&buffer, &fw_size, priv);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = air_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
+				     AIR_PHY_FW_CTRL_1_START);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, AIR_MD32_DM_SIZE,
+			    (unsigned char *)buffer);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = an8811hb_check_crc(phydev, AN8811HB_CRC_DM_SET1,
+				 AN8811HB_CRC_DM_MON2, AN8811HB_CRC_DM_MON3);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, AIR_MD32_DSP_SIZE,
+			    (unsigned char *)buffer + AIR_MD32_DM_SIZE);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = an8811hb_check_crc(phydev, AN8811HB_CRC_PM_SET1,
+				 AN8811HB_CRC_PM_MON2, AN8811HB_CRC_PM_MON3);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = air_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
+				     AIR_PHY_FW_CTRL_1_FINISH);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = an8811hb_surge_protect_cfg(phydev);
+	if (ret < 0) {
+		dev_err(phydev->dev, "an8811hb_surge_protect_cfg fail. (ret=%d)\n", ret);
+		goto an8811hb_load_firmware_out;
+	}
+
+	do {
+		mdelay(300);
+
+		ret = air_buckpbus_reg_read(phydev, AIR_PHY_FW_CTRL_1, &reg_val);
+		if (ret < 0)
+			goto an8811hb_load_firmware_out;
+
+		if (reg_val == AIR_PHY_FW_CTRL_1_FINISH)
+			break;
+
+		debug("%d: reg 0x%x val 0x%x!\n", __LINE__, AIR_PHY_FW_CTRL_1,
+		      reg_val);
+
+		ret = air_buckpbus_reg_write(phydev, AIR_PHY_FW_CTRL_1,
+					     AIR_PHY_FW_CTRL_1_FINISH);
+		if (ret < 0)
+			goto an8811hb_load_firmware_out;
+
+	} while (--retry);
+
+	ret = en8811h_wait_mcu_ready(phydev);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	air_buckpbus_reg_read(phydev, AIR_PHY_MD32FW_VERSION,
+			      &priv->firmware_version);
+
+	debug("MD32 firmware version: %08x\n", priv->firmware_version);
+
+an8811hb_load_firmware_out:
+	free(buffer);
+	if (ret < 0)
+		dev_err(phydev->dev, "Firmware loading failed: %d\n", ret);
+
+	return ret;
+}
+
+int an8811hb_cko_cfg(struct phy_device *phydev)
+{
+	ofnode node = phy_get_ofnode(phydev);
+	u32 pbus_value;
+	int ret = 0;
+
+	if (!ofnode_read_bool(node, "airoha,phy-output-clock")) {
+		ret = air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+					      AN8811HB_CLK_DRV_CKO_MASK,
+					      AN8811HB_CLK_DRV_CKOPWD    |
+					      AN8811HB_CLK_DRV_CKO_LDPWD |
+					      AN8811HB_CLK_DRV_CKO_LPPWD);
+		if (ret < 0)
+			return ret;
+
+		debug("CKO Output mode - Disabled\n");
+	} else {
+		ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
+		if (ret < 0)
+			return ret;
+
+		debug("CKO Output %dMHz - Enabled\n",
+		      (pbus_value & AN8811HB_HWTRAP2_CKO) ? 50 : 25);
+	}
+
+	return ret;
+}
+
 static int en8811h_restart_mcu(struct phy_device *phydev)
 {
 	int ret;
@@ -613,13 +986,30 @@ static int air_led_init(struct phy_device *phydev, u8 index, u8 state, u8 pol)
 	return 0;
 }
 
+/**
+ * air_leds_init - Initialize and configure LEDs for a phy device.
+ *
+ * @phydev: Pointer to the phy_device structure.
+ * @num: Number of LEDs to initialize.
+ * @dur: Duration for LED blink in milliseconds. It sets the duration
+ *       for both the ON and OFF periods (OFF period will be half of `dur`).
+ * @mode: LED operation mode. Supported modes are:
+ *           - AIR_LED_MODE_DISABLE: Disables LED control.
+ *           - AIR_LED_MODE_USER_DEFINE: Enables user-defined LED control.
+ *
+ * Initializes and configures LEDs on a phy device with a specified blink duration
+ * and mode. Supports disabling or enabling user-defined control.
+ * Return:
+ * On success, returns 0. On error, it returns a negative value that denotes
+ * the error code.
+ */
+
 static int air_leds_init(struct phy_device *phydev, int num, u16 dur, int mode)
 {
 	struct en8811h_priv *priv = phydev->priv;
 	int ret, i;
 
-	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_BLINK,
-			    dur);
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_BLINK, dur);
 	if (ret < 0)
 		return ret;
 
@@ -707,10 +1097,121 @@ static int en8811h_config(struct phy_device *phydev)
 		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
 	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
 				      EN8811H_POLARITY_RX_REVERSE |
-				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
+				      EN8811H_POLARITY_TX_NORMAL,
+				      pbus_value);
+	if (ret < 0)
+		return ret;
+
+	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
+			    AIR_LED_MODE_USER_DEFINE);
+	if (ret < 0) {
+		dev_err(phydev->dev, "Failed to disable leds: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int an8811hb_config(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	u32 pbus_value = 0;
+	ofnode node;
+	int ret = 0;
+
+	node = phy_get_ofnode(phydev);
+	if (!ofnode_valid(node))
+		return 0;
+
+	/* If restart happened in .probe(), no need to restart now */
+	if (priv->mcu_needs_restart) {
+		ret = an8811hb_mcu_assert(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = an8811hb_mcu_deassert(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = en8811h_restart_mcu(phydev);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = an8811hb_load_firmware(phydev);
+		if (ret) {
+			dev_err(phydev->dev, "Load firmware fail.\n");
+			return ret;
+		}
+		/* Next calls to .config() mcu needs to restart */
+		priv->mcu_needs_restart = true;
+	}
+
+	ret = air_buckpbus_reg_read(phydev, AN8811HB_PRO_ID, &pbus_value);
+	if (ret < 0)
+		return ret;
+	priv->pro_id = (pbus_value & AN8811HB_PRO_ID_VERSION) + 1;
+
+	ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
+	if (ret < 0)
+		return ret;
+	priv->pkg_sel = (pbus_value & AN8811HB_HWTRAP2_PKG) >> 12;
+	debug("%s(%d) Version: E%d\n",
+	      priv->pkg_sel ? "AN8811HBCN" : "AN8811HBN", priv->pkg_sel,
+	      priv->pro_id);
+
+	/* Serdes polarity */
+	pbus_value = 0;
+	if (ofnode_read_bool(node, "airoha,pnswap-rx"))
+		pbus_value &= ~AN8811HB_RX_POLARITY_NORMAL;
+	else
+		pbus_value |= AN8811HB_RX_POLARITY_NORMAL;
+
+	debug("1 pbus_value 0x%x\n", pbus_value);
+	ret = air_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
+				      AN8811HB_RX_POLARITY_NORMAL, pbus_value);
+	if (ret < 0)
+		return ret;
+
+	pbus_value = 0;
+	if (ofnode_read_bool(node, "airoha,pnswap-tx"))
+		pbus_value &= ~AN8811HB_TX_POLARITY_NORMAL;
+	else
+		pbus_value |= AN8811HB_TX_POLARITY_NORMAL;
+
+	debug("2 pbus_value 0x%x\n", pbus_value);
+	ret = air_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
+				      AN8811HB_TX_POLARITY_NORMAL, pbus_value);
 	if (ret < 0)
 		return ret;
 
+	/* Configure led gpio pins as output */
+	if (priv->pkg_sel) {
+		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+					      AN8811HB_GPIO_OUTPUT_MASK,
+					      AN8811HB_GPIO_OUTPUT_0115);
+		if (ret < 0)
+			return ret;
+		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_1,
+					      AN8811HB_GPIO_SEL_1_0_MASK |
+					      AN8811HB_GPIO_SEL_1_1_MASK,
+					      AN8811HB_GPIO_SEL_1_0 |
+					      AN8811HB_GPIO_SEL_1_1);
+		if (ret < 0)
+			return ret;
+
+		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_2,
+					      AN8811HB_GPIO_SEL_2_15_MASK,
+					      AN8811HB_GPIO_SEL_2_15);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+					      AN8811HB_GPIO_OUTPUT_345,
+					      AN8811HB_GPIO_OUTPUT_345);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
 			    AIR_LED_MODE_USER_DEFINE);
 	if (ret < 0) {
@@ -718,9 +1219,91 @@ static int en8811h_config(struct phy_device *phydev)
 		return ret;
 	}
 
+	/* Co-Clock Output */
+	ret = an8811hb_cko_cfg(phydev);
+	if (ret)
+		return ret;
+
+	printf("AN8811HB initialize OK !\n");
+
+	return 0;
+}
+
+static int an8811hb_update_duplex(struct phy_device *phydev)
+{
+	int lpa;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		lpa = phy_read(phydev, MDIO_DEVAD_NONE, MII_LPA);
+		if (lpa < 0)
+			return lpa;
+
+		switch (phydev->speed) {
+		case SPEED_2500:
+		case SPEED_1000:
+			phydev->duplex = DUPLEX_FULL;
+			break;
+		case SPEED_100:
+			phydev->duplex = (lpa & LPA_100FULL) ? DUPLEX_FULL :
+							       DUPLEX_HALF;
+			break;
+		case SPEED_10:
+			phydev->duplex = (lpa & LPA_10FULL) ? DUPLEX_FULL :
+							      DUPLEX_HALF;
+			break;
+		}
+	} else {
+		int bmcr = phy_read(phydev, MDIO_DEVAD_NONE, MII_BMCR);
+
+		if (phydev->speed == SPEED_2500)
+			phydev->duplex = DUPLEX_FULL;
+		else
+			phydev->duplex = (bmcr & BMCR_FULLDPLX) ? DUPLEX_FULL :
+								  DUPLEX_HALF;
+	}
+
 	return 0;
 }
 
+static int an8811hb_parse_status(struct phy_device *phydev)
+{
+	int ret = 0, reg_value;
+
+	reg_value = phy_read(phydev, MDIO_DEVAD_NONE, AIR_AUX_CTRL_STATUS);
+	if (reg_value < 0)
+		return reg_value;
+
+	switch (reg_value & AIR_AUX_CTRL_STATUS_SPEED_MASK) {
+	case AIR_AUX_CTRL_STATUS_SPEED_2500:
+		phydev->speed = SPEED_2500;
+		break;
+	case AIR_AUX_CTRL_STATUS_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		break;
+	case AIR_AUX_CTRL_STATUS_SPEED_100:
+		phydev->speed = SPEED_100;
+		break;
+	case AIR_AUX_CTRL_STATUS_SPEED_10:
+		phydev->speed = SPEED_10;
+		break;
+	default:
+		dev_err(phydev->dev,
+			"Auto-neg error, defaulting to 2500M/FD\n");
+		phydev->speed = SPEED_2500;
+		phydev->duplex = DUPLEX_FULL;
+		return 0;
+	}
+
+	/* Update duplex mode based on speed and negotiation status */
+	ret = an8811hb_update_duplex(phydev);
+	if (ret < 0)
+		return ret;
+
+	debug("Speed: %d, %s duplex\n", phydev->speed,
+	      (phydev->duplex) ? "full" : "half");
+	return ret;
+}
+
 static int en8811h_parse_status(struct phy_device *phydev)
 {
 	int ret = 0, reg_value;
@@ -742,7 +1325,8 @@ static int en8811h_parse_status(struct phy_device *phydev)
 		phydev->speed = SPEED_100;
 		break;
 	default:
-		dev_err(phydev->dev, "Auto-neg error, defaulting to 2500M/FD\n");
+		dev_err(phydev->dev,
+			"Auto-neg error, defaulting to 2500M/FD\n");
 		phydev->speed = SPEED_2500;
 		break;
 	}
@@ -752,24 +1336,35 @@ static int en8811h_parse_status(struct phy_device *phydev)
 
 static int en8811h_startup(struct phy_device *phydev)
 {
+	u32 phy_id = phydev->phy_id;
 	int ret = 0;
 
 	ret = genphy_update_link(phydev);
 	if (ret)
 		return ret;
 
-	return en8811h_parse_status(phydev);
+	if (phy_id == EN8811H_PHY_ID)
+		ret = en8811h_parse_status(phydev);
+	else if (phy_id == AN8811HB_PHY_ID)
+		ret = an8811hb_parse_status(phydev);
+
+	return ret;
 }
 
 static int en8811h_probe(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv;
+	int phy_id;
 
 	priv = malloc(sizeof(*priv));
 	if (!priv)
 		return -ENOMEM;
 	memset(priv, 0, sizeof(*priv));
 
+	debug("%s driver is probed.\n", phydev->drv->name);
+	get_phy_id(phydev->bus, phydev->addr, MDIO_DEVAD_NONE, &phy_id);
+	debug("phy id is 0x%x.\n", phy_id);
+
 	priv->led[0].rules = AIR_DEFAULT_TRIGGER_LED0;
 	priv->led[1].rules = AIR_DEFAULT_TRIGGER_LED1;
 	priv->led[2].rules = AIR_DEFAULT_TRIGGER_LED2;
@@ -782,12 +1377,12 @@ static int en8811h_probe(struct phy_device *phydev)
 	return 0;
 }
 
-static int en8811h_read_page(struct phy_device *phydev)
+static int air_phy_read_page(struct phy_device *phydev)
 {
 	return phy_read(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS);
 }
 
-static int en8811h_write_page(struct phy_device *phydev, int page)
+static int air_phy_write_page(struct phy_device *phydev, int page)
 {
 	return phy_write(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS, page);
 }
@@ -798,8 +1393,20 @@ U_BOOT_PHY_DRIVER(en8811h) = {
 	.mask = 0x0ffffff0,
 	.config = &en8811h_config,
 	.probe = &en8811h_probe,
-	.read_page = &en8811h_read_page,
-	.write_page = &en8811h_write_page,
+	.read_page = &air_phy_read_page,
+	.write_page = &air_phy_write_page,
+	.startup = &en8811h_startup,
+	.shutdown = &genphy_shutdown,
+};
+
+U_BOOT_PHY_DRIVER(an8811hb) = {
+	.name = "Airoha AN8811HB",
+	.uid = AN8811HB_PHY_ID,
+	.mask = 0x0ffffff0,
+	.config = &an8811hb_config,
+	.probe = &en8811h_probe,
+	.read_page = &air_phy_read_page,
+	.write_page = &air_phy_write_page,
 	.startup = &en8811h_startup,
 	.shutdown = &genphy_shutdown,
 };
-- 
2.43.0

base-commit: 8fd76675efbe7af785ccc1ba1ac8b9f7e10f6715
branch: next
