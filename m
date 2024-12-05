Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB0FE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD1789540;
	Thu,  5 Dec 2024 14:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XtJE74Ye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42975894E0; Thu,  5 Dec 2024 14:54:53 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D03389501
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A76F40010;
 Thu,  5 Dec 2024 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuD9lTC5L311B3ORurAtRrnWe4gCY+gWnarPONdQ8TQ=;
 b=XtJE74YeRLiiy9KVtopCGz+UOi7/IdugOOMABRwE3KlqdN00zzPmqqAFsIf9yVg0Cf8osN
 FhnF2NhAbn11h4HdW5DkiI9UMj5LzTZ8hkMRGtNf7GMrth6D2bn/xdz8Z/kOQ6TK4b0Cmx
 BrA0rbkD+aCuWG5cbXk00Fw4T3bMfkI0qqh0O7DtfJfhkGCTFtjAUaLMNbznu4GkLwjfrt
 MM1PeerTaGKB0MloQAvhz4ygBgZUKkXSuPO66G6Kvt5rQOCsEZHtqi67GqVLJIMbrfMRg2
 /1i+MhCXvlyW6NZlFrDVwwaFAefoXzy4YCGhXpgTjpsax/o5Q8ztggO2bmeBlA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:12 +0100
Subject: [PATCH v2 06/13] clk: Ensure the parent clocks are enabled while
 reparenting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-6-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
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

