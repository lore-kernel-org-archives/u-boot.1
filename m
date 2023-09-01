Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A3CCA0FE2
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A4686828;
	Fri,  1 Sep 2023 03:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lXkzjAPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A68EB86722; Fri,  1 Sep 2023 03:14:25 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6819E8671C
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so35968339f.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530860; x=1694135660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhvpI5tPEkAAVR8Jt4Zxw9mYLbrF5WzGgfQ8tvDqU/I=;
 b=lXkzjAPyjvyCtDFFRXia8qPzaSQlwdHLkrYzgUd6Fy+eHfG/xpbj62yoCy9/3sIR/h
 A2WkjFSEJTx/+AGEsH9ky+4NDecXUPyGVNUsU1uaTprcqbtP1exQcrVXyo1fnfDCqO49
 1AG6F1r9neqcb6+nZ81iFMMnGnFiRH4uk2ud4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530860; x=1694135660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhvpI5tPEkAAVR8Jt4Zxw9mYLbrF5WzGgfQ8tvDqU/I=;
 b=gR1wdh9YIAXOq+QHhsLtzbM3TRH0J3zACAMwUFhZ3rtab399kmVhXSWDgY47cz3H9G
 gbjyWVsBlvyWGD/JFHXzDTIN9LV7MZ6i3zsyyqLf2yQJ9gytPfiW7ERb3ZrjdP5x6lCA
 RnIKCenzEGpn2LO3mop/ixdEM0OxtAPXD/S7u2bb+FEBFJBfVBncLkhTFhZdDDocVzRj
 XuO4ew9p3oJb6DiaMZIlDrlXPPoovpCNgZKuvMDiLMR6RKGLO26I99YrJqNZ3rGwUR0r
 iXXH3bya9lohaIkDq7JEUdnIX5ULLplU2oJ+nCZRPKzIXQQ8s34I+Yxleb49ZQxJby3k
 l8fw==
X-Gm-Message-State: AOJu0YyC8Sg+N5H3riU0iFDGGyt49ZpA1BTNVGTJs3DdDpekDdVovA9t
 8ct7TTnPJLcfS38Q4ivmJxnVKc52L+etperyouE=
X-Google-Smtp-Source: AGHT+IHyQJlhRN7lh1vySyiEGmy0Ry6iP9NK4B3+eRX6J6oFo6npsrN1/nNgE09A3lhOtApF1ZXL+A==
X-Received: by 2002:a05:6602:3994:b0:791:ad01:3f3e with SMTP id
 bw20-20020a056602399400b00791ad013f3emr4194580iob.0.1693530860037; 
 Thu, 31 Aug 2023 18:14:20 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 12/14] lmb: Tidy up lmb_overlaps_region()
Date: Thu, 31 Aug 2023 19:13:50 -0600
Message-ID: <20230901011357.2482203-13-sjg@chromium.org>
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

Add a comment to define what this returns. Return a specific error when
no overlap is found.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/lmb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 0c6244ca47f8..8a299c97b3ad 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -386,6 +386,13 @@ int lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
 }
 
+/**
+ * lmb_overlaps_region() - Check if a region overlaps a given base/size
+ *
+ * @base:	base address of the memory region
+ * @size:	size of the memory region
+ * Returns: Region number of overlapping region, if found, else -ENOENT
+ */
 static int lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
 			       phys_size_t size)
 {
@@ -396,10 +403,10 @@ static int lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
 		phys_size_t asize = rgn->area[i].size;
 
 		if (lmb_addrs_overlap(base, size, abase, asize))
-			break;
+			return i;
 	}
 
-	return i < rgn->cnt ? i : -1;
+	return -ENOENT;
 }
 
 phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
-- 
2.42.0.283.g2d96d420d3-goog

