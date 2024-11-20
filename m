Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEE5D60D17
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FA28964F;
	Wed, 20 Nov 2024 10:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E42758964F; Wed, 20 Nov 2024 10:48:55 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 19E9988B6D
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: io1LMI9JTLiwkUHdKcNaPA==
X-CSE-MsgGUID: VN3srXlxR46w9rZOrKOrRQ==
X-IronPort-AV: E=Sophos;i="6.12,169,1728918000"; d="scan'208";a="229403987"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 20 Nov 2024 18:48:51 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.28])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 277E141A351A;
 Wed, 20 Nov 2024 18:48:37 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/3] pinctrl: rzg2l: Support Ethernet TXC output enable
Date: Wed, 20 Nov 2024 09:48:29 +0000
Message-Id: <20241120094830.71-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
References: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
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

On the RZ/G2L SoC family, the direction of the Ethernet TXC/TX_CLK
signal is selectable to support an Ethernet PHY operating in either MII
or RGMII mode. By default, the signal is configured as an input and MII
mode is supported. The ETH_MODE register can be modified to configure
this signal as an output to support RGMII mode.

As this signal is be default an input, and can optionally be switched to
an output, it maps neatly onto an `output-enable` property in the device
tree.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
Changes v1->v2:
  - Split out of series adding RZ/G2L Ethernet support [1]

[1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/

 drivers/pinctrl/renesas/rzg2l-pfc.c | 31 +++++++++++++++++++++++++++--
 include/renesas/rzg2l-pfc.h         |  2 ++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
index 0098e2d52d57..af371bd0ff1e 100644
--- a/drivers/pinctrl/renesas/rzg2l-pfc.c
+++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
@@ -180,7 +180,7 @@ static const u32 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0) | PIN_CFG_OEN),
 	RZG2L_GPIO_PORT_PACK(2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
 	RZG2L_GPIO_PORT_PACK(2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
 	RZG2L_GPIO_PORT_PACK(2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
@@ -189,7 +189,7 @@ static const u32 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
 	RZG2L_GPIO_PORT_PACK(2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
 	RZG2L_GPIO_PORT_PACK(2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1) | PIN_CFG_OEN),
 	RZG2L_GPIO_PORT_PACK(2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
 	RZG2L_GPIO_PORT_PACK(2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
 	RZG2L_GPIO_PORT_PACK(2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
@@ -449,6 +449,32 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		break;
 	}
 
+	case PIN_CONFIG_OUTPUT_ENABLE: {
+		u8 ch;
+
+		if (!(cfg & PIN_CFG_OEN)) {
+			dev_err(dev, "pin does not support OEN\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * We can determine which Ethernet interface we're dealing with from
+		 * the caps.
+		 */
+		if (cfg & PIN_CFG_IO_VMC_ETH0)
+			ch = 0;
+		else /* PIN_CFG_IO_VMC_ETH1 */
+			ch = 1;
+
+		dev_dbg(dev, "set ETH%u TXC OEN=%u\n", ch, argument);
+		if (argument)
+			clrbits_8(data->base + ETH_MODE, BIT(ch));
+		else
+			setbits_8(data->base + ETH_MODE, BIT(ch));
+
+		break;
+	}
+
 	default:
 		dev_err(dev, "Invalid pinconf parameter\n");
 		return -EOPNOTSUPP;
@@ -542,6 +568,7 @@ static int rzg2l_get_pin_muxing(struct udevice *dev, unsigned int selector,
 
 static const struct pinconf_param rzg2l_pinconf_params[] = {
 	{ "input-enable",	PIN_CONFIG_INPUT_ENABLE,	1 },
+	{ "output-enable",	PIN_CONFIG_OUTPUT_ENABLE,	1 },
 	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	3300 /* mV */ },
 };
 
diff --git a/include/renesas/rzg2l-pfc.h b/include/renesas/rzg2l-pfc.h
index d1015b1d2ac1..36fa8da8e2e4 100644
--- a/include/renesas/rzg2l-pfc.h
+++ b/include/renesas/rzg2l-pfc.h
@@ -22,6 +22,7 @@
 #define PIN_CFG_FILONOFF		BIT(10)
 #define PIN_CFG_FILNUM			BIT(11)
 #define PIN_CFG_FILCLKSEL		BIT(12)
+#define PIN_CFG_OEN			BIT(13)
 
 #define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
 					 PIN_CFG_SR | \
@@ -79,6 +80,7 @@
 #define SD_CH(n)		(0x3000 + (n) * 4)
 #define ETH_POC(ch)		(0x300c + (ch) * 4)
 #define QSPI			0x3008
+#define ETH_MODE		(0x3018)
 
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
-- 
2.43.0

