Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1C6CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F9C838CC;
	Mon, 27 Oct 2025 17:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BAJfnFc9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WJkiHvGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26801838C8; Mon, 27 Oct 2025 17:37:53 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 038AE82E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwK1V5kn4z9stP;
 Mon, 27 Oct 2025 17:37:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LYt1kj+f3KGX3dT5ic51l6KRbRxz/AqYWJzc/67hmr4=;
 b=BAJfnFc9yZZOwdWCYnhemKIjKISSxoDTR3BjP8kGQViT81M9asj4hUij6u9eaZMA4xumJJ
 hFiLuoVW1YBzoe+w8vuDriYGJCOS0veAKfex0NaW2j4/Md+dLz8pDKNWN3MqgqDFmLW2hq
 A/k299v5qNL3ogzAUd698Y31nZoGF3JugL1JS1GWqwnoalD+u+PulmWhAGhxKitH022TLe
 cvwXAsup/VEMM9lSXH7YnG8JctrBgtSgiuGG/D53F3tHf/QMB73bwmwBFFwie6amHsj6eW
 d2lzJDNcy80JiSSXRDLHgebOdAZJFuERgpO89BB0pXczg9bhGCcFNYd1mtNTEA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LYt1kj+f3KGX3dT5ic51l6KRbRxz/AqYWJzc/67hmr4=;
 b=WJkiHvGs4rNgC/XtF3V0/hGRDzMGsxawWNYmjOWeAzQ8O9B/8y4QiaT9i5c43prNiS7vIx
 Xx+w6+ZOn7HdwSUJoW2wBdqqodSHGLmJ9aPZNi8jPcnxJgs7lDEyT325T/+ocX1NhFvETL
 D/HI3X2s0mzabf3BNWtk+OIyE4LPH8UH5zK6Le22sI8vOWiMaNpAkrXM0CdTOr4hTKYwTo
 0fWTFyz67kG5AH1jq0NAFMh7DcnC5kpNP7GIlEklAvchKADbky4Td9Kxo+vT36x5IO+SwS
 CtnQr68W3AC9OuXKB2Wb8LqNI2ZBvY5GiyKIy4krzYHLnkAxu2oNiuUTCj2BGg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Huy Bui <huy.bui.wm@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] gpio: renesas: Drop pfc_offset parsing
Date: Mon, 27 Oct 2025 17:35:34 +0100
Message-ID: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: miourake97j6bcs1jcnqy14pxfiwawjz
X-MBO-RS-ID: c48fed70c2c6942f3ed
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

The PFC offset is no longer used directly in the driver since commit
fbf26bea3964 ("gpio: renesas: Migrate to pinctrl GPIO accessors")
Drop the pfc_offset parsing.

Fixes: fbf26bea3964 ("gpio: renesas: Migrate to pinctrl GPIO accessors")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/gpio/gpio-rcar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index d1a39938809..109383e83d5 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -38,7 +38,6 @@ DECLARE_GLOBAL_DATA_PTR;
 struct rcar_gpio_priv {
 	void __iomem		*regs;
 	u32			quirks;
-	int			pfc_offset;
 };
 
 static int rcar_gpio_get_value(struct udevice *dev, unsigned offset)
@@ -154,7 +153,6 @@ static int rcar_gpio_probe(struct udevice *dev)
 
 	ret = fdtdec_parse_phandle_with_args(gd->fdt_blob, node, "gpio-ranges",
 					     NULL, 3, 0, &args);
-	priv->pfc_offset = ret == 0 ? args.args[1] : -1;
 	uc_priv->gpio_count = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
 
 	ret = clk_get_by_index(dev, 0, &clk);
-- 
2.51.0

