Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C85CDDE7D
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 15:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E238919C;
	Wed, 23 Oct 2024 17:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ObN5ukY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2CE892CF; Wed, 23 Oct 2024 17:22:19 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC87892CF
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9abe139088so153479566b.1
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729696930; x=1730301730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yi5zxJzn0EZ8cZJYy+huwu4x2mZWmwvGL6NSdSIM8xQ=;
 b=ObN5ukY8Y1rKtzxMclPt+M3gdP7ziqztrrjo3XbtyLy8TbDQySo1r8VEuEyGccLxYP
 yPoxAwhuJdrygi5cqVAO9oIaelRVqOPUEKbmGPZGfCzKShJY2hmhlt4fCtupu5Tu9Rty
 915wMqoqkZeSN+gep4tDry8URAd5VcdZyI/l6I0hp7vkMuJAYJdAMUWZ5gyqcsmDBpGt
 xOU2nlZ0lIkqN8diOkqCg11laCxI/t8CNDmFluaLa/oDKv1C6bbb/vcbUYkZ3dIyy/qj
 o5NycIKZ4rVwlSDqK1YJ8xrUt0eqr/KVC3DOpk4HxZbWflaa0uc90MHiBlvwMiuozq42
 fqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729696930; x=1730301730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yi5zxJzn0EZ8cZJYy+huwu4x2mZWmwvGL6NSdSIM8xQ=;
 b=YZy8btdF9PHAErsbxYI6HNHGS+7oXZa2ts9WOOcGJxnSCV3zQe8xUvTy1ZnnHz0ebc
 PRrOXfOH9d3+/Gw2lwVEaDIJ8DY+nrEaaXuD+Kuw+mF8aYfqhUrghOHqnnaar6UT0OFw
 CBqZoXLOGy/Udbt9fjcBt2POzeMk4wkWJARnBrvsoxG5pWPlsVwcjXjiEXsbJU79oN6Y
 DI0DQjAZ1u81V8BvCUNGn1VRUvAijB/V8vhwJBiSX7OQAdx6w9kFCkaIa4yw/B1DRVdW
 Lu3Jz+tUv8g/JPTbcD1XEI5Lvq0PZXTMkmnDXMy72RRYStj6sPR7Jadbia8l9LtjmajN
 9S3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWpwxM0Kyd97vZ6hLrD2IwHtUCBMD6d966BLJ4SuWYtqxWQMpUrw/Oi5NXcbZJ+48/50BNEz4=@lists.denx.de
X-Gm-Message-State: AOJu0YxPA3O+N3s8PNjegFSE4HBD5JHnPzhdD2/QTNg+zgT/Fns7gM8C
 /RkWpk2hHBblVt+BNALJl4OPrBeTRCDWEXbNFxVEc3byMeMXhdBhhaphQ3RAE4o=
X-Google-Smtp-Source: AGHT+IGRj3A6wbxxeFCEIolxcY6wSRTvE1E+NuypT7RXuswIynfxCIgfBS86Y2Atq+PDsgk9BlLE4w==
X-Received: by 2002:a17:907:2ce1:b0:a99:f29a:bc9a with SMTP id
 a640c23a62f3a-a9abf8491c3mr276344266b.7.1729696929568; 
 Wed, 23 Oct 2024 08:22:09 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912edfedsm489242766b.72.2024.10.23.08.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 08:22:09 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sughosh.ganu@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] lmb: Simplify lmb_should_notify usage
Date: Wed, 23 Oct 2024 18:22:01 +0300
Message-ID: <20241023152203.1218242-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023152203.1218242-1-ilias.apalodimas@linaro.org>
References: <20241023152203.1218242-1-ilias.apalodimas@linaro.org>
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

We never call lmb_map_update_notify() without checking the result of
lmb_should_notify(). Instead of running that function everytime fold it
in there and add the additional flags parameter

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lmb.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 8ce58fcb9224..69001ad57373 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -40,7 +40,7 @@ static bool lmb_should_notify(enum lmb_flags flags)
 
 static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
 						phys_size_t size,
-						u8 op)
+						u8 op, enum lmb_flags flags)
 {
 	u64 efi_addr;
 	u64 pages;
@@ -51,6 +51,9 @@ static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
 		return -1;
 	}
 
+	if (!lmb_should_notify(flags))
+		return 0;
+
 	efi_addr = (uintptr_t)map_sysmem(addr, 0);
 	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
 	efi_addr &= ~EFI_PAGE_MASK;
@@ -64,9 +67,9 @@ static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
 		log_err("%s: LMB Map notify failure %lu\n", __func__,
 			status & ~EFI_ERROR_MASK);
 		return -1;
-	} else {
-		return 0;
 	}
+
+	return 0;
 }
 
 static void lmb_print_region_flags(enum lmb_flags flags)
@@ -490,10 +493,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	if (ret)
 		return ret;
 
-	if (lmb_should_notify(LMB_NONE))
-		return lmb_map_update_notify(base, size, MAP_OP_ADD);
-
-	return 0;
+	return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
 }
 
 static long _lmb_free(phys_addr_t base, phys_size_t size)
@@ -566,10 +566,7 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
 	if (ret < 0)
 		return ret;
 
-	if (lmb_should_notify(flags))
-		return lmb_map_update_notify(base, size, MAP_OP_FREE);
-
-	return ret;
+	return lmb_map_update_notify(base, size, MAP_OP_FREE, flags);
 }
 
 long lmb_free(phys_addr_t base, phys_size_t size)
@@ -586,10 +583,7 @@ long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 	if (ret)
 		return ret;
 
-	if (lmb_should_notify(flags))
-		return lmb_map_update_notify(base, size, MAP_OP_RESERVE);
-
-	return ret;
+	return lmb_map_update_notify(base, size, MAP_OP_RESERVE, flags);
 }
 
 long lmb_reserve(phys_addr_t base, phys_size_t size)
@@ -621,7 +615,6 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 				    phys_addr_t max_addr, enum lmb_flags flags)
 {
-	u8 op;
 	int ret;
 	long i, rgn;
 	phys_addr_t base = 0;
@@ -654,13 +647,11 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 							 size, flags))
 					return 0;
 
-				if (lmb_should_notify(flags)) {
-					op = MAP_OP_RESERVE;
-					ret = lmb_map_update_notify(base, size,
-								    op);
-					if (ret)
-						return ret;
-				}
+				ret = lmb_map_update_notify(base, size,
+							    MAP_OP_RESERVE,
+							    flags);
+				if (ret)
+					return ret;
 
 				return base;
 			}
-- 
2.45.2

