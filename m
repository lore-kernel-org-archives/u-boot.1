Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8041CAC5A0
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 12:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F397C8318E;
	Thu, 18 Sep 2025 14:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="cqauEBl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D70C8319C; Thu, 18 Sep 2025 14:49:46 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F43D8003E
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 14:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1uzE4w-0003OL-Nv; Thu, 18 Sep 2025 08:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=LAhk7qhC4YmeYQsz7w5lArGChNesJPV88fZwbgBUQI0=; b=cqauEBl61kYNp6
 DKsFSxHfHKwEKuhu96zG4hvA7lhMQtPKDCYJRDmijWOE+P4B8GNgJ+tEg8e8F7cSkJFFne9di6Vdd
 MIYchbuEmScM0rXA0HaK0B4epTbVcdTG1JQ348/+Nm0wVLZI3fQ2tf+tAakA7QIBNJZpgKwDGrg4b
 eT4LDELVjvGR6FliiZRYgPKE8UMSmt8B4Cdb0ZqvKV+NcSbGbplP4cwQAoH6iw00TDP3ayqqur35o
 0q+YIUuSASutPEIicegw+tYgESGuaXcFalCZdL9xhKGsiVi+AD72v9elT4jG7vaWbhnny+do66YA3
 v6tVhXYBzUlttZ7jdb8g==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul@pbarker.dev>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Mathieu Othacehe <othacehe@gnu.org>, u-boot@lists.denx.de
Cc: anton.reding@landisgyr.com
Subject: [PATCH] board: rzg2l: Do not expect a DTB blob from the TF-A.
Date: Thu, 18 Sep 2025 14:48:27 +0200
Message-ID: <20250918124827.5577-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.49.0
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

On the RZG2L platform, the advised
TF-A (https://github.com/renesas-rz/rzg_trusted-firmware-a/tree/v2.5/rzg2l)
does not pass any DTB blob to U-Boot.

On the other hand, the RZG2L part of U-Boot expects a DTB to be passed.  It
means that if one flashes the latest TF-A as well as the mainline U-Boot,
it will crash trying to dereference the NULL DTB pointer before outputing
anything, which is painful to debug.

As the renesas_rzg2l_smarc_defconfig U-Boot configuration (the only RZG2L
supported configuration) is anyway embedding only the
renesas/r9a07g044l2-smarc.dts device-tree, it is fair to assume that we are
booting from that platform.

Remove any DTB blob expectation and assume that we are booting from the
platform we are compiling U-Boot for.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/mach-renesas/cpu_info-rzg2l.c | 25 ++--------------
 board/renesas/rzg2l/rzg2l.c            | 40 --------------------------
 2 files changed, 2 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-renesas/cpu_info-rzg2l.c b/arch/arm/mach-renesas/cpu_info-rzg2l.c
index ab95ce76388..97e0eb419a4 100644
--- a/arch/arm/mach-renesas/cpu_info-rzg2l.c
+++ b/arch/arm/mach-renesas/cpu_info-rzg2l.c
@@ -10,9 +10,6 @@
 
 #define SYSC_LSI_DEVID		0x11020A04
 
-/* If the firmware passed a device tree, use it for soc identification. */
-extern u64 rcar_atf_boot_args[];
-
 /* CPU information table */
 struct tfa_info {
 	const char *soc_name;
@@ -24,32 +21,14 @@ static const struct tfa_info tfa_info[] = {
 	{ "renesas,r9a07g044l2", "R9A07G044L", RENESAS_CPU_TYPE_R9A07G044L },
 };
 
-static const struct tfa_info invalid_tfa_info = { NULL, "(invalid)", 0 };
-
-static const struct tfa_info *get_tfa_info(void)
-{
-	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
-
-	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC) {
-		unsigned int i;
-		for (i = 0; i < ARRAY_SIZE(tfa_info); i++) {
-			if (!fdt_node_check_compatible(atf_fdt_blob, 0,
-						       tfa_info[i].soc_name))
-				return &tfa_info[i];
-		}
-	}
-
-	return &invalid_tfa_info;
-}
-
 const u8 *rzg_get_cpu_name(void)
 {
-	return get_tfa_info()->cpu_name;
+	return tfa_info->cpu_name;
 }
 
 u32 renesas_get_cpu_type(void)
 {
-	return get_tfa_info()->cpu_type;
+	return tfa_info->cpu_type;
 }
 
 u32 renesas_get_cpu_rev_integer(void)
diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
index 509c5dbb156..0bdf030eb15 100644
--- a/board/renesas/rzg2l/rzg2l.c
+++ b/board/renesas/rzg2l/rzg2l.c
@@ -7,46 +7,6 @@
 #include <fdtdec.h>
 #include <linux/libfdt.h>
 
-#if IS_ENABLED(CONFIG_MULTI_DTB_FIT)
-/* If the firmware passed a device tree, use it for board identification. */
-extern u64 rcar_atf_boot_args[];
-
-static bool is_rzg2l_board(const char *board_name)
-{
-	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
-
-	return fdt_node_check_compatible(atf_fdt_blob, 0, board_name) == 0;
-}
-
-int board_fit_config_name_match(const char *name)
-{
-	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
-
-	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
-		return -1;
-
-	if (is_rzg2l_board("renesas,r9a07g044l2"))
-		return strcmp(name, "r9a07g044l2-smarc");
-
-	return -1;
-}
-#endif
-
-static void apply_atf_overlay(void *fdt_blob)
-{
-	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
-
-	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC)
-		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0);
-}
-
-int fdtdec_board_setup(const void *fdt_blob)
-{
-	apply_atf_overlay((void *)fdt_blob);
-
-	return 0;
-}
-
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	return 0;
-- 
2.49.0

