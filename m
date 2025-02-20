Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71793C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4113B80F98;
	Thu, 20 Feb 2025 22:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zTxzBBTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD7780F5F; Thu, 20 Feb 2025 14:56:00 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DEB8001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43984e9cc90so12398595e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059757; x=1740664557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZNDoru6BQKLt0+9h8+H9ivCYVfBH1Oosy/mEW5+620=;
 b=zTxzBBThpjjQdHarYhJkRYGyiZtBv329wFlOjW0F0arTrmp4e52qLqqxRCe52FBq4U
 RVkE+24UJGXYhgc5BDeOR1ADizyJ3sKANuCX70LMy8xfI9G4C7H2pyubUlGYizIZ9lA1
 8I2E2vWGzg2Nu/3FlV3PENJmL8KAM9fb3WMA1nndA+nm/RLtZkf456oBZrFV044EvEZs
 auAMIdAC6kDajjXgFXxOrUhSoKVG9gy7PTW7e70U2z/ADftOHqQQ1L3jsIItbuZOdQJM
 YIYRqk2Id+xp93Hj4MDPyHtwnYBh/xZwpEdanHtnCnPCJPWAWFroNasuMdGUv0rNpSN3
 wUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059757; x=1740664557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZNDoru6BQKLt0+9h8+H9ivCYVfBH1Oosy/mEW5+620=;
 b=cn8M3iAZt10hkZ3dGy4hLSZ1USoe4DK97BxHsglXfJ5lVhECqOfyvdwj45D/hHBjPj
 9GN2PmgKopB2a7D/Api89ihu5899PW6R4jxHjlaOxgH6VxfziK87+ibOTcQCzxUyhmn9
 pagdtvzfL7DfEAd79T6YTBwX9VuNSUOp57ZxXkvrHPviCf3YglfRAV50TKX+letkVcAQ
 7e/fftotgFUoi0wJAdp82vlQ6CskPDTvpkumBtj9BVtqPUhtxl30UpmVdvy+lHQOvoE2
 3bzOJULOOebaK7VTktpFTg7ZAndtUFC71wbsPCygD5YZiuv2SmDHLWSzruz3m8SD9KaD
 hxdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqIgXNZ7jBul2r6KzDL/IGrHF1pd1F3j8trwv5BZcd5+/7oRiGrV21QGhRLDhPKYqo0B2dfLM=@lists.denx.de
X-Gm-Message-State: AOJu0YxOe3pKT4R4i8tTeNgS0afjEBFWLRily3FlXFt2eL8yfiG2UoxR
 wrE982yg8yusRIXQCw4/9FA6AhYUmi5p4u0gsM/jGPA5cD8nfhkLJ0t6weyB0Wk=
X-Gm-Gg: ASbGncs8mK4I+ZLzR3+qJIAIG/fgIt94pJ7WB7lTv8+qAEsAeSURMPv/OBEsM7mddZq
 2OYDKn41cQlLQHvL6yQNX/qlNt2/ElSZJl7/i04C63i/Ratyu74cowvXYxjmelVIxZHcoGhcNZt
 Jr8kThDVN9GF9rOLQrFixNY0cXRcFOSGv788rOjx1sRhMG2ZPQwHUfzB6nr4ZcE4EdYgShPsZqx
 LGgany6RkTF90AIk548as5M0/2XsJGHIb/tZ22WQ7DXZuhaVPw77AC02lDVZPAHgsbS+WkXZ1vH
 oMW4OUiQJ3DCd4EqhVWCQnHAhMgEtkrf+79sZQLIk4CmIqqG2+Fl0iz0oTlVugOIFvURew==
X-Google-Smtp-Source: AGHT+IGEjEiCQn+eAcz+cJCp+eDRFtWr4Z0rOZLlS2CqT66MOwVxCaYCME3D0KFweb9gVDxuHfu6Wg==
X-Received: by 2002:a05:600c:5246:b0:439:98fd:a4b6 with SMTP id
 5b1f17b1804b1-439a30e6a0dmr30464965e9.15.1740059757255; 
 Thu, 20 Feb 2025 05:55:57 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987088ecbsm111659865e9.31.2025.02.20.05.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:55:56 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 4/6] arm64: mmu_change_region_attr() add an option not to
 break PTEs
Date: Thu, 20 Feb 2025 15:54:41 +0200
Message-ID: <20250220135506.151894-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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

The ARM ARM on section 8.17.1 describes the cases where
break-before-make is required when changing live page tables.
Since we can use this function to tweak block and page permssions,
where BBM is not required add an extra argument to the function.

While at it add a function description.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c           |  6 +++++-
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 +++++-----
 arch/arm/include/asm/system.h           | 11 ++++++++++-
 arch/arm/mach-snapdragon/board.c        |  2 +-
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index c4b3da4a8da7..670379e17b7a 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -972,11 +972,14 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
  * The procecess is break-before-make. The target region will be marked as
  * invalid during the process of changing.
  */
-void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
+void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs, bool bbm)
 {
 	int level;
 	u64 r, size, start;
 
+	if (!bbm)
+		goto skip_break;
+
 	start = addr;
 	size = siz;
 	/*
@@ -1001,6 +1004,7 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
 
+skip_break:
 	/*
 	 * Loop through the address range until we find a page granule that fits
 	 * our alignment constraints, then set it to the new cache attributes
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index d2d3e346a36f..caf1dab05936 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -1573,7 +1573,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 	} else {
 		mmu_change_region_attr(
 					CFG_SYS_SDRAM_BASE,
@@ -1581,7 +1581,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
 #ifndef CONFIG_SYS_DDR_BLOCK2_SIZE
 #error "Missing CONFIG_SYS_DDR_BLOCK2_SIZE"
@@ -1594,7 +1594,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 			mmu_change_region_attr(
 					CONFIG_SYS_DDR_BLOCK3_BASE,
 					gd->ram_size -
@@ -1603,7 +1603,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 		} else
 #endif
 		{
@@ -1614,7 +1614,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 		}
 	}
 }
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 091082281c73..08e6e52cc673 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -303,7 +303,16 @@ void flush_l3_cache(void);
  * @emerg: Also map the region in the emergency table
  */
 void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
-void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
+
+/**
+ * mmu_change_region_attr() - change a mapped region attributes
+ *
+ * @start: Start address of the region
+ * @size:  Size of the region
+ * @aatrs: New attributes
+ * @bbm:   Perform a break-before-make on the page tables entries
+ */
+void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs, bool bbm);
 
 /*
  * smc_call() - issue a secure monitor call
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2ef936aab757..13f4e8e640ef 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -577,7 +577,7 @@ static void carve_out_reserved_memory(void)
 		if (i == count || start + size < res[i].start - SZ_2M) {
 			debug("  0x%016llx - 0x%016llx: reserved\n",
 			      start, start + size);
-			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
+			mmu_change_region_attr(start, size, PTE_TYPE_FAULT, true);
 			/* If this is the final region then quit here before we index
 			 * out of bounds...
 			 */
-- 
2.47.2

