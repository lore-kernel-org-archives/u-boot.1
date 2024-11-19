Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44466D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7DB89717;
	Tue, 19 Nov 2024 14:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JvOzH9y7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED3B8970E; Tue, 19 Nov 2024 14:20:20 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A6B89619
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a76df43746so7038485ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022416; x=1732627216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fngqPpH8C1fFfMampNPdlMYwodBG8Vae91PYZIgbQ4=;
 b=JvOzH9y7hC+H/pypURxuwCV0DMrFd/wjoHUQU+qkF0QoCtBmyuka4pfD7K2JZmfk7w
 UFpiDMJmaTuoCn0fXIdjD62Br2Y7iSBIiqgQhPbdIvf3nhHMDsGWUpVNG3HRPwkMJzRx
 InjJhOJX9kqHhZbx1i3XxojC7A2uNiBMo+L+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022416; x=1732627216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fngqPpH8C1fFfMampNPdlMYwodBG8Vae91PYZIgbQ4=;
 b=nGEmcGmTfMA6Gm+7bS/DFmdyu0p/j1A5e/CuXivHQfDF7OQeFq8sq8Lm0695M2uz6D
 rT84S1JAWbrNr1QSiFTQzWFH0qtWTeiFUQdQ70XoWX5Oc3c6QTQayjdUWV+QVfnWbmbd
 X2AewrJ/XyWthht/X4aoTnOQalO+EiDzN/eWhja4tMnLJIs9TQ/4XPU4bTaxQyZ29SCu
 15rEBikXVjtn3uhR91xp3lpG/oTst1EM/heXsriZqjN5BfdQYwZu9H2fdnn2P8nn6dTe
 01hiBJR0W1vBpQ8rtgQHR19Ujmv/MZhAf7KwU3UnwHRQs3p5BS1LoQpP8miMVIWlgSBi
 UvPA==
X-Gm-Message-State: AOJu0YzUmkUeKRidNWg6As9mj2mZSdQStRsNv/R3gRy0/09x5iricl06
 0xj/ZktF2JGjiTihNbC8Ssl5m08geJqrK68SWQvqlWX6a73seasOn9SCcWxCHssnt5wR+uvplWE
 =
X-Google-Smtp-Source: AGHT+IH+OnGZDf7YVsDltxMsmLV4ajiyNKGhknqEkvvwU9dAcPjgwXnz5gni12mt2aBhDKbAVCF8rQ==
X-Received: by 2002:a05:6e02:1849:b0:3a7:6f1c:a084 with SMTP id
 e9e14a558f8ab-3a76f1ca151mr79007915ab.23.1732022415745; 
 Tue, 19 Nov 2024 05:20:15 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 31/39] bootmeth: Refactor to put options in a common file
Date: Tue, 19 Nov 2024 06:18:36 -0700
Message-Id: <20241119131844.4078144-32-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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
index 2f8e579540b..ce11077ee35 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -21,48 +21,6 @@
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
@@ -203,38 +161,6 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
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

