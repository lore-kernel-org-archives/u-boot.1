Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA218CCD18E
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 10:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083B383835;
	Mon, 13 Oct 2025 12:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="CrpSTWLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C616B8383E; Mon, 13 Oct 2025 12:55:16 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9DA8381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 12:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id BFA071F928;
 Mon, 13 Oct 2025 12:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1760352914;
 bh=lpnMmOg3zQqPbqQn+wPm0U/KnT/rf+03lRY2QiIf8ls=; h=From:To:Subject;
 b=CrpSTWLvE9XfyIGYkYFIhaLxkD9cNpd6y1PqB5mY9A6dV3P6dNmZJDXyx8Co7JosS
 6hT6laFNCltF7JckRHCxT8Hn7WIZefaWc7NkZxe08AaPGQUfO1JSoEVELP2iAzK1rG
 /NKhsPPXaySHKSgkliuTfzYs2OGvzUykP9dRZ2Q3bI9TK3c9hC6o4cjZfgakxbh4/X
 3hOuDkjAxlyYLEI/mM7NqefkkiqlaKKoI3w7ddRsqqc3qN64i9vpMG2lCR3SfOF8pr
 w0LQ9A5WtzX1/8sBK03hvajGfMYVG9qO3G9l76Y+31JjrftBpRc/oGkL5sPQ9J2pnO
 248h2K1gc4mkw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] board: toradex: fix aquila imx95 0098 pid4
Date: Mon, 13 Oct 2025 12:55:07 +0200
Message-Id: <20251013105507.35881-1-francesco@dolcini.it>
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

The memory size of the 0098 SKU is 8 GB instead of 16 GB.
Fix PID4 0098 Aquila iMX95 definition.

Fixes: 4c9340716522 ("toradex: tdx-cfg-block: add new pid4 support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 2 +-
 board/toradex/common/tdx-cfg-block.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 869656eee7a7..cb81646f9a1a 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -166,7 +166,7 @@ const struct toradex_som toradex_modules[] = {
 	{ APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ,  "Apalis iMX8QM 8GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
 	{ SMARC_IMX95_HEXA_8GB_WB_IT,            "SMARC iMX95 Hexa 8GB WB IT",           TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
 	{ SMARC_IMX8MPQ_4GB_WB_IT,               "SMARC iMX8M Plus Quad 4GB WB IT",      TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
-	{ AQUILA_IMX95_HEXA_16GB_WB_IT,          "Aquila iMX95 Hexa 16GB WB IT",         TARGET_IS_ENABLED(AQUILA_IMX95)         },
+	{ AQUILA_IMX95_HEXA_8GB_WB_IT,           "Aquila iMX95 Hexa 8GB WB IT",          TARGET_IS_ENABLED(AQUILA_IMX95)         },
 	{ VERDIN_AM62PQ_2G_WIFI_BT_IT,           "Verdin AM62P Quad 2GB WB IT",          TARGET_IS_ENABLED(VERDIN_AM62P_A53)     },
 	{ SMARC_IMX95_HEXA_8GB_IT,               "SMARC iMX95 Hexa 8GB IT",              TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
 	{ SMARC_IMX95_HEXA_4GB_WB_IT,            "SMARC iMX95 Hexa 4GB WB IT",           TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index d002b969bdfe..f78e69645cfe 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -124,7 +124,7 @@ enum {
 	APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ, /* 95 */
 	SMARC_IMX95_HEXA_8GB_WB_IT,
 	SMARC_IMX8MPQ_4GB_WB_IT,
-	AQUILA_IMX95_HEXA_16GB_WB_IT,
+	AQUILA_IMX95_HEXA_8GB_WB_IT,
 	VERDIN_AM62PQ_2G_WIFI_BT_IT, /* 99 */
 	SMARC_IMX95_HEXA_8GB_IT = 201,
 	SMARC_IMX95_HEXA_4GB_WB_IT,
-- 
2.39.5

