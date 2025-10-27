Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F28CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533A6838D7;
	Mon, 27 Oct 2025 17:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jUKblfSf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qd56iyUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34626838BB; Mon, 27 Oct 2025 17:37:55 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1BB82E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwK1Y0FB9z9tNb;
 Mon, 27 Oct 2025 17:37:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvVIJhSLlXU4TtMvy66R0wMKtBZKnrZl737sMRwIjVQ=;
 b=jUKblfSfF/splxNdMBhOR6cGWNrWbGfkq82cNTy4K/vh9r6mYTIF6XZbHFIyCB5WBu8J4i
 KY9DnFULNY+U9B61eaU+qeR2dy5JwIx96Llat7MeV/45VHkyQcy6+5fxh0VVE2/sdXSB8E
 dRjaZO7Mbms4lBPGla+LLCssF+dNFwQoXwgdhTnJ0pVAMQslHE9HfeUIIuUg67cl0awc5e
 nre1xcMVVkwi9VHEmBLij9ne4prAGNJ/BakQsCqUc7Hzx5iCR561k9Tt/dUAJoy8qYq40G
 SYmrz1p8tg3E78sTWyumC8Mav2HufmctfN+x4I/COupicpkJv3BKlmn/6yTRUA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvVIJhSLlXU4TtMvy66R0wMKtBZKnrZl737sMRwIjVQ=;
 b=qd56iyUSb93U70IKGrQs6HpELK/3FrjYSnYKALlHuiafKyU5GKxzCW4oM7rZchu0uUMNl2
 j1VG+HtFBJTqffKCYD6Tzyjcy6Pn38hWDXhC1czTk5LXFeocqnOwufo7pdC30BGaEnrdmh
 zi1Umt5QQja8IN3VBaU2+p47mGUvsBDSiDwwgzpfAGE5Ws9xy39GGGWoFSFfovF3tMQvfA
 LVDY1y1PDmKLhJqREdM96Dy/+DpklBcQdjMGSUl8ul7e26iwxrWxTzkaFMfxJgV6PBf97a
 6Rw16JsCUHyCH+UzS7RILZBU7tZ7iBBLL8N8XXrTajwbPALQP43sF5gh0yQUmQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Huy Bui <huy.bui.wm@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] gpio: renesas: Wrap quirks in struct rcar_gpio_data
Date: Mon, 27 Oct 2025 17:35:36 +0100
Message-ID: <20251027163738.11734-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
References: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: df715455aed20263c64
X-MBO-RS-META: skw493zi91edzugzuebydajdrgidg433
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

Wrap the RCAR_GPIO_HAS_INEN quirk in more flexible struct rcar_gpio_data {}
in preparation for addition of Renesas R-Car Gen5 GPIO controller support.
The Renesas R-Car Gen5 GPIO controller requires more than a single quirk
to properly describe it, therefore increase the flexibility and introduce
full match data structure, and use it throughout the driver. No functional
change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/gpio/gpio-rcar.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 8853187e64e..fada6f4c624 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -28,9 +28,13 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+struct rcar_gpio_data {
+	u32				quirks;
+};
+
 struct rcar_gpio_priv {
-	void __iomem		*regs;
-	u32			quirks;
+	void __iomem			*regs;
+	const struct rcar_gpio_data	*data;
 };
 
 static int rcar_gpio_get_value(struct udevice *dev, unsigned offset)
@@ -65,6 +69,7 @@ static void rcar_gpio_set_direction(struct udevice *dev, unsigned offset,
 				    bool output)
 {
 	struct rcar_gpio_priv *priv = dev_get_priv(dev);
+	const struct rcar_gpio_data *data = priv->data;
 	void __iomem *regs = priv->regs;
 
 	/*
@@ -77,7 +82,7 @@ static void rcar_gpio_set_direction(struct udevice *dev, unsigned offset,
 	clrbits_le32(regs + GPIO_POSNEG, BIT(offset));
 
 	/* Select "Input Enable/Disable" in INEN */
-	if (priv->quirks & RCAR_GPIO_HAS_INEN) {
+	if (data->quirks & RCAR_GPIO_HAS_INEN) {
 		if (output)
 			clrbits_le32(regs + GPIO_INEN, BIT(offset));
 		else
@@ -141,7 +146,7 @@ static int rcar_gpio_probe(struct udevice *dev)
 	int ret;
 
 	priv->regs = dev_read_addr_ptr(dev);
-	priv->quirks = dev_get_driver_data(dev);
+	priv->data = (const struct rcar_gpio_data *)dev_get_driver_data(dev);
 	uc_priv->bank_name = dev->name;
 
 	ret = fdtdec_parse_phandle_with_args(gd->fdt_blob, node, "gpio-ranges",
@@ -163,17 +168,24 @@ static int rcar_gpio_probe(struct udevice *dev)
 	return 0;
 }
 
+static const struct rcar_gpio_data rcar_gpio_gen2_data = {
+};
+
+static const struct rcar_gpio_data rcar_gpio_gen3_data = {
+	.quirks = RCAR_GPIO_HAS_INEN,
+};
+
 static const struct udevice_id rcar_gpio_ids[] = {
-	{ .compatible = "renesas,gpio-r8a7795" },
-	{ .compatible = "renesas,gpio-r8a7796" },
-	{ .compatible = "renesas,gpio-r8a77965" },
-	{ .compatible = "renesas,gpio-r8a77970" },
-	{ .compatible = "renesas,gpio-r8a77990" },
-	{ .compatible = "renesas,gpio-r8a77995" },
-	{ .compatible = "renesas,gpio-r8a779a0", .data = RCAR_GPIO_HAS_INEN },
-	{ .compatible = "renesas,rcar-gen2-gpio" },
-	{ .compatible = "renesas,rcar-gen3-gpio" },
-	{ .compatible = "renesas,rcar-gen4-gpio", .data = RCAR_GPIO_HAS_INEN },
+	{ .compatible = "renesas,gpio-r8a7795", .data = (ulong)&rcar_gpio_gen2_data },
+	{ .compatible = "renesas,gpio-r8a7796", .data = (ulong)&rcar_gpio_gen2_data },
+	{ .compatible = "renesas,gpio-r8a77965", .data = (ulong)&rcar_gpio_gen2_data },
+	{ .compatible = "renesas,gpio-r8a77970", .data = (ulong)&rcar_gpio_gen2_data },
+	{ .compatible = "renesas,gpio-r8a77990", .data = (ulong)&rcar_gpio_gen2_data },
+	{ .compatible = "renesas,gpio-r8a77995", .data = (ulong)&rcar_gpio_gen2_data },
+	{ .compatible = "renesas,gpio-r8a779a0", .data = (ulong)&rcar_gpio_gen3_data },
+	{ .compatible = "renesas,rcar-gen2-gpio", .data = (ulong)&rcar_gpio_gen2_data },
+	{ .compatible = "renesas,rcar-gen3-gpio", .data = (ulong)&rcar_gpio_gen2_data },
+	{ .compatible = "renesas,rcar-gen4-gpio", .data = (ulong)&rcar_gpio_gen3_data },
 	{ /* sentinel */ }
 };
 
-- 
2.51.0

