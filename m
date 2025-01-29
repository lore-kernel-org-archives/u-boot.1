Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BBFC0218F
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95EFC81951;
	Wed, 29 Jan 2025 11:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="owP/TOf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5593381276; Wed, 29 Jan 2025 11:22:16 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25198129B
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4B7443187;
 Wed, 29 Jan 2025 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1738146131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuD9lTC5L311B3ORurAtRrnWe4gCY+gWnarPONdQ8TQ=;
 b=owP/TOf49vF6gZLsPLE9YM3DMD6TFIJIUji28uBqJuTESB6sJykbZSjL6pLecYL/dLaANy
 bn0E6wjTFmkfSicmhDT2hbCSiT4nGzQZAZHYA+XpKN6o/bFIx2g/NHlwA+c+XZX9TY0MXL
 W80tJOfGYrjyIzXp+4CVWgTb+TLDoq3vx/BXPgJ+CHZPUqiJqEc56EvHdPcdnv/uTII3LA
 KkcqK72LFwdWSa/eQXnlzdS/WLVmVtE4+caEhGei0V03vjnlOT92vK1WzAU+JXurOVpjsQ
 WPlc7if/a1gMH4rb0mEPxsuBab0xPWBTqgssBw+8I0YTjv+f1herVETIC80ETw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Jan 2025 11:22:00 +0100
Subject: [PATCH v4 06/12] clk: Ensure the parent clocks are enabled while
 reparenting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-ge-mainline-display-support-v4-6-a43b3657ed7c@bootlin.com>
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
In-Reply-To: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuggrrhhiohdrsghin
 hgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
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
index a9937c22dcb6bcc90b14f748a0758810a7435d61..dc89e3071130f1e1c98001a955c4fec210aa5b47 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -593,14 +593,27 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
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
2.47.0

