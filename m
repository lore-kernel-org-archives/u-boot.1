Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC44CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D86A839FD;
	Thu, 30 Oct 2025 17:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kgCuIdD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CFE3839DE; Thu, 30 Oct 2025 17:45:52 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16FCF839E2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B726C4E413FE;
 Thu, 30 Oct 2025 16:45:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8DB7860331;
 Thu, 30 Oct 2025 16:45:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9361111808CA0; Thu, 30 Oct 2025 17:45:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=aLrkDVj8dkgSeiMKgHD5A0z/9M7Ejs5fJV8iqC40xfc=;
 b=kgCuIdD4p6I1ti6MVacK23MgNFoIxU6B/vStzfNqGbn+xeq7S9rzFe2PZMtTvGSx4dtv05
 EWC4g3nvB+WML4ZwUaROFhUEF6UNPAysxCmD5ftjYIWdlTS0ARoFbHEqlHjEhYVvbaq6Iq
 d0JV6BOPgNar6myRszW+u3HgeMOpvBlkZrFU8GY3GiSdItCn75H+020PQ4pXBGz/gyuSLu
 ETXXAlaUh9kqVPwhCoxfORCKIF2rsv//3VvIzwSTMk5UAWafTVArXVfHCR69keeemwnEov
 LtBWPWaA9PZBnHFkux3jSGMTS5S97udEkVe5Mmg6SpKcudJgEBA64bunhM8ctA==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:45:13 +0100
Subject: [PATCH v5 20/20] boot: bootmeth_efi: Add extension board
 devicetree overlay support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-20-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

Add support for scanning and applying extension board devicetree
overlays during EFI boot. After loading the main board devicetree,
the system now scans for available extension boards and applies their
overlays automatically.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Not yet tested, need to find a board with extension boards and supporting
EFI boot. Roger Quadros could you test it on your side?

Changes in v3:
- Added error log if the overlay does not load or apply.
---
 boot/bootmeth_efi.c | 68 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 64de5c08b7b..f592fec07f6 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -16,6 +16,7 @@
 #include <efi.h>
 #include <efi_loader.h>
 #include <env.h>
+#include <extension_board.h>
 #include <fs.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -99,8 +100,11 @@ static int distro_efi_check(struct udevice *dev, struct bootflow_iter *iter)
 static int distro_efi_try_bootflow_files(struct udevice *dev,
 					 struct bootflow *bflow)
 {
+	ulong fdt_addr, size, overlay_addr;
+	const struct extension *extension;
+	struct fdt_header *working_fdt;
 	struct blk_desc *desc = NULL;
-	ulong fdt_addr, size;
+	struct alist *extension_list;
 	char fname[256];
 	int ret, seq;
 
@@ -157,16 +161,58 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	bflow->fdt_size = size;
 	bflow->fdt_addr = fdt_addr;
 
-	/*
-	 * TODO: Apply extension overlay
-	 *
-	 * Here we need to load and apply the extension overlay. This is
-	 * not implemented. See do_extension_apply(). The extension
-	 * stuff needs an implementation in boot/extension.c so it is
-	 * separate from the command code. Really the extension stuff
-	 * should use the device tree and a uclass / driver interface
-	 * rather than implementing its own list
-	 */
+	if (!CONFIG_IS_ENABLED(SUPPORT_EXTENSION_SCAN))
+		return 0;
+
+	ret = extension_scan();
+	if (ret < 0)
+		return 0;
+
+	extension_list = extension_get_list();
+	if (!extension_list)
+		return 0;
+
+	working_fdt = map_sysmem(fdt_addr, 0);
+	if (fdt_check_header(working_fdt))
+		return 0;
+
+	overlay_addr = env_get_hex("extension_overlay_addr", 0);
+	if (!overlay_addr) {
+		log_debug("Environment extension_overlay_addr is missing\n");
+		return 0;
+	}
+
+	alist_for_each(extension, extension_list) {
+		char *overlay_file;
+		int len;
+
+		len = sizeof(EFI_DIRNAME) + strlen(extension->overlay);
+		overlay_file = calloc(1, len);
+		if (!overlay_file)
+			return -ENOMEM;
+
+		snprintf(overlay_file, len, "%s%s", EFI_DIRNAME,
+			 extension->overlay);
+
+		ret = bootmeth_common_read_file(dev, bflow, overlay_file,
+						overlay_addr,
+						(enum bootflow_img_t)IH_TYPE_FLATDT,
+						&size);
+		if (ret) {
+			log_debug("Failed loading overlay %s\n", overlay_file);
+			free(overlay_file);
+			continue;
+		}
+
+		ret = extension_apply(working_fdt, size);
+		if (ret) {
+			log_debug("Failed applying overlay %s\n", overlay_file);
+			free(overlay_file);
+			continue;
+		}
+		bflow->fdt_size += size;
+		free(overlay_file);
+	}
 
 	return 0;
 }

-- 
2.43.0

