Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B113C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5D788CF6;
	Mon,  2 Sep 2024 00:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mj4Mkx1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DA088C6F; Mon,  2 Sep 2024 00:27:50 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2977A88CFB
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-82a238e0a9cso126636539f.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229665; x=1725834465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHLSpsEitVXzP9nxjSGKZ6Onrp/N0+j5xPcO2BpW+vo=;
 b=Mj4Mkx1/M6JKTB2mKdTpQHG1vfutmBRJR8w223mWx3yTl7LedzKyvFd4v1r3iGXhxf
 xmO7zvu+3VbFkujurkhr2sU4APqVfk78ECvOwKqMI13mMupW+U2P8sVv+OZFsimTQs9A
 bJFeLrk54hj/9xr9aOObDycHYlP5SbECbMjU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229665; x=1725834465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHLSpsEitVXzP9nxjSGKZ6Onrp/N0+j5xPcO2BpW+vo=;
 b=GUck+dniwOu7uz2vwyZMfESY5QRLZQLReJ3QtsO/ezhLLAHabT7u5E1etcVjBtjxl8
 mjTS/KHHzHj4m+IQy4nUyCJvh8GmaKFo6rQ5XtTTt8IButF90Pk+M4lkzPU0yYRlSMz1
 IISVFwgmDqiq6uLPZguGzO9mxpdJwEQR47UWHFF2KnLuiqGukpWB6TjHkZ4bMXwNfq6s
 wnMw/H4rKjMz8fjA1YfLtVDMi5muPK2l0RE5H1fm/2nTCYkaCBA7/0JQvoLYpXPMOYhX
 xYxU0fwq9NTNeh3Ou2yhO1AJUXQhs9eSSbaIrkIpnN859vAh+drWgGQ4xsXZorkDYeai
 XxoQ==
X-Gm-Message-State: AOJu0Yyx2wAPmUGGRHQ9fv39Q5BiccPTAuNWplu7A5okJ5Lk5ZtQ7AW/
 9Mr13jc68o0thVAC1IfCqMgVtBS9KqypsDjbvsEtkfjcJk5Du6+o1ZitAQ69fCOkV4BMlCRA4bw
 =
X-Google-Smtp-Source: AGHT+IEaJJAH5IuxNyf/1vIw3EadALvHnM1OAgcCFtzQe4QSQYArkbXi3fX7+WfPWi+dioKyIMWJdQ==
X-Received: by 2002:a05:6602:26c7:b0:82a:168f:bc92 with SMTP id
 ca18e2360f4ac-82a168fbd4amr1700043039f.4.1725229665599; 
 Sun, 01 Sep 2024 15:27:45 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e17bb4sm1866981173.82.2024.09.01.15.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 4/8] sunxi: Add a bootmeth for FEL
Date: Sun,  1 Sep 2024 16:27:30 -0600
Message-Id: <20240901222734.462334-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222734.462334-1-sjg@chromium.org>
References: <20240901222734.462334-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Put the FEL bootmeth before all other global bootmeths

 boot/Kconfig        | 14 ++++++++
 boot/Makefile       |  1 +
 boot/bootmeth_fel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 boot/bootmeth_fel.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 291919ea1ef..7d6e819bde6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -585,6 +585,20 @@ config BOOTMETH_EFI_BOOTMGR
 	  the EFI binary to be launched is determined. To set the EFI variables
 	  use the eficonfig command.
 
+config BOOTMETH_FEL
+	bool "Bootdev support for Sunxi FEL"
+	depends on ARCH_SUNXI
+	default y
+	help
+	  Enables support for booting over USB on a Sunxi device. This uses
+	  the FEL protocol and obtains the script address from the
+	  'fel_scriptaddr' environment variable.
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
index f4675d6ffd5..295f27dfd39 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
+obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_FEL) += bootmeth_fel.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_QFW) += bootmeth_qfw.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
diff --git a/boot/bootmeth_fel.c b/boot/bootmeth_fel.c
new file mode 100644
index 00000000000..160ba6eb827
--- /dev/null
+++ b/boot/bootmeth_fel.c
@@ -0,0 +1,81 @@
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

