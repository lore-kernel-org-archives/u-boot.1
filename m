Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFC6C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7308799D;
	Fri, 12 Jan 2024 09:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iUX88yJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC4386D38; Fri, 12 Jan 2024 09:53:22 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B6F87980
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705049598;
 bh=1QrV5aNtzBLtI6pX8I+bP3MakczTiBQrHN7/hCepSkU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iUX88yJUEqHB0ReD4z4DDBjg6RMPh5HPcaDlS3E/GyTHqDa7mL6nGB1o6aH2ZbplY
 nIsN3y+d0kGRQ42jDuLhPiGdue2sn+oFLKtW4hKN2PFWZyzA23Wck6mAZHgoiiemuQ
 OFdNKdYthuR8ekLxYUOQ3BX51ZZlHcJJ6o/O9VCvcNDdXrIAoqz1rvQHKOFfqtmWiP
 Dis7hQlEo/p5aWxVDJr4g/UGGGmPdDbRjwkkUWlr2RfSWtSN7GASbO5hiRF14yVzcH
 wnYYW5Te1FwWy4dxqgEkF0RZ/nnUXNq5ql+ZWGkalicdW7GaH2Z3PYY9LlFIkzRuqB
 ZxEENppGYcuMQ==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0B0A03782011;
 Fri, 12 Jan 2024 08:53:18 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 986269ED7CCA; Fri, 12 Jan 2024 09:53:17 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v4 1/7] usb: dwc3: Add dwc3 glue driver for am62
Date: Fri, 12 Jan 2024 09:52:16 +0100
Message-ID: <20240112085317.1866449-2-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112085317.1866449-1-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
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

Add glue code for TI AM62 to the dwc3 driver; Most code adopted from
TI vendor u-boot code.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

Changes in v4:
- Add config dependency on SYSCON
- Move defines and constants outside out of function scope

Changes in v2:
- Switch dwc3 glue to a seperate driver rather then in dwc-generic

 drivers/usb/dwc3/Kconfig     |  14 ++++
 drivers/usb/dwc3/Makefile    |   1 +
 drivers/usb/dwc3/dwc3-am62.c | 125 +++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index c0c8c16fd9c..0100723a68b 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -37,6 +37,20 @@ config SPL_USB_DWC3_GENERIC
 	  Select this for Xilinx ZynqMP and similar Platforms.
 	  This wrapper supports Host and Peripheral operation modes.
 
+config SPL_USB_DWC3_AM62
+	bool "TI AM62 USB wrapper"
+	depends on SPL_DM_USB && SPL_USB_DWC3_GENERIC && SPL_SYSCON
+	help
+	  Select this for TI AM62 Platforms.
+	  This wrapper supports Host and Peripheral operation modes.
+
+config USB_DWC3_AM62
+	bool "TI AM62 USB wrapper"
+	depends on DM_USB && USB_DWC3_GENERIC && SYSCON
+	help
+	  Select this for TI AM62 Platforms.
+	  This wrapper supports Host and Peripheral operation modes.
+
 config USB_DWC3_MESON_G12A
 	bool "Amlogic Meson G12A USB wrapper"
 	depends on DM_USB && USB_DWC3 && ARCH_MESON
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 97b4f7191ca..a46b6824ab7 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -6,6 +6,7 @@ dwc3-y					:= core.o
 
 obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
 
+obj-$(CONFIG_$(SPL_)USB_DWC3_AM62)	+= dwc3-am62.o
 obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
new file mode 100644
index 00000000000..99519602eb2
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI AM62 specific glue layer for DWC3
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
+
+#include "dwc3-generic.h"
+
+#define USBSS_MODE_CONTROL		0x1c
+#define USBSS_PHY_CONFIG		0x8
+#define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
+#define USBSS_PHY_VBUS_SEL_SHIFT	1
+#define USBSS_MODE_VALID	BIT(0)
+#define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
+static const int dwc3_ti_am62_rate_table[] = {	/* in KHZ */
+	9600,
+	10000,
+	12000,
+	19200,
+	20000,
+	24000,
+	25000,
+	26000,
+	38400,
+	40000,
+	58000,
+	50000,
+	52000,
+};
+
+static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
+					enum usb_dr_mode mode)
+{
+	struct clk usb2_refclk;
+	int rate_code, i, ret;
+	unsigned long rate;
+	u32 reg;
+	void *usbss;
+	bool vbus_divider;
+	struct regmap *syscon;
+	struct ofnode_phandle_args args;
+
+	usbss = dev_remap_addr_index(dev, 0);
+	if (IS_ERR(usbss)) {
+		dev_err(dev, "can't map IOMEM resource\n");
+		return;
+	}
+
+	ret = clk_get_by_name(dev, "ref", &usb2_refclk);
+	if (ret) {
+		dev_err(dev, "can't get usb2_refclk\n");
+		return;
+	}
+
+	/* Calculate the rate code */
+	rate = clk_get_rate(&usb2_refclk);
+	rate /= 1000;	/* To KHz */
+	for (i = 0; i < ARRAY_SIZE(dwc3_ti_am62_rate_table); i++) {
+		if (dwc3_ti_am62_rate_table[i] == rate)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(dwc3_ti_am62_rate_table)) {
+		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
+		return;
+	}
+
+	rate_code = i;
+
+	/* Read the syscon property */
+	syscon = syscon_regmap_lookup_by_phandle(dev, "ti,syscon-phy-pll-refclk");
+	if (IS_ERR(syscon)) {
+		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
+		return;
+	}
+
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "ti,syscon-phy-pll-refclk", NULL, 1,
+					     0, &args);
+	if (ret)
+		return;
+
+	/* Program PHY PLL refclk by reading syscon property */
+	ret = regmap_update_bits(syscon, args.args[0], PHY_PLL_REFCLK_MASK, rate_code);
+	if (ret) {
+		dev_err(dev, "failed to set phy pll reference clock rate\n");
+		return;
+	}
+
+	/* VBUS divider select */
+	reg = readl(usbss + USBSS_PHY_CONFIG);
+	vbus_divider = dev_read_bool(dev, "ti,vbus-divider");
+	if (vbus_divider)
+		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
+
+	writel(reg, usbss + USBSS_PHY_CONFIG);
+
+	/* Set mode valid */
+	reg = readl(usbss + USBSS_MODE_CONTROL);
+	reg |= USBSS_MODE_VALID;
+	writel(reg, usbss + USBSS_MODE_CONTROL);
+}
+
+struct dwc3_glue_ops ti_am62_ops = {
+	.glue_configure = dwc3_ti_am62_glue_configure,
+};
+
+static const struct udevice_id dwc3_am62_match[] = {
+	{ .compatible = "ti,am62-usb", .data = (ulong)&ti_am62_ops },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(dwc3_am62_wrapper) = {
+	.name	= "dwc3-am62",
+	.id	= UCLASS_SIMPLE_BUS,
+	.of_match = dwc3_am62_match,
+	.bind = dwc3_glue_bind,
+	.probe = dwc3_glue_probe,
+	.remove = dwc3_glue_remove,
+	.plat_auto	= sizeof(struct dwc3_glue_data),
+};
-- 
2.43.0

