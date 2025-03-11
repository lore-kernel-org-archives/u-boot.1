Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1461CC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 18:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45742801FB;
	Tue, 11 Mar 2025 19:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jw4VSKqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4828141D; Tue, 11 Mar 2025 15:14:41 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9771E801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A528344258;
 Tue, 11 Mar 2025 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1741702479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BRiRtrSm5l8173qASXbKwJtFaarO3Zb+8dEcD5BKCpY=;
 b=jw4VSKqpQ9/+fCSJZ7E/zq1Pq9uBZ3buMTT0PmlBs/ucTRco/mjr0drotsB0jMf/JWWaiD
 s9oiM+5AZnCB1k/d3vrcGxk2EYkRYidRAIl58Of63XTqm2oYhOb0Td67N1YXNpUV2GEAil
 X9tJm7Q6t82hzIGBxWZJ2Vc6DvEopS7zaLmVmAIPWN2hw/5Zt/0NA4aE94tCWZu61DXX+B
 vBwCK6bNtHc3gdS25Hmoo6CRYR2xU5NWQgLfcedexhsMqyazjRJVJQ3KZSUxzPNX7YR0kB
 h3BTXCEcqF9T4AEdcnpyxiauCnC+5eUNHJCujcV5NME+1uHoyxCG5XUWij2dOA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH] net: am65-cpsw: cpsw_mdio: fix typo in error message
Date: Tue, 11 Mar 2025 15:14:30 +0100
Message-ID: <20250311141430.154763-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvgeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfivghnohhuugcuoehrihgthhgrrhgurdhgvghnohhuugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeluddvlefhkefhueeiudffgefgvdevvdeffeevieeitefgteeiheelieeggfetnecukfhppedvrgdtudemtggsuddtmeelleehleemkegrtddtmegukeekjeemudejsgegmehfhegvtdemfeefkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdutdemleelheelmeekrgdttdemugekkeejmedujegsgeemfhehvgdtmeeffeekgedphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomheprhhitghhrghrugdrghgvnhhouhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepjhhovgdrhhgvrhhshhgsvghrghgvrhesnhhirdgtohhmpdhrtghpthhtoheprhhfrhhivggurdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrt
 ghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprhhitghhrghrugdrghgvnhhouhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: richard.genoud@bootlin.com
X-Mailman-Approved-At: Tue, 11 Mar 2025 19:37:38 +0100
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

Replace "froced" by "forced"

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/net/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index c70b42f6bcc2..3c62fc0b4282 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -661,7 +661,7 @@ static int am65_cpsw_ofdata_parse_phy(struct udevice *dev)
 
 	dev_read_u32(dev, "max-speed", (u32 *)&pdata->max_speed);
 	if (pdata->max_speed)
-		dev_err(dev, "Port %u speed froced to %uMbit\n",
+		dev_err(dev, "Port %u speed forced to %uMbit\n",
 			priv->port_id, pdata->max_speed);
 
 	return 0;
-- 
2.47.2

