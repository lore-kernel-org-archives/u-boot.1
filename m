Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54374C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2EE88A99;
	Fri, 23 Aug 2024 22:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j8iPTmf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2114E88AAA; Fri, 23 Aug 2024 22:27:44 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDECB88580
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39d20c4be31so8316305ab.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724444860; x=1725049660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFxwDa9ZcvwcCul0GZ/CNCbV1uK3WJy68XxYXq0aPbc=;
 b=j8iPTmf+Ck/ghrfOpDmNu2JX1SE+sNuQ5pLuAFz/9FMPp21Em+Ga9bo+AM6RsXcdr7
 zGdMGwgQpphaJx/ETn79OEKE/vlkD+SGQGbf2dI8uhCcJaaPhB/3NBGlDplhJIpn3hvI
 h7++leLxo5SbdzaWHPCgWRk/i03DpVMdORjcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724444860; x=1725049660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFxwDa9ZcvwcCul0GZ/CNCbV1uK3WJy68XxYXq0aPbc=;
 b=gBzY4TK90m3YIsycXPaAWILm271V1ie0d77qiV4MHgyIctD+jObuZufnem3EnkckTL
 itc0l0wIQgRM15gMUSL5daUwSwp/Kku0I7Lfi1kyo2YMedZx7twhODVWWqvrtSiOkHi9
 8V7xmCasZ36deC8L3QzAMeLwAFGbmjbJndr+Gfbou7T6gQh09RAQPJwCTEIAs34KqtX0
 FptkRa7PSa82dN3Svc5idpIU0tJZ2kjmr8O+SB9OTMKucPZjRHRJvCgcbLU68Y8ElTXV
 NeUxXPdavdZNJHRF3x3X1kbILNfnHDihSbUV1e7Xl0tKfWvoayu5TGI//I7FMI/gRNyd
 ZYsg==
X-Gm-Message-State: AOJu0Yx4Uagxdk0JYJwAl6oTbafXINkRM6sGuX3pqiZv7zF51Um0sEmV
 FvMW3ZQNmZPc6+LtTjJjlQDGT3CdwWbi78RpC2jTWwhCxJM4gxCfyClX2cLGyURd0xsAxghokko
 =
X-Google-Smtp-Source: AGHT+IEzPbtlOC8RCSoVHq71ZLCAlXYMUEWJdNcOmhp4klDpnMI1FQHRGAJujWuubpvEE7zO1JoKqQ==
X-Received: by 2002:a05:6e02:1c85:b0:37a:a9f0:f263 with SMTP id
 e9e14a558f8ab-39e3c9c0732mr38849345ab.20.1724444860559; 
 Fri, 23 Aug 2024 13:27:40 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7480bsm15401635ab.30.2024.08.23.13.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:27:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 26/35] global_data: Reduce size of early-malloc vars
Date: Fri, 23 Aug 2024 14:27:04 -0600
Message-Id: <20240823202713.430219-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823202713.430219-1-sjg@chromium.org>
References: <20240823202713.430219-1-sjg@chromium.org>
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
comments for clarity while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Keep new_ptr as a ulong to avoid overflow
- Update the comment for malloc_ptr

 arch/arm/lib/bdinfo.c             | 2 +-
 common/board_r.c                  | 2 +-
 common/malloc_simple.c            | 4 ++--
 common/spl/spl.c                  | 4 ++--
 include/asm-generic/global_data.h | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

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
index 4e6d7952b3c..5a8ec538f8f 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -23,7 +23,7 @@ static void *alloc_simple(size_t bytes, int align)
 
 	addr = ALIGN(gd->malloc_base + gd->malloc_ptr, align);
 	new_ptr = addr + bytes - gd->malloc_base;
-	log_debug("size=%lx, ptr=%lx, limit=%lx: ", (ulong)bytes, new_ptr,
+	log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
 		  gd->malloc_limit);
 	if (new_ptr > gd->malloc_limit) {
 		log_err("alloc space exhausted\n");
@@ -87,6 +87,6 @@ void free_simple(void *ptr)
 
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
index 253dd21d880..b09d4bc7d02 100644
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
-	 * @malloc_ptr: current address of early malloc()
+	 * @malloc_ptr: currently used bytes of early malloc()
 	 */
-	unsigned long malloc_ptr;
+	unsigned int malloc_ptr;
 #endif
 #ifdef CONFIG_CONSOLE_RECORD
 	/**
-- 
2.34.1

