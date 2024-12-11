Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9B5E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 02:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8CA80274;
	Wed, 11 Dec 2024 03:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BaFsQ2PC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BE28023C; Wed, 11 Dec 2024 03:25:58 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 071A3801FE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 03:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-29645a83b1bso3161896fac.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733883955; x=1734488755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUULVKp6JsJMDTs4uADkfys/dyoa4YYb7jx4+q3kuks=;
 b=BaFsQ2PCbLabqBBTUGKMjd3CMG1Rtf7lJCfpjFhVaIYbqN//TEkFVtSbBnIdCgg18t
 zu9g6mBEhgarQ2g7/+iu7Z0sjM7YYz9GeJ1sHX9/7FHsal6/QUr0g8jsXpO/+9A1jvkQ
 7kZDkJJMU5upEELBtxFlg+YWBtOVRzYPzu6sWTM/rQ8++mp/raXB1Ae4PreWjHY1PZfs
 QUNyXq9oXPPAzwnTsSe9BOYtMrYtlqx92pKb+K3nsukWDkQJEiLkKntJfcnGcD52E5OL
 IVogIGS11Bg38rcrIXs5gcEy1Scy12CI0t6At+k7aDLv0BlKLQWaahF7u5+Ne4tbNbxb
 CCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733883955; x=1734488755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUULVKp6JsJMDTs4uADkfys/dyoa4YYb7jx4+q3kuks=;
 b=EKHAr51kth2MsT5yGuZ02dLQzGMrJSM80TEtcpZtehJLP224ddH1N9kG1QMDVL2RdO
 DeqOj5QgSfLd9LfyuTHnwOvBKC91LIrmIB8DmLx+jHMjsKhNcLTC7PI6lxbnqb4iEkqB
 INDuGo1+nJZPDA0nwcsWJyfKUEGvuo1/3AiBHZGB0IVVtbKdB8mi5+8fLnVGA7EB+mqt
 u0gvh6mUDqNFFWSoDGG7TolAfecXUTyqU+FkPl0My67yEpRWVZ3JUpZZ0umpes4jTD6t
 FBX5utvYcVYt+wn6n01ZbTDxpfHaexmGRIk+0eApM/qepimBq6pxuFq8qZVKHfCjcWzF
 9lpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6wwZ6D0l4sMC6qGQSSSaYCIQFuqvJ9h6iiX5S79wdzcaDG/hnNPd4yVZvgAf14KamFmLpGos=@lists.denx.de
X-Gm-Message-State: AOJu0YwO5JGIMocjC/JqhIhDwxANkBAbnVJP2ahOm9VLu+MRaZLRnsVA
 nrZplUgPOzsO5sK3FKzOTVd8vMSHT07pnOGM1xPf8Vcp/S3cAianLD4CV9G9DQE=
X-Gm-Gg: ASbGncsDN8m/u9uoU/PDFDvsXEEOoO39cW2F5qIfBvnpVrwJtQbJECWWmGCHqhSefT2
 eO5Q7D3KMq/d1isVFvih4vErD95NyJ1Bx5FLmlTVhp0B+fSphFEaQfnGIVNLTZk3Jll076UrXvV
 a8EJa4G8+B29gDScrOoOE6JYvW2BxzkFYsSpLxp0WPFhIntx1MyfH3Ky5CtrMT9s9bhSSKrNjnY
 OI5wy5x+tGT4WKUJAAmEGvieVZZ9kSIJwSA63wA2fo7xLQB3FJZTld2OCk=
X-Google-Smtp-Source: AGHT+IGkJGhxdd+C0zy/DHsJ3pxjSgRghZn41vTXhKzYe/71VUf/ruLXp8mz7nrUadr6+sLkrudOaw==
X-Received: by 2002:a05:6871:8916:b0:29e:29ac:5ade with SMTP id
 586e51a60fabf-2a012e19fdfmr860987fac.35.1733883954846; 
 Tue, 10 Dec 2024 18:25:54 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29fd866f393sm1582995fac.21.2024.12.10.18.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 18:25:54 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH v2 3/4] lmb: Improve coding style
Date: Tue, 10 Dec 2024 20:25:49 -0600
Message-Id: <20241211022550.2995-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211022550.2995-1-semen.protsenko@linaro.org>
References: <20241211022550.2995-1-semen.protsenko@linaro.org>
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

Fix checkpatch warnings. No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2:
  - Added Acked-by tag from Ilias

 lib/lmb.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 0f9de26b64af..40f03151929c 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -57,7 +57,6 @@ static long lmb_regions_overlap(struct alist *lmb_rgn_lst, unsigned long r1,
 				unsigned long r2)
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
-
 	phys_addr_t base1 = rgn[r1].base;
 	phys_size_t size1 = rgn[r1].size;
 	phys_addr_t base2 = rgn[r2].base;
@@ -70,11 +69,11 @@ static long lmb_regions_adjacent(struct alist *lmb_rgn_lst, unsigned long r1,
 				 unsigned long r2)
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
-
 	phys_addr_t base1 = rgn[r1].base;
 	phys_size_t size1 = rgn[r1].size;
 	phys_addr_t base2 = rgn[r2].base;
 	phys_size_t size2 = rgn[r2].size;
+
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
 
@@ -228,6 +227,8 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 
 			coalesced++;
 			break;
+
+			return -1;
 		}
 	}
 
@@ -278,14 +279,17 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
 	phys_addr_t end = base + size - 1;
 	int i;
 
-	rgnbegin = rgnend = 0; /* supress gcc warnings */
+	/* Suppress GCC warnings */
+	rgnbegin = 0;
+	rgnend = 0;
+
 	rgn = lmb_rgn_lst->data;
 	/* Find the region where (base, size) belongs to */
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		rgnbegin = rgn[i].base;
 		rgnend = rgnbegin + rgn[i].size - 1;
 
-		if ((rgnbegin <= base) && (end <= rgnend))
+		if (rgnbegin <= base && end <= rgnend)
 			break;
 	}
 
@@ -294,7 +298,7 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
 		return -1;
 
 	/* Check to see if we are removing entire region */
-	if ((rgnbegin == base) && (rgnend == end)) {
+	if (rgnbegin == base && rgnend == end) {
 		lmb_remove_region(lmb_rgn_lst, i);
 		return 0;
 	}
@@ -330,6 +334,7 @@ static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		phys_addr_t rgnbase = rgn[i].base;
 		phys_size_t rgnsize = rgn[i].size;
+
 		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
 			break;
 	}
@@ -705,7 +710,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size)
 }
 
 static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
-				    phys_addr_t max_addr, enum lmb_flags flags)
+				   phys_addr_t max_addr, enum lmb_flags flags)
 {
 	int ret;
 	long i, rgn;
@@ -720,16 +725,18 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 
 		if (lmbsize < size)
 			continue;
-		if (max_addr == LMB_ALLOC_ANYWHERE)
+
+		if (max_addr == LMB_ALLOC_ANYWHERE) {
 			base = lmb_align_down(lmbbase + lmbsize - size, align);
-		else if (lmbbase < max_addr) {
+		} else if (lmbbase < max_addr) {
 			base = lmbbase + lmbsize;
 			if (base < lmbbase)
 				base = -1;
 			base = min(base, max_addr);
 			base = lmb_align_down(base - size, align);
-		} else
+		} else {
 			continue;
+		}
 
 		while (base && lmbbase <= base) {
 			rgn = lmb_overlaps_region(&lmb.used_mem, base, size);
@@ -803,7 +810,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 }
 
 static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
-				    enum lmb_flags flags)
+				   enum lmb_flags flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.free_mem.data;
-- 
2.39.5

