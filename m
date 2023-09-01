Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2C4CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91FDD867E2;
	Fri,  1 Sep 2023 03:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a7scCwDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B738688D; Fri,  1 Sep 2023 03:14:20 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A740867C7
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so54957339f.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530855; x=1694135655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efcZnLur/rZfDYWEFJrlS5JhWdiggQbgd++YOjQz/+Y=;
 b=a7scCwDxj9eZfeTb5OCRbvFi8y5Prb+hVc8br6iuLzhACPy2lweBLPUZrA01J68kfE
 0YRc6CJ3eUOlg+eIW6aH0nXwfY1nZdIObgqTiV+M1i/SbfIQG/9ZPYns/42pvc10faKg
 woQcF+63NFNoWyfZIagpS0PlqKkfnBf/dIXK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530855; x=1694135655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efcZnLur/rZfDYWEFJrlS5JhWdiggQbgd++YOjQz/+Y=;
 b=ZFLDHECxXj4JYE5bz+5D5exV18/Ffl1ZDei8sbPrBAGSo99TV1TJxPvlKOZYgRx+bC
 ML3szq9TIXiCzQnT/+dcuRSBZOb+4HQ8R5pUJiQ9QGkfnolM4K8OuKagmS8+dtW8dPHC
 2WHDCXS4weHNYYvpAwdtI39sxNRmiabvJnS8DdAC0Iwg5lOyIJbVITBEKcdUi0PmUWiK
 Fz6x9ZBQNeOKwX2+e6+paOzDVTcaOK+i3R2UFoBVIJzOUdlxNqCIjUevrJUxhiaBLlPB
 D8lQm3Ylko5R8haJwU1SbdDqWPDyqHC78AB2SonXD7s4u5NtyliCFksogw+Jynul7kYm
 AdaQ==
X-Gm-Message-State: AOJu0YyP2mqYYWqJfrTdzhHu122txVE8VeA/uBqer2cH38WvLCLkcCcV
 0SLGCyG6KSq5bBBtwpritqCX8DcePRFUV+4RQsI=
X-Google-Smtp-Source: AGHT+IE/AAh5TryZP5VhKWmLNraYeDdGpKf37VGMVcHGhc/SVrisjwNRqW3NFyJ8FSqR/+1UsZmtcQ==
X-Received: by 2002:a05:6e02:d0f:b0:34c:e2c5:bf6c with SMTP id
 g15-20020a056e020d0f00b0034ce2c5bf6cmr1118668ilj.28.1693530855721; 
 Thu, 31 Aug 2023 18:14:15 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v2 07/14] lmb: Update use of region in the header file
Date: Thu, 31 Aug 2023 19:13:45 -0600
Message-ID: <20230901011357.2482203-8-sjg@chromium.org>
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

Tidy up places in the header file where it says region but now means area.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to update use of region in the header file

 include/lmb.h | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 3cf23d2f2346..6f91df43d5d5 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -13,7 +13,7 @@
  */
 
 /**
- * enum lmb_flags - definition of memory region attributes
+ * enum lmb_flags - definition of memory area attributes
  * @LMB_NONE: no special request
  * @LMB_NOMAP: don't add to mmu configuration
  */
@@ -40,24 +40,24 @@ struct lmb_area {
  * all the #if test are done with CONFIG_LMB_USE_MAX_AREAS (boolean)
  *
  * case 1. CONFIG_LMB_USE_MAX_AREAS is defined (legacy mode)
- *         => CONFIG_LMB_MAX_AREAS is used to configure the region size,
- *         directly in the array lmb_region.region[], with the same
- *         configuration for memory and reserved regions.
+ *         => CONFIG_LMB_MAX_AREAS is used to configure the maximum number of
+ *	   areas, directly in the array lmb_region.area[], with the same
+ *         configuration for memory and reserved areas.
  *
- * case 2. CONFIG_LMB_USE_MAX_AREAS is not defined, the size of each
- *         region is configurated *independently* with
- *         => CONFIG_LMB_MEMORY_AREAS: struct lmb.memory_regions
- *         => CONFIG_LMB_RESERVED_AREAS: struct lmb.reserved_regions
- *         lmb_region.region is only a pointer to the correct buffer,
+ * case 2. CONFIG_LMB_USE_MAX_AREAS is not defined, the maximum number of
+ *         areas is configured *independently* with
+ *         => CONFIG_LMB_MEMORY_AREAS: struct lmb.memory_areas
+ *         => CONFIG_LMB_RESERVED_AREAS: struct lmb.reserved_areas
+ *         lmb_region.area is only a pointer to the correct buffer,
  *         initialized in lmb_init(). This configuration is useful to manage
- *         more reserved memory regions with CONFIG_LMB_RESERVED_AREAS.
+ *         more reserved memory areas with CONFIG_LMB_RESERVED_AREAS.
  */
 
 /**
- * struct lmb_region - Description of a set of region.
+ * struct lmb_region - Description of a set of areas.
  *
- * @cnt: Number of regions.
- * @max: Size of the region array, max value of cnt.
+ * @cnt: Number of areas
+ * @max: Size of the area array, max value of cnt
  * @area: Array of the areas within the region
  */
 struct lmb_region {
@@ -99,13 +99,13 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 long lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size);
 long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size);
 /**
- * lmb_reserve_flags - Reserve one region with a specific flags bitfield.
+ * lmb_reserve_flags - Reserve one area with a specific flags bitfield.
  *
  * @lmb:	the logical memory block struct
- * @base:	base address of the memory region
- * @size:	size of the memory region
- * @flags:	flags for the memory region
- * Return:	0 if OK, > 0 for coalesced region or a negative error code.
+ * @base:	base address of the memory area
+ * @size:	size of the memory area
+ * @flags:	flags for the memory area
+ * Return:	0 if OK, > 0 for coalesced area or a negative error code.
  */
 long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base,
 		       phys_size_t size, enum lmb_flags flags);
@@ -118,9 +118,9 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
 
 /**
- * lmb_is_reserved() - test if address is in reserved region
+ * lmb_is_reserved() - test if address is in reserved area
  *
- * The function checks if a reserved region comprising @addr exists.
+ * The function checks if a reserved area comprising @addr exists.
  *
  * @lmb:	the logical memory block struct
  * @addr:	address to be tested
@@ -129,9 +129,9 @@ phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
 int lmb_is_reserved(struct lmb *lmb, phys_addr_t addr);
 
 /**
- * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
+ * lmb_is_reserved_flags() - test if address is in reserved area with flag bits set
  *
- * The function checks if a reserved region comprising @addr exists which has
+ * The function checks if a reserved area comprising @addr exists which has
  * all flag bits set which are set in @flags.
  *
  * @lmb:	the logical memory block struct
-- 
2.42.0.283.g2d96d420d3-goog

