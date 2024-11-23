Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC313E66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F96E89406;
	Sat, 23 Nov 2024 22:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0A089275; Sat, 23 Nov 2024 20:57:34 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D30F891B4
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id A273D408A9;
 Sat, 23 Nov 2024 19:57:07 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Hanyuan Zhao <hanyuan-z@qq.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 05/10] Add EFI network driver
Date: Sat, 23 Nov 2024 11:55:04 -0800
Message-ID: <20241123195616.305687-6-mjg59@srcf.ucam.org>
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

Add a driver that makes use of the UEFI Simple Network Protocol to
support network access when using the UEFI app implementation, and hook
up the app code to instantiate it for probed devices.

Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
---

 drivers/net/Kconfig    |   7 +++
 drivers/net/Makefile   |   1 +
 drivers/net/efi_net.c  | 110 +++++++++++++++++++++++++++++++++++++++++
 include/efi.h          |  12 +++++
 lib/efi/efi_app_init.c |  67 +++++++++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 drivers/net/efi_net.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 576cd2d50ad..693d00fa2e3 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -333,6 +333,13 @@ config EEPRO100
 	  This driver supports Intel(R) PRO/100 82557/82559/82559ER fast
 	  ethernet family of adapters.
 
+config EFI_NET
+        bool "UEFI firmware-based networking support"
+	depends on EFI_APP
+	help
+	  This driver allows the use of UEFI-provided network interfaces
+	  as network devices within U-Boot.
+
 config ESSEDMA
 	bool "Qualcomm ESS Edma support"
 	depends on DM_ETH && ARCH_IPQ40XX
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index f5ab1f5dedf..f58c62cdb40 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_DWC_ETH_QOS_STM32) += dwc_eth_qos_stm32.o
 obj-$(CONFIG_E1000) += e1000.o
 obj-$(CONFIG_E1000_SPI) += e1000_spi.o
 obj-$(CONFIG_EEPRO100) += eepro100.o
+obj-$(CONFIG_EFI_NET) += efi_net.o
 obj-$(CONFIG_ESSEDMA) += essedma.o
 obj-$(CONFIG_ETHOC) += ethoc.o
 obj-$(CONFIG_ETH_DESIGNWARE) += designware.o
diff --git a/drivers/net/efi_net.c b/drivers/net/efi_net.c
new file mode 100644
index 00000000000..370056040f3
--- /dev/null
+++ b/drivers/net/efi_net.c
@@ -0,0 +1,110 @@
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
+#include <malloc.h>
+#include <net.h>
+
+struct efi_net_priv {
+	void *buffer;
+};
+
+static int efi_net_bind(struct udevice *dev)
+{
+	struct efi_net_plat *plat = dev_get_plat(dev);
+	struct efi_net_priv *priv = dev_get_priv(dev);
+	efi_status_t status;
+
+	priv->buffer = malloc(PKTSIZE);
+
+	status = plat->snp->start(plat->snp);
+	if (status != EFI_SUCCESS)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int efi_net_init(struct udevice *dev)
+{
+	struct efi_net_plat *plat = dev_get_plat(dev);
+	efi_status_t status;
+
+	status = plat->snp->initialize(plat->snp, 0, 0);
+	if (status != EFI_SUCCESS)
+		return -ENOENT;
+
+	return 0;
+}
+
+static void efi_net_halt(struct udevice *dev)
+{
+	struct efi_net_plat *plat = dev_get_plat(dev);
+
+	plat->snp->shutdown(plat->snp);
+	plat->snp->stop(plat->snp);
+}
+
+static int efi_net_send(struct udevice *dev, void *packet, int length)
+{
+	struct efi_net_plat *plat = dev_get_plat(dev);
+	efi_status_t status;
+
+	status = plat->snp->transmit(plat->snp, 0, length, packet, NULL, NULL,
+				     NULL);
+	if (status != EFI_SUCCESS)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int efi_net_recv(struct udevice *dev, int flags, uchar **packetp)
+{
+	struct efi_net_plat *plat = dev_get_plat(dev);
+	struct efi_net_priv *priv = dev_get_priv(dev);
+	efi_status_t status;
+	size_t size = PKTSIZE;
+
+	status = plat->snp->receive(plat->snp, 0, &size, priv->buffer, NULL,
+				    NULL, NULL);
+	if (status == EFI_NOT_READY)
+		return -EAGAIN;
+	else if (status != EFI_SUCCESS)
+		return -EINVAL;
+
+	*packetp = priv->buffer;
+
+	return 0;
+}
+
+static int efi_net_read_hwaddr(struct udevice *dev)
+{
+	struct efi_net_plat *plat = dev_get_plat(dev);
+
+	memcpy(plat->eth_pdata.enetaddr,
+	       (void *)&plat->snp->mode->permanent_address, ARP_HLEN);
+
+	return 0;
+}
+
+static const struct eth_ops efi_net_ops = {
+	.start	= efi_net_init,
+	.stop	= efi_net_halt,
+	.send	= efi_net_send,
+	.recv	= efi_net_recv,
+	.read_rom_hwaddr = efi_net_read_hwaddr,
+};
+
+U_BOOT_DRIVER(efi_net) = {
+	.name	= "efi_net",
+	.id	= UCLASS_ETH,
+	.bind	= efi_net_bind,
+	.ops	= &efi_net_ops,
+	.plat_auto = sizeof(struct efi_net_plat),
+	.priv_auto = sizeof(struct efi_net_priv),
+};
diff --git a/include/efi.h b/include/efi.h
index 1d06230439f..3c4c321362f 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -16,6 +16,7 @@
 #ifndef _EFI_H
 #define _EFI_H
 
+#include <net.h>
 #include <linux/linkage.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -494,6 +495,17 @@ struct efi_media_plat {
 	struct efi_device_path *device_path;
 };
 
+/*
+ * EFI attributes of the udevice handled by efi_net driver
+ *
+ * @handle: handle of the controller on which this driver is installed
+ */
+struct efi_net_plat {
+	struct eth_pdata eth_pdata;
+	efi_handle_t handle;
+	struct efi_simple_network *snp;
+};
+
 /* Base address of the EFI image */
 extern char image_base[];
 
diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
index c5e4192fe06..bc09eb063a1 100644
--- a/lib/efi/efi_app_init.c
+++ b/lib/efi/efi_app_init.c
@@ -183,6 +183,70 @@ static int setup_block(void)
 	return 0;
 }
 
+/**
+ * setup_net() - Find all network devices and setup EFI devices for them
+ *
+ * Return: 0 if found, -ENOSYS if there is no boot-services table, -ENOTSUPP
+ *	if a required protocol is not supported
+ */
+static int setup_net(void)
+{
+	efi_guid_t efi_snp_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
+	struct efi_boot_services *boot = efi_get_boot();
+	efi_uintn_t num_handles;
+	efi_handle_t *handle;
+	int ret, i;
+
+	if (!boot)
+		return log_msg_ret("sys", -ENOSYS);
+
+	/* Find all devices which support the simple network protocol */
+	ret = boot->locate_handle_buffer(BY_PROTOCOL, &efi_snp_guid, NULL,
+				  &num_handles, &handle);
+
+	if (ret)
+		return 0;
+	log_debug("Found %d net handles:\n", (int)num_handles);
+
+	for (i = 0; i < num_handles; i++) {
+		struct efi_simple_network *snp;
+		struct efi_net_plat *plat;
+		struct udevice *dev;
+		char name[18];
+
+		ret = boot->handle_protocol(handle[i], &efi_snp_guid,
+					    (void **)&snp);
+
+		if (ret != EFI_SUCCESS) {
+			log_warning("- snp %d failed (ret=0x%x\n", i, ret);
+			continue;
+		}
+
+		plat = malloc(sizeof(*plat));
+		if (!plat) {
+			log_warning("- snp %d failed to alloc platform data", i);
+			continue;
+		}
+		plat->handle = handle[i];
+		plat->snp = snp;
+		ret = device_bind(dm_root(), DM_DRIVER_GET(efi_net), "efi_net",
+				  plat, ofnode_null(), &dev);
+		if (ret) {
+			log_warning("- bind snp %d failed (ret=0x%x)\n", i,
+				    ret);
+			continue;
+		}
+
+		snprintf(name, sizeof(name), "efi_net_%x", dev_seq(dev));
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
@@ -199,6 +263,9 @@ int board_early_init_r(void)
 		ret = setup_block();
 		if (ret)
 			return ret;
+		ret = setup_net();
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.47.0

