Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1587CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B8488FFC;
	Wed,  9 Oct 2024 03:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J6qbY8de";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E0288FED; Wed,  9 Oct 2024 03:50:34 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ABD388FE8
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a0be4d803eso18338545ab.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438631; x=1729043431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KTSVBtL/3dolKT8qng2VPYKUHr0yGyrmDrTfIYe4H8=;
 b=J6qbY8deKWT5chjSh9V4Rn0mPOxeDvJwyTOPPKDIILVuzHVm2IRJ3CAaBn+mH+VfcQ
 oBjm+6arHRc2bdaIgGjeh+4p/ypNpLe21h9Y4JltfjldF9n3P6OcE96qAhKALT45GAmW
 c3UnuBm5afN9m62Ch3JeToLBUKdIa3Rr5o2IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438631; x=1729043431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KTSVBtL/3dolKT8qng2VPYKUHr0yGyrmDrTfIYe4H8=;
 b=JCaQ2mzG83CNpD7DQZHivUjRz3sY6cxnUCUoysxilAe/uBQJAkX+owl225QWF+BRpS
 gJ/C7UKWGAFMYWbl6BTSN0pBQ64LZ05KR6I817XXppEVZF2kZ6wcNeNd6Quv15/xpN5f
 FuuA7Ufhw2f8EycEz2AXEXkmhtnbk3uOXAgoU+yhHwNSbF0q45OagbuaGBbYdqfdLxbH
 LstWH4B40iYowKIgy/5SYkt93D7s3yo+FT4Tioem0hbDnhSNXD+A+2ECkr2zLNEHCUiw
 5yDYVAzUot+YlH+/to0bCWg4PZ7kj5eirNc3Jlz+p2J5gDhaD5L6djy1BHcbzpfmk8hS
 H9AQ==
X-Gm-Message-State: AOJu0Yyt1S5b/Kqxx+2+F/b5kIkVvQz+iYvmFp5ZZYSb85mEEtaMvZAx
 Na4sCrEpJ1G54opQxsL+y1uVkrFBK66NcXKfjKowlXTVewX8MPt8TK98RtHQxx/9R9A6EmZ1gja
 qfQ==
X-Google-Smtp-Source: AGHT+IGlVgTnNpMnlRIrTEos6zSxejhmlOCx4yYPA0dFQyRp6YuhGioJDpjYUTrDX2AE1Gj1E0KApw==
X-Received: by 2002:a05:6e02:1d98:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a397cecd9fmr7306875ab.10.1728438630756; 
 Tue, 08 Oct 2024 18:50:30 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a868967sm20677585ab.67.2024.10.08.18.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 18:50:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Artur Rojek <artur@conclusive.pl>, Devarsh Thakkar <devarsht@ti.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 2/6] common: Tidy up how malloc() is inited
Date: Tue,  8 Oct 2024 19:50:14 -0600
Message-ID: <20241009015020.25817-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009015020.25817-1-sjg@chromium.org>
References: <20241009015020.25817-1-sjg@chromium.org>
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

The call to malloc() is a bit strange. The naming of the arguments
suggests that an address is passed, but in fact it is a pointer, at
least in the board_init_r() function and SPL equivalent.

Update it to work as described. Add a function comment as well.

Note that this does adjustment does not extend into the malloc()
implementation itself, apart from changing mem_malloc_init(), since
there are lots of casts and pointers and integers are used
interchangeably.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_r.c  | 3 +--
 common/dlmalloc.c | 8 +++++---
 common/spl/spl.c  | 4 +---
 include/malloc.h  | 8 ++++++++
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 4faaa202421..fbb10fea494 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -203,8 +203,7 @@ static int initr_malloc(void)
 	 */
 	start = gd->relocaddr - TOTAL_MALLOC_LEN;
 	gd_set_malloc_start(start);
-	mem_malloc_init((ulong)map_sysmem(start, TOTAL_MALLOC_LEN),
-			TOTAL_MALLOC_LEN);
+	mem_malloc_init(start, TOTAL_MALLOC_LEN);
 	return 0;
 }
 
diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 1ac7ce3f43c..cc4d3a0a028 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -16,6 +16,8 @@
 #include <asm/global_data.h>
 
 #include <malloc.h>
+#include <mapmem.h>
+#include <string.h>
 #include <asm/io.h>
 #include <valgrind/memcheck.h>
 
@@ -598,9 +600,9 @@ void *sbrk(ptrdiff_t increment)
 
 void mem_malloc_init(ulong start, ulong size)
 {
-	mem_malloc_start = start;
-	mem_malloc_end = start + size;
-	mem_malloc_brk = start;
+	mem_malloc_start = (ulong)map_sysmem(start, size);
+	mem_malloc_end = mem_malloc_start + size;
+	mem_malloc_brk = mem_malloc_start;
 
 #ifdef CONFIG_SYS_MALLOC_DEFAULT_TO_INIT
 	malloc_init();
diff --git a/common/spl/spl.c b/common/spl/spl.c
index c13b2b8f714..fc8b38862e8 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -679,9 +679,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	spl_set_bd();
 
 	if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
-		mem_malloc_init((ulong)map_sysmem(SPL_SYS_MALLOC_START,
-						  SPL_SYS_MALLOC_SIZE),
-				SPL_SYS_MALLOC_SIZE);
+		mem_malloc_init(SPL_SYS_MALLOC_START, SPL_SYS_MALLOC_SIZE);
 		gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 	}
 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
diff --git a/include/malloc.h b/include/malloc.h
index 07d3e90a855..9e0be482416 100644
--- a/include/malloc.h
+++ b/include/malloc.h
@@ -981,6 +981,14 @@ extern ulong mem_malloc_start;
 extern ulong mem_malloc_end;
 extern ulong mem_malloc_brk;
 
+/**
+ * mem_malloc_init() - Set up the malloc() pool
+ *
+ * Sets the region of memory to be used for all future calls to malloc(), etc.
+ *
+ * @start: Start address
+ * @size: Size in bytes
+ */
 void mem_malloc_init(ulong start, ulong size);
 
 #ifdef __cplusplus
-- 
2.43.0

