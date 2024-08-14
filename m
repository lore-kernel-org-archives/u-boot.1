Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F6C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D658388AA9;
	Wed, 14 Aug 2024 13:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4283B88A66; Wed, 14 Aug 2024 13:02:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 05EC588A79
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62A29DA7;
 Wed, 14 Aug 2024 04:03:09 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32B03F58B;
 Wed, 14 Aug 2024 04:02:38 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 26/32] stm32mp: compute ram_top based on the optee base
 address
Date: Wed, 14 Aug 2024 16:30:03 +0530
Message-Id: <20240814110009.45310-27-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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

The value of ram_top address currently gets computed in an indirect
manner. The boot_fdt_add_mem_rsv_regions() function gets called first
to reserve the memory region occupied by OP-TEE in the LMB memory
map. This is followed by a call to the lmb_alloc() API, which returns
an address which is below the OP-TEE base address. This address is the
value of ram_top returned by the board_get_usable_ram_top() function.

This has now changed, as the LMB memory map, which is no longer local,
gets set up after relocation. Get the OP-TEE base address by reading
the device tree, and set the ram_top from this value.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 arch/arm/mach-stm32mp/dram_init.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index b3dbd521b7..32baefca71 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -62,8 +62,10 @@ int dram_init(void)
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
+	int ret;
 	phys_size_t size;
 	phys_addr_t reg;
+	u32 optee_start, optee_size;
 
 	if (!total_size)
 		return gd->ram_top;
@@ -73,16 +75,10 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	 * if the effective available memory is bigger
 	 */
 	gd->ram_top = clamp_val(gd->ram_top, 0, SZ_4G - 1);
+	size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
 
-	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_add(gd->ram_base, gd->ram_top - gd->ram_base);
-	boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob);
-	/* add 8M for reserved memory for display, fdt, gd,... */
-	size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE),
-	reg = lmb_alloc(size, MMU_SECTION_SIZE);
-
-	if (!reg)
-		reg = gd->ram_top - size;
+	ret = optee_get_reserved_memory(&optee_start, &optee_size);
+	reg = (!ret ? optee_start : gd->ram_top) - size;
 
 	/* before relocation, mark the U-Boot memory as cacheable by default */
 	if (!(gd->flags & GD_FLG_RELOC))
-- 
2.34.1

