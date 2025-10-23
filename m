Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C43CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 08:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D361183303;
	Thu, 23 Oct 2025 10:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HKA23JPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB2EF8334F; Thu, 23 Oct 2025 10:09:51 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6106832BC
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 10:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59N89SIs482654;
 Thu, 23 Oct 2025 03:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761206968;
 bh=6ib4ViVrRNdthKcTc6Y6kE0vb/x4O6O4yC2r3p0xgQE=;
 h=From:To:CC:Subject:Date;
 b=HKA23JPlK2c/tmVIETBYnn8E/9D834ng9Wl6mxl5MkiYHnSKm87gxInFYysVMG9rQ
 ikOg5lZMsbAuM39z4hgBLD2Ha9Ft+5YjvVJYd7GjwuKl3ZhE+GwBCW5aq51VNJu6Ld
 vJ+upwhEHDofO2jXGpTLAOhzpce52q8kFdKwty4A=
Received: from DFLE212.ent.ti.com (dfle212.ent.ti.com [10.64.6.70])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59N89SIg2245777
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Oct 2025 03:09:28 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 03:09:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 03:09:28 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59N89Ndg2539518;
 Thu, 23 Oct 2025 03:09:23 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <lukma@denx.de>, <mkorpershoek@kernel.org>,
 <peng.fan@nxp.com>, <marek.vasut+renesas@mailbox.org>,
 <anshuld@ti.com>, <andre.przywara@arm.com>, <xypron.glpk@gmx.de>,
 <ye.li@nxp.com>, <sjg@chromium.org>,
 <dario.binacchi@amarulasolutions.com>, <a-dutta@ti.com>,
 <dinesh.maniyam@altera.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <danishanwar@ti.com>
Subject: [PATCH v4] spl: Add support for Device Firmware Upgrade (DFU) over
 PCIe
Date: Thu, 23 Oct 2025 13:39:22 +0530
Message-ID: <20251023080922.3527052-1-h-salunke@ti.com>
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
4e4a9de31de  Merge branch 'next' of git://source.denx.de/u-boot-usb into next

Changes since v3
- Addressed feedback from Mattijs Korpershoek
- Renamed all Kconfig symbols to include SPL_ prefix to avoid potential
  naming clashes with future U-Boot proper DFU over PCIe implementation:
  * PCI_DFU_SPL_LOAD_FIT_ADDRESS -> SPL_PCI_DFU_LOAD_FIT_ADDRESS
  * PCI_DFU_BAR_SIZE -> SPL_PCI_DFU_BAR_SIZE
  * PCI_DFU_MAGIC_WORD -> SPL_PCI_DFU_MAGIC_WORD
  * PCI_DFU_VENDOR_ID -> SPL_PCI_DFU_VENDOR_ID
  * PCI_DFU_DEVICE_ID -> SPL_PCI_DFU_DEVICE_ID
  * PCI_DFU_BOOT_PHASE -> SPL_PCI_DFU_BOOT_PHASE
- Changed strncpy to strlcpy for safer string copying
- Fixed boot phase string length check to enforce 63 character max as
  documented in Kconfig
- Improved error message clarity for boot phase string length validation
- Removed verbose debug print statements from normal operation

v3 : https://patchwork.ozlabs.org/project/uboot/patch/20250619071841.1265364-1-h-salunke@ti.com/

 common/spl/Kconfig   | 62 ++++++++++++++++++++++++++++++
 common/spl/spl_dfu.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 common/spl/spl_ram.c | 18 +++++++++
 drivers/Makefile     |  1 +
 4 files changed, 172 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index f34b96efc02..86464c17799 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1278,6 +1278,14 @@ config SPL_PCI
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
@@ -1338,6 +1346,60 @@ config SPL_RAM_DEVICE
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
+config SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS
+	hex "Address to load FIT image when booting via DFU over PCIe"
+	help
+	  Specify the load address of the fit image that will be loaded
+	  by SPL via DFU over PCIe.
+
+config SPL_PCI_DFU_BAR_SIZE
+	hex "BAR size to advertise for PCIe DFU"
+	default 0x800000
+	help
+	  This config sets the size of BAR to be advertised to the Root
+	  Complex. The size should be large enough to fit the FIT image
+	  being downloaded via DFU over PCIe.
+
+config SPL_PCI_DFU_MAGIC_WORD
+	hex "Completion magic word for PCIe DFU boot"
+	default 0xdeadbeef
+	help
+	  Specify the magic word which will be written to a specific
+	  address to signal the completion of transfer of FIT image
+	  when using DFU over PCIe to download the image. Size of magic
+	  word should be 32-bit.
+
+config SPL_PCI_DFU_VENDOR_ID
+	hex "PCI Vendor ID for PCI endpoint"
+	help
+	  PCI Vendor ID for endpoint device for DFU over PCIe. This should
+	  be set to your assigned 16-bit PCI Vendor ID.
+
+config SPL_PCI_DFU_DEVICE_ID
+	hex "PCI Vendor ID for PCI endpoint"
+	help
+	  A 16-bit PCI Vendor ID for endpoint device for DFU over PCIe.
+
+config SPL_PCI_DFU_BOOT_PHASE
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
index e9f381c392c..b09f82790c9 100644
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
+#define BOOT_PHASE_STRING_SIZE 63
 
 static int run_dfu(int usb_index, char *interface, char *devstring)
 {
@@ -32,11 +43,91 @@ exit:
 	return ret;
 }
 
+#ifdef CONFIG_SPL_PCI_DFU
+static int dfu_over_pcie(void)
+{
+	u32 offset, magic_word;
+	volatile void *addr;
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
+	hdr.deviceid = CONFIG_SPL_PCI_DFU_DEVICE_ID;
+	hdr.vendorid = CONFIG_SPL_PCI_DFU_VENDOR_ID;
+	hdr.baseclass_code = PCI_BASE_CLASS_MEMORY;
+	hdr.subclass_code = PCI_CLASS_MEMORY_RAM;
+
+	ret = pci_ep_write_header(dev, fn, &hdr);
+	if (ret) {
+		pr_err("Failed to write header: %d\n", ret);
+		return ret;
+	}
+
+	bar.barno = BAR_0;
+	bar.phys_addr = (dma_addr_t)CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
+	bar.flags = PCI_BASE_ADDRESS_SPACE_MEMORY |
+			  PCI_BASE_ADDRESS_MEM_TYPE_32 |
+			  PCI_BASE_ADDRESS_MEM_PREFETCH;
+
+	bar.size = CONFIG_SPL_PCI_DFU_BAR_SIZE;
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
+	addr = (void *)CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
+	offset = CONFIG_SPL_PCI_DFU_BAR_SIZE - MAGIC_WORD_SIZE;
+
+	if (sizeof(CONFIG_SPL_PCI_DFU_BOOT_PHASE) > BOOT_PHASE_STRING_SIZE) {
+		pr_err("Not copying boot phase. String too long\n");
+	} else {
+		bootphase = (char *)(addr + CONFIG_SPL_PCI_DFU_BAR_SIZE -
+				  (BOOT_PHASE_STRING_SIZE + MAGIC_WORD_SIZE + 1));
+		strlcpy(bootphase, CONFIG_SPL_PCI_DFU_BOOT_PHASE,
+			sizeof(CONFIG_SPL_PCI_DFU_BOOT_PHASE) + 1);
+	}
+
+	addr = addr + offset;
+	magic_word = CONFIG_SPL_PCI_DFU_MAGIC_WORD;
+	(*(int *)addr) = 0;
+	flush_dcache_all();
+	for (;;) {
+		if (*(int *)addr == magic_word)
+			break;
+		invalidate_dcache_all();
+	}
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
index 71b7a8374bb..0c501cf02f2 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -27,6 +27,11 @@ static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
 		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
 				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+
+#ifdef	CONFIG_SPL_PCI_DFU
+		if (spl_boot_device() == BOOT_DEVICE_PCIE)
+			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
+#endif
 	}
 	addr += sector;
 	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
@@ -47,6 +52,11 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
 		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
 				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+
+#ifdef CONFIG_SPL_PCI_DFU
+		if (spl_boot_device() == BOOT_DEVICE_PCIE)
+			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
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
index 7560008a842..77fc66eb8ba 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_MULTIPLEXER) += mux/
 obj-$(CONFIG_$(PHASE_)ETH) += net/
 obj-$(CONFIG_$(PHASE_)PCH) += pch/
 obj-$(CONFIG_$(PHASE_)PCI) += pci/
+obj-$(CONFIG_$(PHASE_)PCI_ENDPOINT) += pci_endpoint/
 obj-$(CONFIG_$(PHASE_)PHY) += phy/
 obj-$(CONFIG_$(PHASE_)PINCTRL) += pinctrl/
 obj-$(CONFIG_$(PHASE_)POWER) += power/
-- 
2.34.1

