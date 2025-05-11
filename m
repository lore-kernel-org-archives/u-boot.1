Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E22C3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 13:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E1E882A33;
	Sun, 11 May 2025 15:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQtzUazG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45BD580ADF; Sun, 11 May 2025 07:14:54 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F778004F
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso33269225ad.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 22:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746940490; x=1747545290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lMagvvb68QBMKK5abHViG7TmRAgcyhILsohBo7GTivc=;
 b=gQtzUazG3/0zisn9QIo7Ga6pkqJos/aarObOXSi//JqVOBHnXEazfwh1yG7PLohffE
 hsYbe4wqrbvphXjehJzNKmb7BKQbY38Odc0Zrfl5YURmx9TWTCdD5hn64I2oCpg1Yi2U
 dPkmpg9Kq03qKKOs/rqDUMAcqaKQ42F5JdoaE7CE2N/YOQ3r8q0vSKapOfCATWHSKhAM
 LvxNEM2+Er2Cid+2weDr/ZZo5VywBuMRkxhPBOyN8168fCmFSysDgLbxCS3Fog4oXZS+
 KKDKfYf69QInLGMHAcGyDYoadamsnotJzD0yXNtcsBbnTqJM2Fs9bl4KHsefDNYlBFsj
 tXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746940490; x=1747545290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lMagvvb68QBMKK5abHViG7TmRAgcyhILsohBo7GTivc=;
 b=YXkDKZ2QKW6NyyUx0bkt5MaLB1zp62o0b3mCF66MZ4+ZKk4QkxkTSOMgVMR3WOHe12
 Jj3Aeolv/3WE8t8kJung/Q+IOAQxQfiVC/Ow/RoAiEg+2ZIssCGxQWxx6VoJUY6uoGjB
 VW7iZKaLBpMDSWy3XMGNge0B6VgTBCJRct+Vc5RdWV/brgQ9737oBWoJfMD/zk1mglSY
 veJKas3QI0YhbnGz8vepLNDM2ra/3UMOS47OUnojP2v+u4FvM4IT5Bdkp50hdCHDD/q8
 BAxp9gUoM1No29ExpBhDxxV8hy5e5GgPOxjGtV8wIxGMSmBdp4iCzvnel8Ge7YKi65aE
 Eo9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5b6GMEWYaN34nbeijdjqda1GJoIP2rW5CknciPg+P9NJhfC5SHXo382Q8KD0hqR41X5kKqGc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4X7xqikfHCcAlixY7TxjC3g91vaggImhoJxzMJTkhUDTrJsZm
 p+7qG7UZnJXIcvKyNTlCdytx7wIGOn/UyjVtY2tXvucv4HQUJLOy
X-Gm-Gg: ASbGnct8vdJzkjWJ/aATLQ3w04t390fcB2yywDw2AD6oFykLr+B5xk3l54/gbZLpneD
 wVnVwSpldk3tKnGBDjqul631mCxjGHpo5+zPAjSp4iSVlHSvkarodJ93EMOpjxL2/wrBeore3e7
 z8EvR+IOFTWXLxQ1M4QqRMqBbGL50YIL2vxos1CiE1nSWkRXeNJLNJsEYFO1iXpvl0iFqVHypvk
 1SdeUOmFYyK5O8vps5WkkYz8xiKGH8KNO+tSJW6ENDcI06Amn2xjteo9/jjsLK8ocxdWH6t509k
 dIO1STSaW1Cajz2j8x3kc4e7SV3Ei+Xlw34uuxMFTWbUcZvoiWt5jUqJgPF6U/nE5LFnTmf1py4
 C27vUVxkg7DF9x8YNo+8llGFHjeGa3keeM9/oUHtLR/wzqMdgcuBOaOp7Ng==
X-Google-Smtp-Source: AGHT+IGiYxLaJGMO3CEajb8NsYGRlYROhJujMZkaaIq8UHVNNLlVgAovn/53ttxAXNTTbCpyEVJVkQ==
X-Received: by 2002:a17:902:ea0e:b0:22e:327f:4ab0 with SMTP id
 d9443c01a7336-22fc8b7eae8mr142580135ad.28.1746940489483; 
 Sat, 10 May 2025 22:14:49 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b23439074a3sm3665903a12.0.2025.05.10.22.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 22:14:49 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, lucienzx159@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com
Subject: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
Date: Sun, 11 May 2025 13:14:00 +0800
Message-Id: <20250511051400.29853-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 May 2025 15:02:43 +0200
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

Locating the AIROHA FW within the filesystem at the designated partition
and path will trigger its automatic loading and writing to the PHY via MDIO.
If need board specific loading override,
please override the en8811h_read_fw function on board or architecture level.

Linux upstream AIROHA EN8811H driver commit:
71e79430117d56c409c5ea485a263bc0d8083390

Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
I have modified the relevant process to align with the U-Boot boot sequence.
and have validated this on Banana Pi BPI-R3 Mini.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/net/phy/Kconfig       |  43 ++
 drivers/net/phy/air_en8811h.c | 852 ++++++++++++++++++++++++++++++++++
 2 files changed, 895 insertions(+)
 create mode 100644 drivers/net/phy/air_en8811h.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3132718e4f8..384cef845e1 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -79,6 +79,49 @@ config PHY_ADIN
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
+	bool "Airoha firmware in MMC partition"
+	help
+		Airoha PHYs use firmware which can be loaded automatically
+		from storage directly attached to the PHY, and then loaded
+		via MDIO commands by the boot loader. The firmware is loaded
+		from a file specified by the PHY_AIROHA_FW_PART,
+		PHY_AIROHA_FW_DM_FILEPATH and PHY_AIROHA_FW_DSP_FILEPATH options.
+
+config PHY_AIROHA_FW_PART
+	string "Airoha firmware partition"
+	depends on PHY_AIROHA_FW_IN_MMC
+	help
+		Partition containing the firmware file.
+
+config PHY_AIROHA_FW_DM_FILEPATH
+	string "Airoha firmware DM file path in the filesystem"
+	depends on PHY_AIROHA_FW_IN_MMC
+	help
+		Specify Airoha firmware DM file path in the filesystem.
+
+config PHY_AIROHA_FW_DSP_FILEPATH
+	string "Airoha firmware DSP file path in the filesystem"
+	depends on PHY_AIROHA_FW_IN_MMC
+	help
+		Specify Airoha firmware DSP file path in the filesystem.
+
+endchoice
+
 menuconfig PHY_AQUANTIA
 	bool "Aquantia Ethernet PHYs support"
 	select PHY_GIGE
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
new file mode 100644
index 00000000000..79c66ac8bbf
--- /dev/null
+++ b/drivers/net/phy/air_en8811h.c
@@ -0,0 +1,852 @@
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
+#include <log.h>
+#include <malloc.h>
+#include <fs.h>
+#include <asm/unaligned.h>
+#include <linux/iopoll.h>
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <dm/device_compat.h>
+#include <u-boot/crc.h>
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
+#define clear_bit(bit, bitmap)	__clear_bit(bit, bitmap)
+
+/* Led definitions */
+#define EN8811H_LED_COUNT	3
+
+struct led {
+	unsigned long rules;
+	unsigned long state;
+};
+
+enum {
+	AIR_PHY_LED_STATE_FORCE_ON,
+	AIR_PHY_LED_STATE_FORCE_BLINK,
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
+/* Trigger specific enum */
+enum led_trigger_netdev_modes {
+	TRIGGER_NETDEV_LINK = 0,
+	TRIGGER_NETDEV_LINK_10,
+	TRIGGER_NETDEV_LINK_100,
+	TRIGGER_NETDEV_LINK_1000,
+	TRIGGER_NETDEV_LINK_2500,
+	TRIGGER_NETDEV_LINK_5000,
+	TRIGGER_NETDEV_LINK_10000,
+	TRIGGER_NETDEV_HALF_DUPLEX,
+	TRIGGER_NETDEV_FULL_DUPLEX,
+	TRIGGER_NETDEV_TX,
+	TRIGGER_NETDEV_RX,
+	TRIGGER_NETDEV_TX_ERR,
+	TRIGGER_NETDEV_RX_ERR,
+
+	/* Keep last */
+	__TRIGGER_NETDEV_MAX,
+};
+
+/* Default LED setup:
+ * GPIO5 <-> LED0  On: Link detected, blink Rx/Tx
+ * GPIO4 <-> LED1  On: Link detected at 2500 and 1000 Mbps
+ * GPIO3 <-> LED2  On: Link detected at 2500 and  100 Mbps
+ */
+#define AIR_DEFAULT_TRIGGER_LED0 (BIT(TRIGGER_NETDEV_LINK)      | \
+				  BIT(TRIGGER_NETDEV_RX)        | \
+				  BIT(TRIGGER_NETDEV_TX))
+#define AIR_DEFAULT_TRIGGER_LED1 (BIT(TRIGGER_NETDEV_LINK_2500) | \
+				  BIT(TRIGGER_NETDEV_LINK_1000))
+#define AIR_DEFAULT_TRIGGER_LED2 (BIT(TRIGGER_NETDEV_LINK_2500) | \
+				  BIT(TRIGGER_NETDEV_LINK_100))
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
+static void crc32_check(unsigned char *buf, u32 len)
+{
+	u32 ca_crc32;
+
+	ca_crc32 = crc32(0, buf, len);
+	printf("crc32 is 0x%x\n", ca_crc32);
+}
+
+__weak int en8811h_read_fw(void **addr)
+{
+	loff_t read;
+	int ret;
+
+	printf("\nLoading Airoha FW from %s %s\n",
+	       CONFIG_PHY_AIROHA_FW_PART,
+	       CONFIG_PHY_AIROHA_FW_DM_FILEPATH);
+	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
+	if (ret < 0)
+		return ret;
+
+	ret = fs_read(CONFIG_PHY_AIROHA_FW_DM_FILEPATH,
+		      (ulong)*addr, 0, EN8811H_MD32_DM_SIZE, &read);
+	if (ret < 0)
+		return ret;
+
+	/* Calculate the CRC32 */
+	crc32_check((unsigned char *)*addr, EN8811H_MD32_DM_SIZE);
+
+	printf("Loading Airoha FW from %s %s\n",
+	       CONFIG_PHY_AIROHA_FW_PART,
+	       CONFIG_PHY_AIROHA_FW_DSP_FILEPATH);
+	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
+	if (ret < 0)
+		return ret;
+
+	ret = fs_read(CONFIG_PHY_AIROHA_FW_DSP_FILEPATH,
+		      (ulong)*addr + EN8811H_MD32_DM_SIZE,
+		      0, EN8811H_MD32_DSP_SIZE, &read);
+	if (ret < 0)
+		return ret;
+
+	/* Calculate the CRC32 */
+	crc32_check((unsigned char *)*addr + EN8811H_MD32_DM_SIZE,
+		    EN8811H_MD32_DSP_SIZE);
+
+	printf("Found Airoha Firmware.\n");
+
+	return 0;
+}
+
+static int en8811h_load_firmware(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	void *addr = NULL;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC)) {
+		u32 fw_length = EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE;
+
+		addr = malloc(fw_length);
+		if (!addr) {
+			printf("Failed to allocate memory for firmware\n");
+			return -ENOMEM;
+		}
+
+		ret = en8811h_read_fw(&addr);
+		if (ret < 0) {
+			free(addr);
+			return ret;
+		}
+	} else {
+		puts("EN8811H firmware loading not implemented");
+		return -EOPNOTSUPP;
+	}
+
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_START);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+				      EN8811H_FW_CTRL_2_LOADING,
+				      EN8811H_FW_CTRL_2_LOADING);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, EN8811H_MD32_DM_SIZE,
+			    (unsigned char *)addr);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, EN8811H_MD32_DSP_SIZE,
+			    (unsigned char *)addr + EN8811H_MD32_DM_SIZE);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+				      EN8811H_FW_CTRL_2_LOADING, 0);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_FINISH);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
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
+static int air_led_hw_control_set(struct phy_device *phydev, u8 index,
+				  unsigned long rules)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	u16 on = 0, blink = 0;
+	int ret;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	priv->led[index].rules = rules;
+
+	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
+		on |= AIR_PHY_LED_ON_FDX;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= AIR_PHY_LED_ON_LINK10;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= AIR_PHY_LED_ON_LINK100;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= AIR_PHY_LED_ON_LINK1000;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= AIR_PHY_LED_ON_LINK2500;
+
+	if (rules & BIT(TRIGGER_NETDEV_RX)) {
+		blink |= AIR_PHY_LED_BLINK_10RX   |
+			 AIR_PHY_LED_BLINK_100RX  |
+			 AIR_PHY_LED_BLINK_1000RX |
+			 AIR_PHY_LED_BLINK_2500RX;
+	}
+
+	if (rules & BIT(TRIGGER_NETDEV_TX)) {
+		blink |= AIR_PHY_LED_BLINK_10TX   |
+			 AIR_PHY_LED_BLINK_100TX  |
+			 AIR_PHY_LED_BLINK_1000TX |
+			 AIR_PHY_LED_BLINK_2500TX;
+	}
+
+	if (blink || on) {
+		/* switch hw-control on, so led-on and led-blink are off */
+		clear_bit(AIR_PHY_LED_STATE_FORCE_ON,
+			  &priv->led[index].state);
+		clear_bit(AIR_PHY_LED_STATE_FORCE_BLINK,
+			  &priv->led[index].state);
+	} else {
+		priv->led[index].rules = 0;
+	}
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_ON(index),
+			     AIR_PHY_LED_ON_MASK, on);
+
+	if (ret < 0)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BLINK(index),
+			     blink);
+};
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
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_BLINK,
+			    dur);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_ON,
+			    dur >> 1);
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

