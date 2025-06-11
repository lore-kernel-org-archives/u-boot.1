Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CDCC71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 17:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA17982B20;
	Wed, 11 Jun 2025 19:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Trc2H9X+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9758582B63; Wed, 11 Jun 2025 19:10:38 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2349882B0F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 19:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41FA41F4F3;
 Wed, 11 Jun 2025 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1749661834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ga/e8DGy4kA9qX7diL/f4Zy+cGN2wKFePIlFuubiYgY=;
 b=Trc2H9X+oXxrvH6GwwdMnjmNl8y5lOxSD+PRPXmSJ5fa8aq7pxUBjOYSFnVRjj/8orc3gi
 nj/AnVx9nXf98O46DiagKu49JScpTAGPomF4Aojj5mnrrflKgj2KTUZTXdwBdo0ZVajnHp
 kWWE7peZGvXghA8ATRgwf/We+YTC4tAu1qjCndnMoMLO8rp9OwWlgSL9AkT8PspDJsT26s
 //h8vzp9ZRII5MHcqwOvAW4+fvEDehkmufMW0mzMJrptV8SVRJ0hWnc4BQSoRja8o6EsBx
 UW42DrewdW4wC2Yj2oZBYnBTePqZnYo/axKbl2GRgm+POGtMXIFeZ8HcJJ3SSA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>,
	u-boot@lists.denx.de
Cc: Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH] usb: gadget: musb: Fix duplicate ops assignment in
 ti_musb_peripheral
Date: Wed, 11 Jun 2025 19:10:30 +0200
Message-ID: <20250611171031.840277-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegudegvdeklefhheefueeiieegteegteeuudegteduvdevffeikefgjeekgfdukeenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemsgefiegsmeejjehftgemleehkedtmedvkegurgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmegsfeeisgemjeejfhgtmeelheektdemvdekuggrpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepjhhjhhhisghlohhtsehtihdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhto
 hepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehmkhhorhhpvghrshhhohgvkheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com
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

Remove duplicate .ops assignment that was overriding the correct
ti_musb_gadget_ops with musb_usb_ops (host ops) in the ti_musb_peripheral
driver. This was causing U-Boot crashes when trying to call the
handle_interrupts operation since the wrong ops structure was being used.

Fixes: 7d98dbcc3dc ("usb: musb-new: Add support for DM_USB")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/usb/musb-new/ti-musb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index ec1baa9337d..967d0953875 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -282,7 +282,6 @@ U_BOOT_DRIVER(ti_musb_peripheral) = {
 	.ops	= &ti_musb_gadget_ops,
 	.probe = ti_musb_peripheral_probe,
 	.remove = ti_musb_peripheral_remove,
-	.ops	= &musb_usb_ops,
 	.plat_auto	= sizeof(struct ti_musb_plat),
 	.priv_auto	= sizeof(struct ti_musb_peripheral),
 	.flags = DM_FLAG_PRE_RELOC,
-- 
2.43.0

