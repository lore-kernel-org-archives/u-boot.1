Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD1C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FE480824;
	Wed,  5 Feb 2025 14:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x9K0qMH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBF980207; Wed,  5 Feb 2025 08:17:51 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DCE805D7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab737e78900so454317066b.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 23:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738739869; x=1739344669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vMO6iN3NnCiRZ5O772lxPg+OODwikPNOb2/pBTuVKo=;
 b=x9K0qMH2KL62KxwmPJlFhimo3Y569oIPTwGpl8zY9TRlCSkZvfeNLowF81hhe13DRs
 +wwsu50QgfMA5BfuV2aUAb61LY5EDakrtWW+YQ7z2PEVd74lOTRc6Qg63Ic8IjYmTzLV
 38UaWIJ9CCPzUFJA8a2rhIFYSIz4srseicTjWd75BZ8fh06akpEOD0yvVMWwyuh3XP4d
 yym13472CeH8SI8iEgFYzGBiGzgCXeFERFhQJB6q9bulY7DZ0GTvw+aI02EJSb+vs/2Z
 cNYDVufejP4egSjxDW38MREc6+GHFYtAlBbPZwDWCPHvMuWRnqM8SpTf9KMulq+/XZTp
 zPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739869; x=1739344669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vMO6iN3NnCiRZ5O772lxPg+OODwikPNOb2/pBTuVKo=;
 b=TvLbCnS4EDtoOSzygtwKpAGWYjQqX+VJP9LcJyUPsqdCPR+wHu4aMIJ8PsxygT7YEB
 wMMMR6fHbz4vuxLnU7rYhMAbjxReFT7VJKLoeTO3vmGCtJGcPDziRJ6/Vb1U+KYVj7tf
 bAbV38hXbHdLJGzqDYrJeABZo111CFmHdfwNtQBgtAE53qeKhmzNrWZ3SVtgbs8RlWm5
 ET/6ZBKvQ8rXH9bHSQzfoe+xb6UVrmzblVqHk3mKt7WE1T3OY4ZdC+ek745dztbX0kC/
 0i5HDQtxkTiUAwMxfXztX9fglQ57y574/jKPZoC6dJUO2mBG+F+BnD/KpicmxCeyEKm4
 tOCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgi/WG1Xwk8KI5e2Y+eoyQOuGi24IhSjbUbNragvmHqICG6VMXWCtRvmrAiBngjUGmAaPhqAo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7mnrziRXb6CbCByVbUqpzBMQCIIo2oh9KRK6o7gF9MzNnlmfq
 8Ka3uKssDPi6xnaBBvxcccIQ4c/+u47HWOKrnKGAEuMXbc6XpK4hZD60jXLRoHU=
X-Gm-Gg: ASbGncscUvgwwyb2GfKeFPAZO6kIDukldMpwWkzNi8X/UbYz9r/dSbxJZY77Kg9Co7/
 Z9Rrjo7n+sKdrPpx3CKlyTMGX9XgeVXIkqm2wKORJOLkhX/V7dynAwSn3RPlktMM4nJVsq2LNni
 zFqTlaXvTg8cLtPrOOZvF2cM+S9Hj/bO4C+IPFfwnkU8Yc4YA5ep6LhRiouLfe+n8f6ENDF2rrZ
 6n4OPiPtOJan7LPBI0fZLqpwFYG3L3JptGWtKWhrBQuOd5v/b1CHHUu4+gh7kDdcTOiPN4zaY7k
 YKH5GEMF12XM2TWyV/9pTarIZQaaf1vKz0w9q1o6IqM7SgvQ1sGmPat8e5v6RrkY85SA
X-Google-Smtp-Source: AGHT+IGHcPT032efs4lgTgr2nfKE1WlKBO3CXjv9Jjp2jzvWhcl0Nhxx7T9WV1MfSENshjN34MFygw==
X-Received: by 2002:a17:907:94d3:b0:ab6:4fa6:71e2 with SMTP id
 a640c23a62f3a-ab75e23ea15mr144891866b.22.1738739869087; 
 Tue, 04 Feb 2025 23:17:49 -0800 (PST)
Received: from localhost.localdomain (ppp176092167070.access.hol.gr.
 [176.92.167.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcda28cbcesm1107191a12.43.2025.02.04.23.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 23:17:48 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Marc Zyngier <maz@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 4/6] arm64: mmu_change_region_attr() add an option not to
 break PTEs
Date: Wed,  5 Feb 2025 09:16:48 +0200
Message-ID: <20250205071714.635518-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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
index dbf9ab43e280..f84bffe9d4fb 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -287,7 +287,16 @@ void flush_l3_cache(void);
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

