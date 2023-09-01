Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A88BCA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B42058680E;
	Fri,  1 Sep 2023 03:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FBucMvXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF56786759; Fri,  1 Sep 2023 03:14:16 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2198D86768
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bf298ef1f5so1195061a34.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530852; x=1694135652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jsYIhcDLlURsZx+urJQuIOgYRYh+kjVkgtk/hGjlz8=;
 b=FBucMvXMbcScojLP2suxNkxKIvC86eZ+kCS1y0TZF17q1OjVWT1DWDtJNP5pbQMIi5
 UYg080n+ONd+HJ6tare1lMptljd32GBqx8WSgDr1hJKztA0FT3iRjA2i8rI4sdX8/SY+
 vufuoyDOmTQYs68kcj2I+OdQkFv09a6T/eW3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530852; x=1694135652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jsYIhcDLlURsZx+urJQuIOgYRYh+kjVkgtk/hGjlz8=;
 b=S458x5gXZaszO65QoNCy+LZnOprA3btoDY1VFsHa8f3rBKjZqxM/9WfM+nUdX1Q8R4
 iB1cX4HPGcqEBen2oXpPZmmAHFEoQ10uKKGhyZDTxxXBiair2b8lPAtS9UyganLbc6T0
 rKbIqETx+LVL7K2A7slox+QY34YFqY/GWhdkFdiPkrhkRY3T5C7Y1eNWjWm5lj3Dk1oq
 FYcg77LQIqqonxddSAMiH+je/1KIXMmS5zodRU2HTJY+/Peknlqc4pD7h+VCwlESo1mK
 cJ9NrT/h48KkFz8++usbkTd6kogTAne7+Wdvw8H1UapiLryY74mEGImKLQ6AsBx0ZANm
 LO+Q==
X-Gm-Message-State: AOJu0YzSLmAv6a6vTlYSsW6jicNfWXmWDrck6+UHdKbwCbeW2qkETOZK
 9PzgacAIcOE0vnlSJFyfytrH736SsjQsBGXOwnQ=
X-Google-Smtp-Source: AGHT+IEalU0j0R6gOtR5dobRDgnY62uQkqtdiethwErCGOLDAObN318goS067G+uyixJuiPoo13UJg==
X-Received: by 2002:a05:6870:171a:b0:1c8:d334:a6f5 with SMTP id
 h26-20020a056870171a00b001c8d334a6f5mr1274704oae.7.1693530852686; 
 Thu, 31 Aug 2023 18:14:12 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 04/14] lmb: Rename memory/reserved_regions to area
Date: Thu, 31 Aug 2023 19:13:42 -0600
Message-ID: <20230901011357.2482203-5-sjg@chromium.org>
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

Rename these two fields since they are areas, not regions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to rename memory/reserved_regions to area

 include/lmb.h | 8 ++++----
 lib/lmb.c     | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 9d4a05670c23..92332eb63069 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -80,15 +80,15 @@ struct lmb_region {
  *
  * @memory: Description of memory regions.
  * @reserved: Description of reserved regions.
- * @memory_regions: Array of the memory regions (statically allocated)
- * @reserved_regions: Array of the reserved regions (statically allocated)
+ * @memory_areas: Array of the memory areas (statically allocated)
+ * @reserved_areas: Array of the reserved areas (statically allocated)
  */
 struct lmb {
 	struct lmb_region memory;
 	struct lmb_region reserved;
 #if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_area memory_regions[CONFIG_LMB_MEMORY_REGIONS];
-	struct lmb_area reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
+	struct lmb_area memory_areas[CONFIG_LMB_MEMORY_REGIONS];
+	struct lmb_area reserved_areas[CONFIG_LMB_RESERVED_REGIONS];
 #endif
 };
 
diff --git a/lib/lmb.c b/lib/lmb.c
index 9336792df8ba..2669868f0dda 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -113,8 +113,8 @@ void lmb_init(struct lmb *lmb)
 #else
 	lmb->memory.max = CONFIG_LMB_MEMORY_REGIONS;
 	lmb->reserved.max = CONFIG_LMB_RESERVED_REGIONS;
-	lmb->memory.region = lmb->memory_regions;
-	lmb->reserved.region = lmb->reserved_regions;
+	lmb->memory.area = lmb->memory_areas;
+	lmb->reserved.area = lmb->reserved_areas;
 #endif
 	lmb->memory.cnt = 0;
 	lmb->reserved.cnt = 0;
-- 
2.42.0.283.g2d96d420d3-goog

