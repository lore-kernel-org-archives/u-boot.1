Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B421FCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920D0838C8;
	Mon, 27 Oct 2025 17:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ILYmUQHZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="er1KxujB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58803838BB; Mon, 27 Oct 2025 17:37:56 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B56838AB
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwK1Z14nGz9sDT;
 Mon, 27 Oct 2025 17:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/iv+mn5XZqF/StGgrBddUNUUK0NrlEKVO4QU0dCZLY=;
 b=ILYmUQHZ9UEg31PqFtiVJq4fQrYfvLhS4fMYtgHhGp00QL34qnCS6B7TWwAiFXPni8WnGB
 8E0wEofthKWF5m3ieAxt8ehNRZFJB6nZdm1ODO7r07IpLEcXaIxD1ASbEA5NUFNJHg6lr7
 yOpHR31sPMuDBXw/Zr70IuH1f5MFz61PiCcnSa3tupPMZ+xir+16HSaJD5FSqvl97EZaau
 vxrUrVSKZNhTiGS56UshvtRO4CnVdIRuCwndBC+sq0RXheWzbTWq89kkjccYmC9qgLJG3m
 cDxpaQy2OVy0K/MA1ZofIl9TJTVVvm9VV4LzachcF4C5d2tI+iwZSbfioFczCg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/iv+mn5XZqF/StGgrBddUNUUK0NrlEKVO4QU0dCZLY=;
 b=er1KxujBkVTNdR5fZdfKpyTkKmfeVvpGXqsxO71qw0hRoDfQFfP9QbdlUnFO//OLxNlSKH
 1CEedAAlHS7evb89Mq9BYUIn4O7PGRM+AARWaxUAxHo2Xlso0lBVhOJ1N8ojrkP6XN3/AT
 n06ySxsgtkIxLp8oQ5rqcO5lqkg3lTzSYHPAkQ57kKdwA8MS52iRv0n3lqdQiRoBwkdwfc
 GOx+ebNDnsyYxLoyxyG1fKMjgwwku2Y2pCc1324NWuqUpEzl7Xv8ky49zebhGUuRo8RUaj
 25VCvfjr2Z8/iCj8tRcKHBxKPV4TJ7SrlgSWFHUM6KjHG1TLD5sz6+n56JBrhA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Huy Bui <huy.bui.wm@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] gpio: renesas: Access INDT, POSNEG,
 INEN registers via match data offsets
Date: Mon, 27 Oct 2025 17:35:37 +0100
Message-ID: <20251027163738.11734-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
References: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1366927f0b7cad527ce
X-MBO-RS-META: a7t5cftun73mwij83fhxo6cw6gf51pyd
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

The Renesas R-Car Gen5 GPIO controller has INDT, POSNEG, INEN registers
at different offsets compared to previous generations. Introduce three
new entries in struct rcar_gpio_data {} match data to describe these
register offsets for each GPIO controller. Update the driver to access
these three registers through the match data offsets. No functional
change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/gpio/gpio-rcar.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index fada6f4c624..f4eaf6f9c2d 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -18,9 +18,9 @@
 #define GPIO_IOINTSEL	0x00	/* General IO/Interrupt Switching Register */
 #define GPIO_INOUTSEL	0x04	/* General Input/Output Switching Register */
 #define GPIO_OUTDT	0x08	/* General Output Register */
-#define GPIO_INDT	0x0c	/* General Input Register */
-#define GPIO_POSNEG	0x20	/* Positive/Negative Logic Select Register */
-#define GPIO_INEN	0x50	/* General Input Enable Register */
+#define GPIO_INDT_G2	0x0c	/* General Input Register */
+#define GPIO_POSNEG_G2	0x20	/* Positive/Negative Logic Select Register */
+#define GPIO_INEN_G4	0x50	/* General Input Enable Register */
 
 #define RCAR_MAX_GPIO_PER_BANK		32
 
@@ -30,6 +30,9 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct rcar_gpio_data {
 	u32				quirks;
+	u32				indt_offset;
+	u32				posneg_offset;
+	u32				inen_offset;
 };
 
 struct rcar_gpio_priv {
@@ -40,6 +43,7 @@ struct rcar_gpio_priv {
 static int rcar_gpio_get_value(struct udevice *dev, unsigned offset)
 {
 	struct rcar_gpio_priv *priv = dev_get_priv(dev);
+	const struct rcar_gpio_data *data = priv->data;
 	const u32 bit = BIT(offset);
 
 	/*
@@ -49,7 +53,7 @@ static int rcar_gpio_get_value(struct udevice *dev, unsigned offset)
 	if (readl(priv->regs + GPIO_INOUTSEL) & bit)
 		return !!(readl(priv->regs + GPIO_OUTDT) & bit);
 	else
-		return !!(readl(priv->regs + GPIO_INDT) & bit);
+		return !!(readl(priv->regs + data->indt_offset) & bit);
 }
 
 static int rcar_gpio_set_value(struct udevice *dev, unsigned offset,
@@ -79,14 +83,14 @@ static void rcar_gpio_set_direction(struct udevice *dev, unsigned offset,
 	 */
 
 	/* Configure postive logic in POSNEG */
-	clrbits_le32(regs + GPIO_POSNEG, BIT(offset));
+	clrbits_le32(regs + data->posneg_offset, BIT(offset));
 
 	/* Select "Input Enable/Disable" in INEN */
 	if (data->quirks & RCAR_GPIO_HAS_INEN) {
 		if (output)
-			clrbits_le32(regs + GPIO_INEN, BIT(offset));
+			clrbits_le32(regs + data->inen_offset, BIT(offset));
 		else
-			setbits_le32(regs + GPIO_INEN, BIT(offset));
+			setbits_le32(regs + data->inen_offset, BIT(offset));
 	}
 
 	/* Select "General Input/Output Mode" in IOINTSEL */
@@ -169,10 +173,15 @@ static int rcar_gpio_probe(struct udevice *dev)
 }
 
 static const struct rcar_gpio_data rcar_gpio_gen2_data = {
+	.indt_offset = GPIO_INDT_G2,
+	.posneg_offset = GPIO_POSNEG_G2,
 };
 
 static const struct rcar_gpio_data rcar_gpio_gen3_data = {
 	.quirks = RCAR_GPIO_HAS_INEN,
+	.indt_offset = GPIO_INDT_G2,
+	.posneg_offset = GPIO_POSNEG_G2,
+	.inen_offset = GPIO_INEN_G4,
 };
 
 static const struct udevice_id rcar_gpio_ids[] = {
-- 
2.51.0

