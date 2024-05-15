Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06E5C04FFE
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 00:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D0D8814E;
	Wed, 15 May 2024 02:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F50388168; Wed, 15 May 2024 02:22:57 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6D6880F1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 02:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1s72Pz-0088Md-QT;
 Wed, 15 May 2024 00:22:51 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] fdt: add kaslr-seed if DM_RNG is enabled
Date: Tue, 14 May 2024 17:22:48 -0700
Message-Id: <20240515002248.2920155-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

If we have DM_RNG enabled poulate this value automatically when
fdt_chosen is called.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 boot/fdt_support.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 874ca4d6f5af..cd3069baf450 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -7,10 +7,12 @@
  */
 
 #include <abuf.h>
+#include <dm.h>
 #include <env.h>
 #include <log.h>
 #include <mapmem.h>
 #include <net.h>
+#include <rng.h>
 #include <stdio_dev.h>
 #include <dm/ofnode.h>
 #include <linux/ctype.h>
@@ -300,6 +302,27 @@ int fdt_chosen(void *fdt)
 	if (nodeoffset < 0)
 		return nodeoffset;
 
+	if (IS_ENABLED(CONFIG_DM_RNG)) {
+		struct udevice *dev;
+		size_t len = 0x8;
+		u64 *data;
+
+		data = malloc(len);
+		if (!data)
+			return -ENOMEM;
+
+		err = uclass_get_device(UCLASS_RNG, 0, &dev);
+		if (!err)
+			err = dm_rng_read(dev, data, len);
+		if (!err)
+			err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", data, len);
+		if (err < 0) {
+			printf("WARNING: could not set kaslr-seed %s.\n",
+			       fdt_strerror(err));
+			return err;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
 		err = fdt_setprop(fdt, nodeoffset, "rng-seed",
 				  abuf_data(&buf), abuf_size(&buf));
-- 
2.25.1

