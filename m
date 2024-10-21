Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F3CD0E6C8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7DD8930D;
	Mon, 21 Oct 2024 10:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b5M035mM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF9928931A; Mon, 21 Oct 2024 10:19:42 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F1289304
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso8828553a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498780; x=1730103580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBfJRuvkoDR5n2ZgyL7GmPonOc9eTC/gncn1a1t8IiI=;
 b=b5M035mMqNBOFj0qvB5FCv8ut1EHEj/e/GZwvsiZ2yeyA+mp6UyqGtAP83IGhsSUuJ
 jwSJeoG6ZgkFgcDgvIZQisMJsgQo1K2shHQ8vWQ2/lLKYW3shvF630QO3cdP+Uklnonx
 aiUfPqJb5sqLPSZruVSfv4UKDfBmG3LV7Jt40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498780; x=1730103580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBfJRuvkoDR5n2ZgyL7GmPonOc9eTC/gncn1a1t8IiI=;
 b=vY5mSrvwAeKwLdU10QHRBk0g3X2zIKtnL7iqG+GtmMDsDLIwMmzsP1aC2sCCpJMbi/
 /QkOSJtSUGZ561/eGWRe1CufDtui3wWI5UpkrjW9IBDZyF0XOJ7hf1N4BaAvJ8LnXaYp
 UUTym2K2C4zpuX8Gf5O1nNGo+fvbjWpk3Z3uKZLxdeHMSPZCktixAG3JoLL4/PlxQ6YJ
 qbWjhav7pMCwfppKB9rbvD2J0OXPuWP8wqI2iIcf8bwKvLEnsCk+OTcMY8Gj8Ny1uf3x
 K41LeEvh6CZQ/kfgTLSJkCZO6uVpr18uXk0lCib56IIKt+XUvCrRcMSodeIVwVFgElBI
 9gFw==
X-Gm-Message-State: AOJu0YxUUPWEMEA0sKuz6awhqWFeCcSnQwkhBYLmMye40jhAVgEnJuqt
 R9EkLwR7edpKb9zWsPe1YoPeBWraqXkh0jWhzwwJJkTOGRF+4HUeS7seSw104ycUkZPtFqtSpAl
 MGomP
X-Google-Smtp-Source: AGHT+IHWbOSZnkqm5EJW/Ti7FuyJr51gdtlae6gW0bYAB2qVVsEmP9PIOLviQ1EwsUOPmIFlhmHwuQ==
X-Received: by 2002:a17:907:1c20:b0:a9a:a3a:6c48 with SMTP id
 a640c23a62f3a-a9a4c2c532fmr1654778866b.2.1729498779599; 
 Mon, 21 Oct 2024 01:19:39 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Artur Rojek <artur@conclusive.pl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 2/8] common: Tidy up how malloc() is inited
Date: Mon, 21 Oct 2024 10:19:26 +0200
Message-ID: <20241021081934.289473-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 common/board_r.c  | 3 +--
 common/dlmalloc.c | 8 +++++---
 common/spl/spl.c  | 4 +---
 include/malloc.h  | 8 ++++++++
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index e5f33f40643..8a19817fa39 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -204,8 +204,7 @@ static int initr_malloc(void)
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
index 94657d00591..1ceb63daf31 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -678,9 +678,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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

