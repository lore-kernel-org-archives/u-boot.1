Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD28D216A3
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A15A88413;
	Tue, 15 Oct 2024 15:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UYdJGncr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0111A88618; Tue, 15 Oct 2024 15:33:14 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5DC58811C
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-835393376e1so328364839f.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728999190; x=1729603990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHT35NvdEx+lOmRjRxXjD/dUvSdZHtsK2YH1Vkt2kH8=;
 b=UYdJGncrs38xNMTYY6FrA45eY+uYbF84RRS6njxBSsV1jUZyTk6BHQfNF9ASCbM97s
 JMICUSOfWk341FULJYAwhZ/JLmCkmJEUxHSwzD1rRvA+8Td+inCyKJfWm0V+MWAx3An8
 ybs1NzxFGr26BMzK8EW0E3BVCtti9cfvashUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999190; x=1729603990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHT35NvdEx+lOmRjRxXjD/dUvSdZHtsK2YH1Vkt2kH8=;
 b=gtbJ8kn70dNHecFBKOi8XusSxQskGdnQENBNcmkVKYIzdDEbFdNwLlcncVsoeLT8gl
 YSJKRByfqHG5IvwrE3jRUT4p/+WVmlgsoOhQRf6+pL7jxCjUt9U5fn6qKzj1sID9f8Sj
 IjcRLb0UwKNXVtwCRbHkxVoDbcI5szInCJ/MmeAZQmb/Eb1jRK5Pz8TTYcFMlzRoByuR
 dtio1boYWJTe/QFVwjyaJedt5lQyhNOpvrp+FQpgOMKyiH6lGeBCdbOtDB7YCMW3dodA
 /I7h1LKo+PAf2f5MkipZ8UG4kx2j7Hn+KPmsRIhN4+EVS450fgkVHlLN34e3oD475Klw
 IqIA==
X-Gm-Message-State: AOJu0YyheyNcK3IE/IentlhwMbLVDtdx8kwpPks8UdmGiQMAG8n3Gw/o
 g1g7LB4ChC4BLKDwl12N4W65J2NWBl1YraJyAheyR6/+M6pbVIijBl6YsiANcIFlh8/MUw/BtP5
 eEA==
X-Google-Smtp-Source: AGHT+IF+X2+3x5ZPNBjuZMInX5zj1wlIN2FiaWw/F8JmIraQsTOS45+WV1aElxd8bG1d2RgQx19hxQ==
X-Received: by 2002:a05:6602:1541:b0:834:f2d5:c758 with SMTP id
 ca18e2360f4ac-83a64d854c3mr950730639f.13.1728999190469; 
 Tue, 15 Oct 2024 06:33:10 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83a8b28bed6sm29794939f.8.2024.10.15.06.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:33:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Artur Rojek <artur@conclusive.pl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 2/7] common: Tidy up how malloc() is inited
Date: Tue, 15 Oct 2024 07:32:59 -0600
Message-Id: <20241015133304.2874735-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015133304.2874735-1-sjg@chromium.org>
References: <20241015133304.2874735-1-sjg@chromium.org>
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
2.34.1

