Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86FDD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1938892C0;
	Fri, 18 Oct 2024 01:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OFf3X2gt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6BFC892AF; Fri, 18 Oct 2024 01:25:43 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B653D891E4
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83ab94452a7so15257539f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207539; x=1729812339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbY2ul3KZgi+gbQXHV0nd80yhBZk3tlPYeS+bWoLw5Y=;
 b=OFf3X2gtCG8tiUYZJExCcH3NVsai7mokcKd0hGF/FQXu9KkDA0tNvQvKsTwZafhiu8
 1BnLF7rRXKxG9F2oNjmreCni1FmRHlr8gWdq6TU16zDYGZD4BaDn+u79WeFb15crm4G4
 dxiIkKEDPIyoX9Hne0pkUef6XUd6tw9Oj8jhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207539; x=1729812339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbY2ul3KZgi+gbQXHV0nd80yhBZk3tlPYeS+bWoLw5Y=;
 b=PLL0ErCTEPYGb57Hda9agp8u6B/JbfCXkHuLIOJxW70+jK7IXZ2mrM/CkhmfHtTTiW
 yTWPVmrZAfaBIDc1GGSRbVrzgiJMCoi4O9qNd5VvZP6Lk5lVVih0F0sE8lMRk3Dro4mg
 97HsoeUvU2Hrjk0my9RnF602FWiPTWvU3e75MdKVnXWblj8j5IvQFLQ7iSxKMDs8ykvM
 ke73j8ezzN0jxdJlfIM+N/PJ/Rl/1/P1mQE1XC7eh9dOikC6m+bXw3tV+RGaRSWuR6nq
 dgKG5vSIXC2Y5r8rWf+IFs0fcDvFm/uCRr7vdEE0CXWbZJ+AkNZkMTDsfPksB1cOrRc8
 Kpsw==
X-Gm-Message-State: AOJu0YxgGQgQns9vMERCPuO5gtNisu18B+bY4RwaKRJQ0Xk8l4xMnsjT
 A4dbzaTqqb+VQFRWvL97iYJI934ahvkgbY12JBj7646gysEfvoIA62ZCuD1Q2pp0CrF63Judv2M
 =
X-Google-Smtp-Source: AGHT+IFciedPuGB6BaRudYb6Cf8BBYdt88miAxXpae/oP7BRHKt/VkOwY+bZb5mDDSY40SHFgKC9cw==
X-Received: by 2002:a05:6602:158f:b0:83a:9a59:f382 with SMTP id
 ca18e2360f4ac-83aba67f44amr47785739f.16.1729207539322; 
 Thu, 17 Oct 2024 16:25:39 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ac9csm122057173.29.2024.10.17.16.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v4 4/8] sunxi: Add a bootmeth for FEL
Date: Thu, 17 Oct 2024 17:25:27 -0600
Message-Id: <20241017232531.726559-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232531.726559-1-sjg@chromium.org>
References: <20241017232531.726559-1-sjg@chromium.org>
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

Add support for booting from a script loaded over FEL. This mirrors the
bootcmd_fel provided by distro boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v4:
- Reword Kconfig
- Add a name for the bootflow

Changes in v2:
- Put the FEL bootmeth before all other global bootmeths

 boot/Kconfig        | 14 ++++++++
 boot/Makefile       |  1 +
 boot/bootmeth_fel.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 boot/bootmeth_fel.c

diff --git a/boot/Kconfig b/boot/Kconfig
index ccbc113d8e2..7b399ff00a7 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -589,6 +589,20 @@ config BOOTMETH_EFI_BOOTMGR
 	  the EFI binary to be launched is determined. To set the EFI variables
 	  use the eficonfig command.
 
+config BOOTMETH_FEL
+	bool "Bootdev support for Sunxi FEL"
+	depends on ARCH_SUNXI
+	default y
+	help
+	  Enables support for executing an explicit boot script uploaded before
+	  via the USB FEL protocol. The 'fel_scriptaddr' environment variable
+	  holds the address of this script, taken from the SPL header.
+
+	  This method is only available if booting from FEL, i.e. the
+	  'fel_booted' environment variable is set.
+
+	  See https://linux-sunxi.org/FEL/Protocol for more information.
+
 config BOOTMETH_QFW
 	bool "Boot method using QEMU parameters"
 	depends on QFW
diff --git a/boot/Makefile b/boot/Makefile
index b24f806d5bf..5bee34e8531 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_FEL) += bootmeth_fel.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
diff --git a/boot/bootmeth_fel.c b/boot/bootmeth_fel.c
new file mode 100644
index 00000000000..61332d5a3b4
--- /dev/null
+++ b/boot/bootmeth_fel.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bootmethod for sunxi FEL loading
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <bootdev.h>
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <command.h>
+#include <dm.h>
+#include <env.h>
+
+static int fel_check(struct udevice *dev, struct bootflow_iter *iter)
+{
+	return 0;
+}
+
+static int fel_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+	if (!env_get("fel_booted") || !env_get("fel_scriptaddr"))
+		return -ENOENT;
+
+	bflow->name = strdup("fel-script");
+	if (!bflow->name)
+		return log_msg_ret("fel", -ENOMEM);
+	bflow->state = BOOTFLOWST_READY;
+
+	return 0;
+}
+
+static int fel_read_file(struct udevice *dev, struct bootflow *bflow,
+			 const char *file_path, ulong addr, ulong *sizep)
+{
+	return -ENOSYS;
+}
+
+static int fel_boot(struct udevice *dev, struct bootflow *bflow)
+{
+	ulong addr;
+	int ret;
+
+	addr = env_get_hex("fel_scriptaddr", 0);
+	ret = cmd_source_script(addr, NULL, NULL);
+	if (ret)
+		return log_msg_ret("boot", ret);
+
+	return 0;
+}
+
+static int fel_bootmeth_bind(struct udevice *dev)
+{
+	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	plat->desc = IS_ENABLED(CONFIG_BOOTSTD_FULL) ?
+	   "Sunxi FEL boot over USB" : "FEL";
+	plat->flags = BOOTMETHF_GLOBAL;
+
+	return 0;
+}
+
+static struct bootmeth_ops fel_bootmeth_ops = {
+	.check		= fel_check,
+	.read_bootflow	= fel_read_bootflow,
+	.read_file	= fel_read_file,
+	.boot		= fel_boot,
+};
+
+static const struct udevice_id fel_bootmeth_ids[] = {
+	{ .compatible = "u-boot,fel-bootmeth" },
+	{ }
+};
+
+U_BOOT_DRIVER(bootmeth_2fel) = {
+	.name		= "bootmeth_fel",
+	.id		= UCLASS_BOOTMETH,
+	.of_match	= fel_bootmeth_ids,
+	.ops		= &fel_bootmeth_ops,
+	.bind		= fel_bootmeth_bind,
+};
-- 
2.34.1

