Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD16D29DE9
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F3282C7F;
	Tue, 13 Jan 2026 09:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="U6nnkMmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512B5836AC; Tue, 13 Jan 2026 09:20:40 +0100 (CET)
Received: from mx-relay35-hz1.antispameurope.com
 (mx-relay35-hz1.antispameurope.com [94.100.133.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4D3808AF
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=04663608a3=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate35-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=X80TgLhM3ppOHxSbAuE+sxtluCtbT/5Iv1S4MOApUVw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768292437;
 b=es4UIYMvSWzblASlXcmLI0/iUND3yAKbfbnznfco/PSG+alTFb5LxNuD93AYmy9pOnrbnGtR
 3FQ9WjoJIrleilM4rZ67TJoU99giuKL5O3FStB3wnjHUtQqiCbZMTwS4nwTABRh0+SLCFeWMsKH
 +pc2T6iEDXzWObQawfyay7jLTMOBT8+yEGwyd4OP/CMFGq8mo42s5kN9/3V9a4KbJjXsOFE0aZl
 KspMWdFtY/+SRHbwby+WIb8LY16JF+C1c1Hyf1UQMP66DqaWhyvjv6kjqxqLmF8GBMNtj9MO3FP
 W2ViU9gQ08XOkMF/3t8KxPmc+dkdTMqaUhIsChU4CJsRw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768292437;
 b=l9QqYTUdNBJk3px+qgVsqmUjLSmVagLF46gT1cmn2Lz0LKoXv2ZypteegU6TjEtPN8J+o+b8
 r1ulwFTljsWDMP0D4GLygOoH+Ur9oCqVNA98hgOPT1EBAv0qGtbedVGB2T3v00wO711n2+yAMPN
 l3tJbOZpLduyx1Kus2B2p8o9dR8fll+iA/xoTRosx2SgzSUh0obq8qENUR81zt68UWjVLZHTWgP
 3OAsz+rWzOMK4Y8A0m106iFcQTyyPiFmdfNeNP/KtOY252YZ+lqccISeMQPC3IxipYVb7/gOr8W
 7SAx08P4gcgWJWv6w6dcrs0E9UomzOR1g30o8Ke9p2Q8Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay35-hz1.antispameurope.com; Tue, 13 Jan 2026 09:20:37 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 19DE5A415AC;
 Tue, 13 Jan 2026 09:20:20 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Quentin Schulz <quentin.schulz@cherry.de>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [RESEND PATCH v2 2/2] net: phy: micrel_ksz90x1: support forced GIGE
 master for KSZ9031
Date: Tue, 13 Jan 2026 09:16:38 +0100
Message-ID: <20260113081726.502484-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113081726.502484-1-Max.Merchel@ew.tq-group.com>
References: <20260113081726.502484-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay35-hz1.antispameurope.com with 4dr2HS4hzRz17b6h
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 03fb3b848e04d295f67f59b878c9e20f
X-cloud-security: scantime:1.924
DKIM-Signature: a=rsa-sha256;
 bh=X80TgLhM3ppOHxSbAuE+sxtluCtbT/5Iv1S4MOApUVw=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768292437; v=1;
 b=U6nnkMmxiFf19kzdE3TsN/sKKO2LKvuPXv0ME5ecKpjBG2wJB71ruanm+nLUq1mEeM9mhzyo
 aYhP0bPst+UnnjOGWxaSSsOs4QbKcFHyviwpte7KM061SBQyxyZkwDybZMZWrhlHnNtIRDipmpH
 w/BpsYS4CmmS6Gxdjmj1IWqbmnUxZTEqC/ATRJHCBV3FrUIgT5b/PvFxYd2tl/VrGyArijNdT/g
 tq3AAw8o4TPEdzjR17dzlhRtyT9kGyze2d+aKBHafBb5tdLc4AqitR0sang+QFboa6FjksE4axu
 aNlO2XbZcf2o327DHjSYVVegY/Qr2t1+iil8r+AviqcGA==
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
index 3066c2ed73f..346e248c6f5 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -189,7 +189,10 @@ static int ksz9031_of_config(struct phy_device *phydev)
 		{ MII_KSZ9031_EXT_RGMII_TX_DATA_SKEW, 2, ksz90x1_txd_grp, 4 },
 		{ MII_KSZ9031_EXT_RGMII_CLOCK_SKEW, 2, ksz9031_clk_grp, 2 },
 	};
+	const unsigned int master = CTRL1000_CONFIG_MASTER | CTRL1000_MANUAL_CONFIG;
+	struct udevice *dev = phydev->dev;
 	int i, ret = 0;
+	ofnode node;
 
 	for (i = 0; i < ARRAY_SIZE(ofcfg); i++) {
 		ret = ksz90x1_of_config_group(phydev, &ofcfg[i],
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

