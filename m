Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61557E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3728970D;
	Wed,  4 Dec 2024 00:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n2Nc8ynh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9F6896E9; Wed,  4 Dec 2024 00:47:50 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85CE8967A
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84198253281so216051139f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269665; x=1733874465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U34ky1O8g2whdyky8fhWnvwdpC85GdqPr865922Y0z0=;
 b=n2Nc8ynhRPi3GBFSvYa/6yAwqRPhAlUHbXJrOu00dyyAEQBWr4v1sjGZJ/c2Ej4MFa
 TJscfjb353skGI3ViAna8qFNdyb7+kbccw1wipj0eKNYc8xBHwhJ8a0DSBPA8iTbfzir
 ne0BWunK/RpamEOgTRGRIlTwFYkPYmdVI3050=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269665; x=1733874465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U34ky1O8g2whdyky8fhWnvwdpC85GdqPr865922Y0z0=;
 b=kN7OwQLp+O73xsXDnLgwwbs9Xo71I8vScUro3bIYXsD6e4LdsGVqL/cYkSKXSZNUGa
 mjzhsSAAv/GmmKEoF7kv+TD0pdXDU6IT9rUzMic23COQoc6+IrEAgyV2FhH7VSZNZb1v
 602jLQRy9pQl72kOpL96C/DfhPJNzrWUnYtDMV2UZ+l1EZyAV8ZI0owTKQILf6IGRvc8
 ZvNNybNJtpZ0H808NaRjBOQX8783bJzCBfbMMlMj7k2qgtjHYLvrL9OWjb6IH8sYDt3l
 UMkfFNFajrrO41J7F+FiOcWtjj5rQ9+ySmzhZU3xDh/eMAtTqMuFZFtkxHRT7PEnHsw2
 RDPw==
X-Gm-Message-State: AOJu0YyHS0S5XJondGyLpSNMT0KpcelhvCJmGYDJLOSFYR7vCy95nNHP
 Q0qugjoH4OU+HpRKBZtXHcT/loXRNXAQHlT5EffZ73rTaHi7XJ8NCgXKP0zYwcKBocNvNv3puig
 =
X-Gm-Gg: ASbGncuCiYoxseyDem42U+H226AXhbCttka32G2DzK2S0wp48KTXTgrJp7fS2dnzamH
 YA69jFZXWF4PeReGs5U58ELAdEw7ZPdJ8VoCO7OxA1B3ZX2wwXDQb1P42rRu4fjynlAhNrduDmj
 xSAFEY94RQh4qZx08EKtK1KSw6cwbvvY4+pdWYd1OIiZpsQGMKQMnfyK6wkn51QjS2Hi7ISRYIq
 VoXGCNe7KuVT24oNmQBRh7ILY7mg16iTlO/+YARvOAecyhsaRHGLDJzkLEAdVUfEDV0r4CJwOYL
 CKTzhupFRwk=
X-Google-Smtp-Source: AGHT+IEe/1lz5Mvp6Rgjxy3+pzoruYneG4VzZMb4ZbYZH91TJ58/Dp3FPqPI9/j1Bb48MWfoBTKUFw==
X-Received: by 2002:a05:6602:6b09:b0:83b:2c8e:c4 with SMTP id
 ca18e2360f4ac-8445b56f271mr592542039f.9.1733269665615; 
 Tue, 03 Dec 2024 15:47:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 33/41] bootmeth: Refactor to put options in a common file
Date: Tue,  3 Dec 2024 16:45:51 -0700
Message-Id: <20241203234559.2938192-34-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

The fallback feature is implemented for extlinux but not for PXE. Move
the code into common files so we can keep both pieces in sync.

Tidy up the comment for set_property() while we are here, fixing the
return value and some missing hyphens.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Makefile            |  4 +--
 boot/bootmeth_extlinux.c | 74 --------------------------------------
 boot/ext_pxe_common.c    | 76 ++++++++++++++++++++++++++++++++++++++++
 include/bootmeth.h       |  8 ++---
 include/extlinux.h       | 29 +++++++++++++++
 5 files changed, 111 insertions(+), 80 deletions(-)
 create mode 100644 boot/ext_pxe_common.c

diff --git a/boot/Makefile b/boot/Makefile
index 9ccdc2dc8f4..882cd760027 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -27,8 +27,8 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootstd-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD_MENU) += bootflow_menu.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
 
-obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
-obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += ext_pxe_common.o bootmeth_extlinux.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += ext_pxe_common.o bootmeth_pxe.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 144f5a11425..d0a32eb8b68 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -22,48 +22,6 @@
 #include <mmc.h>
 #include <pxe_utils.h>
 
-/**
- * struct extlinux_plat - locate state for this bootmeth
- *
- * @use_fallback: true to boot with the fallback option
- * @info: Info passed to the extlinux_getfile() function
- * @ctx: holds the PXE context, if it should be saved
- */
-struct extlinux_plat {
-	bool use_fallback;
-	struct pxe_context ctx;
-	struct extlinux_info info;
-};
-
-enum extlinux_option_type {
-	EO_FALLBACK,
-	EO_INVALID
-};
-
-struct extlinux_option {
-	char *name;
-	enum extlinux_option_type option;
-};
-
-static const struct extlinux_option options[] = {
-	{"fallback", EO_FALLBACK},
-	{NULL, EO_INVALID}
-};
-
-static enum extlinux_option_type get_option(const char *option)
-{
-	int i = 0;
-
-	while (options[i].name) {
-		if (!strcmp(options[i].name, option))
-			return options[i].option;
-
-		i++;
-	}
-
-	return EO_INVALID;
-};
-
 static int extlinux_get_state_desc(struct udevice *dev, char *buf, int maxsize)
 {
 	if (IS_ENABLED(CONFIG_SANDBOX)) {
@@ -205,38 +163,6 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	return 0;
 }
 
-static int extlinux_set_property(struct udevice *dev, const char *property, const char *value)
-{
-	struct extlinux_plat *plat;
-	static enum extlinux_option_type option;
-
-	plat = dev_get_plat(dev);
-
-	option = get_option(property);
-	if (option == EO_INVALID) {
-		printf("Invalid option\n");
-		return -EINVAL;
-	}
-
-	switch (option) {
-	case EO_FALLBACK:
-		if (!strcmp(value, "1")) {
-			plat->use_fallback = true;
-		} else if (!strcmp(value, "0")) {
-			plat->use_fallback = false;
-		} else {
-			printf("Unexpected value '%s'\n", value);
-			return -EINVAL;
-		}
-		break;
-	default:
-		printf("Unrecognised property '%s'\n", property);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int extlinux_bootmeth_bind(struct udevice *dev)
 {
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
diff --git a/boot/ext_pxe_common.c b/boot/ext_pxe_common.c
new file mode 100644
index 00000000000..e42865b84f5
--- /dev/null
+++ b/boot/ext_pxe_common.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Common functions for extlinux and PXE
+ *
+ * Copyright 2024 Collabora
+ * Written by Martyn Welch <martyn.welch@collabora.com>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <dm.h>
+#include <extlinux.h>
+#include <mapmem.h>
+#include <linux/string.h>
+
+enum extlinux_option_type {
+	EO_FALLBACK,
+	EO_INVALID
+};
+
+struct extlinux_option {
+	char *name;
+	enum extlinux_option_type option;
+};
+
+static const struct extlinux_option options[] = {
+	{"fallback", EO_FALLBACK},
+	{NULL, EO_INVALID}
+};
+
+static enum extlinux_option_type extlinux_get_option(const char *option)
+{
+	int i = 0;
+
+	while (options[i].name) {
+		if (!strcmp(options[i].name, option))
+			return options[i].option;
+
+		i++;
+	}
+
+	return EO_INVALID;
+};
+
+int extlinux_set_property(struct udevice *dev, const char *property,
+			  const char *value)
+{
+	struct extlinux_plat *plat;
+	static enum extlinux_option_type option;
+
+	plat = dev_get_plat(dev);
+
+	option = extlinux_get_option(property);
+	if (option == EO_INVALID) {
+		printf("Invalid option\n");
+		return -EINVAL;
+	}
+
+	switch (option) {
+	case EO_FALLBACK:
+		if (!strcmp(value, "1")) {
+			plat->use_fallback = true;
+		} else if (!strcmp(value, "0")) {
+			plat->use_fallback = false;
+		} else {
+			printf("Unexpected value '%s'\n", value);
+			return -EINVAL;
+		}
+		break;
+	default:
+		printf("Unrecognised property '%s'\n", property);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 26de593a9a4..03301c90580 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -151,15 +151,15 @@ struct bootmeth_ops {
 	/**
 	 * set_property() - set the bootmeth property
 	 *
-	 * This allows the setting of boot method specific properties to enable
-	 * automated finer grain control of the boot process
+	 * This allows the setting of bootmeth-specific properties to enable
+	 * automated finer-grained control of the boot process
 	 *
 	 * @name: String containing the name of the relevant boot method
 	 * @property: String containing the name of the property to set
 	 * @value: String containing the value to be set for the specified
 	 *         property
-	 * Return: 0 if OK, -ENODEV if an unknown bootmeth or property is
-	 *      provided, -ENOENT if there are no bootmeth devices
+	 * Return: 0 if OK, -EINVAL if an unknown property or invalid value is
+	 *	provided
 	 */
 	int (*set_property)(struct udevice *dev, const char *property,
 			    const char *value);
diff --git a/include/extlinux.h b/include/extlinux.h
index 6747fe01dda..f97164954cc 100644
--- a/include/extlinux.h
+++ b/include/extlinux.h
@@ -7,6 +7,8 @@
 #ifndef __extlinux_h
 #define __extlinux_h
 
+#include <pxe_utils.h>
+
 #define EXTLINUX_FNAME	"extlinux/extlinux.conf"
 
 /**
@@ -20,4 +22,31 @@ struct extlinux_info {
 	struct bootflow *bflow;
 };
 
+/**
+ * struct extlinux_plat - locate state for this bootmeth
+ *
+ * @use_falllback: true to boot with the fallback option
+ * @ctx: holds the PXE context, if it should be saved
+ * @info: information used for the getfile() method
+ */
+struct extlinux_plat {
+	bool use_fallback;
+	struct pxe_context ctx;
+	struct extlinux_info info;
+};
+
+/**
+ * extlinux_set_property() - set an extlinux property
+ *
+ * This allows the setting of bootmeth-specific properties to enable
+ * automated finer-grained control of the boot process
+ *
+ * @name: String containing the name of the relevant boot method
+ * @property: String containing the name of the property to set
+ * @value: String containing the value to be set for the specified property
+ * Return: 0 if OK, -EINVAL if an unknown property or invalid value is provided
+ */
+int extlinux_set_property(struct udevice *dev, const char *property,
+			  const char *value);
+
 #endif
-- 
2.34.1

