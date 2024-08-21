Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49B0C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C572D88E6E;
	Wed, 21 Aug 2024 18:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oEhPNzke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E42488E5E; Wed, 21 Aug 2024 18:19:59 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5C488E2F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-70940c9657dso3247554a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257196; x=1724861996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcR/5iKrFCBX//g8VkkTnn7McDIXjBFIYs+lfpROyyg=;
 b=oEhPNzke52a/SsTCAAfPzs5MxScvGtccheINt84wg5mnD65DkJo8EljhgS8Hbg+5K2
 6XcbXOMn8qXXu1DzcD0qg0D00IGbse84CDBqiKsW0oDAJPaghw0RidbHW+yDA1jbJPms
 PUG1BF7eogvYYcg9rIcRFXLtt3cUuYDwZ+vm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257196; x=1724861996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcR/5iKrFCBX//g8VkkTnn7McDIXjBFIYs+lfpROyyg=;
 b=gN7jzD1AhEeYlDXynZ40UlwL1KsbZrBeREspStMpQ33iyaUd8rYc1N5BJxTSm5Grfp
 l1TmkOXQ5PnsK2d0adtIX7OTLB9Bg2W5YMy/z1E3g9Q4mEV5LvRs83LxeBu0ZV2MoDlo
 JNnImb0lDUoQS+q/VLZcCPJjJdHkUU5gcrWzQwsP+hZqEWpBkmbNvEIFgNqYje/a2KbP
 WnG1b2Ci8ekJJAOwPl9AGZqjp1fgf48xc1aHg5lok8DywtuL+fVaZPJBksyY+B77ah+S
 f6uFSHgbixfp+cUSBQaMlxUxt9XWYPj05+EkWG59Yrcwt78BnE7grlqjWKLrU5H2Kdhn
 Sj1Q==
X-Gm-Message-State: AOJu0YzHnzUuy0ndn9LlAryI2uVc3tS54a88SwwpqM5YBCagp8gbBhm4
 kFAiDphnrW+QSX0p0ZUtcBbF9rHwLGF2DMIZl0Bq1KnzXU0b2gIlyn0TaQ3OCJvJ31hRmVkbwb4
 =
X-Google-Smtp-Source: AGHT+IGUOfAq9hma+OQfzNCeaeQuGXd8qKf0ZLJjoxkY7UZRMaCWT8oYrJK2roJ337Yf7WbSNauqFg==
X-Received: by 2002:a05:6830:6dc3:b0:709:35ae:e793 with SMTP id
 46e09a7af769-70df88916a7mr3821372a34.33.1724257195953; 
 Wed, 21 Aug 2024 09:19:55 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 22/35] global_data: Collect common fields at the top
Date: Wed, 21 Aug 2024 10:19:14 -0600
Message-Id: <20240821161927.695717-23-sjg@chromium.org>
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

Move all the fields which are always present to the top of the struct,
so we can potentially save some space by taking note of alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/asm-generic/global_data.h | 166 +++++++++++++++---------------
 1 file changed, 82 insertions(+), 84 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 16c4b4fe676..094e97449f6 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -71,48 +71,6 @@ struct global_data {
 	 * @mem_clk: memory clock rate in Hz
 	 */
 	unsigned long mem_clk;
-#if defined(CONFIG_POST)
-	/**
-	 * @post_log_word: active POST tests
-	 *
-	 * @post_log_word is a bit mask defining which POST tests are recorded
-	 * (see constants POST_*).
-	 */
-	unsigned long post_log_word;
-	/**
-	 * @post_log_res: POST results
-	 *
-	 * @post_log_res is a bit mask with the POST results. A bit with value 1
-	 * indicates successful execution.
-	 */
-	unsigned long post_log_res;
-	/**
-	 * @post_init_f_time: time in ms when post_init_f() started
-	 */
-	unsigned long post_init_f_time;
-#endif
-#ifdef CONFIG_BOARD_TYPES
-	/**
-	 * @board_type: board type
-	 *
-	 * If a U-Boot configuration supports multiple board types, the actual
-	 * board type may be stored in this field.
-	 */
-	unsigned long board_type;
-#endif
-#if CONFIG_IS_ENABLED(PRE_CONSOLE_BUFFER)
-	/**
-	 * @precon_buf_idx: pre-console buffer index
-	 *
-	 * @precon_buf_idx indicates the current position of the
-	 * buffer used to collect output before the console becomes
-	 * available. When negative, the pre-console buffer is
-	 * temporarily disabled (used when the pre-console buffer is
-	 * being written out, to prevent adding its contents to
-	 * itself).
-	 */
-	long precon_buf_idx;
-#endif
 	/**
 	 * @env_addr: address of environment structure
 	 *
@@ -177,7 +135,87 @@ struct global_data {
 	 * @new_gd: pointer to relocated global data
 	 */
 	struct global_data *new_gd;
-
+	/**
+	 * @fdt_blob: U-Boot's own device tree, NULL if none
+	 */
+	const void *fdt_blob;
+	/**
+	 * @fdt_src: Source of FDT
+	 */
+	enum fdt_source_t fdt_src;
+	/**
+	 * @jt: jump table
+	 *
+	 * The jump table contains pointers to exported functions. A pointer to
+	 * the jump table is passed to standalone applications.
+	 */
+	struct jt_funcs *jt;
+	/**
+	 * @env_buf: buffer for env_get() before reloc
+	 */
+	char env_buf[32];
+	/**
+	 * @cur_serial_dev: current serial device
+	 */
+	struct udevice *cur_serial_dev;
+	/**
+	 * @arch: architecture-specific data
+	 */
+	struct arch_global_data arch;
+	/**
+	 * @dmtag_list: List of DM tags
+	 */
+	struct list_head dmtag_list;
+	/**
+	 * @timebase_h: high 32 bits of timer
+	 */
+	unsigned int timebase_h;
+	/**
+	 * @timebase_l: low 32 bits of timer
+	 */
+	unsigned int timebase_l;
+#if defined(CONFIG_POST)
+	/**
+	 * @post_log_word: active POST tests
+	 *
+	 * @post_log_word is a bit mask defining which POST tests are recorded
+	 * (see constants POST_*).
+	 */
+	unsigned long post_log_word;
+	/**
+	 * @post_log_res: POST results
+	 *
+	 * @post_log_res is a bit mask with the POST results. A bit with value 1
+	 * indicates successful execution.
+	 */
+	unsigned long post_log_res;
+	/**
+	 * @post_init_f_time: time in ms when post_init_f() started
+	 */
+	unsigned long post_init_f_time;
+#endif
+#ifdef CONFIG_BOARD_TYPES
+	/**
+	 * @board_type: board type
+	 *
+	 * If a U-Boot configuration supports multiple board types, the actual
+	 * board type may be stored in this field.
+	 */
+	unsigned long board_type;
+#endif
+#if CONFIG_IS_ENABLED(PRE_CONSOLE_BUFFER)
+	/**
+	 * @precon_buf_idx: pre-console buffer index
+	 *
+	 * @precon_buf_idx indicates the current position of the
+	 * buffer used to collect output before the console becomes
+	 * available. When negative, the pre-console buffer is
+	 * temporarily disabled (used when the pre-console buffer is
+	 * being written out, to prevent adding its contents to
+	 * itself).
+	 */
+	long precon_buf_idx;
+#endif
 #ifdef CONFIG_DM
 	/**
 	 * @dm_root: root instance for Driver Model
@@ -222,38 +260,18 @@ struct global_data {
 	 */
 	struct udevice *timer;
 #endif
-	/**
-	 * @fdt_blob: U-Boot's own device tree, NULL if none
-	 */
-	const void *fdt_blob;
-	/**
-	 * @fdt_src: Source of FDT
-	 */
-	enum fdt_source_t fdt_src;
 #if CONFIG_IS_ENABLED(OF_LIVE)
 	/**
 	 * @of_root: root node of the live tree
 	 */
 	struct device_node *of_root;
 #endif
-
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT)
 	/**
 	 * @multi_dtb_fit: pointer to uncompressed multi-dtb FIT image
 	 */
 	const void *multi_dtb_fit;
 #endif
-	/**
-	 * @jt: jump table
-	 *
-	 * The jump table contains pointers to exported functions. A pointer to
-	 * the jump table is passed to standalone applications.
-	 */
-	struct jt_funcs *jt;
-	/**
-	 * @env_buf: buffer for env_get() before reloc
-	 */
-	char env_buf[32];
 #ifdef CONFIG_TRACE
 	/**
 	 * @trace_buff: trace buffer
@@ -269,18 +287,10 @@ struct global_data {
 	 */
 	int cur_i2c_bus;
 #endif
-	/**
-	 * @timebase_h: high 32 bits of timer
-	 */
-	unsigned int timebase_h;
-	/**
-	 * @timebase_l: low 32 bits of timer
-	 */
-	unsigned int timebase_l;
+#if CONFIG_IS_ENABLED(CMD_BDINFO_EXTRA)
 	/**
 	 * @malloc_start: start of malloc() region
 	 */
-#if CONFIG_IS_ENABLED(CMD_BDINFO_EXTRA)
 	unsigned long malloc_start;
 #endif
 #if CONFIG_IS_ENABLED(SYS_MALLOC_F)
@@ -297,14 +307,6 @@ struct global_data {
 	 */
 	unsigned long malloc_ptr;
 #endif
-	/**
-	 * @cur_serial_dev: current serial device
-	 */
-	struct udevice *cur_serial_dev;
-	/**
-	 * @arch: architecture-specific data
-	 */
-	struct arch_global_data arch;
 #ifdef CONFIG_CONSOLE_RECORD
 	/**
 	 * @console_out: output buffer for console recording
@@ -432,10 +434,6 @@ struct global_data {
 	 */
 	struct hlist_head cyclic_list;
 #endif
-	/**
-	 * @dmtag_list: List of DM tags
-	 */
-	struct list_head dmtag_list;
 #if CONFIG_IS_ENABLED(UPL)
 	/**
 	 * @upl: Universal Payload-handoff information
-- 
2.34.1

