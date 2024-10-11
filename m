Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99732D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F8838939B;
	Fri, 11 Oct 2024 23:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ha6hEqJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF2F893F8; Fri, 11 Oct 2024 23:40:42 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E076C893D3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a1a90bd015so8040925ab.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728682838; x=1729287638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKUye/GNhY6eymV0+AALcX1ICRtRHyht+yjZun1fWxE=;
 b=ha6hEqJn/h7VCrD/M5UTJCo6D/SyAt9SlsasPNAv3LsGFO8VGrjNXx+WV6HN0ZM9AK
 t/s4l7JnC76z0RQzdLxxnOBK3/k2qdpE01BwWm97mnSbIUT7klYKrbNECoCuTrtHL0TF
 Myb8h98cOreWACc/I4WIIDFvOOMG3zeLIeu3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728682838; x=1729287638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKUye/GNhY6eymV0+AALcX1ICRtRHyht+yjZun1fWxE=;
 b=hIABFe7YkN4yueKdOsnD/6wK6f9V+hS6UC0Vfs+TF4Mxxy25PHqxYrF+SIBp4J3E1q
 xnNAqDsut8hgpPCK9UYTyxX9oBbXYcNurd19aDr1NKW+Vv0y7QKBJLlzcsd+Mk4h5s8L
 dd+x9/tpY9CPV62UNqUgeA5wRv97UGiUByd6ZN2sY7v5jFxN4bKsIYWcuoSzE8F+iEHw
 zdiAc+wW8rzXJtynws1m2+4X0EytKk2VkQStfQWJ1/AT95/zaRxANBrT55KyJ3z3hBM6
 qocsVLATMVxoxVlGjZ+AQSUZJ2cW7ymScG36UGyLwq4dxNPb8SewUaCLypntbK2cI03W
 07/A==
X-Gm-Message-State: AOJu0YwFOO8DG3cRmJLmeo8algIex/KqTGvXdxlUYFdUMpOtRMuxSEGS
 y24PmWMc9EtC/vH2g5g/A7rANcDmYalKIrqBhPK2W94NGczD/K08BulbnPRMvanga0zN8eySmQD
 RcQ==
X-Google-Smtp-Source: AGHT+IEo6xRjRG+lg1U1HzZO90ZJbtOAPuWT/vBbAEE2yon+soyLhff157Xp4ZD+fVnbwgeVG08X1w==
X-Received: by 2002:a05:6e02:1a22:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a3b5f7390emr30978845ab.12.1728682838581; 
 Fri, 11 Oct 2024 14:40:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a3afdae0f1sm8830475ab.11.2024.10.11.14.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:40:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/7] common: Tidy up how malloc() is inited
Date: Fri, 11 Oct 2024 15:40:26 -0600
Message-Id: <20241011214032.760072-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011214032.760072-1-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
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

(no changes since v1)

 common/board_r.c  | 3 +--
 common/dlmalloc.c | 8 +++++---
 common/spl/spl.c  | 4 +---
 include/malloc.h  | 8 ++++++++
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 1acad069d92..60eba0942d8 100644
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
2.34.1

