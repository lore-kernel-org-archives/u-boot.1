Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CA6CE8E8B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4841488FB7;
	Thu, 24 Oct 2024 17:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D62D88D3F; Thu, 24 Oct 2024 17:25:31 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id E61B488FB7
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="226887993"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:20 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8C56C4008C65;
 Fri, 25 Oct 2024 00:25:09 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 02/14] pinctrl: rzg2l: Support 2.5V PVDD for Ethernet
 interfaces
Date: Thu, 24 Oct 2024 16:24:36 +0100
Message-Id: <20241024152448.102-3-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
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

The Ethenet interfaces on the Renesas RZ/G2L SoC family can operate at
multiple power supply voltages: 3.3V (default value), 2.5V and 1.8V.

rzg2l_pinconf_set() is extended to support the 2.5V setting, with a
check to ensure this is only used on Ethernet interfaces as it is not
supported on the SD & QSPI interfaces.

While we're modifying rzg2l_pinconf_set(), drop the unnecessary default
value for pwr_reg as it is set in every branch of the following if
condition.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/pinctrl/renesas/rzg2l-pfc.c | 49 ++++++++++++++++++++---------
 include/renesas/rzg2l-pfc.h         |  2 ++
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
index e88ec1c18373..0098e2d52d57 100644
--- a/drivers/pinctrl/renesas/rzg2l-pfc.c
+++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
@@ -394,18 +394,10 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	}
 
 	case PIN_CONFIG_POWER_SOURCE: {
-		u32 pwr_reg = 0x0;
+		bool support_2500 = false;
+		u32 pwr_reg;
+		u32 value;
 
-		/* argument is in mV */
-		if (argument != 1800 && argument != 3300) {
-			dev_err(dev, "Invalid mV %u\n", argument);
-			return -EINVAL;
-		}
-
-		/*
-		 * TODO: PIN_CFG_IO_VMC_ETH0 & PIN_CFG_IO_VMC_ETH1 will be
-		 * handled when the RZ/G2L Ethernet driver is added.
-		 */
 		if (cfg & PIN_CFG_IO_VMC_SD0) {
 			dev_dbg(dev, "port off %u:%u set SD_CH 0 PVDD=%u\n",
 				port_offset, pin, argument);
@@ -418,13 +410,42 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			dev_dbg(dev, "port off %u:%u set QSPI PVDD=%u\n",
 				port_offset, pin, argument);
 			pwr_reg = QSPI;
+		} else if (cfg & PIN_CFG_IO_VMC_ETH0) {
+			dev_dbg(dev, "port off %u:%u set ETH0 PVDD=%u\n",
+				port_offset, pin, argument);
+			pwr_reg = ETH_POC(0);
+			support_2500 = true;
+		} else if (cfg & PIN_CFG_IO_VMC_ETH1) {
+			dev_dbg(dev, "port off %u:%u set ETH1 PVDD=%u\n",
+				port_offset, pin, argument);
+			pwr_reg = ETH_POC(1);
+			support_2500 = true;
 		} else {
-			dev_dbg(dev, "pin power source is not selectable\n");
+			dev_dbg(dev, "port off %u:%u PVDD is not selectable\n",
+				port_offset, pin);
+			return -EINVAL;
+		}
+
+		/* argument is in mV */
+		switch (argument) {
+		case 1800:
+			value = PVDD_1800;
+			break;
+		case 3300:
+			value = PVDD_3300;
+			break;
+		case 2500:
+			if (support_2500) {
+				value = PVDD_2500;
+				break;
+			}
+			fallthrough;
+		default:
+			dev_err(dev, "Invalid mV %u\n", argument);
 			return -EINVAL;
 		}
 
-		writel((argument == 1800) ? PVDD_1800 : PVDD_3300,
-		       data->base + pwr_reg);
+		writel(value, data->base + pwr_reg);
 		break;
 	}
 
diff --git a/include/renesas/rzg2l-pfc.h b/include/renesas/rzg2l-pfc.h
index 2df17ece2a31..d1015b1d2ac1 100644
--- a/include/renesas/rzg2l-pfc.h
+++ b/include/renesas/rzg2l-pfc.h
@@ -77,9 +77,11 @@
 #define IEN(n)			(0x1800 + (n) * 8)
 #define PWPR			0x3014
 #define SD_CH(n)		(0x3000 + (n) * 4)
+#define ETH_POC(ch)		(0x300c + (ch) * 4)
 #define QSPI			0x3008
 
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
+#define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_3300		0	/* I/O domain voltage >= 3.3V */
 
 #define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
-- 
2.43.0

