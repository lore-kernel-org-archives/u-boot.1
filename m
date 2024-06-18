Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F61C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 22:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CC487FA1;
	Wed, 19 Jun 2024 00:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eNpKmU/d";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t+SjVT6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03C487E2E; Wed, 19 Jun 2024 00:55:33 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0257881E7
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W3htC4X97z9sHh
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JouqAOx3yWTlhjdjBkTCmRxw8z0OzHac7TCEwDsjuyU=;
 b=eNpKmU/dqdQWNwdy9flv4w9GBTO1QjDJ5W7QyEHTDlPaXcjMA9+HZpRPeNtxFUuk7DHcLu
 HiXeAu+8rtm+FTCvwgh86R5ykgYWvJKE3AQxGGwyyaCe8Lnv/FoXM5cjK3PiJ5roEnnyMk
 0gDbATq6TXoMvQaEvbSV52SXXIR5PdXjp8g02yPn2NDvJBBFUl5zJSajHoh88B+C8iq/Xc
 vjTZ55mbwRoHsN+FJMjD4SUIGD5vUfAl4MYSQt12V/5Q93mao1TIvQPWpVNGxJph1viOuV
 yzMyE+/714mIPT6EOWRDOFCHTlyCpil2gJDlJCGPsSea4sb01WsO+fSnw2bT3Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JouqAOx3yWTlhjdjBkTCmRxw8z0OzHac7TCEwDsjuyU=;
 b=t+SjVT6o3/7dn5r0dDjp276bOnQ2urEaJ2I1fk0t1IiwmFNiKKyivQS9BKLQfpktHqK0WS
 E4rXNsYsaLn3RC4DcAwKovLYRCxmtk/ijNuXzIE1crLr47Ul5hh9pHRINOrgJHJNRTWRxl
 k1bdA1wpCi+3qHwV0YL3BVwCfR4Fe3tibMhTr6LdcrLl6QSHUTfKl93GIquSDvGD7GYZ19
 iEq2zHMauB2q7qDrreAo0qtvIKAdURXx0goqTck8oN6W1NVLHutTRmLflYp6s7S0T5pdZ6
 +lpzbAh84UsinK+DkAsVMHXipItZH8nsl8yUL7Foqx+vaz9BJmkJz1DkSTKyuA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/6] clk: renesas: Synchronize R-Car R8A77951 H3 clock tables
 with Linux 6.9.3
Date: Wed, 19 Jun 2024 00:54:15 +0200
Message-ID: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: af7f94d0643929e08e7
X-MBO-RS-META: jhdifnigq45gmrhhkoqjpgiztw4cu7jz
X-Rspamd-Queue-Id: 4W3htC4X97z9sHh
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

Synchronize R-Car R8A77951 H3 clock tables with Linux 6.9.3,
commit 1b4861e32e461b6fae14dc49ed0f1c7f20af5146 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a7795-cpg-mssr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index e511f74982b..4225036a1a9 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -77,6 +77,7 @@ static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",         R8A7795_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
 	DEF_GEN3_Z("z2",        R8A7795_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("zg",        R8A7795_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A7795_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7795_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7795_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -126,6 +127,7 @@ static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
 };
 
 static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
+	DEF_MOD("3dge",			 112,	R8A7795_CLK_ZG),
 	DEF_MOD("fdp1-1",		 118,	R8A7795_CLK_S0D1),
 	DEF_MOD("fdp1-0",		 119,	R8A7795_CLK_S0D1),
 	DEF_MOD("tmu4",			 121,	R8A7795_CLK_S0D6),
@@ -249,6 +251,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("rpc-if",		 917,	R8A7795_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A7795_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A7795_CLK_S0D6),
+	DEF_MOD("adg",			 922,	R8A7795_CLK_S0D4),
 	DEF_MOD("i2c-dvfs",		 926,	R8A7795_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A7795_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A7795_CLK_S0D6),
-- 
2.43.0

