Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9002CCFA13
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 00:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202C183AA0;
	Tue, 11 Nov 2025 01:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="msmQboIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B03E83AA9; Tue, 11 Nov 2025 01:06:01 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA0783A94
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 01:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b6ceb3b68eeso2256277a12.2
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 16:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762819557; x=1763424357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T3lDq7b8tJojqCQkcsiEhMozdKfG0U+exWSGdvQsmdY=;
 b=msmQboImc+AnsF5p3T5qS5tWX4j4nc9T6YFzTmHfHvJqXk42xWKtB2eGrVhlNdqUEl
 bBALsT7RZ0VKNI0LYZkaBxfmwvAsycALJuQBRlg/hFpsetu2si/TYDi+tBF0mhKYZYJK
 qukZYvSUTKcWhm/5hziWhgawd/Gv2JP1k2uytGX5+hpVNaDxyLxZCGhK9CxpKtdRlvsQ
 VCT/x1k0onBKVTgnRS6+61qphT2QzIb+Hk3awbQ+QJAW0/gv6pD0ZBlEAZ6AcEvjkIxj
 0DV0qxHGCD7MuarHk2vwICs3OdFxgn8/RnqhajISs8pKEcZQsv26tLIMyZa00IEC4bux
 ME9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762819557; x=1763424357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3lDq7b8tJojqCQkcsiEhMozdKfG0U+exWSGdvQsmdY=;
 b=AKqYtP6i3xLcydugoR2PsF3wSDfZ6Zuze+aAtw3lOYu6iMeaZU/qv6pdvcYOUvS6LO
 wv7kGTZLADYRs7jXQZfyvVnn+pga410PHkPFLT9UyY/Af3YD8L9pyax4/jfcyfMh8jZO
 ZCqTdbvuzwi7Nqbs73JaKxI3wgthL+lqBdhVMXFby6DHNxCRUAb5B3qgQ6AdreQ7+qKS
 b1kpyzEmM1eROS+HLlQsu5gDF9lcHdkNQrLXkwqDsrLKt48cQ50D9/p8O4kiKpwXvQP7
 Kbo4Zlr7ak29vNCvl7sqFkx7y5qT6pyp5ASw6tHZKKGJ31XtXN1ZyiMX9hhq2fRf+bLw
 cIYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYV3Mg9zk0BxSNevPTLctRgybdPVPOIES6/yQAqBAL8uHcomCIrH98Vrn3wXo6M/8ffoPlGw4=@lists.denx.de
X-Gm-Message-State: AOJu0YyFBs8aMd++zXseFHE+9SFW8kVF3n9gsfTBh7gIXB230ukA2udE
 zUXGcdKkbNk3vKH84M+hQFn7269MUShlyj1Tje8zn4ADViF1O0Ha86yq
X-Gm-Gg: ASbGncu8aMh7h+PL8chNIMm6cTLJCGptwZ4gLcKlxotReINMa9lOnEEzV2drWWTF/ww
 0jUarMH0RHUyVu+qZTB1W4vj2p7f36TCugZVBCBrPHtFw2U9OQxRkSc5s91fwgiOrm230DzYuxL
 anT4JoVhun9XEN0CPMFEIWvRLOj/nKnh+tyrtBAoe754h8JHoEheibYTkKFwqyCyE1XYioQ52oU
 syUKuTAQ8ZwAVI7PIzVv1F+cf0Whoo3bGdBoNcwo5e3H1V55ZqobRD17zq4GXfAxTeJmbDwAtEc
 cVWQsyzXKKq1XhnR8tV7xLTWwbYUzyboWbxRg2YNHEtRxnL1sQ2gXfelgmFT6XSUKpSDAzyNwSQ
 m0EGbiQkyCoxWq/st8wdGhS9pzue+WTLJIRbtzXAc+Wwd5v+Wutrxe7WAReqmyxcMCD65ayXTtO
 bwLKjwu8pK2eWwu5S0rjlZpMyI2Kju1D2c9vhPO7/mWQUUjkP/xhUpsSeObyPBYC6yPPfkaO0=
X-Google-Smtp-Source: AGHT+IFRvtiWaP0ekbjO2gd49a8VnrabjAOaY1d8uAa8zWlxHi8gk8bTD+M7wj8RoJEGoJyLL4cbZg==
X-Received: by 2002:a17:902:f70a:b0:295:5dbe:f629 with SMTP id
 d9443c01a7336-297e540dd62mr100401215ad.8.1762819556425; 
 Mon, 10 Nov 2025 16:05:56 -0800 (PST)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba9024e6e17sm13594196a12.34.2025.11.10.16.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 16:05:55 -0800 (PST)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com,
 marek.vasut+renesas@mailbox.org, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, lucienzx159@gmail.com, ansuelsmth@gmail.com,
 weijie.gao@mediatek.com, SkyLake.Huang@mediatek.com,
 romain.gantois@bootlin.com, s-vadapalli@ti.com, u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 ericwouds@gmail.com
Subject: [PATCH 1/1] [U-Boot, v6,
 1/1]net: phy: Add the Airoha EN8811H PHY driver
Date: Tue, 11 Nov 2025 08:05:06 +0800
Message-Id: <20251111000506.18366-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Nov 2025 01:10:21 +0100
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

Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
I have modified the relevant process to align with the U-Boot boot sequence.
and have validated this on Banana Pi BPI-R3 Mini.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
Change in PATCH v6:
air_en8811.c:
 * Use dev_err() instead of printf() for error messages
 * Use dev_info() instead of printf() for error messages
 * Return actual error code in en8811h_wait_mcu_ready()
 * Fix comment formatting for MII Registers Page 4

Change in PATCH v5:
air_en8811.c:
 * Add read_page & write_page functions for page access.
 * Change fs_loader to fw_loader.
 * Remove unnecessary debug prints.

Change in PATCH v4:
air_en8811.c:
 * Create the airoha folder to store all future airoha phy drivers.
 * Use `request_firmware_into_buf_via_script` for firmware loading.

Change in PATCH v3:
air_en8811.c:
 * Add U-Boot environment variable(en8811h_fw_part, en8811h_fw_dm_dir, en8811h_fw_dsp_dir)
   support for firmware loading.

Regarding the firmware loading mechanism,
Please refer to the following script example for guidance:
1.  `env set en8811h_load_firmware 'env set en8811h_load_firmware_addr 0x46000000 && env set en8811h_load_firmware_size 0x24000 && mw.b ${en8811h_load_firmware_addr} 0 ${en8811h_load_firmware_size} && load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin && if test ${filesize} -eq 4000; then load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin; else echo "loading MD32 FW failed"; env set en8811h_load_firmware_size 0; exit 1;fi'`
````Test Log````
Net:   16384 bytes read in 1 ms (15.6 MiB/s)
131072 bytes read in 9 ms (13.9 MiB/s)
addr: 0x46000000, size: 0x24000
Found Airoha Firmware.
MD32 firmware version: 24112802
````End of Test Log````

2.  `env set en8811h_load_firmware 'env set en8811h_load_firmware_addr 0x46000000 && env set en8811h_load_firmware_size 0x24000 && mmc partconf 0 1 2 2 && mmc read $en8811h_load_firmware_addr 0x0 0x120 && mmc partconf 0 1 1 0'`
````Test Log````
Net:   MMC read: dev # 0, block # 0, count 288 ... 288 blocks read: OK
addr: 0x46000000, size: 0x24000
Found Airoha Firmware.
MD32 firmware version: 24112802
````End of Test Log````

 drivers/net/phy/Kconfig             |   2 +
 drivers/net/phy/Makefile            |   1 +
 drivers/net/phy/airoha/Kconfig      |  11 +
 drivers/net/phy/airoha/Makefile     |   3 +
 drivers/net/phy/airoha/air_en8811.c | 805 ++++++++++++++++++++++++++++
 5 files changed, 822 insertions(+)
 create mode 100644 drivers/net/phy/airoha/Kconfig
 create mode 100644 drivers/net/phy/airoha/Makefile
 create mode 100644 drivers/net/phy/airoha/air_en8811.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 018be98705a..b254a0f4591 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -188,6 +188,8 @@ config PHY_MARVELL_10G

 source "drivers/net/phy/mediatek/Kconfig"

+source "drivers/net/phy/airoha/Kconfig"
+
 config PHY_MESON_GXL
 	bool "Amlogic Meson GXL Internal PHY support"

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index a339b8ac29d..83520de7f1f 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PHY_LXT) += lxt.o
 obj-$(CONFIG_PHY_MARVELL) += marvell.o
 obj-$(CONFIG_PHY_MARVELL_10G) += marvell10g.o
 obj-y += mediatek/
+obj-y += airoha/
 obj-$(CONFIG_PHY_MICREL_KSZ8XXX) += micrel_ksz8xxx.o
 obj-$(CONFIG_PHY_MICREL_KSZ90X1) += micrel_ksz90x1.o
 obj-$(CONFIG_PHY_MESON_GXL) += meson-gxl.o
diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
new file mode 100644
index 00000000000..999564e4848
--- /dev/null
+++ b/drivers/net/phy/airoha/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig PHY_AIROHA
+	bool "Airoha Ethernet PHYs support"
+
+config PHY_AIROHA_EN8811
+	bool "Airoha Ethernet EN8811H support"
+	depends on PHY_AIROHA
+	select FW_LOADER
+	help
+	  AIROHA EN8811H supported.
+
diff --git a/drivers/net/phy/airoha/Makefile b/drivers/net/phy/airoha/Makefile
new file mode 100644
index 00000000000..84d23b19ab0
--- /dev/null
+++ b/drivers/net/phy/airoha/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PHY_AIROHA_EN8811) += air_en8811.o
diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
new file mode 100644
index 00000000000..1a628ede82b
--- /dev/null
+++ b/drivers/net/phy/airoha/air_en8811.c
@@ -0,0 +1,805 @@
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
+
+#include <phy.h>
+#include <errno.h>
+#include <log.h>
+#include <env.h>
+#include <malloc.h>
+#include <fw_loader.h>
+#include <asm/unaligned.h>
+#include <linux/iopoll.h>
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <dm/device_compat.h>
+#include <u-boot/crc.h>
+
+#define EN8811H_PHY_ID		0x03a2a411
+
+#define AIR_FW_ADDR_DM		0x00000000
+#define AIR_FW_ADDR_DSP		0x00100000
+
+#define EN8811H_MD32_DM_SIZE	0x4000
+#define EN8811H_MD32_DSP_SIZE	0x20000
+
+#define EN8811H_FW_CTRL_1		0x0f0018
+#define EN8811H_FW_CTRL_1_START		0x0
+#define EN8811H_FW_CTRL_1_FINISH	0x1
+#define EN8811H_FW_CTRL_2		0x800000
+#define EN8811H_FW_CTRL_2_LOADING	BIT(11)
+
+/* MII Registers */
+#define AIR_AUX_CTRL_STATUS		0x1d
+#define AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
+#define AIR_AUX_CTRL_STATUS_SPEED_100	0x4
+#define AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
+#define AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
+
+#define AIR_EXT_PAGE_ACCESS		0x1f
+#define AIR_PHY_PAGE_STANDARD		0x0000
+#define AIR_PHY_PAGE_EXTENDED_4		0x0004
+
+/* MII Registers Page 4 */
+#define AIR_BPBUS_MODE			0x10
+#define AIR_BPBUS_MODE_ADDR_FIXED	0x0000
+#define AIR_BPBUS_MODE_ADDR_INCR	BIT(15)
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
+#define EN8811H_PHY_READY		0x02
+
+/* Registers on MDIO_MMD_VEND2 */
+#define AIR_PHY_LED_BCR			0x021
+#define AIR_PHY_LED_BCR_MODE_MASK	GENMASK(1, 0)
+#define AIR_PHY_LED_BCR_TIME_TEST	BIT(2)
+#define AIR_PHY_LED_BCR_CLK_EN		BIT(3)
+#define AIR_PHY_LED_BCR_EXT_CTRL	BIT(15)
+
+#define AIR_PHY_LED_DUR_ON		0x022
+
+#define AIR_PHY_LED_DUR_BLINK		0x023
+
+#define AIR_PHY_LED_ON(i)	       (0x024 + ((i) * 2))
+#define AIR_PHY_LED_ON_MASK		(GENMASK(6, 0) | BIT(8))
+#define AIR_PHY_LED_ON_LINK1000		BIT(0)
+#define AIR_PHY_LED_ON_LINK100		BIT(1)
+#define AIR_PHY_LED_ON_LINK10		BIT(2)
+#define AIR_PHY_LED_ON_LINKDOWN		BIT(3)
+#define AIR_PHY_LED_ON_FDX		BIT(4) /* Full duplex */
+#define AIR_PHY_LED_ON_HDX		BIT(5) /* Half duplex */
+#define AIR_PHY_LED_ON_FORCE_ON		BIT(6)
+#define AIR_PHY_LED_ON_LINK2500		BIT(8)
+#define AIR_PHY_LED_ON_POLARITY		BIT(14)
+#define AIR_PHY_LED_ON_ENABLE		BIT(15)
+
+#define AIR_PHY_LED_BLINK(i)	       (0x025 + ((i) * 2))
+#define AIR_PHY_LED_BLINK_1000TX	BIT(0)
+#define AIR_PHY_LED_BLINK_1000RX	BIT(1)
+#define AIR_PHY_LED_BLINK_100TX		BIT(2)
+#define AIR_PHY_LED_BLINK_100RX		BIT(3)
+#define AIR_PHY_LED_BLINK_10TX		BIT(4)
+#define AIR_PHY_LED_BLINK_10RX		BIT(5)
+#define AIR_PHY_LED_BLINK_COLLISION	BIT(6)
+#define AIR_PHY_LED_BLINK_RX_CRC_ERR	BIT(7)
+#define AIR_PHY_LED_BLINK_RX_IDLE_ERR	BIT(8)
+#define AIR_PHY_LED_BLINK_FORCE_BLINK	BIT(9)
+#define AIR_PHY_LED_BLINK_2500TX	BIT(10)
+#define AIR_PHY_LED_BLINK_2500RX	BIT(11)
+
+#define EN8811H_FW_VERSION		0x3b3c
+
+#define EN8811H_POLARITY		0xca0f8
+#define EN8811H_POLARITY_TX_NORMAL	BIT(0)
+#define EN8811H_POLARITY_RX_REVERSE	BIT(1)
+
+#define EN8811H_CLK_CGM			0xcf958
+#define EN8811H_CLK_CGM_CKO		BIT(26)
+#define EN8811H_HWTRAP1			0xcf914
+#define EN8811H_HWTRAP1_CKO		BIT(12)
+
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
+enum air_led_trigger_netdev_modes {
+	AIR_TRIGGER_NETDEV_LINK = 0,
+	AIR_TRIGGER_NETDEV_LINK_10,
+	AIR_TRIGGER_NETDEV_LINK_100,
+	AIR_TRIGGER_NETDEV_LINK_1000,
+	AIR_TRIGGER_NETDEV_LINK_2500,
+	AIR_TRIGGER_NETDEV_LINK_5000,
+	AIR_TRIGGER_NETDEV_LINK_10000,
+	AIR_TRIGGER_NETDEV_HALF_DUPLEX,
+	AIR_TRIGGER_NETDEV_FULL_DUPLEX,
+	AIR_TRIGGER_NETDEV_TX,
+	AIR_TRIGGER_NETDEV_RX,
+	AIR_TRIGGER_NETDEV_TX_ERR,
+	AIR_TRIGGER_NETDEV_RX_ERR,
+
+	/* Keep last */
+	__AIR_TRIGGER_NETDEV_MAX,
+};
+
+/* Default LED setup:
+ * GPIO5 <-> LED0  On: Link detected, blink Rx/Tx
+ * GPIO4 <-> LED1  On: Link detected at 2500 and 1000 Mbps
+ * GPIO3 <-> LED2  On: Link detected at 2500 and  100 Mbps
+ */
+#define AIR_DEFAULT_TRIGGER_LED0 (BIT(AIR_TRIGGER_NETDEV_LINK)      | \
+				  BIT(AIR_TRIGGER_NETDEV_RX)        | \
+				  BIT(AIR_TRIGGER_NETDEV_TX))
+#define AIR_DEFAULT_TRIGGER_LED1 (BIT(AIR_TRIGGER_NETDEV_LINK_2500) | \
+				  BIT(AIR_TRIGGER_NETDEV_LINK_1000))
+#define AIR_DEFAULT_TRIGGER_LED2 (BIT(AIR_TRIGGER_NETDEV_LINK_2500) | \
+				  BIT(AIR_TRIGGER_NETDEV_LINK_100))
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
+static int air_buckpbus_reg_write(struct phy_device *phydev,
+				  u32 pbus_address, u32 pbus_data)
+{
+	int ret, saved_page;
+
+	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0)
+		return saved_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
+			AIR_BPBUS_MODE_ADDR_FIXED);
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
+			upper_16_bits(pbus_address));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
+			lower_16_bits(pbus_address));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
+			upper_16_bits(pbus_data));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
+			lower_16_bits(pbus_data));
+	if (ret < 0)
+		goto restore_page;
+
+restore_page:
+	if (ret < 0)
+		dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
+			pbus_address, ret);
+
+	return phy_restore_page(phydev, saved_page, ret);
+}
+
+static int air_buckpbus_reg_read(struct phy_device *phydev,
+				 u32 pbus_address, u32 *pbus_data)
+{
+	int pbus_data_low, pbus_data_high;
+	int ret = 0, saved_page;
+
+	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0)
+		return saved_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
+			AIR_BPBUS_MODE_ADDR_FIXED);
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_HIGH,
+			upper_16_bits(pbus_address));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_LOW,
+			lower_16_bits(pbus_address));
+	if (ret < 0)
+		goto restore_page;
+
+	pbus_data_high = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_HIGH);
+	if (pbus_data_high < 0) {
+		ret = pbus_data_high;
+		goto restore_page;
+	}
+
+	pbus_data_low = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_LOW);
+	if (pbus_data_low < 0) {
+		ret = pbus_data_low;
+		goto restore_page;
+	}
+
+	*pbus_data = pbus_data_low | (pbus_data_high << 16);
+
+restore_page:
+	if (ret < 0)
+		dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
+			pbus_address, ret);
+
+	return phy_restore_page(phydev, saved_page, ret);
+}
+
+static int air_buckpbus_reg_modify(struct phy_device *phydev,
+				   u32 pbus_address, u32 mask, u32 set)
+{
+	int pbus_data_low, pbus_data_high;
+	u32 pbus_data_old, pbus_data_new;
+	int ret = 0, saved_page;
+
+	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0)
+		return saved_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
+			AIR_BPBUS_MODE_ADDR_FIXED);
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_HIGH,
+			upper_16_bits(pbus_address));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_ADDR_LOW,
+			lower_16_bits(pbus_address));
+	if (ret < 0)
+		goto restore_page;
+
+	pbus_data_high = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_HIGH);
+	if (pbus_data_high < 0) {
+		ret = pbus_data_high;
+		goto restore_page;
+	}
+
+	pbus_data_low = phy_read(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_RD_DATA_LOW);
+	if (pbus_data_low < 0) {
+		ret = pbus_data_low;
+		goto restore_page;
+	}
+
+	pbus_data_old = pbus_data_low | (pbus_data_high << 16);
+	pbus_data_new = (pbus_data_old & ~mask) | set;
+	if (pbus_data_new == pbus_data_old)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
+			upper_16_bits(pbus_address));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
+			lower_16_bits(pbus_address));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
+			upper_16_bits(pbus_data_new));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
+			lower_16_bits(pbus_data_new));
+	if (ret < 0)
+		goto restore_page;
+
+restore_page:
+	if (ret < 0)
+		dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
+			pbus_address, ret);
+
+	return phy_restore_page(phydev, saved_page, ret);
+}
+
+static int air_write_buf(struct phy_device *phydev, unsigned long address,
+			 unsigned long array_size, const unsigned char *buffer)
+{
+	unsigned int offset;
+	int ret, saved_page;
+	u16 val;
+
+	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
+	if (saved_page < 0)
+		return saved_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
+			AIR_BPBUS_MODE_ADDR_INCR);
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
+			upper_16_bits(address));
+	if (ret < 0)
+		goto restore_page;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
+			lower_16_bits(address));
+	if (ret < 0)
+		goto restore_page;
+
+	for (offset = 0; offset < array_size; offset += 4) {
+		val = get_unaligned_le16(&buffer[offset + 2]);
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH, val);
+		if (ret < 0)
+			goto restore_page;
+
+		val = get_unaligned_le16(&buffer[offset]);
+		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW, val);
+		if (ret < 0)
+			goto restore_page;
+	}
+
+restore_page:
+	if (ret < 0)
+		dev_err(phydev->dev, "%s 0x%08lx failed: %d\n", __func__,
+			address, ret);
+
+	return phy_restore_page(phydev, saved_page, ret);
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
+		dev_err(phydev->dev, "MCU not ready: 0x%x\n", reg_value);
+		return ret;
+	}
+
+	return ret;
+}
+
+int en8811h_read_fw(void **fw, size_t *fwsize)
+{
+	void *buffer;
+	int ret;
+
+	buffer = malloc(EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
+	if (!buffer)
+		return -ENOMEM;
+
+	ret = request_firmware_into_buf_via_script(buffer,
+						   EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE,
+						   "en8811h_load_firmware", fwsize);
+	if (ret) {
+		free(buffer);
+		return ret;
+	}
+
+	*fw = buffer;
+
+	debug("Found Airoha Firmware.\n");
+
+	return 0;
+}
+
+static int en8811h_load_firmware(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	size_t fw_size;
+	void *buffer;
+	int ret;
+
+	ret = en8811h_read_fw(&buffer, &fw_size);
+	if (ret < 0) {
+		dev_err(phydev->dev, "Failed to get firmware data\n");
+		return -EINVAL;
+	}
+
+	if (fw_size != EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE) {
+		dev_err(phydev->dev,
+			"MD32 firmware size mismatch (0x%zx != 0x%x)\n",
+			fw_size, EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
+		ret = -EINVAL;
+		goto en8811h_load_firmware_out;
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
+			    (unsigned char *)buffer);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, EN8811H_MD32_DSP_SIZE,
+			    (unsigned char *)buffer + EN8811H_MD32_DM_SIZE);
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
+	dev_info(phydev->dev, "MD32 firmware version: %08x\n",
+		 priv->firmware_version);
+
+en8811h_load_firmware_out:
+	free(buffer);
+	if (ret < 0)
+		dev_err(phydev->dev, "Firmware loading failed: %d\n", ret);
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
+	if (rules & BIT(AIR_TRIGGER_NETDEV_FULL_DUPLEX))
+		on |= AIR_PHY_LED_ON_FDX;
+
+	if (rules & (BIT(AIR_TRIGGER_NETDEV_LINK_10) | BIT(AIR_TRIGGER_NETDEV_LINK)))
+		on |= AIR_PHY_LED_ON_LINK10;
+
+	if (rules & (BIT(AIR_TRIGGER_NETDEV_LINK_100) | BIT(AIR_TRIGGER_NETDEV_LINK)))
+		on |= AIR_PHY_LED_ON_LINK100;
+
+	if (rules & (BIT(AIR_TRIGGER_NETDEV_LINK_1000) | BIT(AIR_TRIGGER_NETDEV_LINK)))
+		on |= AIR_PHY_LED_ON_LINK1000;
+
+	if (rules & (BIT(AIR_TRIGGER_NETDEV_LINK_2500) | BIT(AIR_TRIGGER_NETDEV_LINK)))
+		on |= AIR_PHY_LED_ON_LINK2500;
+
+	if (rules & BIT(AIR_TRIGGER_NETDEV_RX)) {
+		blink |= AIR_PHY_LED_BLINK_10RX   |
+			 AIR_PHY_LED_BLINK_100RX  |
+			 AIR_PHY_LED_BLINK_1000RX |
+			 AIR_PHY_LED_BLINK_2500RX;
+	}
+
+	if (rules & BIT(AIR_TRIGGER_NETDEV_TX)) {
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
+static int air_leds_init(struct phy_device *phydev, int num, u16 dur, int mode)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret, i;
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
+		dev_err(phydev->dev, "LED mode %d is not supported\n", mode);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num; ++i) {
+		ret = air_led_init(phydev, i, AIR_LED_ENABLE, AIR_ACTIVE_HIGH);
+		if (ret < 0) {
+			dev_err(phydev->dev, "LED%d init failed: %d\n", i, ret);
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
+	struct en8811h_priv *priv = phydev->priv;
+	ofnode node = phy_get_ofnode(phydev);
+	u32 pbus_value = 0;
+	int ret = 0;
+
+	/* If restart happened in .probe(), no need to restart now */
+	if (priv->mcu_needs_restart) {
+		ret = en8811h_restart_mcu(phydev);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = en8811h_load_firmware(phydev);
+		if (ret) {
+			dev_err(phydev->dev, "Load firmware fail.\n");
+			return ret;
+		}
+		/* Next calls to .config() mcu needs to restart */
+		priv->mcu_needs_restart = true;
+	}
+
+	ret = phy_write_mmd(phydev, 0x1e, 0x800c, 0x0);
+	if (ret < 0)
+		return ret;
+	ret = phy_write_mmd(phydev, 0x1e, 0x800d, 0x0);
+	if (ret < 0)
+		return ret;
+	ret = phy_write_mmd(phydev, 0x1e, 0x800e, 0x1101);
+	if (ret < 0)
+		return ret;
+	ret = phy_write_mmd(phydev, 0x1e, 0x800f, 0x0002);
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
+		dev_err(phydev->dev, "Failed to disable leds: %d\n", ret);
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
+		dev_err(phydev->dev, "Auto-neg error, defaulting to 2500M/FD\n");
+		phydev->speed = SPEED_2500;
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
+static int en8811h_read_page(struct phy_device *phydev)
+{
+	return phy_read(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS);
+}
+
+static int en8811h_write_page(struct phy_device *phydev, int page)
+{
+	return phy_write(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS, page);
+}
+
+U_BOOT_PHY_DRIVER(en8811h) = {
+	.name = "Airoha EN8811H",
+	.uid = EN8811H_PHY_ID,
+	.mask = 0x0ffffff0,
+	.config = &en8811h_config,
+	.probe = &en8811h_probe,
+	.read_page = &en8811h_read_page,
+	.write_page = &en8811h_write_page,
+	.startup = &en8811h_startup,
+	.shutdown = &genphy_shutdown,
+};
--
2.34.1

