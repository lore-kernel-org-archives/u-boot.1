Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2079C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F73D88E80;
	Wed, 21 Aug 2024 18:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hSv/W2jC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E85F088E41; Wed, 21 Aug 2024 18:20:03 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0974488E48
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7095bfd6346so4121819a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257199; x=1724861999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MG9H2vzu6Pv/pzojZG1JUbKZEjdJC7PHQyLvp3SiEs0=;
 b=hSv/W2jCNnAs3kn/Up22cD3CdzLLGYVU+AiMn/emc2BwxvES06ZwbDe4i2NHtKWgGJ
 5d/uBMU6iGBrNqpM7M5JQxP5IWGIvxdF6hPOv0/2thNCiWT8k3e3kbWcpgMYpSsia8EV
 Hgtjcl+GN5SeZ+bSL+HlnbYi7ycbhLrofT/7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257199; x=1724861999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MG9H2vzu6Pv/pzojZG1JUbKZEjdJC7PHQyLvp3SiEs0=;
 b=vcT8XpBK6XkAzWR8AFOqv2sMwiD9QdRgV7SyEhRCLSmuFBPI4ZvVMvCqCajaDT3YBb
 qCXBoP51XApl52+0/6yd7e0JoCgwvNsva0+efqXALAJNNarbFYojSfdmESN4wWv6PAjf
 zUhtS7Ue7fveQxcbMlRRwhYxH0cq7zB6WyM/1zxaY3EdF3JBOngSp8teOlokJHCC4FHA
 QrBD2RICIUuWBTJ1ZjKIE1lyEzvyoq3kAhxCJ6Yr44uMhKKnOzQKlV3919g+7rQ0p+5a
 f4jbYubl/VA1LmXmP6LqgmeE/QkX1nFgrmDlcP6TiNj/1P4oCtSON85On9AOl6LZtzdi
 hj8A==
X-Gm-Message-State: AOJu0YxYKPIR3A4AFoa+XdPUKVwe5NH+3Rjnu2N44q4JMJTaLHp7arjA
 EAhwsIcaWf3UV6F6NJePUYsJ10Z/iCZvyWzqf7Wu1JXXn0QuhFzja1SRvC/53sEmE0VN7Ru94Gg
 =
X-Google-Smtp-Source: AGHT+IHXQyC3vXe1F6FRlBDevAbWdErjIOYoGcVyxbcYGgLJwkJxw403YpLmTzms/jsCiOF46reL7g==
X-Received: by 2002:a05:6830:211b:b0:709:4ef3:244 with SMTP id
 46e09a7af769-70df8890822mr3173581a34.30.1724257199505; 
 Wed, 21 Aug 2024 09:19:59 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 26/35] global_data: Reduce size of early-malloc vars
Date: Wed, 21 Aug 2024 10:19:18 -0600
Message-Id: <20240821161927.695717-27-sjg@chromium.org>
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

The early malloc region is normally quite small and is certainly less
than 4GB, so use a 32-bit value for the limit and pointer. Update the
comment for clarity while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/bdinfo.c             | 2 +-
 common/board_r.c                  | 2 +-
 common/malloc_simple.c            | 7 ++++---
 common/spl/spl.c                  | 4 ++--
 include/asm-generic/global_data.h | 6 +++---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/lib/bdinfo.c b/arch/arm/lib/bdinfo.c
index 7c49462c8eb..c7fff01c435 100644
--- a/arch/arm/lib/bdinfo.c
+++ b/arch/arm/lib/bdinfo.c
@@ -58,7 +58,7 @@ void arch_print_bdinfo(void)
 	printf("Board Type  = %ld\n", gd->board_type);
 #endif
 #if CONFIG_IS_ENABLED(SYS_MALLOC_F)
-	printf("Early malloc usage: %lx / %x\n", gd->malloc_ptr,
+	printf("Early malloc usage: %x / %x\n", gd->malloc_ptr,
 	       CONFIG_VAL(SYS_MALLOC_F_LEN));
 #endif
 }
diff --git a/common/board_r.c b/common/board_r.c
index f445803d7a4..e88b7ea4d8a 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -192,7 +192,7 @@ static int initr_malloc(void)
 	ulong start;
 
 #if CONFIG_IS_ENABLED(SYS_MALLOC_F)
-	debug("Pre-reloc malloc() used %#lx bytes (%ld KB)\n", gd->malloc_ptr,
+	debug("Pre-reloc malloc() used %#x bytes (%d KB)\n", gd->malloc_ptr,
 	      gd->malloc_ptr / 1024);
 #endif
 	/* The malloc area is immediately below the monitor copy in DRAM */
diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 4e6d7952b3c..c24e70c95c2 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -18,12 +18,13 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static void *alloc_simple(size_t bytes, int align)
 {
-	ulong addr, new_ptr;
+	ulong addr;
+	uint new_ptr;
 	void *ptr;
 
 	addr = ALIGN(gd->malloc_base + gd->malloc_ptr, align);
 	new_ptr = addr + bytes - gd->malloc_base;
-	log_debug("size=%lx, ptr=%lx, limit=%lx: ", (ulong)bytes, new_ptr,
+	log_debug("size=%lx, ptr=%x, limit=%x: ", (ulong)bytes, new_ptr,
 		  gd->malloc_limit);
 	if (new_ptr > gd->malloc_limit) {
 		log_err("alloc space exhausted\n");
@@ -87,6 +88,6 @@ void free_simple(void *ptr)
 
 void malloc_simple_info(void)
 {
-	log_info("malloc_simple: %lx bytes used, %lx remain\n", gd->malloc_ptr,
+	log_info("malloc_simple: %x bytes used, %x remain\n", gd->malloc_ptr,
 		 CONFIG_VAL(SYS_MALLOC_F_LEN) - gd->malloc_ptr);
 }
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 651b434f615..459161910e6 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -784,7 +784,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 	if (CONFIG_IS_ENABLED(SYS_MALLOC_F) &&
 	    !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
-		debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
+		debug("SPL malloc() used 0x%x bytes (%d KB)\n",
 		      gd_malloc_ptr(), gd_malloc_ptr() / 1024);
 
 	bootstage_mark_name(get_bootstage_id(false), "end phase");
@@ -903,7 +903,7 @@ ulong spl_relocate_stack_gd(void)
 
 #if defined(CONFIG_SPL_SYS_MALLOC_SIMPLE) && CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN) {
-		debug("SPL malloc() before relocation used 0x%lx bytes (%ld KB)\n",
+		debug("SPL malloc() before relocation used 0x%x bytes (%d KB)\n",
 		      gd->malloc_ptr, gd->malloc_ptr / 1024);
 		ptr -= CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN;
 		gd->malloc_base = ptr;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 253dd21d880..c5f07709118 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -299,13 +299,13 @@ struct global_data {
 	 */
 	unsigned long malloc_base;
 	/**
-	 * @malloc_limit: limit address of early malloc()
+	 * @malloc_limit: maximum size of early malloc()
 	 */
-	unsigned long malloc_limit;
+	unsigned int malloc_limit;
 	/**
 	 * @malloc_ptr: current address of early malloc()
 	 */
-	unsigned long malloc_ptr;
+	unsigned int malloc_ptr;
 #endif
 #ifdef CONFIG_CONSOLE_RECORD
 	/**
-- 
2.34.1

