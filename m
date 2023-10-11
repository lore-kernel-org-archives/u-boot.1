Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73289CD6E42
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 08:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D948086C5E;
	Wed, 11 Oct 2023 10:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SMx2XHbp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A1286CAC; Wed, 11 Oct 2023 10:48:32 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D92F86C75
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 10:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ae214a077cso5029503b6e.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697014103; x=1697618903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRAtl29LIgJX/pRsKKpxJH8V/B8SHy+AwLdZJ6uLZws=;
 b=SMx2XHbpgpwe+eNfHR8lfraDVwZY8em8Zyv1bK/pVy7H+svzRheeGLaydRstaVuLet
 J/L/wrX+CaRM/sfv04ap0Z3XpOcJok8NE6ZiXes5GITv5WGYJWpRHj35O6FFSWRaAnxs
 gENgCTocBVLCItelFtT+WrAm7XsaivyI7LQ8Z8yVw4bSzqBw4L1ZYeITVd97kIk/xNNl
 D+/KEdU+KLrNirUUDSmswD0RUYj0SgW/Gi7JQANrfXcriMOE9KsZNb4AsBXU1N+tOZ4A
 IkQ8t2Cnwele6acLHj1SblElvO8/jowvwbU1VcqF04QChxF3lLnvTgY1oS4WLNttstgA
 u82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697014103; x=1697618903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRAtl29LIgJX/pRsKKpxJH8V/B8SHy+AwLdZJ6uLZws=;
 b=nMTy/aPI7OnPHwHmRt7CeDza/4G9h+uxT/xS/eDaV5Xy+5bXfM86HHTwurOeEZbSWq
 Ea9tFrIm0Je5UtTnuonXfnpjsgffM3u+K7AfqHnyYswgQxW5Fjlvamx33Ch0Ndmf4dBh
 shdyYls28/+0bU71ReN11REK8Uxq/IQX3mWLfhBD9k7ihcsepRI/VjN4ZshfY6FP6DAp
 R+rFukswTICJa/VL98IWDvfPBoixheLYOqzJiE069iGoQqyaqdpDX+iogRu6QW7F0AxI
 1jDAW8X3Y1lb4MdCrdB2J6jPKTsWOcPGd1uE/cakHiDTDM+8vQL1tCtnfDKt9BWeJlzk
 zvgw==
X-Gm-Message-State: AOJu0Yyelh7cp5z5y0XFvbTpyjie5SXFKbOMQsYWlSUfKwz/rqPelJSY
 1G/YmulYCF3HMq2AaW172Eg=
X-Google-Smtp-Source: AGHT+IGGg/G7+14cex5hmOq+rsvNkfS/LndxTsVnFXZipbELMtvMWj64PyHXMY/+UV1VnQa1xUi1Yw==
X-Received: by 2002:a05:6808:3023:b0:3ae:554b:6c57 with SMTP id
 ay35-20020a056808302300b003ae554b6c57mr24315193oib.11.1697014103528; 
 Wed, 11 Oct 2023 01:48:23 -0700 (PDT)
Received: from localhost.localdomain ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a638c1c000000b0059c8fa8f917sm2307940pgd.12.2023.10.11.01.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:48:23 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
 YSCHU@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 3/5] board: nuvuton: arbel: fix incorrect ram size
Date: Wed, 11 Oct 2023 16:45:31 +0800
Message-Id: <20231011084533.2325296-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
References: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
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

