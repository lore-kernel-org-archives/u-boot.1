Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3317CC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9208E87E4F;
	Tue, 30 Jan 2024 15:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RkCEE/Ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A7387EC5; Tue, 30 Jan 2024 15:05:42 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B09F587E26
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40f02b8d176so5460585e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623529; x=1707228329; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BVzgV+ZnnG9GkmvhHdBEcm+/iVq+Y+1mFbYWhchC46Q=;
 b=RkCEE/UdouWq64ahv4DmzDImXH3W8JHYu1mW6nDPJrP4zb2P1xU17PSSYt4mcFL0XY
 1pfETU76eCrBMff8LE0zE/ZFknngXlycKIV68S/MLKKOp2oXbABIgf3l4xGL9Qbd45hd
 LfdWkNgd8TCiq3A0R6NtxIbNYdNPU0r73ZzmGc9Yf4XPUOHyPSRYAdGuveQQwYFhZ3u2
 sbmae00fdPCY2SwGOicL1L3B/3MkiKzYmA5bYwmHuOssIvCABwt1y/v7lc3F/JRN5yzF
 Yyd2uFYWd5gF8otzpHiuiWchUgLGxo5gh090yADqUIi5glTJLz4IlqSAXg1jBx4nizs2
 6miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623529; x=1707228329;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVzgV+ZnnG9GkmvhHdBEcm+/iVq+Y+1mFbYWhchC46Q=;
 b=bKqSj/qsGj1uh9Z32QE2MpFdpdtqYAsNn+q1ZtcDbqlJI7rL1oqAXHYwXVNjcMV/FJ
 Jg+Dt0RQ4zjuNUeXLoiUHQQN1MJFrQ2iCS9xl5mN3g2FKSrjkQOeSh41u40SHcE4v1LI
 md8hFYIcmtl+NZQho032XT02xVjlmjnYzuQsRwa+cxwGZORjnGgSamsYlZhynXOjstsA
 nBlzCSpibN8MNjc0VuWvNUdDL/gXf3I18qfp+caCxTJPVwBmoBqD6FL0TjYswrdVHh2I
 lp84qncu4FM5W3r1p0AN7B22fcRhm+hh21OmUrFLlgpOJG0JWk1QISSvdOjuQzFZg8v9
 arog==
X-Gm-Message-State: AOJu0YxEJhuQwlSm0Gw5lC8uDlii5+7yxYvm1eSkFYssrYmOX9hq1rZh
 B+qsvF8aIfZHJ75h6iE8GQtpMe4DzEo1H7zSwcRPRoLj/hxYGVgyH4hDhgO0/N8=
X-Google-Smtp-Source: AGHT+IESYDl/EQ4I42Uv1grcHhJfqgphsUDYwHU2nmwF3LxDsZEzrCtjuOPeRQE8PhMObPZKoWdzAw==
X-Received: by 2002:a05:600c:4fc9:b0:40f:cd:3885 with SMTP id
 o9-20020a05600c4fc900b0040f00cd3885mr1721777wmq.25.1706623529226; 
 Tue, 30 Jan 2024 06:05:29 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:28 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:08 +0000
Subject: [PATCH v3 20/36] mach-snapdragon: carve out no-map regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-20-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=8408;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=eup42pSlkSski4u/DSwnay4Y+bOVlTp/vaI9F/w5rNA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTILthZn1X32ZzHu62fXtP/FE7T6sKZelGWt6adHBL
 6Wdrzo6SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwEQCdzH8s8mYUa38O+zvgS/L
 9U99Ewpce0pEwuFbw/23nrfulWyeV8jIsGfyz69cDJGvTG5onGrld7ubUDRxwaklrSozApniXHW
 EEwE=
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

On Qualcomm platforms, the TZ may already have certain memory regions
under protection by the time U-Boot starts. There is a rare case on some
platforms where the prefetcher might speculatively access one of these
regions resulting in a board crash (TZ traps and then resets the board).

We shouldn't be accessing these regions from within U-Boot anyway, so
let's mark them all with PTE_TYPE_FAULT to prevent any speculative
access and correctly trap in EL1 rather than EL3.

This is quite costly with caches off (takes ~2 seconds on SDM845 vs 35ms
with caches on). So to minimise the impact this is only enabled on
QCS404 for now (where the issue is known to occur).

In the future, we should try to find a more efficient way to handle
this, perhaps by turning on the MMU in stages.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 abort                            |  20 ++++++
 arch/arm/mach-snapdragon/board.c | 151 ++++++++++++++++++++++++++++++++-------
 2 files changed, 147 insertions(+), 24 deletions(-)

diff --git a/abort b/abort
new file mode 100644
index 000000000000..34c3e2f0596a
--- /dev/null
+++ b/abort
@@ -0,0 +1,20 @@
+"Synchronous Abort" handler, esr 0x96000007, far 0x0
+elr: 0000000000005070 lr : 00000000000039a8 (reloc)
+elr: 000000017ff27070 lr : 000000017ff259a8
+x0 : 0000000000000000 x1 : 0000000000000000
+x2 : 000000017faeb328 x3 : 000000017faeb320
+x4 : 00000000000feae8 x5 : 00000000feae8000
+x6 : 0000000000000007 x7 : 0000000000000004
+x8 : 0000000000000000 x9 : 000000017eae7000
+x10: 0000000000000000 x11: 000000027c89ffff
+x12: 000000017fffffff x13: 0000000180000000
+x14: 0000000000518db0 x15: 000000017faeb0cc
+x16: 000000017ff2edac x17: 0000000000000000
+x18: 000000017fb02d50 x19: 000000017ffbd600
+x20: 000000017ffbd600 x21: 0000000000000000
+x22: 0000000000001f1f x23: 000000017faeb370
+x24: 000000017ffbd000 x25: 000000017ff94993
+x26: 0000000000000030 x27: 000000017ffbecf0
+x28: 0000000000000000 x29: 000000017faeb2a0
+
+Code: a94153f3 f94013f5 a8c47bfd d65f03c0 (b9400002) 
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 9d8684a21fa1..ca300dc843a9 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -6,8 +6,9 @@
  * Author: Caleb Connolly <caleb.connolly@linaro.org>
  */
 
-#define LOG_DEBUG
+//#define LOG_DEBUG
 
+#include "time.h"
 #include <asm/armv8/mmu.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -26,6 +27,7 @@
 #include <lmb.h>
 #include <malloc.h>
 #include <usb.h>
+#include <sort.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -297,7 +299,7 @@ int board_late_init(void)
 
 static void build_mem_map(void)
 {
-	int i;
+	int i, j;
 
 	/*
 	 * Ensure the peripheral block is sized to correctly cover the address range
@@ -313,39 +315,140 @@ static void build_mem_map(void)
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
 
-	debug("Configured memory map:\n");
-	debug("  0x%016llx - 0x%016llx: Peripheral block\n",
-	      mem_map[0].phys, mem_map[0].phys + mem_map[0].size);
-
-	/*
-	 * Now add memory map entries for each DRAM bank, ensuring we don't
-	 * overwrite the list terminator
-	 */
-	for (i = 0; i < ARRAY_SIZE(rbx_mem_map) - 2 && gd->bd->bi_dram[i].size; i++) {
-		if (i == ARRAY_SIZE(rbx_mem_map) - 1) {
-			log_warning("Too many DRAM banks!\n");
-			break;
-		}
-		mem_map[i + 1].phys = gd->bd->bi_dram[i].start;
-		mem_map[i + 1].virt = mem_map[i + 1].phys;
-		mem_map[i + 1].size = gd->bd->bi_dram[i].size;
-		mem_map[i + 1].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-				     PTE_BLOCK_INNER_SHARE;
-
-		debug("  0x%016llx - 0x%016llx: DDR bank %d\n",
-		      mem_map[i + 1].phys, mem_map[i + 1].phys + mem_map[i + 1].size, i);
+	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->bd->bi_dram[j].size; i++, j++) {
+		mem_map[i].phys = gd->bd->bi_dram[j].start;
+		mem_map[i].virt = mem_map[i].phys;
+		mem_map[i].size = gd->bd->bi_dram[j].size;
+		mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
+				   PTE_BLOCK_INNER_SHARE;
 	}
+
+	mem_map[i].phys = UINT64_MAX;
+	mem_map[i].size = 0;
+
+	debug("Configured memory map:\n");
+	for (i = 0; mem_map[i].size; i++)
+		debug("  0x%016llx - 0x%016llx: entry %d\n",
+		      mem_map[i].phys, mem_map[i].phys + mem_map[i].size, i);
 }
 
 u64 get_page_table_size(void)
 {
-	return SZ_64K;
+	return SZ_256K;
 }
 
+static int fdt_cmp_res(const void *v1, const void *v2)
+{
+	const struct fdt_resource *res1 = v1, *res2 = v2;
+
+	return res1->start - res2->start;
+}
+
+#define N_RESERVED_REGIONS 32
+
+/* Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
+ * On some platforms this is enough to trigger a security violation and trap
+ * to EL3.
+ */
+static void carve_out_reserved_memory(void)
+{
+	static struct fdt_resource res[N_RESERVED_REGIONS] = { 0 };
+	int parent, rmem, count, i = 0;
+	phys_addr_t start;
+	size_t size;
+
+	/* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
+	 * attempt to access them, causing a security exception.
+	 */
+	parent = fdt_path_offset(gd->fdt_blob, "/reserved-memory");
+	if (parent <= 0) {
+		log_err("No reserved memory regions found\n");
+		return;
+	}
+	count = fdtdec_get_child_count(gd->fdt_blob, parent);
+	if (count > N_RESERVED_REGIONS) {
+		log_err("Too many reserved memory regions!\n");
+		count = N_RESERVED_REGIONS;
+	}
+
+	/* Collect the reserved memory regions */
+	fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
+		if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
+			continue;
+		if (fdt_getprop(gd->fdt_blob, rmem, "compatible", NULL))
+			continue;
+		/* Skip regions that don't have a fixed address/size */
+		if (fdt_get_resource(gd->fdt_blob, rmem, "reg", 0, &res[i++]))
+			i--;
+	}
+
+	/* Sort the reserved memory regions by address */
+	count = i;
+	qsort(res, count, sizeof(struct fdt_resource), fdt_cmp_res);
+
+	/* Now set the right attributes for them. Often a lot of the regions are tightly packed together
+	 * so we can optimise the number of calls to mmu_change_region_attr() by combining adjacent
+	 * regions.
+	 */
+	start = ALIGN_DOWN(res[0].start, SZ_2M);
+	size = ALIGN(res[0].end, SZ_4K) - start;
+	for (i = 1; i < count; i++) {
+		/* We ideally want to 2M align everything for more efficient pagetables, but we must avoid
+		 * overwriting reserved memory regions which shouldn't be mapped as FAULT (like those with
+		 * compatible properties).
+		 * If within 2M of the previous region, bump the size to include this region. Otherwise
+		 * start a new region.
+		 */
+		if (start + size < res[i].start - SZ_2M) {
+			debug("  0x%016llx - 0x%016llx FAULT\n",
+			      start, start + size);
+			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
+			start = ALIGN_DOWN(res[i].start, SZ_2M);
+			size = ALIGN(res[i].end, SZ_4K) - start;
+		} else {
+			/* Bump size if this region is immediately after the previous one */
+			size = ALIGN(res[i].end, SZ_4K) - start;
+		}
+	}
+}
+
+/* This function open-codes setup_all_pgtables() so that we can
+ * insert additional mappings *before* turning on the MMU.
+ */
 void enable_caches(void)
 {
+	u64 tlb_addr = gd->arch.tlb_addr;
+	u64 tlb_size = gd->arch.tlb_size;
+	ulong carveout_start;
+
+	gd->arch.tlb_fillptr = tlb_addr;
+
 	build_mem_map();
 
 	icache_enable();
+
+	/* Create normal system page tables */
+	setup_pgtables();
+
+	/* Create emergency page tables */
+	gd->arch.tlb_size -= (uintptr_t)gd->arch.tlb_fillptr -
+			     (uintptr_t)gd->arch.tlb_addr;
+	gd->arch.tlb_addr = gd->arch.tlb_fillptr;
+	setup_pgtables();
+	gd->arch.tlb_emerg = gd->arch.tlb_addr;
+	gd->arch.tlb_addr = tlb_addr;
+	gd->arch.tlb_size = tlb_size;
+
+	/* Doing this has a noticeable impact on boot time, so until we can
+	 * find a more efficient solution, just enable the workaround for
+	 * the one board where it's necessary. Without this there seems to
+	 * be a speculative access to a region which is protected by the TZ.
+	 */
+	if (of_machine_is_compatible("qcom,qcs404")) {
+		carveout_start = get_timer(0);
+		carve_out_reserved_memory();
+		debug("carveout time: %lums\n", get_timer(carveout_start));
+	}
+
 	dcache_enable();
 }

-- 
2.43.0

