Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAC3C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FC388092;
	Tue, 26 Mar 2024 13:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711454891;
	bh=TJD8RoFe3KdjpbNT8zQpmh1o9MQkg9GKOeTWQbyZ7Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b+WxGnawBpZ3uslIc8owDLs9hdi7iSINmhehnFAfcZmPz+Kj5cJVmO4unVDqbw9DR
	 RKzZdpnz75gLE36Bq7815tzrF1G4JsHhGNyp4Vl9Wn5+5YAjQanz17Ky3wcUwJtUxP
	 d67T+OdFFkm9+IiP+jPWUu4BoXHl+d380LKd+CuqkC0ydi7nyEksX+CSaN+VsS0M0e
	 kHXc/Tl5iHgKu9QI6bpeRqYucTknTnN8pq0IGYXafdzOarRbmSb46LDI6tkw88N029
	 C6YIdv83oVSgloZ3rw7WEuQywGiiMpzY7ASRNgqjMx+zJ8y0Tg7mTNk2rskl/N679u
	 DLE5A3QmwV/gA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BB95A88076;
 Tue, 26 Mar 2024 13:08:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711454888;
 bh=TJD8RoFe3KdjpbNT8zQpmh1o9MQkg9GKOeTWQbyZ7Ec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CIpfhIllpXDNSnbevUV8lkbCfb7SLA8d8RFCYoPdzYb7HIU+E0kkM4QyE83TSa1BW
 STab3RgDuVA23sUCAXerA+wK5re7fkcM7tC1DGxASPp5QzWbHIWcHfRocNCZAREtY6
 jipr9x3Vb9dibzcizBoeGjk7b8yymOWt9uJ15cnATRWzzlHZ93fb1dWvSDDPSsSaxU
 k2ZxtpN0xsNujuyqOl8t7c4dZjo8mVjVQU/D4/UbiDrXWULkI8VIJUsXte+UnOdEZ8
 pH48VLFJBBgjfmRyI7biDYspMEfz/02qHuHyn05TL97tqJkCzdwL0vBfHCu4lqQsM2
 JkL9Leg837syQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 05/11] net: dwc_eth_qos: Use FIELD_PREP for ETH_SEL bitfield
Date: Tue, 26 Mar 2024 13:07:26 +0100
Message-ID: <20240326120745.27581-6-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326120745.27581-1-marex@denx.de>
References: <20240326120745.27581-1-marex@denx.de>
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

Use FIELD_PREP to configure content of ETH_SEL bitfield in SYSCFG_PMCSETR
register. No functional change.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christophe Roullier <christophe.roullier@st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Add RB from Patrice
---
 drivers/net/dwc_eth_qos_stm32.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index d7ec0c9be36..7545026b158 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -26,6 +26,7 @@
 #include <reset.h>
 #include <syscon.h>
 #include <wait_bit.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 
 #include "dwc_eth_qos.h"
@@ -40,9 +41,9 @@
 #define SYSCFG_PMCSETR_ETH_SELMII	BIT(20)
 
 #define SYSCFG_PMCSETR_ETH_SEL_MASK	GENMASK(23, 21)
-#define SYSCFG_PMCSETR_ETH_SEL_GMII_MII	0
-#define SYSCFG_PMCSETR_ETH_SEL_RGMII	BIT(21)
-#define SYSCFG_PMCSETR_ETH_SEL_RMII	BIT(23)
+#define SYSCFG_PMCSETR_ETH_SEL_GMII_MII	0x0
+#define SYSCFG_PMCSETR_ETH_SEL_RGMII	0x1
+#define SYSCFG_PMCSETR_ETH_SEL_RMII	0x4
 
 static ulong eqos_get_tick_clk_rate_stm32(struct udevice *dev)
 {
@@ -142,35 +143,33 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 
 	switch (interface_type) {
 	case PHY_INTERFACE_MODE_MII:
-		value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
-			SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
+		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
+				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
+		value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
 		log_debug("PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
+		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
+				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
 		if (eth_clk_sel_reg)
-			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
-				SYSCFG_PMCSETR_ETH_CLK_SEL;
-		else
-			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII;
+			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
 		log_debug("PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
+		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
+				   SYSCFG_PMCSETR_ETH_SEL_RMII);
 		if (eth_ref_clk_sel_reg)
-			value = SYSCFG_PMCSETR_ETH_SEL_RMII |
-				SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
-		else
-			value = SYSCFG_PMCSETR_ETH_SEL_RMII;
+			value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
 		log_debug("PHY_INTERFACE_MODE_RMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
+		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
+				   SYSCFG_PMCSETR_ETH_SEL_RGMII);
 		if (eth_clk_sel_reg)
-			value = SYSCFG_PMCSETR_ETH_SEL_RGMII |
-				SYSCFG_PMCSETR_ETH_CLK_SEL;
-		else
-			value = SYSCFG_PMCSETR_ETH_SEL_RGMII;
+			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
 		log_debug("PHY_INTERFACE_MODE_RGMII\n");
 		break;
 	default:
-- 
2.43.0

