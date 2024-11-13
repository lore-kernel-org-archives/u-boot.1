Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A7AD462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B1C895A3;
	Wed, 13 Nov 2024 16:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UxegY0fG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A19F89417; Wed, 13 Nov 2024 16:09:59 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7294C8959A
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83e5ae95815so5280639f.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731510594; x=1732115394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jinahmZseO2tlwOxFf3n+ltDt3DYWLV4fSq+MJDaXFg=;
 b=UxegY0fGrntVee+6UeYx/5MoN4tbzRd6O+mlqQTWfjKdFOv3lP5QqTY4Ha3tFho5Gt
 X8F0/qhLgtQ1eQ2Cmq8CJhg9KR8bPAn9fYUAUi/M1MR7v2MKSR32CnOEK8q6ffyk3E/w
 YdNTPmJe20GeFP+1fbVqY9DSK32vIwe9IqkkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510594; x=1732115394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jinahmZseO2tlwOxFf3n+ltDt3DYWLV4fSq+MJDaXFg=;
 b=JHApowvwGG+qvxh6HT14vSnQTPBIFGIpSeSVnr8n9T8YrVwRgT/afg3xlN27As5Zjw
 NVgN8YB5Y8QwVazRHHjZggfuZg2Ald+V/xoec9xw9jwy4gcMD/gMgI9pDb5jvgOJlNga
 /JhRG9vwV8IVTrFZxTeJ3cAodRdO5f/uEORElCeJrwNzYqDEP8ZZpoMyjQMOzd3qR1Tb
 aLzHO4SbEHk0ixns6IX8lJ/XwwtM4VmicSHvy+5KRpD8R1Wo/GgaUvOxGOqhgNA2Ggu3
 LRu3YX/k7stxoG5KU4MBWu/K3WMkHexBKb9nKAk1OPU69c5ICQbP0yGBaqJLFc0dhRKO
 P/IA==
X-Gm-Message-State: AOJu0YzGf97gH8Z0iC9vshywBXlIkRW+Mj2V4uV3TiIIQcOpo+U58sQa
 AxOI9csD/6keo6aA9crcxrwXG+g77uiL7fujFcV/DzLsedrtJfqjHUkG2X9riMx4Ujebtx/RNv4
 =
X-Google-Smtp-Source: AGHT+IHB45y+39Tb7qGbsLTuiIqXhnbF04YdWetqn0j357OZyQZObGfjKil/eKyNmkcEet/aK31uVQ==
X-Received: by 2002:a05:6e02:1609:b0:3a3:9471:8967 with SMTP id
 e9e14a558f8ab-3a715728afcmr32520215ab.11.1731510593935; 
 Wed, 13 Nov 2024 07:09:53 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a719d6b62fsm2710105ab.18.2024.11.13.07.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:09:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 2/8] sunxi: Add a bootmeth for FEL
Date: Wed, 13 Nov 2024 08:09:32 -0700
Message-Id: <20241113150938.1534931-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113150938.1534931-1-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
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

(no changes since v4)

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
index b5433e88f10..b612360ca55 100644
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
index 43def7c33d7..b03d628187b 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
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

