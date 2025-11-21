Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66731CFA468
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 668DA801CF;
	Fri, 21 Nov 2025 09:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UfAk7Qnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E0B835B3; Fri, 21 Nov 2025 09:20:08 +0100 (CET)
Received: from mx-relay08-hz2.antispameurope.com
 (mx-relay08-hz2.antispameurope.com [83.246.65.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F114980077
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413995d28=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate08-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=5Y8zFNLMDLQHzs4z33U7g7t3XgseTLJAQ+NInfhgq2Y=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763713205;
 b=H2UW7Bz/uo/ZnR+X2i2L13Mq1o4Ch01+3c7dO0ehe3azNYZzXHcSwRsj39L13Zsq6Q8TI2k2
 5XWSuRYN7fVV4z5MncXFXuPGYz7Pj5a8YMK2enrq7k9vY4ByUnjv1Ce293Hpz+nBQyCMdYJKdmL
 AxINlObjIuyqPZIxi67vSQK5au7JSy80n7PmLBd+wCtcptdCmjnPiQmXlBdtRYjAFz8vj+oHQe9
 UY7WisJhQDFInwqs42wyX++3zrD1KSiRUzcCTBptstwUnZt5YGTSoinENOneRnIQs3HnVktD1bg
 +ldzEbuzu0Rix6rf2b4SiEDNmKlZoAUVZyyQZQZoP6ooA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763713205;
 b=PyqoRdXRycN3GZ1SVLpNtNgnes6kINCHIaNPm6Xe28HvYCQ84fkOET95NvuvjlCP/w968Y+R
 FRycb7Mh4JrdptnB18n+mBVghKcivi5Sf9DmvbDOADPrhVGRQSg3gr2DN3Rsz1kqSWCTMsHxp+F
 PWQ+lkn447sf9Oqt9bOnSfrChFRcbGAdGa/gezZW3g7+y+F4/8ZEdEt8gQc91PeQj2mqq1Y8U66
 ZndkFSVQ9DWsYYtoJsTJz6qptH9G032FjI7PwjoVNLw8ipilRjl4s2o5aS+/XT29/VAa5c1H/4T
 fBgCjNztDGzl9t1j2KJxdcW+LNwZNVwi3b5CXASdCrapg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay08-hz2.antispameurope.com; Fri, 21 Nov 2025 09:20:05 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 099A45A087B;
 Fri, 21 Nov 2025 09:19:50 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 2/2] net: phy: micrel_ksz90x1: support forced GIGE master for
 KSZ9031
Date: Fri, 21 Nov 2025 09:18:07 +0100
Message-ID: <20251121081810.73852-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121081810.73852-1-Max.Merchel@ew.tq-group.com>
References: <20251121081810.73852-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay08-hz2.antispameurope.com with 4dCSnL3vn6z14dst
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: bf81beed565b16236be96eb5aa91e6ea
X-cloud-security: scantime:2.066
DKIM-Signature: a=rsa-sha256;
 bh=5Y8zFNLMDLQHzs4z33U7g7t3XgseTLJAQ+NInfhgq2Y=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763713204; v=1;
 b=UfAk7Qnm2FwL0V42HbfcxzjHUztqWYQ6pbAQzcA1Ffx9Pg2E8IVLHU/PuIOvtVRHulYu3NRU
 3ITpsPUcOuJgoFYgQKOQQge6GqYraOk+R16QZhjPtmLmNnfhkeWeg3uWmzuyR0yGjDZF8ZX0LVJ
 IDC0E/ZnH7lMWmbmAq0twG9GZEWH5b240Gt3U2UrvEDfTWUN1DjbYWwmgYum+HE21rXFTIkwpsA
 BOvrEO+NdU3plmqYcbA1pE4qm2KEx7oEQCYw0+MUvz1qPm3RTZcsjFqcIXJ/YW0Ord2nIs3fVjL
 iKPhbiUc5rG9xapvukQk3l9wDUYvwBlIg0QynlLbImFaA==
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The micrel KSZ9031 phy has a optional clock pin (CLK125_NDO) which can be
used as reference clock for the MAC unit. The clock signal must meet the
RGMII requirements to ensure the correct data transmission between the
MAC and the PHY. The KSZ9031 phy does not fulfill the duty cycle
requirement if the phy is configured as slave. For a complete
describtion look at the errata sheets: DS80000691D or DS80000692D.

The errata sheet recommends to force the phy into master mode whenever
there is a 1000Base-T link-up as work around. Only set the
"micrel,force-master" property if you use the phy reference clock provided
by CLK125_NDO pin as MAC reference clock in your application.

Attention: this workaround is only usable if the link partner can
be configured to slave mode for 1000Base-T.

This follows linux implementation in commit
e1b505a60366 ("net: phy: micrel: add 125MHz reference clock workaround")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 drivers/net/phy/micrel_ksz90x1.c | 37 +++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index bc42506c65e..1c0a58e25de 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -189,6 +189,9 @@ static int ksz9031_of_config(struct phy_device *phydev)
 		{ MII_KSZ9031_EXT_RGMII_TX_DATA_SKEW, 2, ksz90x1_txd_grp, 4 },
 		{ MII_KSZ9031_EXT_RGMII_CLOCK_SKEW, 2, ksz9031_clk_grp, 2 },
 	};
+	const unsigned int master = CTRL1000_CONFIG_MASTER | CTRL1000_MANUAL_CONFIG;
+	struct udevice *dev = phydev->dev;
+	ofnode node;
 	int i, ret = 0;
 
 	for (i = 0; i < ARRAY_SIZE(ofcfg); i++) {
@@ -198,7 +201,39 @@ static int ksz9031_of_config(struct phy_device *phydev)
 			return ret;
 	}
 
-	return 0;
+	node = phydev->node;
+
+	/* Look for a PHY node under the Ethernet node */
+	if (!ofnode_valid(node))
+		node = dev_read_subnode(dev, "ethernet-phy");
+
+	/* No node found, look in the Ethernet node */
+	if (!ofnode_valid(node))
+		node = dev_ofnode(dev);
+
+	/* Silicon Errata Sheet (DS80000691D or DS80000692D):
+	 * When the device links in the 1000BASE-T slave mode only,
+	 * the optional 125MHz reference output clock (CLK125_NDO)
+	 * has wide duty cycle variation.
+	 *
+	 * The optional CLK125_NDO clock does not meet the RGMII
+	 * 45/55 percent (min/max) duty cycle requirement and therefore
+	 * cannot be used directly by the MAC side for clocking
+	 * applications that have setup/hold time requirements on
+	 * rising and falling clock edges.
+	 *
+	 * Workaround:
+	 * Force the phy to be the master to receive a stable clock
+	 * which meets the duty cycle requirement.
+	 */
+	if (ofnode_read_bool(node, "micrel,force-master")) {
+		ret = phy_modify(phydev, MDIO_DEVAD_NONE, MII_CTRL1000,
+				 master | CTRL1000_PREFER_MASTER, master);
+		if (ret < 0)
+			pr_err("KSZ9031: error applying 'micrel,force-master'\n");
+	}
+
+	return ret;
 }
 
 static int ksz9031_center_flp_timing(struct phy_device *phydev)
-- 
2.43.0

