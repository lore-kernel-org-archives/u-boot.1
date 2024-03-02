Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A9BC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 13:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679D28744F;
	Sat,  2 Mar 2024 14:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=georgemail.de header.i=@georgemail.de header.b="k56wgYPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7378887B30; Sat,  2 Mar 2024 14:17:41 +0100 (CET)
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A1C87E7F
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 14:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon@georgemail.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 407E0240458
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 14:17:39 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id A4EBD240128
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 14:17:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.de;
 s=DKIM001; t=1709385457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hgoVj0HBxpwFXS8QscxsnFNiCPbt/bA3YFEFfC4iu1g=;
 b=k56wgYPauNEj92f2ZZUUZdA92F7PAfvN7FUcaRBDsQ9Gt40BP+xlRkigjgqFPc/K9Wmv86
 8pTUpANYLaFCLOBoJACBo9tAXS0pq4c5abDDOnHbIe4UcohF3jqMawd7APl0LmecoKzVYT
 2AZNSJ3lcAFPwtTGSLroU+ZtyRk5rrIR1JuHeaUhTExkrlx84Qbsqmb3+mAKA6Np+gJMDo
 AsakgYG3zf/mStoDqGMBRABdge+CkE5wcz4ZTbxO3Q2HKi26d+dX/8AVif2xVBrjkoVRd9
 VIVMFz1KlOuJCnsL7UatEA+EeWYZJT/OzKoRy5iZoEULJRm/Zhgk0awBJrgvKQ==
Received: from couch-potassium.fritz.box (unknown
 [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 76D79240030
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 14:17:37 +0100 (CET)
From: "Leon M. Busch-George" <leon@georgemail.de>
To: u-boot@lists.denx.de
Subject: [PATCH] Makefile: use shell to calculate map_size
Date: Sat,  2 Mar 2024 14:17:19 +0100
Message-ID: <20240302131728.148251-1-leon@georgemail.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 4c936b
X-Rspamd-UID: 7d9926
X-Mailman-Approved-At: Sat, 02 Mar 2024 14:49:18 +0100
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
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7a3209bd9e..41dc4baad2 100644
--- a/Makefile
+++ b/Makefile
@@ -1275,9 +1275,9 @@ OBJCOPYFLAGS_u-boot-nodtb.bin := -O binary \
 binary_size_check: u-boot-nodtb.bin FORCE
 	@file_size=$(shell wc -c u-boot-nodtb.bin | awk '{print $$1}') ; \
 	map_size=$(shell cat u-boot.map | \
-		awk '/_image_copy_start/ {start = $$1} /_image_binary_end/ {end = $$1} END {if (start != "" && end != "") print "ibase=16; " toupper(end) " - " toupper(start)}' \
+		awk '/_image_copy_start/ {start = $$1} /_image_binary_end/ {end = $$1} END {if (start != "" && end != "") print "echo $$((0x" toupper(end) " - 0x" toupper(start) "))"}' \
 		| sed 's/0X//g' \
-		| bc); \
+		| sh); \
 	if [ "" != "$$map_size" ]; then \
 		if test $$map_size -ne $$file_size; then \
 			echo "u-boot.map shows a binary size of $$map_size" >&2 ; \
-- 
2.44.0

