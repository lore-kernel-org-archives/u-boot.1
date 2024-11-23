Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19485E66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D6789419;
	Sat, 23 Nov 2024 22:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51934893AA; Sat, 23 Nov 2024 20:57:37 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk
 [IPv6:2a00:1098:84:22e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40696891B4
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id DA48E407EA;
 Sat, 23 Nov 2024 19:57:32 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 06/10] Add UEFI TPM2 driver
Date: Sat, 23 Nov 2024 11:55:05 -0800
Message-ID: <20241123195616.305687-7-mjg59@srcf.ucam.org>
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

Add support for driving a TPM via UEFI firmware provided drivers, and
bind those devices from the UEFI app.

Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
---

 drivers/tpm/Kconfig    |  7 +++
 drivers/tpm/Makefile   |  1 +
 drivers/tpm/tpm2_efi.c | 97 ++++++++++++++++++++++++++++++++++++++++++
 include/efi.h          | 11 +++++
 include/efi_tcg2.h     |  1 +
 lib/efi/efi_app_init.c | 69 ++++++++++++++++++++++++++++++
 6 files changed, 186 insertions(+)
 create mode 100644 drivers/tpm/tpm2_efi.c

diff --git a/drivers/tpm/Kconfig b/drivers/tpm/Kconfig
index d59102d9a6b..36546c2c00e 100644
--- a/drivers/tpm/Kconfig
+++ b/drivers/tpm/Kconfig
@@ -209,6 +209,13 @@ config TPM2_MMIO
 	  to the device using the standard TPM Interface Specification (TIS)
 	  protocol.
 
+config TPM2_EFI
+        bool "UEFI firmware based TPM2 Interface"
+	depends on TPM_V2 && EFI_APP
+	help
+	  This driver supports the use of UEFI firmware-provided drivers for
+	  interfacing with a TPM 2.
+
 endif # TPM_V2
 
 endmenu
diff --git a/drivers/tpm/Makefile b/drivers/tpm/Makefile
index 76e516dbbaf..4b7da33e660 100644
--- a/drivers/tpm/Makefile
+++ b/drivers/tpm/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_TPM2_TIS_SPI) += tpm2_tis_core.o tpm2_tis_spi.o
 obj-$(CONFIG_TPM2_TIS_I2C) += tpm2_tis_core.o tpm2_tis_i2c.o
 obj-$(CONFIG_TPM2_FTPM_TEE) += tpm2_ftpm_tee.o
 obj-$(CONFIG_TPM2_MMIO) += tpm2_tis_core.o tpm2_tis_mmio.o
+obj-$(CONFIG_TPM2_EFI) += tpm2_efi.o
diff --git a/drivers/tpm/tpm2_efi.c b/drivers/tpm/tpm2_efi.c
new file mode 100644
index 00000000000..2eb144891d8
--- /dev/null
+++ b/drivers/tpm/tpm2_efi.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Aurora Innovation, Inc. Copyright 2022.
+ *
+ */
+
+#include <config.h>
+#include <dm.h>
+#include <efi.h>
+#include <efi_api.h>
+#include <efi_tcg2.h>
+#include <malloc.h>
+#include <tpm-v2.h>
+
+static int efi_tpm_bind(struct udevice *dev)
+{
+	struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
+	struct efi_tpm_plat *plat = dev_get_plat(dev);
+	struct efi_tcg2_boot_service_capability caps;
+	efi_status_t status;
+
+	caps.size = sizeof(caps);
+	status = plat->proto->get_capability(plat->proto, &caps);
+	if (status != EFI_SUCCESS)
+		return -EINVAL;
+
+	if (!caps.tpm_present_flag)
+		return -ENODEV;
+
+	priv->pcr_count = 24;
+	priv->pcr_select_min = 3;
+	priv->version = TPM_V2;
+
+	return 0;
+}
+
+static int efi_tpm_open(struct udevice *dev)
+{
+	return 0;
+}
+
+static int efi_tpm_close(struct udevice *dev)
+{
+	return 0;
+}
+
+static int efi_tpm_xfer(struct udevice *dev, const u8 *sendbuf,
+			size_t send_size, u8 *recvbuf,
+			size_t *recv_len)
+{
+	struct efi_tpm_plat *plat = dev_get_plat(dev);
+	efi_status_t status;
+
+	status = plat->proto->submit_command(plat->proto, send_size,
+					     (u8 *)sendbuf, *recv_len,
+					     recvbuf);
+	switch (status) {
+	case EFI_BUFFER_TOO_SMALL:
+		debug("%s:response length is bigger than receive buffer\n",
+		      __func__);
+		return -EIO;
+	case EFI_DEVICE_ERROR:
+		debug("%s:received error from device on write\n", __func__);
+		return -EIO;
+	case EFI_INVALID_PARAMETER:
+		debug("%s:invalid parameter\n", __func__);
+		return -EINVAL;
+	case EFI_SUCCESS:
+		return 0;
+	default:
+		debug("%s:received unknown error 0x%lx\n", __func__, status);
+		return -EIO;
+	}
+}
+
+static int efi_tpm_desc(struct udevice *dev, char *buf, int size)
+{
+	if (size < 9)
+		return -ENOSPC;
+
+	return snprintf(buf, size, "UEFI TPM");
+}
+
+static const struct tpm_ops efi_tpm_ops = {
+	.open		= efi_tpm_open,
+	.close		= efi_tpm_close,
+	.get_desc	= efi_tpm_desc,
+	.xfer		= efi_tpm_xfer,
+};
+
+U_BOOT_DRIVER(efi_tpm) = {
+	.name	= "efi_tpm",
+	.id	= UCLASS_TPM,
+	.bind	= efi_tpm_bind,
+	.ops	= &efi_tpm_ops,
+	.plat_auto = sizeof(struct efi_tpm_plat),
+};
diff --git a/include/efi.h b/include/efi.h
index 3c4c321362f..2eb9556770d 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -506,6 +506,17 @@ struct efi_net_plat {
 	struct efi_simple_network *snp;
 };
 
+/*
+ * EFI attributes of the udevice handled by efi_tpm driver
+ *
+ * @handle: handle of the controller on which this driver is installed
+ * @proto: pointer to the TCG2 EFI protocol
+ */
+struct efi_tpm_plat {
+	efi_handle_t handle;
+	struct efi_tcg2_protocol *proto;
+};
+
 /* Base address of the EFI image */
 extern char image_base[];
 
diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index 8dfb1bc9527..7dff89722bc 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -17,6 +17,7 @@
 #define _EFI_TCG2_PROTOCOL_H_
 
 #include <efi_api.h>
+#include <part_efi.h>
 #include <tpm-v2.h>
 #include <tpm_tcg2.h>
 
diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
index bc09eb063a1..9704020b749 100644
--- a/lib/efi/efi_app_init.c
+++ b/lib/efi/efi_app_init.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <efi.h>
 #include <efi_api.h>
+#include <efi_tcg2.h>
 #include <errno.h>
 #include <malloc.h>
 #include <asm/global_data.h>
@@ -247,6 +248,71 @@ static int setup_net(void)
 	return 0;
 }
 
+/**
+ * setup_tpm() - Find all TPMs and setup EFI devices for them
+ *
+ * Return: 0 if found, -ENOSYS if there is no boot-services table, -ENOTSUPP
+ *	if a required protocol is not supported
+ */
+static int setup_tpm(void)
+{
+	efi_guid_t efi_tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
+	struct efi_boot_services *boot = efi_get_boot();
+	efi_uintn_t num_handles;
+	efi_handle_t *handle;
+	int ret, i;
+
+	if (!boot)
+		return log_msg_ret("sys", -ENOSYS);
+
+	/* Find all devices which support the TCG2 protocol */
+	ret = boot->locate_handle_buffer(BY_PROTOCOL, &efi_tcg2_guid, NULL,
+				  &num_handles, &handle);
+
+	if (ret)
+		return 0;
+	log_debug("Found %d TPM handles:\n", (int)num_handles);
+
+	for (i = 0; i < num_handles; i++) {
+		struct efi_tcg2_protocol *proto;
+		struct efi_tpm_plat *plat;
+		struct udevice *dev;
+		char name[18];
+
+		ret = boot->handle_protocol(handle[i], &efi_tcg2_guid,
+					    (void **)&proto);
+
+		if (ret != EFI_SUCCESS) {
+			log_warning("- TPM %d failed (ret=0x%x)\n", i, ret);
+			continue;
+		}
+
+		plat = malloc(sizeof(*plat));
+		if (!plat) {
+			log_warning("- TPM %d failed to alloc platform data", i);
+			continue;
+		}
+
+		plat->handle = handle[i];
+		plat->proto = proto;
+		ret = device_bind(dm_root(), DM_DRIVER_GET(efi_net), "efi_tpm",
+				  plat, ofnode_null(), &dev);
+		if (ret) {
+			log_warning("- bind TPM %d failed (ret=0x%x)\n", i,
+				    ret);
+			continue;
+		}
+
+		snprintf(name, sizeof(name), "efi_tpm_%x", dev_seq(dev));
+		device_set_name(dev, name);
+
+		printf("%2d: %-12s\n", i, dev->name);
+	}
+	boot->free_pool(handle);
+
+	return 0;
+}
+
 /**
  * board_early_init_r() - Scan for UEFI devices that should be available
  *
@@ -266,6 +332,9 @@ int board_early_init_r(void)
 		ret = setup_net();
 		if (ret)
 			return ret;
+		ret = setup_tpm();
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.47.0

