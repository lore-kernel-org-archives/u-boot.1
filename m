Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A263EE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0489686A74;
	Wed,  6 Sep 2023 23:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="owDr0SLn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c2qPJQ35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B943486A24; Wed,  6 Sep 2023 23:30:57 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF35886A08
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXZ6KB1z9tTZ;
 Wed,  6 Sep 2023 23:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S++SWz2X6yWtqWC2IGrxXRQasCt/fP2Nia4xjrcM6YQ=;
 b=owDr0SLnUykmXbA3sxKRrQ/ak2fK8aXg2sZX1OxgnA4AVDYc0M12viftIDwaWGRwC60igx
 KGhKi7TeppfXa4biNzLQ3y3XdNZaQlRvyzbwPYXiR7eKkxRROct3wpX6PpLoPs34tguX8l
 rhBDrGYYhiPZ4gckq43gi0h+EQP1hzp7FrWtIjBAVRGUTxu4SZiSaKSSTX4ekO+mYQO4u+
 x6VeUikPMu1gfYLvzEeljPcebtMPKo6nGIVR9todOtSVELQKL8vg12rfVRqcjP82oZERua
 rKovVg2DxL65Ds9G4QKBh/LjKiUjs8NpfGuOqXtr2MUH1IFEV3AdRON6l+V/pA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S++SWz2X6yWtqWC2IGrxXRQasCt/fP2Nia4xjrcM6YQ=;
 b=c2qPJQ35s+O96xb/C0i07hD2E1gLuXCt6fwB1xwyxhZLWrIWk5W3sojeY59+mrKCpdjJoN
 gy4UgZuD5vrYH+pafxwINJreZOJuHI7Q3PhkjoylnCerrO+6n15WWBrTnh8s06GqgBy+3T
 C7sx2U8A7QMCBRxt7ydhEt2gJ7rHyYaNGskcZD/uHO4+Mh5tcQEmzasJumpTJ0ZWgRp0tY
 AuZpbBLQBZwCH0SL0WueVvR4F2EeVIsLpqANS/3LWXLx0O7APcaCptkW+jMedd89BgplQB
 gNFl/R+K1GPNpwkGAAhcCFpTYb8eHH0G46dw4nFDGoLO7aD4tNzesD3vGQmWKw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 23/35] gpio: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:03 +0200
Message-Id: <20230906213015.203437-24-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o9o4rwiendeas8tay6c1awxxyyte7q9y
X-MBO-RS-ID: 61736af831a23ec590c
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/gpio/gpio-uclass.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index fc395c97a28..7aece85a70a 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1498,36 +1498,6 @@ void devm_gpiod_put(struct udevice *dev, struct gpio_desc *desc)
 
 static int gpio_post_bind(struct udevice *dev)
 {
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	struct dm_gpio_ops *ops = (struct dm_gpio_ops *)device_get_ops(dev);
-	static int reloc_done;
-
-	if (!reloc_done) {
-		if (ops->request)
-			ops->request += gd->reloc_off;
-		if (ops->rfree)
-			ops->rfree += gd->reloc_off;
-		if (ops->direction_input)
-			ops->direction_input += gd->reloc_off;
-		if (ops->direction_output)
-			ops->direction_output += gd->reloc_off;
-		if (ops->get_value)
-			ops->get_value += gd->reloc_off;
-		if (ops->set_value)
-			ops->set_value += gd->reloc_off;
-		if (ops->get_function)
-			ops->get_function += gd->reloc_off;
-		if (ops->xlate)
-			ops->xlate += gd->reloc_off;
-		if (ops->set_flags)
-			ops->set_flags += gd->reloc_off;
-		if (ops->get_flags)
-			ops->get_flags += gd->reloc_off;
-
-		reloc_done++;
-	}
-#endif
-
 	if (CONFIG_IS_ENABLED(GPIO_HOG) && dev_has_ofnode(dev)) {
 		struct udevice *child;
 		ofnode node;
-- 
2.40.1

