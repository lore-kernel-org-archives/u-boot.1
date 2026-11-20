Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E47606B458
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UIZy5+jB;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=tZ/mCAJN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AC2260EDB;
	Fri, 20 Nov 2026 18:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VI5Q4C-lE_WL; Fri, 20 Nov 2026 18:13:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4728260EA6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795198423;
	b=ay+Dp28EJroDSMb7t0TOQNahYjzFL6UoWawplV2vssZdtepzAZ/hw7q09mO5KJt1H3f9
	 UfnLIs1YU40tmwthapWTMhm5jvnC9ETTzOD0CaEYrAk5d2zYmACT7oIG4Wi7fbqlaz3oU
	 Z4HIOi2snJBeTOeUAMTECMGAsPNQClwXLeoylSkkh9JuJTDbDFf5NaORfpn9i8h3rX/FB
	 2b2yeX8TZyuLsUJDr9fZP9rXD22yBIb1oFjhj8UKQK4vXn8xeyy1Astqswq5hlDtVEMU0
	 tRP/WF3kbLgVQVXOyrOSULX+/Q3Bgo+Nk28IPJGeIvnfX0YP/KL6XcbotYRS8UIDBEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198423;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dQl3I5cvU1PdFKjvsfPOK/htCMUPXnFd8FTxaLnXrrM=;
	b=TqHzusUC0oro1PBPTnvqSC4wamO/rmuI3ZhJN3fCCsq1yxOeHibYF3Q75IdSj3opmUWM
	 Y8Gvsl1f+fYYNiWwzLAug8596mYo5UxrB4SxTCOH2GXJIcnyYTHzgR0X7ZSq6tlD3xuFt
	 qNr8ET7lLzNwSoECeE5DyN0frWqXFP17RpyVfC6PJ8eqBX40/kpF1GGLo/uPWQFr1baKT
	 ROqlz85sQNmP2vLNCpy6iiJyTrsxLyefeBla7cVM/PP2ydPuFdk84zuEOE7mYWRpQ1WDZ
	 KzsEKccHrJlTkjKPngbsc9PAZxNYsLj7anFYfrolhut2jBKKDRP0a/QRPuwsJeaRNyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="tZ/mCAJN";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795198423;
	bh=dQl3I5cvU1PdFKjvsfPOK/htCMUPXnFd8FTxaLnXrrM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UIZy5+jBjmzXm6btsgAsSvBbBPLsYaC8uSnZ2cVr5Q3+QW3dxg154s9+t5J4mJ4Xm
	 abi5EY5aFfLbkc3jbqRjWoSJArYkL6RD5me7BdX+IjOHx47NLfxQ2Dw6H3Np53QaMg
	 XtCJCl3FVgBdidD0H9VayHl7bmwbEZUJfBdUVgk2/lwH5YlVJoOexKvfbWwgdT/dKj
	 GdcPsy84Qupr1gOdg+SFhD7fV00eI03V7pC9q1DyGnR2j3T4g/RU9hJ1PUYTI/OnLa
	 mrjLm2cAQRP7lumkA9zJz4719TjixLBb8N5tINZRJSRXQUB7NXhdj7yLz9xGMQZOpC
	 qlH0DqdPuqW7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4728260EA6;
	Fri, 20 Nov 2026 18:13:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1857E1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10B3D60EAA
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GFFIt_jnxDQt for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 370C360760
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7779e6c3c=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=tZ/mCAJN
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 370C360760
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1795198424; x=1826734424;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=83lLyetHFwrmjwGR3KG6u4ZU5/QaLcq146OEJqI7r9o=;
 b=tZ/mCAJNB/ke7Y9SgeeF8/tOGIhunI6DrPABtTOwKX9pGjezhToGUT6U
 h2Yw6lL0zlAvzo3QIeRIOqtYVIwfv2BXSdDsM3p1Is/hNnZqS2i0jfE9+
 9vbiuIm9Wv46tKt20q0yzjjA3b2z8ZFSMmPhQ0Dss48h86qJlga/y+WlF
 Ef13oqgB6Xh213Y+19+NaOkw9+lOeggv8FvZ0AuCm+aEG5WFuiycSpyPL
 I/KsllH6Ry+QTddsvWXpAIAsCmS+Jt20BiACbeI63q9dBeTnH11jgeTXu
 XiB2/IkPkyvlAABwqTAI4napbsfTasEmUEVPRMIsJTb1HEGob2175vz+O w==;
X-CSE-ConnectionGUID: 0pWmysNeTUeH8FjkUhDvfw==
X-CSE-MsgGUID: xFwMZbDAT2y1Dcwc7kjPeg==
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="298246838"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 11:13:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 11:13:35 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 20 Nov 2026 11:13:34 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 20 Nov 2026 13:13:04 -0500
Subject: [PATCH 5/6] net: macb: remove useless read in macb_phy_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-add-macb-support-for-dm-mdio-v1-5-d344297d5b44@microchip.com>
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

The PHY has already been accessed in macb_phy_find().

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/macb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index b9ed5d060fce..39ab56c9d8fd 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -657,7 +657,6 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 {
 	struct macb_device *macb = dev_get_priv(dev);
 	u32 ncfgr;
-	u16 phy_id;
 	int speed, duplex;
 	int ret;
 
@@ -669,13 +668,6 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 		if (ret)
 			return ret;
 
-		/* Check if the PHY is up to snuff... */
-		phy_id = macb_mdio_read(macb, macb->phy_addr, MII_PHYSID1);
-		if (phy_id == 0xffff) {
-			printf("%s: No PHY present\n", name);
-			return -ENODEV;
-		}
-
 		if (macb->phy_addr == PHY_MAX_ADDR+2) {
 			/* Internal PCS fake PHY */
 			int id;

-- 
2.53.0

