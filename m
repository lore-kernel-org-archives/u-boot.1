Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D033AC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 22:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502138841E;
	Wed, 19 Jun 2024 00:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SeA6ui6v";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xWuWhp7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A85987B1A; Wed, 19 Jun 2024 00:55:35 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE25883D2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W3htD70kRz9sms
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPdWjNzuBO9dGeGsR6TnTQjWxkDFRZtdYos4tifgDgE=;
 b=SeA6ui6v0zrKVZ/JsFl3zuAz2UuveaBuZX2OvY3rR89/yI0cYBMQNqVeAjX8sax1R3/vEp
 BtSKDDZlTy8fnsnnI/0VZyfU2qwuQ1YVWn7UMXBLjXnmhJuya/gXJr3IbiuxPcz631Mz7N
 jS5jWuGf+84FrUZqvUWaIBMTNUvP3RfvLIJMtc3bPQdkPU/GGit3IdCrjAzey1CjLvbTg8
 SClddS+6u78abboXEa2+x4ZXoRdR25Axs7DNTcvrpcJB2BgPWAFKkORVWh1MstVdXdoayl
 rwEgaYOAwE1xaHNCOzV5fJZzWvSezQs5Jtvt0HP0apE1lfprVLs95WvyxCmlxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPdWjNzuBO9dGeGsR6TnTQjWxkDFRZtdYos4tifgDgE=;
 b=xWuWhp7kU8UEHcrDRuBbWFDIkYTL7xoI9FMljssKAnJq05uuxt29IynCSBhBSTeLGgSf6M
 p3zKSDxacCDCqt4zM7qSv0aV2ifcCLv74cTTYg5YeB4f74awBVtDkCV9+92FWnP0NTwBhK
 /Jw26OPIJaAexjETmWl26UCeOfQJyTM3v2BhgdgoY47GE8PoGK7kpZp+atFmk6kpFK0ljp
 psq1qo0bKx1QPWwK6hYZOsllfzuFRUfihKCcI/bNPvdjV37Wzxn+B2B2je0uP3ef8m/bvh
 SD8BJrMh4zfkM55TAaM12HSVp03EJ96MYShT6BBAGXE7vZKGCMPYUZGk9lgtQg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 4/6] clk: renesas: Synchronize R-Car R8A779G0 V4H clock tables
 with Linux 6.9.3
Date: Wed, 19 Jun 2024 00:54:18 +0200
Message-ID: <20240618225505.154437-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
References: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sdhtp6o4uycqjes5ayw1kappaqqa5fbj
X-MBO-RS-ID: c1d262b3c1d05079501
X-Rspamd-Queue-Id: 4W3htD70kRz9sms
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

Synchronize R-Car R8A779G0 V4H clock tables with Linux 6.9.3,
commit 1b4861e32e461b6fae14dc49ed0f1c7f20af5146 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       | 14 +++++++++-----
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 781806eed58..4df0a69cfe1 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -17,7 +17,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R8A779G0_CLK_R,
+	LAST_DT_CORE_CLK = R8A779G0_CLK_CP,
 
 	/* External Input Clocks */
 	CLK_EXTAL,
@@ -136,6 +136,7 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
 	DEF_FIXED("svd2_vip",	R8A779G0_CLK_SVD2_VIP,	CLK_SV_VIP,	2, 1),
 	DEF_FIXED("cbfusa",	R8A779G0_CLK_CBFUSA,	CLK_EXTAL,	2, 1),
 	DEF_FIXED("cpex",	R8A779G0_CLK_CPEX,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("cp",		R8A779G0_CLK_CP,	CLK_EXTAL,	2, 1),
 	DEF_FIXED("viobus",	R8A779G0_CLK_VIOBUS,	CLK_VIO,	1, 1),
 	DEF_FIXED("viobusd2",	R8A779G0_CLK_VIOBUSD2,	CLK_VIO,	2, 1),
 	DEF_FIXED("vcbus",	R8A779G0_CLK_VCBUS,	CLK_VC,		1, 1),
@@ -187,6 +188,8 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("msi3",		621,	R8A779G0_CLK_MSO),
 	DEF_MOD("msi4",		622,	R8A779G0_CLK_MSO),
 	DEF_MOD("msi5",		623,	R8A779G0_CLK_MSO),
+	DEF_MOD("pciec0",	624,	R8A779G0_CLK_S0D2_HSC),
+	DEF_MOD("pciec1",	625,	R8A779G0_CLK_S0D2_HSC),
 	DEF_MOD("pwm",		628,	R8A779G0_CLK_SASYNCPERD4),
 	DEF_MOD("rpc-if",	629,	R8A779G0_CLK_RPCD2),
 	DEF_MOD("scif0",	702,	R8A779G0_CLK_SASYNCPERD4),
@@ -225,11 +228,12 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",		911,	R8A779G0_CLK_R),
 	DEF_MOD("cmt2",		912,	R8A779G0_CLK_R),
 	DEF_MOD("cmt3",		913,	R8A779G0_CLK_R),
-	DEF_MOD("pfc0",		915,	R8A779G0_CLK_CL16M),
-	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CL16M),
-	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CL16M),
-	DEF_MOD("pfc3",		918,	R8A779G0_CLK_CL16M),
+	DEF_MOD("pfc0",		915,	R8A779G0_CLK_CP),
+	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CP),
+	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CP),
+	DEF_MOD("pfc3",		918,	R8A779G0_CLK_CP),
 	DEF_MOD("tsc",		919,	R8A779G0_CLK_CL16M),
+	DEF_MOD("tsn",		2723,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("ssiu",		2926,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("ssi",		2927,	R8A779G0_CLK_S0D6_PER),
 };
diff --git a/include/dt-bindings/clock/r8a779g0-cpg-mssr.h b/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
index 754c54a6eb0..7850cdc62e2 100644
--- a/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
@@ -86,5 +86,6 @@
 #define R8A779G0_CLK_CPEX		74
 #define R8A779G0_CLK_CBFUSA		75
 #define R8A779G0_CLK_R			76
+#define R8A779G0_CLK_CP			77
 
 #endif /* __DT_BINDINGS_CLOCK_R8A779G0_CPG_MSSR_H__ */
-- 
2.43.0

