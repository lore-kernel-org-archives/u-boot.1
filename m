Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D10CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D105186785;
	Fri,  1 Sep 2023 03:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FWgvKIuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FFF48676C; Fri,  1 Sep 2023 03:14:14 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB7080750
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so4675339f.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530850; x=1694135650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G2Y0euzkXOWB45pmtQvCXBg1MPleW1w86oCnXVxCTg=;
 b=FWgvKIuvJWhMMH8pw6Qdc/k+S4WXgr3yUOnqHc1idhl3i9GQBZ8xiR8lGGLWhweohZ
 oKLD4RdfzjIrAgvap9waQzZl5q6iDMHECTrLdZoFrO2enB9fSepwWecju8MDD5zYyaSY
 Qlb/Aijs9YOODNd9wp1/TB92QK/6/X/vl2mw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530850; x=1694135650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1G2Y0euzkXOWB45pmtQvCXBg1MPleW1w86oCnXVxCTg=;
 b=KZxO9tk59r9+MvvZ+aSJcDlSlz5ie8iJSrdPVxQxOoXv1QYjbfl6384yc5m46Lwgj9
 p0/oAXLp1et8XWnnvCelN1qCII7kxmrBwp3TXXmZTOU+RQtzlN2YUeHAC2rzgh8ahL2H
 NQyOlsqX3JS3SK4Ko/eRtn8uN6YWOcUc0HuEAhbq+YDRL59ATTphHiSO1nru+YnKjoW4
 mpm8EFYq/+nSlSKPY5j49j/GBuDvMx9nUX/cF8lMEQyXSdOrsoEjh65nkR7pXxipQxbY
 ZjH5aZltS9Ai/7aUXxoYQdtsV5QVXZ6b/GmXizMrXUeIvapP2XljtzlqRDJFdWrWConP
 eonw==
X-Gm-Message-State: AOJu0YxkUCV146s43Ep7vLeYIRUR2gnQta/zyExN0wIV9MW1s+QcBbBj
 oZ7vkPgCRYdrBdh7O+bzvuBUICPtJl+De4skg+s=
X-Google-Smtp-Source: AGHT+IE5EbobLOqW21gJgxFhNGhNiDiCDM5wEJTRWK/YKGvdmAPazUU+t6znhq/OGCOeV/uXvgnUrg==
X-Received: by 2002:a05:6602:498f:b0:792:96c0:f4ad with SMTP id
 eg15-20020a056602498f00b0079296c0f4admr4070218iob.3.1693530850171; 
 Thu, 31 Aug 2023 18:14:10 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 01/14] lmb: Drop surplus brackets and fix code style
Date: Thu, 31 Aug 2023 19:13:39 -0600
Message-ID: <20230901011357.2482203-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901011357.2482203-1-sjg@chromium.org>
References: <20230901011357.2482203-1-sjg@chromium.org>
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

(no changes since v1)

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
2.42.0.283.g2d96d420d3-goog

