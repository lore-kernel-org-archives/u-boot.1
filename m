Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EE7C369D5
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91338820B0;
	Mon, 21 Apr 2025 18:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ugT4H1wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FBA810E8; Mon, 21 Apr 2025 18:26:30 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A84181FC6
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0796141A13
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252787;
 bh=+m8n/lZ9nTCkcWH52NC7k9JcZheMp8XysTCjrht+XG8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ugT4H1wP+1aKaEWMaKIX34eVIgjRB2PPkpM4tgk8Z447iV02b8p45ly1psl0ysjxc
 yyjUp+iNL+43aZXv125/C0aTt2DY8PANwqOLuNqWD82T5JdVKH1w4dGj2qNQkm2XPm
 LlTMqrVGvwb+ZTj5x6Ry2hjyyvJZ4hMJd5jYku1ZumVJHw0godUGcJd014NyK3bLEI
 DcIZOVq+tUyGgwT6yO5KZaYIzC8EaMrH/zEnedQVAKXyshAkuD3GMPU3SmTXBDOLDf
 75gDnhKOUFnq595N/vMAv9E3w6z86H1gPpfhXazTSZ1jcpEHMm597swKZww4RUzbM+
 PKPQRaf9DQYng==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso2158675f8f.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252786; x=1745857586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+m8n/lZ9nTCkcWH52NC7k9JcZheMp8XysTCjrht+XG8=;
 b=KEaiCfddVxGVQdzkP6Lyg0voj+o+/HHaCmZdAN5cJTQngjBdvfPvHgZUxj1eOqx9Q4
 4Rj+6WpQcBFGZ3GD5MFexczj0fdzLicSgV3zBqZMWB/yPE1755Sbm5hPraN4QRmsBxZz
 tJ1xMhDJtLgjZxy8SD3Pz17GzpJ7i0GaZS3WGXsA+oAH2e/P998oOHotUiWvBEUfzO2h
 2QCwmXJst2YgVJWDiGABqUNdi7jdkWZcC9c0qgBSjFV3N9e5FcCwiRUSEbHhMeQMU5o/
 /PbybPkUMczZKMiERVZ1xmyHxGz/81JXFW1jiEH+NVfqvHPsg/50ukRfMwbDqKRghfLL
 mxZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtS16Jym3YtSfkWl06vA2ojK2x3jx3QPsSSPdWmaMSMvAem/KaI0JvrvcPIVKqlwZJdiKWYic=@lists.denx.de
X-Gm-Message-State: AOJu0YxtVSwZCPRy4sUTN5uy6OfoaNILkEHG1wibYjKaZJ4Vft0c12ML
 EQkN7Vfsl5r2o5SwAq4BkNW/g/7B1dJm/H4MFDJACxWPxoDCvnHnZ8aOo0EyvYb7FJF3mL0CAtq
 H42KYaBp5ugaaPV4HwAzhRk/JFTHVV7RRBJqPPBU0T7kU2XRy9+4ExAgvKGVvzXUi7sE=
X-Gm-Gg: ASbGncsacWhVOAvSDUQNioUwlJgEa8ywoGbsFS4VaW02jShX0o06seQCjS68BPZAlOK
 iZ7HuGSFMocXQpz6vHJWhusLXU0d8r743EOFQLTrars+T9ho5ZQvpL8xEnTO/sVf1GILm+jE6JQ
 FkAAw45Jexo9uJ9jldgiHvXla6JN57lmODaMn2JXMkJc/QPxYxdhH+Vyj+7GwkQP92kW1oXLzbF
 XGhrZ7k9xNiGNEiR5q6XXo0Nk7kLReMihRuBDab8twEysoydnRbjXHaUf+g9tucRabcBmerJn7Z
 r9K3Qjr/t+XnDwTFM7NS4zNancDSSZbi1MXhXZnIn2dif/OcUzCfYj72LFpuZDcen5CyX66jGR6
 /3WnJNPUVVfdKPA==
X-Received: by 2002:a05:6000:290e:b0:38d:df15:2770 with SMTP id
 ffacd0b85a97d-39ef85ac297mr9603874f8f.0.1745252786385; 
 Mon, 21 Apr 2025 09:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLvNNoQUyN3j9iEP81gR3icc3JMCp7PSSjif4ZsyCD4okbCiYYn7NNKd88lu72/N8tyR9wJQ==
X-Received: by 2002:a05:6000:290e:b0:38d:df15:2770 with SMTP id
 ffacd0b85a97d-39ef85ac297mr9603860f8f.0.1745252786065; 
 Mon, 21 Apr 2025 09:26:26 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:24 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 7/8] efi_loader: create EFI BOOTDEV
Date: Mon, 21 Apr 2025 18:25:54 +0200
Message-ID: <20250421162555.1200687-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

Create a bootdev device for the EFI boot manager.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/dm/uclass-id.h       |   1 +
 lib/efi_loader/Makefile      |   1 +
 lib/efi_loader/efi_bootdev.c | 102 +++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 lib/efi_loader/efi_bootdev.c

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..d0795c13d14 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -59,6 +59,7 @@ enum uclass_id {
 	UCLASS_ECDSA,		/* Elliptic curve cryptographic device */
 	UCLASS_EFI_LOADER,	/* Devices created by UEFI applications */
 	UCLASS_EFI_MEDIA,	/* Devices provided by UEFI firmware */
+	UCLASS_EFI_BOOT_MGR,	/* EFI boot manager */
 	UCLASS_ETH,		/* Ethernet device */
 	UCLASS_ETH_PHY,		/* Ethernet PHY device */
 	UCLASS_EXTCON,		/* External Connector Class */
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index ab50a69e48b..c37f05d70e4 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -25,6 +25,7 @@ apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
 obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
 obj-$(CONFIG_EFI_BINARY_EXEC) += efi_bootbin.o
+obj-$(CONFIG_BOOTMETH_EFI_BOOTMGR) += efi_bootdev.o
 obj-y += efi_boottime.o
 obj-y += efi_helper.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
diff --git a/lib/efi_loader/efi_bootdev.c b/lib/efi_loader/efi_bootdev.c
new file mode 100644
index 00000000000..066df9462c8
--- /dev/null
+++ b/lib/efi_loader/efi_bootdev.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Bootdev for boot manager
+ *
+ * Copyright 2025, Heinrich Schuchardt <xypron.glpk@gmx.de>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <bootdev.h>
+#include <bootflow.h>
+#include <dm.h>
+#include <dm/lists.h>
+
+static int efi_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
+			    struct bootflow *bflow)
+{
+	int ret;
+
+	ret = strcmp(iter->method->name, "efi_mgr");
+	if (!ret)
+		bflow->state = BOOTFLOWST_READY;
+
+	return ret;
+}
+
+struct bootdev_ops efi_bootdev_ops = {
+	.get_bootflow	= efi_get_bootflow,
+};
+
+static int efi_bootdev_bind(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	ucp->prio = BOOTDEVP_6_EFI;
+
+	return 0;
+}
+
+static const struct udevice_id efi_bootdev_ids[] = {
+	{ .compatible = "u-boot,bootdev-efi" },
+	{ }
+};
+
+U_BOOT_DRIVER(efi_bootdev) = {
+	.name		= "efi_bootdev",
+	.id		= UCLASS_BOOTDEV,
+	.ops		= &efi_bootdev_ops,
+	.bind		= efi_bootdev_bind,
+	.of_match	= efi_bootdev_ids,
+};
+
+/**
+ * efi_bootdev_hunt() - find devices used by EFI boot manager
+ *
+ * Invoke all hunters that have not been invoked by now.
+ * This should only be the network hunter.
+ *
+ * @info:	info structure describing this hunter
+ * @show:	true to show information from the hunter
+ *
+ * Return:	0 if device found, -EINVAL otherwise
+ */
+static int efi_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	return bootdev_hunt(NULL, 0);
+}
+
+BOOTDEV_HUNTER(efi_bootdev_hunt) = {
+	.prio		= BOOTDEVP_6_EFI,
+	.uclass		= UCLASS_EFI_BOOT_MGR,
+	.hunt		= efi_bootdev_hunt,
+	.drv		= DM_DRIVER_REF(efi_bootdev),
+};
+
+static int efi_bootdev_create(void)
+{
+	int ret;
+	struct udevice *dev_mgr;
+	struct udevice *dev;
+
+	ret = device_bind_driver(gd->dm_root, "efimgr",
+				 "efimgr", &dev_mgr);
+	if (ret)
+		return ret;
+
+	ret = device_bind_driver(dev_mgr, "efi_bootdev",
+				 "efimgr.bootdev", &dev);
+	return ret;
+}
+
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, efi_bootdev_create);
+
+U_BOOT_DRIVER(efimgr) = {
+	.name		= "efimgr",
+	.id		= UCLASS_EFI_BOOT_MGR,
+};
+
+UCLASS_DRIVER(efimgr) = {
+	.id		= UCLASS_EFI_BOOT_MGR,
+	.name		= "efimgr",
+};
-- 
2.48.1

