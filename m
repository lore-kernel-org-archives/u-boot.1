Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FE1CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94698671C;
	Fri,  1 Sep 2023 03:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SNSnZDtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E62886722; Fri,  1 Sep 2023 03:14:25 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC7D86867
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34cc8e8cbd4so5003575ab.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530859; x=1694135659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RUEzp3as2ymuYLniTz4ehtj0/XBkD/NkNtWen8lzsg=;
 b=SNSnZDtKwazKB7webHvstBrYlkTRCFVh6CUDwwOdwNVLRKF+SXJPylXEsKZGJBcfxH
 Or6Up0LloxQCI6XuVqao9TQBHdwmKLh/7fnvymeCfbAgkINe5oEsQUE0PIGRtwEx+xIf
 r0l48am/VnuBaTdsSRRqRxqBO6kODeHN72Ql0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530859; x=1694135659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RUEzp3as2ymuYLniTz4ehtj0/XBkD/NkNtWen8lzsg=;
 b=SeafMYYwEFb9WGbC9eA370g6+6uclGI6jujH1BiEuy1w72zGEwbvRaLrsLsgFX0FNs
 d7NJUAmYh9V3g3X+QKSBenzTfvCCItKCOBn+IUKC0AoEUCNk0+D6KgKNghlnBK9z0EUj
 dATolGK0qMwAxeNq+aiwIBqaBuWBjc1I3eVhKiJ8RgPN18xz5Cg8UFQ0vfBt1bHW63Cn
 pXB+vBcoDyQYdP6vtGH8uMe8e2F4gzg0/v0OST8oegpk3j33UG/d96+5oj8Mlg6HxwLV
 FgLliYQRqEv5mRHKSU+ybXU8ekBuw9/NCT6tTkbcKr6DmMIPhQOyOjstj/VUxywEiDYq
 uTUw==
X-Gm-Message-State: AOJu0Yy4o7cLio3zsc3ynmxak4Ef4euWbrIHiv2DVul1L/g9ERZJQenS
 IRIDxGBOdDCGmMhya6O5EQK/98pw1OjWU8qMmCA=
X-Google-Smtp-Source: AGHT+IFRLIN7pFkBnydIrH66kVY+wLXqRzTHxAjNNGYI42gKy7n44ZffHNV/y9riSz/LBnW0zT6BZQ==
X-Received: by 2002:a05:6e02:13f0:b0:34a:c4ae:1937 with SMTP id
 w16-20020a056e0213f000b0034ac4ae1937mr1190281ilj.13.1693530859036; 
 Thu, 31 Aug 2023 18:14:19 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 11/14] lmb: Change functions returning long to return int
Date: Thu, 31 Aug 2023 19:13:49 -0600
Message-ID: <20230901011357.2482203-12-sjg@chromium.org>
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

It makes no sense to return long when an int is plenty to provide an error
code and a region position. It is just confusing.

Update the return-value types to keep to this rule.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/lmb.h | 10 +++++-----
 lib/lmb.c     | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 6f91df43d5d5..c81716b3f1d1 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -96,8 +96,8 @@ void lmb_init(struct lmb *lmb);
 void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob);
 void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 				phys_size_t size, void *fdt_blob);
-long lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size);
-long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size);
+int lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size);
+int lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size);
 /**
  * lmb_reserve_flags - Reserve one area with a specific flags bitfield.
  *
@@ -107,8 +107,8 @@ long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size);
  * @flags:	flags for the memory area
  * Return:	0 if OK, > 0 for coalesced area or a negative error code.
  */
-long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base,
-		       phys_size_t size, enum lmb_flags flags);
+int lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
+		      enum lmb_flags flags);
 phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align);
 phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 			   phys_addr_t max_addr);
@@ -141,7 +141,7 @@ int lmb_is_reserved(struct lmb *lmb, phys_addr_t addr);
  */
 int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags);
 
-long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size);
+int lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size);
 
 void lmb_dump_all(struct lmb *lmb);
 void lmb_dump_all_force(struct lmb *lmb);
diff --git a/lib/lmb.c b/lib/lmb.c
index 579f98baef87..0c6244ca47f8 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -315,14 +315,14 @@ static int lmb_add_area(struct lmb_region *rgn, phys_addr_t base,
 }
 
 /* This routine may be called with relocation disabled. */
-long lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+int lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
 	struct lmb_region *_rgn = &(lmb->memory);
 
 	return lmb_add_area(_rgn, base, size);
 }
 
-long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+int lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
 	struct lmb_region *rgn = &(lmb->reserved);
 	phys_addr_t rgnbegin, rgnend;
@@ -373,15 +373,15 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 				    rgn->area[i].flags);
 }
 
-long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
-		       enum lmb_flags flags)
+int lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
+		      enum lmb_flags flags)
 {
 	struct lmb_region *_rgn = &(lmb->reserved);
 
 	return lmb_add_area_flags(_rgn, base, size, flags);
 }
 
-long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+int lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
 	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
 }
-- 
2.42.0.283.g2d96d420d3-goog

