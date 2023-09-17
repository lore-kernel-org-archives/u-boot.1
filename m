Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104ADCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E47586A33;
	Sun, 17 Sep 2023 16:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hZ23efaz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DEfzCodJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8CEA86A23; Sun, 17 Sep 2023 16:12:05 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1529C86996
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVH662qjz9sTr
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJ1z0kOEa0Acpwj/2r/4GPWCIhZhkQtIdBf9SQVbFs4=;
 b=hZ23efazXyyp7kxlp1hKSdcQC1JDwpzerK/9EMORqYWX7Qnv0CJAlm95F3Vfyugn7VwET7
 qn3nSt0GPkXJuEtcAZDpXovBhuC3lYoFCGfpgOTPVUKn7SXvZrYkoIcD5ff553+TKLdEPn
 ADGIw+lQqxWQZHoYpa3a6jWCWrx5qhGnYzbLq1sgSfDYZk3SisSqH3XC4783Ry671bq/mj
 npJ+HLVZbsBvRA6uhO5Myk5rqUBBgs84usx5CWZXScho4PgCCroKzN4rsqOaizFcjPZ/ku
 eJFP9c3z8oec1Go5x2H8pHQDDK60gLM10L2RXbFr7W3YHle8cUnVWNAwKS/a9Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJ1z0kOEa0Acpwj/2r/4GPWCIhZhkQtIdBf9SQVbFs4=;
 b=DEfzCodJuKva1LVFcCqdoftSYliEYZb7PrIDwoQhJAGHg3XtAmlhNYvSPvdFxv35JP+ym8
 bSy8nR92Mq7CLU/K9pIp97GJnzvtViyV45nuZGPD/RXxuozq2LQxOOuSL3HtsV+hqQtidc
 krVekC6ub59DFPCsUZ3jnCOKXqrAPxU3Vdm4ulmbcrIsDgr4ZFlqirrM1hQ11Ejk3PAdSI
 1/mcAFm9H+ZuTRjTBZN/GkDsaYpUgSVbXDdQhwuKlKNolqbNuKB19EMYJjbXgXgGj0eiXq
 vMd8KUVg+QgbVSvS6nFA+6zrEeD3TcJ3uEuppjZ3l4aAvFvKamvJjMpH/MHGJw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 05/20] clk: renesas: Synchronize R8A7792 V2H clock tables with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:26 +0200
Message-Id: <20230917141141.379884-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xdaxgck87dky1jndfhko4y7efdpwja7r
X-MBO-RS-ID: 79b4f17a385a744c8b5
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

Synchronize R-Car R8A7792 V2H clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a7792-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a7792-cpg-mssr.c b/drivers/clk/renesas/r8a7792-cpg-mssr.c
index 5b333638ac0..496e51aa73f 100644
--- a/drivers/clk/renesas/r8a7792-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7792-cpg-mssr.c
@@ -37,7 +37,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a7792_core_clks[] = {
+static const struct cpg_core_clk r8a7792_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",     CLK_EXTAL),
 
@@ -76,7 +76,7 @@ static const struct cpg_core_clk r8a7792_core_clks[] = {
 	DEF_FIXED("osc",    R8A7792_CLK_OSC,   CLK_PLL1,      12288, 1),
 };
 
-static const struct mssr_mod_clk r8a7792_mod_clks[] = {
+static const struct mssr_mod_clk r8a7792_mod_clks[] __initconst = {
 	DEF_MOD("msiof0",		   0,	R8A7792_CLK_MP),
 	DEF_MOD("jpu",			 106,	R8A7792_CLK_M2),
 	DEF_MOD("tmu1",			 111,	R8A7792_CLK_P),
@@ -174,7 +174,7 @@ static const struct mssr_mod_clk r8a7792_mod_clks[] = {
 #define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 12) | \
 					 (((md) & BIT(13)) >> 12) | \
 					 (((md) & BIT(19)) >> 19))
-static const struct rcar_gen2_cpg_pll_config cpg_pll_configs[8] = {
+static const struct rcar_gen2_cpg_pll_config cpg_pll_configs[8] __initconst = {
 	{ 1, 208, 106, 200 },
 	{ 1, 208,  88, 200 },
 	{ 1, 156,  80, 150 },
-- 
2.40.1

