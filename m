Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43982C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2A48761C;
	Sun,  3 Dec 2023 14:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PgXiP2AO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JALrphWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DD687636; Sun,  3 Dec 2023 14:17:15 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229168760C
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SjnQH5Wp6z9sWg;
 Sun,  3 Dec 2023 14:17:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4qZp9cHuUF7g67HUce/WCeSmgf9UmhubJY8cx+j1c8=;
 b=PgXiP2AOke1nIXatv/aXakkvmOLrbFdtm88fLCZLLV+VQ1YFLZp+Zz0BjfPKlj+2Hl7mqN
 Nb4IXAfPe15gJ8VCN5I4tu0rzOF+IU+vzc6cAWpGUdUTBgOq3N5OvJoNSG+B4MkUwbniG0
 SlalIrnqVQ5NPos7pm4uZvvE15M+wUzeJRop0Wzs8F16SnYTa0Lv3h1imGkwxY8Og8fv/A
 BDdNdce4Skq4IdIHwSyiD3r9dLZ5VILvW8wEYCVZgjoTA2b23RZhJIT4qhtGwoouZ2Yqk0
 294u97kcf2KUZV8eleqrJLQrOZH1tZnUV93eQLC0BLEcgygK4O22yGB9bsOSkA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4qZp9cHuUF7g67HUce/WCeSmgf9UmhubJY8cx+j1c8=;
 b=JALrphWHsbDPFFlyRaT8QqV/UsNQ9fc9HGKuJhplIhDGVOSPcd/y4STm3if9DMdqEDJRsL
 eEMWgrkEG5A3wYaWDb9h6vF/dN7b0FNx+P8NsuOZwr1HR4Iu5bbCfBSaBgM+q5AfBPd+g/
 k503pL2i2ci7Zo2mz+o6jcyg1w1w6EqZbwOhA9PR5nGqtdLXRD5aZJP36q3sahhJyyJBNt
 bVtPWkSSqNhrxPz32NWIDVenrAzkkznX8ZVgeco8s3OgkVRv0M3Mztq9Q1KhaHVGgB9GKK
 euFIbK956w+F9i1mdjajWD+pZlZZcNOCJZXLm1x6QIe+zZycgbU/cKyJM7icgw==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/12] clk: renesas: Synchronize RZ R8A774B1 RZ/G2N clock
 tables with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:18 +0100
Message-ID: <20231203131635.119191-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 88707d9ce6e287b61cd
X-MBO-RS-META: jzfo37og4w8b4kr9eypuhzmbew7peab3
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

Synchronize RZ R8A774B1 RZ/G2N clock tables with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a774b1-cpg-mssr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r8a774b1-cpg-mssr.c b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
index 60f4f1da519..1a794980319 100644
--- a/drivers/clk/renesas/r8a774b1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
@@ -72,6 +72,7 @@ static const struct cpg_core_clk r8a774b1_core_clks[] __initconst = {
 
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",         R8A774B1_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
+	DEF_GEN3_Z("zg",        R8A774B1_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A774B1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774B1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774B1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -119,6 +120,7 @@ static const struct cpg_core_clk r8a774b1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774b1_mod_clks[] __initconst = {
+	DEF_MOD("3dge",			 112,	R8A774B1_CLK_ZG),
 	DEF_MOD("tmu4",			 121,	R8A774B1_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A774B1_CLK_S3D2),
 	DEF_MOD("tmu2",			 123,	R8A774B1_CLK_S3D2),
@@ -208,6 +210,7 @@ static const struct mssr_mod_clk r8a774b1_mod_clks[] __initconst = {
 	DEF_MOD("rpc-if",		 917,	R8A774B1_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A774B1_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A774B1_CLK_S0D6),
+	DEF_MOD("adg",			 922,	R8A774B1_CLK_S0D4),
 	DEF_MOD("iic-pmic",		 926,	R8A774B1_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A774B1_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A774B1_CLK_S0D6),
-- 
2.42.0

