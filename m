Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D47C3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71651820F6;
	Thu,  3 Apr 2025 14:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DYePu02x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7265481F6B; Thu,  3 Apr 2025 09:39:33 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7727180194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 09:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EF1044378;
 Thu,  3 Apr 2025 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743665971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDFUf7Fc/jCXounF+LWHGJusAq06LLCcIqT4DovJ0DY=;
 b=DYePu02xQSxkLmg8yWbvuNxuzf8q2z9aVFQcB0tXl3KO+cZb2ecsqPfJVuUyodfhrIT1t4
 ES45jvE1m22wBkFDBD1upWa4gJCTnSCXcG53Bhkb1JSG6WzruK70Y6ezBq2sU8IIXnJbqH
 vXt8gcue79MNzWfnFKEZ9xyX/t5sjQNHqoC1ou9I6pgthC0sCvIzyiYkncvHtuIeoPexaL
 h48I7Geh6W1XLte99hTrrk/Qbjxm0elHyOwNwIoSCfOm/+scgZ9YUk//uPppeIvTJ6ewX3
 6AGmIRqKgba448qpB/3I1S5tylcMoiJvoraC9YEXpL2pRHKjgJRGb+kdBCFcNA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 03 Apr 2025 09:39:06 +0200
Subject: [PATCH v6 06/12] clk: Ensure the parent clocks are enabled while
 reparenting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-ge-mainline-display-support-v6-6-478b5e3dd872@bootlin.com>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
In-Reply-To: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledvrddukeegrdduuddtrdduleelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleelpdhhvghloheplgduledvrdduieekrddurddutdeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehsvggrnhhgrgdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopegrghhushhtseguvghng
 idruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtoheptghlrghmohhrleehsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 03 Apr 2025 14:36:19 +0200
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

Reparenting a clock C with a new parent P means that C will only
continue clocking if P is already clocking when the mux is updated. In
case the parent is currently disabled, failures (stalls) are likely to
happen.

This is exactly what happens on i.MX8 when enabling the video
pipeline. We tell LCDIF clocks to use the VIDEO PLL as input, while the
VIDEO PLL is currently off. This all happens as part of the
assigned-clocks handling procedure, where the reparenting happens before
the enable() calls. Enabling the parents as part of the reparenting
procedure seems sane and also matches the logic applied in other parts
of the CCM.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk-uclass.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 90b70529a478d11d907cbd6b64d680d0c1db4d5c..4b3d812f9c6539a6b769990e3e11f14f49abb2a9 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -623,14 +623,27 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!ops->set_parent)
 		return -ENOSYS;
 
-	ret = ops->set_parent(clk, parent);
-	if (ret)
+	ret = clk_enable(parent);
+	if (ret) {
+		printf("Cannot enable parent %s\n", parent->dev->name);
 		return ret;
+	}
 
-	if (CONFIG_IS_ENABLED(CLK_CCF))
+	ret = ops->set_parent(clk, parent);
+	if (ret) {
+		clk_disable(parent);
+		return ret;
+	}
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
 		ret = device_reparent(clk->dev, parent->dev);
+		if (ret) {
+			clk_disable(parent);
+			return ret;
+		}
+	}
 
-	return ret;
+	return 0;
 }
 
 int clk_enable(struct clk *clk)

-- 
2.48.1

