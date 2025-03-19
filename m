Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92045C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D60B381D4F;
	Wed, 19 Mar 2025 04:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354360;
	bh=Y3JRCgmSZ842CKyjhZkWsN1Mry0YA1ZjmW9qSsYPhRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R1SPAsIXtcMRq5OJz8+Tlxv7/v4jclX5+Ji8VJ/5qUzVxLqtAkA1sGobkR9vgRS66
	 vru7ozMJ2PKvefpMitzQwEnAlOINN7agB3Jcvd5jKjk92DUQ8opihhCU23FtX7kMu/
	 Rb9C4H3eie52uVGCufgrQE0KxMywUbx8Dxj5LRZlNgvGpNfjlssWe47lSe1GMCejt8
	 f7gjqtnCBQH/DMNU7QQddy9m/rvbhD3yMw22tN9QVK4Jwh48fmBbFyjtbMOZXFUlB3
	 +0Q54xJB3sP7LteZMav+E2poVkPR3wX1a2484DM5XrPb1xTKeJY37TY1MTtQ5F4Bxz
	 m1EvRliIfJsOg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA7881CFD; Wed, 19 Mar 2025 04:19:19 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0378E8197D
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BLI69hMv"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AA0F5101E91C2; Wed, 19 Mar 2025 04:19:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354356; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Y3JRCgmSZ842CKyjhZkWsN1Mry0YA1ZjmW9qSsYPhRM=;
 b=BLI69hMvLN/g0nQJFrFTkxzDmVLdmK5ujeR+xyLq+ROTFB7+oDgB68s57x+U+435M68k0D
 1KAFJ0f3h9QOUIONUPiH0khp4s7ibgYKgGlXGSakWcbiqTMuyjptKveRkX+y23/WAA0FhB
 oB5CYpgT9Vl4TB7pKq4JKfrOdTIk0pnaq14N1n3/ztNIUThTUuapwBJbOMczueCCk0wGTV
 p+8/2itBYiQ0ZKQ8jSNldpAwzhn/RBjQIxvLx5Ruge86hhN7cshG/4kpZ5exIqeyuS8qhl
 0ndas8izsg2fb8NfepU9bdfQ4n1dTCIDqOaklXColEezuTnLCOdht0M5Kd+USw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 02/24] clk: clk-mux: Fold clk_register_mux()
Date: Wed, 19 Mar 2025 04:17:12 +0100
Message-ID: <20250319031852.233537-3-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Neither clk_register_mux_table() nor clk_hw_register_mux_table()
are called outside of clk-mux.c , fold both into clk_register_mux().
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
 drivers/clk/clk-mux.c | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 62477e15d27..9507a779525 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -159,15 +159,15 @@ const struct clk_ops clk_mux_ops = {
 	.set_parent = clk_mux_set_parent,
 };
 
-struct clk *clk_hw_register_mux_table(struct device *dev, const char *name,
+struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table)
+		void __iomem *reg, u8 shift, u8 width,
+		u8 clk_mux_flags)
 {
+	u32 mask = BIT(width) - 1;
 	struct clk_mux *mux;
 	struct clk *clk;
-	u8 width = 0;
 	int ret;
 
 	if (clk_mux_flags & CLK_MUX_HIWORD_MASK) {
@@ -192,7 +192,7 @@ struct clk *clk_hw_register_mux_table(struct device *dev, const char *name,
 	mux->shift = shift;
 	mux->mask = mask;
 	mux->flags = clk_mux_flags;
-	mux->table = table;
+	mux->table = NULL;
 #if IS_ENABLED(CONFIG_SANDBOX_CLK_CCF)
 	mux->io_mux_val = *(u32 *)reg;
 #endif
@@ -216,35 +216,6 @@ struct clk *clk_hw_register_mux_table(struct device *dev, const char *name,
 	return clk;
 }
 
-struct clk *clk_register_mux_table(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents,
-		unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table)
-{
-	struct clk *clk;
-
-	clk = clk_hw_register_mux_table(dev, name, parent_names, num_parents,
-				       flags, reg, shift, mask, clk_mux_flags,
-				       table);
-	if (IS_ERR(clk))
-		return ERR_CAST(clk);
-	return clk;
-}
-
-struct clk *clk_register_mux(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents,
-		unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_mux_flags)
-{
-	u32 mask = BIT(width) - 1;
-
-	return clk_register_mux_table(dev, name, parent_names, num_parents,
-				      flags, reg, shift, mask, clk_mux_flags,
-				      NULL);
-}
-
 U_BOOT_DRIVER(ccf_clk_mux) = {
 	.name	= UBOOT_DM_CLK_CCF_MUX,
 	.id	= UCLASS_CLK,
-- 
2.47.2

