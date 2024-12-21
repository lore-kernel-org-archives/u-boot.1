Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3536DE7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB7680585;
	Sat, 21 Dec 2024 22:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eGR6nXOu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cBcDysgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1ED180585; Sat, 21 Dec 2024 22:47:09 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90D98056B
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YFyYR3Yvjz9stK;
 Sat, 21 Dec 2024 22:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734817627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LD2fypUfrimQHOApmk8J4BBC9BXf2DCBx7uDP35CYcA=;
 b=eGR6nXOurFSQe0RdfYRdBerb8MV9aD1hc47e1JEG/sD7FQtlRcrEb5Vr9nm3wWckcdPRy1
 myBkFC8qQzMDBv1MvEVc0T5cQDXe4vsnvbZ+UunODQKi1BkmWt1G9rLpv85Wg65AFt+eAZ
 kmh10qvxnBHMTv6iG3t6KT+1icS2jLR6zsfRtDOHky9x+yaYT2ht8N2P12XzjbRbJ9++Ke
 0VOlmr64evc/iZQv0GE/gBTo1PRxBSVWR6v+uyxWqOlO+ao82oz62PPDSffaVAyHFmD8/X
 SGJQCGYfzWY9b/SAelHaOYeNVKqGUdiW+Z365F985JNLqQTVuc6iQXy1G71Qsg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734817625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LD2fypUfrimQHOApmk8J4BBC9BXf2DCBx7uDP35CYcA=;
 b=cBcDysgzprz0wAf/A25+qIjWoL8XBU2xXXMj1ks99I2YlCZb3HtpN34lir+cGuglhlvy4U
 cxR2xIoYH26+BbKX1mOckdi1pkiwSg29vcYRcHl6h9mo/AtddTn9NnPuE3MTh70oTSR+OI
 bbeYG3mAw/uaU1oMRsMpijKmvFxMD6hZAgFvPrnyKpXO1PpfzHC6ugz1CkDNj7aJ/d+kqb
 oH5gWD2omi7jSAA9ANde8ipDNQNMjQ7Z4nELmsmpGhHaOv7RUv3uiT2F0bV34kOfNb713F
 2B+ftcgYkHGfMtne6Gadk+ev0HvdAJSUsaP5Z1HV9zXHcYoBerFntGgCTXshzw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm64: renesas: Make bottom 128 MiB of DRAM available in
 EL3
Date: Sat, 21 Dec 2024 22:46:36 +0100
Message-ID: <20241221214647.158389-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 350d6829e783075bc33
X-MBO-RS-META: a33rbzy4mtjfzub4roibsyoxd3gzwuch
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

In case U-Boot runs in EL3, which is the highest privilege level on ARM64,
there can be no firmware running that would restrict access to the bottom
128 MiB of DRAM. In fact, it is likely that U-Boot would have to load that
firmware into those bottom 128 MiB of DRAM and start that firmware.

Make those bottom 128 MiB of DRAM available in case U-Boot runs in EL3 to
allow loading the firmware to that area.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Make this non-Gen4 specific, Gen3 an benefit from this too
---
 board/renesas/rcar-common/common.c | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/board/renesas/rcar-common/common.c b/board/renesas/rcar-common/common.c
index 4e35e0151c9..90eb468e4c4 100644
--- a/board/renesas/rcar-common/common.c
+++ b/board/renesas/rcar-common/common.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include <dm/uclass-internal.h>
 #include <asm/arch/renesas.h>
+#include <asm/system.h>
 #include <linux/libfdt.h>
 
 #ifdef CONFIG_RCAR_64
@@ -23,13 +24,42 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	int ret = fdtdec_setup_mem_size_base();
+
+	if (current_el() == 3 && gd->ram_base == 0x48000000) {
+		/*
+		 * If this U-Boot runs in EL3, make the bottom 128 MiB
+		 * available for loading of follow up firmware blobs.
+		 */
+		gd->ram_base -= 0x8000000;
+		gd->ram_size += 0x8000000;
+	}
+
+	return ret;
 }
 
 int dram_init_banksize(void)
 {
+	int bank;
+
 	fdtdec_setup_memory_banksize();
 
+	if (current_el() != 3)
+		return 0;
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		if (gd->bd->bi_dram[bank].start != 0x48000000)
+			continue;
+
+		/*
+		 * If this U-Boot runs in EL3, make the bottom 128 MiB
+		 * available for loading of follow up firmware blobs.
+		 */
+		gd->bd->bi_dram[bank].start -= 0x8000000;
+		gd->bd->bi_dram[bank].size += 0x8000000;
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.45.2

