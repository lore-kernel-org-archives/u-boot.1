Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5802DFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1A984693;
	Tue, 28 Apr 2026 12:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="bgEX6yK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18128467C; Tue, 28 Apr 2026 12:56:18 +0200 (CEST)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fa8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563DD8467C
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g4cmw0XJRz1gx;
 Tue, 28 Apr 2026 12:56:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777373775;
 bh=nGKmvPFQo/I5oao6zu4PZ1OymaJhmI8qWyG/2sF9tfY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bgEX6yK3uh3wT24ApQdjJM3GCgCy83Y0486DZ1KPesakZK2eiKFKwD0raO/aPv3Wu
 cb773Cs4Bps6axzk1kOr4qC6GWzqGiw9UB3HUjGIrgS+4fjw6c3qBc2jhoMXGNRLyB
 c1yUXfz5/dM8lG+zbCSor75EMqjYWNNfTFoBSfhx7fra1O9K9bxkZ1P8lwPXsp7qX6
 14nw2QXF9x7vawmif3yiG1U72DDdjXEuj11JN/46qZiElxMsWkn37i77Bzts8LceNT
 UOtVQrJaf2HAQs3ZTQ/wvxGxEWAAr65x7rxjLulsE7QqUPoqkQ5YlpadgJOy/3LbVG
 XVwgBKWZvE27g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g4cmv1gKFzmfJ; Tue, 28 Apr 2026 12:56:15 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Apr 2026 12:56:05 +0200
Subject: [PATCH 2/2] cmd: ufetch: only show comma separator if there was a
 previous feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ufetch-net-v1-2-5d58c7618239@cherry.de>
References: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
In-Reply-To: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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
index bc5db08eee1..5c0d09c07bf 100644
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
+				printf(":%scat :3", sep ? ", " : "");
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

