Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C27EC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3E087BDB;
	Fri, 27 Oct 2023 02:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HceAuYzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B3187BC6; Fri, 27 Oct 2023 02:24:53 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9897C87BCE
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso1406745b3a.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698366288; x=1698971088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mVbYwdzonaQngpYG7INelm+PlUcbLIMzI8WRwuBhiw=;
 b=HceAuYzluKEs/Id+K3wNt9UMlMhckd2yZ/bmLgj1a93acNHOLXh2t95FC2+djVdabd
 p3v64L3BpkMsmDICtfVsC/lv63CTojQWnmnCzFeFxhDK3j6R/gMbSVofMw/9+cB5lGJ8
 rja2qW0HrhNJ4BXl5SSOJzC3/1LgzWUP+vZJ2Jt9wQIRg2jAfpolVm1zbNT4H03FFFQC
 oZxjMKA02uc2mPzy+H2wRK5YHyR76EK07abVjodXMGFCeBn2bfxNdvYtxabdOxsjEqfs
 AOdobyHFTwvwtNrAlNFmGIUAWr9hN3WyhgImVrFpCwM3dTyCO4XKpdydtBEvUlDKavr3
 5CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698366288; x=1698971088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mVbYwdzonaQngpYG7INelm+PlUcbLIMzI8WRwuBhiw=;
 b=J96XByYzh3Om6U9mMFyScMbafS9f3XF0W99hPkvG7401jvMNz+INZl2e+33acAfEpa
 G/4ntxN7yzxy1vcDp+joOwW5bhOJg654iDw55+v5dmHMeIW4TJQw/8BVX04sOgoloo30
 XG1ivWXAG9K9CfnLatjjfIZMYEZ24TqTwNODpR6g7yi0ot/lyKFpbWiYaPpF4uL7i20A
 34r988VjF8UTUWBVxDeVoOdUBMuRNbsqbylHQHcqKxTOZo9WYWmiYMvEilWezXW9Kakm
 JeJN2Q6tq6OASO1Y83Rsxit8fO3S4WBoZ5We5ccuHSoQbs6TVfLYFjelHXFOT/I200EN
 qqqg==
X-Gm-Message-State: AOJu0YyjCwELn1y0O1LyF+6jI6NADWXcfYArerRo8unXXhfomHgPnGnV
 XnHkXKwjpzyQnDbRzfoN6K+N7YKoAMMLrw==
X-Google-Smtp-Source: AGHT+IGP/e21Vn2ggWqG5VlwSETCnwYajfSlNTY2kb0xLNXP+zF9HtQ5PDpRs930z6O6IuQv0EzgWw==
X-Received: by 2002:a05:6a20:be9a:b0:15a:f4e:620e with SMTP id
 gf26-20020a056a20be9a00b0015a0f4e620emr1108862pzb.59.1698366288627; 
 Thu, 26 Oct 2023 17:24:48 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:b6a2:eace:f54:1956])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a031600b0027476c68cc3sm167606pje.22.2023.10.26.17.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:24:48 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Simon Glass <sjg@chromium.org>, Ye Li <ye.li@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>
Subject: [PATCH 3/3] Revert "arm64: Use FEAT_HAFDBS to track dirty pages when
 available"
Date: Fri, 27 Oct 2023 13:23:54 +1300
Message-ID: <20231027002409.430285-4-judge.packham@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027002409.430285-1-judge.packham@gmail.com>
References: <20231027002409.430285-1-judge.packham@gmail.com>
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

This reverts commit 6cdf6b7a340db4ddd008516181de7e08e3f8c213. This is
part of a series trying to make use of the arm64 hardware features for
tracking dirty pages. Unfortunately this series causes problems for the
AC5/AC5X SoCs. Having exhausted other options the consensus seems to be
reverting this series is the best course of action.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/cpu/armv8/cache_v8.c      | 16 +---------------
 arch/arm/include/asm/armv8/mmu.h   | 14 ++++----------
 arch/arm/include/asm/global_data.h |  1 -
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 4760064ee18f..697334086fdc 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -93,8 +93,6 @@ u64 get_tcr(u64 *pips, u64 *pva_bits)
 
 	if (el == 1) {
 		tcr = TCR_EL1_RSVD | (ips << 32) | TCR_EPD1_DISABLE;
-		if (gd->arch.has_hafdbs)
-			tcr |= TCR_HA | TCR_HD;
 	} else if (el == 2) {
 		tcr = TCR_EL2_RSVD | (ips << 16);
 	} else {
@@ -202,9 +200,6 @@ static void __cmo_on_leaves(void (*cmo_fn)(unsigned long, unsigned long),
 		    attrs != PTE_BLOCK_MEMTYPE(MT_NORMAL_NC))
 			continue;
 
-		if (gd->arch.has_hafdbs && (pte & (PTE_RDONLY | PTE_DBM)) != PTE_DBM)
-			continue;
-
 		end = va + BIT(level2shift(level)) - 1;
 
 		/* No intersection with RAM? */
@@ -353,9 +348,6 @@ static void add_map(struct mm_region *map)
 	if (va_bits < 39)
 		level = 1;
 
-	if (gd->arch.has_hafdbs)
-		attrs |= PTE_DBM | PTE_RDONLY;
-
 	map_range(map->virt, map->phys, map->size, level,
 		  (u64 *)gd->arch.tlb_addr, attrs);
 }
@@ -407,13 +399,7 @@ static int count_ranges(void)
 __weak u64 get_page_table_size(void)
 {
 	u64 one_pt = MAX_PTE_ENTRIES * sizeof(u64);
-	u64 size, mmfr1;
-
-	asm volatile("mrs %0, id_aa64mmfr1_el1" : "=r" (mmfr1));
-	if ((mmfr1 & 0xf) == 2)
-		gd->arch.has_hafdbs = true;
-	else
-		gd->arch.has_hafdbs = false;
+	u64 size;
 
 	/* Account for all page tables we would need to cover our memory map */
 	size = one_pt * count_ranges();
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 98a27db3166b..9f58cedb650c 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -49,13 +49,10 @@
 #define PTE_TYPE_BLOCK		(1 << 0)
 #define PTE_TYPE_VALID		(1 << 0)
 
-#define PTE_RDONLY		BIT(7)
-#define PTE_DBM			BIT(51)
-
-#define PTE_TABLE_PXN		BIT(59)
-#define PTE_TABLE_XN		BIT(60)
-#define PTE_TABLE_AP		BIT(61)
-#define PTE_TABLE_NS		BIT(63)
+#define PTE_TABLE_PXN		(1UL << 59)
+#define PTE_TABLE_XN		(1UL << 60)
+#define PTE_TABLE_AP		(1UL << 61)
+#define PTE_TABLE_NS		(1UL << 63)
 
 /*
  * Block
@@ -102,9 +99,6 @@
 #define TCR_TG0_16K		(2 << 14)
 #define TCR_EPD1_DISABLE	(1 << 23)
 
-#define TCR_HA			BIT(39)
-#define TCR_HD			BIT(40)
-
 #define TCR_EL1_RSVD		(1U << 31)
 #define TCR_EL2_RSVD		(1U << 31 | 1 << 23)
 #define TCR_EL3_RSVD		(1U << 31 | 1 << 23)
diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 1325b0644248..75bd9d56f893 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -52,7 +52,6 @@ struct arch_global_data {
 #if defined(CONFIG_ARM64)
 	unsigned long tlb_fillptr;
 	unsigned long tlb_emerg;
-	bool has_hafdbs;
 #endif
 #endif
 #ifdef CFG_SYS_MEM_RESERVE_SECURE
-- 
2.42.0

