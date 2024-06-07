Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF83CC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D966884D1;
	Fri,  7 Jun 2024 20:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CC4884D0; Fri,  7 Jun 2024 20:54:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 29B0788495
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FA9D1480;
 Fri,  7 Jun 2024 11:54:23 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAAD83F792;
 Fri,  7 Jun 2024 11:53:55 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 08/31] lmb: replcace the lmb_init_and_reserve() function
Date: Sat,  8 Jun 2024 00:22:17 +0530
Message-Id: <20240607185240.1892031-9-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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

With the changes to make the Logical Memory Block(LMB) allocations
persistent and with the common memory regions being reserved during
board init, the lmb_init_and_reserve() API can be removed and replaced
with a lmb_add_memory() API, which adds all the available memory to
the LMB pool.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 arch/arm/mach-apple/board.c          |  2 +-
 arch/arm/mach-snapdragon/board.c     |  2 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c |  2 +-
 cmd/bdinfo.c                         |  2 +-
 cmd/load.c                           |  2 +-
 fs/fs.c                              |  2 +-
 include/lmb.h                        | 12 +++++++++++-
 lib/lmb.c                            | 15 +++++++++++----
 net/tftp.c                           |  2 +-
 net/wget.c                           |  2 +-
 test/cmd/bdinfo.c                    | 10 +---------
 11 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index c877c7b94c..2e72d03edd 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -776,7 +776,7 @@ int board_late_init(void)
 {
 	u32 status = 0;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+	lmb_add_memory(gd->bd);
 
 	/* somewhat based on the Linux Kernel boot requirements:
 	 * align by 2M and maximal FDT size 2M
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index a63c8bec45..b3c9a21419 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -282,7 +282,7 @@ int board_late_init(void)
 {
 	u32 status = 0;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+	lmb_add_memory(gd->bd);
 
 	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
 	status |= env_set_hex("kernel_addr_r", addr_alloc(SZ_128M));
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index a223297034..8e3f001f74 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -143,7 +143,7 @@ int mach_cpu_init(void)
 void enable_caches(void)
 {
 	/* parse device tree when data cache is still activated */
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+	lmb_add_memory(gd->bd);
 
 	/* I-cache is already enabled in start.S: icache_enable() not needed */
 
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index e08d3e2cf3..fc408e9820 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -163,7 +163,7 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
 #endif
 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
-		lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+		lmb_add_memory(gd->bd);
 		lmb_dump_all_force();
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			printf("devicetree  = %s\n", fdtdec_get_srcname());
diff --git a/cmd/load.c b/cmd/load.c
index f019111991..9918523806 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -154,7 +154,7 @@ static ulong load_serial(long offset)
 	int	line_count =  0;
 	long ret;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+	lmb_add_memory(gd->bd);
 
 	while (read_record(record, SREC_MAXRECLEN + 1) >= 0) {
 		type = srec_decode(record, &binlen, &addr, binbuf);
diff --git a/fs/fs.c b/fs/fs.c
index 3c54eaa366..f72d3962d1 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -549,7 +549,7 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 	if (len && len < read_len)
 		read_len = len;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+	lmb_add_memory(gd->bd);
 	lmb_dump_all();
 
 	if (lmb_alloc_addr(addr, read_len) == addr)
diff --git a/include/lmb.h b/include/lmb.h
index f3e3f716e5..03bce2a50c 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -84,7 +84,17 @@ struct lmb {
 	struct lmb_region reserved;
 };
 
-void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
+/**
+ * lmb_add_memory() - Add memory range for LMB allocations
+ * @bd: pointer to board info structure
+ *
+ * Add the entire available memory range to the pool of memory that
+ * can be used by the LMB module for allocations.
+ *
+ * Return: None
+ *
+ */
+void lmb_add_memory(struct bd_info *bd);
 long lmb_add(phys_addr_t base, phys_size_t size);
 long lmb_reserve(phys_addr_t base, phys_size_t size);
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index 5c056800c3..de5a2cf23b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -240,8 +240,17 @@ void lmb_reserve_common(void *fdt_blob)
 		efi_lmb_reserve();
 }
 
-/* Initialize the struct, add memory and call arch/board reserve functions */
-void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
+/**
+ * lmb_add_memory() - Add memory range for LMB allocations
+ * @bd: pointer to board info structure
+ *
+ * Add the entire available memory range to the pool of memory that
+ * can be used by the LMB module for allocations.
+ *
+ * Return: None
+ *
+ */
+void lmb_add_memory(struct bd_info *bd)
 {
 	int i;
 
@@ -249,8 +258,6 @@ void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
 		if (bd->bi_dram[i].size)
 			lmb_add(bd->bi_dram[i].start, bd->bi_dram[i].size);
 	}
-
-	lmb_reserve_common(fdt_blob);
 }
 
 /* This routine called with relocation disabled. */
diff --git a/net/tftp.c b/net/tftp.c
index 02a5ca0f9f..54ac5e1262 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -714,7 +714,7 @@ static int tftp_init_load_addr(void)
 #ifdef CONFIG_LMB
 	phys_size_t max_size;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+	lmb_add_memory(gd->bd);
 
 	max_size = lmb_get_free_size(image_load_addr);
 	if (!max_size)
diff --git a/net/wget.c b/net/wget.c
index dbdc519946..87f2f33c8a 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -76,7 +76,7 @@ static int wget_init_load_size(void)
 {
 	phys_size_t max_size;
 
-	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+	lmb_add_memory(gd->bd);
 
 	max_size = lmb_get_free_size(image_load_addr);
 	if (!max_size)
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 31d5e28105..8ba785fc31 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -114,14 +114,6 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
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
@@ -201,7 +193,7 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
 		struct lmb lmb;
 
-		lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+		lmb_add_memory(gd->bd);
 		ut_assertok(lmb_test_dump_all(uts, &lmb));
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
-- 
2.34.1

