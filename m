Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF8606C6EB
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ra6QD0NX;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=XpI2WrR4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC65560748;
	Fri, 20 Nov 2026 18:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id maSSpa6FttQS; Fri, 20 Nov 2026 18:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5473B60E71
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795198412;
	b=Ut8MaA1I7yjaEWwBV2VRgSQo0GsacHPwpn1kQ2Q2qKwj/KHFdAUqP4m4juTCCbQtWk8w
	 cqfFCI+cbhZoVgv8h+rPg67jplv47hhM1uS2Teabswc2YLA42iJWJLApLaEdIjlNg7le/
	 J7WS2o/IzMt8iIEBMH/t+hbm+4wF31pspoKFtp8yMvK0pUlsbWBvdrly+exIF/T1d/8vN
	 VB+fszYdctZ92uAMf+BcN+c3t0SlTs9rogSiymHEFCxq0QTjGiKKFZ+5X9CzswALCjqKN
	 sRw3P1grB+9cJyJFUfSsBijpmqjX1uZL0GGbikLhx14pp4CxuLmURqLVxEJpjVj5Psw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EjHJTgRwq24LglMoQVT4PwKvn6ZmEt08zIsyBpYIAvs=;
	b=k310SiX9m8TEF1p5yV5AscopNcDQnS5dxhIx+3CV7dZzO3gOOLaQwaWimCEbedGSLLzr
	 Hv+USW2ZjzZfMaD+s1kla7WPtQjKp2gBYA7Qj40C4Ykv+19M0ezQslq4i0JCbVw9EZamr
	 7pkPwf/ZFue1tLDZsdg7Mg07koeVtjD66AL3kNbJnS1xmcasvGk1dc/S8sE/ePoifq1lP
	 wu0zPpEArrb9MVMMwVDQuYzBh8YKlPsYifuF+uIRtaSuDjeJI1e+ecumb19L0gDtluXk6
	 2BI+nlTkg8uvF3lqH00t56TzEl5mYiCmBNeaF6tQbH1oh6l92zAflo1cVO0y7l18qog==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795198412;
	bh=EjHJTgRwq24LglMoQVT4PwKvn6ZmEt08zIsyBpYIAvs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ra6QD0NXPVJzYhVFrD51EljfM0B9KRcUap08aRloEg60FZ2XeKYaHxANFvLeEmjKx
	 TlDiSn7Kwv05TgDVirEsi/PI+b7IYNsYThEmCYPz6BzudMTVsZubvVkZVfL8q0IRbx
	 B1axl5wostxwtl1t6TViWWu3YyF4O6hLUGfiRjysmktaqLk1Q9p9uPrdCgPRi4DYD5
	 uBZfal9h9UKRUveIzO7+3NDQOYHTIdK1l9yVnk7IM+Z7maSJ7PPqNXPYp4Ns13Q6ei
	 aWMFE0gBzAb72LSaAk3ONUNX3oEf9LlrsjWHBcNXR3qsxPYN1JC4jPMWqZPp7k1JPi
	 rg0a/2nITQj+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5473B60E71;
	Fri, 20 Nov 2026 18:13:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3587498
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B585E400A2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVNOwvfA97tF for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:13:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D88D14022E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7779e6c3c=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=XpI2WrR4
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D88D14022E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1795198418; x=1826734418;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=td3utrN6xcCDaDD9A8LIEsjXmRx99VuMH19tp9C0JwQ=;
 b=XpI2WrR4J4teOAFx1FfsGVpsXnA+Y5AbuNysDA0QikFWwjX+HxNvUQkJ
 Q7bVXv3S88S7Hhlgs6RyDwTzdSohPXmdifgH8WHFvuVHK03HJt82arG/K
 W3bcRG0w0rBpkdIdoPWZKUqMXCzG9mPzkd/Er3wPnB38MT5i8JKSigcQA
 aPj329F+B5qckCxR/5bD8mMzUAPru5QXsq/hbjtzXZ5TNff7ZDDdVEpCI
 ORgP3W6xRtUocGYfrMycD1QgohHbnQgfVwINXLne/A5xaFaZnyQZB7iW7
 Ls1GEoxrFuXxb15YYxOBNsen+gI1J3Zelm4s8iJXoE84bJsFdEeYtYYbx w==;
X-CSE-ConnectionGUID: 20xRresXR26Osz8IWxm7dQ==
X-CSE-MsgGUID: mPL5L0vNTsqkB27KiJfi2Q==
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="66837645"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 11:13:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 11:13:26 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 20 Nov 2026 11:13:25 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 20 Nov 2026 13:13:00 -0500
Subject: [PATCH 1/6] net: macb: remove CONFIG_PHYLIB guards
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-add-macb-support-for-dm-mdio-v1-1-d344297d5b44@microchip.com>
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

CONFIG_MACB select CONFIG_PHYLIB. It is therefore impossible to build
macb.c without CONFIG_PHYLIB, making the #ifdef guards useless. Remove
them.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/macb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index 06e08d1d87e8..fabfe72210fb 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -135,9 +135,7 @@ struct macb_device {
 	unsigned int    	speed;
 	unsigned short		phy_addr;
 	struct mii_dev		*bus;
-#ifdef CONFIG_PHYLIB
 	struct phy_device	*phydev;
-#endif
 
 #ifdef CONFIG_CLK
 	unsigned long		pclk_rate;
@@ -269,8 +267,6 @@ void __weak arch_get_mdio_control(const char *name)
 	return;
 }
 
-#if defined(CONFIG_CMD_MII) || defined(CONFIG_PHYLIB)
-
 int macb_miiphy_read(struct mii_dev *bus, int phy_adr, int devad, int reg)
 {
 	u16 value = 0;
@@ -294,7 +290,6 @@ int macb_miiphy_write(struct mii_dev *bus, int phy_adr, int devad, int reg,
 
 	return 0;
 }
-#endif
 
 #define RX	1
 #define TX	0
@@ -712,7 +707,6 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 			return -ENODEV;
 		}
 
-#ifdef CONFIG_PHYLIB
 		if (macb->phy_addr == PHY_MAX_ADDR+2) {
 			/* Internal PCS fake PHY */
 			int id;
@@ -731,7 +725,6 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 		}
 
 		phy_config(macb->phydev);
-#endif
 
 		status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
 		if (!(status & BMSR_LSTATUS)) {
@@ -1343,7 +1336,6 @@ static int macb_eth_probe(struct udevice *dev)
 
 	_macb_eth_initialize(macb);
 
-#if defined(CONFIG_CMD_MII) || defined(CONFIG_PHYLIB)
 	macb->bus = mdio_alloc();
 	if (!macb->bus)
 		return -ENOMEM;
@@ -1355,7 +1347,6 @@ static int macb_eth_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 	macb->bus = miiphy_get_dev_by_name(dev->name);
-#endif
 
 	return 0;
 }
@@ -1364,9 +1355,7 @@ static int macb_eth_remove(struct udevice *dev)
 {
 	struct macb_device *macb = dev_get_priv(dev);
 
-#ifdef CONFIG_PHYLIB
 	free(macb->phydev);
-#endif
 	mdio_unregister(macb->bus);
 	mdio_free(macb->bus);
 

-- 
2.53.0

