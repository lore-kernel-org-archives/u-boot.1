Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31DDCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09ED86AA8;
	Sun, 17 Sep 2023 16:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a3PtQ7/1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gvousygx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE6E86AA4; Sun, 17 Sep 2023 16:12:08 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7A586996
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVH963hBz9sWS
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwdCq8pF6PZo+h6VpW7nE3I4bkwRpzSZeO3Yh7BBYm0=;
 b=a3PtQ7/1yYoXR2EvfDreM6o3WDa6FG/7L5pSXw5vS8CVNmDYKAG0leGr0HTOOI4P8UQ0WK
 dANMfg1xoem5nKM+hDd7mlXWhNs1Erb0XgrVxKtAkMbIYIb0cOqPvsnFXJNawcXQOCQAiH
 yoBCC4+1jrQUZUthfAB8NDN4KsBaUSOaDNW96/vucgZfkaPwd2wgEbezEw6M4YxDTr9RpN
 Q093/D6f4tIorZeYLcbjMrutqHCSwAmyH0CkOE3hVpO+jinVZbKqHw5TRSRFGalGQ4G27V
 i+alNA9D3eDp1BBz7WDoBXQCxhqF94qaa7OUUr9sHkqdiV4JBi5G+zkR3bpCbA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwdCq8pF6PZo+h6VpW7nE3I4bkwRpzSZeO3Yh7BBYm0=;
 b=gvousygxAT61r9tqryFTVFrO7J1B3xkvZU7IomswcngFHJ43cuvBLXANS/4XfyKlc3gOE2
 lhuOWsivfB29Lgx91kIU76jxY0QZXEs9Sinxt6J1uLVVVpEA6lR+CEJcQyuSJ2B8bLI8ds
 b/NVZ6+7LYm1J+kSJ7WeoQAITy+vy4ZohzeQ531+q8my1XSbjyqg6FJqcS5zHHOPdc+jKO
 ipSoMqkYDc7EiefJmWXJyEBfFU7RFFmPFigzwGiSepguRqo7+srSNJjZO19eD9UPpynBJa
 WxrD2e5d5t6ThnFwUbnyAbiVXZmGIdUEWzKtsKsCraWKmoaKiChWU+UboBJqpQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/20] clk: renesas: Synchronize R8A77990 E3 clock tables with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:33 +0200
Message-Id: <20230917141141.379884-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 56a0abc3c0cbefa4e2b
X-MBO-RS-META: ngczxku1xs3bsaajygb7z9nzxdy57umr
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

Synchronize R-Car R8A77990 E3 clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/renesas/r8a77990-cpg-mssr.c
index 1864af30c8c..e5710b05933 100644
--- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
@@ -52,7 +52,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a77990_core_clks[] = {
+static const struct cpg_core_clk r8a77990_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",     CLK_EXTAL),
 
@@ -132,7 +132,7 @@ static const struct cpg_core_clk r8a77990_core_clks[] = {
 	DEF_GEN3_RCKSEL("r",   R8A77990_CLK_R, CLK_RINT, 1, CLK_OCO, 61 * 4),
 };
 
-static const struct mssr_mod_clk r8a77990_mod_clks[] = {
+static const struct mssr_mod_clk r8a77990_mod_clks[] __initconst = {
 	DEF_MOD("tmu4",			 121,	R8A77990_CLK_S0D6C),
 	DEF_MOD("tmu3",			 122,	R8A77990_CLK_S3D2C),
 	DEF_MOD("tmu2",			 123,	R8A77990_CLK_S3D2C),
@@ -273,7 +273,7 @@ static const struct mssr_mod_clk r8a77990_mod_clks[] = {
  */
 #define CPG_PLL_CONFIG_INDEX(md)	(((md) & BIT(19)) >> 19)
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div */
 	{ 1,		100,	3,	100,	3,	},
 	{ 1,		100,	3,	 58,	3,	},
-- 
2.40.1

