Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90AAC25B7E
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 22:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB1488748;
	Fri, 31 May 2024 00:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C8CB88735; Fri, 31 May 2024 00:06:43 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0C1882CD
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 00:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sCnuv-0030IF-Eq;
 Thu, 30 May 2024 22:06:37 +0000
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
Subject: [PATCH v5 1/3] Add fdt_kaslrseed function to add kaslr-seed to chosen
 node
Date: Thu, 30 May 2024 15:06:32 -0700
Message-Id: <20240530220634.155951-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240530220634.155951-1-tharvey@gateworks.com>
References: <20240530220634.155951-1-tharvey@gateworks.com>
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

If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
randomize the virtual address at which the kernel image is loaded, it
expects entropy to be provided by the bootloader by populating
/chosen/kaslr-seed with a 64-bit value from source of entropy at boot.

Add a fdt_kaslrseed function to accommodate this allowing an existing
node to be overwritten if present. For now use the first rng device
but it would be good to enhance this in the future to allow some sort
of selection or policy in choosing the rng device used.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
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
v5:
 - move function to boot/fdt_support.c
 - remove ability to select rng index and note in the commit log
   something like this as a future enhancement.
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
 boot/fdt_support.c    | 44 +++++++++++++++++++++++++++++++++++++++++++
 include/fdt_support.h | 10 ++++++++++
 2 files changed, 54 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 2bd80a9dfb18..b1b2679dea0c 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -7,12 +7,15 @@
  */
 
 #include <common.h>
+#include <dm.h>
 #include <abuf.h>
 #include <env.h>
 #include <log.h>
 #include <mapmem.h>
 #include <net.h>
+#include <rng.h>
 #include <stdio_dev.h>
+#include <dm/device_compat.h>
 #include <dm/ofnode.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
@@ -274,6 +277,47 @@ int fdt_initrd(void *fdt, ulong initrd_start, ulong initrd_end)
 	return 0;
 }
 
+int fdt_kaslrseed(void *fdt, bool overwrite)
+{
+	int len, err, nodeoffset;
+	struct udevice *dev;
+	const u64 *orig;
+	u64 data = 0;
+
+	err = fdt_check_header(fdt);
+	if (err < 0)
+		return err;
+
+	/* find or create "/chosen" node. */
+	nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
+	if (nodeoffset < 0)
+		return nodeoffset;
+
+	/* return without error if we are not overwriting and existing non-zero node */
+	orig = fdt_getprop(fdt, nodeoffset, "kaslr-seed", &len);
+	if (orig && len == sizeof(*orig))
+		data = fdt64_to_cpu(*orig);
+	if (data && !overwrite) {
+		debug("not overwriting existing kaslr-seed\n");
+		return 0;
+	}
+	err = uclass_get_device(UCLASS_RNG, 0, &dev);
+	if (err) {
+		printf("No RNG device\n");
+		return err;
+	}
+	err = dm_rng_read(dev, &data, sizeof(data));
+	if (err) {
+		dev_err(dev, "dm_rng_read failed: %d\n", err);
+		return err;
+	}
+	err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
+	if (err < 0)
+		printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));
+
+	return err;
+}
+
 /**
  * board_fdt_chosen_bootargs - boards may override this function to use
  *                             alternative kernel command line arguments
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 4b71b8948d99..741e2360c224 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -463,4 +463,14 @@ void fdt_fixup_board_enet(void *blob);
 #ifdef CONFIG_CMD_PSTORE
 void fdt_fixup_pstore(void *blob);
 #endif
+
+/**
+ * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
+ *
+ * @blob:	fdt blob
+ * @overwrite:	do not overwrite existing non-zero node unless true
+ * Return:	0 if OK, -ve on error
+ */
+int fdt_kaslrseed(void *blob, bool overwrite);
+
 #endif /* ifndef __FDT_SUPPORT_H */
-- 
2.25.1

