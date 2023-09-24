Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4818FCE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5661C86BA4;
	Sun, 24 Sep 2023 21:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mGFGPMoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D860086B0C; Sun, 24 Sep 2023 21:26:10 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA6B86B3C
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so143587439f.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583559; x=1696188359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cR0fBGVVxu5evn3PnWlJipOeSZyyQdKYfAWKmIJe+Vk=;
 b=mGFGPMocNijbDcpysKVXX7DXWDEj7VWn3FKNRIUrmI/bB0BA2hSex/VVjuMl3P6UNr
 96MIXyhCljSYJBobVXbaDe+dMn8WVrh00EdDYR4E18GFC1M1eTgL0CpHmBkUr9upJdbP
 ZkvqnaBTTuxNPJDeQQftoIUKoDSLvs8v2oSkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583559; x=1696188359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cR0fBGVVxu5evn3PnWlJipOeSZyyQdKYfAWKmIJe+Vk=;
 b=tqXU51xbMw5NF3D+5ktzCVZ5rWMyAI3vd/CgAo+29mo2ijct8/cIEnyr2EFhDDp9oh
 PfyfjFoX9OS5ciNkhRhSXyopMJNVi426gbajBZwojk+fuvmjsPQDS74Gcca9TjjnmmL9
 Rc3gj1vZKKRhZcPt/oQ1mRdubmNf62zKs+Y0SiV13Uw73CHQzSr14V5/1iR5gJSQLp2c
 +uLrdYmHyBBWf4QijiHl8F4Zd4Vy42P0zV7bk0a9QiuNV8gAKgeYEgDsoaruh2zpRMNs
 aofjleo1whrPJv6h9BEDk6lxCYVPqBpbX7JpGZlBZ8dwhkYHodWftYbjo4dLUQZvOe9u
 uyuQ==
X-Gm-Message-State: AOJu0YxQhJXsEZkxKTYWtu78y5D2ior3g+3JQnrpxneFgj+8k4Yo4fZR
 HEbRzYU6aS13kRuoeP+Bows0SputxsTcGpjnTgw=
X-Google-Smtp-Source: AGHT+IFxE7CSORtzSGrKk5d7PLu31BJcGu9sDsg8YQa/wUJTHqhfbpj/MCiRI+zLEkNfsDKOsVuA7Q==
X-Received: by 2002:a05:6602:3819:b0:792:8c29:7b with SMTP id
 bb25-20020a056602381900b007928c29007bmr7163384iob.10.1695583559382; 
 Sun, 24 Sep 2023 12:25:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bo Gan <ganboing@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ovidiu Panait <ovpanait@gmail.com>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Troy Kisky <troykiskyboundary@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 11/38] spl: Use SYS_MALLOC_F instead of SYS_MALLOC_F_LEN
Date: Sun, 24 Sep 2023 13:24:56 -0600
Message-ID: <20230924192536.1812799-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

Use the new SPL/TPL/VPL_SYS_MALLOC_F symbols to determine whether the
malloc pool exists.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to use SYS_MALLOC_F instead of SYS_MALLOC_F_LEN

 Kconfig                                  |  9 ++++-----
 arch/arm/lib/bdinfo.c                    |  2 +-
 arch/mips/cpu/start.S                    |  4 ++--
 arch/mips/mach-mtmips/mt7621/spl/start.S |  4 ++--
 arch/powerpc/cpu/mpc83xx/start.S         |  2 +-
 arch/powerpc/cpu/mpc85xx/start.S         |  4 ++--
 arch/sandbox/cpu/start.c                 |  2 +-
 arch/sh/lib/start.S                      |  4 ++--
 common/Makefile                          |  6 +-----
 common/board_f.c                         |  2 +-
 common/board_r.c                         |  2 +-
 common/dlmalloc.c                        | 12 ++++++------
 common/init/board_init.c                 |  4 ++--
 common/spl/spl.c                         |  6 +++---
 include/asm-generic/global_data.h        |  2 +-
 lib/asm-offsets.c                        |  2 +-
 16 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/Kconfig b/Kconfig
index 690ccdb93c4e..57afe597b0c8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -307,8 +307,7 @@ config SPL_SYS_MALLOC_F
 
 config SPL_SYS_MALLOC_F_LEN
 	hex "Size of malloc() pool in SPL"
-	depends on SYS_MALLOC_F && SPL
-	default 0x0 if !SPL_FRAMEWORK
+	depends on SPL_SYS_MALLOC_F
 	default 0x2800 if RCAR_GEN3
 	default 0x2000 if IMX8MQ
 	default SYS_MALLOC_F_LEN
@@ -332,7 +331,7 @@ config TPL_SYS_MALLOC_F
 
 config TPL_SYS_MALLOC_F_LEN
 	hex "Size of malloc() pool in TPL"
-	depends on SYS_MALLOC_F && TPL
+	depends on TPL_SYS_MALLOC_F
 	default SPL_SYS_MALLOC_F_LEN
 	help
 	  Sets the size of the malloc() pool in TPL. This is used for
@@ -366,8 +365,8 @@ config VPL_SYS_MALLOC_F
 
 config VPL_SYS_MALLOC_F_LEN
 	hex "Size of malloc() pool in VPL before relocation"
-	depends on SYS_MALLOC_F && VPL
-	default SYS_MALLOC_F_LEN
+	depends on VPL_SYS_MALLOC_F
+	default SPL_SYS_MALLOC_F_LEN
 	help
 	  Sets the size of the malloc() pool in VPL. This is used for
 	  driver model and other features, which must allocate memory for
diff --git a/arch/arm/lib/bdinfo.c b/arch/arm/lib/bdinfo.c
index 5e6eaad968d6..b88b01eefdcd 100644
--- a/arch/arm/lib/bdinfo.c
+++ b/arch/arm/lib/bdinfo.c
@@ -57,7 +57,7 @@ void arch_print_bdinfo(void)
 #ifdef CONFIG_BOARD_TYPES
 	printf("Board Type  = %ld\n", gd->board_type);
 #endif
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	printf("Early malloc usage: %lx / %x\n", gd->malloc_ptr,
 	       CONFIG_VAL(SYS_MALLOC_F_LEN));
 #endif
diff --git a/arch/mips/cpu/start.S b/arch/mips/cpu/start.S
index 2acc21d5871c..a95c95bc7832 100644
--- a/arch/mips/cpu/start.S
+++ b/arch/mips/cpu/start.S
@@ -46,7 +46,7 @@
 		sp, sp, GD_SIZE		# reserve space for gd
 	and	sp, sp, t0		# force 16 byte alignment
 	move	k0, sp			# save gd pointer
-#if CONFIG_VAL(SYS_MALLOC_F_LEN) && \
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && \
     !CONFIG_IS_ENABLED(INIT_STACK_WITHOUT_MALLOC_F)
 	li	t2, CONFIG_VAL(SYS_MALLOC_F_LEN)
 	PTR_SUBU \
@@ -63,7 +63,7 @@
 	blt	t0, t1, 1b
 	 nop
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN) && \
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && \
     !CONFIG_IS_ENABLED(INIT_STACK_WITHOUT_MALLOC_F)
 	PTR_S	sp, GD_MALLOC_BASE(k0)	# gd->malloc_base offset
 #endif
diff --git a/arch/mips/mach-mtmips/mt7621/spl/start.S b/arch/mips/mach-mtmips/mt7621/spl/start.S
index d2f9c031cbae..d56e624f3131 100644
--- a/arch/mips/mach-mtmips/mt7621/spl/start.S
+++ b/arch/mips/mach-mtmips/mt7621/spl/start.S
@@ -37,7 +37,7 @@
 		sp, sp, GD_SIZE		# reserve space for gd
 	and	sp, sp, t0		# force 16 byte alignment
 	move	k0, sp			# save gd pointer
-#if CONFIG_VAL(SYS_MALLOC_F_LEN) && \
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && \
     !CONFIG_IS_ENABLED(INIT_STACK_WITHOUT_MALLOC_F)
 	li	t2, CONFIG_VAL(SYS_MALLOC_F_LEN)
 	PTR_SUBU \
@@ -54,7 +54,7 @@
 	blt	t0, t1, 1b
 	 nop
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN) && \
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && \
     !CONFIG_IS_ENABLED(INIT_STACK_WITHOUT_MALLOC_F)
 	PTR_S	sp, GD_MALLOC_BASE(k0)	# gd->malloc_base offset
 #endif
diff --git a/arch/powerpc/cpu/mpc83xx/start.S b/arch/powerpc/cpu/mpc83xx/start.S
index 6749263da8a2..d72d3147f63d 100644
--- a/arch/powerpc/cpu/mpc83xx/start.S
+++ b/arch/powerpc/cpu/mpc83xx/start.S
@@ -244,7 +244,7 @@ in_flash:
 	cmplw	r3, r4
 	bne	1b
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 
 #if CONFIG_VAL(SYS_MALLOC_F_LEN) + GENERATED_GBL_DATA_SIZE > CFG_SYS_INIT_RAM_SIZE
 #error "SYS_MALLOC_F_LEN too large to fit into initial RAM."
diff --git a/arch/powerpc/cpu/mpc85xx/start.S b/arch/powerpc/cpu/mpc85xx/start.S
index 562b6993b9da..e9c304277347 100644
--- a/arch/powerpc/cpu/mpc85xx/start.S
+++ b/arch/powerpc/cpu/mpc85xx/start.S
@@ -1233,7 +1233,7 @@ _start_cont:
 	lis	r3,(CFG_SYS_INIT_RAM_ADDR)@h
 	ori	r3,r3,((CFG_SYS_INIT_SP_OFFSET-16)&~0xf)@l /* Align to 16 */
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 #if CONFIG_VAL(SYS_MALLOC_F_LEN) + GENERATED_GBL_DATA_SIZE > CFG_SYS_INIT_RAM_SIZE
 #error "SYS_MALLOC_F_LEN too large to fit into initial RAM."
 #endif
@@ -1253,7 +1253,7 @@ _start_cont:
 	cmplw	r4,r3
 	bne	1b
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	lis	r4,SYS_INIT_SP_ADDR@h
 	ori	r4,r4,SYS_INIT_SP_ADDR@l
 
diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 1026898727f5..bbd9e77afed9 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -529,7 +529,7 @@ int sandbox_main(int argc, char *argv[])
 			goto err;
 	}
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	gd->malloc_base = CFG_MALLOC_F_ADDR;
 #endif
 #if CONFIG_IS_ENABLED(LOG)
diff --git a/arch/sh/lib/start.S b/arch/sh/lib/start.S
index ddb9aa9f87b1..f0e1c805b01f 100644
--- a/arch/sh/lib/start.S
+++ b/arch/sh/lib/start.S
@@ -53,7 +53,7 @@ _start:
 
 	mov.l	._gd_init, r13		/* global data */
 	mov.l	._stack_init, r15	/* stack */
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	mov.l	._gd_malloc_base, r14
 	mov.l	r15, @r14
 #endif
@@ -73,7 +73,7 @@ loop:
 ._bss_start:		.long	bss_start
 ._bss_end:		.long	bss_end
 ._gd_init:		.long	(_start - GENERATED_GBL_DATA_SIZE)
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 ._gd_malloc_base:	.long	(_start - GENERATED_GBL_DATA_SIZE + GD_MALLOC_BASE)
 #endif
 ._stack_init:		.long	(_start - GENERATED_GBL_DATA_SIZE - CONFIG_SYS_MALLOC_LEN - 16)
diff --git a/common/Makefile b/common/Makefile
index 5c1617206f07..cdeadf72026c 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -74,11 +74,7 @@ endif # CONFIG_SPL_BUILD
 
 obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
-ifdef CONFIG_SYS_MALLOC_F
-ifneq ($(CONFIG_$(SPL_TPL_)SYS_MALLOC_F_LEN),0x0)
-obj-y += malloc_simple.o
-endif
-endif
+obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
 
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
diff --git a/common/board_f.c b/common/board_f.c
index aef395b1354e..99c2a43c1961 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -794,7 +794,7 @@ static int initf_bootstage(void)
 
 static int initf_dm(void)
 {
-#if defined(CONFIG_DM) && CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if defined(CONFIG_DM) && CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	int ret;
 
 	bootstage_start(BOOTSTAGE_ID_ACCUM_DM_F, "dm_f");
diff --git a/common/board_r.c b/common/board_r.c
index e30963339cfe..52786901be55 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -191,7 +191,7 @@ static int initr_malloc(void)
 {
 	ulong start;
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	debug("Pre-reloc malloc() used %#lx bytes (%ld KB)\n", gd->malloc_ptr,
 	      gd->malloc_ptr / 1024);
 #endif
diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index ebf0f27e1657..c2f5a7347b89 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -1291,7 +1291,7 @@ Void_t* mALLOc(bytes) size_t bytes;
 
   INTERNAL_SIZE_T nb;
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT))
 		return malloc_simple(bytes);
 #endif
@@ -1572,7 +1572,7 @@ void fREe(mem) Void_t* mem;
   mchunkptr fwd;       /* misc temp for linking */
   int       islr;      /* track whether merging with last_remainder */
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	/* free() is a no-op - all the memory will be freed on relocation */
 	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
 		VALGRIND_FREELIKE_BLOCK(mem, SIZE_SZ);
@@ -1735,7 +1735,7 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
   /* realloc of null is supposed to be same as malloc */
   if (oldmem == NULL) return mALLOc(bytes);
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
 		/* This is harder to support and should not be needed */
 		panic("pre-reloc realloc() is not supported");
@@ -1957,7 +1957,7 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
 
   if ((long)bytes < 0) return NULL;
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
 		return memalign_simple(alignment, bytes);
 	}
@@ -2153,7 +2153,7 @@ Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
     return NULL;
   else
   {
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
 		memset(mem, 0, sz);
 		return mem;
@@ -2455,7 +2455,7 @@ int mALLOPt(param_number, value) int param_number; int value;
 
 int initf_malloc(void)
 {
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	assert(gd->malloc_base);	/* Set up by crt0.S */
 	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
 	gd->malloc_ptr = 0;
diff --git a/common/init/board_init.c b/common/init/board_init.c
index ab8c508ad83c..ed2365daa35e 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -79,7 +79,7 @@ ulong board_init_f_alloc_reserve(ulong top)
 {
 	/* Reserve early malloc arena */
 #ifndef CFG_MALLOC_F_ADDR
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	top -= CONFIG_VAL(SYS_MALLOC_F_LEN);
 #endif
 #endif
@@ -159,7 +159,7 @@ void board_init_f_init_reserve(ulong base)
 	 * Use gd as it is now properly set for all architectures.
 	 */
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	/* go down one 'early malloc arena' */
 	gd->malloc_base = base;
 #if CONFIG_IS_ENABLED(ZERO_MEM_BEFORE_USE)
diff --git a/common/spl/spl.c b/common/spl/spl.c
index e270edb7aade..8967a140041b 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -527,7 +527,7 @@ static int spl_common_init(bool setup_malloc)
 {
 	int ret;
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (setup_malloc) {
 #ifdef CFG_MALLOC_F_ADDR
 		gd->malloc_base = CFG_MALLOC_F_ADDR;
@@ -864,7 +864,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
-#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
 	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
 	      gd->malloc_ptr / 1024);
 #endif
@@ -965,7 +965,7 @@ ulong spl_relocate_stack_gd(void)
 	if (CONFIG_IS_ENABLED(SYS_REPORT_STACK_F_USAGE))
 		spl_relocate_stack_check();
 
-#if defined(CONFIG_SPL_SYS_MALLOC_SIMPLE) && CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if defined(CONFIG_SPL_SYS_MALLOC_SIMPLE) && CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN) {
 		debug("SPL malloc() before relocation used 0x%lx bytes (%ld KB)\n",
 		      gd->malloc_ptr, gd->malloc_ptr / 1024);
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index c6d63b3657c3..f8fc87f1e46e 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -307,7 +307,7 @@ struct global_data {
 #if CONFIG_IS_ENABLED(CMD_BDINFO_EXTRA)
 	unsigned long malloc_start;
 #endif
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	/**
 	 * @malloc_base: base address of early malloc()
 	 */
diff --git a/lib/asm-offsets.c b/lib/asm-offsets.c
index 0808cd4b0c11..216d9716d0d6 100644
--- a/lib/asm-offsets.c
+++ b/lib/asm-offsets.c
@@ -32,7 +32,7 @@ int main(void)
 
 	DEFINE(GD_FLAGS, offsetof(struct global_data, flags));
 
-#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	DEFINE(GD_MALLOC_BASE, offsetof(struct global_data, malloc_base));
 #endif
 
-- 
2.42.0.515.g380fc7ccd1-goog

