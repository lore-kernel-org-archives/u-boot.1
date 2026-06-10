Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408E4CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 18:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A0884928;
	Wed, 10 Jun 2026 20:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DsRXx0D1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P5A17K5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 910468491C; Wed, 10 Jun 2026 20:21:53 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3918489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 20:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gbDdC0qtBz9vPJ;
 Wed, 10 Jun 2026 20:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781115711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Ql8cpThZh/RJBPd7pHOFp/HFejcP9zD6sXWngjHhgg=;
 b=DsRXx0D1Ru9Hp0cjQjzOGYj54dnbdqM/vbIFr4RPJvP8ipHO21uAmuES6UDbpDHyjclDde
 Seq6jfHJ8Sn5VSL8wCuXkIZImKao/SSlRBAEjy9FsgipOxQcQ/IapSmSwfU9HKJyVjmYCd
 S4wb1fzlhz22j/gC3yjm5YJGxnqOlhOWCyLiUIbcYtWZmp7y02gHxg3lts3atnBBws6bzQ
 gPp52NgvVkme5nQn7nMN4B6IqPzjGALkP8u2080O0uV7WKC9L1fTwdeS1Z/3SsZJpFjepx
 sm4bUsc6PQILKOrx86xrybXmiDNBA3ROv4bCq6gyfx4B5Ad1nXLmPmYRZbwKsQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781115709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Ql8cpThZh/RJBPd7pHOFp/HFejcP9zD6sXWngjHhgg=;
 b=P5A17K5GqbGh3X5jWMHcuwGJYL/5ZQk7DdEq67dszaJAEPTckBge1rLpAGhBt6z8nQ6H0r
 Gtyy/nOcAJCj86JLYXod8fpTPtCKrvz0ej2uyc3g15pSSAGSUm0JWXpJT8pNSOA7354+xS
 PpuJ6e/8/z/XQe1j/jsB8rEdv5guDW+3lUaNgWEFW1mbEv/HqG9t6HzMlQh+v2CBScwBvy
 Ds4wE4MCsrBpKnnHNAZZuNYVSf9N1E/+d4ZSLlmIR3khmU0K++UMVx4CzeGZkzwMsZm4DS
 cAyliAuZkTE2S5eX/wGjFdQRyHGWQ7otQ5CmCOVlvbF7TIJNlhcqrUeDXMr4uw==
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/3] ram: renesas: rtvram: Add support for Renesas R-Car Gen5
Date: Wed, 10 Jun 2026 20:20:57 +0200
Message-ID: <20260610182140.56393-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2d7bf6a194068e43ce8
X-MBO-RS-META: 933x6tpym3m3fdyd166ab5hczctsj4bd
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

Add support for Renesas R-Car Gen5 R8A78000 SoC into RT-VRAM
initialization driver. The changes are only a slight adjustment
to the register programming, therefore reuse the existing RT-VRAM
driver and parametrize those changes using driver data.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/ram/renesas/dbsc5/rtvram.c | 44 +++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/rtvram.c b/drivers/ram/renesas/dbsc5/rtvram.c
index 6c149284bc6..bf30a207142 100644
--- a/drivers/ram/renesas/dbsc5/rtvram.c
+++ b/drivers/ram/renesas/dbsc5/rtvram.c
@@ -13,34 +13,41 @@
 #define RTVRAM_VBUF_CFG			0x6504
 #define RTVRAM_VBUF_CFG_CACHE_MODE_8WAY	(1 << 8)
 #define RTVRAM_VBUF_CFG_VBUF_SIZE_28M	(6 << 0)
+#define RTVRAM_VBUF_CFG_VBUF_SIZE_32M	(7 << 0)
 #define RTVRAM_EXT_MODE			0x8500
 #define RTVRAM_EXT_MODE_EXT		BIT(0)
 #define RTVRAM_VBUF_BADDR		0xC580
 
-#define RTVRAM_VBUF_NUM			7
-
-#define SDRAM_40BIT_ADDR_TOP		0x0400000000ULL
 #define RTVRAM_VBUF_AREA_SIZE		SZ_4M
 
 struct renesas_dbsc5_rtvram_priv {
 	void __iomem		*regs;
 };
 
+struct renesas_dbsc5_rtvram_data {
+	u8	sdram_40bit_addr_top;	/* Left-shift by 32 */
+	u8	vbuf_num;
+	u8	size;
+	u8	size_bit;
+};
+
 static int renesas_dbsc5_rtvram_probe(struct udevice *dev)
 {
 	struct renesas_dbsc5_rtvram_priv *priv = dev_get_priv(dev);
+	struct renesas_dbsc5_rtvram_data *data =
+		(struct renesas_dbsc5_rtvram_data *)dev_get_driver_data(dev);
 	u64 addr;
 	int i;
 
 	/* Set each 4MB from the top of SDRAM as the buffer area of RT-VRAM. */
-	for (i = 0; i < RTVRAM_VBUF_NUM; i++) {
-		addr = (SDRAM_40BIT_ADDR_TOP + (RTVRAM_VBUF_AREA_SIZE * i)) >> 16;
+	for (i = 0; i < data->vbuf_num + 1; i++) {
+		addr = (((u64)(data->sdram_40bit_addr_top) << 32ULL) + (RTVRAM_VBUF_AREA_SIZE * i)) >> 16;
 		writel(lower_32_bits(addr), priv->regs + (RTVRAM_VBUF_BADDR + (4 * i)));
 	}
 
 	/* Cache Mode: 8-way, VBF size: 28M */
 	setbits_le32(priv->regs + RTVRAM_VBUF_CFG,
-		     RTVRAM_VBUF_CFG_CACHE_MODE_8WAY | RTVRAM_VBUF_CFG_VBUF_SIZE_28M);
+		     RTVRAM_VBUF_CFG_CACHE_MODE_8WAY | data->size_bit);
 
 	/* Change from Compatible Mode to Extended Mode */
 	writel(RTVRAM_EXT_MODE_EXT, priv->regs + RTVRAM_EXT_MODE);
@@ -65,9 +72,11 @@ static int renesas_dbsc5_rtvram_get_info(struct udevice *dev,
 					 struct ram_info *info)
 {
 	struct renesas_dbsc5_rtvram_priv *priv = dev_get_priv(dev);
+	struct renesas_dbsc5_rtvram_data *data =
+		(struct renesas_dbsc5_rtvram_data *)dev_get_driver_data(dev);
 
 	info->base = (phys_addr_t)priv->regs;
-	info->size = 28 * SZ_1M;
+	info->size = data->size * SZ_1M;
 
 	return 0;
 }
@@ -76,14 +85,29 @@ static const struct ram_ops renesas_dbsc5_rtvram_ops = {
 	.get_info = renesas_dbsc5_rtvram_get_info,
 };
 
+struct renesas_dbsc5_rtvram_data gen4_rtvram_data = {
+	.sdram_40bit_addr_top = 0x4,
+	.vbuf_num = 7,
+	.size = 28,
+	.size_bit = RTVRAM_VBUF_CFG_VBUF_SIZE_28M,
+};
+
+struct renesas_dbsc5_rtvram_data gen5_rtvram_data = {
+	.sdram_40bit_addr_top = 0x12,
+	.vbuf_num = 8,
+	.size = 32,
+	.size_bit = RTVRAM_VBUF_CFG_VBUF_SIZE_32M,
+};
+
 static const struct udevice_id renesas_dbsc5_rtvram_ids[] = {
-	{ .compatible = "renesas,r8a779g0-rtvram" },
-	{ .compatible = "renesas,r8a779h0-rtvram" },
+	{ .compatible = "renesas,r8a779g0-rtvram", .data = (ulong)&gen4_rtvram_data },
+	{ .compatible = "renesas,r8a779h0-rtvram", .data = (ulong)&gen4_rtvram_data },
+	{ .compatible = "renesas,r8a78000-rtvram", .data = (ulong)&gen5_rtvram_data },
 	{ /* sentinel */ }
 };
 
 U_BOOT_DRIVER(renesas_dbsc5_rtvram) = {
-	.name		= "rtvram",
+	.name		= "dbsc5_rtvram",
 	.id		= UCLASS_RAM,
 	.of_match	= renesas_dbsc5_rtvram_ids,
 	.of_to_plat	= renesas_dbsc5_rtvram_of_to_plat,
-- 
2.53.0

