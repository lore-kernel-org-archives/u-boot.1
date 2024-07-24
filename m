Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F82C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 300C5889FC;
	Wed, 24 Jul 2024 17:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HHXctVY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AA28897D; Wed, 24 Jul 2024 17:10:00 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851FC889D6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-397ba4f7387so29037365ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833797; x=1722438597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxvAYhHBEAOug/ziwcv1FJDNAfJPWj7x2CKfDADCZqY=;
 b=HHXctVY+LxNrwLn2i1QaUsVtE3s01lHUdYfyn1MBEDQvgVSQB9ryoX0ymoUcJloUkZ
 dxT9jkqURfsm2sOlg5BV396YJ8N93AYiU7/bPlB+p92/soydm4OmMqoeXtUA9SZ3REaS
 OEQM8OgpyhLGEpLfD1cruZltbdetr+phnMgFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833797; x=1722438597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxvAYhHBEAOug/ziwcv1FJDNAfJPWj7x2CKfDADCZqY=;
 b=pVvyq389+vfrUpT/hVvFjwRdPkebgnlP1BhQ+PWS+un3HJ3+pm8nVitgw7z06tILNY
 3eO/Hsez4YPP35LBS+LqUOsXuiDnPRm3s7NgzcRQH5JSR/ierJMcKs6Vk3EcxjmZ8Ggt
 RgWptS1TkAU4F8XeyQyE7YzU0qbF1r0Ry/2hHVx8qqacuCuAYhjNmeJHKyr+iXZUxR9s
 gpZ9P6xuYejdQ2QAIxb97tedMcrFZp9qasky2dVH0yrbyAlhPZKgRwWyWdGmygdsYmfD
 oTznaaQgy2nQzzOtY55OuMT/pfFSwXTKjFJ5zOI5Gow4wR4RHcgIRovRHAPZmifOMUDP
 MVVA==
X-Gm-Message-State: AOJu0Yx+Rnyix9Z0EL24yaZCfMFrFeVOP4RL3DxKAZdOX9ieDd7WVRDn
 Kui4gvdBXg5UayJWyDFksEF/bNqkpUfQN/8dLrLCFKwTrM0ANCuhsqPRYjLI8Zzt9CqRaZRv/wU
 =
X-Google-Smtp-Source: AGHT+IHfqVQFZg2VdjakfEyP9yhwpT0KTpG59Rf4x2L8teApjUdDxVgvyvP4As6A4CdRPgLcLqVIsw==
X-Received: by 2002:a92:c544:0:b0:396:5af7:64e3 with SMTP id
 e9e14a558f8ab-39a19272634mr26724605ab.15.1721833797199; 
 Wed, 24 Jul 2024 08:09:57 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 22/35] global_data: Collect common fields at the top
Date: Wed, 24 Jul 2024 09:09:09 -0600
Message-Id: <20240724150922.2343249-23-sjg@chromium.org>
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

Move all the fields which are always present to the top of the struct,
so we can potentially save some space by taking note of alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 166 +++++++++++++++---------------
 1 file changed, 82 insertions(+), 84 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 1331686066c..48241d10034 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -70,48 +70,6 @@ struct global_data {
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
@@ -176,7 +134,87 @@ struct global_data {
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
@@ -221,38 +259,18 @@ struct global_data {
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
@@ -268,18 +286,10 @@ struct global_data {
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
@@ -296,14 +306,6 @@ struct global_data {
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
@@ -431,10 +433,6 @@ struct global_data {
 	 */
 	struct hlist_head cyclic_list;
 #endif
-	/**
-	 * @dmtag_list: List of DM tags
-	 */
-	struct list_head dmtag_list;
 };
 #ifndef DO_DEPS_ONLY
 static_assert(sizeof(struct global_data) == GD_SIZE);
-- 
2.34.1

