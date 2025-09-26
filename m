Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB39CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B8B8384E;
	Fri, 26 Sep 2025 18:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MI2gW7Cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC1483887; Fri, 26 Sep 2025 18:02:37 +0200 (CEST)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F92383824
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 18:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-425911e5661so9568265ab.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758902553; x=1759507353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRNODJlaCT62WIxehS2s60bcT7C679vS5fBmY6yJY6c=;
 b=MI2gW7Cf+nAF9dDZBDPKvQT+bte4LD6uSQVYpc6kCMWYPaazI6Hd/gNC0kd/r0zJhE
 GKG18h2nhSHMPVzjCLdUM/vbwRdQOqcr9D1kDcGZCbSfEdht0kS+R0FYntnKtSTowV4M
 3FBWfU3fmAXWqHq/lEQ8VzAdQxuHr7FwVYHEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902553; x=1759507353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRNODJlaCT62WIxehS2s60bcT7C679vS5fBmY6yJY6c=;
 b=cqK2bzBSAHF2dOQPpxrz+zSdFQ8fo0SHz//5SgkvBW6Pvtq9vutxbxFEUb/9ZxioAE
 9fDJd3jH9VRSGONn7LD98Dj2wcuR6LByixD0bwaeElXb3TsEHkKxzoo/TKCPGEyKYpID
 /GxxsNTANNby0f01NMA/l4lYyk/jf2Hhj3Fy4KnwWLnpjbPmnZBS9j+UNGKUQD+db8ju
 +Z3pB4Nf+l5PJT3O8LXYZ/3ACTpxGU0jRczxZfBjSvxjNi99m8PopixOlRhyNpTjhY5j
 cgFyp83se2C/YThRwy7ffK/Bol7pHdKHiZrTugCwoxiVK+Eh/W1sJ2/w9niICPCk/HNT
 ZYNQ==
X-Gm-Message-State: AOJu0YxKJwBSC1IuAJDLbmIfeZ0yLzdm5sYB/nokkxw9r20ni6vAwF11
 uw/Wau7dIRnJP8JnNvPpX1cMsk3Dc58RmnrCpJNQ/aXuKWkctLMok8gG3HXYckJkaEmHeyKe/Kw
 UXAVLxFGC
X-Gm-Gg: ASbGncuEChupyqo7UMSpB8Tzk1XMV91GyRx6E54FPi79pLppN/J5bxqrMza4cMbEZQ/
 X79QqB5gA4CLuxPsHkosDoIuqsBY8c/zsrWBwD3f98MsvfJ3ds77DvEGXiD80BXnN7ifbY5vsPz
 4iQ2447K9QztPiV7w2vG0f34+1BcxRPRO2Q0TsCgCTEV1w2m2M38/89cm0X8Hm061SAYG0lSUjc
 l2x7F7QMtw6abhFbcA7Atm9F8cwAL6hDEK4zBONWi+5bz+L51YX/iOBJAG/ggfGKQ6nUYNABr13
 niaN/itrZiyj/2o1yTl8on7NOcutFaDH4tbmNeIfuVoPTieJ4GSjjg661xzMItof6Yi+0xSVvlI
 fpONy9xwD7ImCtJ1j8dwTcb/lHyI=
X-Google-Smtp-Source: AGHT+IGyUdtncrudMUzpPjyRdHx3Upgzp4+dRQV/+OYO+LJt5NE3usYQAwYwfbZIpZoS/xECXdqh3w==
X-Received: by 2002:a05:6e02:4701:b0:425:793a:e089 with SMTP id
 e9e14a558f8ab-4259563e17bmr100638295ab.15.1758902552563; 
 Fri, 26 Sep 2025 09:02:32 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a6a5ae382sm1997134173.64.2025.09.26.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:02:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v8 1/4] sunxi: Add a bootmeth for FEL
Date: Fri, 26 Sep 2025 10:02:09 -0600
Message-ID: <20250926160216.2157348-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926160216.2157348-1-sjg@chromium.org>
References: <20250926160216.2157348-1-sjg@chromium.org>
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
 boot/bootmeth_fel.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 boot/bootmeth_fel.c

diff --git a/boot/Kconfig b/boot/Kconfig
index dd047365754..d1e608f2595 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -634,6 +634,20 @@ config BOOTMETH_EFI_BOOTMGR
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
index 3da6f7a0914..e026720ff39 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_FEL) += bootmeth_fel.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
diff --git a/boot/bootmeth_fel.c b/boot/bootmeth_fel.c
new file mode 100644
index 00000000000..b5a3f3730e3
--- /dev/null
+++ b/boot/bootmeth_fel.c
@@ -0,0 +1,85 @@
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
+			 const char *file_path, ulong addr,
+			 enum bootflow_img_t type, ulong *sizep)
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
2.43.0

