Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F8AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 11:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 606E9876A2;
	Mon, 11 Dec 2023 12:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="QpnvYAzV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65579876B4; Mon, 11 Dec 2023 12:04:17 +0100 (CET)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E984A87640
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 12:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1702292654; x=1733828654;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=M24Grrvizp0DUZ7BHFQBHAzcaJSFuMC0L4eiB/05hC0=;
 b=QpnvYAzV6+oflm2WIWsp8e89wThCxriO3MpRNXCd6OGCloB7XxlJepPU
 mu6habAd8x25YdoTBRkk+P3874U+y+4AqtR/uQ1GCSgne+aFGSeuZyuwe
 RppdM/o3eC+wXcihWQp2Pea/VJ0iWHNr3ckk0m4cA24AP91t65t3TY4Pd
 BvUYqJAXZJm1NDMMG3qAABu7Jbde7BwXtbvUqENYYp6g829l2p1xuS9HS
 UXFyrLE2ZJ2LWZCp7TLiHR5k8qEUk5FmL3w79i9OqFnPbf5SJkp10RfLo
 9dobx/JD9aeXc/rzPgxzVEwpo7I9HIIrRgqCAk1HXj/h/dPgz6KSzIckV Q==;
X-IronPort-AV: E=Sophos;i="6.04,267,1695679200"; d="scan'208";a="34430526"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 11 Dec 2023 12:04:14 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.53.15])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3E165280075;
 Mon, 11 Dec 2023 12:04:14 +0100 (CET)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] boot: add support for fdt_fixup command in environment
Date: Mon, 11 Dec 2023 12:03:17 +0100
Message-ID: <20231211110317.697011-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The "fdt" command is convenient for making small changes to the OS FDT,
especially during development. This is easy when the kernel and FDT are
loaded separately, but can be cumbersome for FIT images, requiring to
unpack the image, manually apply overlays, etc.

Add an option to execute a command "fdt_fixup" from the environment at
the beginning of image_setup_libfdt() (after overlays are applied, and
before the other fixups).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 boot/Kconfig     |  9 +++++++++
 boot/image-fdt.c | 19 +++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index ef71883a502..7eea935f490 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1502,6 +1502,15 @@ if OF_LIBFDT
 
 menu "Devicetree fixup"
 
+config OF_ENV_SETUP
+	bool "Run a command from environment to set up device tree before boot"
+	depends on CMD_FDT
+	help
+	  This causes U-Boot to run a command from the environment variable
+	  fdt_fixup before booting into the operating system, which can use the
+	  fdt command to modify the device tree. The device tree is then passed
+	  to the OS.
+
 config OF_BOARD_SETUP
 	bool "Set up board-specific details in device tree before boot"
 	help
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index f10200f6474..78b5c639381 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -9,6 +9,7 @@
  */
 
 #include <common.h>
+#include <command.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
 #include <env.h>
@@ -608,8 +609,22 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 {
 	ulong *initrd_start = &images->initrd_start;
 	ulong *initrd_end = &images->initrd_end;
-	int ret = -EPERM;
-	int fdt_ret;
+	int ret, fdt_ret;
+
+	if (IS_ENABLED(CONFIG_OF_ENV_SETUP)) {
+		const char *fdt_fixup;
+
+		fdt_fixup = env_get("fdt_fixup");
+		if (fdt_fixup) {
+			set_working_fdt_addr(map_to_sysmem(blob));
+			ret = run_command_list(fdt_fixup, -1, 0);
+			if (ret)
+				printf("WARNING: fdt_fixup command returned %d\n",
+				       ret);
+		}
+	}
+
+	ret = -EPERM;
 
 	if (fdt_root(blob) < 0) {
 		printf("ERROR: root node setup failed\n");
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

