Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190EA1091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E719484067;
	Thu, 19 Mar 2026 21:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XsnGjR2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858AA83E36; Thu, 19 Mar 2026 21:02:31 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB7ED83FC5
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67c11d3ecc5so705453eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950536; x=1774555336;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=chmZKruVf2a+X9bI0NSl0btHjTs4zHmL9IQiPvR0/0s=;
 b=XsnGjR2bvfVex64Gq+I2pLopwQAqdgNytCL3IbkeBaUh13OHOWBowh6BPeco9igeKc
 Hn+rfV49TrQypCcZIpa9PgZJn9pgYbCR//TzOLKTG7RpO7YDhuk4SXJPdjcQiHwdprdU
 J8X4u7kFYafwe98OmqNifi8ewVNnK0Ly6rpsz9azmyzDpt/aem3HLYC8pPlenFg5vp0O
 8S6Snp9x0oTZxey+aJ8IUvJ2JWcPBSBhb+GwENbbd6y30sTrPPfzI5eAcNXhYQuDNN9t
 kLs/jpueEbGNTNZLHZIXWxuNGFlqtJCaAV3scfkmlFO3OLKEILevRUha0/vGTHPuz0P/
 8HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950536; x=1774555336;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=chmZKruVf2a+X9bI0NSl0btHjTs4zHmL9IQiPvR0/0s=;
 b=nzUlNLqhoNv4q1lvW5LZNm568EazTnC6eJ0M+LWAbV1CjhWZtmtQGDwiaUy5O8ubBL
 hXUmbuLA+lbNrtNeH+vQiFIrkZ54Ej3x68tg6sWPH4S0TYyrKUx2+BzKYgvspIue8yiH
 +x4020daM73bZZQ3fHz7LP3iB3bUVAKTBJSfXQwVXsz7yXo5ZrBG+xwQcYXATWVKalYU
 IeSwSruXeb+shQbLSi4IA1IkpqjEILNXNzl6Y6e71R3ZJ0GspwQEY4NehUrXQxuQ99zd
 4/zsvjXU0hss+K/9QzMmW6dJWM+ft3SBx/AlbZ1VB8kqKPdR7AXlxNbGtJiEZQsg4tcI
 T8zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFaF4gajJORjY9oC8TbSbLk1d4ceJ9Oio3qJEvOVQJKOp3XmFQm92J6WLUPaeKg4w417+3vPQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4ZXkaF+rAxVXY2SvcUfLGIMBQCW0PKQiJIfoS4a7QcngC9ERi
 Kp2VGxzAtiULcpMmwcc5jF6HlL29ti+gIidHZ4kxMll0ovlDYPawAwTfCYCeTXKMUxE=
X-Gm-Gg: ATEYQzzAb7IZZMQjxbywOVAOOq+3IVOS1Idm0aKLPCRMal5z7KRyJu65vMLADH4l+hc
 087o1pGd36qwh8tjsF90D1/NbkxXtQDfo76NvJFNEtFeJU9UZLniLhJKwLmLfky4rgq2JRepswt
 K39kEWWntuANelfYPT3CrZTLJ6pEBjQdtv4Rf51Mh1dbd6WNOm8Ilqtf+ld+jRZQu/gqwc/DsE7
 dAVyHT2W+fY/e282DY67Cfn3QR8LmrQzeA/tijofl4lYsiOuHSDjHR6WbLI6FCOj8IYbB6KphjS
 RSmrRDd+hxajrTZTq3SKXp1hgVH+yxqVG6Wzmhwr4EjHt8DdKP6/P+ho5rlj9uP8W85qw1xe8/2
 r8gi6XKDymIiNDsRyDnOSua88JZqXg9cr0J1dM3yS2Fh3NtDvuZTONyBE95+K5Had4+UQz1ogpE
 cNvLatYcHjA0ya7Lx3WdpfJ5Xiw71s
X-Received: by 2002:a05:6820:1f06:b0:67b:b243:987c with SMTP id
 006d021491bc7-67c22ef0ee9mr487508eaf.4.1773950536633; 
 Thu, 19 Mar 2026 13:02:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:11 -0500
Subject: [PATCH 08/17] arm: mediatek: mt8188: fix gd->ram_top limit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-8-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2123; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2iUNHCSdPB4SLuMpqYpoIT6dAVetyaoT5p7ZsV8hq4U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFX71GRwnEkoAze/wGEDMrBbwl+TMp9JrFl4X
 Uynd/Cn+0yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxV+xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/APtUIAJYV7yd2UMPdlZhN3m/6UTjvNbC7ApeAsWyIoPh
 uViOi1ioa/Qbt4z6PsefbXgOMucBbvYg8N/u9FT73shrVC+wN/CH9+KMAw9PQmY1X/H9or60sgT
 HCIVQ8KfYayyuooBRimc0c3PUSv3L74x2VmNnkrZ0ELU5+lzRu/mRW9UG2u8ZK/zqd2BwnwR/U8
 gBx58bgDtw4Omy5jr7DWQs/A52hr3HPm9m0VRTgD7olFFElAiQfaqVyEoEX5ujUhkt2xKJ4dK1x
 TC0pHmN0UQui/OKXFJJ8+KnVpJbxJ6tGCltlKSF1xCz6MYplQrkL93+u9oCFsW0sFPlvkt+aW77
 xm9I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Fix the implementation of the gd->ram_top limit for mt8188.

The intention of the comment about MMC/DMA is correct, but the
implementation was wrong. gd->mon_len is set to the code size of U-Boot,
so trying to set it to limit gd->ram_top does not make sense.

Instead, there is already a get_effective_memsize() weak function that
we can override to implement the required limit on the usable memory
size. This is used to set gd->ram_top in setup_dest_addr().

The comment about the extra SZ_1M needing to be reserved is not correct
as U-Boot already takes care of this (with the actual size of U-Boot) in
the various board_f functions, so it is removed.

This fixes DMA not working on MMC on mt8188.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8188/init.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index fc80bc92bd8..a48a41f3b97 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -9,6 +9,7 @@
 #include <asm/global_data.h>
 #include <asm/system.h>
 #include <dm/uclass.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <wdt.h>
 
@@ -16,23 +17,16 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-	int ret;
-
-	ret = fdtdec_setup_mem_size_base();
-	if (ret)
-		return ret;
+	return fdtdec_setup_mem_size_base();
+}
 
+phys_size_t get_effective_memsize(void)
+{
 	/*
-	 * Limit gd->ram_top not exceeding SZ_4G.  Some periphals like mmc
-	 * requires DMA buffer allocated below SZ_4G.
-	 *
-	 * Note: SZ_1M is for adjusting gd->relocaddr, the reserved memory for
-	 * u-boot itself.
+	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
+	 * MMC requires DMA buffer allocated below SZ_4G.
 	 */
-	if (gd->ram_base + gd->ram_size >= SZ_4G)
-		gd->mon_len = (gd->ram_base + gd->ram_size + SZ_1M) - SZ_4G;
-
-	return 0;
+	return min(SZ_4G - gd->ram_base, gd->ram_size);
 }
 
 void reset_cpu(void)

-- 
2.43.0

