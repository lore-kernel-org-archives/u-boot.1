Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68885E6B242
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1FD88B55;
	Fri,  1 Nov 2024 11:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="tT4RjAbw";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZXtbNvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FBC88DF4; Fri,  1 Nov 2024 11:17:49 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A3B4889D2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EA254254012E;
 Fri,  1 Nov 2024 06:17:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Fri, 01 Nov 2024 06:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1730456265;
 x=1730542665; bh=EDlxF/lGjaZqSQCFt6zYPtTZ3B3mTCT4JirT5pi/0xs=; b=
 tT4RjAbwF8lvu/+mgt25Xq5SfKaB32KHgDYkn/OiOFCqgqDt/GfcmfQeG3HFqxWt
 IS0nlm+J8M/ZDSnk+/wt+HcwVCMr6VcGBsBjOzoJCtndhrWg5ZS0My2HRFtgcCDc
 fmA2H1fx3gISp5lQLaCtKBYcx6M+U4pDZL6LoLSGI5hXKuzPNiZq3+H2BZw6V8yh
 2tACK2mNEwxUdL0Sk2mGy9opTrv0qZ/ZkGVHS9M5URQ3OpejPsmVjiHulQRv0q+I
 B/VzF41aqdtjpBxxCTCLEscIxiJsvKdjSnKGXjJVNQnRlHUhulHDLPwI5+5Hdud2
 upqxmWR/KHdv1wqlLjeOqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730456265; x=
 1730542665; bh=EDlxF/lGjaZqSQCFt6zYPtTZ3B3mTCT4JirT5pi/0xs=; b=k
 ZXtbNvcAuvJQKHXwame1zOnSUKumD5KYVppgq6e0iecCax5fGhhZV7Ze1/QHTAsd
 k20i41e+tslQqPFumdxXUNmV16vE00PriQtqq8qe5NMKCKKill7+/2rCNzoTVG57
 5afrhWr+D9MsupXFBOAqqns9nVDpl1QsnHGpnpZbaaiVStszLy5JczRUY4Eq6JJq
 qd3CZxk7NSbtqfis/04vK2YSm5PAREZnukAgKwi8XfppDFg7aKUMwjFsPnxmuzss
 jcIpEnDfoTSz4NXtRcX+WhDFVTtCFc0a19LBdpPN/qfCNakzxPpJQrOYkFwv7DmA
 jCujt4QKPEkuKscPIGJHQ==
X-ME-Sender: <xms:yaokZ-XaC839IPkjUMAvExpXZde8hCHpLkWTp1xk_xlsw6HLhV3aPQ>
 <xme:yaokZ6kNyJ2pHVPnh2BPAViSh_Qc816XA7WPZXiNyo-qd-YYliInhx48An8mKj5nU
 XI8QDwYei5ipHygYGw>
X-ME-Received: <xmr:yaokZyb_nwe2UZsBo-A-XvCxJ_CKLOdWSxnT3479658kjZvgmLfdJcR4am4oOSNrhDR2bf78TxH4ZFjxRkbvz5kUXBRr2aTc_iM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepfeehheeileduffehteeihfdvtdelffdutdeludduiedutedv
 feffheekhefgtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprh
 gtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprhgtphhtthhopehs
 uhhghhhoshhhrdhgrghnuheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhjghestg
 hhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghn
 gidruggvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:yaokZ1UzR24o-wn8DuWPw5j6KRHFdHuLCvvKqElOOnB-Vcy2xHO6nw>
 <xmx:yaokZ4n9DjGRN1AnGKwfu1aAppTvUCXyKbv0EMw9QTeQGi7WjkLeKQ>
 <xmx:yaokZ6elXWSSr9r3HUq5k_RB5iF34HC48yrl8ZIZDlUXOnizFye6kw>
 <xmx:yaokZ6EjRdm1nE5EibRy2Y7TJitqWQdCp8Q8N3s822O8NrBGJpdW5A>
 <xmx:yaokZ2bD6eL5E_7ee4lLg2RGco8BjpxfIRyAA7NM5RRkM_becRn3q4Cl>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 06:17:45 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 01 Nov 2024 11:15:52 +0100
Subject: [PATCH 2/4] lmb: cosmetic: reorder functions and global LMB variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-io_lmb_apple_dart_iommu-v1-2-fe4b9a74d47c@jannau.net>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
In-Reply-To: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14783; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=7nJsgL6d/7s6/dh09NTpMHt5t0/Pwcd+p7a7ND4n3Xo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnSVVeFXdJsn17w8dDl87by1TJ2Hm8v81/ziNY5+umZpe
 oaBr8XejlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABOZKM3wv+Y0W7X2Boeju2QM
 ilsu/3rWWWBlHiwlvDDPI15xtvUcR4b/FVf2OS/OWJK38HWfKc85Yc5CzRc2a/6tlJ1zYl5CwN0
 drAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Low lovel LMB functionality will be used to manage IOVA space in the
Apple dart iommu driver. This reordering ensures that those function
can not access the global LMB memory map variable.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/lmb.c | 496 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 254 insertions(+), 242 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 5be0d9dd89a506dc1e6e6951cc54441a8d4bb0df..2ce91f7521cfe58577b092fdaea8004b17f0eeff 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -27,97 +27,11 @@ DECLARE_GLOBAL_DATA_PTR;
 #define MAP_OP_FREE		(u8)0x2
 #define MAP_OP_ADD		(u8)0x3
 
-static struct lmb lmb;
-
-static bool lmb_should_notify(enum lmb_flags flags)
-{
-	return !lmb.test && !(flags & LMB_NONOTIFY) &&
-		CONFIG_IS_ENABLED(EFI_LOADER);
-}
-
-static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
-						phys_size_t size,
-						u8 op, enum lmb_flags flags)
-{
-	u64 efi_addr;
-	u64 pages;
-	efi_status_t status;
-
-	if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
-		log_err("Invalid map update op received (%d)\n", op);
-		return -1;
-	}
-
-	if (!lmb_should_notify(flags))
-		return 0;
-
-	efi_addr = (uintptr_t)map_sysmem(addr, 0);
-	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
-	efi_addr &= ~EFI_PAGE_MASK;
-
-	status = efi_add_memory_map_pg(efi_addr, pages,
-				       op == MAP_OP_RESERVE ?
-				       EFI_BOOT_SERVICES_DATA :
-				       EFI_CONVENTIONAL_MEMORY,
-				       false);
-	if (status != EFI_SUCCESS) {
-		log_err("%s: LMB Map notify failure %lu\n", __func__,
-			status & ~EFI_ERROR_MASK);
-		return -1;
-	}
-	unmap_sysmem((void *)(uintptr_t)efi_addr);
-
-	return 0;
-}
-
-static void lmb_print_region_flags(enum lmb_flags flags)
-{
-	u64 bitpos;
-	const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
-
-	do {
-		bitpos = flags ? fls(flags) - 1 : 0;
-		assert_noisy(bitpos < ARRAY_SIZE(flag_str));
-		printf("%s", flag_str[bitpos]);
-		flags &= ~(1ull << bitpos);
-		puts(flags ? ", " : "\n");
-	} while (flags);
-}
-
-static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
-{
-	struct lmb_region *rgn = lmb_rgn_lst->data;
-	unsigned long long base, size, end;
-	enum lmb_flags flags;
-	int i;
-
-	printf(" %s.count = 0x%x\n", name, lmb_rgn_lst->count);
-
-	for (i = 0; i < lmb_rgn_lst->count; i++) {
-		base = rgn[i].base;
-		size = rgn[i].size;
-		end = base + size - 1;
-		flags = rgn[i].flags;
-
-		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
-		       name, i, base, end, size);
-		lmb_print_region_flags(flags);
-	}
-}
-
-void lmb_dump_all_force(void)
-{
-	printf("lmb_dump_all:\n");
-	lmb_dump_region(&lmb.free_mem, "memory");
-	lmb_dump_region(&lmb.used_mem, "reserved");
-}
-
-void lmb_dump_all(void)
-{
-#ifdef DEBUG
-	lmb_dump_all_force();
-#endif
-}
+/*
+ * The following low level LMB functions must not access the global LMB memory
+ * map since they are also used to manage IOVA memory maps in iommu drivers like
+ * apple_dart.
+ */
 
 static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
 			      phys_addr_t base2, phys_size_t size2)
@@ -206,117 +120,6 @@ static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
 	lmb_remove_region(lmb_rgn_lst, r2);
 }
 
-static void lmb_reserve_uboot_region(void)
-{
-	int bank;
-	ulong end, bank_end;
-	phys_addr_t rsv_start;
-
-	rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
-	end = gd->ram_top;
-
-	/*
-	 * Reserve memory from aligned address below the bottom of U-Boot stack
-	 * until end of RAM area to prevent LMB from overwriting that memory.
-	 */
-	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
-
-	/* adjust sp by 16K to be safe */
-	rsv_start -= SZ_16K;
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		if (!gd->bd->bi_dram[bank].size ||
-		    rsv_start < gd->bd->bi_dram[bank].start)
-			continue;
-		/* Watch out for RAM at end of address space! */
-		bank_end = gd->bd->bi_dram[bank].start +
-			gd->bd->bi_dram[bank].size - 1;
-		if (rsv_start > bank_end)
-			continue;
-		if (bank_end > end)
-			bank_end = end - 1;
-
-		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
-				  LMB_NOOVERWRITE);
-
-		if (gd->flags & GD_FLG_SKIP_RELOC)
-			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
-					  gd->mon_len, LMB_NOOVERWRITE);
-
-		break;
-	}
-}
-
-static void lmb_reserve_common(void *fdt_blob)
-{
-	lmb_reserve_uboot_region();
-
-	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
-		boot_fdt_add_mem_rsv_regions(fdt_blob);
-}
-
-static __maybe_unused void lmb_reserve_common_spl(void)
-{
-	phys_addr_t rsv_start;
-	phys_size_t rsv_size;
-
-	/*
-	 * Assume a SPL stack of 16KB. This must be
-	 * more than enough for the SPL stage.
-	 */
-	if (IS_ENABLED(CONFIG_SPL_STACK_R_ADDR)) {
-		rsv_start = gd->start_addr_sp - 16384;
-		rsv_size = 16384;
-		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
-	}
-
-	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)) {
-		/* Reserve the bss region */
-		rsv_start = (phys_addr_t)(uintptr_t)__bss_start;
-		rsv_size = (phys_addr_t)(uintptr_t)__bss_end -
-			(phys_addr_t)(uintptr_t)__bss_start;
-		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
-	}
-}
-
-/**
- * lmb_add_memory() - Add memory range for LMB allocations
- *
- * Add the entire available memory range to the pool of memory that
- * can be used by the LMB module for allocations.
- *
- * Return: None
- */
-void lmb_add_memory(void)
-{
-	int i;
-	phys_size_t size;
-	u64 ram_top = gd->ram_top;
-	struct bd_info *bd = gd->bd;
-
-	if (CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP))
-		return lmb_arch_add_memory();
-
-	/* Assume a 4GB ram_top if not defined */
-	if (!ram_top)
-		ram_top = 0x100000000ULL;
-
-	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		size = bd->bi_dram[i].size;
-		if (size) {
-			lmb_add(bd->bi_dram[i].start, size);
-
-			/*
-			 * Reserve memory above ram_top as
-			 * no-overwrite so that it cannot be
-			 * allocated
-			 */
-			if (bd->bi_dram[i].start >= ram_top)
-				lmb_reserve_flags(bd->bi_dram[i].start, size,
-						  LMB_NOOVERWRITE);
-		}
-	}
-}
-
 static long lmb_resize_regions(struct alist *lmb_rgn_lst,
 			       unsigned long idx_start,
 			       phys_addr_t base, phys_size_t size)
@@ -476,25 +279,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 	return 0;
 }
 
-static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
-			   phys_size_t size)
-{
-	return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
-}
-
-/* This routine may be called with relocation disabled. */
-long lmb_add(phys_addr_t base, phys_size_t size)
-{
-	long ret;
-	struct alist *lmb_rgn_lst = &lmb.free_mem;
-
-	ret = lmb_add_region(lmb_rgn_lst, base, size);
-	if (ret)
-		return ret;
-
-	return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
-}
-
 static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
 		      phys_size_t size)
 {
@@ -546,6 +330,255 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
 				    rgn[i].flags);
 }
 
+static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
+				phys_size_t size)
+{
+	unsigned long i;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		phys_addr_t rgnbase = rgn[i].base;
+		phys_size_t rgnsize = rgn[i].size;
+		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
+			break;
+	}
+
+	return (i < lmb_rgn_lst->count) ? i : -1;
+}
+
+static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
+{
+	return addr & ~(size - 1);
+}
+
+/*
+ * Low level LMB functions are used to manage IOVA memory maps for the Apple
+ * dart iommu. They must not access the global LMB memory map.
+ * So keep the global LMB variable declaration unreachable from them.
+ */
+
+static struct lmb lmb;
+
+static bool lmb_should_notify(enum lmb_flags flags)
+{
+	return !lmb.test && !(flags & LMB_NONOTIFY) &&
+		CONFIG_IS_ENABLED(EFI_LOADER);
+}
+
+static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
+						phys_size_t size,
+						u8 op, enum lmb_flags flags)
+{
+	u64 efi_addr;
+	u64 pages;
+	efi_status_t status;
+
+	if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
+		log_err("Invalid map update op received (%d)\n", op);
+		return -1;
+	}
+
+	if (!lmb_should_notify(flags))
+		return 0;
+
+	efi_addr = (uintptr_t)map_sysmem(addr, 0);
+	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
+	efi_addr &= ~EFI_PAGE_MASK;
+
+	status = efi_add_memory_map_pg(efi_addr, pages,
+				       op == MAP_OP_RESERVE ?
+				       EFI_BOOT_SERVICES_DATA :
+				       EFI_CONVENTIONAL_MEMORY,
+				       false);
+	if (status != EFI_SUCCESS) {
+		log_err("%s: LMB Map notify failure %lu\n", __func__,
+			status & ~EFI_ERROR_MASK);
+		return -1;
+	}
+	unmap_sysmem((void *)(uintptr_t)efi_addr);
+
+	return 0;
+}
+
+static void lmb_print_region_flags(enum lmb_flags flags)
+{
+	u64 bitpos;
+	const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
+
+	do {
+		bitpos = flags ? fls(flags) - 1 : 0;
+		assert_noisy(bitpos < ARRAY_SIZE(flag_str));
+		printf("%s", flag_str[bitpos]);
+		flags &= ~(1ull << bitpos);
+		puts(flags ? ", " : "\n");
+	} while (flags);
+}
+
+static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
+{
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+	unsigned long long base, size, end;
+	enum lmb_flags flags;
+	int i;
+
+	printf(" %s.count = 0x%x\n", name, lmb_rgn_lst->count);
+
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		base = rgn[i].base;
+		size = rgn[i].size;
+		end = base + size - 1;
+		flags = rgn[i].flags;
+
+		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
+		       name, i, base, end, size);
+		lmb_print_region_flags(flags);
+	}
+}
+
+void lmb_dump_all_force(void)
+{
+	printf("lmb_dump_all:\n");
+	lmb_dump_region(&lmb.free_mem, "memory");
+	lmb_dump_region(&lmb.used_mem, "reserved");
+}
+
+void lmb_dump_all(void)
+{
+#ifdef DEBUG
+	lmb_dump_all_force();
+#endif
+}
+
+static void lmb_reserve_uboot_region(void)
+{
+	int bank;
+	ulong end, bank_end;
+	phys_addr_t rsv_start;
+
+	rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
+	end = gd->ram_top;
+
+	/*
+	 * Reserve memory from aligned address below the bottom of U-Boot stack
+	 * until end of RAM area to prevent LMB from overwriting that memory.
+	 */
+	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
+
+	/* adjust sp by 16K to be safe */
+	rsv_start -= SZ_16K;
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		if (!gd->bd->bi_dram[bank].size ||
+		    rsv_start < gd->bd->bi_dram[bank].start)
+			continue;
+		/* Watch out for RAM at end of address space! */
+		bank_end = gd->bd->bi_dram[bank].start +
+			gd->bd->bi_dram[bank].size - 1;
+		if (rsv_start > bank_end)
+			continue;
+		if (bank_end > end)
+			bank_end = end - 1;
+
+		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
+				  LMB_NOOVERWRITE);
+
+		if (gd->flags & GD_FLG_SKIP_RELOC)
+			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
+					  gd->mon_len, LMB_NOOVERWRITE);
+
+		break;
+	}
+}
+
+static void lmb_reserve_common(void *fdt_blob)
+{
+	lmb_reserve_uboot_region();
+
+	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
+		boot_fdt_add_mem_rsv_regions(fdt_blob);
+}
+
+static __maybe_unused void lmb_reserve_common_spl(void)
+{
+	phys_addr_t rsv_start;
+	phys_size_t rsv_size;
+
+	/*
+	 * Assume a SPL stack of 16KB. This must be
+	 * more than enough for the SPL stage.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_STACK_R_ADDR)) {
+		rsv_start = gd->start_addr_sp - 16384;
+		rsv_size = 16384;
+		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)) {
+		/* Reserve the bss region */
+		rsv_start = (phys_addr_t)(uintptr_t)__bss_start;
+		rsv_size = (phys_addr_t)(uintptr_t)__bss_end -
+			(phys_addr_t)(uintptr_t)__bss_start;
+		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
+	}
+}
+
+/**
+ * lmb_add_memory() - Add memory range for LMB allocations
+ *
+ * Add the entire available memory range to the pool of memory that
+ * can be used by the LMB module for allocations.
+ *
+ * Return: None
+ */
+void lmb_add_memory(void)
+{
+	int i;
+	phys_size_t size;
+	u64 ram_top = gd->ram_top;
+	struct bd_info *bd = gd->bd;
+
+	if (CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP))
+		return lmb_arch_add_memory();
+
+	/* Assume a 4GB ram_top if not defined */
+	if (!ram_top)
+		ram_top = 0x100000000ULL;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		size = bd->bi_dram[i].size;
+		if (size) {
+			lmb_add(bd->bi_dram[i].start, size);
+
+			/*
+			 * Reserve memory above ram_top as
+			 * no-overwrite so that it cannot be
+			 * allocated
+			 */
+			if (bd->bi_dram[i].start >= ram_top)
+				lmb_reserve_flags(bd->bi_dram[i].start, size,
+						  LMB_NOOVERWRITE);
+		}
+	}
+}
+
+static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
+			   phys_size_t size)
+{
+	return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
+}
+
+/* This routine may be called with relocation disabled. */
+long lmb_add(phys_addr_t base, phys_size_t size)
+{
+	long ret;
+	struct alist *lmb_rgn_lst = &lmb.free_mem;
+
+	ret = lmb_add_region(lmb_rgn_lst, base, size);
+	if (ret)
+		return ret;
+
+	return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
+}
+
 /**
  * lmb_free_flags() - Free up a region of memory
  * @base: Base Address of region to be freed
@@ -590,27 +623,6 @@ long lmb_reserve(phys_addr_t base, phys_size_t size)
 	return lmb_reserve_flags(base, size, LMB_NONE);
 }
 
-static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
-				phys_size_t size)
-{
-	unsigned long i;
-	struct lmb_region *rgn = lmb_rgn_lst->data;
-
-	for (i = 0; i < lmb_rgn_lst->count; i++) {
-		phys_addr_t rgnbase = rgn[i].base;
-		phys_size_t rgnsize = rgn[i].size;
-		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
-			break;
-	}
-
-	return (i < lmb_rgn_lst->count) ? i : -1;
-}
-
-static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
-{
-	return addr & ~(size - 1);
-}
-
 static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 				    phys_addr_t max_addr, enum lmb_flags flags)
 {

-- 
2.47.0

