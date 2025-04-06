Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09D7C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388DE82B4A;
	Sun,  6 Apr 2025 17:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRqJmQqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0A882B5C; Sun,  6 Apr 2025 15:04:08 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F2282A96
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 15:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22423adf751so33246925ad.2
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743944642; x=1744549442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=03CStcEtF/l3lR+tkYxhmK7P+3Q/T/iXxb5kHr0Agk0=;
 b=BRqJmQqLwYBqlEb+uAgdTUmplvESZVIoK5eRPCjglxA0yjgHOBTy/0S7OK4V1l7eyq
 P4sZ48cwuV8Fvfc3bD3oI5a4Trs+GkmmKrDsXJiD8crUW/oVKnzPVH+KcWLAEANjshMy
 Ba6/R4WXD4XzUKQM2QwSf734nwOKLQPpufqvhk/Jc6EFvGOYE0Xo2xI9BWK6t8bfUWlq
 DDfwqT9DJkfPtuWaJub1DNRl8G7heRMak9IKvPhsgYt55Z5wYnuf6nSDYCq364vV7e2K
 8hbJI23RftM+KDWp6HuZj7EJWi+b4wbpK69KolGgogPZne1Dqoq5syj+u3+4etrnj2nh
 XgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743944642; x=1744549442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03CStcEtF/l3lR+tkYxhmK7P+3Q/T/iXxb5kHr0Agk0=;
 b=Vm42bP6jG4pBNIO78/+wuReugCb8+01NEpsu6nXv1ei3qnQuWgZh+cPwnxRZkEHU3Z
 MBX3DifTe3yKV1nQ2H9vk9be3441ypUeBDMQB7kPBJkikbkjBZGRWlnc/bHVlY+yVWbE
 AE8flSsLwO2mztSMHGrT+zmd0Q3+cnrB9iO3BcfBZi09g1szqpf/w6gDI+WhDbQgzutJ
 CANSdRuGR+1BpBN3M6INLhwIt8MlaLGrYshJDA+4i/9ga8VNl1BpUQ0ByXBI1D2Vod8p
 cvXv4pVsV8XBJB29LZolLM3N4uSVa8CH8whV1B+Cr/VO8FwQ1o4UhvWlfm8dDZAwEXOk
 ikSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNhaa+2B1WgXwUGs57PkYxQ5Xu7XzgTXZff87UcnICEoJ3q2dNJNGa4J3Ibemg4zKe7/xjvoI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+7uwqyEFkJiUyz18uEqp028IrSkGBzFdvDu2EScMAtggEq3+e
 IxJhaR8u4SZtiHeFugd3GZoPGmkd5c+h75fHtQumIz+EPPG/75l5D9s1ig==
X-Gm-Gg: ASbGncsP83R9RHUJkFs7c1ELZkxx5XFBTrwRiJq2p0u6t8LSgS8/Fzq+tf8cXfkEvYF
 7jtkuWq/ZgvH5uCfh55ePWP3tmQo9FfpOJFzzLR9F/n+y0UUC2BcQmIbcy3jw60yA+WJ2pt1TLC
 p5oZfuJwFtiXG5EzDxrGDRWkSqd0317Apz7My6CslLnXqER4LVWr8dq5+KlfcteGPNCuoEwc8Fu
 IOU2z/Zk4S7lN6wl9i9RyTicdCdrG1k5+LDTZp1tyUzVeKr3t17S0hsscmJLAkX8CZYFQKQ7NeB
 jnb942WH/FNvlYJSyUY+k7F2zyvOuKBjOX9DtNzqzc/CNNWXjMon8muDVSr5ojnA2cXN7JC5JoV
 ii9LnwwnaXizRWG+58Hkhi5Mvcncfl6MfG+lrCfed
X-Google-Smtp-Source: AGHT+IGtCkcQzeDmDIglzs0JWjcrqh1DwZkq9wKxUsVfNy4kAt7sagi0oWaXvKoG0jCgv72BDPWlSw==
X-Received: by 2002:a17:903:3bc6:b0:224:18b0:86a0 with SMTP id
 d9443c01a7336-22a8a0a3957mr125410275ad.37.1743944642179; 
 Sun, 06 Apr 2025 06:04:02 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c279csm63344425ad.94.2025.04.06.06.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 06:04:01 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, lucienzx159@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com
Subject: [PATCH 1/1] net: phy: Add the Airoha EN8811H PHY driver
Date: Sun,  6 Apr 2025 21:02:44 +0800
Message-Id: <20250406130244.19496-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 06 Apr 2025 17:37:08 +0200
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

Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
100/1000/2500 Mbps with auto negotiation only.

The driver uses two firmware files, for which updated versions are added to
linux-firmware already.

Based on the Linux upstream 8811 driver code(air_en8811h.c),
I have modified the relevant process to align with the U-Boot boot sequence.
and have validated this on Banana Pi BPI-R3 Mini.

The MD32 FW is currently stored in eMMC partition 1 on Banana Pi BPI-R3 Mini,
and it is loaded from there.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/net/phy/Kconfig       |  34 ++
 drivers/net/phy/Makefile      |   1 +
 drivers/net/phy/air_en8811h.c | 783 ++++++++++++++++++++++++++++++++++
 3 files changed, 818 insertions(+)
 create mode 100644 drivers/net/phy/air_en8811h.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3132718e4f8..5b4cf30b0a3 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -79,6 +79,40 @@ config PHY_ADIN
 	help
 		Add support for configuring RGMII on Analog Devices ADIN PHYs.
 
+menuconfig PHY_AIROHA
+	bool "Airoha Ethernet PHYs support"
+
+config PHY_AIROHA_EN8811H
+	bool "Airoha Ethernet EN8811H support"
+	depends on PHY_AIROHA
+	help
+		AIROHA EN8811H supported.
+
+choice
+	prompt "Location of the Airoha PHY firmware"
+	default PHY_AIROHA_FW_IN_MMC
+	depends on PHY_AIROHA_EN8811H
+
+config PHY_AIROHA_FW_IN_MMC
+	bool "Airoha firmware in MMC boot1 partition"
+
+endchoice
+
+config AIROHA_FW_ADDR
+	hex "Airoha Firmware Address"
+	depends on PHY_AIROHA_EN8811H
+	default 0x0
+
+config AIROHA_MD32_DM_SIZE
+	hex "Airoha Firmware MD32 DM Size"
+	depends on PHY_AIROHA_EN8811H
+	default 0x4000
+
+config AIROHA_MD32_DSP_SIZE
+	hex "Airoha Firmware MD32 DSP Size"
+	depends on PHY_AIROHA_EN8811H
+	default 0x20000
+
 menuconfig PHY_AQUANTIA
 	bool "Aquantia Ethernet PHYs support"
 	select PHY_GIGE
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 2487f366e1c..87dee3c15b9 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MV88E6352_SWITCH) += mv88e6352.o
 obj-$(CONFIG_PHYLIB) += phy.o
 obj-$(CONFIG_PHYLIB_10G) += generic_10g.o
 obj-$(CONFIG_PHY_ADIN) += adin.o
+obj-$(CONFIG_PHY_AIROHA_EN8811H) += air_en8811h.o
 obj-$(CONFIG_PHY_AQUANTIA) += aquantia.o
 obj-$(CONFIG_PHY_ATHEROS) += atheros.o
 obj-$(CONFIG_PHY_BROADCOM) += broadcom.o
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
new file mode 100644
index 00000000000..96bb24418a0
--- /dev/null
+++ b/drivers/net/phy/air_en8811h.c
@@ -0,0 +1,783 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for the Airoha EN8811H 2.5 Gigabit PHY.
+ *
+ * Limitations of the EN8811H:
+ * - Only full duplex supported
+ * - Forced speed (AN off) is not supported by hardware (100Mbps)
+ *
+ * Source originated from linux air_en8811h.c
+ *
+ * Copyright (C) 2025 Airoha Technology Corp.
+ */
+#include <phy.h>
+#include <errno.h>
+#include <malloc.h>
+#include <asm/unaligned.h>
+#include <linux/iopoll.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <mmc.h>
+
+#define EN8811H_PHY_ID		0x03a2a411
+
+#define AIR_FW_ADDR_DM	0x00000000
+#define AIR_FW_ADDR_DSP	0x00100000
+
+#define EN8811H_MD32_DM_SIZE	0x4000
+#define EN8811H_MD32_DSP_SIZE	0x20000
+
+ #define	EN8811H_FW_CTRL_1		0x0f0018
+ #define	EN8811H_FW_CTRL_1_START		0x0
+ #define	EN8811H_FW_CTRL_1_FINISH	0x1
+ #define	EN8811H_FW_CTRL_2		0x800000
+ #define	EN8811H_FW_CTRL_2_LOADING	BIT(11)
+
+ /* MII Registers */
+ #define AIR_AUX_CTRL_STATUS		0x1d
+ #define   AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
+ #define   AIR_AUX_CTRL_STATUS_SPEED_100		0x4
+ #define   AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
+ #define   AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
+
+#define AIR_EXT_PAGE_ACCESS		0x1f
+#define   AIR_PHY_PAGE_STANDARD			0x0000
+#define   AIR_PHY_PAGE_EXTENDED_4		0x0004
+
+/* MII Registers Page 4*/
+#define AIR_BPBUS_MODE			0x10
+#define   AIR_BPBUS_MODE_ADDR_FIXED		0x0000
+#define   AIR_BPBUS_MODE_ADDR_INCR		BIT(15)
+#define AIR_BPBUS_WR_ADDR_HIGH		0x11
+#define AIR_BPBUS_WR_ADDR_LOW		0x12
+#define AIR_BPBUS_WR_DATA_HIGH		0x13
+#define AIR_BPBUS_WR_DATA_LOW		0x14
+#define AIR_BPBUS_RD_ADDR_HIGH		0x15
+#define AIR_BPBUS_RD_ADDR_LOW		0x16
+#define AIR_BPBUS_RD_DATA_HIGH		0x17
+#define AIR_BPBUS_RD_DATA_LOW		0x18
+
+/* Registers on MDIO_MMD_VEND1 */
+#define EN8811H_PHY_FW_STATUS		0x8009
+#define   EN8811H_PHY_READY			0x02
+
+/* Registers on MDIO_MMD_VEND2 */
+#define AIR_PHY_LED_BCR			0x021
+#define   AIR_PHY_LED_BCR_MODE_MASK		GENMASK(1, 0)
+#define   AIR_PHY_LED_BCR_TIME_TEST		BIT(2)
+#define   AIR_PHY_LED_BCR_CLK_EN		BIT(3)
+#define   AIR_PHY_LED_BCR_EXT_CTRL		BIT(15)
+
+#define AIR_PHY_LED_DUR_ON		0x022
+
+#define AIR_PHY_LED_DUR_BLINK		0x023
+
+#define AIR_PHY_LED_ON(i)	       (0x024 + ((i) * 2))
+#define   AIR_PHY_LED_ON_MASK			(GENMASK(6, 0) | BIT(8))
+#define   AIR_PHY_LED_ON_LINK1000		BIT(0)
+#define   AIR_PHY_LED_ON_LINK100		BIT(1)
+#define   AIR_PHY_LED_ON_LINK10			BIT(2)
+#define   AIR_PHY_LED_ON_LINKDOWN		BIT(3)
+#define   AIR_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
+#define   AIR_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
+#define   AIR_PHY_LED_ON_FORCE_ON		BIT(6)
+#define   AIR_PHY_LED_ON_LINK2500		BIT(8)
+#define   AIR_PHY_LED_ON_POLARITY		BIT(14)
+#define   AIR_PHY_LED_ON_ENABLE			BIT(15)
+
+#define AIR_PHY_LED_BLINK(i)	       (0x025 + ((i) * 2))
+#define   AIR_PHY_LED_BLINK_1000TX		BIT(0)
+#define   AIR_PHY_LED_BLINK_1000RX		BIT(1)
+#define   AIR_PHY_LED_BLINK_100TX		BIT(2)
+#define   AIR_PHY_LED_BLINK_100RX		BIT(3)
+#define   AIR_PHY_LED_BLINK_10TX		BIT(4)
+#define   AIR_PHY_LED_BLINK_10RX		BIT(5)
+#define   AIR_PHY_LED_BLINK_COLLISION		BIT(6)
+#define   AIR_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
+#define   AIR_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
+#define   AIR_PHY_LED_BLINK_FORCE_BLINK		BIT(9)
+#define   AIR_PHY_LED_BLINK_2500TX		BIT(10)
+#define   AIR_PHY_LED_BLINK_2500RX		BIT(11)
+
+#define EN8811H_FW_VERSION		0x3b3c
+
+#define EN8811H_POLARITY		0xca0f8
+#define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
+#define   EN8811H_POLARITY_RX_REVERSE		BIT(1)
+
+#define EN8811H_CLK_CGM		0xcf958
+#define   EN8811H_CLK_CGM_CKO		BIT(26)
+#define EN8811H_HWTRAP1		0xcf914
+#define   EN8811H_HWTRAP1_CKO		BIT(12)
+
+#define air_upper_16_bits(n) ((u16)((n) >> 16))
+#define air_lower_16_bits(n) ((u16)((n) & 0xffff))
+
+/* Led definitions */
+#define EN8811H_LED_COUNT	3
+
+/* Default LED setup:
+ * GPIO5 <-> LED0  On: Link detected
+ * GPIO4 <-> LED1  On: Link detected at 2500 and 1000 Mbps
+ * GPIO3 <-> LED2  On: Link detected at 2500 and  100 Mbps
+ */
+#define AIR_DEFAULT_TRIGGER_LED0 (AIR_PHY_LED_ON_LINK2500 | \
+				  AIR_PHY_LED_ON_LINK1000 | \
+				  AIR_PHY_LED_ON_LINK100)
+#define AIR_DEFAULT_TRIGGER_LED1 (AIR_PHY_LED_ON_LINK2500 | \
+				  AIR_PHY_LED_ON_LINK1000 | \
+				  AIR_PHY_LED_BLINK_2500TX | \
+				  AIR_PHY_LED_BLINK_2500RX | \
+				  AIR_PHY_LED_BLINK_1000TX | \
+				  AIR_PHY_LED_BLINK_1000RX)
+#define AIR_DEFAULT_TRIGGER_LED2 (AIR_PHY_LED_ON_LINK2500 | \
+				  AIR_PHY_LED_ON_LINK100 | \
+				  AIR_PHY_LED_BLINK_2500TX | \
+				  AIR_PHY_LED_BLINK_2500RX | \
+				  AIR_PHY_LED_BLINK_100TX | \
+				  AIR_PHY_LED_BLINK_100RX)
+
+struct led {
+	unsigned long rules;
+};
+
+enum {
+	AIR_PHY_LED_DUR_BLINK_32MS,
+	AIR_PHY_LED_DUR_BLINK_64MS,
+	AIR_PHY_LED_DUR_BLINK_128MS,
+	AIR_PHY_LED_DUR_BLINK_256MS,
+	AIR_PHY_LED_DUR_BLINK_512MS,
+	AIR_PHY_LED_DUR_BLINK_1024MS,
+};
+
+enum {
+	AIR_LED_DISABLE,
+	AIR_LED_ENABLE,
+};
+
+enum {
+	AIR_ACTIVE_LOW,
+	AIR_ACTIVE_HIGH,
+};
+
+enum {
+	AIR_LED_MODE_DISABLE,
+	AIR_LED_MODE_USER_DEFINE,
+};
+
+#define AIR_PHY_LED_DUR_UNIT	781
+#define AIR_PHY_LED_DUR (AIR_PHY_LED_DUR_UNIT << AIR_PHY_LED_DUR_BLINK_64MS)
+
+struct en8811h_priv {
+	int firmware_version;
+	bool		mcu_needs_restart;
+	struct led	led[EN8811H_LED_COUNT];
+};
+
+static int air_phy_read_page(struct phy_device *phydev)
+{
+	return phy_read(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS);
+}
+
+static int air_phy_write_page(struct phy_device *phydev, int page)
+{
+	return phy_write(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS, page);
+}
+
+int air_phy_select_page(struct phy_device *phydev, int page)
+{
+	int ret, oldpage;
+
+	oldpage = air_phy_read_page(phydev);
+	if (oldpage < 0)
+		return oldpage;
+
+	if (oldpage != page) {
+		ret = air_phy_write_page(phydev, page);
+		if (ret < 0)
+			return ret;
+	}
+
+	return oldpage;
+}
+
+int air_phy_restore_page(struct phy_device *phydev, int oldpage, int ret)
+{
+	int r;
+
+	if (oldpage >= 0) {
+		r = air_phy_write_page(phydev, oldpage);
+
+		if (ret >= 0 && r < 0)
+			ret = r;
+	} else {
+		ret = oldpage;
+	}
+
+	return ret;
+}
+
+static int air_buckpbus_reg_write(struct phy_device *phydev,
+				  u32 pbus_address, u32 pbus_data)
+{
+	int ret, saved_page;
+
+	saved_page = air_phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+
+	if (saved_page >= 0) {
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
+				air_upper_16_bits(pbus_address));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
+				air_lower_16_bits(pbus_address));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
+				air_upper_16_bits(pbus_data));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
+				air_lower_16_bits(pbus_data));
+		if (ret < 0)
+			goto restore_page;
+	}
+
+restore_page:
+	if (ret < 0)
+		printf("%s 0x%08x failed: %d\n", __func__,
+		       pbus_address, ret);
+
+	return air_phy_restore_page(phydev, saved_page, ret);
+}
+
+static int air_buckpbus_reg_read(struct phy_device *phydev,
+				 u32 pbus_address, u32 *pbus_data)
+{
+	int pbus_data_low, pbus_data_high;
+	int ret = 0, saved_page;
+
+	saved_page = air_phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+
+	if (saved_page >= 0) {
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_HIGH,
+				air_upper_16_bits(pbus_address));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_LOW,
+				air_lower_16_bits(pbus_address));
+		if (ret < 0)
+			goto restore_page;
+
+		pbus_data_high = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_HIGH);
+		if (pbus_data_high < 0) {
+			ret = pbus_data_high;
+			goto restore_page;
+		}
+
+		pbus_data_low = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_LOW);
+		if (pbus_data_low < 0) {
+			ret = pbus_data_low;
+			goto restore_page;
+		}
+
+		*pbus_data = pbus_data_low | (pbus_data_high << 16);
+	}
+
+restore_page:
+	if (ret < 0)
+		printf("%s 0x%08x failed: %d\n", __func__,
+		       pbus_address, ret);
+
+	return air_phy_restore_page(phydev, saved_page, ret);
+}
+
+static int air_buckpbus_reg_modify(struct phy_device *phydev,
+				   u32 pbus_address, u32 mask, u32 set)
+{
+	int pbus_data_low, pbus_data_high;
+	u32 pbus_data_old, pbus_data_new;
+	int ret = 0, saved_page;
+
+	saved_page = air_phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+
+	if (saved_page >= 0) {
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_HIGH,
+				air_upper_16_bits(pbus_address));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_LOW,
+				air_lower_16_bits(pbus_address));
+		if (ret < 0)
+			goto restore_page;
+
+		pbus_data_high = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_HIGH);
+		if (pbus_data_high < 0)
+			return pbus_data_high;
+
+		pbus_data_low = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_LOW);
+		if (pbus_data_low < 0)
+			return pbus_data_low;
+
+		pbus_data_old = pbus_data_low | (pbus_data_high << 16);
+		pbus_data_new = (pbus_data_old & ~mask) | set;
+		if (pbus_data_new == pbus_data_old)
+			return 0;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
+				air_upper_16_bits(pbus_address));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
+				air_lower_16_bits(pbus_address));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
+				air_upper_16_bits(pbus_data_new));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
+				air_lower_16_bits(pbus_data_new));
+		if (ret < 0)
+			goto restore_page;
+	}
+
+restore_page:
+	if (ret < 0)
+		printf("%s 0x%08x failed: %d\n", __func__,
+		       pbus_address, ret);
+
+	return air_phy_restore_page(phydev, saved_page, ret);
+}
+
+static int air_write_buf(struct phy_device *phydev, unsigned long address,
+			 unsigned long array_size, const unsigned char *buffer)
+{
+	unsigned int offset;
+	int ret, saved_page;
+	u16 val;
+
+	saved_page = air_phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+
+	if (saved_page >= 0) {
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_INCR);
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
+				air_upper_16_bits(address));
+		if (ret < 0)
+			goto restore_page;
+
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
+				air_lower_16_bits(address));
+		if (ret < 0)
+			goto restore_page;
+
+		for (offset = 0; offset < array_size; offset += 4) {
+			val = get_unaligned_le16(&buffer[offset + 2]);
+			ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH, val);
+			if (ret < 0)
+				goto restore_page;
+
+			val = get_unaligned_le16(&buffer[offset]);
+			ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW, val);
+			if (ret < 0)
+				goto restore_page;
+		}
+	}
+
+restore_page:
+	if (ret < 0)
+		printf("%s 0x%08lx failed: %d\n", __func__,
+		       address, ret);
+
+	return air_phy_restore_page(phydev, saved_page, ret);
+}
+
+__weak ulong *en8811h_get_fw_addr(void)
+{
+	return (ulong *)CONFIG_AIROHA_FW_ADDR;
+}
+
+static int en8811h_wait_mcu_ready(struct phy_device *phydev)
+{
+	int ret, reg_value;
+
+	/* Because of mdio-lock, may have to wait for multiple loads */
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					EN8811H_PHY_FW_STATUS, reg_value,
+					reg_value == EN8811H_PHY_READY,
+					20000, 7500000, true);
+	if (ret) {
+		printf("MCU not ready: 0x%x\n", reg_value);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int en8811h_load_firmware(struct phy_device *phydev)
+{
+	int ret;
+	char *addr = NULL;
+	struct en8811h_priv *priv = phydev->priv;
+	int dev = CONFIG_SYS_MMC_ENV_DEV;
+	u32 cnt = (CONFIG_AIROHA_MD32_DM_SIZE +
+		   CONFIG_AIROHA_MD32_DSP_SIZE) / 512;
+	ulong airoha_fw_addr = (ulong)en8811h_get_fw_addr();
+	u32 blk = airoha_fw_addr / 512;
+
+	addr = malloc(CONFIG_AIROHA_MD32_DM_SIZE + CONFIG_AIROHA_MD32_DSP_SIZE);
+	if (!addr) {
+		puts("cannot allocated buffer for firmware.\n");
+		return -ENOMEM;
+	}
+
+	if (IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC)) {
+		struct mmc *mmc = find_mmc_device(dev);
+
+		if (!mmc) {
+			puts("Failed to find MMC device for Airoha ucode\n");
+			goto en8811h_load_firmware_out;
+		}
+
+		printf("MMC read: dev # %u, block # %u, count %u ...\n",
+		       dev, blk, cnt);
+
+		if (mmc_init(mmc)) {
+			puts("initializing MMC device failed.\n");
+			goto en8811h_load_firmware_out;
+		}
+
+		ret = mmc_set_part_conf(mmc, 1, 2, 2);
+		if (ret) {
+			puts("cannot access eMMC boot1 hw partition.\n");
+			goto en8811h_load_firmware_out;
+		}
+
+		(void)blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
+
+		mmc_set_part_conf(mmc, 1, 1, 0);
+
+	} else {
+		puts("EN8811H firmware loading not implemented");
+		free(addr);
+		addr = NULL;
+		return -EOPNOTSUPP;
+	}
+
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_START);
+	if (ret < 0)
+		return ret;
+
+	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+				      EN8811H_FW_CTRL_2_LOADING,
+				      EN8811H_FW_CTRL_2_LOADING);
+	if (ret < 0)
+		return ret;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, CONFIG_AIROHA_MD32_DM_SIZE, addr);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, CONFIG_AIROHA_MD32_DSP_SIZE,
+			    addr + CONFIG_AIROHA_MD32_DM_SIZE);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+				      EN8811H_FW_CTRL_2_LOADING, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_FINISH);
+	if (ret < 0)
+		return ret;
+
+	ret = en8811h_wait_mcu_ready(phydev);
+
+	air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
+			      &priv->firmware_version);
+	printf("MD32 firmware version: %08x\n",
+	       priv->firmware_version);
+
+en8811h_load_firmware_out:
+	free(addr);
+	if (ret < 0)
+		printf("Firmware loading failed: %d\n", ret);
+
+	return ret;
+}
+
+static int en8811h_restart_mcu(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, 0x1e, 0x8009, 0x0);
+	if (ret < 0)
+		return ret;
+
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_START);
+	if (ret < 0)
+		return ret;
+
+	return air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				      EN8811H_FW_CTRL_1_FINISH);
+}
+
+static int air_led_hw_control_set(struct phy_device *phydev,
+				  u8 index, unsigned long rules)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	u16 on = 0, blink = 0;
+	int ret;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	on |= rules & (AIR_PHY_LED_ON_LINK100 |
+		AIR_PHY_LED_ON_LINK1000 |
+		AIR_PHY_LED_ON_LINK2500);
+
+	blink |= rules & (AIR_PHY_LED_BLINK_100TX |
+		AIR_PHY_LED_BLINK_100RX |
+		AIR_PHY_LED_BLINK_1000TX |
+		AIR_PHY_LED_BLINK_1000RX |
+		AIR_PHY_LED_BLINK_2500TX |
+		AIR_PHY_LED_BLINK_2500RX);
+
+	if (blink || on) {
+		on &= ~AIR_PHY_LED_ON_FORCE_ON;
+		blink &= ~AIR_PHY_LED_BLINK_FORCE_BLINK;
+	} else {
+		priv->led[index].rules = 0;
+	}
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_ON(index),
+			     AIR_PHY_LED_ON_MASK, on);
+	if (ret < 0)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BLINK(index),
+			blink);
+}
+
+static int air_led_init(struct phy_device *phydev, u8 index, u8 state, u8 pol)
+{
+	int val = 0;
+	int err;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	if (state == AIR_LED_ENABLE)
+		val |= AIR_PHY_LED_ON_ENABLE;
+	else
+		val &= ~AIR_PHY_LED_ON_ENABLE;
+
+	if (pol == AIR_ACTIVE_HIGH)
+		val |= AIR_PHY_LED_ON_POLARITY;
+	else
+		val &= ~AIR_PHY_LED_ON_POLARITY;
+
+	err = phy_write_mmd(phydev, 0x1f, AIR_PHY_LED_ON(index), val);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int air_leds_init(struct phy_device *phydev, int num, int dur, int mode)
+{
+	int ret, i;
+	struct en8811h_priv *priv = phydev->priv;
+
+	ret = phy_write_mmd(phydev, 0x1f, AIR_PHY_LED_DUR_BLINK, dur);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, 0x1f, AIR_PHY_LED_DUR_ON, dur >> 1);
+	if (ret < 0)
+		return ret;
+
+	switch (mode) {
+	case AIR_LED_MODE_DISABLE:
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR,
+				     AIR_PHY_LED_BCR_EXT_CTRL |
+				     AIR_PHY_LED_BCR_MODE_MASK, 0);
+		break;
+	case AIR_LED_MODE_USER_DEFINE:
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR,
+				     AIR_PHY_LED_BCR_EXT_CTRL |
+				     AIR_PHY_LED_BCR_CLK_EN,
+				     AIR_PHY_LED_BCR_EXT_CTRL |
+				     AIR_PHY_LED_BCR_CLK_EN);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		printf("LED mode %d is not supported\n", mode);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num; ++i) {
+		ret = air_led_init(phydev, i, AIR_LED_ENABLE, AIR_ACTIVE_HIGH);
+		if (ret < 0) {
+			printf("LED%d init failed: %d\n", i, ret);
+			return ret;
+		}
+		air_led_hw_control_set(phydev, i, priv->led[i].rules);
+	}
+
+	return 0;
+}
+
+static int en8811h_config(struct phy_device *phydev)
+{
+	ofnode node = phy_get_ofnode(phydev);
+	struct en8811h_priv *priv = phydev->priv;
+	int ret = 0;
+	u32 pbus_value = 0;
+
+	/* If restart happened in .probe(), no need to restart now */
+	if (priv->mcu_needs_restart) {
+		ret = en8811h_restart_mcu(phydev);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = en8811h_load_firmware(phydev);
+		if (ret) {
+			printf("Load firmware fail.\n");
+			return ret;
+		}
+		/* Next calls to .config() mcu needs to restart */
+		priv->mcu_needs_restart = true;
+	}
+
+	ret = phy_write_mmd(phydev, 0x1e, 0x800c, 0x0);
+	ret |= phy_write_mmd(phydev, 0x1e, 0x800d, 0x0);
+	ret |= phy_write_mmd(phydev, 0x1e, 0x800e, 0x1101);
+	ret |= phy_write_mmd(phydev, 0x1e, 0x800f, 0x0002);
+	if (ret < 0)
+		return ret;
+
+	/* Serdes polarity */
+	pbus_value = 0;
+	if (ofnode_read_bool(node, "airoha,pnswap-rx"))
+		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
+	else
+		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
+	if (ofnode_read_bool(node, "airoha,pnswap-tx"))
+		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
+	else
+		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
+	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+				      EN8811H_POLARITY_RX_REVERSE |
+				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
+	if (ret < 0)
+		return ret;
+
+	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
+			    AIR_LED_MODE_USER_DEFINE);
+	if (ret < 0) {
+		printf("Failed to disable leds: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int en8811h_parse_status(struct phy_device *phydev)
+{
+	int ret = 0, reg_value;
+
+	phydev->duplex = DUPLEX_FULL;
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
+	default:
+		printf("Auto-neg error, defaulting to 100M/FD\n");
+		phydev->speed = SPEED_100;
+		break;
+	}
+
+	return ret;
+}
+
+static int en8811h_startup(struct phy_device *phydev)
+{
+	int ret = 0;
+
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	return en8811h_parse_status(phydev);
+}
+
+static int en8811h_probe(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv;
+
+	priv = malloc(sizeof(*priv));
+	if (!priv)
+		return -ENOMEM;
+	memset(priv, 0, sizeof(*priv));
+
+	priv->led[0].rules = AIR_DEFAULT_TRIGGER_LED0;
+	priv->led[1].rules = AIR_DEFAULT_TRIGGER_LED1;
+	priv->led[2].rules = AIR_DEFAULT_TRIGGER_LED2;
+
+	/* mcu has just restarted after firmware load */
+	priv->mcu_needs_restart = false;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+U_BOOT_PHY_DRIVER(en8811h) = {
+	.name = "Airoha EN8811H",
+	.uid = EN8811H_PHY_ID,
+	.mask = 0x0ffffff0,
+	.config = &en8811h_config,
+	.probe = &en8811h_probe,
+	.startup = &en8811h_startup,
+	.shutdown = &genphy_shutdown,
+};
-- 
2.34.1

