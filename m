Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E8CA0FE2
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BFCF868CB;
	Fri,  1 Sep 2023 03:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b+OAYtjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5248671C; Fri,  1 Sep 2023 03:14:26 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4799D86898
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-77a62a84855so57306939f.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530861; x=1694135661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bRSEfgaUNHospgGeRPyIJjXFtfEpHFtez5+wIu/b8o=;
 b=b+OAYtjN3fmwzENXEp2EOhC0QdcuuWN2DK4Y1Tmt2G9fm+u/7fGO0dv40GzmGgw+Sg
 tdOC9BCEU8H6ogVbg5arZOHUdb9BM//4OQefMuKklOWFTBm93bHRqKjYBb0vO86JfeLZ
 In6p/cwthVBYWPrrLJJYRu34H7OU2fajsapoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530861; x=1694135661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bRSEfgaUNHospgGeRPyIJjXFtfEpHFtez5+wIu/b8o=;
 b=BGAwpUOv0cnh4kn0ykzi0+Tf9IqK1e1d+56SpVNQyysvj6zkQWBTMH/N8uBtb0Kg7+
 3XMkdUqmqsiiOiyLdNSyOSwFhbymYQL3nRtIzom4VuRCvb6VdM+2dwCfXUIpKMx3uWU0
 UDSAvAmAzsAoTKshEIgPW6rSqIeDu3LsidDSGb650v9CDZHgftMQFoI9n72tWD5uBHzd
 1ONr3Wiy2jyLRncLExRlsfhl9EKzR44I22JDQQ4hokRvCz230PskUzE5+MoMEJQNw4qz
 qSScQEW0rx4dXhaAVdnOFKAQZp+AwJllMvk4pddlHn7ju4GQSGXJY1/3vLVCZ6RK1IPK
 RaOQ==
X-Gm-Message-State: AOJu0YyGEVay99gadTj11BIqZiOLTtmXIA/ym6zY4DZ+lTSWIQ1kDjo1
 eUqY4smFGF2XvYIqTHl3tL8humz5Et5LK+ggkXs=
X-Google-Smtp-Source: AGHT+IF7i5Ku8kuYa7uQzSkY1peu0ehcYBkbybu2tqGg2qM/zkHfaA4GDmcUMxc393dD8za2uXRPuw==
X-Received: by 2002:a5d:9304:0:b0:780:d76c:b640 with SMTP id
 l4-20020a5d9304000000b00780d76cb640mr1048930ion.9.1693530860843; 
 Thu, 31 Aug 2023 18:14:20 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 13/14] lmb: Document and tidy lmb_add_region_flags()
Date: Thu, 31 Aug 2023 19:13:51 -0600
Message-ID: <20230901011357.2482203-14-sjg@chromium.org>
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

Update this to return an error code so we can tell when it just ran out of
space in its lmb list. Make lmb_addrs_overlap() return a bool.

Add a few function comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/lmb.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 8a299c97b3ad..fd6326cbf7fe 100644
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
@@ -220,7 +240,22 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 	lmb_reserve_common(lmb, fdt_blob);
 }
 
-/* This routine called with relocation disabled. */
+/**
+ * lmb_add_area_flags() - Add a region or coalesce with another similar one
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
 static int lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
 			      phys_size_t size, enum lmb_flags flags)
 {
@@ -250,7 +285,7 @@ static int lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
 				/* Already have this area, so we're done */
 				return 0;
 			else
-				return -1; /* areas with new flags */
+				return -EBUSY; /* areas with new flags */
 		}
 
 		adjacent = lmb_addrs_adjacent(base, size, abase, asize);
@@ -269,7 +304,7 @@ static int lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
 			break;
 		} else if (lmb_addrs_overlap(base, size, abase, asize)) {
 			/* areas overlap */
-			return -1;
+			return -EPERM;
 		}
 	}
 
@@ -283,7 +318,7 @@ static int lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
 	if (coalesced)
 		return coalesced;
 	if (rgn->cnt >= rgn->max)
-		return -1;
+		return -ENOSPC;
 
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
 	for (i = rgn->cnt-1; i >= 0; i--) {
-- 
2.42.0.283.g2d96d420d3-goog

