Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28768606C961
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PhuWC82t;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=b99OFR4y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01FB560EAE;
	Fri, 20 Nov 2026 18:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FnpUMsXpAnLO; Fri, 20 Nov 2026 18:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A91560EB2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795198421;
	b=ZnR35iJYhqmXRZDETiUANctDygeNQtDZXC8rM9wfPhiiOgkvZARRxymhRfpIfng5tPqi
	 9YFIjtKxptX+CAfLUdCMqKYW4YtwT7EV3qL8EVYQWgCkj5AxOZ0odP719ZxouVs1VMfo4
	 mUwz56B2bN+TSV/N2Kug9FBQmpbs0fGp5WIgO09duOq9399kdizKNnL311Pb0kvjcFzyH
	 D8bCf7KpCAY1Bk/U2TGVjnUkyPRkAI21mOX0dzFEPGWMT/x8fuCSi9n9+wNQAAoQFckbj
	 lRRrihXuWnk6pi0nNYhqfQ/Ozf1cEb9WVEpFGAiLV7C/OYcrGYISOWhB5i9QXmt3Uzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SuxruQDe5RIVV/EHPwXjfdn+nqG2BUqhRGKR8UcokBU=;
	b=IsmNtWF/P1GBZukgpo+/XUKKBkKZjP7891zF6vbByrAGwwXYTez5udVjZBJqrKg8K7QN
	 tWoJc7EOzblkmrwYKdlGidAmF/gfnFANjFwc3UZ6Wi2h1poClgMx9mqLgkqV1wjOKCfsj
	 13zfHBcJoy32pNNj0OB+gxyH5Sf+fCGLwPum9HQfpCjl7kv4Sdc254p9+FSlbjeSggnF1
	 CAC5NewfNhgdxGoeKQ+Oo54bVQ7DcSy6WmPJg3U+yF1yrkXiXxoQvHblB6q320i4QqaPu
	 ce2YtNeTlZB1vNDsr/3RlM0kps9zZ4uA6S7RF/4Gidlctw3ywSp27+kDdBAk7mrL9nw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795198421;
	bh=SuxruQDe5RIVV/EHPwXjfdn+nqG2BUqhRGKR8UcokBU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PhuWC82tMojyRWKkfyMekN7TZKPvqx1o0qS3CqlKyCO2rzoqgRuihFLzQqkjZh1L/
	 B31N3IGbJu/Wj3i3HCixWurqoNSKt6fr5tBzUjFNFAYSj49ZNhetNzSBdNYCbpvN1w
	 a+22/LyXd3oXIUlrqz0CUu39K75parvhAPmH7HUA17b1xxLIVWvrhWLFmeHVfjaBDW
	 myCjlnQUyFYPfn16LqYHUIr1ogpgNml45xZiPSRBYLvzG1W6kue1TbcbHp3Td3Ktgg
	 Nysqo6Cl/66NDQUSEq9JdBXGFVcxMxdT8dMC5hISG5NODkjlBjK0z7B9LOtydoirE2
	 hDSuXkL40Z+Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A91560EB2;
	Fri, 20 Nov 2026 18:13:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A75FE9CF
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DB914022E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CdnPabqJECme for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A930400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7779e6c3c=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=b99OFR4y
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A930400A2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1795198414; x=1826734414;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=44RkKv2rKCfnc4Bd7p7kC00pvYsTPdNfTKO5MH/Mx0g=;
 b=b99OFR4yuAi9DP9mTBQeDC5fep7Ty6nPAy+dTzim0zOOcBg9BZvnEdMx
 CjSwHx+bs7NGl2oD09KEkYHVHgXbjycS0Ie58YbUAPytH2raSJIx3QK7h
 JvxwF0bsUJhHxbuGinYIzEL8QAhGV7C3mLD4Mjti0XiDyjlHaltkmSov4
 R+8DIQvRgNChk5cKv1Qg+wsED7o821EGbM7/ZCXtVEA6fv0kPRnohgW6g
 gGT0clZ08jv6fOYBoP3sKAkHTBQY1skdR+T/XwwbBeYcJiW6pSyeKiMYr
 maGnXGrRME4cpJju8iPGSvB0I1GHzVzJviZYPEUmEQ+oCnGJFmAVNhxWW Q==;
X-CSE-ConnectionGUID: ulNzsEIrTGKhe25lMYdRng==
X-CSE-MsgGUID: y1ryv9n7S7iVgYx8Zo7xXQ==
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="65862334"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Nov 2026 11:13:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 20 Nov 2026 11:13:33 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 20 Nov 2026 11:13:32 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 20 Nov 2026 13:13:03 -0500
Subject: [PATCH 4/6] net: macb: parse the phylink status instead of reading
 status registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-add-macb-support-for-dm-mdio-v1-4-d344297d5b44@microchip.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that phy_startup() is called, use the result stored in macb->phydev to
calculate "speed" and "duplex" rather than using the open coded link speed
resolution.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/macb.c | 67 ++++++++++++++++--------------------------------------
 1 file changed, 20 insertions(+), 47 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index c23ca588a2d9..b9ed5d060fce 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -657,8 +657,8 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 {
 	struct macb_device *macb = dev_get_priv(dev);
 	u32 ncfgr;
-	u16 phy_id, adv, lpa;
-	int media, speed, duplex;
+	u16 phy_id;
+	int speed, duplex;
 	int ret;
 
 	arch_get_mdio_control(name);
@@ -713,53 +713,26 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 		 */
 		mdelay(10);
 
-		adv = macb_mdio_read(macb, macb->phy_addr, MII_ADVERTISE);
-		lpa = macb_mdio_read(macb, macb->phy_addr, MII_LPA);
-
-		/* First check for GMAC and that it is GiB capable */
-		if (gem_is_gigabit_capable(macb)) {
-			if (lpa & ADVERTISE_CSMA)
-				lpa = macb_mdio_read(macb, macb->phy_addr, MII_STAT1000);
-
-			if (lpa & (LPA_1000FULL | LPA_1000HALF | LPA_1000XFULL |
-						LPA_1000XHALF)) {
-				duplex = ((lpa & (LPA_1000FULL | LPA_1000XFULL)) ?
-						1 : 0);
-
-				printf("%s: link up, 1000Mbps %s-duplex (lpa: 0x%04x)\n",
-					name,
-					duplex ? "full" : "half",
-					lpa);
-
-				ncfgr = macb_readl(macb, NCFGR);
-				ncfgr &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
-				ncfgr |= GEM_BIT(GBE);
-
-				if (duplex)
-					ncfgr |= MACB_BIT(FD);
-
-				macb_writel(macb, NCFGR, ncfgr);
-
-				ret = macb_linkspd_cb(dev, _1000BASET);
-				if (ret)
-					return ret;
-
-				return 0;
-			}
+		switch (macb->phydev->speed) {
+		case SPEED_1000:
+			speed = 2;
+			break;
+		case SPEED_100:
+			speed = 1;
+			break;
+		case SPEED_10:
+			speed = 0;
+			break;
+		default:
+			printf("%s: speed %d not supported\n", name, speed);
+			return -EINVAL;
 		}
+		duplex = macb->phydev->duplex;
+
+		printf("%s: link up, %sMbps %s-duplex\n", name,
+			(speed == 2) ? "1000" : (speed == 1) ? "100" : "10",
+			duplex ? "full" : "half");
 
-		/* fall back for EMAC checking */
-		adv = macb_mdio_read(macb, macb->phy_addr, MII_ADVERTISE);
-		lpa = macb_mdio_read(macb, macb->phy_addr, MII_LPA);
-		media = mii_nway_result(lpa & adv);
-		speed = (media & (ADVERTISE_100FULL | ADVERTISE_100HALF)
-			? 1 : 0);
-		duplex = (media & ADVERTISE_FULL) ? 1 : 0;
-		printf("%s: link up, %sMbps %s-duplex (lpa: 0x%04x)\n",
-			name,
-			speed ? "100" : "10",
-			duplex ? "full" : "half",
-			lpa);
 	} else {
 		/* if macb port is a fixed link */
 		const char *human_readable_speed;

-- 
2.53.0

