Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1149C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1008B88A25;
	Wed, 14 Aug 2024 13:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E77788A2C; Wed, 14 Aug 2024 13:01:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4EA1F88A35
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B375FFEC;
 Wed, 14 Aug 2024 04:01:58 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D0A83F58B;
 Wed, 14 Aug 2024 04:01:28 -0700 (PDT)
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
Subject: [PATCH v2 12/32] lmb: remove the lmb_init_and_reserve() function
Date: Wed, 14 Aug 2024 16:29:49 +0530
Message-Id: <20240814110009.45310-13-sughosh.ganu@linaro.org>
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

With the changes to make the LMB reservations persistent, the common
memory regions are being added during board init. Remove the
now superfluous lmb_init_and_reserve() function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since V1: None

 arch/arm/mach-apple/board.c          |  2 --
 arch/arm/mach-snapdragon/board.c     |  2 --
 arch/arm/mach-stm32mp/stm32mp1/cpu.c |  3 ---
 cmd/bdinfo.c                         |  1 -
 cmd/load.c                           |  2 --
 fs/fs.c                              |  1 -
 include/lmb.h                        |  1 -
 lib/lmb.c                            | 13 -------------
 net/tftp.c                           |  2 --
 net/wget.c                           |  2 --
 test/cmd/bdinfo.c                    |  9 ---------
 11 files changed, 38 deletions(-)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 213390d6e8..0b6d290b8a 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -775,8 +775,6 @@ int board_late_init(void)
 {
 	u32 status = 0;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
-
 	/* somewhat based on the Linux Kernel boot requirements:
 	 * align by 2M and maximal FDT size 2M
 	 */
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index a63c8bec45..22a7d2a637 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -282,8 +282,6 @@ int board_late_init(void)
 {
 	u32 status = 0;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
-
 	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
 	status |= env_set_hex("kernel_addr_r", addr_alloc(SZ_128M));
 	status |= env_set_hex("ramdisk_addr_r", addr_alloc(SZ_128M));
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index a913737342..64480da9f8 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -141,9 +141,6 @@ int mach_cpu_init(void)
 
 void enable_caches(void)
 {
-	/* parse device tree when data cache is still activated */
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
-
 	/* I-cache is already enabled in start.S: icache_enable() not needed */
 
 	/* deactivate the data cache, early enabled in arch_cpu_init() */
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index b31e0208df..3c40dee143 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -162,7 +162,6 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
 #endif
 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
-		lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 		lmb_dump_all_force();
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			printf("devicetree  = %s\n", fdtdec_get_srcname());
diff --git a/cmd/load.c b/cmd/load.c
index 56da3a4c5d..20d802502a 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -153,8 +153,6 @@ static ulong load_serial(long offset)
 	int	line_count =  0;
 	long ret;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
-
 	while (read_record(record, SREC_MAXRECLEN + 1) >= 0) {
 		type = srec_decode(record, &binlen, &addr, binbuf);
 
diff --git a/fs/fs.c b/fs/fs.c
index 3fb00590be..4bc28d1dff 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -549,7 +549,6 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 	if (len && len < read_len)
 		read_len = len;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 	lmb_dump_all();
 
 	if (lmb_alloc_addr(addr, read_len) == addr)
diff --git a/include/lmb.h b/include/lmb.h
index 0827fa37a7..4a9070799e 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -63,7 +63,6 @@ struct lmb {
  */
 int lmb_init(void);
 
-void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
 void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
 				void *fdt_blob);
 long lmb_add(phys_addr_t base, phys_size_t size);
diff --git a/lib/lmb.c b/lib/lmb.c
index a7c4e59f8a..f803b5f63f 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -225,19 +225,6 @@ static void lmb_reserve_common(void *fdt_blob)
 		efi_lmb_reserve();
 }
 
-/* Initialize the struct, add memory and call arch/board reserve functions */
-void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
-{
-	int i;
-
-	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		if (bd->bi_dram[i].size)
-			lmb_add(bd->bi_dram[i].start, bd->bi_dram[i].size);
-	}
-
-	lmb_reserve_common(fdt_blob);
-}
-
 /* Initialize the struct, add memory and call arch/board reserve functions */
 void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
 				void *fdt_blob)
diff --git a/net/tftp.c b/net/tftp.c
index 99b2ab9fca..b5d227d8bc 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -718,8 +718,6 @@ static int tftp_init_load_addr(void)
 	if (CONFIG_IS_ENABLED(LMB)) {
 		phys_size_t max_size;
 
-		lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
-
 		max_size = lmb_get_free_size(image_load_addr);
 		if (!max_size)
 			return -1;
diff --git a/net/wget.c b/net/wget.c
index b8ea43e7f0..82a7e30ea7 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -75,8 +75,6 @@ static int wget_init_load_size(void)
 {
 	phys_size_t max_size;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
-
 	max_size = lmb_get_free_size(image_load_addr);
 	if (!max_size)
 		return -1;
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 34d2b141d8..1cd81a195b 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -113,14 +113,6 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
 		end = base + size - 1;
 		flags = rgn->region[i].flags;
 
-		/*
-		 * this entry includes the stack (get_sp()) on many platforms
-		 * so will different each time lmb_init_and_reserve() is called.
-		 * We could instead have the bdinfo command put its lmb region
-		 * in a known location, so we can check it directly, rather than
-		 * calling lmb_init_and_reserve() to create a new (and hopefully
-		 * identical one). But for now this seems good enough.
-		 */
 		if (!IS_ENABLED(CONFIG_SANDBOX) && i == 3) {
 			ut_assert_nextlinen(" %s[%d]\t[", name, i);
 			continue;
@@ -200,7 +192,6 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
 		struct lmb lmb;
 
-		lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 		ut_assertok(lmb_test_dump_all(uts, &lmb));
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
-- 
2.34.1

