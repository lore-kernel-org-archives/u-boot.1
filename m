Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0A9C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 08:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB9A82E37;
	Mon, 14 Jul 2025 10:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="PYL6FFTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01BAE82E52; Mon, 14 Jul 2025 10:44:32 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5C582B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 10:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id A0F461FB7A;
 Mon, 14 Jul 2025 10:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1752482661;
 bh=L85b/2Q34h6R66hKXf2X2X0XOf7hk6knXGX8Ma3VUB4=; h=From:To:Subject;
 b=PYL6FFTAIMxRE4pNZZHc/CPz2o9fqOuE1oUBsOcNiqNB7+kpxIG82c5UZo+Sp4EeJ
 zP1PUPbG90t9MIUt/Mt3hb5wkpgZrhqJnEdQ2JPP+tDWRLSqI/jGDYEhUmdIeNUkE5
 0KMlbeRuTE0rKuLXaYAWPfwZQcYBFR7SPPvjPmrUsWaOs/43OOgU0b6Aoc/D/6Gmm6
 tPAPYwLCNNQeGHOakXcx7gLRzHvur7uCQUYdFmRtUpC0LYSgPhIctncBCpVE4geFs6
 0UMot/ERBH4uWFORp77IDl10Kc7sa7stvuMedBm/yH14PKgzDAZv6dQjj01kJHxcdV
 X+JqgNuaodvfQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1] board: toradex: Fix variant (wifi/non-wifi) selection
Date: Mon, 14 Jul 2025 10:44:16 +0200
Message-Id: <20250714084416.25920-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Do not dereference NULL, when "variant" env variable is not present.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/verdin-am62/verdin-am62.c     | 2 +-
 board/toradex/verdin-am62p/verdin-am62p.c   | 2 +-
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 2 +-
 board/toradex/verdin-imx8mp/verdin-imx8mp.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index eca2cc8bc7f8..100cfb90eb1c 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -95,7 +95,7 @@ static void select_dt_from_module_version(void)
 	else
 		strlcpy(&variant[0], "nonwifi", sizeof(variant));
 
-	if (strcmp(variant, env_variant)) {
+	if (!env_variant || strcmp(variant, env_variant)) {
 		printf("Setting variant to %s\n", variant);
 		env_set("variant", variant);
 	}
diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
index 43d1c9312fe3..a7124ecf823e 100644
--- a/board/toradex/verdin-am62p/verdin-am62p.c
+++ b/board/toradex/verdin-am62p/verdin-am62p.c
@@ -124,7 +124,7 @@ static void select_dt_from_module_version(void)
 	else
 		strlcpy(&variant[0], "nonwifi", sizeof(variant));
 
-	if (strcmp(variant, env_variant)) {
+	if (!env_variant || strcmp(variant, env_variant)) {
 		printf("Setting variant to %s\n", variant);
 		env_set("variant", variant);
 	}
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 066e8db678fb..04c918a079f3 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -100,7 +100,7 @@ static void select_dt_from_module_version(void)
 		break;
 	}
 
-	if (strcmp(variant, env_variant)) {
+	if (!env_variant || strcmp(variant, env_variant)) {
 		printf("Setting variant to %s\n", variant);
 		env_set("variant", variant);
 	}
diff --git a/board/toradex/verdin-imx8mp/verdin-imx8mp.c b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
index e57ec3b68967..34ce25512e8b 100644
--- a/board/toradex/verdin-imx8mp/verdin-imx8mp.c
+++ b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
@@ -90,7 +90,7 @@ static void select_dt_from_module_version(void)
 	else
 		strlcpy(&variant[0], "nonwifi", sizeof(variant));
 
-	if (strcmp(variant, env_variant)) {
+	if (!env_variant || strcmp(variant, env_variant)) {
 		printf("Setting variant to %s\n", variant);
 		env_set("variant", variant);
 	}
-- 
2.39.5

