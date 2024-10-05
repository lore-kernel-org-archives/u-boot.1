Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A35CFB420
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 17:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EDA88970;
	Sat,  5 Oct 2024 19:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cV7i/qDa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Cb51TwyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA0A88916; Sat,  5 Oct 2024 19:45:38 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D5688970
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 19:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XLXrJ20Ypz9tDd;
 Sat,  5 Oct 2024 19:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1728150336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3jwzLTYmTkUfyoS1ip6AUrQx619Ms2YCEpSjleBRgFE=;
 b=cV7i/qDagY3oOQXT+wnZFTajySVrHmiZPBnB5a+YLrFDI3vGehEhHkFiIDGZj4SRt0MLu8
 Tcwx1H1WFngFmj4fdrvJV9+ZVp/CxC8bhmHkj/hm3J74VcvnReB6heFysDiFyKbdqmWYQi
 r+ZDND8VC80l/7TBO9CS7Ov3Tp3uH5VbCNu+6fr9BLBCH/Qof0gQf1Lk0+C2WFKiocOQN3
 V95gaVHP9HdVVjYd2BeYe0PLlRFNOeBH9JcyaOZEh8OkEBHk1T7R7/L1Bm3s0y087+eS3a
 BwbJRGzdM4HYeAeS3slPeOd9+m11VQMVkPFA6RmkgEUmK3V24dxf132Q6uuhiA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1728150334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3jwzLTYmTkUfyoS1ip6AUrQx619Ms2YCEpSjleBRgFE=;
 b=Cb51TwyNRhPQA8RaVLLSYya9MB33oNOqpdF5a3Zd+tYzNpU6rq+UtFBOqIVf0Z2nxgAMwP
 F6ILdygsrC98XRLtGWB5afZTtMYdg9xsTvo2VY0Vpskw7MJrQxbtUwBjAsfFkTICty1QJU
 YhNVqcthHjV4Xi0PPuw36BLM2jJz6RshvJQ5euYs7n/QXu8lAS9c2XUn4xPC8m03JF4Y5h
 ryxae3V9z+YnZ1BpWNrjVcHjKSet7l/G5PpBcCwZCcBM5QV6oYBYU8SLJDDi20GPjKEe4I
 ZT0l1PN5QnlCfgi6DnWkp9ceceu5A5k0nOBAhU5F/Jd1oQqNUG7s7MezdXJ6BQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: renesas: rcar-gen3: Fix SSCG caching replacement with
 MDSEL/PE caching
Date: Sat,  5 Oct 2024 19:45:02 +0200
Message-ID: <20241005174523.182066-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qirzhmzd1wrkyoqw39sor488qpa6w4xc
X-MBO-RS-ID: ddfd23fe1f71f5473da
X-Rspamd-Queue-Id: 4XLXrJ20Ypz9tDd
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

The SSCG is active with MDSEL[12] is not set. Previous commit
99c7e031196d ("clk: renesas: rcar-gen3: Replace SSCG caching
with MDSEL/PE caching") inverted the conditional assignment
of priv->sscg = !(cpg_mode & BIT(12)) during conversion from
(priv->sscg ? 16 : 0) to priv->cpg_mode & BIT(core->offset) ? 16 : 0;
Invert the assignment back to the correct state.

This fixes R8A77980, R8A77990, R8A77995 and R8A774C0.

Fixes: 99c7e031196d ("clk: renesas: rcar-gen3: Replace SSCG caching with MDSEL/PE caching")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
---
NOTE: This is for 2024.10
---
 drivers/clk/renesas/clk-rcar-gen3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
index ac05788ccc5..aa38c0f7dd0 100644
--- a/drivers/clk/renesas/clk-rcar-gen3.c
+++ b/drivers/clk/renesas/clk-rcar-gen3.c
@@ -69,7 +69,7 @@ static int gen3_clk_get_parent(struct gen3_clk_priv *priv, struct clk *clk,
 			return ret;
 
 		if (core->type == CLK_TYPE_GEN3_MDSEL) {
-			shift = priv->cpg_mode & BIT(core->offset) ? 16 : 0;
+			shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
 			parent->dev = clk->dev;
 			parent->id = core->parent >> shift;
 			parent->id &= 0xffff;
@@ -318,7 +318,7 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
 						"FIXED");
 
 	case CLK_TYPE_GEN3_MDSEL:
-		shift = priv->cpg_mode & BIT(core->offset) ? 16 : 0;
+		shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
 		div = (core->div >> shift) & 0xffff;
 		rate = gen3_clk_get_rate64(&parent) / div;
 		debug("%s[%i] PE clk: parent=%i div=%u => rate=%llu\n",
-- 
2.45.2

