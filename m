Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9057E87827
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551AE841DF;
	Tue,  3 Feb 2026 14:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="YWcUO6sD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0088F84105; Tue,  3 Feb 2026 14:08:51 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED1D883FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id BBE7B26EE1;
 Tue,  3 Feb 2026 14:08:48 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WpbH5obRlEvO; Tue,  3 Feb 2026 14:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124128; bh=iid11dL+XhiTWQrX67cQ/7tBPmLWSXW/uoXKkMC9NT4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YWcUO6sD3HjRCfI9DqMNP96WVq4JkDL4iAcznlLce9ZWhY08+B7wx9Jca5xhPbOy8
 hu5UibIQFjHSqTzh9o6lW/QSE+AxjnajtUUNwzwjFlSv73mAZVCP2LvUFnP7FuQkjt
 t0a3jIRWmsR5ypJfEZtC/dzVpiGdtwb/nxlzem5i75QdLMKze/jzWbPtozm9N2gWRk
 wjDtSgNUIvSjlxSJH8WeNUCKxDhN5qv1Bk8fARvYFtIKgXRpF8AtSADvqZVvp1ma6I
 RsnjpAGvnOgUlkfSG9lonS0KgZdOlXwKkVtax2nznJsbj6HuZXPfn5Qx7B4rLTgTpg
 Jbkla5Gqk/iTg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:39 +0530
Subject: [PATCH 01/11] board: samsung: exynos-mobile: simplify parsing RAM
 banks from device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-1-a16a0e57991c@disroot.org>
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

Remove the baked-in bank addresses used for figuring out RAM banks from
device tree. Instead, sequentially fill in the bank addresses and sizes,
and doing away with an extra array for specifying bases.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 board/samsung/exynos-mobile/exynos-mobile.c | 38 +++++++++++------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index 8ef38816abf..915bda64082 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -27,7 +27,6 @@ DECLARE_GLOBAL_DATA_PTR;
 struct exynos_board_info {
 	const char *name;
 	const char *chip;
-	const u64 *const dram_bank_bases;
 
 	char serial[64];
 
@@ -54,10 +53,6 @@ static struct mm_region exynos_mem_map[CONFIG_NR_DRAM_BANKS + 2] = {
 
 struct mm_region *mem_map = exynos_mem_map;
 
-static const u64 exynos7870_common_dram_bank_bases[CONFIG_NR_DRAM_BANKS] = {
-	0x40000000, 0x80000000, 0x100000000,
-};
-
 static const char *exynos_prev_bl_get_bootargs(void)
 {
 	void *prev_bl_fdt_base = (void *)get_prev_bl_fdt_addr();
@@ -157,7 +152,6 @@ static struct exynos_board_info exynos_board_info_match[] = {
 		/* Samsung Galaxy A2 Core */
 		.name = "a2corelte",
 		.chip = "exynos7870",
-		.dram_bank_bases = exynos7870_common_dram_bank_bases,
 		.match = exynos7870_fdt_match,
 		.match_model = "A260",
 		.match_max_rev = U8_MAX,
@@ -165,7 +159,6 @@ static struct exynos_board_info exynos_board_info_match[] = {
 		/* Samsung Galaxy J6 */
 		.name = "j6lte",
 		.chip = "exynos7870",
-		.dram_bank_bases = exynos7870_common_dram_bank_bases,
 		.match = exynos7870_fdt_match,
 		.match_model = "J600",
 		.match_max_rev = U8_MAX,
@@ -173,18 +166,17 @@ static struct exynos_board_info exynos_board_info_match[] = {
 		/* Samsung Galaxy J7 Prime */
 		.name = "on7xelte",
 		.chip = "exynos7870",
-		.dram_bank_bases = exynos7870_common_dram_bank_bases,
 		.match = exynos7870_fdt_match,
 		.match_model = "G610",
 		.match_max_rev = U8_MAX,
 	},
 };
 
-static void exynos_parse_dram_banks(const struct exynos_board_info *board_info,
-				    const void *fdt_base)
+static void exynos_parse_dram_banks(const void *fdt_base)
 {
 	u64 mem_addr, mem_size = 0;
-	u32 na, ns, i, j;
+	u32 na, ns, i;
+	int index = 1;
 	int offset;
 
 	if (fdt_check_header(fdt_base) < 0)
@@ -199,6 +191,9 @@ static void exynos_parse_dram_banks(const struct exynos_board_info *board_info,
 			continue;
 
 		for (i = 0; ; i++) {
+			if (index > CONFIG_NR_DRAM_BANKS)
+				break;
+
 			mem_addr = fdtdec_get_addr_size_fixed(fdt_base, offset,
 							      "reg", i, na, ns,
 							      &mem_size, false);
@@ -208,17 +203,12 @@ static void exynos_parse_dram_banks(const struct exynos_board_info *board_info,
 			if (!mem_size)
 				continue;
 
-			for (j = 0; j < CONFIG_NR_DRAM_BANKS; j++) {
-				if (board_info->dram_bank_bases[j] != mem_addr)
-					continue;
-
-				mem_map[j + 1].phys = mem_addr;
-				mem_map[j + 1].virt = mem_addr;
-				mem_map[j + 1].size = mem_size;
-				mem_map[j + 1].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-						       PTE_BLOCK_INNER_SHARE;
-				break;
-			}
+			mem_map[index].phys = mem_addr;
+			mem_map[index].virt = mem_addr;
+			mem_map[index].size = mem_size;
+			mem_map[index].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+					       PTE_BLOCK_INNER_SHARE;
+			index++;
 		}
 	}
 }
@@ -334,7 +324,7 @@ int board_early_init_f(void)
 		return -ENODATA;
 	board_info = (const struct exynos_board_info *)gd->board_type;
 
-	exynos_parse_dram_banks(board_info, gd->fdt_blob);
+	exynos_parse_dram_banks(gd->fdt_blob);
 	/*
 	 * Some devices have multiple variants based on the amount of
 	 * memory and internal storage. The lowest bank base has been
@@ -342,7 +332,7 @@ int board_early_init_f(void)
 	 * For variants with more memory, the previous bootloader should
 	 * overlay the devicetree with the required extra memory ranges.
 	 */
-	exynos_parse_dram_banks(board_info, (const void *)get_prev_bl_fdt_addr());
+	exynos_parse_dram_banks((const void *)get_prev_bl_fdt_addr());
 
 	return 0;
 }

-- 
2.52.0

