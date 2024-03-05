Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF2CC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D9D8801A;
	Tue,  5 Mar 2024 17:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=georgemail.de header.i=@georgemail.de header.b="imNq6A/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C8488042; Tue,  5 Mar 2024 17:47:21 +0100 (CET)
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9417F87D07
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon@georgemail.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 55D25240AB2;
 Tue,  5 Mar 2024 17:47:19 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id B8804240252;
 Tue,  5 Mar 2024 17:47:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.de;
 s=DKIM001; t=1709657237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sd9hPaMBfhPpwGlQ6pVlSoiCv+f2HcfEFqLkJS47zQA=;
 b=imNq6A/nh4/DR9Lc1K0zPLd2KOBne6UjGuhdEvkJJRZ475sVX4P5gYZnYH01pBRKBktl+w
 QG1wVSwUzia5s293mEO1b6g1VURJg27r0pvrB9G/qp1z64208z/ou8yxFd0YIVaK4gpEcz
 /j5aWemSX/8Gtt1lzhe8v3bIl4AjSYPVbuIQpLjmEj9+7uuLeWpR2NhminKcukMGxOSml/
 SHilULxI8uVF0a6MAkYOBGKhU9jv1BPptJQgCa0pphyDmR1su5AC+Bv8nnSNwbYIAqJoo+
 qKofExUsbBVhPFTS5iCIzW4/HO53JT78OqMh/mzjj/7l4UewXTZDli+wnfgpsQ==
Received: from couch-potassium.fritz.box (unknown
 [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 82801240125;
 Tue,  5 Mar 2024 17:47:17 +0100 (CET)
From: "Leon M. Busch-George" <leon@georgemail.de>
To: u-boot@lists.denx.de,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v3] Makefile: use shell to calculate map_size
Date: Tue,  5 Mar 2024 17:46:24 +0100
Message-ID: <20240305164707.23144-1-leon@georgemail.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304203909.63796-1-leon@georgemail.de>
References: <20240304203909.63796-1-leon@georgemail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: b58ae5
X-Rspamd-UID: a427a9
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
index a2bc9d5903..0aef07ef3b 100644
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
+		| sh -c 'read end start && echo $$((end - start))'); \
+	if [ -n "$$map_size" ]; then \
 		if test $$map_size -ne $$file_size; then \
 			echo "u-boot.map shows a binary size of $$map_size" >&2 ; \
 			echo "  but u-boot-nodtb.bin shows $$file_size" >&2 ; \
-- 
2.44.0

