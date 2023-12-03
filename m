Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A978CC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89DEB87622;
	Sun,  3 Dec 2023 14:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HPL6HieV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iIkOBkGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD24A875FC; Sun,  3 Dec 2023 14:17:13 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E033875C9
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SjnQF1Sq9z9shP;
 Sun,  3 Dec 2023 14:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqJWNH7pDE6LBe+anE6Fb1tL1Bv/pH8uLi7iaPLixSQ=;
 b=HPL6HieV1vO/8pb/mn4WY2N//7fS1rmJAop/WSNFRjIQRDdjPqMTTS3+iFvBFf15voxcUE
 UwhPSyfJfmdQuy2Cqji2MeREWdbpR42kdtiwFpBd+DgvJkKAjBafeuFBEoG2vZANBj5hwW
 l6pFTfadAts+Zd51KvgL6IFA2ZsG8gytfJ4iA+qYpRXZNcJma4S+sfzuUoZpfAKbYVYxAA
 33DTL6EbrR/kRxknPmiCVB7Tl2DX04ZBjXIr9/kYbmkSF+HIJY5OXYvcFER3ipx5kZWAm5
 XSskYp/dZTtnuF45dmOL1c4ZqkjfqhrgnENOPMMK40QD4UmnAwRaeY/bnf4ojw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqJWNH7pDE6LBe+anE6Fb1tL1Bv/pH8uLi7iaPLixSQ=;
 b=iIkOBkGO6bRqlFl0BdEc/EMpqXV98ZyzrZAoPEdBT8YV89Kfdr+aQWAY467Bcc2vAUnjKH
 poAWWQdrrgXmYqcNHkhkFJhwF9PYBrMXM6X6tgu95tEPrmoAjDFMVvM2FBteLk0Sx+biaV
 MCOKMdwNOQu75ht0aN/K7DKCCI9BKSu7RZqYo3zPpOJc8+ksjEP+LRuc8lu0wO9UUhWXbN
 pWK2GB3IGPEVeaJBmaMFkyfpz5FaLkES/SR0XhI7pJjZR0H5pu58fWNamVWSJdtRa1GNLX
 LAkrYDucKFMIBi8+fq996n9sqDQEVg/ZgaXJIfxkPBzU4oqxpm6CSesJnlUklQ==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 02/12] clk: renesas: Synchronize R-Car R8A77965 M3-N clock
 tables with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:14 +0100
Message-ID: <20231203131635.119191-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4cb2e851e48ee31dadf
X-MBO-RS-META: gotokm8dgq1ma178iuc7xw7q3g6uyw85
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

Synchronize R-Car R8A77965 M3-N clock tables with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 8a5c1525ece..cf4503803d0 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -76,6 +76,7 @@ static const struct cpg_core_clk r8a77965_core_clks[] __initconst = {
 
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",		R8A77965_CLK_Z,		CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
+	DEF_GEN3_Z("zg",	R8A77965_CLK_ZG,	CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",	R8A77965_CLK_ZTR,	CLK_PLL1_DIV2,	6, 1),
 	DEF_FIXED("ztrd2",	R8A77965_CLK_ZTRD2,	CLK_PLL1_DIV2,	12, 1),
 	DEF_FIXED("zt",		R8A77965_CLK_ZT,	CLK_PLL1_DIV2,	4, 1),
@@ -125,6 +126,7 @@ static const struct cpg_core_clk r8a77965_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
+	DEF_MOD("3dge",			112,	R8A77965_CLK_ZG),
 	DEF_MOD("fdp1-0",		119,	R8A77965_CLK_S0D1),
 	DEF_MOD("tmu4",			121,	R8A77965_CLK_S0D6),
 	DEF_MOD("tmu3",			122,	R8A77965_CLK_S3D2),
@@ -236,6 +238,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("rpc-if",		917,	R8A77965_CLK_RPCD2),
 	DEF_MOD("i2c6",			918,	R8A77965_CLK_S0D6),
 	DEF_MOD("i2c5",			919,	R8A77965_CLK_S0D6),
+	DEF_MOD("adg",			922,	R8A77965_CLK_S0D4),
 	DEF_MOD("i2c-dvfs",		926,	R8A77965_CLK_CP),
 	DEF_MOD("i2c4",			927,	R8A77965_CLK_S0D6),
 	DEF_MOD("i2c3",			928,	R8A77965_CLK_S0D6),
-- 
2.42.0

