Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D504C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B594F889F7;
	Wed, 24 Jul 2024 17:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JG1lyuVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E7E887F5; Wed, 24 Jul 2024 17:10:00 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E148896B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-396675b83afso30844705ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833796; x=1722438596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toONqZovdnEEiLIl5obomsGt+0/ob4Fr7jQdKkWmMww=;
 b=JG1lyuVk4C7Wu9hK+CjhgRx8/JpxjZkT7SvXQVhiUJZ9HtkcdbHQxmc2cuSnkfFl2c
 sVzjnLtK6YXZ+Y8ah/4TfTZyoOAX50XQRYKib4imhKjhgdXdqP1Ecy+nEu1F0EAezDNr
 sYKGqodPEHZih+TEmhj6AEJjCjfBOtx5NTFUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833796; x=1722438596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toONqZovdnEEiLIl5obomsGt+0/ob4Fr7jQdKkWmMww=;
 b=efVxOwvUPHERxAef5YwcldCzj/mUu09Piv6gApNluwH+l0oP9V+VDzuhULGwE/fRcG
 pLCsGjnDcrT/8uT8X4xRltn/fQ3WQZHasimHenPp1A40+1XYKKYYCCw6JNer6qLkUeb2
 ecUWQyT6aiB55yqTmR8/Gs70lXY+kAh8lJJJ/NUsn+lNeuXxS6ACft46R9zsxTBhyLt0
 Dz+gIlEO4oI8iVaU/I7tlaGMs4yL1e14wv0sJqphEanmojtTtt6jx322Lk/NVpXmFkin
 6RqOwFqeKqqIPKx50KFs1R9AfRbeSAUfzwMWYyaOUatgJ+2PMG3lidEiPGMrVQdL1mTH
 8MUA==
X-Gm-Message-State: AOJu0YxmNxzSgzacqFvO2496ro4OlfvyhHnE7SpoPFrHsmcb24Vp0Vff
 vy+rLXR5BGwZbIgig9Ku0vQBzI6l52Ed7e4V4NmiKVs1tYBlTpBJRJU17IPAV+DqsLq95fDKfAw
 =
X-Google-Smtp-Source: AGHT+IG11a/Zw7opDPwEAVHzXbazcM0z23/veEoFZaCmIq2LHlMS7IV+Laxnw/GAKfRV1Z6A3SeXIw==
X-Received: by 2002:a05:6e02:2184:b0:382:64d9:1cba with SMTP id
 e9e14a558f8ab-398ea29417amr157748745ab.19.1721833796391; 
 Wed, 24 Jul 2024 08:09:56 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 21/35] global_data: Drop spl_handoff
Date: Wed, 24 Jul 2024 09:09:08 -0600
Message-Id: <20240724150922.2343249-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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
index 1e698d31841..c99b573bc17 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -304,17 +304,6 @@ static int setup_mon_len(void)
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
@@ -876,7 +865,6 @@ static const init_fnc_t init_sequence_f[] = {
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
index a23925ba9b3..1331686066c 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -395,12 +395,6 @@ struct global_data {
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

