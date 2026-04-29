Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3F0FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 098CB84903;
	Wed, 29 Apr 2026 23:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="o08LqhYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C141C84862; Wed, 29 Apr 2026 15:59:24 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89F084832
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso96719255e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471161; x=1778075961;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ou+kxqqVupP6mcMqGz+1DYN/l8k68LTl+x2Yj2AWySA=;
 b=o08LqhYmGsXHZGr1WMnQ9ghfpaf++P4knywPDBaKMSRIW+dwmUqakKb6SRE1UiHOVW
 Algdv1RDRwR5606vCW7+aq3xOGWoiBAyxRjejFtVlm/kCRhux7KQCyLbA69QRcVXwnC+
 cpPjvXqfeR/lzh6GMZ/rDLTJD9kmGroznRIwZK4PB/OUZgxuSgYDLYo+IpayJRg576JK
 X3DmXyvSpRNRKtserXzyfEhpixUzl5I8iREqDK8D0G0r2tjYIeKtNDpMSqTGgrGbL1Qt
 grfqTplQuM1q5LzMP0U3wCi6OeqV1CI4jMy878SzknI1CEDG8yvUXXxCQOQ2JDP448R2
 O1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471161; x=1778075961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ou+kxqqVupP6mcMqGz+1DYN/l8k68LTl+x2Yj2AWySA=;
 b=NPEuPQvjM4SbsEC7A7lpj13c09RSXboucq5ShIAwy99irF1kwbRy4AarIVfmwuHd5H
 JrG3fcCxFybDZeRVO7BvuOdFjlS4HNfLiHNbU6Jv0ZjudN2FaNnxk1z4anEewZwNNJHo
 rD5Doqfi6TuigXfWq926ZImO3C6fGYPfNqDTPXSaDq6X2cs5Wb955LddQ9QzHSHt2eaM
 xl+Spt/KggE8sGFWzK1V+Xvt7PddulMxsgzmSWbUq4XQ2iErrBdPuF6dknCtZmuYwWEe
 S2ebXVbXZcfijxkfKFP2UhKZiIIY0fLJ5ZTgnIonl94OctAB/shovU4iB8iACq4Wt8F7
 sa2A==
X-Gm-Message-State: AOJu0YzUQ5WkvfdGWs+tDQb8DZzd2AQidO2GRyBa/hwkG8ZQnzlL5CJJ
 U1oZf9Shy+S8x5hJnQ7jz72AuC5R/CPtjQcN/xUe1Q918GIf0IdnMncfUuFibZSMi0g=
X-Gm-Gg: AeBDiestBAdrQZCOLytE0OZiB5/+seH3jyPN4KE9EJncm+NoYYCyG5jhiZ5ajaNAz1D
 pp0voMBF22/xmzn0Dkvg2nI8XDJ9bCu7yxDhhx1ywu889PquiE/CiS9mXM4VQFx7LIq/rU4twKJ
 sFpBUor9UijjiX1ukyVTZRBbr0VAGSPfROK11IC1vHShpbiunlq3QH8YW6rNcFUEaB/m7kauZin
 CU/dCgNNDu4jAZokwPxTW3knsc6yc030T3Ew5+6cDnapQJdJ6opho4zGp3yZ71bYJ7S9A4xRuue
 Md03nEU1PCvfSvi6ER6NEi3Veiii5ZLEq04JZFer/86Oz4hugZAAwu5ykBZE5M08pSfFuVe28bO
 hW+7CTOBfxCr1sA/4WYsj5mgllhpAYDkol7O1PS+H+3/COzRJ/RgnpWi3TWMjVbH3F2h0M9DHn2
 PlK+uziZRzRblBKy74waNFO0Ry2YaQc4973E0NiSwn+uzC21vzeG+6n3Wgj3x2kRMmRceo96lbe
 BNi23c8cPuJAN5t0tp3Y1se1GkBWFMb6lmIIJDbRI6BLhJT137dBkuBcKn84J07fTF0XZmUCmJl
 Nh2ZEUX7kOtyYlf6uuo=
X-Received: by 2002:a05:600c:3e83:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-48a77aed616mr123518225e9.9.1777471161072; 
 Wed, 29 Apr 2026 06:59:21 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 15:58:59 +0200
Subject: [PATCH v4 6/9] net: phy: Add airoha AN8801 ethernet phy driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-6-be54e17239b7@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

Add Airoha AN8801 Ethernet PHY driver (air_an8801.c).
Implement CL22/CL45 MDIO access, LED control, and RGMII delay
configuration. Provide probe, initialization, LED setup, and status
handling. Expose DTS properties for clock delays. Register driver with
PHY framework and trigger on startup.

Signed-off-by: Yanqing Wang <ot_yanqing.wang@mediatek.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS                         |   1 +
 drivers/net/phy/airoha/Kconfig      |   7 +
 drivers/net/phy/airoha/Makefile     |   1 +
 drivers/net/phy/airoha/air_an8801.c | 594 ++++++++++++++++++++++++++++++++++++
 4 files changed, 603 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 735ecc36210..165994cd72f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -60,6 +60,7 @@ F:	lib/acpi/
 
 AIROHA PHY
 M:	Tommy Shih <tommy.shih@airoha.com>
+M:	Kevin-KW Huang <kevin-kw.huang@airoha.com>
 S:	Maintained
 F:	drivers/net/phy/airoha/
 
diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
index 5b109d5c6b4..eb267ac0a40 100644
--- a/drivers/net/phy/airoha/Kconfig
+++ b/drivers/net/phy/airoha/Kconfig
@@ -2,6 +2,13 @@
 menuconfig PHY_AIROHA
 	bool "Airoha Ethernet PHYs support"
 
+config PHY_AIROHA_AN8801
+	bool "Airoha Ethernet AN8801 support"
+	depends on PHY_AIROHA
+	select PHY_AIROHA_PHYLIB
+	help
+	  Currently support AIROHA AN8801 1G PHY.
+
 config PHY_AIROHA_EN8811
 	bool "Airoha Ethernet EN8811H support"
 	depends on PHY_AIROHA
diff --git a/drivers/net/phy/airoha/Makefile b/drivers/net/phy/airoha/Makefile
index 59051caecef..25e44004cfd 100644
--- a/drivers/net/phy/airoha/Makefile
+++ b/drivers/net/phy/airoha/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_PHY_AIROHA_AN8801) += air_an8801.o
 obj-$(CONFIG_PHY_AIROHA_EN8811) += air_en8811.o
 obj-$(CONFIG_PHY_AIROHA_PHYLIB) += air_phy_lib.o
diff --git a/drivers/net/phy/airoha/air_an8801.c b/drivers/net/phy/airoha/air_an8801.c
new file mode 100644
index 00000000000..9d9958fc665
--- /dev/null
+++ b/drivers/net/phy/airoha/air_an8801.c
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * air_an8801.c - PHY driver for Airoha AN8801.
+ * Copyright (c) 2026 Airoha Technology Corp.
+ * Copyright (C) 2026 BayLibre, SAS.
+ * Author: Kevin-KW Huang <kevin-kw.huang@airoha.com>
+ *         Sita Huang <sita.huang@airoha.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <malloc.h>
+#include <phy.h>
+#include <dm/device_compat.h>
+
+#include "air_phy_lib.h"
+
+#define AN8801R_PHY_ID1			0xc0ff
+#define AN8801R_PHY_ID2			0x0421
+#define AN8801R_PHY_ID			((u32)((AN8801R_PHY_ID1 << 16) | AN8801R_PHY_ID2))
+
+#define AN8801R_MAX_LED_SIZE		3
+
+/* MII Registers - Airoha Page 4 */
+#define AN8801_PBUS_ACCESS		BIT(28)
+
+/* BPBUS Registers */
+#define AN8801_BPBUS_REG_LED_GPIO	0x54
+#define AN8801_BPBUS_REG_LED_ID_SEL	0x58
+#define  LED_ID_GPIO_SEL(led, gpio)	((led) << ((gpio) * 3))
+
+#define AN8801_BPBUS_REG_GPIO_MODE	0x70
+
+#define AN8801_BPBUS_REG_LINK_MODE	0x5054
+#define  AN8801_BPBUS_LINK_MODE_1000	BIT(0)
+
+#define AN8801_BPBUS_REG_BYPASS_PTP	0x21c004
+#define   AN8801_BYP_PTP_RGMII_TO_GPHY	BIT(0)
+
+#define AN8801_BPBUS_REG_TXDLY_STEP	0x21c024
+#define  RGMII_DELAY_STEP_MASK		GENMASK(2, 0)
+#define  AIR_RGMII_DELAY_NOSTEP		0
+#define  AIR_RGMII_DELAY_STEP_1		1
+#define  AIR_RGMII_DELAY_STEP_2		2
+#define  AIR_RGMII_DELAY_STEP_3		3
+#define  AIR_RGMII_DELAY_STEP_4		4
+#define  AIR_RGMII_DELAY_STEP_5		5
+#define  AIR_RGMII_DELAY_STEP_6		6
+#define  AIR_RGMII_DELAY_STEP_7		7
+#define  RGMII_TXDELAY_FORCE_MODE	BIT(24)
+
+#define AN8801_BPBUS_REG_RXDLY_STEP	0x21c02c
+#define  RGMII_RXDELAY_ALIGN		BIT(4)
+#define  RGMII_RXDELAY_FORCE_MODE	BIT(24)
+
+#define AN8801_BPBUS_REG_EFIFO_CTL(x)	(0x270004 + (0x100 * (x))) /* 0..2 */
+#define   AN8801_EFIFO_ALL_EN		GENMASK(7, 0)
+#define   AN8801_EFIFO_RX_EN		BIT(0)
+#define   AN8801_EFIFO_TX_EN		BIT(1)
+#define   AN8801_EFIFO_RX_CLK_EN	BIT(2)
+#define   AN8801_EFIFO_TX_CLK_EN	BIT(3)
+#define   AN8801_EFIFO_RX_EEE_EN	BIT(4)
+#define   AN8801_EFIFO_TX_EEE_EN	BIT(5)
+#define   AN8801_EFIFO_RX_ODD_NIBBLE_EN	BIT(6)
+#define   AN8801_EFIFO_TX_ODD_NIBBLE_EN	BIT(7)
+
+#define AN8801_BPBUS_REG_HWRST_DE_GLITCH	0xc8
+#define  AN8801_DE_GLITCH_EN			BIT(2)
+#define  AN8801_11_CYCLE_XTAL_PERIOD_DE_GLITCH	GENMASK(1, 0)
+
+#define LED_BCR				0x21
+#define  LED_BCR_MODE_MASK		GENMASK(1, 0)
+#define  LED_BCR_TIME_TEST		BIT(2)
+#define  LED_BCR_CLK_EN			BIT(3)
+#define  LED_BCR_EVT_ALL		BIT(4)
+#define  LED_BCR_EXT_CTRL		BIT(15)
+#define LED_BCR_MODE_DISABLE		0
+#define LED_BCR_MODE_2LED		1
+#define LED_BCR_MODE_3LED_1		2
+#define LED_BCR_MODE_3LED_2		3
+
+#define LED_ON_DUR			0x22
+#define LED_ON_DUR_MASK			GENMASK(15, 0)
+
+#define LED_BLINK_DUR			0x23
+#define LED_BLINK_DUR_MASK		GENMASK(15, 0)
+
+#define LED_ON_CTRL(i)			(0x024 + ((i) * 2))
+#define  LED_ON_EVT_MASK		GENMASK(6, 0)
+#define  LED_ON_EVT_LINK_1000M		BIT(0)
+#define  LED_ON_EVT_LINK_100M		BIT(1)
+#define  LED_ON_EVT_LINK_10M		BIT(2)
+#define  LED_ON_EVT_LINK_DN		BIT(3)
+#define  LED_ON_EVT_FDX			BIT(4)
+#define  LED_ON_EVT_HDX			BIT(5)
+#define  LED_ON_EVT_FORCE		BIT(6)
+#define  LED_ON_POL			BIT(14)
+#define  LED_ON_EN			BIT(15)
+
+#define LED_BLINK_CTRL(i)		(0x025 + ((i) * 2))
+#define  LED_BLINK_EVT_MASK		GENMASK(9, 0)
+#define  LED_BLINK_EVT_1000M_TX		BIT(0)
+#define  LED_BLINK_EVT_1000M_RX		BIT(1)
+#define  LED_BLINK_EVT_100M_TX		BIT(2)
+#define  LED_BLINK_EVT_100M_RX		BIT(3)
+#define  LED_BLINK_EVT_10M_TX		BIT(4)
+#define  LED_BLINK_EVT_10M_RX		BIT(5)
+#define  LED_BLINK_EVT_FORCE		BIT(9)
+
+#define UNIT_LED_BLINK_DURATION		780
+#define LED_BLINK_DURATION(f)		(UNIT_LED_BLINK_DURATION << (f))
+
+/* Link on(1G/100M/10M), no activity */
+#define AIR_LED0_ON \
+	(LED_ON_EVT_LINK_1000M | LED_ON_EVT_LINK_100M | LED_ON_EVT_LINK_10M)
+#define AIR_LED0_BLINK			0x0
+/* No link on, activity(1G/100M/10M TX/RX) */
+#define AIR_LED1_ON			0x0
+#define AIR_LED1_BLINK \
+	(LED_BLINK_EVT_1000M_TX | LED_BLINK_EVT_1000M_RX | \
+	LED_BLINK_EVT_100M_TX | LED_BLINK_EVT_100M_RX | \
+	LED_BLINK_EVT_10M_TX | LED_BLINK_EVT_10M_RX)
+/* Link on(100M/10M), activity(100M/10M TX/RX) */
+#define AIR_LED2_ON \
+	(LED_ON_EVT_LINK_100M | LED_ON_EVT_LINK_10M)
+#define AIR_LED2_BLINK \
+	(LED_BLINK_EVT_100M_TX | LED_BLINK_EVT_100M_RX | \
+	LED_BLINK_EVT_10M_TX | LED_BLINK_EVT_10M_RX)
+
+#define INVALID_DATA			GENMASK(31, 0)
+
+#define AN8801_REG_PHY_INTERNAL0	0x600
+#define AN8801_REG_PHY_INTERNAL1	0x601
+
+#define AN8801_LED_ENABLE		1
+
+enum air_led_gpio_pin {
+	AIR_LED_GPIO1 = 1,
+	AIR_LED_GPIO2,
+	AIR_LED_GPIO3
+};
+
+enum air_led {
+	AIR_LED0 = 0,
+	AIR_LED1,
+	AIR_LED2,
+	AIR_LED3
+};
+
+enum air_led_blink_dut {
+	AIR_LED_BLINK_DUR_32M = 0,
+	AIR_LED_BLINK_DUR_64M,
+	AIR_LED_BLINK_DUR_128M,
+	AIR_LED_BLINK_DUR_256M,
+	AIR_LED_BLINK_DUR_512M,
+	AIR_LED_BLINK_DUR_1024M,
+	AIR_LED_BLINK_DUR_LAST
+};
+
+enum air_led_polarity {
+	AIR_ACTIVE_LOW = 0,
+	AIR_ACTIVE_HIGH,
+};
+
+enum air_led_mode {
+	AIR_LED_MODE_DISABLE = 0,
+	AIR_LED_MODE_USER_DEFINE,
+	AIR_LED_MODE_LAST
+};
+
+struct air_led_cfg {
+	u16 led_en;
+	u16 gpio;
+	u16 led_polarity;
+	u16 led_on_cfg;
+	u16 led_blk_cfg;
+};
+
+struct an8801r_priv {
+	struct air_led_cfg	led_cfg[AN8801R_MAX_LED_SIZE];
+	u32			led_blink_cfg;
+	u8			rxdelay_force;
+	u8			txdelay_force;
+	u16			rxdelay_step;
+	u8			rxdelay_align;
+	u16			txdelay_step;
+};
+
+#define phydev_cfg(phy)		((struct an8801r_priv *)(phy)->priv)
+
+/*
+ *	GPIO1 <-> LED0,
+ *	GPIO2 <-> LED1,
+ *	GPIO3 <-> LED2,
+ */
+static const struct an8801r_priv an8801r_priv_defaults = {
+	.led_cfg = {
+		/* LED Enable, GPIO, LED Polarity, LED ON, LED Blink */
+		{AN8801_LED_ENABLE, AIR_LED_GPIO1, AIR_ACTIVE_LOW,  AIR_LED0_ON, AIR_LED0_BLINK},
+		{AN8801_LED_ENABLE, AIR_LED_GPIO2, AIR_ACTIVE_HIGH, AIR_LED1_ON, AIR_LED1_BLINK},
+		{AN8801_LED_ENABLE, AIR_LED_GPIO3, AIR_ACTIVE_HIGH, AIR_LED2_ON, AIR_LED2_BLINK},
+	},
+	.led_blink_cfg = AIR_LED_BLINK_DUR_64M,
+	.rxdelay_force = false,
+	.txdelay_force = false,
+	.rxdelay_step = AIR_RGMII_DELAY_NOSTEP,
+	.rxdelay_align = false,
+	.txdelay_step = AIR_RGMII_DELAY_NOSTEP,
+};
+
+static int an8801_buckpbus_reg_rmw(struct phy_device *phydev,
+				   u32 addr, u32 mask, u32 set)
+{
+	return air_phy_buckpbus_reg_modify(phydev,
+					  addr | AN8801_PBUS_ACCESS,
+					  mask, set);
+}
+
+static int an8801_buckpbus_reg_set_bits(struct phy_device *phydev,
+					u32 addr, u32 mask)
+{
+	return air_phy_buckpbus_reg_modify(phydev,
+					  addr | AN8801_PBUS_ACCESS,
+					  mask, mask);
+}
+
+static int an8801_buckpbus_reg_clear_bits(struct phy_device *phydev,
+					  u32 addr, u32 mask)
+{
+	return air_phy_buckpbus_reg_modify(phydev,
+					  addr | AN8801_PBUS_ACCESS,
+					  mask, 0);
+}
+
+static int an8801_buckpbus_reg_write(struct phy_device *phydev, u32 addr, u32 data)
+{
+	return air_phy_buckpbus_reg_write(phydev, addr | AN8801_PBUS_ACCESS, data);
+}
+
+static int an8801r_led_set_usr_def(struct phy_device *phydev, u8 entity,
+				   u16 polar, u16 on_evt, u16 blk_evt)
+{
+	int ret;
+
+	if (polar == AIR_ACTIVE_HIGH)
+		on_evt |= LED_ON_POL;
+	else
+		on_evt &= ~LED_ON_POL;
+
+	on_evt |= LED_ON_EN;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, LED_ON_CTRL(entity), on_evt);
+	if (ret)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, LED_BLINK_CTRL(entity), blk_evt);
+}
+
+static int an8801r_led_set_blink(struct phy_device *phydev, u16 blink)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, LED_BLINK_DUR,
+			    LED_BLINK_DURATION(blink));
+	if (ret)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, LED_ON_DUR,
+			     LED_BLINK_DURATION(blink) / 2);
+}
+
+static int an8801r_led_set_mode(struct phy_device *phydev, u8 mode)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LED_BCR);
+	if (ret < 0)
+		return ret;
+
+	switch (mode) {
+	case AIR_LED_MODE_DISABLE:
+		ret &= ~LED_BCR_EXT_CTRL;
+		ret &= ~LED_BCR_MODE_MASK;
+		ret |= LED_BCR_MODE_DISABLE;
+		break;
+	case AIR_LED_MODE_USER_DEFINE:
+		ret |= LED_BCR_EXT_CTRL | LED_BCR_CLK_EN;
+		break;
+	}
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, LED_BCR, ret);
+}
+
+static int an8801r_led_set_state(struct phy_device *phydev, u8 entity, u8 state)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LED_ON_CTRL(entity));
+	if (ret < 0)
+		return ret;
+
+	if (state)
+		ret |= LED_ON_EN;
+	else
+		ret &= ~LED_ON_EN;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, LED_ON_CTRL(entity), ret);
+}
+
+static int an8801r_led_init(struct phy_device *phydev)
+{
+	struct an8801r_priv *priv = phydev_cfg(phydev);
+	struct air_led_cfg *led_cfg = priv->led_cfg;
+	u16 led_blink_cfg = priv->led_blink_cfg;
+	int ret, led_id;
+
+	ret = an8801r_led_set_blink(phydev, led_blink_cfg);
+	if (ret)
+		return ret;
+
+	ret = an8801r_led_set_mode(phydev, AIR_LED_MODE_USER_DEFINE);
+	if (ret) {
+		dev_err(phydev->dev, "AN8801R: Fail to set LED mode, ret %d!\n", ret);
+		return ret;
+	}
+
+	for (led_id = AIR_LED0; led_id < AN8801R_MAX_LED_SIZE; led_id++) {
+		ret = an8801r_led_set_state(phydev, led_id, led_cfg[led_id].led_en);
+		if (ret) {
+			dev_err(phydev->dev, "AN8801R: Fail to set LED%d state, ret %d!\n",
+				led_id, ret);
+			return ret;
+		}
+
+		if (!led_cfg[led_id].led_en)
+			continue;
+
+		ret = an8801_buckpbus_reg_set_bits(phydev, AN8801_BPBUS_REG_LED_GPIO,
+						   BIT(led_cfg[led_id].gpio));
+		if (ret)
+			return ret;
+
+		ret = an8801_buckpbus_reg_set_bits(phydev, AN8801_BPBUS_REG_LED_ID_SEL,
+						   LED_ID_GPIO_SEL(led_id,
+								   led_cfg[led_id].gpio));
+		if (ret)
+			return ret;
+
+		ret = an8801_buckpbus_reg_clear_bits(phydev, AN8801_BPBUS_REG_GPIO_MODE,
+						     BIT(led_cfg[led_id].gpio));
+		if (ret)
+			return ret;
+
+		ret = an8801r_led_set_usr_def(phydev, led_id,
+					      led_cfg[led_id].led_polarity,
+					      led_cfg[led_id].led_on_cfg,
+					      led_cfg[led_id].led_blk_cfg);
+		if (ret) {
+			dev_err(phydev->dev, "AN8801R: Fail to set LED%d, ret %d!\n",
+				led_id, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int an8801r_of_init(struct phy_device *phydev)
+{
+	struct an8801r_priv *priv = phydev_cfg(phydev);
+	ofnode node = phy_get_ofnode(phydev);
+	u32 val = 0;
+	int ret;
+
+	if (!ofnode_valid(node))
+		return -EINVAL;
+
+	if (ofnode_has_property(node, "airoha,rxclk-delay")) {
+		ret = ofnode_read_u32(node, "airoha,rxclk-delay", &val);
+		if (ret) {
+			dev_err(phydev->dev, "airoha,rxclk-delay value is invalid.\n");
+			return ret;
+		}
+		if (val > AIR_RGMII_DELAY_STEP_7) {
+			dev_err(phydev->dev, "airoha,rxclk-delay value %u out of range.\n", val);
+			return -EINVAL;
+		}
+		priv->rxdelay_force = true;
+		priv->rxdelay_step = val;
+		priv->rxdelay_align = ofnode_read_bool(node,
+						       "airoha,rxclk-delay-align");
+	}
+
+	if (ofnode_has_property(node, "airoha,txclk-delay")) {
+		ret = ofnode_read_u32(node, "airoha,txclk-delay", &val);
+		if (ret) {
+			dev_err(phydev->dev, "airoha,txclk-delay value is invalid.\n");
+			return ret;
+		}
+		if (val > AIR_RGMII_DELAY_STEP_7) {
+			dev_err(phydev->dev, "airoha,txclk-delay value %u out of range.\n", val);
+			return -EINVAL;
+		}
+		priv->txdelay_force = true;
+		priv->txdelay_step = val;
+	}
+	return 0;
+}
+
+static int an8801r_rgmii_rxdelay(struct phy_device *phydev, u16 delay, u8 align)
+{
+	u32 reg_val = delay & RGMII_DELAY_STEP_MASK;
+	int ret;
+
+	if (align) {
+		reg_val |= RGMII_RXDELAY_ALIGN;
+		debug("AN8801R: Rxdelay align\n");
+	}
+	reg_val |= RGMII_RXDELAY_FORCE_MODE;
+	ret = an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_RXDLY_STEP, reg_val);
+	if (ret)
+		return ret;
+
+	debug("AN8801R: Force rxdelay = %d(0x%x)\n", delay, reg_val);
+	return 0;
+}
+
+static int an8801r_rgmii_txdelay(struct phy_device *phydev, u16 delay)
+{
+	u32 reg_val = delay & RGMII_DELAY_STEP_MASK;
+	int ret;
+
+	reg_val |= RGMII_TXDELAY_FORCE_MODE;
+	ret = an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_TXDLY_STEP, reg_val);
+	if (ret)
+		return ret;
+
+	debug("AN8801R: Force txdelay = %d(0x%x)\n", delay, reg_val);
+	return 0;
+}
+
+static int an8801r_rgmii_delay_config(struct phy_device *phydev)
+{
+	struct an8801r_priv *priv = phydev_cfg(phydev);
+	int ret;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		return an8801r_rgmii_txdelay(phydev, AIR_RGMII_DELAY_STEP_4);
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		return an8801r_rgmii_rxdelay(phydev, AIR_RGMII_DELAY_NOSTEP, true);
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		ret = an8801r_rgmii_txdelay(phydev, AIR_RGMII_DELAY_STEP_4);
+		if (ret)
+			return ret;
+		return an8801r_rgmii_rxdelay(phydev, AIR_RGMII_DELAY_NOSTEP, true);
+	case PHY_INTERFACE_MODE_RGMII:
+	default:
+		if (priv->rxdelay_force) {
+			ret = an8801r_rgmii_rxdelay(phydev, priv->rxdelay_step,
+						    priv->rxdelay_align);
+			if (ret)
+				return ret;
+		}
+		if (priv->txdelay_force)
+			return an8801r_rgmii_txdelay(phydev, priv->txdelay_step);
+		return 0;
+	}
+}
+
+static int an8801r_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = an8801r_of_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_HWRST_DE_GLITCH,
+					AN8801_DE_GLITCH_EN |
+					AN8801_11_CYCLE_XTAL_PERIOD_DE_GLITCH);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AN8801_REG_PHY_INTERNAL0, 0x1e);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AN8801_REG_PHY_INTERNAL1, 0x02);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0x0);
+	if (ret)
+		return ret;
+
+	ret = an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_BYPASS_PTP,
+					AN8801_BYP_PTP_RGMII_TO_GPHY);
+	if (ret)
+		return ret;
+
+	ret = an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_EFIFO_CTL(0),
+					AN8801_EFIFO_RX_EN |
+					AN8801_EFIFO_TX_EN |
+					AN8801_EFIFO_RX_CLK_EN |
+					AN8801_EFIFO_TX_CLK_EN |
+					AN8801_EFIFO_RX_EEE_EN |
+					AN8801_EFIFO_TX_EEE_EN);
+	if (ret)
+		return ret;
+
+	ret = an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_EFIFO_CTL(1),
+					AN8801_EFIFO_ALL_EN);
+	if (ret)
+		return ret;
+
+	ret = an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_EFIFO_CTL(2),
+					AN8801_EFIFO_ALL_EN);
+	if (ret)
+		return ret;
+
+	ret = an8801r_rgmii_delay_config(phydev);
+	if (ret)
+		return ret;
+
+	ret = an8801r_led_init(phydev);
+	if (ret) {
+		dev_err(phydev->dev, "AN8801R: LED initialize fail, ret %d!\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int an8801r_phy_probe(struct phy_device *phydev)
+{
+	struct an8801r_priv *priv;
+	u32 phy_id;
+	int ret;
+
+	ret = get_phy_id(phydev->bus, phydev->addr, MDIO_DEVAD_NONE, &phy_id);
+	if (ret)
+		return ret;
+
+	if (phy_id != AN8801R_PHY_ID) {
+		dev_err(phydev->dev,
+			"AN8801R can't be detected (id=0x%08x).\n", phy_id);
+		return -ENODEV;
+	}
+
+	priv = malloc(sizeof(*priv));
+	if (!priv)
+		return -ENOMEM;
+
+	*priv = an8801r_priv_defaults;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static int an8801r_read_status(struct phy_device *phydev)
+{
+	u32 data;
+
+	if (!phydev->link)
+		return 0;
+
+	debug("AN8801R: SPEED %d\n", phydev->speed);
+	data = phydev->speed == SPEED_1000 ? AN8801_BPBUS_LINK_MODE_1000 : 0;
+
+	return an8801_buckpbus_reg_rmw(phydev, AN8801_BPBUS_REG_LINK_MODE,
+				       AN8801_BPBUS_LINK_MODE_1000, data);
+}
+
+static int an8801r_startup(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_startup(phydev);
+	if (ret)
+		return ret;
+
+	return an8801r_read_status(phydev);
+}
+
+U_BOOT_PHY_DRIVER(an8801r) = {
+	.name = "Airoha AN8801R",
+	.uid = AN8801R_PHY_ID,
+	.mask = 0x0ffffff0,
+	.features = PHY_GBIT_FEATURES,
+	.probe = &an8801r_phy_probe,
+	.config = &an8801r_config_init,
+	.read_page = &air_phy_read_page,
+	.write_page = &air_phy_write_page,
+	.startup = &an8801r_startup,
+	.shutdown = &genphy_shutdown,
+};

-- 
2.52.0

