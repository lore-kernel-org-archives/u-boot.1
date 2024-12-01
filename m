Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9065D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 14:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A3C8912B;
	Sun,  1 Dec 2024 15:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="irzKk7P4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2CB4892E5; Sun,  1 Dec 2024 15:43:18 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF59289275
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83eb38883b5so108304739f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064189; x=1733668989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/dnl7p8B66ze8S7kOZPi/Y5Esqyr7ALxC+uR5RWHkI=;
 b=irzKk7P4/YsOPTN6sgycxfqvhdr5cOZT60fyak7s1H7JQPF5FYen9hPrBpRYe1M8Xa
 RR/EgcRy57S+9yOZEQW+yleL8wbZeREgi5DlcAI0G7XMzQM4s6Sm0gZ2ddecaHKUEsDb
 2tpiUYyAig/71OqVE5sd2QzeGbu/8ZHFR6+v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064189; x=1733668989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/dnl7p8B66ze8S7kOZPi/Y5Esqyr7ALxC+uR5RWHkI=;
 b=gFzUhr/pOsFfSGB+z+q/x0qk2MKN8bCHlE+2F83Rwqh5X9kYyBqb+hm8nbdqPlNu7Y
 D+RQvBViaThHQCnGpKYMgCHRNmrxi8eL1Y6Dwz6C2J1Ku4C3UYTuA4HYxqQfszvaRhW1
 THN/U524TjhTTWLL9iSfl29h1f33whnDTorDwEkGc8OhGv+htT6KB4gmQWmmqu4FKZ3N
 9IGz6oK03zVI3wF5UDROWzlbRISMd+umRfEWP8V3QNQsbOul5Z5XZkUDuuJfsA5zLK6K
 2XiFitpWk1Q6MPajJUqYFbc6BAGlAfEC5VSKDWprzmX2Cmw8eZo58an+vrOF/sFhVhYx
 Y3Ug==
X-Gm-Message-State: AOJu0Yx6NTYN5Q4wRrRxWUOe3V4auLXZPYfsqMVS51J8KW4B70/RDaec
 xWMVxlxNHdzP69N1DWKgtH9PABzMhCQ7xoWeKZj0YNvZBhKGBf7BWbbZh+nKZPdVE0V6ssyWN/k
 =
X-Gm-Gg: ASbGncsttUPA8cEku+w8NF0mNRmVeKoy1Vnqn4sG4v7eo90QVMof/OtRSv0x4HppmYj
 bwIUwp5UeDKgfPByZAxNAx7g8XZfXPMAAdnXRC4BFWbTh7el7ORY4J5ouKNpVBU7/CZBF/yd9Yj
 8fV9AcRH5aZqDoAP0oamh6HTCrUYpbDJE1yqT9I4FiLPQa9vee6bVhOhRtfQBm3sbn+Gm40bDZx
 j/iT8/bMJLDAJ/c+YlljBRh5UaKojlS8BouWEWpZDL9
X-Google-Smtp-Source: AGHT+IHrP/OatBnRJFSwPIO3VIjN/Yv1RTf6q3AObKM9bQ/5ZgWsTnzDPgI8O4EirZKMKRIBld9JEw==
X-Received: by 2002:a05:6602:448:b0:843:f220:fa34 with SMTP id
 ca18e2360f4ac-843f220fe90mr1436753139f.15.1733064189470; 
 Sun, 01 Dec 2024 06:43:09 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:43:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 7/8] Revert "global_data: Drop spl_handoff"
Date: Sun,  1 Dec 2024 07:42:35 -0700
Message-ID: <20241201144240.1664398-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
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

This breaks chromebook_coral which says:

   Video: No video mode configured in FSP!

This reverts commit 2e9313179a846b581c0fc3f6a49e19f3d343efa8.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/intel_common/cpu_from_spl.c |  4 +++-
 arch/x86/lib/fsp2/fsp_dram.c             |  4 ++--
 cmd/sb.c                                 |  6 ++----
 common/board_f.c                         | 12 ++++++++++++
 common/init/handoff.c                    | 12 ------------
 drivers/clk/rockchip/clk_rk3399.c        |  3 +--
 include/asm-generic/global_data.h        |  6 ++++++
 include/handoff.h                        |  7 -------
 8 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/x86/cpu/intel_common/cpu_from_spl.c b/arch/x86/cpu/intel_common/cpu_from_spl.c
index 5aad2ae7309..48b2ef253cb 100644
--- a/arch/x86/cpu/intel_common/cpu_from_spl.c
+++ b/arch/x86/cpu/intel_common/cpu_from_spl.c
@@ -24,7 +24,9 @@ int arch_cpu_init(void)
 	int ret;
 
 #if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_USE_HOB)
-	gd->arch.hob_list = handoff_get();
+	struct spl_handoff *ho = gd->spl_handoff;
+
+	gd->arch.hob_list = ho->arch.hob_list;
 #endif
 	ret = x86_cpu_reinit_f();
 
diff --git a/arch/x86/lib/fsp2/fsp_dram.c b/arch/x86/lib/fsp2/fsp_dram.c
index 4c4c8334bdb..75fa8f9de7a 100644
--- a/arch/x86/lib/fsp2/fsp_dram.c
+++ b/arch/x86/lib/fsp2/fsp_dram.c
@@ -59,7 +59,7 @@ int dram_init(void)
 #endif
 	} else {
 #if CONFIG_IS_ENABLED(HANDOFF)
-		struct spl_handoff *ho = handoff_get();
+		struct spl_handoff *ho = gd->spl_handoff;
 
 		if (!ho) {
 			log_debug("No SPL handoff found\n");
@@ -82,7 +82,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 		return gd->ram_size;
 
 #if CONFIG_IS_ENABLED(HANDOFF)
-	struct spl_handoff *ho = handoff_get();
+	struct spl_handoff *ho = gd->spl_handoff;
 
 	log_debug("usable_ram_top = %lx\n", ho->arch.usable_ram_top);
 
diff --git a/cmd/sb.c b/cmd/sb.c
index 9245052492e..79f3fb0aacd 100644
--- a/cmd/sb.c
+++ b/cmd/sb.c
@@ -15,10 +15,8 @@ static int do_sb_handoff(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
 #if CONFIG_IS_ENABLED(HANDOFF)
-	struct spl_handoff *handoff = handoff_get();
-
-	if (handoff)
-		printf("SPL handoff magic %lx\n", handoff->arch.magic);
+	if (gd->spl_handoff)
+		printf("SPL handoff magic %lx\n", gd->spl_handoff->arch.magic);
 	else
 		printf("SPL handoff info not received\n");
 
diff --git a/common/board_f.c b/common/board_f.c
index 98dc2591e1d..939697d13d8 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -305,6 +305,17 @@ static int setup_mon_len(void)
 	return 0;
 }
 
+static int setup_spl_handoff(void)
+{
+#if CONFIG_IS_ENABLED(HANDOFF)
+	gd->spl_handoff = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF,
+					sizeof(struct spl_handoff));
+	debug("Found SPL hand-off info %p\n", gd->spl_handoff);
+#endif
+
+	return 0;
+}
+
 __weak int arch_cpu_init(void)
 {
 	return 0;
@@ -880,6 +891,7 @@ static const init_fnc_t init_sequence_f[] = {
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
 	bloblist_maybe_init,
+	setup_spl_handoff,
 #if defined(CONFIG_CONSOLE_RECORD_INIT_F)
 	console_record_init,
 #endif
diff --git a/common/init/handoff.c b/common/init/handoff.c
index 86c020ee0b9..a7cd065fb38 100644
--- a/common/init/handoff.c
+++ b/common/init/handoff.c
@@ -5,7 +5,6 @@
  * Copyright 2018 Google, Inc
  */
 
-#include <bloblist.h>
 #include <handoff.h>
 #include <asm/global_data.h>
 
@@ -39,14 +38,3 @@ void handoff_load_dram_banks(struct spl_handoff *ho)
 		bd->bi_dram[i].size = ho->ram_bank[i].size;
 	}
 }
-
-struct spl_handoff *handoff_get(void)
-{
-	struct spl_handoff *handoff;
-
-	handoff = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF,
-				sizeof(struct spl_handoff));
-	debug("Found SPL hand-off info %p\n", handoff);
-
-	return handoff;
-}
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 155ea8d6353..6e87db18be0 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -8,7 +8,6 @@
 #include <dm.h>
 #include <dt-structs.h>
 #include <errno.h>
-#include <handoff.h>
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -1468,7 +1467,7 @@ static int rk3399_clk_probe(struct udevice *dev)
 	init_clocks = true;
 #elif CONFIG_IS_ENABLED(HANDOFF)
 	if (!(gd->flags & GD_FLG_RELOC)) {
-		if (!handoff_get())
+		if (!(gd->spl_handoff))
 			init_clocks = true;
 	}
 #endif
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 26277b93976..789adf2c3f9 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -400,6 +400,12 @@ struct global_data {
 	 */
 	struct bloblist_hdr *bloblist;
 #endif
+#if CONFIG_IS_ENABLED(HANDOFF)
+	/**
+	 * @spl_handoff: SPL hand-off information
+	 */
+	struct spl_handoff *spl_handoff;
+#endif
 #if defined(CONFIG_TRANSLATION_OFFSET)
 	/**
 	 * @translation_offset: optional translation offset
diff --git a/include/handoff.h b/include/handoff.h
index 0072ea832f8..c0ae7b19a75 100644
--- a/include/handoff.h
+++ b/include/handoff.h
@@ -31,13 +31,6 @@ void handoff_save_dram(struct spl_handoff *ho);
 void handoff_load_dram_size(struct spl_handoff *ho);
 void handoff_load_dram_banks(struct spl_handoff *ho);
 
-/**
- * handoff_get() - Get the SPL handoff information
- *
- * Return: Pointer to SPL handoff if received, else NULL
- */
-struct spl_handoff *handoff_get(void);
-
 /**
  * handoff_arch_save() - Save arch-specific info into the handoff area
  *
-- 
2.43.0

