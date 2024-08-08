Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6655C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7050988A44;
	Fri,  9 Aug 2024 01:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QZ6s5N9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4FA88B86; Fri,  9 Aug 2024 01:59:42 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A90888E7
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7aa212c1c9so208752666b.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161580; x=1723766380; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oQVAqXN0aVyCZrOfA+KR9HiRdoiW3c0WHFlddx70NvA=;
 b=QZ6s5N9zJmaHjYBXs9pKwFbzYJ8AFEufXgDFlynKgXMDfjzhjq4tB1P/gVB2pTlTAd
 CSEWPcqTKwoMIDKncVShu9F2Q79n9gRONNvrElMF0q2VA5DnWvN4JyZ4X1kprPh/nSHw
 DH99HuWrwalELMEu5lu5C/h6HM/LtRaQP6ddU/mUoaQkucperJSb5BZ9P+0z/H/aBDe6
 4n8CihZGCT4lm7Z9/VpOVeJTQOc3lbhL7uFq7fsbGa0Ag56UNXEJ5ilJneOlSUuEaP8f
 wLnIRyjkzq8H9GXFBo026rNtrIFdAi7qAD6MWkcu+gSewNEcDJyjENZfrFIYttltSiKL
 7PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161580; x=1723766380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQVAqXN0aVyCZrOfA+KR9HiRdoiW3c0WHFlddx70NvA=;
 b=rnx6aeFvvhd3XG/2x5aIKmiCDZFTOgyBv5Ex9EYuJAEaNthTmAyCgdcLlpy8lgJoMC
 5wgOAEYogGesI0mYv5LSPJuIbfQ5u2X5ng2OD27GGXUZIBQ/FWTHndO5y6zubiPYfl44
 fR5tc4ElMDwo6b9DwnHNkUSsiHqMHIN80lee5IrzDWOAy7RvMQAxu8d+5QFbjZrOM391
 2VDSqANR7WX33MKmDSRdT9TJxZDb0mzap30piNPh2n537vxsjVBhByv6u4H/S+hrv7BA
 jTeTKBEtbpYU6I5ddViu5DvWHOl4w/SyioTFPT5tP/PZgDQPQdK+jOlKnHPOcJD0zGqj
 F/ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL3LohNzfvPomz+4gMH5mS96gGv+5aCprLFwO3eC21F+mo4V/gY5w/cWMKwJCsaCwkzIMdi3xKfMoLv1QKAZVWoT7hmw==
X-Gm-Message-State: AOJu0YwsjtAHULaQNuUjQnj7lHBLKyPZoyOb0jnqlh7gmHBX9IfjxlgH
 +urimVwPEr5PmMUwqN0Yo7jYnahrR5wNtRarRFassgzgZRJVD6XCe4lsAk7hluE=
X-Google-Smtp-Source: AGHT+IHqa0HezJLmj1rBgEY+pVZCLpadm5e7w1OxqTaBefE8X+GuFO6UrVWYv6w6q539b32BcVEzLg==
X-Received: by 2002:a17:907:972a:b0:a7a:9447:3e8c with SMTP id
 a640c23a62f3a-a8090c26d34mr267576066b.3.1723161579733; 
 Thu, 08 Aug 2024 16:59:39 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:25 +0200
Subject: [PATCH 02/11] mach-snapdragon: parse memory ourselves
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-2-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5361;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kqxRPDy9dXNXEcM3z+9hPiRV/NLkk7TQTnMS9KRVQ7E=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvnJ3o8Tu8g9YPA3ivY444BimnqudncPPeSe
 AvBiHLJNbuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb5wAKCRAFgzErGV9k
 tqI2D/9OKBAIzMWSIn0oG9JREW63XIntQs7PQNVLLVE3nkkCiubWzQVHbXrAtf53ARoikVcj/FW
 PUMBCEmOc4x128K5t7WfBsemh+xI4MwRczxDpbWS0c7B190ncyX1Ul0orO0qHhMncTw4kGad6er
 RGnrv2uA4Z6fXpaID/x6kNZia00iaChWrmRDIyYUKbY/8kVFKTWEE0w/zHGy8W2kMB4Z8W3w8Ld
 JLerfRY5jrhOg/qyv9jIIYJao9S7xtWyGjZAtkSc8cn877qsFAyS93h49GwCzhvgUPmB1xt2eu9
 Y+SegNHnRahmGZDLw2+WOkLQeMpDr5AA6J1obY57LtkYzXZjRfUHLulk5gd01DliOJ+hpGGvMq5
 nwYw/c+1dQ2npnHaxt3fbbH8tJZljxBMmSR8IScxpOCfhxT7c2JNMhDHGFUq8bskVbBAY4GIoI7
 848eJoZoZgyc/2FPfwmVV0DgSOtR7tG/OA9UElfvb4laqAOZpKrXvwYHDl/qOdix3BNRS2VbRbr
 eclYudTcX3jp5fpzxiLTBSekvOs0RvDT51g8bpYXaD8cLXrDIDR8HohaJRKFcbaSYsNQplQP6rV
 d4OSi1HXNojMQfgadS3NLbumlzH2MU2iOtbe9q9X+BrN5TCtDmubXhsNiNuq4UgGgN4oSywMALv
 bp6uxjZK6HIn5JA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The generic memory parsing code in U-Boot lacks a few things that we
need on Qualcomm:

1. It sets gd->ram_size and gd->ram_base to represent a single memory
   block.
2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the
   end of that first memory block.

This results in all memory beyond U-Boot being unusable in Linux when
booting with EFI.

Since the ranges in the memory node may be out of order, the only way
for us to correctly determine the relocation address for U-Boot is to
parse all memory regions and find the highest valid address.

We can't use fdtdec_setup_memory_banksize() since it stores the result
in gd->bd which is not yet allocated.

Hence, this commit, which implements an optimised parser to read the
memory blocks and store them in the .data section where they will
survive relocation.

We set ram_base and ram_size to describe the entire address space of
memory, with the assumption that the last memory region is big enough
for U-Boot, its DTB, and heap. On all boards tested so far this seems
to be a reasonable assumption.

As a nice side effect, our fdt parsing also winds up being faster since
we avoid the overhead of checking address/size-cells or populating
struct resource. We can safely make these optimisations since we only
support ARM64, and trust the reg property to be populated correctly.

After relocation, we then populate gd->bd->bi_dram with the data we
parsed earlier.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 93 ++++++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2881de28a0a3..8947cf913dff 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -37,11 +37,20 @@ DECLARE_GLOBAL_DATA_PTR;
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
+static struct {
+	phys_addr_t start;
+	phys_size_t size;
+} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
+
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	/*
+	 * gd->ram_base / ram_size have been setup already
+	 * in qcom_parse_memory().
+	 */
+	return 0;
 }
 
 static int ddr_bank_cmp(const void *v1, const void *v2)
 {
@@ -57,25 +66,73 @@ static int ddr_bank_cmp(const void *v1, const void *v2)
 
 	return (res1->start >> 24) - (res2->start >> 24);
 }
 
+/* This has to be done post-relocation since gd->bd isn't preserved */
+static void qcom_configure_bi_dram(void)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
+		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
+	}
+}
+
 int dram_init_banksize(void)
 {
-	int ret;
-
-	ret = fdtdec_setup_memory_banksize();
-	if (ret < 0)
-		return ret;
-
-	if (CONFIG_NR_DRAM_BANKS < 2)
-		return 0;
-
-	/* Sort our RAM banks -_- */
-	qsort(gd->bd->bi_dram, CONFIG_NR_DRAM_BANKS, sizeof(gd->bd->bi_dram[0]), ddr_bank_cmp);
+	qcom_configure_bi_dram();
 
 	return 0;
 }
 
+static void qcom_parse_memory(void)
+{
+	ofnode node;
+	const fdt64_t *memory;
+	int memsize;
+	phys_addr_t ram_end = 0;
+	int i, j, banks;
+
+	node = ofnode_path("/memory");
+	if (!ofnode_valid(node)) {
+		log_err("No memory node found in device tree!\n");
+		return;
+	}
+	memory = ofnode_read_prop(node, "reg", &memsize);
+	if (!memory) {
+		log_err("No memory configuration was provided by the previous bootloader!\n");
+		return;
+	}
+
+	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
+
+	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
+		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
+
+	if (banks > CONFIG_NR_DRAM_BANKS)
+		log_err("Provided more memory banks than we can handle\n");
+
+	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
+		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
+		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
+		/* SM8650 boards sometimes have empty regions! */
+		if (!prevbl_ddr_banks[j].size) {
+			j--;
+			continue;
+		}
+		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
+	}
+
+	/* Sort our RAM banks -_- */
+	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
+
+	gd->ram_base = prevbl_ddr_banks[0].start;
+	gd->ram_size = ram_end - gd->ram_base;
+	debug("ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
+	      gd->ram_base, gd->ram_size, ram_end);
+}
+
 static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
@@ -109,13 +166,21 @@ void *board_fdt_blob_setup(int *err)
 		      (phys_addr_t)fdt);
 
 	if (internal_valid) {
 		debug("Using built in FDT\n");
-		return (void *)gd->fdt_blob;
 	} else {
 		debug("Using external FDT\n");
-		return (void *)fdt;
+		/* So we can use it before returning */
+		gd->fdt_blob = fdt;
 	}
+
+	/*
+	 * Parse the /memory node while we're here,
+	 * this makes it easy to do other things early.
+	 */
+	qcom_parse_memory();
+
+	return (void *)gd->fdt_blob;
 }
 
 void reset_cpu(void)
 {

-- 
2.46.0

