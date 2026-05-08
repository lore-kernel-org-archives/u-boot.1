Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C318CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 07:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69D784AF6;
	Fri,  8 May 2026 09:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kvM7fP1B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9247584B56; Fri,  8 May 2026 09:28:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F01384AB3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 09:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1404360252;
 Fri,  8 May 2026 07:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B84C2BCB0;
 Fri,  8 May 2026 07:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778225301;
 bh=FxJ9BmPhsc3qbDyU+Pzfz9Fn1Uq18pBQ+/fXW29rTOQ=;
 h=From:To:Cc:Subject:Date:From;
 b=kvM7fP1BCq7ls4azK/LnWuLBn1fQaSooIu0ttKDasI7roHXQTc0dWL58gKD1Nujg7
 JmbU0AMUospxHHT34Pb2g0j4jXSZ1sY8vJJbvEXmQBXvHa94v1wqBN23N5IGqcOQ4n
 2lYeUkYgmGP0INkOv7cIUX1cCqZGiFEUue688PFvj/jPSN0/CRXX8GJqibiJq+l/zd
 V+VNIdziJLcY65WVwS1LAxAofStZeMD0+v9F2M8SfZmQtdV+EFa65xYTvjC2rzW6oO
 e7qhhm0ReBlsNi7qWZCafGOwgQH6ID+YSPrYt/XrheBtnPaKyV9HWCQ/wsSrf0jPpi
 I6uDCofx+sboQ==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH] armv8: mmu: Extend mmu_map_region() to allow uncached mappings
Date: Fri,  8 May 2026 12:58:06 +0530
Message-ID: <20260508072806.2421694-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

On Qcom platforms, cmd-db region is required to be mapped as uncached
region especially when executing at EL2. Otherwise an xPU violation
can be triggered due to cache operations as descibed by a similar fix
for the kernel here:

Commit f9bb896eab22 ("soc: qcom: cmd-db: Map shared memory as WC, not WB")

So, let's map CMD-DB region as uncached to avoid any issues while
booting U-Boot in EL2 mode.

Fixes: a9cbf76e4dd3 ("soc: qcom: cmd-db: map cmd-db region")
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm/cpu/armv8/cache_v8.c | 11 ++++++++---
 arch/arm/include/asm/system.h |  3 ++-
 drivers/soc/qcom/cmd-db.c     |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21..05e90e1eb32 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -388,13 +388,18 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
 	}
 }
 
-void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
+void mmu_map_region(phys_addr_t addr, u64 size, bool cached, bool emergency)
 {
 	u64 va_bits;
 	int level = 0;
-	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE;
+	u64 attrs;
 
-	attrs |= PTE_TYPE_BLOCK | PTE_BLOCK_AF;
+	if (cached)
+		attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL);
+	else
+		attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC);
+
+	attrs |= PTE_BLOCK_INNER_SHARE | PTE_TYPE_BLOCK | PTE_BLOCK_AF;
 
 	get_tcr(NULL, &va_bits);
 	if (va_bits < 39)
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 5ed6833c155..52ab86112fb 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -306,9 +306,10 @@ void flush_l3_cache(void);
  *
  * @start: Start address of the region
  * @size: Size of the region
+ * @cached: Map memory as cacheable or not
  * @emerg: Also map the region in the emergency table
  */
-void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
+void mmu_map_region(phys_addr_t start, u64 size, bool cached, bool emerg);
 
 /**
  * mmu_change_region_attr() - change a mapped region attributes
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..61e15783123 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -248,7 +248,7 @@ static int cmd_db_bind(struct udevice *dev)
 	}
 
 	/* On SM8550/SM8650 and newer SoCs cmd-db might not be mapped */
-	mmu_map_region((phys_addr_t)base, (phys_size_t)size, false);
+	mmu_map_region((phys_addr_t)base, (phys_size_t)size, false, false);
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-- 
2.51.0

