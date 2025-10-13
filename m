Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A879ECCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B60B383A37;
	Mon, 13 Oct 2025 15:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VFosItnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FA3E83A35; Mon, 13 Oct 2025 15:33:16 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 819C3839AF
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2C4204E40F94;
 Mon, 13 Oct 2025 13:33:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F0710606C6;
 Mon, 13 Oct 2025 13:33:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C93D7102F2263; 
 Mon, 13 Oct 2025 15:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362393; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Gb6CS+KrhXfv+frc4fZBNlPkGZdPrdf995AnbNouK+4=;
 b=VFosItnrpIZFw+FG9+NE3Uy+QAMKq2DQesNH4FX19fd5QaIZ1T+E6K40ZMwwYPix4NgRWw
 swM8ud9YEcpR5ycyHc4tvMV1kkplQyzjX+OCKQdmGKaCYqKUV0U34koxQwbnsUTeo0T/eG
 T8zXhxNMBjPBK1Qae3gYhz3+yNqCxVcuJUqouEXDyCQUwB4aeWMg1CbmDsfqJ1+wpbj0r8
 pusFtdcVxpy7wKaUElSCJ9tCxLiR/BaADplXYZysEDsi1HuVWRC1XTv9+FznvdytTQ9bXL
 GnT8M44NDjeNNGa8XQb++x6N6K6QRAMc01bYwKP3lIjR5eE41WxQIHA5uuIZbw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 15:32:43 +0200
Subject: [PATCH v3 18/20] boot: pxe_utils: Add extension board devicetree
 overlay support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_sysboot_extension_board-v3-18-04067b7422a5@bootlin.com>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
In-Reply-To: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
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
X-Mailer: b4 0.15-dev-8cb71
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
overlays during PXE boot. After loading the main board devicetree,
the system now scans for available extension boards and applies their
overlays automatically.

This enables dynamic hardware configuration for systems with extension
boards during boot scenarios which are using pxe_utils.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Added error log if the overlay does not load or apply.
---
 boot/pxe_utils.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index eb4d7723481..038416203fc 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <dm.h>
 #include <env.h>
+#include <extension_board.h>
 #include <image.h>
 #include <log.h>
 #include <malloc.h>
@@ -432,6 +433,95 @@ skip_overlay:
 }
 #endif
 
+/*
+ * label_boot_extension - scan extension boards and load overlay associated
+ */
+
+static void label_boot_extension(struct pxe_context *ctx,
+				 struct pxe_label *label)
+{
+#if CONFIG_IS_ENABLED(SUPPORT_EXTENSION_SCAN)
+	const struct extension *extension;
+	struct fdt_header *working_fdt;
+	struct alist *extension_list;
+	int ret, dir_len, len;
+	char *overlay_dir;
+	const char *slash;
+	ulong fdt_addr;
+
+	ret = extension_scan();
+	if (ret < 0)
+		return;
+
+	extension_list = extension_get_list();
+	if (!extension_list)
+		return;
+
+	/* Get the main fdt and map it */
+	fdt_addr = env_get_hex("fdt_addr_r", 0);
+	working_fdt = map_sysmem(fdt_addr, 0);
+	if (fdt_check_header(working_fdt))
+		return;
+
+	/* Use fdtdir for now as the overlay devicetree directory */
+	if (label->fdtdir) {
+		len = strlen(label->fdtdir);
+		if (!len)
+			slash = "./";
+		else if (label->fdtdir[len - 1] != '/')
+			slash = "/";
+		else
+			slash = "";
+
+		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
+		overlay_dir = calloc(1, len);
+		if (!overlay_dir)
+			return;
+
+		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
+			 slash);
+	} else {
+		dir_len = 2;
+		snprintf(overlay_dir, dir_len, "/");
+	}
+
+	alist_for_each(extension, extension_list) {
+		char *overlay_file;
+		ulong size;
+
+		len = dir_len + strlen(extension->overlay);
+		overlay_file = calloc(1, len);
+		if (!overlay_file)
+			goto cleanup;
+
+		snprintf(overlay_file, len, "%s%s", overlay_dir,
+			 extension->overlay);
+
+		/* Load extension overlay file */
+		ret = get_relfile_envaddr(ctx, overlay_file,
+					  "extension_overlay_addr",
+					  (enum bootflow_img_t)IH_TYPE_FLATDT,
+					  &size);
+		if (ret < 0) {
+			printf("Failed loading overlay %s\n", overlay_file);
+			free(overlay_file);
+			continue;
+		}
+
+		ret = extension_apply(working_fdt, size);
+		if (ret) {
+			printf("Failed applying overlay %s\n", overlay_file);
+			free(overlay_file);
+			continue;
+		}
+		free(overlay_file);
+	}
+
+cleanup:
+	free(overlay_dir);
+#endif
+}
+
 /**
  * label_boot() - Boot according to the contents of a pxe_label
  *
@@ -685,6 +775,8 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 			if (label->fdtoverlays)
 				label_boot_fdtoverlay(ctx, label);
 #endif
+			label_boot_extension(ctx, label);
+
 		} else {
 			bootm_argv[3] = NULL;
 		}

-- 
2.43.0

