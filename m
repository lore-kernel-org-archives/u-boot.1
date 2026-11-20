Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD27606C966
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rMjXDSAR;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=X0NyzKRx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D69BA40E83;
	Fri, 20 Nov 2026 18:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0s-hNLfuJ67; Fri, 20 Nov 2026 18:13:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20A7940E7C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795198420;
	b=G/HnclkXWv0pI5AbvLRLouZIWiNM9ggxAGNT0rQ/ZFPdOpsJHmIAapmd91x/WhsjkmVT
	 n2Oq/g7tjMDjYrHj05CnnntLipsfSAb+vtZXDfrtrjC+MDpBo9J8Tud5EiWLLc+Rmw5T6
	 SoY2f0bBB+MYFfCDdFNZMlZrz8NxlI0n9rzTDAfHTPm/ybOw/OOed8LIkVCaeU05idUIW
	 4I7cF7stwpFMcG9BM6XR6KZ18Hia/wA95tJHRdKswMPGGkv59dGMns3YSi/xhS6bMXP+2
	 /lRxG2l6MbRl0fqNDB4N4RRYNP0Ko5kmhMl3kI/A2Mcy/4uC0gWt+wpawlQVk4RQbZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iUtU0fi2swk5SIJR+DN5qnIrbnIGlkbMlKms2Q5quf4=;
	b=g1k2kVbA3W310jUDiQwmkRGrILMZe690RcjK/947k6iAaR7Xa5AwhIB1E3UINdm+OJJ2
	 gj5vhil461E9BuH/WOnCQkwN3FZUwIxc/E2bFm/CkKczJ3lWVexgY1YdDTbvMN6g807Ml
	 Mcj6lY+qsRUQqiRMuLv4AQVFy/JFzUku/UFIYaGKi69dzU/kfu364PMwKAywWCBoFVwm3
	 113rEflXsjcykfGotlcHGwl3W509tZTUJAF6FWiBRaqxyjJWCZp364ULuDsAhxPXI2fYU
	 8JzgbeavUgNWF45uaOmGcaeojoNd3LcWYgji3ykjAeoN86Jets9qCUuOLmnHmoRZ8mA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795198420;
	bh=iUtU0fi2swk5SIJR+DN5qnIrbnIGlkbMlKms2Q5quf4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMjXDSAR66ANH/HvjDPrysyZkaVt//tYvGOpCTOPA7ksWypfjV4GMpPmt4SaY7CjU
	 cRZBUxeI9swty6Li/NL/Lw9NwthUkVlarJ0NG5+0JhVrpowcLdlGokqhFJtButgySA
	 bdPF5/xe2Z1ooLu/9W9X7za1/jicY3Gb02YoH6/5yKkjV2i/gEx5leu8KCNbpsCDOq
	 pwhNmLDRotItGllevlnrGZSqCIEE532M7XcckKMVZKQKTm0F94zJyDPlH5dD6Sxrgr
	 zEKcMCNKDS3tF0JH0zjWEuaETdBwGvwgC5TLpS5FOmTSQrY94wQzFKRneHRbCwLN/1
	 8aQvWMi4CvsgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20A7940E7C;
	Fri, 20 Nov 2026 18:13:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 28E951E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0846760EA4
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yR3VXsxVop-1 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86C6A60790
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7779e6c3c=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=X0NyzKRx
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86C6A60790
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1795198421; x=1826734421;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=YpO80a1up3ly7nACWNn6cprOaj7l8hwMXNf8lcPhEqE=;
 b=X0NyzKRx0VE03ZiXSpKaISbBoUMYU33AYO7X4dnJf//ch9htAXmVginm
 9XhDsp4mfj2tP04JWUrsZ0vZz0mi4i9UuKMcKSaJUXHwW4cxupAt0lze+
 BxlMcS/R9sS3LacfCHytJgDpgxGanGqNd0HEkISo/IPjRLLUwmZZ4wPAv
 9HMR6wNccz4fz07XnUZpO/dbKbNwLN/A/mwFChz5z/YIBWaFBeupAj9Q0
 i2y4R4w+qtD89i4xX1Swnz5vWFkS7MgzvXRFnNeoNEvRLmGFcku5IDH6s
 4mx4QrpqRmWxOeutA5iHXok/LEFlplw9z6p+7Q5LDXwqpizUDxY61YuKZ w==;
X-CSE-ConnectionGUID: iyq3JVeXSKOBVdJVZuQSzA==
X-CSE-MsgGUID: Hr9EE2MpT7K1fKRGjlSyYA==
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="298246815"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 11:13:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 11:13:32 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 20 Nov 2026 11:13:30 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 20 Nov 2026 13:13:02 -0500
Subject: [PATCH 3/6] net: macb: remove open coded phy_startup()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-add-macb-support-for-dm-mdio-v1-3-d344297d5b44@microchip.com>
References: <20261120-add-macb-support-for-dm-mdio-v1-0-d344297d5b44@microchip.com>
In-Reply-To: <20261120-add-macb-support-for-dm-mdio-v1-0-d344297d5b44@microchip.com>
To: <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Nathan Whitehorn <nwhitehorn@pa.msu.edu>, Conor Dooley
 <conor@kernel.org>, Romain Caritey <romain.caritey@microchip.com>, "Mame
 Maria Mbaye" <MameMaria.Mbaye@microchip.com>, Charles Perry
 <charles.perry@microchip.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the open coded loop that polls MII_BMSR with phy_startup().  This
changes the timeout from 5 seconds (MACB_AUTONEG_TIMEOUT) to 4 seconds.
Keep the 10ms delay after link-up is detected as that might be important on
some platforms.

Also remove macb_phy_reset() that restarts autoneg which is already done by
phy_config().

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/macb.c | 64 ++++++++++--------------------------------------------
 1 file changed, 11 insertions(+), 53 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index f3850022e721..c23ca588a2d9 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -61,7 +61,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define MACB_TX_RING_SIZE		16
 
 #define MACB_TX_TIMEOUT		1000
-#define MACB_AUTONEG_TIMEOUT	5000000
 
 #ifdef CONFIG_MACB_ZYNQ
 /* INCR4 AHB bursts */
@@ -539,35 +538,6 @@ static int _macb_recv(struct macb_device *macb, uchar **packetp)
 	}
 }
 
-static void macb_phy_reset(struct macb_device *macb, const char *name)
-{
-	int i;
-	u16 status, adv;
-
-	if (macb->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
-	    macb->phy_sub_interface == PHY_INTERFACE_MODE_1000BASEX)
-		adv = ADVERTISE_1000XFULL;
-	else
-		adv = ADVERTISE_CSMA | ADVERTISE_ALL;
-	macb_mdio_write(macb, macb->phy_addr, MII_ADVERTISE, adv);
-	printf("%s: Starting autonegotiation...\n", name);
-	macb_mdio_write(macb, macb->phy_addr, MII_BMCR, (BMCR_ANENABLE
-					 | BMCR_ANRESTART));
-
-	for (i = 0; i < MACB_AUTONEG_TIMEOUT / 100; i++) {
-		status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
-		if (status & BMSR_ANEGCOMPLETE)
-			break;
-		udelay(100);
-	}
-
-	if (status & BMSR_ANEGCOMPLETE)
-		printf("%s: Autonegotiation complete\n", name);
-	else
-		printf("%s: Autonegotiation timed out (status=0x%04x)\n",
-		       name, status);
-}
-
 static int macb_phy_find(struct macb_device *macb, const char *name)
 {
 	int i;
@@ -687,10 +657,9 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 {
 	struct macb_device *macb = dev_get_priv(dev);
 	u32 ncfgr;
-	u16 phy_id, status, adv, lpa;
+	u16 phy_id, adv, lpa;
 	int media, speed, duplex;
 	int ret;
-	int i;
 
 	arch_get_mdio_control(name);
 	/* If port is not fixed -> setup PHY */
@@ -730,31 +699,20 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 			return ret;
 		}
 
-		status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
-		if (!(status & BMSR_LSTATUS)) {
-			/* Try to re-negotiate if we don't have link already. */
-			macb_phy_reset(macb, name);
-
-			for (i = 0; i < MACB_AUTONEG_TIMEOUT / 100; i++) {
-				status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
-				if (status & BMSR_LSTATUS) {
-					/*
-					 * Delay a bit after the link is established,
-					 * so that the next xfer does not fail
-					 */
-					mdelay(10);
-					break;
-				}
-				udelay(100);
-			}
-		}
+		ret = phy_startup(macb->phydev);
+		if (ret)
+			return ret;
 
-		if (!(status & BMSR_LSTATUS)) {
-			printf("%s: link down (status: 0x%04x)\n",
-			       name, status);
+		if (!macb->phydev->link) {
+			printf("%s: link down\n", name);
 			return -ENETDOWN;
 		}
 
+		/* Delay a bit after the link is established, so that the next
+		 * xfer does not fail
+		 */
+		mdelay(10);
+
 		adv = macb_mdio_read(macb, macb->phy_addr, MII_ADVERTISE);
 		lpa = macb_mdio_read(macb, macb->phy_addr, MII_LPA);
 

-- 
2.53.0

