Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F265C2BA1A
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 19:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16EB088416;
	Mon, 17 Jun 2024 21:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D340888403; Mon, 17 Jun 2024 21:14:25 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968568832D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 21:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sJHo5-00CFal-Ac;
 Mon, 17 Jun 2024 19:14:21 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Michal Simek <michal.simek@amd.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v6 3/4] use fdt_kaslrseed function to de-duplicate code
Date: Mon, 17 Jun 2024 12:14:15 -0700
Message-Id: <20240617191416.1351790-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617191416.1351790-1-tharvey@gateworks.com>
References: <20240617191416.1351790-1-tharvey@gateworks.com>
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

Use the fdt_kaslrseed function to deduplicate code doing the same thing.

Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
but left in place in case boot scripts exist that rely on this command
existing and returning success. An informational message is printed to
alert users of this command that it is likely no longer needed.

Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
randomization and completely ignores the kaslr-seed for its own
randomness needs (i.e the randomization of the physical placement of
the kernel). It gets weeded out from the DTB that gets handed over via
efi_install_fdt() as it would also mess up the measured boot DTB TPM
measurements as well.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Chris Morgan <macromorgan@hotmail.com>
---
v6:
 - collected tags
v5:
 - fixed typo in commit message s/it's/its/
 - use cmd_process_error per Michal's suggestion
v4:
 - add missing /n to notice in kaslrseed cmd
 - combine ints in declaration
 - remove unused vars from board/xilinx/common/board.c ft_board_setup
v3:
 - skip if CONFIG_MEASURED_BOOT
 - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
 - pass in rng index and bool to specify overwrite
 - remove duplicate error strings printed outside of fdt_kaslrseed
 - added note to commit log about how EFI STUB weeds out kalsr-seed
v2:
 - fix typo in commit msg
 - use stack for seed to avoid unecessary malloc/free
 - move to a library function and deduplicate code by using it
   elsewhere
---
 board/xilinx/common/board.c | 40 ------------------------------
 boot/pxe_utils.c            | 34 +------------------------
 cmd/kaslrseed.c             | 49 ++++++-------------------------------
 3 files changed, 8 insertions(+), 115 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index b47d2d23f913..098738017bab 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -702,11 +702,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 #define MAX_RAND_SIZE 8
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
-	size_t n = MAX_RAND_SIZE;
-	struct udevice *dev;
-	u8 buf[MAX_RAND_SIZE];
-	int nodeoffset, ret;
-
 	static const struct node_info nodes[] = {
 		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
 	};
@@ -714,41 +709,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
 		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
 
-	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
-		debug("No RNG device\n");
-		return 0;
-	}
-
-	if (dm_rng_read(dev, buf, n)) {
-		debug("Reading RNG failed\n");
-		return 0;
-	}
-
-	if (!blob) {
-		debug("No FDT memory address configured. Please configure\n"
-		      "the FDT address via \"fdt addr <address>\" command.\n"
-		      "Aborting!\n");
-		return 0;
-	}
-
-	ret = fdt_check_header(blob);
-	if (ret < 0) {
-		debug("fdt_chosen: %s\n", fdt_strerror(ret));
-		return ret;
-	}
-
-	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
-	if (nodeoffset < 0) {
-		debug("Reading chosen node failed\n");
-		return nodeoffset;
-	}
-
-	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
-	if (ret < 0) {
-		debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
-		return ret;
-	}
-
 	return 0;
 }
 #endif
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 5c1c962ff4c1..38ca9b81a42d 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -324,10 +324,6 @@ static void label_boot_kaslrseed(void)
 #if CONFIG_IS_ENABLED(DM_RNG)
 	ulong fdt_addr;
 	struct fdt_header *working_fdt;
-	size_t n = 0x8;
-	struct udevice *dev;
-	u64 *buf;
-	int nodeoffset;
 	int err;
 
 	/* Get the main fdt and map it */
@@ -343,35 +339,7 @@ static void label_boot_kaslrseed(void)
 	if (err <= 0)
 		return;
 
-	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
-		printf("No RNG device\n");
-		return;
-	}
-
-	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
-	if (nodeoffset < 0) {
-		printf("Reading chosen node failed\n");
-		return;
-	}
-
-	buf = malloc(n);
-	if (!buf) {
-		printf("Out of memory\n");
-		return;
-	}
-
-	if (dm_rng_read(dev, buf, n)) {
-		printf("Reading RNG failed\n");
-		goto err;
-	}
-
-	err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
-	if (err < 0) {
-		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
-		goto err;
-	}
-err:
-	free(buf);
+	fdt_kaslrseed(working_fdt, true);
 #endif
 	return;
 }
diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
index 9acb8e163863..645cab2e74fd 100644
--- a/cmd/kaslrseed.c
+++ b/cmd/kaslrseed.c
@@ -16,56 +16,21 @@
 
 static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	size_t n = 0x8;
-	struct udevice *dev;
-	u64 *buf;
-	int nodeoffset;
-	int ret = CMD_RET_SUCCESS;
+	int err = CMD_RET_SUCCESS;
 
-	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
-		printf("No RNG device\n");
-		return CMD_RET_FAILURE;
-	}
-
-	buf = malloc(n);
-	if (!buf) {
-		printf("Out of memory\n");
-		return CMD_RET_FAILURE;
-	}
-
-	if (dm_rng_read(dev, buf, n)) {
-		printf("Reading RNG failed\n");
-		return CMD_RET_FAILURE;
-	}
+	printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed\n");
 
 	if (!working_fdt) {
 		printf("No FDT memory address configured. Please configure\n"
 		       "the FDT address via \"fdt addr <address>\" command.\n"
 		       "Aborting!\n");
-		return CMD_RET_FAILURE;
-	}
-
-	ret = fdt_check_header(working_fdt);
-	if (ret < 0) {
-		printf("fdt_chosen: %s\n", fdt_strerror(ret));
-		return CMD_RET_FAILURE;
-	}
-
-	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
-	if (nodeoffset < 0) {
-		printf("Reading chosen node failed\n");
-		return CMD_RET_FAILURE;
+		err = CMD_RET_FAILURE;
+	} else {
+		if (fdt_kaslrseed(working_fdt, true) < 0)
+			err = CMD_RET_FAILURE;
 	}
 
-	ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
-	if (ret < 0) {
-		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
-		return CMD_RET_FAILURE;
-	}
-
-	free(buf);
-
-	return ret;
+	return cmd_process_error(cmdtp, err);
 }
 
 U_BOOT_LONGHELP(kaslrseed,
-- 
2.25.1

