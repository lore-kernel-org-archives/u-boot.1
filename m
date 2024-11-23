Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EF2E66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040F6893FD;
	Sat, 23 Nov 2024 22:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5660C893A5; Sat, 23 Nov 2024 20:57:09 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk
 [IPv6:2a00:1098:84:22e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5951C891B4
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id 112D3407E1;
 Sat, 23 Nov 2024 19:57:04 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/10] Hook up EFI env variable support in the EFI app
Date: Sat, 23 Nov 2024 11:55:03 -0800
Message-ID: <20241123195616.305687-5-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
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

From: Matthew Garrett <mgarrett@aurora.tech>

Add simple support for accessing EFI variables when in EFI app mode

Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
---

 cmd/Kconfig        |  2 +-
 lib/efi/Makefile   |  2 +-
 lib/efi/efi_app.c  |  5 +++++
 lib/efi/efi_vars.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 lib/efi/efi_vars.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5ed6a50121c..33bf3d1ad39 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -717,7 +717,7 @@ config CMD_ENV_FLAGS
 
 config CMD_NVEDIT_EFI
 	bool "env [set|print] -e - set/print UEFI variables"
-	depends on EFI_LOADER
+	depends on EFI_LOADER || EFI_APP
 	imply HEXDUMP
 	help
 	  UEFI variables are encoded as some form of U-Boot variables.
diff --git a/lib/efi/Makefile b/lib/efi/Makefile
index 232fa684360..63845287336 100644
--- a/lib/efi/Makefile
+++ b/lib/efi/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2015 Google, Inc
 
-obj-$(CONFIG_EFI_APP) += efi_app.o efi.o efi_app_init.o
+obj-$(CONFIG_EFI_APP) += efi_app.o efi.o efi_app_init.o efi_vars.o
 obj-$(CONFIG_EFI_STUB) += efi_info.o
 
 CFLAGS_REMOVE_efi_stub.o := -mregparm=3 \
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index 7c3ef9a7926..77d5da40a5d 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -30,6 +30,11 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+int efi_init_obj_list(void)
+{
+	return EFI_SUCCESS;
+}
+
 int efi_info_get(enum efi_entry_t type, void **datap, int *sizep)
 {
 	return -ENOSYS;
diff --git a/lib/efi/efi_vars.c b/lib/efi/efi_vars.c
new file mode 100644
index 00000000000..099a59b2a1e
--- /dev/null
+++ b/lib/efi/efi_vars.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Aurora Innovation, Inc. Copyright 2022.
+ *
+ */
+
+#define __efi_runtime
+
+#include <errno.h>
+#include <asm/global_data.h>
+#include <efi.h>
+#include <efi_api.h>
+#include <efi_variable.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+efi_status_t efi_get_variable_int(const u16 *variable_name, const efi_guid_t *vendor,
+				  u32 *attributes, efi_uintn_t *data_size,
+				  void *data, u64 *timep)
+{
+	struct efi_priv *priv = efi_get_priv();
+	struct efi_runtime_services *run = priv->run;
+
+	return run->get_variable((u16 *)variable_name, vendor, attributes, data_size, data);
+}
+
+efi_status_t efi_set_variable_int(const u16 *variable_name, const efi_guid_t *vendor,
+				  u32 attributes, efi_uintn_t data_size, const void *data,
+				  bool ro_check)
+{
+	struct efi_priv *priv = efi_get_priv();
+	struct efi_runtime_services *run = priv->run;
+
+	return run->set_variable((u16 *)variable_name, vendor, attributes, data_size, data);
+}
+
+efi_status_t efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
+					    u16 *variable_name, efi_guid_t *vendor)
+{
+	struct efi_priv *priv = efi_get_priv();
+	struct efi_runtime_services *run = priv->run;
+
+	return run->get_next_variable_name(variable_name_size, variable_name, vendor);
+}
-- 
2.47.0

