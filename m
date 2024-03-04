Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216B0C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 20:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F14D87FE0;
	Mon,  4 Mar 2024 21:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=georgemail.de header.i=@georgemail.de header.b="q8eFlvY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D4A87FED; Mon,  4 Mar 2024 21:39:19 +0100 (CET)
Received: from smtp6.goneo.de (smtp6.goneo.de [IPv6:2001:1640:5::8:31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A18F287E63
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 21:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon@georgemail.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 47A682402D9;
 Mon,  4 Mar 2024 21:39:14 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id E61412402D6;
 Mon,  4 Mar 2024 21:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.de;
 s=DKIM001; t=1709584754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jy1dYSB3HQrgr1ProPhm6ZJgEeoYRgmeN16CY+CjiAQ=;
 b=q8eFlvY+G8+zQLIA4jFCZH0ZNAeo0vfwfC7TmkhfzlYHBYHIfBM12gn1NuuJL3XyL3i61/
 1m7CvyCRsThItR0Ibdip2fLCV8fAxDnROIhTT6wsKCiBQC2/M+qtz2RTqLqnh/SFeBY6WU
 mN+6CbeTlYWbb5RF/WQ60khXH+CvKuzca3gaUb8SKJswvabP0Bl3IqjUmJj6JsUOh6m5Mc
 wPqOhtewc5oA7bPQVAqqv2FGL7FbgUepuoik3n7jxCu8alaXbY+P1RfPG6HABQXvSBncW3
 iH3OZNe41zaKYLfTxSUZndjETEhB4ZlKzQGfoo7BBrg87lnQ0sSjjC8q0dzjnw==
Received: from couch-potassium.fritz.box (unknown
 [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id B46732400FE;
 Mon,  4 Mar 2024 21:39:13 +0100 (CET)
From: "Leon M. Busch-George" <leon@georgemail.de>
To: u-boot@lists.denx.de,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v2] Makefile: use shell to calculate map_size
Date: Mon,  4 Mar 2024 21:38:56 +0100
Message-ID: <20240304203909.63796-1-leon@georgemail.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302131728.148251-1-leon@georgemail.de>
References: <20240302131728.148251-1-leon@georgemail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 2fe88c
X-Rspamd-UID: cca88b
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

From: "Leon M. Busch-George" <leon@georgemail.eu>

The error message "bc: command not found" is easily missed since the
build continues.
bc is not a part of coreutils or base-devel. POSIX sh can also do the
calculation.

Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>
---
 Makefile | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index a2bc9d5903..e8e794368e 100644
--- a/Makefile
+++ b/Makefile
@@ -1275,10 +1275,15 @@ OBJCOPYFLAGS_u-boot-nodtb.bin := -O binary \
 binary_size_check: u-boot-nodtb.bin FORCE
 	@file_size=$(shell wc -c u-boot-nodtb.bin | awk '{print $$1}') ; \
 	map_size=$(shell cat u-boot.map | \
-		awk '/_image_copy_start/ {start = $$1} /_image_binary_end/ {end = $$1} END {if (start != "" && end != "") print "ibase=16; " toupper(end) " - " toupper(start)}' \
-		| sed 's/0X//g' \
-		| bc); \
-	if [ "" != "$$map_size" ]; then \
+		awk ' \
+			/_image_copy_start/ { start = $$1 } \
+			/_image_binary_end/ { end = $$1 } \
+			END { \
+				if (start != "" && end != "") \
+					print end " " start; \
+			}' \
+		| sh -c 'read end start; [ -n "$$end" ] && echo $$((end - start))'); \
+	if [ -n "$$map_size" ]; then \
 		if test $$map_size -ne $$file_size; then \
 			echo "u-boot.map shows a binary size of $$map_size" >&2 ; \
 			echo "  but u-boot-nodtb.bin shows $$file_size" >&2 ; \
-- 
2.44.0

