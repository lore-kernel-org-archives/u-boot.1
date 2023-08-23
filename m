Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02784EE49B5
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733C8864BA;
	Wed, 23 Aug 2023 15:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A2SlarTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5CA864C7; Wed, 23 Aug 2023 15:42:21 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4481E86386
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-792409bc1cdso60881839f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692798138; x=1693402938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O7JKfxlbBDYr+GYG1dv+lSSVfAWQ8NGjexGgrYISO0=;
 b=A2SlarTvsXPeUmccCj6hEx99is3bKGcQ7op/u5vjk+JEOFHv3SobU8vOdLijwKQsWV
 oc6vayTiyRPGg9W8IhD8LjNbZBRWeJyz/RzR6MpKKif0Bc8Ck+FA5U7mdpDnB1H98rnR
 LRg5eGCirOYYZbXT60SPKrfJIqhdzxpbXMThs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692798138; x=1693402938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7O7JKfxlbBDYr+GYG1dv+lSSVfAWQ8NGjexGgrYISO0=;
 b=LRCsxdkEDfKxxXh7pr+Kxm6LDIRZ9acIV4mCttsWfLzKI8kuN7Fx4ZbLxh/qQ8msj4
 k43koLhIws6xjK4WD8xnnruZVGn2VDicMr29ZBmOxChcVqI1wuHG1P9vmKnAVjTY4jnv
 ajY7oxy+qAnC3ymUdyDTbX218+QZSYR+zczmbFAiA4wGTTd2TiB+tBd5CYHxpB333AWR
 8Ms3EiMUSKvliQ2TGw2Heo18jA/vx2cIVwtR0jHuqiOHUTW1bCGHs1U+i4h5ZP1Hbom+
 CpLPutRUnNIHRuz4DpneWK/Fnb8jqW/lWINWBo37B0gHX8J1aIyTTeTGkABDI4NOQUHb
 NLiw==
X-Gm-Message-State: AOJu0YzlxAe1CY03dmg1trTm+EKMPSarkCMGVXNDFeErVMgowzVj/RtS
 /GWCKarhTm3KWgqC4EZPH4+FyEgR4rFKTzqFt8Y=
X-Google-Smtp-Source: AGHT+IGZn4DWEn7JsZoGmeniyPWC14z/yxmk+wGfxMgyQjk0KF909c/n89mzwfVlf+JZ0ZRYRdbE5Q==
X-Received: by 2002:a05:6602:1650:b0:786:a615:6281 with SMTP id
 y16-20020a056602165000b00786a6156281mr2775740iow.3.1692798137891; 
 Wed, 23 Aug 2023 06:42:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a02cdcd000000b0042b4f9ddecasm3800233jap.85.2023.08.23.06.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 06:42:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 1/7] lmb: Drop surplus brackets and fix code style
Date: Wed, 23 Aug 2023 07:41:57 -0600
Message-ID: <20230823134209.1450567-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823134209.1450567-1-sjg@chromium.org>
References: <20230823134209.1450567-1-sjg@chromium.org>
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

Use a blank line before the final return. Avoid using too many brackets
to avoid confusion about precedence. Fix some overly long lines.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lmb.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index b2c233edb64e..ae1969893f00 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -60,7 +60,7 @@ static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
 	const phys_addr_t base1_end = base1 + size1 - 1;
 	const phys_addr_t base2_end = base2 + size2 - 1;
 
-	return ((base1 <= base2_end) && (base2 <= base1_end));
+	return base1 <= base2_end && base2 <= base1_end;
 }
 
 static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
@@ -278,7 +278,7 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		}
 	}
 
-	if ((i < rgn->cnt - 1) && lmb_regions_adjacent(rgn, i, i + 1)) {
+	if (i < rgn->cnt - 1 && lmb_regions_adjacent(rgn, i, i + 1)) {
 		if (rgn->region[i].flags == rgn->region[i + 1].flags) {
 			lmb_coalesce_regions(rgn, i, i + 1);
 			coalesced++;
@@ -375,6 +375,7 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	 * beginging of the hole and add the region after hole.
 	 */
 	rgn->region[i].size = base - rgn->region[i].base;
+
 	return lmb_add_region_flags(rgn, end + 1, rgnend - end,
 				    rgn->region[i].flags);
 }
@@ -404,7 +405,7 @@ static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
 			break;
 	}
 
-	return (i < rgn->cnt) ? i : -1;
+	return i < rgn->cnt ? i : -1;
 }
 
 phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
@@ -412,7 +413,8 @@ phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
 	return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
 }
 
-phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
+phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
+			   phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
 
@@ -430,7 +432,8 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 	return addr & ~(size - 1);
 }
 
-phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
+phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
+			     phys_addr_t max_addr)
 {
 	long i, rgn;
 	phys_addr_t base = 0;
@@ -468,6 +471,7 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phy
 			base = lmb_align_down(res_base - size, align);
 		}
 	}
+
 	return 0;
 }
 
@@ -494,6 +498,7 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 				return base;
 		}
 	}
+
 	return 0;
 }
 
@@ -521,6 +526,7 @@ phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr)
 		return lmb->memory.region[lmb->memory.cnt - 1].base +
 		       lmb->memory.region[lmb->memory.cnt - 1].size - addr;
 	}
+
 	return 0;
 }
 
@@ -534,6 +540,7 @@ int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags)
 		if ((addr >= lmb->reserved.region[i].base) && (addr <= upper))
 			return (lmb->reserved.region[i].flags & flags) == flags;
 	}
+
 	return 0;
 }
 
-- 
2.42.0.rc1.204.g551eb34607-goog

