Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49903C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6EA88827;
	Tue, 30 Jul 2024 16:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N3oYOKNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6810E887B9; Tue, 30 Jul 2024 16:40:46 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407738882F
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f921c40f2so191190439f.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350443; x=1722955243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOeIOfELo3KRS0yS9ZPkv3fiDn8fjnO2vg1TiC0sSOA=;
 b=N3oYOKNWozdjCTZkm49WAt7W/IaM9r+qMkcZeMRBTU7qkN5K3SJc13Rzj+Hy2JMhIp
 LmAMlwfHlqWXYjG+i2B8u9pSGGq6YKPkw8hfFYtxrJcYc5XAgGLt2lgYj4Drbn6h/dMl
 FXfXZsHq07ZYyqFp12LQ8lUz657bgLbggL+gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350443; x=1722955243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOeIOfELo3KRS0yS9ZPkv3fiDn8fjnO2vg1TiC0sSOA=;
 b=l1965MgneRtcK1AnSJuCGXgqz6b2KmwmvbvXMmMh7iOB28eAR9VO/RtgHMv8fBsS5x
 5IGp+selr2OFkUqnRJ9/9vdO4UzA1Kj+O9bLvKF0YUYeDGk3qkR6FFFk1hokYqS+xSu9
 i96ApsHpCdoePD9n7KQ40nyt2f61u990T4E3Zinlk5eWpSowtejs+LdhlfvMsguOTVX1
 14WXpnBOmNZsF/r13oMSvJJzpvvoFLlT6gIqPPqenckSnLDIMM1Kg8QGRUA8Dx5olLFH
 UYDlTog0yel+ITinzcwni0xsR571TEO4Vv4vjaIFv6BzEyc27RZzdemSr55eq7Llh+xY
 LX3g==
X-Gm-Message-State: AOJu0Yw+O3W6b1/lifzfIW4Z8BhKlB8eVanYMb0d6S9RAdyZty/Vdxox
 UwivD7VUOq35MHTj0fMcud1l92/U4W/7QapPD9pkukNlYZw6lAtpjZ4zAZkqo6ajoCDqCxaIzu8
 =
X-Google-Smtp-Source: AGHT+IGClNTFTQAlFpDJ6xdNfImz5E3rgdDM7sLbIzMgeezuWuuPUKihHLRnOo3bRBB8s+wu1Sagkw==
X-Received: by 2002:a05:6602:26d1:b0:804:8a79:2c77 with SMTP id
 ca18e2360f4ac-81f95a4451cmr1813015139f.8.1722350442786; 
 Tue, 30 Jul 2024 07:40:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa9338csm2714724173.39.2024.07.30.07.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:40:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
	Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 2/4] lmb: Tighten up the code in lmb_add_region_flags()
Date: Tue, 30 Jul 2024 08:40:33 -0600
Message-Id: <20240730144035.3992996-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730144035.3992996-1-sjg@chromium.org>
References: <20240730144035.3992996-1-sjg@chromium.org>
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

This function has more special cases than it needs. Simplify it to
reduce code size and complexity.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lmb.c | 57 +++++++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index c11ce308c5b..83b060a2f4d 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -396,14 +396,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 	if (alist_err(lmb_rgn_lst))
 		return -1;
 
-	if (alist_empty(lmb_rgn_lst)) {
-		rgn[0].base = base;
-		rgn[0].size = size;
-		rgn[0].flags = flags;
-		lmb_rgn_lst->count = 1;
-		return 0;
-	}
-
 	/* First try and coalesce this LMB with another. */
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		phys_addr_t rgnbase = rgn[i].base;
@@ -448,50 +440,39 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 		}
 	}
 
-	if (i < lmb_rgn_lst->count - 1 &&
-	    rgn[i].flags == rgn[i + 1].flags) {
-		if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
-			lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
-			coalesced++;
-		} else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
-			/* fix overlapping area */
-			lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
-			coalesced++;
+	if (lmb_rgn_lst->count && i < lmb_rgn_lst->count - 1) {
+		rgn = lmb_rgn_lst->data;
+		if (rgn[i].flags == rgn[i + 1].flags) {
+			if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
+				lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
+				coalesced++;
+			} else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
+				/* fix overlapping area */
+				lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
+				coalesced++;
+			}
 		}
 	}
 
 	if (coalesced)
 		return coalesced;
 
-	if (alist_full(lmb_rgn_lst)) {
-		if (!alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc * 2))
-			return -1;
-		else
-			rgn = lmb_rgn_lst->data;
-	}
+	if (!alist_add_placeholder(lmb_rgn_lst))
+		return -1;
+	rgn = lmb_rgn_lst->data;
 
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
 	for (i = lmb_rgn_lst->count - 1; i >= 0; i--) {
-		if (base < rgn[i].base) {
-			rgn[i + 1].base = rgn[i].base;
-			rgn[i + 1].size = rgn[i].size;
-			rgn[i + 1].flags = rgn[i].flags;
+		if (i && base < rgn[i - 1].base) {
+			rgn[i] = rgn[i - 1];
 		} else {
-			rgn[i + 1].base = base;
-			rgn[i + 1].size = size;
-			rgn[i + 1].flags = flags;
+			rgn[i].base = base;
+			rgn[i].size = size;
+			rgn[i].flags = flags;
 			break;
 		}
 	}
 
-	if (base < rgn[0].base) {
-		rgn[0].base = base;
-		rgn[0].size = size;
-		rgn[0].flags = flags;
-	}
-
-	lmb_rgn_lst->count++;
-
 	return 0;
 }
 
-- 
2.34.1

