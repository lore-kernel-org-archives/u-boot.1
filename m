Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D89CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C4C8470E;
	Wed, 27 May 2026 14:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="ga7mYdfY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 132218341A; Wed, 27 May 2026 13:24:50 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1AB8803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 13:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-516cc5471bdso83551641cf.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779881087; x=1780485887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8p1kKbqFrG61cOGk4qCMAbgPLNJknz34LFSs9Xwv1Y=;
 b=ga7mYdfY6BcPGeHcVIAa6NKyv1RfEDSE3SzKoTuKmAOuyYHClyc4aGM7/V2X0jd5fq
 pE+og5xDxiOdcbYjAsAc00PqmgSQSXfNEl83qOT0NuiaejQulPkIxgaG2Lb4ZTxhmyJT
 7aXx8CqJTV2cB5MSDFUVFt405eVAuywjwndCx/qFmrQigLGsyAthR0lcKMbB526wBxN6
 elVCBt3ERryvbtLvBppDz18sP8340sg1tJo7TszBTfV24bfkUn9rg7tlrTAQv9xJgf9E
 G42A5c7b1wHrN4w7stRkG7pFekbQRFrQRNLbdKocrWWJT58mk9T4xkNeGqsSrHhp+yfv
 oedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779881087; x=1780485887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s8p1kKbqFrG61cOGk4qCMAbgPLNJknz34LFSs9Xwv1Y=;
 b=A/b6d5dr+BLSXWfPx6o+rNkfPttD9YFuIM2+vHrEehFP7a9N73WFfvUcNK/gQOiP7W
 2srM+KwLphp7BNNtPiI/eGns+caFOtn2U9MKkEhhBuq8i/nYGIHOyuLEOSYgaAJ4MqQk
 x1dI7C4aLcr8UPDXFY/SMtIRgE9e7NriQk9Koi9BDiFH61wBEMlGB19+4bVHm53o1HWX
 BzSRySOaOlwM2H2OwUugKS9MvSV3PZDMjPXrEDjhCpuSa8NBlVRznU7bWApvEJk7EEhv
 B8ok0zTqdMmj9LCAFCadSOuTyjHy4FVlbaau5szbGf3xYCDHCYcVxtCIXLdvb2vIrR4b
 pZxg==
X-Gm-Message-State: AOJu0Yyvp1y1hmqfwulBH8nTdElzbSxHLwgMlLAwhWhJvzlDU+IbuPQ+
 +xyTGoMzl74BelO3NPD4jcv83XJT5yAEmom7CVYPG2QrTOUfanJiUtPzkdBHKl3DNd4Memgvhes
 sL28ktRrPNw==
X-Gm-Gg: Acq92OG+FER9FZObPCKDWSyIGnZFSHf9n1Dat4g4tuib9JPw+MFfnRgK6thmD8lrpJ5
 b2upSurkaSsQ0gSXyjUwg9KwWr6I9qIstMd6jFSuwJp2hhymh1iLmxf0tL0KYOZC6cb2NLUYj2Z
 byE6h/WuGsApkIzTIzibIX0jcxYn2WmCroOv8apiICzzwHxchWp6YivjZyV+ToTR9fkta93YhEa
 6LZSLaWPUli5ODnAl8k6dH1vIYpd/pj288fFMD8b6Ucg8RjxjAGUnYTMO19hMSCl+S1BhhwX1Mo
 hj1LWWNyyrRTaBbho2wwnY2fRsnHqn7J3xNhbf6SigJFipeTEcr2LzCWRNsdyK4bZuaDYAMyEcv
 Bxkn0JbsimMHOS0w6RFN1eDX4MOPSYA5r8Dwtct+C4bvyEztj21lDX/8CksVMbiHhpHs5jzO7eo
 +cykn+IlTricHistQ9Cd9dUOQAO7h0q7SLOPUohezYLNCBAa4ZDGlX6c6d
X-Received: by 2002:a05:622a:144d:b0:516:e517:6dfd with SMTP id
 d75a77b69052e-516e5177023mr225053131cf.8.1779881086815; 
 Wed, 27 May 2026 04:24:46 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc66d22b8sm593456066b.55.2026.05.27.04.24.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 04:24:46 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v3] fdt_region: Check return value of
 fdt_get_property_by_offset() calls
Date: Wed, 27 May 2026 12:24:43 +0100
Message-ID: <20260527112443.13870-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526105449.48631-1-anton@binarly.io>
References: <20260526105449.48631-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:27 +0200
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

fdt_get_property_by_offset() returns NULL for FDT with version
less than 0x10. Callers in fdt_find_regions(),
fdt_add_alias_regions(), and fdt_next_region() dereference the
result without checking, leading to a NULL pointer dereference.

Add NULL checks before accessing the returned property pointer.
Also add a missing NULL check for fdt_string() in
fdt_add_alias_regions() and fdt_next_region().

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/fdt_region.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/boot/fdt_region.c b/boot/fdt_region.c
index 295ea08ac91..0a9d47bb2bd 100644
--- a/boot/fdt_region.c
+++ b/boot/fdt_region.c
@@ -69,6 +69,8 @@ int fdt_find_regions(const void *fdt, char * const inc[], int inc_count,
 			include = want >= 2;
 			stop_at = offset;
 			prop = fdt_get_property_by_offset(fdt, offset, NULL);
+			if (!prop)
+				return -FDT_ERR_BADSTRUCTURE;
 			str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
 			if (!str)
 				return -FDT_ERR_BADSTRUCTURE;
@@ -271,7 +273,11 @@ int fdt_add_alias_regions(const void *fdt, struct fdt_region *region, int count,
 		int target, next;
 
 		prop = fdt_get_property_by_offset(fdt, offset, NULL);
+		if (!prop)
+			return -FDT_ERR_BADSTRUCTURE;
 		name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+		if (!name)
+			return -FDT_ERR_BADSTRUCTURE;
 		target = fdt_path_offset(fdt, name);
 		if (!region_list_contains_offset(info, fdt, target))
 			continue;
@@ -520,7 +526,11 @@ int fdt_next_region(const void *fdt,
 		case FDT_PROP:
 			stop_at = offset;
 			prop = fdt_get_property_by_offset(fdt, offset, NULL);
+			if (!prop)
+				return -FDT_ERR_BADSTRUCTURE;
 			str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+			if (!str)
+				return -FDT_ERR_BADSTRUCTURE;
 			val = h_include(priv, fdt, last_node, FDT_IS_PROP, str,
 					    strlen(str) + 1);
 			if (val == -1) {
-- 
2.53.0

