Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC30E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB428975D;
	Fri,  6 Dec 2024 03:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DjC0UOr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E828964B; Fri,  6 Dec 2024 03:38:14 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7280289639
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so61432239f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452690; x=1734057490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCYenFilXTU1jQRStzq9TfQZeMRckJYoTJ9XjbpV5Bw=;
 b=DjC0UOr35OJEknWqfM9PnQIeVxPnyzbMolpFNjl79WAENLrUnVH2HsRRcUTb/q9OFS
 7bMVtPwKP6s3P1ROzYT1knSy4XA4uapuO4w+qN3Qqq7D0oadTGt+Hg3InIzDRVE6tbkz
 uzqs6S1azraVe38ACDv6pWipGjrUwfUQrwIpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452690; x=1734057490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCYenFilXTU1jQRStzq9TfQZeMRckJYoTJ9XjbpV5Bw=;
 b=Y4V59hd3x208Gyp0P6wOESKSZkXQgwHnYnKOFe76z+7eqefXhADAluXseV12WtNm0h
 x3ByzhWsfVFYPekpNhOX2pQbe4YD8oMroIi9tqvrZTDBTnZw4tBp0sLiMv9bArKPZS8w
 SXQEYuEz2kwRzOZiAEaQLN9jMj26rAcH87nTMdINat3KGJNCQ/xlUl9NOfkSSJ++RYOz
 iXWZ33+ocvhU2MbuHg2c6rjnJIEhzbrbhrXuBBwHapo30ysC2jGaFsGrpxU/1/f5jlTf
 E//JGWl/orzG+tYL1cH2XQhjIQbfobuP7eiod/z6l6KmClnN4u8dEPUbvbZwYFcklEdF
 PKVw==
X-Gm-Message-State: AOJu0YzNOnF0tg4qLlQJXfuAWtzPBC01MwqFhbTgZsYw4Y5o5BXldDDI
 yPDB/crfh5DDnOkdn4/jU2ZVr716m4rKdUiz0Ggihtk6MNyF7tt2MrgheBgT3BVzgc86UOdG2SI
 =
X-Gm-Gg: ASbGnctoN41Ou5Z47SoY4vN8kzj6qIwkApEVOnx4ULseWbX2nZuzj01EfeCymovVWfh
 JqgLXH+mtBb1eiK9UM8oHellYWA+ZNo7bAjhfp0sveeOIT/ZFKEIuxNXAkXITWK9TWkiKfgXGLt
 D0Vd+60ipGmdUjEd6Ptn81QOl7QHsy6TZ5GB1619PoMweExZGz9UGjE4+iWHHBt3LDmYM0S6zhl
 7vTwph4n74Grz+sAgSVHK2CzZKrIZfbkZjrCMvLmlNLAA7DAwqXpkXcvLQIG0an3uHKixW6zGot
 d4m26FpNLIY=
X-Google-Smtp-Source: AGHT+IGJRr1mwsRa/YtivwYxapikPQ1yamRJIF0hSeSwmazIbhv7fP/lpmfwUynEc+FeaDcE9/wjoA==
X-Received: by 2002:a5d:8c8a:0:b0:841:9225:1f56 with SMTP id
 ca18e2360f4ac-844710c586dmr531526539f.3.1733452690650; 
 Thu, 05 Dec 2024 18:38:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 37/46] bootmeth: Refactor to put options in a common file
Date: Thu,  5 Dec 2024 19:36:16 -0700
Message-Id: <20241206023626.2456858-38-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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
index ef9943bbfc1..9446c6b82a9 100644
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
 obj-$(CONFIG_$(PHASE_)BOOTMETH_FEL) += bootmeth_fel.o
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

