Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0FECA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DD886768;
	Fri,  1 Sep 2023 03:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MldoKg4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591FF8676C; Fri,  1 Sep 2023 03:14:15 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8568F86722
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bcac140aaaso1194870a34.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530851; x=1694135651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHiynFLapN85/DIAGHY3edqe1foZSTaoFIQCtjFDwo0=;
 b=MldoKg4jAOMrCNd1dU/1AKA3mRl33w06TYkmzTjUWOigP7nRXIjtPqIHq0NEc+5wsV
 YR4mlT9A5BxqDpSVw0bBp9EhcRy0ShtrYqA5OMcDVPK3+ue6bZuM0zejRmT3djkB8JM4
 nx955o2VMy9yBk7NlQoo1kxov+GOPAfeDXxRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530851; x=1694135651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHiynFLapN85/DIAGHY3edqe1foZSTaoFIQCtjFDwo0=;
 b=gl0m1k3q2VK/rF69XfTnU1keaEu1/nGq7DMX1gxuREwBMH2zZLz3iP6c7aFq/F7FvZ
 mK2l+Y56Nw/lXLM3Y49qZSUtEAU/gWp6fb/X0In38LLbvh4P0VKfZIAe2/7CVZBotzR9
 FmcJg7qjZxa6s1pSrmR6XzgtZlsAExYzDKA2EYWZmUCObFLmRdvo/9EH9xWj+iGMC7xt
 Eq7twJdytVmcdtYaWR0nxDX8yYunr4yrp2IZhvNgNfOBOWRG3YEsnZXAxdWFMMzSG+oD
 w9VcNxCGI7Iqk2eJT5qiZd04hjW9SdxqttDe3LFyXi2/JF7PVHnsr6fkmdsBCiJoMPEc
 6GmQ==
X-Gm-Message-State: AOJu0YyNG/KO3b5ivAhJ4W2zIFqaKrfa9JmjxLDrHWDW/VV/9EoEm+d1
 zTmdupbUdy37Srm7aqY86ZZ7weGBC1oE+/ZcdVs=
X-Google-Smtp-Source: AGHT+IGtR94GC0/tW3KmKPh1bY6zlijx7aZPxU0uuza9PhIytgaEVJDQWGu08bie4alQDxjg1vRVsw==
X-Received: by 2002:a05:6870:560f:b0:1bf:787c:411b with SMTP id
 m15-20020a056870560f00b001bf787c411bmr1199978oao.10.1693530850948; 
 Thu, 31 Aug 2023 18:14:10 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v2 02/14] lmb: Rename interior piece to area
Date: Thu, 31 Aug 2023 19:13:40 -0600
Message-ID: <20230901011357.2482203-3-sjg@chromium.org>
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

The lmb data structures use the word 'region' to describe the region in
which the allocations happen, as well as the individual allocations in
that region. The interior structure is called lmb_property but is
described as a region.

This is quite confusing. One of the reviewers in v1 asked why we are using
a property to describe a region!

It seems better to adopt the word 'area' for the internal pieces, since an
area is smaller than a region.

As a first step to improve this, rename struct lmb_property to lmb_area.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/lmb.h  | 12 ++++++------
 test/lib/lmb.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 231b68b27d91..4b7664f22c1d 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -23,13 +23,13 @@ enum lmb_flags {
 };
 
 /**
- * struct lmb_property - Description of one region.
+ * struct lmb_area - Description of one region.
  *
  * @base:	Base address of the region.
  * @size:	Size of the region
  * @flags:	memory region attributes
  */
-struct lmb_property {
+struct lmb_area {
 	phys_addr_t base;
 	phys_size_t size;
 	enum lmb_flags flags;
@@ -64,9 +64,9 @@ struct lmb_region {
 	unsigned long cnt;
 	unsigned long max;
 #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
+	struct lmb_area region[CONFIG_LMB_MAX_REGIONS];
 #else
-	struct lmb_property *region;
+	struct lmb_area *region;
 #endif
 };
 
@@ -87,8 +87,8 @@ struct lmb {
 	struct lmb_region memory;
 	struct lmb_region reserved;
 #if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
-	struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
+	struct lmb_area memory_regions[CONFIG_LMB_MEMORY_REGIONS];
+	struct lmb_area reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
 #endif
 };
 
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 162887503588..59b140fde4ce 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -12,7 +12,7 @@
 #include <test/test.h>
 #include <test/ut.h>
 
-static inline bool lmb_is_nomap(struct lmb_property *m)
+static inline bool lmb_is_nomap(struct lmb_area *m)
 {
 	return m->flags & LMB_NOMAP;
 }
-- 
2.42.0.283.g2d96d420d3-goog

