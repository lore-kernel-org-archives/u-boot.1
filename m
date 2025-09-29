Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2BECCA468
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 19:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A59B883526;
	Mon, 29 Sep 2025 21:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="GTKtMnpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCB682A9E; Mon, 29 Sep 2025 21:53:04 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C99282A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 21:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: fb127cdd-9d6d-11f0-b0b9-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id fb127cdd-9d6d-11f0-b0b9-00505699b430;
 Mon, 29 Sep 2025 21:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=mWdwyrYQQK6et7MQxHVlStlKQCdaIOARCw0qvNTmVIk=;
 b=GTKtMnpG+Cj7Cow6cqpH0PHQ322X/Uud8AEoyARYkyYBtnjndQ8um9loIMlwPobfrZz++zpCH0RWy
 cJAr/iESZ6RboMsgi1n8xS2lfvhGiMKrjPNA5hYaMWzuAFGKfZIUrmsk5RL6QYNPtWjkA++eksCjQb
 Y6sSculPekB9dEe4=
X-KPN-MID: 33|m/QxZeH6HkIyy6TXURpPY+KQz2oGtn2YsMEBK+m5XCyNNVuxuj45QYEvMAqRnSV
 mh1mwjcTVK1WKV225i5JjQXH6GgzIDxLHRuLoVt0JI1o=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|xXagAdIXV4e12V77ioLgfCddL9C7B/48iOiXhSJ2AHwNO/qo7/4kObHzCS5FiOG
 Fo/R+YZH5HcufgBPjh9TeLg==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e76f14be-9d6d-11f0-8d3e-00505699b758;
 Mon, 29 Sep 2025 21:53:00 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	trini@konsulko.com,
	Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2 3/3] usb: xhci-pci: Load ASMedia XHCI controller firmware
Date: Mon, 29 Sep 2025 21:52:41 +0200
Message-ID: <20250929195241.70351-4-kettenis@openbsd.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929195241.70351-1-kettenis@openbsd.org>
References: <20250929195241.70351-1-kettenis@openbsd.org>
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

The ASMedia XHCI controller found on some of the Apple Silicon
machines needs firmware to operate.  Use the file system
firmware loader interface to read the firmware and load it
onto the controller.  This allows keyboards connected to the
type-A ports on these machines to function in U-Boot.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 MAINTAINERS                         |   1 +
 drivers/usb/host/Kconfig            |  11 +
 drivers/usb/host/Makefile           |   1 +
 drivers/usb/host/xhci-pci-asmedia.c | 410 ++++++++++++++++++++++++++++
 drivers/usb/host/xhci-pci.c         |   9 +
 include/usb/xhci.h                  |   3 +
 6 files changed, 435 insertions(+)
 create mode 100644 drivers/usb/host/xhci-pci-asmedia.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1db1070d5f8..5aeae5ee44f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -137,6 +137,7 @@ F:	drivers/nvme/nvme_apple.c
 F:	drivers/pci/pcie_apple.c
 F:	drivers/phy/phy-apple-atc.c
 F:	drivers/pinctrl/pinctrl-apple.c
+F:	drivers/usb/host/xhci-pci-asmedia.c
 F:	drivers/watchdog/apple_wdt.c
 F:	include/configs/apple.h
 
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5c9e8fc9d15..95436fd4459 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -102,6 +102,17 @@ config USB_XHCI_PCI
 	help
 	  Enables support for the PCI-based xHCI controller.
 
+config USB_XHCI_PCI_ASMEDIA
+	bool "Support for ASMedia xHCI USB controller"
+	depends on USB_XHCI_PCI
+	default y if ARCH_APPLE
+	imply FS_LOADER
+	help
+	  Enables support for loading firmware for the ASMedia xHCI
+	  controller.  This is needed on Apple Silicon machines that
+	  contain ASMedia xHCI controllers without the full USB
+	  firmware.
+
 config USB_XHCI_RCAR
 	bool "Renesas R-Car USB 3.0 support"
 	default y
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index ef4ce62a680..d74174213b0 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_USB_XHCI_MVEBU) += xhci-mvebu.o
 obj-$(CONFIG_USB_XHCI_GENERIC) += xhci-generic.o
 obj-$(CONFIG_USB_XHCI_OMAP) += xhci-omap.o
 obj-$(CONFIG_USB_XHCI_PCI) += xhci-pci.o
+obj-$(CONFIG_USB_XHCI_PCI_ASMEDIA) += xhci-pci-asmedia.o
 obj-$(CONFIG_USB_XHCI_RCAR) += xhci-rcar.o
 obj-$(CONFIG_USB_XHCI_OCTEON) += dwc3-octeon-glue.o
 
diff --git a/drivers/usb/host/xhci-pci-asmedia.c b/drivers/usb/host/xhci-pci-asmedia.c
new file mode 100644
index 00000000000..35a75ae8a46
--- /dev/null
+++ b/drivers/usb/host/xhci-pci-asmedia.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * ASMedia xHCI firmware loader
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <fs_loader.h>
+#include <linux/iopoll.h>
+#include <pci.h>
+#include <usb.h>
+#include <usb/xhci.h>
+
+/* Configuration space registers */
+#define ASMT_CFG_CONTROL		0xe0
+#define ASMT_CFG_CONTROL_WRITE		BIT(1)
+#define ASMT_CFG_CONTROL_READ		BIT(0)
+
+#define ASMT_CFG_SRAM_ADDR		0xe2
+
+#define ASMT_CFG_SRAM_ACCESS		0xef
+#define ASMT_CFG_SRAM_ACCESS_READ	BIT(6)
+#define ASMT_CFG_SRAM_ACCESS_ENABLE	BIT(7)
+
+#define ASMT_CFG_DATA_READ0		0xf0
+#define ASMT_CFG_DATA_READ1		0xf4
+
+#define ASMT_CFG_DATA_WRITE0		0xf8
+#define ASMT_CFG_DATA_WRITE1		0xfc
+
+#define ASMT_CMD_GET_FWVER		0x8000060840
+#define ASMT_FWVER_ROM			0x010250090816
+
+/* BAR0 registers */
+#define ASMT_REG_ADDR			0x3000
+
+#define ASMT_REG_WDATA			0x3004
+#define ASMT_REG_RDATA			0x3008
+
+#define ASMT_REG_STATUS			0x3009
+#define ASMT_REG_STATUS_BUSY		BIT(7)
+
+#define ASMT_REG_CODE_WDATA		0x3010
+#define ASMT_REG_CODE_RDATA		0x3018
+
+#define ASMT_MMIO_CPU_MISC		0x500e
+#define ASMT_MMIO_CPU_MISC_CODE_RAM_WR	BIT(0)
+
+#define ASMT_MMIO_CPU_MODE_NEXT		0x5040
+#define ASMT_MMIO_CPU_MODE_CUR		0x5041
+
+#define ASMT_MMIO_CPU_MODE_RAM		BIT(0)
+#define ASMT_MMIO_CPU_MODE_HALFSPEED	BIT(1)
+
+#define ASMT_MMIO_CPU_EXEC_CTRL		0x5042
+#define ASMT_MMIO_CPU_EXEC_CTRL_RESET	BIT(0)
+#define ASMT_MMIO_CPU_EXEC_CTRL_HALT	BIT(1)
+
+#define TIMEOUT_USEC			10000
+#define RESET_TIMEOUT_USEC		500000
+
+static int asmedia_mbox_tx(struct udevice *pdev, u64 data)
+{
+	u8 op;
+	int ret, err;
+
+	ret = read_poll_timeout(dm_pci_read_config8, err,
+				err || !(op & ASMT_CFG_CONTROL_WRITE),
+				1, TIMEOUT_USEC, pdev, ASMT_CFG_CONTROL, &op);
+	if (ret) {
+		dev_err(pdev,
+			"Timed out on mailbox tx: 0x%llx\n",
+			data);
+		return ret;
+	}
+	if (err)
+		return err;
+
+	dm_pci_write_config32(pdev, ASMT_CFG_DATA_WRITE0, data);
+	dm_pci_write_config32(pdev, ASMT_CFG_DATA_WRITE1, data >> 32);
+	dm_pci_write_config8(pdev, ASMT_CFG_CONTROL, ASMT_CFG_CONTROL_WRITE);
+
+	return 0;
+}
+
+static int asmedia_mbox_rx(struct udevice *pdev, u64 *data)
+{
+	u8 op;
+	u32 low, high;
+	int ret, err;
+
+	ret = read_poll_timeout(dm_pci_read_config8, err,
+				err || (op & ASMT_CFG_CONTROL_READ),
+				1, TIMEOUT_USEC, pdev, ASMT_CFG_CONTROL, &op);
+	if (ret) {
+		dev_err(pdev, "Timed out on mailbox rx\n");
+		return ret;
+	}
+	if (err)
+		return err;
+
+	dm_pci_read_config32(pdev, ASMT_CFG_DATA_READ0, &low);
+	dm_pci_read_config32(pdev, ASMT_CFG_DATA_READ1, &high);
+	dm_pci_write_config8(pdev, ASMT_CFG_CONTROL, ASMT_CFG_CONTROL_READ);
+
+	*data = ((u64)high << 32) | low;
+	return 0;
+}
+
+static int asmedia_get_fw_version(struct udevice *pdev, u64 *version)
+{
+	int err = 0;
+	u64 cmd;
+
+	err = asmedia_mbox_tx(pdev, ASMT_CMD_GET_FWVER);
+	if (err)
+		return err;
+	err = asmedia_mbox_tx(pdev, 0);
+	if (err)
+		return err;
+
+	err = asmedia_mbox_rx(pdev, &cmd);
+	if (err)
+		return err;
+	err = asmedia_mbox_rx(pdev, version);
+	if (err)
+		return err;
+
+	if (cmd != ASMT_CMD_GET_FWVER) {
+		dev_err(pdev, "Unexpected reply command 0x%llx\n", cmd);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool asmedia_check_firmware(struct udevice *pdev)
+{
+	u64 fwver;
+	int ret;
+
+	ret = asmedia_get_fw_version(pdev, &fwver);
+	if (ret)
+		return ret;
+
+	dev_info(pdev, "Firmware version: 0x%llx\n", fwver);
+
+	return fwver != ASMT_FWVER_ROM;
+}
+
+static int asmedia_wait_reset(struct udevice *pdev, struct xhci_hcor *hcor)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_poll_sleep_timeout(&hcor->or_usbcmd,
+				       val, !(val & CMD_RESET),
+				       1000, RESET_TIMEOUT_USEC);
+
+	if (!ret)
+		return 0;
+
+	dev_err(pdev, "Reset timed out, trying to kick it\n");
+
+	dm_pci_write_config8(pdev, ASMT_CFG_SRAM_ACCESS,
+			     ASMT_CFG_SRAM_ACCESS_ENABLE);
+
+	dm_pci_write_config8(pdev, ASMT_CFG_SRAM_ACCESS, 0);
+
+	ret = readl_poll_sleep_timeout(&hcor->or_usbcmd,
+				       val, !(val & CMD_RESET),
+				       1000, RESET_TIMEOUT_USEC);
+
+	if (ret)
+		dev_err(pdev, "Reset timed out, giving up\n");
+
+	return ret;
+}
+
+static int asmedia_read_reg(struct udevice *pdev, struct xhci_hccr *hccr,
+			    u16 addr, u8 *val)
+{
+	void __iomem *regs = (void *)hccr;
+	u8 status;
+	int ret;
+
+	ret = readb_poll_sleep_timeout(regs + ASMT_REG_STATUS, status,
+				       !(status & ASMT_REG_STATUS_BUSY),
+				       1000, TIMEOUT_USEC);
+
+	if (ret) {
+		dev_err(pdev,
+			"Read reg wait timed out ([%04x])\n", addr);
+		return ret;
+	}
+
+	writew_relaxed(addr, regs + ASMT_REG_ADDR);
+
+	ret = readb_poll_sleep_timeout(regs + ASMT_REG_STATUS,  status,
+				       !(status & ASMT_REG_STATUS_BUSY),
+				       1000, TIMEOUT_USEC);
+
+	if (ret) {
+		dev_err(pdev,
+			"Read reg addr timed out ([%04x])\n", addr);
+		return ret;
+	}
+
+	*val = readb_relaxed(regs + ASMT_REG_RDATA);
+	return 0;
+}
+
+static int asmedia_write_reg(struct udevice *pdev, struct xhci_hccr *hccr,
+			     u16 addr, u8 data, bool wait)
+{
+	void __iomem *regs = (void *)hccr;
+	u8 status, val;
+	int ret, err;
+
+	writew_relaxed(addr, regs + ASMT_REG_ADDR);
+
+	ret = readb_poll_sleep_timeout(regs + ASMT_REG_STATUS, status,
+				       !(status & ASMT_REG_STATUS_BUSY),
+				       1000, TIMEOUT_USEC);
+
+	if (ret) {
+		dev_err(pdev,
+			"Write reg addr timed out ([%04x] = %02x)\n",
+			addr, data);
+		return ret;
+	}
+
+	writeb_relaxed(data, regs + ASMT_REG_WDATA);
+
+	ret = readb_poll_sleep_timeout(regs + ASMT_REG_STATUS, status,
+				       !(status & ASMT_REG_STATUS_BUSY),
+				       1000, TIMEOUT_USEC);
+
+	if (ret) {
+		dev_err(pdev,
+			"Write reg data timed out ([%04x] = %02x)\n",
+			addr, data);
+		return ret;
+	}
+
+	if (!wait)
+		return 0;
+
+	ret = read_poll_timeout(asmedia_read_reg, err, err || val == data,
+				0, TIMEOUT_USEC, pdev, hccr, addr, &val);
+	if (ret) {
+		dev_err(pdev,
+			"Verify register timed out ([%04x] = %02x)\n",
+			addr, data);
+		return ret;
+	}
+	if (err) {
+		dev_err(pdev,
+			"Verify register read error ([%04x] = %02x)\n",
+			addr, data);
+		return err;
+	}
+
+	return 0;
+}
+
+static int asmedia_load_fw(struct udevice *pdev, struct xhci_hccr *hccr,
+			   struct xhci_hcor *hcor, void *fwdata, size_t fwsize)
+{
+	void __iomem *regs = (void *)hccr;
+	const u16 *fw_data = (const u16 *)fwdata;
+	u16 raddr;
+	u32 data;
+	size_t index = 0, addr = 0;
+	size_t words = fwsize >> 1;
+	int ret, err;
+
+	ret = asmedia_write_reg(pdev, hccr, ASMT_MMIO_CPU_MODE_NEXT,
+				ASMT_MMIO_CPU_MODE_HALFSPEED, false);
+	if (ret)
+		return ret;
+
+	ret = asmedia_write_reg(pdev, hccr, ASMT_MMIO_CPU_EXEC_CTRL,
+				ASMT_MMIO_CPU_EXEC_CTRL_RESET, false);
+	if (ret)
+		return ret;
+
+	ret = asmedia_wait_reset(pdev, hcor);
+	if (ret) {
+		dev_err(pdev, "Failed pre-upload reset\n");
+		return ret;
+	}
+
+	ret = asmedia_write_reg(pdev, hccr, ASMT_MMIO_CPU_EXEC_CTRL,
+				ASMT_MMIO_CPU_EXEC_CTRL_HALT, false);
+	if (ret)
+		return ret;
+
+	ret = asmedia_write_reg(pdev, hccr, ASMT_MMIO_CPU_MISC,
+				ASMT_MMIO_CPU_MISC_CODE_RAM_WR, true);
+	if (ret)
+		return ret;
+
+	dm_pci_write_config8(pdev, ASMT_CFG_SRAM_ACCESS,
+			     ASMT_CFG_SRAM_ACCESS_ENABLE);
+
+	/* The firmware upload is interleaved in 0x4000 word blocks */
+	while (index < words) {
+		data = fw_data[index];
+		if ((index | 0x4000) < words)
+			data |= fw_data[index | 0x4000] << 16;
+
+		dm_pci_write_config16(pdev, ASMT_CFG_SRAM_ADDR,
+				      addr);
+
+		writel_relaxed(data, regs + ASMT_REG_CODE_WDATA);
+
+		ret = read_poll_timeout(dm_pci_read_config16, err,
+					err || (raddr != addr),
+					1, TIMEOUT_USEC, pdev,
+					ASMT_CFG_SRAM_ADDR, &raddr);
+		if (ret) {
+			dev_err(pdev, "Word write timed out\n");
+			return ret;
+		}
+		if (err)
+			return err;
+
+		if (++index & 0x4000)
+			index += 0x4000;
+		addr += 2;
+	}
+
+	dm_pci_write_config8(pdev, ASMT_CFG_SRAM_ACCESS, 0);
+
+	ret = asmedia_write_reg(pdev, hccr, ASMT_MMIO_CPU_MISC, 0, true);
+	if (ret)
+		return ret;
+
+	ret = asmedia_write_reg(pdev, hccr, ASMT_MMIO_CPU_MODE_NEXT,
+				ASMT_MMIO_CPU_MODE_RAM |
+				ASMT_MMIO_CPU_MODE_HALFSPEED, false);
+	if (ret)
+		return ret;
+
+	ret = asmedia_write_reg(pdev, hccr, ASMT_MMIO_CPU_EXEC_CTRL, 0, false);
+	if (ret)
+		return ret;
+
+	ret = asmedia_wait_reset(pdev, hcor);
+	if (ret) {
+		dev_err(pdev, "Failed post-upload reset\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int asmedia_xhci_check_request_fw(struct udevice *pdev,
+				  struct xhci_hccr *hccr,
+				  struct xhci_hcor *hcor)
+{
+	const char *fw_name = "vendorfw/u-boot/asmedia/asm2214a-apple.bin";
+	struct udevice *fsdev;
+	void *data;
+	int ret;
+
+	/* Check if device has firmware, if so skip everything */
+	ret = asmedia_check_firmware(pdev);
+	if (ret < 0)
+		return ret;
+	else if (ret == 1)
+		return 0;
+
+	ret = get_fs_loader(&fsdev);
+	if (ret) {
+		dev_err(pdev, "Could not load firmware %s: %d\n",
+			fw_name, ret);
+		return ret;
+	}
+
+	data = malloc(SZ_256K);
+	ret = request_firmware_into_buf(fsdev, fw_name, data, SZ_256K, 0);
+	if (ret < 0) {
+		dev_err(pdev, "Could not load firmware %s: %d\n",
+			fw_name, ret);
+		return ret;
+	}
+
+	ret = asmedia_load_fw(pdev, hccr, hcor, data, ret);
+	if (ret) {
+		dev_err(pdev, "Firmware upload failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = asmedia_check_firmware(pdev);
+	if (ret < 0) {
+		goto err;
+	} else if (ret != 1) {
+		dev_err(pdev, "Firmware version is too old after upload\n");
+		ret = -EIO;
+	} else {
+		ret = 0;
+	}
+
+err:
+	free(data);
+	return ret;
+}
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index f6972af7963..09d0abfd5af 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -52,6 +52,7 @@ static int xhci_pci_init(struct udevice *dev, struct xhci_hccr **ret_hccr,
 static int xhci_pci_probe(struct udevice *dev)
 {
 	struct xhci_pci_plat *plat = dev_get_plat(dev);
+	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
 	struct xhci_hccr *hccr;
 	struct xhci_hcor *hcor;
 	int ret;
@@ -76,6 +77,14 @@ static int xhci_pci_probe(struct udevice *dev)
 	if (ret)
 		goto err_reset;
 
+	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_ASMEDIA) &&
+	    pplat->vendor == PCI_VENDOR_ID_ASMEDIA &&
+	    pplat->device == 0x2142) {
+		ret = asmedia_xhci_check_request_fw(dev, hccr, hcor);
+		if (ret)
+			goto err_reset;
+	}
+
 	ret = xhci_register(dev, hccr, hcor);
 	if (ret)
 		goto err_reset;
diff --git a/include/usb/xhci.h b/include/usb/xhci.h
index ba065311df5..14de983b152 100644
--- a/include/usb/xhci.h
+++ b/include/usb/xhci.h
@@ -1308,4 +1308,7 @@ static inline void xhci_dma_unmap(struct xhci_ctrl *ctrl, dma_addr_t addr,
 #endif
 }
 
+int asmedia_xhci_check_request_fw(struct udevice *, struct xhci_hccr *,
+				  struct xhci_hcor *);
+
 #endif /* HOST_XHCI_H_ */
-- 
2.50.1

