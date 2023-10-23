Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B9EC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F8E87895;
	Mon, 23 Oct 2023 09:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QGzGXfd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B94187893; Mon, 23 Oct 2023 09:02:59 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3E4878A3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so17799585ad.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698044576; x=1698649376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFqWRW8UJYgxSDc71MXg2ORbulbEf8JXat+EmwAPZRM=;
 b=QGzGXfd2V2qbQRIh5V9qdKArWGvbknIfNVQrk3NLYP70WzkIKLW2YigFOMJlj6QecL
 XAtsM7QFWjSjsRvtF012+01AICRr3HuPZ0DpUYiWKCawovLBPKZUzAANRVaAJEZO7XCx
 5zoGNfbQ5nTayf0AS1NFWGSST1SwIi4GtZuD7I2hFWnRHwxDiGKc/z7KFKJKOIGazVVP
 gVQ1EsIKL6W81WWNyzn5cVrJfE/uC8NywF+Fi+AnBEr4dzQetIqXlR0i6EDlY5z+k05a
 OILHMHVZOn+uTUnp43fZObqFrscJJqewg0PSP4zuoevLEdgszOE+fY7ToRv357Z0Qj0M
 Rk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044576; x=1698649376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFqWRW8UJYgxSDc71MXg2ORbulbEf8JXat+EmwAPZRM=;
 b=Qb7rO/SjWpAEnYZWyDw8+ldYDV8bCI9jvVbPG5Lu1QWHNervS5suKlTMQrJi1YxC+T
 LINXPL+kWnQQsoB8GPQV1laGyQ0OGtm78t9rUD2NgNz+KolVh7cfB6N0XQHQkAKBd7Tf
 1yo10tzZ6l1Y1crBr4jH13DwvaLzCPNabjORD3YAIEPTtSGpH20EYrG3ICW5k9vSP1ZT
 jNdAC1mXpkF2TaKCTvwfjzGxpyLkyRZ1OMnNnc9Eljov86Ht+k5yc14c9QyeOz2Ad0om
 ADl+xtNkY0POZYZJZ1XoZOI3kCiaDaPa+1Pxn2eZ+zpJYkTdD9ZXSSqkKuI7ChQgNPBR
 2Ing==
X-Gm-Message-State: AOJu0YytjyBpk+jtoWf1KMjunq26svT5kmyJjkdHdUijKX3LhCW7ErU8
 QvjwV5igS6Mh80dy2XkM2UY=
X-Google-Smtp-Source: AGHT+IFvDCPLuIQYoRZi98iiS3AqaZLeUjCb5absmYOYExUWO6onOs37Ea7DT5uYu9kLOp3WuFbvwQ==
X-Received: by 2002:a17:902:f685:b0:1bb:994c:bc43 with SMTP id
 l5-20020a170902f68500b001bb994cbc43mr7039285plg.18.1698044575778; 
 Mon, 23 Oct 2023 00:02:55 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.144.223])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001c74876f018sm5368432plg.18.2023.10.23.00.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:02:55 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 3/4] board: nuvuton: arbel: Fix incorrect ram size
Date: Mon, 23 Oct 2023 15:02:24 +0800
Message-Id: <20231023070225.3142578-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
References: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
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

1. Fix incorrect ram size of 4GB dram with ECC enabled
2. Fix wrong place to set dram bank size
   - The dram bank size should be set in dram_init_banksize
   - Dram_init should not access gd->bd because the board info
     struct is not reserved yet.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
Changes for v3:
   - no change
Changes for v4:
   - Add Fix wrong place to set dram bank size

---
 board/nuvoton/arbel_evb/arbel_evb.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index e52e0a59ab..8516a37b78 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -16,7 +16,7 @@
 #define DRAM_1GB_SIZE		0x40000000ULL
 #define DRAM_2GB_ECC_SIZE	0x70000000ULL
 #define DRAM_2GB_SIZE		0x80000000ULL
-#define DRAM_4GB_ECC_SIZE	0xE00000000ULL
+#define DRAM_4GB_ECC_SIZE	0xE0000000ULL
 #define DRAM_4GB_SIZE		0x100000000ULL
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -29,7 +29,6 @@ int board_init(void)
 int dram_init(void)
 {
 	struct npcm_gcr *gcr = (struct npcm_gcr *)NPCM_GCR_BA;
-	uint64_t delta = 0ULL;
 
 	/*
 	 * get dram active size value from bootblock.
@@ -38,18 +37,23 @@ int dram_init(void)
 	 */
 
 	gd->ram_size = readl(&gcr->scrpad_c);
-	debug("%s: scrpad_c: %llx ", __func__, gd->ram_size);
 
 	if (gd->ram_size == 0) {
 		gd->ram_size = readl(&gcr->scrpad_b);
-		debug("%s: scrpad_b: %llx ", __func__, gd->ram_size);
-	} else {
+	else
 		gd->ram_size *= 0x100000ULL;
 	}
 
-	gd->bd->bi_dram[0].start = 0;
 	debug("ram_size: %llx ", gd->ram_size);
 
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+
+	gd->bd->bi_dram[0].start = 0;
+
 	switch (gd->ram_size) {
 	case DRAM_512MB_ECC_SIZE:
 	case DRAM_512MB_SIZE:
@@ -62,32 +66,28 @@ int dram_init(void)
 		gd->bd->bi_dram[1].size = 0;
 		break;
 	case DRAM_4GB_ECC_SIZE:
-		gd->bd->bi_dram[0].size = DRAM_2GB_ECC_SIZE;
+		gd->bd->bi_dram[0].size = DRAM_2GB_SIZE;
 		gd->bd->bi_dram[1].start = DRAM_4GB_SIZE;
-		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE;
-		delta = DRAM_4GB_SIZE - DRAM_2GB_ECC_SIZE;
+		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE -
+			(DRAM_4GB_SIZE - DRAM_4GB_ECC_SIZE);
+		/* use bank0 only */
+		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	case DRAM_4GB_SIZE:
 		gd->bd->bi_dram[0].size = DRAM_2GB_SIZE;
 		gd->bd->bi_dram[1].start = DRAM_4GB_SIZE;
 		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE;
-		delta = DRAM_4GB_SIZE - DRAM_2GB_SIZE;
+		/* use bank0 only */
+		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	default:
 		gd->bd->bi_dram[0].size = DRAM_1GB_SIZE;
 		gd->bd->bi_dram[1].start = 0;
 		gd->bd->bi_dram[1].size = 0;
+		gd->ram_size = DRAM_1GB_SIZE;
 		break;
 	}
 
-	gd->ram_size -= delta;
-
 	return 0;
 }
 
-int dram_init_banksize(void)
-{
-	dram_init();
-
-	return 0;
-}
-- 
2.25.1

