Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA60C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD5588A10;
	Wed, 24 Jul 2024 17:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dw1Vm+Bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33443889FA; Wed, 24 Jul 2024 17:10:04 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2AB889D6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-36da84df7adso3415755ab.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833800; x=1722438600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/uQnfmlmRri+pjd3N8lWv0313ISoX6hn8X7ztqI560=;
 b=Dw1Vm+BnYOtdtTvOKBhAuAczOhC82fB6jaQEacknwysPURTrHlxFsvd22ZtRhaAPME
 uyqhqdY7Ki002V/aPZ8o9L/VXXchJyTNpp2Pz8e5V+O4Lay+R4P6ZKaLUBNtvHKR1XXB
 8mY3fzgpnnEb4p2R4I2cmCm6c1aY1yFoKG3Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833800; x=1722438600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/uQnfmlmRri+pjd3N8lWv0313ISoX6hn8X7ztqI560=;
 b=A3AFIzB1ViODUjYctJSAMCahulXIGE8/yOcrVQAUbKQgAz6Ifgq5d5oOrOXj1IovXU
 D753VeopyRYpYW5hCmM/A0G6zXl2Wh8dzH9dpEF1TUQEDXXghkbd803izC+I1+/tzn1+
 dtNU6nzq/xWuUonPAUhL8kcTIHkG/xvdPcogGXefbmmU2fYUerz/P6RBKyigQF/NtMFo
 O8exTVDt9C0OLD3d9kjPrC3hIqg7MFT6N9Nweq99U1ikva83lpXxrALDVTPVnncAG3lt
 xvkXoWz6xZfQKfNeVjJmC8NmfF14vZa5V6X4J33R2TZaZUTnYkONpOwqU6J/qkQac03s
 cAzQ==
X-Gm-Message-State: AOJu0YzXpSpGsVSR+wWaPEsXsAxqkbcC2MhNCHXuDgqCg70n4ixEKaPL
 NsD78LxhCfELBCVUZhjexkmycH6TWtjfT+DtQe43H9taOnqeiFOIrd6UOwu92X+UlB221tcqXik
 =
X-Google-Smtp-Source: AGHT+IFmB/eXNQAFbBiwE/ePSQr6pOl1/VbNZkqSk+C/IDO1V98cIiOTdVb65rY+t/Nr9XWfetZluw==
X-Received: by 2002:a92:c569:0:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-39a1a775175mr14014465ab.1.1721833800357; 
 Wed, 24 Jul 2024 08:10:00 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Artur Rojek <artur@conclusive.pl>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 26/35] global_data: Reduce size of early-malloc vars
Date: Wed, 24 Jul 2024 09:09:13 -0600
Message-Id: <20240724150922.2343249-27-sjg@chromium.org>
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

The early malloc region is normally quite small and is certainly less
than 4GB, so use a 32-bit value for the limit and pointer. Update the
comment for clarity while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index d4ba245ac69..460b012306e 100644
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
index de34fb06548..5c966a88b8e 100644
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
@@ -895,7 +895,7 @@ ulong spl_relocate_stack_gd(void)
 
 #if defined(CONFIG_SPL_SYS_MALLOC_SIMPLE) && CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	if (CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN) {
-		debug("SPL malloc() before relocation used 0x%lx bytes (%ld KB)\n",
+		debug("SPL malloc() before relocation used 0x%x bytes (%d KB)\n",
 		      gd->malloc_ptr, gd->malloc_ptr / 1024);
 		ptr -= CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN;
 		gd->malloc_base = ptr;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 6ec80a2ccdf..21d4ddea12d 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -298,13 +298,13 @@ struct global_data {
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

