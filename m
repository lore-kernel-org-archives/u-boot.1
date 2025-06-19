Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C58CC71159
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 07:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83AB382BA1;
	Thu, 19 Jun 2025 09:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hzD+xwhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FD282CBB; Thu, 19 Jun 2025 09:19:11 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EFCB82B18
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 09:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55J7Inim521399;
 Thu, 19 Jun 2025 02:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750317529;
 bh=Tyt/XfYrqKJkCn46FhrTclbKn91eYudLc4GSHx5Nqtg=;
 h=From:To:CC:Subject:Date;
 b=hzD+xwhNHSetSeCt7Bb0GyzkMQK24SVpiO6MzDGhFZ8BjTPXjVh8E5PHd9UBrNA/n
 /Eb+T4/iYT06F0c4Cae4VxOC5+tlDGSWOPNqZDv+SZhlL1kx7R4qKonUWvnc8uCF2u
 XYgUjRU8iuiu5glSQgwqWp+zcCFKJR0UOzHr35vs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55J7ImCf528455
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 19 Jun 2025 02:18:48 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 19
 Jun 2025 02:18:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 19 Jun 2025 02:18:48 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55J7Ifdg719070;
 Thu, 19 Jun 2025 02:18:42 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <Oliver.Gaskell@analog.com>, <peng.fan@nxp.com>,
 <malysagreg@gmail.com>, <nathan.morrison@timesys.com>,
 <twoerner@gmail.com>, <sjg@chromium.org>, <contact@paulk.fr>,
 <marex@denx.de>, <anshuld@ti.com>,
 <dario.binacchi@amarulasolutions.com>, <jerome.forissier@linaro.org>,
 <michael@amarulasolutions.com>, <a-dutta@ti.com>,
 <kever.yang@rock-chips.com>, <jonas@kwiboo.se>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>,
 <s-vadapalli@ti.com>, <srk@ti.com>
Subject: [PATCH v3] spl: Add support for Device Firmware Upgrade (DFU) over
 PCIe
Date: Thu, 19 Jun 2025 12:48:41 +0530
Message-ID: <20250619071841.1265364-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Introduces support for Device Firmware Upgrade (DFU) over PCIe in
U-Boot. Traditionally, the DFU protocol is used over USB, where a
device enters DFU mode and allows a host to upload firmware or binary
images directly via the USB interface. This is a widely adopted and
convenient method for updating firmware.

In the context of Texas Instruments (TI) SoCs, PCIe can be used as a
boot interface in a manner that differs from the conventional
"PCIe Boot" process, which typically refers to booting an OS or
firmware image from an NVMe SSD or other PCIe-attached storage devices.
Instead, TI SoCs can be configured as a PCIe Endpoint, allowing a
connected PCIe Root Complex (host) to transfer images directly into the
device’s memory over the PCIe bus for boot purposes. This mechanism is
analogous to DFU over USB, but leverages the high-speed PCIe link and
does not depend on traditional storage devices.

By extending the DFU framework in U-Boot to support PCIe, it will be
possible to flash images over PCIe. While this implementation is
motivated by TI SoC use cases, the framework is generic and can be
adopted by everyone for platforms that support PCIe Endpoint mode.
Platforms with hardware support for PCIe-based memory loading can use
this to implement PCIe as a boot mode, as well as to enable flashing
and recovery scenarios similar to DFU over USB.

In summary, enable support for:
- DFU-style flashing of firmware/images over PCIe, analogous to existing
USB DFU workflows
- PCIe as a boot mode where a host can load images directly into device
memory using DFU over PCIe

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on commit
9de873b4c30 Merge patch series "linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15 + winbond"

Changes since v2
Put the usage of macro BOOT_DEVICE_PCIE under #ifdef CONFIG_SPL_PCI_DFU
to avoid potential compilation errors. This is required as 
BOOT_DEVICE_PCIE macro is defined for only those platforms which support
PCIE as a valid boot device.

v2 : https://patchwork.ozlabs.org/project/uboot/patch/20250616164444.631575-1-h-salunke@ti.com/

 common/spl/Kconfig   | 62 +++++++++++++++++++++++++++++
 common/spl/spl_dfu.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
 common/spl/spl_ram.c | 18 +++++++++
 drivers/Makefile     |  1 +
 4 files changed, 174 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 880192043c4..212b4fc4e9e 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1268,6 +1268,14 @@ config SPL_PCI
 	  necessary driver support. This enables the drivers in drivers/pci
 	  as part of an SPL build.
 
+config SPL_PCI_ENDPOINT
+	bool "Support for PCI endpoint drivers"
+	help
+	   Enable this configuration option to support configurable PCI
+	   endpoints at SPL. This should be enabled if the platform has
+	   a PCI controllers that can operate in endpoint mode (as a device
+	   connected to PCI host or bridge).
+
 config SPL_PCH
 	bool "Support PCH drivers"
 	help
@@ -1328,6 +1336,60 @@ config SPL_RAM_DEVICE
 	  be already in memory when SPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config SPL_PCI_DFU
+	bool "PCIe boot support"
+	depends on SPL_PCI_ENDPOINT
+	help
+	  This config enables support to download bootloaders over PCIe
+	  when device is acting as an PCI endpoint.
+
+if SPL_PCI_DFU
+
+config PCI_DFU_SPL_LOAD_FIT_ADDRESS
+	hex "Address to load FIT image when booting via DFU over PCIe"
+	help
+	  Specify the load address of the fit image that will be loaded
+	  by SPL via DFU over PCIe.
+
+config PCI_DFU_BAR_SIZE
+	hex "BAR size to advertise for PCIe DFU"
+	default 0x800000
+	help
+	  This config sets the size of BAR to be advertised to the Root
+	  Complex. The size should be large enough to fit the FIT image
+	  being downloaded via DFU over PCIe.
+
+config PCI_DFU_MAGIC_WORD
+	hex "Completion magic word for PCIe DFU boot"
+	default 0xdeadbeef
+	help
+	  Specify the magic word which will be written to a specific
+	  address to signal the completion of transfer of FIT image
+	  when using DFU over PCIe to download the image. Size of magic
+	  word should be 32-bit.
+
+config PCI_DFU_VENDOR_ID
+	hex "PCI Vendor ID for PCI endpoint"
+	help
+	  PCI Vendor ID for endpoint device for DFU over PCIe. This should
+	  be set to your assigned 16-bit PCI Vendor ID.
+
+config PCI_DFU_DEVICE_ID
+	hex "PCI Vendor ID for PCI endpoint"
+	help
+	  A 16-bit PCI Vendor ID for endpoint device for DFU over PCIe.
+
+config PCI_DFU_BOOT_PHASE
+	string "Current boot phase for PCI DFU boot"
+	help
+	  Specify the current boot phase when booting via DFU over PCIe.
+	  This value can be read by the root complex to determine the
+	  current boot phase. Value of this config is written to memory
+	  location (BAR_start + PCI_DFU_BAR_SIZE - 70). Max size of this
+	  config is 63 bytes.
+
+endif
+
 config SPL_REMOTEPROC
 	bool "Support REMOTEPROCS"
 	default y if (CPU_V7R && ARCH_K3)
diff --git a/common/spl/spl_dfu.c b/common/spl/spl_dfu.c
index e9f381c392c..1fb5fb2bf6b 100644
--- a/common/spl/spl_dfu.c
+++ b/common/spl/spl_dfu.c
@@ -15,6 +15,17 @@
 #include <usb.h>
 #include <dfu.h>
 #include <linux/printk.h>
+#include <pci_ep.h>
+#include <dm/uclass.h>
+#include <cpu_func.h>
+#include <linux/io.h>
+
+/*
+ * Macros define size of magic word and boot phase string
+ * in bytes.
+ */
+#define MAGIC_WORD_SIZE 4
+#define BOOT_PHASE_STRING_SIZE 64
 
 static int run_dfu(int usb_index, char *interface, char *devstring)
 {
@@ -32,11 +43,93 @@ exit:
 	return ret;
 }
 
+#ifdef CONFIG_SPL_PCI_DFU
+static int dfu_over_pcie(void)
+{
+	u32 offset, magic_word;
+	void *addr;
+	struct udevice *dev;
+	struct pci_bar bar;
+	struct pci_ep_header hdr;
+	uint fn = 0;
+	int ret;
+	char *bootphase;
+
+	uclass_get_device_by_seq(UCLASS_PCI_EP, 0, &dev);
+	if (!dev) {
+		pr_err("Failed to get pci ep device\n");
+		return -ENODEV;
+	}
+
+	printf("%s: Configuring PCIe endpoint\n", __func__);
+	hdr.deviceid = CONFIG_PCI_DFU_DEVICE_ID;
+	hdr.vendorid = CONFIG_PCI_DFU_VENDOR_ID;
+	hdr.baseclass_code = PCI_BASE_CLASS_MEMORY;
+
+	ret = pci_ep_write_header(dev, fn, &hdr);
+	if (ret) {
+		pr_err("Failed to write header: %d\n", ret);
+		return ret;
+	}
+
+	bar.barno = BAR_0;
+	bar.phys_addr = (dma_addr_t)CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
+	bar.flags = PCI_BASE_ADDRESS_SPACE_MEMORY |
+			  PCI_BASE_ADDRESS_MEM_TYPE_32 |
+			  PCI_BASE_ADDRESS_MEM_PREFETCH;
+
+	bar.size = CONFIG_PCI_DFU_BAR_SIZE;
+
+	ret = pci_ep_set_bar(dev, fn, &bar);
+	if (ret) {
+		pr_err("Failed to set bar: %d\n", ret);
+		return ret;
+	}
+
+	ret = pci_ep_start(dev);
+	if (ret) {
+		pr_err("Failed to start ep: %d\n", ret);
+		return ret;
+	}
+
+	addr = (void *)CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
+	offset = CONFIG_PCI_DFU_BAR_SIZE - MAGIC_WORD_SIZE;
+
+	if (sizeof(CONFIG_PCI_DFU_BOOT_PHASE) > BOOT_PHASE_STRING_SIZE) {
+		pr_err("Boot phase string too long\n");
+	} else {
+		bootphase = (char *)(addr + CONFIG_PCI_DFU_BAR_SIZE -
+				  (BOOT_PHASE_STRING_SIZE + MAGIC_WORD_SIZE));
+		strncpy(bootphase, CONFIG_PCI_DFU_BOOT_PHASE,
+			sizeof(CONFIG_PCI_DFU_BOOT_PHASE));
+		bootphase[sizeof(CONFIG_PCI_DFU_BOOT_PHASE)] = '\0';
+	}
+
+	addr = addr + offset;
+	magic_word = CONFIG_PCI_DFU_MAGIC_WORD;
+	(*(int *)addr) = 0;
+	printf("%s: Waiting for an image .....\n", __func__);
+	for (;;) {
+		if (*(int *)addr == magic_word)
+			break;
+		invalidate_dcache_all();
+	}
+	printf("Image loaded\n");
+
+	return 0;
+}
+#endif
+
 int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *devstr)
 {
 	char *str_env;
 	int ret;
 
+#ifdef CONFIG_SPL_PCI_DFU
+	if (spl_boot_device() == BOOT_DEVICE_PCIE)
+		return dfu_over_pcie();
+#endif
+
 	/* set default environment */
 	env_set_default(NULL, 0);
 	str_env = env_get(dfu_alt_info);
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 71b7a8374bb..c8a62a438bb 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -27,6 +27,11 @@ static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
 		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
 				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+
+#ifdef	CONFIG_SPL_PCI_DFU
+		if (spl_boot_device() == BOOT_DEVICE_PCIE)
+			addr = CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
+#endif
 	}
 	addr += sector;
 	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
@@ -47,6 +52,11 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
 		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
 				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+
+#ifdef	CONFIG_SPL_PCI_DFU
+		if (spl_boot_device() == BOOT_DEVICE_PCIE)
+			addr = CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
+#endif
 	}
 
 	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)) {
@@ -64,6 +74,11 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
 #endif
 
+#if CONFIG_IS_ENABLED(PCI_DFU)
+	if (bootdev->boot_device == BOOT_DEVICE_PCIE)
+		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
+#endif
+
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
 		struct spl_load_info load;
@@ -102,3 +117,6 @@ SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, spl_ram_load_image);
 #if CONFIG_IS_ENABLED(DFU)
 SPL_LOAD_IMAGE_METHOD("DFU", 0, BOOT_DEVICE_DFU, spl_ram_load_image);
 #endif
+#if CONFIG_IS_ENABLED(PCI_DFU)
+SPL_LOAD_IMAGE_METHOD("PCIE", 0, BOOT_DEVICE_PCIE, spl_ram_load_image);
+#endif
diff --git a/drivers/Makefile b/drivers/Makefile
index 3c0ad17138f..bd15e89adb0 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_MULTIPLEXER) += mux/
 obj-$(CONFIG_$(PHASE_)ETH) += net/
 obj-$(CONFIG_$(PHASE_)PCH) += pch/
 obj-$(CONFIG_$(PHASE_)PCI) += pci/
+obj-$(CONFIG_$(PHASE_)PCI_ENDPOINT) += pci_endpoint/
 obj-$(CONFIG_$(PHASE_)PHY) += phy/
 obj-$(CONFIG_$(PHASE_)PINCTRL) += pinctrl/
 obj-$(CONFIG_$(PHASE_)POWER) += power/
-- 
2.34.1

