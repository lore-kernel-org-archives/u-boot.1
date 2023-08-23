Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A053EE49B0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CED5A864C5;
	Wed, 23 Aug 2023 15:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I/eKyP8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48963864E0; Wed, 23 Aug 2023 15:42:25 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C20E864D2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34ca1aadce9so12899175ab.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692798141; x=1693402941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AA9w3TzMEKx5fHM3t5oM1FxZHj+zGdFTjT3VtulIZNI=;
 b=I/eKyP8UN450NE15gWR8NaEYCCNJkqi5I4yK2Z8jGKk8fJxJI7uahJxqjYHbGRNniS
 alQQpFR2+ouy+SXD2sCt6QpFtBhT3ftqFQw2DbLlPzfi82UxFviXa/S0N+tvz2zMMqJc
 F8QpGDWVf6O8V3JeElnRHwceYEJXGPMYI8LE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692798141; x=1693402941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AA9w3TzMEKx5fHM3t5oM1FxZHj+zGdFTjT3VtulIZNI=;
 b=eQY6KDb9vDVwHq/b5crSb4KwgOhfJIy/fmYiL4/miRU0/jH8f9pm6cKMsnTo2uaYCk
 ntiajqyAjDf3A+93z4z07gZpm+PprNyeqQT6F6TmIJfuUWX2xWXtN0wGc0A3I4fy3tml
 b04ovHgPrYYqrMOmetieMiFjYjCjZlAm10txKTKpodscXA//09sSnS7Fq7KodieXTelS
 wjfhcFM81BlyXuPuABQmX6YkszAtOgIt1LLxeUw9NiVo2xP/o9bXf8+PVawiXY9QUOE9
 FNg62rQtRyKBURWwCzdmDyCCDK7QoidEqkpiqREu45v19m/MLevaQ4idWE78E3YAwimN
 nhuQ==
X-Gm-Message-State: AOJu0YzlCro9RgI6XLTu3jCGUv02oFqlpEeQUK98fs6CZno4CIgZ9c0j
 B9flV4fNaKOBlX0KuqpNvR/8I5bZL7RqXEXJzlI=
X-Google-Smtp-Source: AGHT+IE4KEikBShhGqqOdDH76XfO/n+l8mPeO45h381OJRfhMBy6OJaCA64SNfcxopTbdAufxmPRuQ==
X-Received: by 2002:a05:6e02:1ca8:b0:349:36e1:10fb with SMTP id
 x8-20020a056e021ca800b0034936e110fbmr2907484ill.18.1692798141777; 
 Wed, 23 Aug 2023 06:42:21 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a02cdcd000000b0042b4f9ddecasm3800233jap.85.2023.08.23.06.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 06:42:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 6/7] lmb: Document and tidy lmb_add_region_flags()
Date: Wed, 23 Aug 2023 07:42:02 -0600
Message-ID: <20230823134209.1450567-7-sjg@chromium.org>
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

Update this to return an error code so we can tell when it just ran out of
space in its lmb list. Make lmb_addrs_overlap() return a bool.

Add a few function comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lmb.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 5f2ea45c3ba9..340681961826 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -53,8 +53,17 @@ void lmb_dump_all(struct lmb *lmb)
 #endif
 }
 
-static int lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
-			     phys_addr_t base2, phys_size_t size2)
+/**
+ * lmb_addrs_overlap() - Compare two address ranges for overlap
+ *
+ * @base1:	base address of region 1
+ * @size1:	size of the region 1
+ * @base2:	base address of region 2
+ * @size2:	size of the region 2
+ * Returns: true if the regions overlap, else false
+ */
+static bool lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
+			      phys_addr_t base2, phys_size_t size2)
 {
 	const phys_addr_t base1_end = base1 + size1 - 1;
 	const phys_addr_t base2_end = base2 + size2 - 1;
@@ -62,6 +71,17 @@ static int lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
 	return base1 <= base2_end && base2 <= base1_end;
 }
 
+/**
+ * lmb_addrs_adjacent() - Compare two address ranges for adjacency
+ *
+ * @base1:	base address of region 1
+ * @size1:	size of the region 1
+ * @base2:	base address of region 2
+ * @size2:	size of the region 2
+ * Returns: 1 if region 2 start at the end of region 1,
+ *	-1 if region 1 starts at the end of region 2,
+ *	else 0
+ */
 static int lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 			      phys_addr_t base2, phys_size_t size2)
 {
@@ -221,7 +241,22 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 	lmb_reserve_common(lmb, fdt_blob);
 }
 
-/* This routine called with relocation disabled. */
+/**
+ * lmb_add_region_flags() - Add a region or coalesce with another similar one
+ *
+ * This will coalesce with an existing regions so long as @flags is the same.
+ *
+ * This routine is called with relocation disabled.
+ *
+ * @rgn:	Region to process
+ * @base:	base address of the memory region to add
+ * @size:	size of the memory region to add
+ * @flags:	flags for this new memory region
+ * Returns: 0 if OK, -EBUSY if an existing enveloping region has different
+ * flags, -EPERM if there is an existing non-adjacent region, -ENOSPC if there
+ * is no more room in the list of regions, ekse region number that was coalesced
+ * with this one
+ **/
 static int lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 				phys_size_t size, enum lmb_flags flags)
 {
@@ -251,7 +286,7 @@ static int lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 				/* Already have this region, so we're done */
 				return 0;
 			else
-				return -1; /* regions with new flags */
+				return -EBUSY; /* regions with new flags */
 		}
 
 		adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
@@ -270,7 +305,7 @@ static int lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
 			/* regions overlap */
-			return -1;
+			return -EPERM;
 		}
 	}
 
@@ -284,7 +319,7 @@ static int lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 	if (coalesced)
 		return coalesced;
 	if (rgn->cnt >= rgn->max)
-		return -1;
+		return -ENOSPC;
 
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
 	for (i = rgn->cnt-1; i >= 0; i--) {
-- 
2.42.0.rc1.204.g551eb34607-goog

