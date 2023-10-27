Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02F2C25B6B
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B208071F;
	Fri, 27 Oct 2023 02:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QmBA/Zgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E7B887BC4; Fri, 27 Oct 2023 02:24:51 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F9087BCC
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5b93ddb10b8so221964a12.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698366284; x=1698971084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBdEo6QUw8eBjO8cIrRTMCExK7sMIwCw0NjxmOhfPf0=;
 b=QmBA/Zgzrnf3H+jiZHHwd9AJ7Xcu9GrYSphQdiDy0ZoylwC0+n0fuMEWaIkpCSkVSo
 X1xT6YALMxXkehfjD6T34twB5LVycLWUvA97Eq4E4YPCTrW1e/8SjVDbppOM5xfsUZl7
 ioroNidqPq1b6LCW9Ov8DIEjPLnL9r3OP/ifD0tlTFpg2Y/bx3ly39b/BGdr4thB1N5T
 Whpi15L+Q3OT5siRRb1yiFaYcjeDTMlsYDFLHgm4A5qnPCPHbs+1zZupJUJiFCbL47uG
 Svv1yIt1+LHbVvFE4UO+M4+A0LB2KlJ5RPkeWAnAu7Uqv9WZ0I7mtq5jZiY5bTqmXslq
 q1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698366284; x=1698971084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBdEo6QUw8eBjO8cIrRTMCExK7sMIwCw0NjxmOhfPf0=;
 b=Th3v3klCsvoLMbvFJE4zmKHDmX8nPz5zv35Lp+azUFrqimvTa21SU06y5krp4O5TvG
 1b1zYLZK+Q7O7JomaBEIpOpR2n3WrpxiQjnOz/zPUxPGyXHT87mPLRO2DsqfSgjY2mnj
 qmyhY1cwaorg7qkWm1DyJ9P7C4deKj2EO3g7hhQ5Md0df8ziwaFxZTpBfWkFhwArWE3A
 TjMJKRnA7trKGC55RVvA527uWSbOIc5oqb91m+ouklAn+29bOEm2zHrRmUASVWtm4cD1
 aerYGyizeOA8t7u545W26CcaFJ/ez+gqjEFN3Is/GUwQDTGj5lOW08LXi8P5jJRM/KzE
 /esA==
X-Gm-Message-State: AOJu0YyyOh3zUU303TLPMuobuC1iPJ7XR3PsaHRQK0SMP1DyfcLE1oc0
 GML2bRihw/qYKOiYLKQCcK/TE56hcXpUTA==
X-Google-Smtp-Source: AGHT+IHPR4EJjqtrEf1Zh0tZJsviQQbYsHKsjRSIflRwObvR+HjIKPNV50NbQIxGOrjug+JRDre+nQ==
X-Received: by 2002:a17:90a:d447:b0:277:3afc:f27 with SMTP id
 cz7-20020a17090ad44700b002773afc0f27mr5226864pjb.1.1698366283842; 
 Thu, 26 Oct 2023 17:24:43 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:b6a2:eace:f54:1956])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a031600b0027476c68cc3sm167606pje.22.2023.10.26.17.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:24:43 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Simon Glass <sjg@chromium.org>, Ye Li <ye.li@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>
Subject: [PATCH 2/3] Revert "arm64: Use level-2 for largest block mappings
 when FEAT_HAFDBS is present"
Date: Fri, 27 Oct 2023 13:23:53 +1300
Message-ID: <20231027002409.430285-3-judge.packham@gmail.com>
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

This reverts commit 836b8d4b205d2175b57cb9ef271e638b0c116e89. This is
part of a series trying to make use of the arm64 hardware features for
tracking dirty pages. Unfortunately this series causes problems for the
AC5/AC5X SoCs. Having exhausted other options the consensus seems to be
reverting this series is the best course of action.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/cpu/armv8/cache_v8.c      | 14 ++++----------
 arch/arm/include/asm/global_data.h |  1 -
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 4c6a1b1d6c5e..4760064ee18f 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -314,7 +314,7 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
 	for (i = idx; size; i++) {
 		u64 next_size, *next_table;
 
-		if (level >= gd->arch.first_block_level &&
+		if (level >= 1 &&
 		    size >= map_size && !(virt & (map_size - 1))) {
 			if (level == 3)
 				table[i] = phys | attrs | PTE_TYPE_PAGE;
@@ -353,9 +353,6 @@ static void add_map(struct mm_region *map)
 	if (va_bits < 39)
 		level = 1;
 
-	if (!gd->arch.first_block_level)
-		gd->arch.first_block_level = 1;
-
 	if (gd->arch.has_hafdbs)
 		attrs |= PTE_DBM | PTE_RDONLY;
 
@@ -372,7 +369,7 @@ static void count_range(u64 virt, u64 size, int level, int *cntp)
 	for (i = idx; size; i++) {
 		u64 next_size;
 
-		if (level >= gd->arch.first_block_level &&
+		if (level >= 1 &&
 		    size >= map_size && !(virt & (map_size - 1))) {
 			virt += map_size;
 			size -= map_size;
@@ -413,13 +410,10 @@ __weak u64 get_page_table_size(void)
 	u64 size, mmfr1;
 
 	asm volatile("mrs %0, id_aa64mmfr1_el1" : "=r" (mmfr1));
-	if ((mmfr1 & 0xf) == 2) {
+	if ((mmfr1 & 0xf) == 2)
 		gd->arch.has_hafdbs = true;
-		gd->arch.first_block_level = 2;
-	} else {
+	else
 		gd->arch.has_hafdbs = false;
-		gd->arch.first_block_level = 1;
-	}
 
 	/* Account for all page tables we would need to cover our memory map */
 	size = one_pt * count_ranges();
diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index b385bae02669..1325b0644248 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -52,7 +52,6 @@ struct arch_global_data {
 #if defined(CONFIG_ARM64)
 	unsigned long tlb_fillptr;
 	unsigned long tlb_emerg;
-	unsigned int first_block_level;
 	bool has_hafdbs;
 #endif
 #endif
-- 
2.42.0

