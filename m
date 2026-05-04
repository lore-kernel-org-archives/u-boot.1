Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF27DCD343A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 14:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E91378466C;
	Mon,  4 May 2026 16:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="HpxiYMRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1228C8460C; Mon,  4 May 2026 16:48:42 +0200 (CEST)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDAF184653
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 16:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8PfH3Zl2z1BsV;
 Mon,  4 May 2026 16:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777906119;
 bh=FvHrAs4a5FH0KPVgq8epTQa33IAZE4NxGTNFxX5wkFg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HpxiYMRpUyWNHpc6GfcFwvb4890ZtaB/Lo38IW3p6oK8/EfQbbyI29a1ETts70nRc
 YkiptqzxIpPJ+yUzWdrZScQhbBFOamTNsjuS5HzH30GZRm4T4P8GRq1BUbE630pqGj
 tUJ1jyGoyjOVY4zjY+Vty8M7mLqwfEI93CFbiMj0Z8SqLvJ/dJJ9LSjtlgGiqCmOav
 OmWfKRwZIVjC5v2Mp0MvKt1fNGI5MpkPSxWZ/B57dTUF/qUHEDSpnxDZnJJOphAl4M
 cI67sEq1+ALWMywVaUHYwDd0H38wEyE0vbmrLFlTw3te6WN1iYF5/gzrsJtCTVJz8v
 AEUjTOCOII3ZQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8PfG4lyhzQ0L; Mon,  4 May 2026 16:48:38 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 16:48:29 +0200
Subject: [PATCH v2 2/2] cmd: ufetch: only show comma separator if there was
 a previous feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-ufetch-net-v2-2-01bec4ca7169@cherry.de>
References: <20260504-ufetch-net-v2-0-01bec4ca7169@cherry.de>
In-Reply-To: <20260504-ufetch-net-v2-0-01bec4ca7169@cherry.de>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Currently, if NET is disabled, the next feature to be printed will start
with a comma and a space which is not pretty. Add the comma and
whitespace only when a previous feature has already been shown.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/ufetch.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index bc5db08eee1..900b126b55b 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -157,26 +157,37 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 				printf(" (%d baud)", gd->baudrate);
 			putc('\n');
 			break;
-		case FEATURES:
+		case FEATURES: {
+			bool sep = false;
+
 			printf("Features:" RESET " ");
-			if (IS_ENABLED(CONFIG_NET))
-				printf("Net");
-			if (IS_ENABLED(CONFIG_EFI_LOADER))
-				printf(", EFI");
-			if (IS_ENABLED(CONFIG_CMD_CAT))
-				printf(", cat :3");
+			if (IS_ENABLED(CONFIG_NET)) {
+				printf("%sNet", sep ? ", " : "");
+				sep = true;
+			}
+			if (IS_ENABLED(CONFIG_EFI_LOADER)) {
+				printf("%sEFI", sep ? ", " : "");
+				sep = true;
+			}
+			if (IS_ENABLED(CONFIG_CMD_CAT)) {
+				printf("%scat :3", sep ? ", " : "");
+				sep = true;
+			}
 #ifdef CONFIG_ARM64
 			switch (current_el()) {
 			case 2:
-				printf(", VMs");
+				printf("%sVMs", sep ? ", " : "");
+				sep = true;
 				break;
 			case 3:
-				printf(", full control!");
+				printf("%sfull control!", sep ? ", " : "");
+				sep = true;
 				break;
 			}
 #endif
 			printf("\n");
 			break;
+		}
 		case RELOCATION:
 			if (gd->flags & GD_FLG_SKIP_RELOC)
 				printf("Relocated:" RESET " no\n");

-- 
2.54.0

