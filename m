Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9DCC46CA0
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EFD8770C;
	Sun,  3 Dec 2023 14:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NHX5lR2f";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qUSP1XFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE28387616; Sun,  3 Dec 2023 14:17:14 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDF78759C
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SjnQH1FDQz9smf;
 Sun,  3 Dec 2023 14:17:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlE/Cr/aG95RwW5wbbEeszs1O1AOxpCSI/JH5mlLcXM=;
 b=NHX5lR2fqmvCy8RBBGxEu+ApjcmMBb9gYyKM/+T/vJsRsOQeqq6oFUZcoZ07k7eMziQsFP
 nq8aTo02M+m6iB3gbpbdwkMSOHHLxRdvnhKQu0MospSxWXKiPdpWih3KiPmNymb4J8PwDT
 XRdb25HNgHbd+2X83/9BR1nSmwl4l2podDaWVe27L8seRPEBb0nzWh9YxFuIeM5+UoXDbZ
 zXI9fyzOwmRZEaVmWytAjQ1At0C1oNjSGtyjP2yIjXVL6yOR1LeUQdwmbQiImFvarOgMul
 5Qgr0Rb446y2c4pzcRDQbZl/J6aWIfiDhjBXDVRyeDupCwwOur7gjtRF9GCxRQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlE/Cr/aG95RwW5wbbEeszs1O1AOxpCSI/JH5mlLcXM=;
 b=qUSP1XFjoLMOmglUYwHGhfUcsb4odelBV/kSMR3i91fRZtW0c36tjttMlCAZYEoJkFF/Ss
 9daWWvAM5H6h6/m11Olz5ZblmiUYAnNHezyv3Uqxcnhufq9B43m6GAtkoG7+pbKdwgmOmU
 ZLd1wcAmSasgM/VJZGbwyeY1fjPefm+lK6FGju0W9UaTs3MMdsdMZBldljOVxLP2b1F29r
 uYTgZpYmgzpE2uXX15VUWO8XrApF23+g011EJg6emEV0qLJv6S/fCRqW1x/Ms9iB7ixja6
 Y3qcqR+YgkrsrE0XOnvM0XNkOcm4jOVZLlGX/LvISX2H0vYvyR3CTUmxqSPXWw==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 05/12] clk: renesas: Synchronize RZ R8A774A1 RZ/G2M clock
 tables with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:17 +0100
Message-ID: <20231203131635.119191-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rtw56n11zuz4wfdhpojifki3bxagt7ea
X-MBO-RS-ID: 42ebc479d05046616eb
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

Synchronize RZ R8A774A1 RZ/G2M clock tables with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 6280061af89..6f94906cc99 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -75,6 +75,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",		R8A774A1_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
 	DEF_GEN3_Z("z2",	R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("zg",	R8A774A1_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A774A1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774A1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774A1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -122,6 +123,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
+	DEF_MOD("3dge",			 112,	R8A774A1_CLK_ZG),
 	DEF_MOD("tmu4",			 121,	R8A774A1_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A774A1_CLK_S3D2),
 	DEF_MOD("tmu2",			 123,	R8A774A1_CLK_S3D2),
@@ -212,6 +214,7 @@ static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
 	DEF_MOD("rpc-if",		 917,	R8A774A1_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A774A1_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A774A1_CLK_S0D6),
+	DEF_MOD("adg",			 922,	R8A774A1_CLK_S0D4),
 	DEF_MOD("iic-pmic",		 926,	R8A774A1_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A774A1_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A774A1_CLK_S0D6),
-- 
2.42.0

