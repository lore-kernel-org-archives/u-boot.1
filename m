Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C09AC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFF4888AB;
	Tue, 30 Jul 2024 16:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bCRi5UqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E734888A4; Tue, 30 Jul 2024 16:40:47 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F5008882C
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8076cee8088so178992339f.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350444; x=1722955244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKB5rDCi7C3n5rB5RnCKEE6bX7aUHG3hMLysSpdaxZE=;
 b=bCRi5UqPVGAhs3nZhBH+m/BCwjqNnBMHgna5jAYx/6gs8nkijJedzkGe64tb1Uho5z
 601uIU3ROs6M8aU4j/BQXV1IvZWEOC4pBuCuXqcq3Wjw3KusOi2rE06ltMMYkoMbk+fl
 /Lwbw4rskyc+OybRFA/v2fqvHgcS2w87QOG5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350444; x=1722955244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKB5rDCi7C3n5rB5RnCKEE6bX7aUHG3hMLysSpdaxZE=;
 b=EIcjXiBXtu/iITV+2f6cwwvVdKTaT4TknoGREPfQMVMjQzsiyeDsyTPMxfWcHZSsKy
 evtuMMLs4sNBX+brAL9nJpHV7m3wVgBuYKPPHkkC8roBMso4gHF8mHygMuLj1qKFTtSD
 QQhwREMoFbBU3mPL3q4dTjIl0uBMVK7ZQFjmrLHqqaQqC2xcVC6tobT023n/lHuG6TvE
 LE1x0J09P63KoUzD/6HDt9tKU9Zg5fKRaBFeZXdB6OlWVf4DJTZAlyeR8iv5Fwd/mgRl
 tBdqNNOQXOG4awqZIFsdAFk6iOq1/p5fXV2Lncez3ApABKUo5iBEGC6ORkCTRemeN6tk
 ptsw==
X-Gm-Message-State: AOJu0Ywn6Ix59KXZy5Lt/ZfiAF0FA/LJOWpFixEQ7nAlyp+U609t+muq
 s46xuZqDmNow/GHZ+Ihtn9FD4GL8AmhAQ6qErK2EYkI/N9dyYq1e7hFIq900lI7HHyYZC5yl9k8
 =
X-Google-Smtp-Source: AGHT+IEwBTk6B1fkOReV+SHdmki/0fwaKzw8ZOHrb2zelul95X5GMefUtD0mF4r+OT6zMRMrY6P3yw==
X-Received: by 2002:a05:6602:6c07:b0:81f:9df7:40d with SMTP id
 ca18e2360f4ac-81f9df7076fmr1021187039f.17.1722350443785; 
 Tue, 30 Jul 2024 07:40:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa9338csm2714724173.39.2024.07.30.07.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:40:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
	Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 3/4] lmb: Split init into two functions
Date: Tue, 30 Jul 2024 08:40:34 -0600
Message-Id: <20240730144035.3992996-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730144035.3992996-1-sjg@chromium.org>
References: <20240730144035.3992996-1-sjg@chromium.org>
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

The normal case for initing lmb is to set up all the memory regions. Put
that in a separate function, called lmb_init(). The other function is
now only used for testing.

Note that tests never set up the memory regions, so we can drop that
code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_r.c |  4 +--
 include/lmb.h    | 13 +++++++
 lib/lmb.c        | 88 +++++++++++++++++++++++++-----------------------
 3 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index eaf9b40ec02..9ce1b8cdd2b 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -611,9 +611,7 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_CLOCKS
 	set_cpu_clk_info, /* Setup clock information */
 #endif
-#if CONFIG_IS_ENABLED(LMB)
-	initr_lmb,
-#endif
+	lmb_init,
 #ifdef CONFIG_EFI_LOADER
 	efi_memory_init,
 #endif
diff --git a/include/lmb.h b/include/lmb.h
index 19231439c34..a2236a419fd 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -96,6 +96,19 @@ void board_lmb_reserve(void);
 void arch_lmb_reserve(void);
 void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
 
+#if CONFIG_IS_ENABLED(LMB)
+/**
+ * lmb_init() - Initialise the LMB memory
+ *
+ * Initialise the LMB-subsystem-related data structures.
+ *
+ * Return: 0 if OK, -ve on failure.
+ */
+int lmb_init(void);
+#else
+static int lmb_init(void) { return 0; }
+#endif
+
 /**
  * lmb_mem_regions_init() - Initialise the LMB memory
  * @mem_lst: Pointer to store location of free memory list
diff --git a/lib/lmb.c b/lib/lmb.c
index 83b060a2f4d..34cbaeaafd5 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -718,6 +718,47 @@ __weak void arch_lmb_reserve(void)
 	arch_lmb_reserve_generic(rsv_start, gd->ram_top, 16384);
 }
 
+static int lmb_setup(struct lmb *lmb)
+{
+	int ret;
+
+	ret = alist_init(&lmb->free_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB free memory\n");
+		return -ENOMEM;
+	}
+
+	ret = alist_init(&lmb->used_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB used memory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int lmb_init(void)
+{
+	bool ret;
+
+	ret = lmb_setup(&lmb);
+	if (ret) {
+		log_debug("Unable to init LMB\n");
+		return ret;
+	}
+	lmb_add_memory();
+
+	/* Reserve the U-Boot image region once U-Boot has relocated */
+	if (spl_phase() == PHASE_SPL)
+		lmb_reserve_common_spl();
+	else if (spl_phase() == PHASE_BOARD_R)
+		lmb_reserve_common((void *)gd->fdt_blob);
+
+	return 0;
+}
+
 /**
  * lmb_mem_regions_init() - Initialise the LMB memory
  * @mem_lst: Pointer to store location of free memory list
@@ -740,18 +781,10 @@ int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
 {
 	bool ret;
 
-	ret = alist_init(&lmb.free_mem, sizeof(struct lmb_region),
-			 (uint)LMB_ALIST_INITIAL_SIZE);
-	if (!ret) {
-		log_debug("Unable to initialise the list for LMB free memory\n");
-		return -1;
-	}
-
-	ret = alist_init(&lmb.used_mem, sizeof(struct lmb_region),
-			 (uint)LMB_ALIST_INITIAL_SIZE);
-	if (!ret) {
-		log_debug("Unable to initialise the list for LMB used memory\n");
-		return -1;
+	ret = lmb_setup(&lmb);
+	if (ret) {
+		log_debug("Unable to init LMB\n");
+		return ret;
 	}
 
 	if (mem_lst)
@@ -760,17 +793,6 @@ int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
 	if (used_lst)
 		*used_lst = &lmb.used_mem;
 
-	if (!add_rsv_mem)
-		return 0;
-
-	lmb_add_memory();
-
-	/* Reserve the U-Boot image region once U-Boot has relocated */
-	if (spl_phase() == PHASE_SPL)
-		lmb_reserve_common_spl();
-	else if (spl_phase() == PHASE_BOARD_R)
-		lmb_reserve_common((void *)gd->fdt_blob);
-
 	return 0;
 }
 
@@ -790,26 +812,6 @@ void __maybe_unused lmb_mem_regions_uninit(struct alist *mem_lst,
 	alist_uninit(used_lst);
 }
 
-/**
- * initr_lmb() - Initialise the LMB lists
- *
- * Initialise the LMB lists needed for keeping the memory map. There
- * are two lists, in form of alloced list data structure. One for the
- * available memory, and one for the used memory.
- *
- * Return: 0 on success, -ve on error
- */
-int initr_lmb(void)
-{
-	int ret;
-
-	ret = lmb_mem_regions_init(NULL, NULL, true);
-	if (ret)
-		printf("Unable to initialise the LMB data structures\n");
-
-	return ret;
-}
-
 struct lmb *lmb_get(void)
 {
 	return &lmb;
-- 
2.34.1

