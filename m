Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454D5C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667AA88E67;
	Wed, 21 Aug 2024 18:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j8Lziwoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81ED88E14; Wed, 21 Aug 2024 18:19:58 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AE98811A
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7093efbade6so4407815a34.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257195; x=1724861995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4yv8xWkAlDiRRqQrlVUQ1sncuiPNGNY9r3D5FCNp6A=;
 b=j8LziwojJpv+2CzCLjf937F+dGD+PdUNR/e4b2X4vpaN7uVW0cXJrJUsNWvjqIHNFR
 VzV8DGnghVsj6Z9NcrCh4usa3zuHaTbTsqfDOC7WusxtDgxnUQmK3fSGwiSNuTnYN8qS
 0cbEcxFp3Nep06HXrpmOaMsCQZsbIk86e38n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257195; x=1724861995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4yv8xWkAlDiRRqQrlVUQ1sncuiPNGNY9r3D5FCNp6A=;
 b=lnKftFDZDE/4ycC8IAzP3FJtMYHQLSnD/zOCodFyS5uQCDyyZ8udHMcgDYiFHhjDz9
 1zoR4gg17UbtYi0sG8MuwlZMP1apVKXiKF393aEe0RrZWcx6Ahd5rtBysgxCFSI+G7DD
 TBG2zyp8krCI9Ygp7T179pQbyeWLy25TTfrwyLAPQuG4rAbV7Vkst6x7UGE3PGVhmQKk
 E6qvxeBxFi5x/vFP7QL0+XnPe1O0231k570Um1cX3TmA2MrUpSpLZYxJZIqR2obkq8Cl
 O7ycNRcwaKBs+ipEfLxy3Y0qrzCIaUu7ojE9Cgn31ZYDHq7vISY4UVw9j3uvgfiL4/r1
 fCEQ==
X-Gm-Message-State: AOJu0YyR08OgqnARRD8wVJVqViZFZ0PFktotlRe8bRIyJQ7fdwcuN4hx
 7GNWpfMZi/PCgwgdfLjvvcILzuGhrRwRo1ylYVepMOU+Z//Jz4wEiVeGxAb/YjJh6L8bEM2riVk
 =
X-Google-Smtp-Source: AGHT+IH3lvfpvtOuEQjb5auwMwaXV3kEsLg9BqMV1rSq5xmPN9n1maHdUsd+b0bcaUOcTZfVkiD8eg==
X-Received: by 2002:a05:6830:3109:b0:707:8b7d:b924 with SMTP id
 46e09a7af769-70df8745d7cmr3089397a34.10.1724257195128; 
 Wed, 21 Aug 2024 09:19:55 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 21/35] global_data: Drop spl_handoff
Date: Wed, 21 Aug 2024 10:19:13 -0600
Message-Id: <20240821161927.695717-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

Provide a function to locate this information, rather than doing it
automatically on startup, to save space in global_data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/intel_common/cpu_from_spl.c |  4 +---
 arch/x86/lib/fsp2/fsp_dram.c             |  4 ++--
 cmd/sb.c                                 |  6 ++++--
 common/board_f.c                         | 12 ------------
 common/init/handoff.c                    | 12 ++++++++++++
 drivers/clk/rockchip/clk_rk3399.c        |  3 ++-
 include/asm-generic/global_data.h        |  6 ------
 include/handoff.h                        |  7 +++++++
 8 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/x86/cpu/intel_common/cpu_from_spl.c b/arch/x86/cpu/intel_common/cpu_from_spl.c
index 48b2ef253cb..5aad2ae7309 100644
--- a/arch/x86/cpu/intel_common/cpu_from_spl.c
+++ b/arch/x86/cpu/intel_common/cpu_from_spl.c
@@ -24,9 +24,7 @@ int arch_cpu_init(void)
 	int ret;
 
 #if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_USE_HOB)
-	struct spl_handoff *ho = gd->spl_handoff;
-
-	gd->arch.hob_list = ho->arch.hob_list;
+	gd->arch.hob_list = handoff_get();
 #endif
 	ret = x86_cpu_reinit_f();
 
diff --git a/arch/x86/lib/fsp2/fsp_dram.c b/arch/x86/lib/fsp2/fsp_dram.c
index 83c6d7bcc93..a50dc985a3c 100644
--- a/arch/x86/lib/fsp2/fsp_dram.c
+++ b/arch/x86/lib/fsp2/fsp_dram.c
@@ -59,7 +59,7 @@ int dram_init(void)
 #endif
 	} else {
 #if CONFIG_IS_ENABLED(HANDOFF)
-		struct spl_handoff *ho = gd->spl_handoff;
+		struct spl_handoff *ho = handoff_get();
 
 		if (!ho) {
 			log_debug("No SPL handoff found\n");
@@ -82,7 +82,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 		return gd->ram_size;
 
 #if CONFIG_IS_ENABLED(HANDOFF)
-	struct spl_handoff *ho = gd->spl_handoff;
+	struct spl_handoff *ho = handoff_get();
 
 	log_debug("usable_ram_top = %lx\n", ho->arch.usable_ram_top);
 
diff --git a/cmd/sb.c b/cmd/sb.c
index 1aa5921f03e..db485fddfca 100644
--- a/cmd/sb.c
+++ b/cmd/sb.c
@@ -14,8 +14,10 @@ static int do_sb_handoff(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
 #if CONFIG_IS_ENABLED(HANDOFF)
-	if (gd->spl_handoff)
-		printf("SPL handoff magic %lx\n", gd->spl_handoff->arch.magic);
+	struct spl_handoff *handoff = handoff_get();
+
+	if (handoff)
+		printf("SPL handoff magic %lx\n", handoff->arch.magic);
 	else
 		printf("SPL handoff info not received\n");
 
diff --git a/common/board_f.c b/common/board_f.c
index eb74bfa428a..eb1a5f0e1e9 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -305,17 +305,6 @@ static int setup_mon_len(void)
 	return 0;
 }
 
-static int setup_spl_handoff(void)
-{
-#if CONFIG_IS_ENABLED(HANDOFF)
-	gd->spl_handoff = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF,
-					sizeof(struct spl_handoff));
-	debug("Found SPL hand-off info %p\n", gd->spl_handoff);
-#endif
-
-	return 0;
-}
-
 __weak int arch_cpu_init(void)
 {
 	return 0;
@@ -891,7 +880,6 @@ static const init_fnc_t init_sequence_f[] = {
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
 	bloblist_maybe_init,
-	setup_spl_handoff,
 #if defined(CONFIG_CONSOLE_RECORD_INIT_F)
 	console_record_init,
 #endif
diff --git a/common/init/handoff.c b/common/init/handoff.c
index a7cd065fb38..86c020ee0b9 100644
--- a/common/init/handoff.c
+++ b/common/init/handoff.c
@@ -5,6 +5,7 @@
  * Copyright 2018 Google, Inc
  */
 
+#include <bloblist.h>
 #include <handoff.h>
 #include <asm/global_data.h>
 
@@ -38,3 +39,14 @@ void handoff_load_dram_banks(struct spl_handoff *ho)
 		bd->bi_dram[i].size = ho->ram_bank[i].size;
 	}
 }
+
+struct spl_handoff *handoff_get(void)
+{
+	struct spl_handoff *handoff;
+
+	handoff = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF,
+				sizeof(struct spl_handoff));
+	debug("Found SPL hand-off info %p\n", handoff);
+
+	return handoff;
+}
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 24cefebd1b2..89924041299 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <dt-structs.h>
 #include <errno.h>
+#include <handoff.h>
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -1467,7 +1468,7 @@ static int rk3399_clk_probe(struct udevice *dev)
 	init_clocks = true;
 #elif CONFIG_IS_ENABLED(HANDOFF)
 	if (!(gd->flags & GD_FLG_RELOC)) {
-		if (!(gd->spl_handoff))
+		if (!handoff_get())
 			init_clocks = true;
 	}
 #endif
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 544195391bd..16c4b4fe676 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -396,12 +396,6 @@ struct global_data {
 	 */
 	struct bloblist_hdr *bloblist;
 #endif
-#if CONFIG_IS_ENABLED(HANDOFF)
-	/**
-	 * @spl_handoff: SPL hand-off information
-	 */
-	struct spl_handoff *spl_handoff;
-#endif
 #if defined(CONFIG_TRANSLATION_OFFSET)
 	/**
 	 * @translation_offset: optional translation offset
diff --git a/include/handoff.h b/include/handoff.h
index c0ae7b19a75..0072ea832f8 100644
--- a/include/handoff.h
+++ b/include/handoff.h
@@ -31,6 +31,13 @@ void handoff_save_dram(struct spl_handoff *ho);
 void handoff_load_dram_size(struct spl_handoff *ho);
 void handoff_load_dram_banks(struct spl_handoff *ho);
 
+/**
+ * handoff_get() - Get the SPL handoff information
+ *
+ * Return: Pointer to SPL handoff if received, else NULL
+ */
+struct spl_handoff *handoff_get(void);
+
 /**
  * handoff_arch_save() - Save arch-specific info into the handoff area
  *
-- 
2.34.1

