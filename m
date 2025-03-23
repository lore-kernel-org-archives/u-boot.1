Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B07EC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E3B820A1;
	Sun, 23 Mar 2025 17:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745720;
	bh=I0Um1WymYy+U6Iiv6wRh8ji0n5sKvh65djX5C+LOFZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=krntCo1673TsmxtYyxb1O4YVrn9Vhw8x5HXTizO/fN0YDPQun/bKRIo6oY5fmoQeq
	 eAxnip68QCifKFmxWxtRj4pwhRul9r2PHJgHMCoUSxpxDdPm3O6rwd+U0hHCEWEYsx
	 AGAJ3RT8ApShiz5YQpPdFYFOUP4QegbTSNJaRUwZXy8BSsbV7oeGg2/X04er9+77jz
	 qGlXump5ZtLDcLMqhP9ic7Sc4N8gJ7/NSdTePQXj4KmOY0aRm+6gdzTACE6OV8+1Cl
	 LjdOyiF/Z/aKzJAwkc/1BEstm1GS6Qbc3vn3zHPz/dP2dILaA9xaV9E12719OppK7g
	 ORbiIE9GRwQoQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47EF8820A1; Sun, 23 Mar 2025 17:01:57 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C87481E3E
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HLyLQAUD"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 611A91029024A; Sun, 23 Mar 2025 17:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745714; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=I0Um1WymYy+U6Iiv6wRh8ji0n5sKvh65djX5C+LOFZ0=;
 b=HLyLQAUDOpKA2682ZQLlEi1fprXjP/TW4zIAhkinmFul/v5w9OxVGYJmlBFJ1a1OHBxNHu
 o6JON2xNpHErTbo8DKKcTH/bQCNvalgLhnrRG8L09xwOjtrp6wma7QhqBIezhzprnAys9t
 8zcaiKPuzmAwLi16iY/AjMxizKLCKEowqsu3rvcS2KyYmbbbglutW1n0jDk7sa/PrzWjjt
 iUrylv3dvzb4XAflAhylFNQH5NHadqU3OG+Lf5CC4lQkL7P047rnHmflMwv88uEQNFkb6x
 2/kn+OdAMOc7wzsyv2ba3Pt3cCb1AOqnnBLgec0KbiNf3hyJaoROm+GsLQmlqg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 02/24] clk: clk-mux: Fold clk_register_mux()
Date: Sun, 23 Mar 2025 16:58:31 +0100
Message-ID: <20250323160107.145749-3-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
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
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
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

