Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC288C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 20:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2412688C3B;
	Wed,  7 Aug 2024 22:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qkms8Lvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8179E88C02; Wed,  7 Aug 2024 22:50:45 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0778B88BE9
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 22:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f94ce22f2so9115939f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723063841; x=1723668641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtiZWjd1oKSJGmFyulyp2hGNVxmEFa3v9vbVuyYF/DM=;
 b=Qkms8LvjOLDRDvg+iIGqL2jYlluIiMUHxiyyGaswKQwo3iN6DBEBhj+iCUQP1yxcSe
 zY6ZoIB/rwSxUCtl+UKJxALaD2ItT9r+COTdpOWBFh4gqhTl0xxdPq95a3i7XSd0rZtQ
 P2XhZB+Vs5ewmzmsc76C/tWxSQdsFe+KPBu+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723063841; x=1723668641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtiZWjd1oKSJGmFyulyp2hGNVxmEFa3v9vbVuyYF/DM=;
 b=NDVL3yEFxLGcDrs7Um7nAjHPauih0AehB/72gOtv2MY3IRv6TV8iS8UfcRF8gPG1eB
 UCZFwwOwJrWQeyA/PjA/WqGooIKWHqGHdzmGCN5mVUPElEgSUL9KwPpEa7pBQyo8pf1Z
 XV/8CFjaK8AG9U/4Z3aMI9fINA0F0gRoPOKBOdyqn3G/YIvt7rfZSfk+wAcaeCQz4Tc+
 hFI0aal7lK2919QWTbvvenfEJ8DOrxs/zkaX67KeozkGT/klq5qStR/rb/ixwJdwXN1R
 /CX/4BV89uZfrdKtD4oFiFPEmJpFJt6Vhe98bER5f0Tb4UWrJSraNa2NduhYQAMeAwQi
 UWZg==
X-Gm-Message-State: AOJu0YxtPK7Xw104SESi9k+hJ2CiWD0gfPOnqssfj00RAsbzjNGq62eF
 ymmJXkD+jIAXQrhKO97iaaqnuH9+JizTdxGECCk1QYv/AhqgnOgyImFi8RlhRUD9XjRt4EjrRAY
 =
X-Google-Smtp-Source: AGHT+IEj7/9XbgZDoMes8/9rDpu6KLy2WA/k0svDswV4vktp7onSz0znzcxFpWKlQH9IprNsL6w1og==
X-Received: by 2002:a92:c683:0:b0:376:3e9c:d9a8 with SMTP id
 e9e14a558f8ab-39b1fb6bb1dmr205162415ab.9.1723063841594; 
 Wed, 07 Aug 2024 13:50:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6988421sm2912581173.32.2024.08.07.13.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:50:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 2/6] sunxi: Add a bootmeth for FEL
Date: Wed,  7 Aug 2024 14:50:28 -0600
Message-Id: <20240807205032.3745680-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807205032.3745680-1-sjg@chromium.org>
References: <20240807205032.3745680-1-sjg@chromium.org>
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
---

 boot/Kconfig        | 14 ++++++++
 boot/Makefile       |  1 +
 boot/bootmeth_fel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 boot/bootmeth_fel.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 940389d4882..77f6382ab2a 100644
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
index dff6f99081a..4a23fcdbfad 100644
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
index 00000000000..ccca68c1cd6
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
+U_BOOT_DRIVER(bootmeth_fel) = {
+	.name		= "bootmeth_fel",
+	.id		= UCLASS_BOOTMETH,
+	.of_match	= fel_bootmeth_ids,
+	.ops		= &fel_bootmeth_ops,
+	.bind		= fel_bootmeth_bind,
+};
-- 
2.34.1

