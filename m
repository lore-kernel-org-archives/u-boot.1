Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C288ACA0FE2
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71635868BB;
	Fri,  1 Sep 2023 03:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="es3LTcTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7347E80750; Fri,  1 Sep 2023 03:14:23 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0FE86759
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7928ba24936so53281439f.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530858; x=1694135658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS0c7L5jBcf7Vye9Z45qj29wRdY+DMX/j7v7/jRT5z0=;
 b=es3LTcTDvhK3Z4IgFQk+csq583d+FrnmC8LnE5dYr0GK4itTR6QluvhQPo3Kue2ZFX
 rRyn2/n9qycDh28gI9LSULg/39aDEb25Ou9VCZAW9RWrOXhIBb6vVdmYAbVzyjfMQ7VE
 hGYGc7CyaaQFlCRgQ/63VNWoYv5NtVnR38aCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530858; x=1694135658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eS0c7L5jBcf7Vye9Z45qj29wRdY+DMX/j7v7/jRT5z0=;
 b=Qk0HJZYaReEOPkmEE2ls1pF3eAFP8h+GUAJZU10qkdqEBkN0x6y9YdflB25w7zx6qp
 hTKdWK7/lmxWohmyj6AI+AOXAIaBBJpSmzg7oSGfLNcjuyO80/Smnk+XqRCyqUTYk3yq
 w0+txjSFWrQGLtdaKFCA32Don2dE0bDjmX+fntHYh4PjbwxrE/q9MjHSUD7kGpsOEsx0
 fvRuKu1XyMoLtt6hIan5qikZ23y31s91wYzqYbZ1gL2K2VVBIIDkWo/YcJ1fEVaY3BHw
 NFxVv3hzlOuiYgpbw0HzI6hyfvKIpK/31acXAv5aZNQwwqtGv2trmYqn4Og/98kDGbu6
 YsUw==
X-Gm-Message-State: AOJu0Yx7fkF4GMrIzWnWQA8sAPOKcsVDi5eZqBk+vtk5VcaoghhvJQBI
 XVWZMELajO/HqUvfz1oFKRK1W06p34vdcdVgwyU=
X-Google-Smtp-Source: AGHT+IGM+3C9e7pHA2f1DosX/PRXeMJzIG9VsF0gTbKM4c0zyBouqOuh/egYcl9hncCa1Nb39IRhOw==
X-Received: by 2002:a5d:934c:0:b0:795:13ea:477a with SMTP id
 i12-20020a5d934c000000b0079513ea477amr970457ioo.8.1693530858214; 
 Thu, 31 Aug 2023 18:14:18 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 10/14] lmb: Avoid long for loop counters and function
 returns
Date: Thu, 31 Aug 2023 19:13:48 -0600
Message-ID: <20230901011357.2482203-11-sjg@chromium.org>
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

Use int for loop counters since it is more common. Do the same with the
return value of some internal functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/lmb.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 862b1cd04953..579f98baef87 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -53,8 +53,8 @@ void lmb_dump_all(struct lmb *lmb)
 #endif
 }
 
-static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
-			      phys_addr_t base2, phys_size_t size2)
+static int lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
+			     phys_addr_t base2, phys_size_t size2)
 {
 	const phys_addr_t base1_end = base1 + size1 - 1;
 	const phys_addr_t base2_end = base2 + size2 - 1;
@@ -62,8 +62,8 @@ static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
 	return base1 <= base2_end && base2 <= base1_end;
 }
 
-static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
-			       phys_addr_t base2, phys_size_t size2)
+static int lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
+			      phys_addr_t base2, phys_size_t size2)
 {
 	if (base2 == base1 + size1)
 		return 1;
@@ -73,7 +73,7 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 	return 0;
 }
 
-static long lmb_areas_adjacent(struct lmb_region *rgn, ulong a1, ulong a2)
+static int lmb_areas_adjacent(struct lmb_region *rgn, ulong a1, ulong a2)
 {
 	phys_addr_t base1 = rgn->area[a1].base;
 	phys_size_t size1 = rgn->area[a1].size;
@@ -85,7 +85,7 @@ static long lmb_areas_adjacent(struct lmb_region *rgn, ulong a1, ulong a2)
 
 static void lmb_remove_area(struct lmb_region *rgn, unsigned long area)
 {
-	unsigned long i;
+	uint i;
 
 	for (i = area; i < rgn->cnt - 1; i++)
 		rgn->area[i] = rgn->area[i + 1];
@@ -221,11 +221,11 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 }
 
 /* This routine called with relocation disabled. */
-static long lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
-			       phys_size_t size, enum lmb_flags flags)
+static int lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
+			      phys_size_t size, enum lmb_flags flags)
 {
-	unsigned long coalesced = 0;
-	long adjacent, i;
+	uint coalesced = 0;
+	int adjacent, i;
 
 	if (rgn->cnt == 0) {
 		rgn->area[0].base = base;
@@ -308,8 +308,8 @@ static long lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
 	return 0;
 }
 
-static long lmb_add_area(struct lmb_region *rgn, phys_addr_t base,
-			 phys_size_t size)
+static int lmb_add_area(struct lmb_region *rgn, phys_addr_t base,
+			phys_size_t size)
 {
 	return lmb_add_area_flags(rgn, base, size, LMB_NONE);
 }
@@ -386,10 +386,10 @@ long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
 }
 
-static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
-				phys_size_t size)
+static int lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
+			       phys_size_t size)
 {
-	unsigned long i;
+	uint i;
 
 	for (i = 0; i < rgn->cnt; i++) {
 		phys_addr_t abase = rgn->area[i].base;
@@ -429,7 +429,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 			     phys_addr_t max_addr)
 {
-	long i, area;
+	int i, area;
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
 
-- 
2.42.0.283.g2d96d420d3-goog

