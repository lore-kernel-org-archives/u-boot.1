Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E46ACDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4A386E5A;
	Thu, 12 Oct 2023 08:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GOXxg75Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE14286E15; Thu, 12 Oct 2023 08:56:41 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB4586E5A
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5859b06509cso454396a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697093780; x=1697698580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usFPWpINFnQj5UHcQM5xhuF0Lddb/aijoQMF47T0hCU=;
 b=GOXxg75QPxWnPYTwRcAkwFkmP+M0IV8FP0f+/XK2tzCXMqu0+AYkysZ3C3F2hsOCyh
 DiixmPSlay8r/+r1HXfSs2vIzTFfamq4tCOsJ8GVTE51CPapjTyb8YUZzxMOeuNcG+5d
 Tt1VRAb62OYpHfVAR5cUHUV3nYnyAUr13+diGF6kWwzW5iqTwMmylWnJfX40lk1yZyrz
 1cpM8+nRrZTYmna+5cehuiBs18XH6g89yAjtxdr/CS56igRCdJ5ONG7p7AxyWeemvCMC
 KKX0BUZuqZRr5Jdb7CVcPiJrn58FDAogW0C5Vrm/PpeoptWz1UBz14zA0n4JuvsPDDbU
 2lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697093780; x=1697698580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usFPWpINFnQj5UHcQM5xhuF0Lddb/aijoQMF47T0hCU=;
 b=YKEIJUNobK6mLcVD7zkkWnFf4fl5MUksOShHIPQ1vUF72WO2jK0hO1xqik6BlcbTag
 CtoD8LrBsywkOYAPKt5tvXbzM1XXDQoCofxNoiBe6EaXJpGcdw+tC5fi+HdusQcrkqXN
 xUBWXdNwgdQHPny1JG4cvgGptvbeXneknx6aWGI7ZMaJwkiwptvMGNwm0aaFmC3PHpv+
 KBAEmH6vd276Jms7c3+tpLD9RTCXyYdvGHXvvYjimwIWSmY4sxz2CSrC/Wz53Q2j6/Se
 SEmoy2Gvqxou58DQuytiqjb9E6WfbB86e47mIiWy0ZuXGdzzkx8Hp3DDKiItavvj6sfR
 D8hg==
X-Gm-Message-State: AOJu0Yw12PAkHwW19h4QUOrIGy59U/DzUP1MaT4T1Np0V4KyFY3jyxTg
 velDTAIsp/fhe78W4c8xqiacuahtilw=
X-Google-Smtp-Source: AGHT+IGLUJqFz7d8JEmMosgIDxR31NJuMu29afA/XoNJpA6h2Xr5IRg8JkHhLjzo76cbsBtCxwUZ4w==
X-Received: by 2002:a05:6a20:9389:b0:154:6480:83a4 with SMTP id
 x9-20020a056a20938900b00154648083a4mr22768727pzh.14.1697093779734; 
 Wed, 11 Oct 2023 23:56:19 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170902c65300b001bc68602e54sm1096977pls.142.2023.10.11.23.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 23:56:19 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 3/4] board: nuvuton: arbel: fix incorrect ram size
Date: Thu, 12 Oct 2023 14:53:22 +0800
Message-Id: <20231012065323.2709121-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
References: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
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

fix incorrect ram size of 4GB dram with ECC enabled

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
Changes for v3:
   - no change
---
 board/nuvoton/arbel_evb/arbel_evb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index e52e0a59ab..acaafad549 100644
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
@@ -62,26 +61,28 @@ int dram_init(void)
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
 
-- 
2.34.1

