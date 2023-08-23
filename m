Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34E3EE49B2
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CBDF864D2;
	Wed, 23 Aug 2023 15:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S6NLE9ke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB2A864C3; Wed, 23 Aug 2023 15:42:23 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA23864C7
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79093c0c68bso198566139f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692798140; x=1693402940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqDsr1EHWyD+Q41YXZV58/N/BT2vxEPmh4f1CNlNs04=;
 b=S6NLE9keEhLi2c2Xb9ic69Vd4cYsE6hpo9PB5erFXbbCFAB8v1kPMXRaQe9Q63JUiY
 20fKjiqyNSaEpbVp/S53FbPkaTo/q671dVso5LiaVJPOtg7PLKV3S7qjGlGCKS64wYzW
 pB054KhJfcRrTv2V9fx3SCmmsCAY1ML8rMbW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692798140; x=1693402940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqDsr1EHWyD+Q41YXZV58/N/BT2vxEPmh4f1CNlNs04=;
 b=IRv1RY1/MCPtiheO4JA7vcUSua5OvEmuUtAeHb8+8D9r8r+OZiXKumyf2cxNuOBPpP
 p1Hm7kxXSmCrjQARkfaxCMBY9wTnGNBJfrilhSPNWIjWL4s8Tb5yOBFvKCyPBZX6NIKm
 GQ+fk1gKBZIzNxpB/XhE54VTcPACtQdVZHuqH9orckp4yCYrgodrnV03U2vGPM3/9g3b
 Feg4mBwKfFYEEYRCNhl6sh/clFtzR8CRpqqtTQ/y4HkJWwqRLNKOW/EPc+p9qwF3E5dD
 P7qVNMDeMrByDkxrmEam/5z6pLfT6HbSWxYQ91KkGSP2uiZgAUjsKuhfbgMOMcHumlKd
 eaQA==
X-Gm-Message-State: AOJu0Yyvxf05GXAfZrhOrGgvOeJ64H7YObPZ1TSBzW5at+LjqGmaPp1G
 m46sf84Lf+u15h/PHro25/SFs6acWKXh45h2OB4=
X-Google-Smtp-Source: AGHT+IFtCiMfqNHqu9WcC195jkp4leqLVpveE0kyl6hAjgwme2W9WJ91bEVj42sa2csJRVnUyLpKgQ==
X-Received: by 2002:a6b:d003:0:b0:787:1990:d2ec with SMTP id
 x3-20020a6bd003000000b007871990d2ecmr2820238ioa.12.1692798140187; 
 Wed, 23 Aug 2023 06:42:20 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a02cdcd000000b0042b4f9ddecasm3800233jap.85.2023.08.23.06.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 06:42:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 4/7] lmb: Change functions returning long to return int
Date: Wed, 23 Aug 2023 07:42:00 -0600
Message-ID: <20230823134209.1450567-5-sjg@chromium.org>
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

It makes no sense to return long when an int is plenty to provide an error
code and a region position. It is just confusing.

Update the return-value types to keep to this rule.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/lmb.h | 10 +++++-----
 lib/lmb.c     | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 231b68b27d91..79a3a12155b4 100644
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
  * lmb_reserve_flags - Reserve one region with a specific flags bitfield.
  *
@@ -107,8 +107,8 @@ long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size);
  * @flags:	flags for the memory region
  * Return:	0 if OK, > 0 for coalesced region or a negative error code.
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
index 2f7b9f7f15fb..bf30e0dc90b2 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -316,14 +316,14 @@ static int lmb_add_region(struct lmb_region *rgn, phys_addr_t base,
 }
 
 /* This routine may be called with relocation disabled. */
-long lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+int lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
 	struct lmb_region *_rgn = &(lmb->memory);
 
 	return lmb_add_region(_rgn, base, size);
 }
 
-long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+int lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
 	struct lmb_region *rgn = &(lmb->reserved);
 	phys_addr_t rgnbegin, rgnend;
@@ -374,15 +374,15 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 				    rgn->region[i].flags);
 }
 
-long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
-		       enum lmb_flags flags)
+int lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
+		      enum lmb_flags flags)
 {
 	struct lmb_region *_rgn = &(lmb->reserved);
 
 	return lmb_add_region_flags(_rgn, base, size, flags);
 }
 
-long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+int lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
 	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
 }
-- 
2.42.0.rc1.204.g551eb34607-goog

