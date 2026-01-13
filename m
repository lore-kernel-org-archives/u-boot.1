Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59784CF45DB
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 01:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A078382A;
	Tue, 13 Jan 2026 02:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="G7ZLJnjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292898388D; Tue, 13 Jan 2026 02:21:24 +0100 (CET)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C6D83700
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1768267281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QrNv7R6XxwRFxRHI1srsyc93+oLTbdwrkXM6ucrDOY=;
 b=G7ZLJnjy+rvggt135RBPRPdKpEQMVY/6iJDtjuJPxnfkeRg3g5mJBk6JZU/qssP7fDlekJ
 yUfbfEDD5mSpcqkY8TWp8/x7GMAjvz/VDH7j/7JPPG0EuIChfmKb8rYFNh+mlyBp1FKH7I
 pN6kG/oO/oFILhFhQZMSB7ERhqHf2G0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 1/3] PCI: sandbox: Use a parallel structure for emulation
Date: Mon, 12 Jan 2026 20:20:35 -0500
Message-Id: <20260113012037.2566942-2-sean.anderson@linux.dev>
In-Reply-To: <20260113012037.2566942-1-sean.anderson@linux.dev>
References: <20260113012037.2566942-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Currently, sandbox associates PCI emulators with PCI devices on a
per-device level. To create this association, the PCI bus needs an ofnode
for each device to include the appropriate phandle, or sandbox,dev-info can
be used to automatically create PCI devices. In the latter case, the
emulator is bound to the PCI device itself! This prevents testing any
U-Boot PCI driver, and also precludes bridges without device tree nodes (as
non-zero busses cannot be specified with sandbox,dev-info).

Instead of extending sandbox,dev-info, switch to a more-natural approach
where PCI emulators form a parallel tree exactly matching the PCI hierarchy
to emulate. To do the lookup, we walk up the PCI tree until we get to the
root port, look up the emulator, and retrace our steps down the emulator
tree.

As it's no longer necessary to have device tree nodes just to link to the
appropriate emulator, remove the superfluous ones. 01:10.0 and 02:1f.0 are
left in because they are required by dm_test_pci_drvdata and
dm_test_pci_mixed, respectively.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- New

 arch/sandbox/dts/sandbox.dtsi         | 16 +++--
 arch/sandbox/dts/test.dts             | 85 +++++++++++++++++-------
 doc/develop/driver-model/pci-info.rst | 59 +++++------------
 drivers/misc/p2sb_emul.c              |  7 +-
 drivers/misc/swap_case.c              |  7 +-
 drivers/pci/pci-emul-uclass.c         | 82 +++++++++++++++++------
 drivers/pci/pci_sandbox.c             | 94 +++++----------------------
 include/pci.h                         |  5 +-
 8 files changed, 179 insertions(+), 176 deletions(-)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index 02b03894eaf..7d5921bb80a 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -202,10 +202,11 @@
 	};
 
 	pci@0 {
+		sandbox,emul = <&pci0_emul>;
+
 		pci@1e,0 {
 			compatible = "sandbox,pmc";
 			reg = <0xf000 0 0 0 0>;
-			sandbox,emul = <&pmc_emul>;
 			gpe0-dwx-mask = <0xf>;
 			gpe0-dwx-shift-base = <4>;
 			gpe0-dw = <6 7 9>;
@@ -216,17 +217,22 @@
 		pci@1f,0 {
 			compatible = "pci-generic";
 			reg = <0xf800 0 0 0 0>;
-			sandbox,emul = <&swap_case_emul>;
 		};
 	};
 
-	emul {
+	pci0_emul: emul {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "sandbox,pci-emul-parent";
-		pmc_emul: emul@1e,0 {
+
+		emul@1e,0 {
 			compatible = "sandbox,pmc-emul";
+			reg = <0xf0>;
 		};
-		swap_case_emul: emul@1f,0 {
+
+		emul@1f,0 {
 			compatible = "sandbox,swap-case";
+			reg = <0xf8>;
 		};
 	};
 
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index cd53c170171..e945a47fb01 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1282,32 +1282,28 @@
 				0x01000000 0 0x20000000 0x20000000 0 0x2000>;
 		iommu-map = <0x0010 &iommu 0 1>;
 		iommu-map-mask = <0xfffffff8>;
-		pci@0,0 {
-			compatible = "pci-generic";
-			reg = <0x0000 0 0 0 0>;
-			sandbox,emul = <&swap_case_emul0_0>;
-		};
+		sandbox,emul = <&pci_emul0>;
+
 		pci@1,0 {
 			compatible = "pci-generic";
 			/* reg 0 is at 0x14, using FDT_PCI_SPACE_MEM32 */
 			reg = <0x02000814 0 0 0x80 0
 			       0x01000810 0 0 0xc0 0>;
-			sandbox,emul = <&swap_case_emul0_1>;
 		};
+
 		p2sb-pci@2,0 {
 			compatible = "sandbox,p2sb";
 			reg = <0x02001010 0 0 0 0>;
-			sandbox,emul = <&p2sb_emul>;
 
 			adder {
 				intel,p2sb-port-id = <3>;
 				compatible = "sandbox,adder";
 			};
 		};
+
 		pci@1e,0 {
 			compatible = "sandbox,pmc";
 			reg = <0xf000 0 0 0 0>;
-			sandbox,emul = <&pmc_emul1e>;
 			acpi-base = <0x400>;
 			gpe0-dwx-mask = <0xf>;
 			gpe0-dwx-shift-base = <4>;
@@ -1315,31 +1311,43 @@
 			gpe0-sts = <0x20>;
 			gpe0-en = <0x30>;
 		};
+
 		pci@1f,0 {
 			compatible = "pci-generic";
 			/* reg 0 is at 0x10, using FDT_PCI_SPACE_IO */
 			reg = <0x0100f810 0 0 0x100 0>;
-			sandbox,emul = <&swap_case_emul0_1f>;
 		};
 	};
 
-	pci-emul0 {
+	pci_emul0: pci-emul0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "sandbox,pci-emul-parent";
-		swap_case_emul0_0: emul0@0,0 {
+
+		emul@0,0 {
 			compatible = "sandbox,swap-case";
+			reg = <0x00>;
 		};
-		swap_case_emul0_1: emul0@1,0 {
+
+		emul@1,0 {
 			compatible = "sandbox,swap-case";
+			reg = <0x08>;
 			use-ea;
 		};
-		swap_case_emul0_1f: emul0@1f,0 {
-			compatible = "sandbox,swap-case";
-		};
-		p2sb_emul: emul@2,0 {
+
+		emul@2,0 {
 			compatible = "sandbox,p2sb-emul";
+			reg = <0x10>;
 		};
-		pmc_emul1e: emul@1e,0 {
+
+		emul@1e,0 {
 			compatible = "sandbox,pmc-emul";
+			reg = <0xf0>;
+		};
+
+		emul0@1f,0 {
+			compatible = "sandbox,swap-case";
+			reg = <0xf8>;
 		};
 	};
 
@@ -1352,14 +1360,34 @@
 		ranges = <0x02000000 0 0x30000000 0x30000000 0 0x2000 // MEM0
 			  0x02000000 0 0x31000000 0x3e000000 0 0x2000 // MEM1
 			  0x01000000 0 0x40000000 0x40000000 0 0x2000>;
-		sandbox,dev-info = <0x08 0x00 0x1234 0x5678
-				    0x0c 0x00 0x1234 0x5678
-				    0x10 0x00 0x1234 0x5678>;
+		sandbox,emul = <&pci_emul1>;
+
 		pci@10,0 {
 			reg = <0x8000 0 0 0 0>;
 		};
 	};
 
+	pci_emul1: pci-emul1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "sandbox,pci-emul-parent";
+
+		emul@8,0 {
+			compatible = "sandbox,swap-case";
+			reg = <0x40>;
+		};
+
+		emul@c,0 {
+			compatible = "sandbox,swap-case";
+			reg = <0x60>;
+		};
+
+		emul@10,0 {
+			compatible = "sandbox,swap-case";
+			reg = <0x80>;
+		};
+	};
+
 	pci2: pci@2 {
 		compatible = "sandbox,pci";
 		device_type = "pci";
@@ -1368,18 +1396,27 @@
 		#size-cells = <2>;
 		ranges = <0x02000000 0 0x50000000 0x50000000 0 0x2000
 				0x01000000 0 0x60000000 0x60000000 0 0x2000>;
-		sandbox,dev-info = <0x08 0x00 0x1234 0x5678>;
+		sandbox,emul = <&pci_emul2>;
+
 		pci@1f,0 {
 			compatible = "pci-generic";
 			reg = <0xf800 0 0 0 0>;
-			sandbox,emul = <&swap_case_emul2_1f>;
 		};
 	};
 
-	pci-emul2 {
+	pci_emul2: pci-emul2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "sandbox,pci-emul-parent";
-		swap_case_emul2_1f: emul2@1f,0 {
+
+		emul@8,0 {
 			compatible = "sandbox,swap-case";
+			reg = <0x40>;
+		};
+
+		emul@1f,0 {
+			compatible = "sandbox,swap-case";
+			reg = <0xf8>;
 		};
 	};
 
diff --git a/doc/develop/driver-model/pci-info.rst b/doc/develop/driver-model/pci-info.rst
index dea595b6cff..1c916b9009d 100644
--- a/doc/develop/driver-model/pci-info.rst
+++ b/doc/develop/driver-model/pci-info.rst
@@ -116,57 +116,28 @@ With sandbox we need a device emulator for each device on the bus since there
 is no real PCI bus. This works by looking in the device tree node for an
 emulator driver. For example::
 
-	pci@1f,0 {
-		compatible = "pci-generic";
-		reg = <0xf800 0 0 0 0>;
-		sandbox,emul = <&emul_1f>;
-	};
-	pci-emul {
+	pci {
+		compatible = "sandbox,pci";
+                /* ... snip ... */
+		sandbox,emul = <&pci_emul>;
+        };
+
+	pci_emul: pci-emul {
 		compatible = "sandbox,pci-emul-parent";
-		emul_1f: emul@1f,0 {
+		emul@1f,0 {
 			compatible = "sandbox,swap-case";
-			#emul-cells = <0>;
+                        reg = <0xf8>;
 		};
 	};
 
-This means that there is a 'sandbox,swap-case' driver at that bus position.
-Note that the first cell in the 'reg' value is the bus/device/function. See
-PCI_BDF() for the encoding (it is also specified in the IEEE Std 1275-1994
-PCI bus binding document, v2.1)
-
-The pci-emul node should go outside the pci bus node, since otherwise it will
-be scanned as a PCI device, causing confusion.
+This means that there is a 'sandbox,swap-case' driver at device 31 function 0.
+The 'reg' value is the device (upper 5 bits) and function (lower 3 bits).
 
 When this bus is scanned we will end up with something like this::
 
-   `- * pci@0 @ 05c660c8, 0
-    `-   pci@1f,0 @ 05c661c8, 63488
-   `-   emul@1f,0 @ 05c662c8
+     pci           0  [ + ]   pci_sandbox           |-- pci@0
+     pci_generi    0  [   ]   pci_generic_drv       |   `-- pci@1f,0
+     pci_emul_p    0  [ + ]   pci_emul_parent_drv   |-- emul
+     pci_emul      1  [ + ]   sandbox_swap_case_em  |   `-- emul@1f,0
 
 When accesses go to the pci@1f,0 device they are forwarded to its emulator.
-
-The sandbox PCI drivers also support dynamic driver binding, allowing device
-driver to declare the driver binding information via U_BOOT_PCI_DEVICE(),
-eliminating the need to provide any device tree node under the host controller
-node. It is required a "sandbox,dev-info" property must be provided in the
-host controller node for this functionality to work.
-
-.. code-block:: none
-
-	pci1: pci@1 {
-		compatible = "sandbox,pci";
-		...
-		sandbox,dev-info = <0x08 0x00 0x1234 0x5678
-				    0x0c 0x00 0x1234 0x5678>;
-	};
-
-The "sandbox,dev-info" property specifies all dynamic PCI devices on this bus.
-Each dynamic PCI device is encoded as 4 cells a group. The first and second
-cells are PCI device number and function number respectively. The third and
-fourth cells are PCI vendor ID and device ID respectively.
-
-When this bus is scanned we will end up with something like this::
-
- pci        [ + ]   pci_sandbo  |-- pci1
- pci_emul   [   ]   sandbox_sw  |   |-- sandbox_swap_case_emul
- pci_emul   [   ]   sandbox_sw  |   `-- sandbox_swap_case_emul
diff --git a/drivers/misc/p2sb_emul.c b/drivers/misc/p2sb_emul.c
index 3dac6bd82e3..12c2b0b93ae 100644
--- a/drivers/misc/p2sb_emul.c
+++ b/drivers/misc/p2sb_emul.c
@@ -264,9 +264,14 @@ U_BOOT_DRIVER(sandbox_p2sb_emul_emul) = {
 	.plat_auto	= sizeof(struct p2sb_emul_plat),
 };
 
+U_BOOT_DRIVER(sandbox_p2sb_emul) = {
+	.name		= "sandbox_p2sb_emul",
+	.id		= UCLASS_MISC,
+};
+
 static struct pci_device_id sandbox_p2sb_emul_supported[] = {
 	{ PCI_VDEVICE(SANDBOX, SANDBOX_PCI_PMC_EMUL_ID) },
 	{},
 };
 
-U_BOOT_PCI_DEVICE(sandbox_p2sb_emul_emul, sandbox_p2sb_emul_supported);
+U_BOOT_PCI_DEVICE(sandbox_p2sb_emul, sandbox_p2sb_emul_supported);
diff --git a/drivers/misc/swap_case.c b/drivers/misc/swap_case.c
index d4a5620c62c..30c8d68d8a7 100644
--- a/drivers/misc/swap_case.c
+++ b/drivers/misc/swap_case.c
@@ -406,10 +406,15 @@ U_BOOT_DRIVER(sandbox_swap_case_emul) = {
 	.plat_auto	= sizeof(struct swap_case_plat),
 };
 
+U_BOOT_DRIVER(sandbox_swap_case) = {
+	.name		= "sandbox_swap_case",
+	.id		= UCLASS_MISC,
+};
+
 static struct pci_device_id sandbox_swap_case_supported[] = {
 	{ PCI_VDEVICE(SANDBOX, SANDBOX_PCI_SWAP_CASE_EMUL_ID),
 		SWAP_CASE_DRV_DATA },
 	{},
 };
 
-U_BOOT_PCI_DEVICE(sandbox_swap_case_emul, sandbox_swap_case_supported);
+U_BOOT_PCI_DEVICE(sandbox_swap_case, sandbox_swap_case_supported);
diff --git a/drivers/pci/pci-emul-uclass.c b/drivers/pci/pci-emul-uclass.c
index 166ee9fcd43..e919cfd3e61 100644
--- a/drivers/pci/pci-emul-uclass.c
+++ b/drivers/pci/pci-emul-uclass.c
@@ -9,40 +9,65 @@
 #include <log.h>
 #include <linux/libfdt.h>
 #include <pci.h>
+#include <dm/device_compat.h>
 #include <dm/lists.h>
 
 struct sandbox_pci_emul_priv {
 	int dev_count;
 };
 
-int sandbox_pci_get_emul(const struct udevice *bus, pci_dev_t find_devfn,
-			 struct udevice **containerp, struct udevice **emulp)
+/**
+ * struct pci_emul_uc_plat - holds info about an emulator device
+ *
+ * There is always at most one emulator per client
+ *
+ * @devfn: Device/Function
+ */
+struct pci_emul_uc_plat {
+	u8 devfn;
+};
+
+int sandbox_pci_get_emul(struct udevice *bus, pci_dev_t devfn,
+			 struct udevice **emulp)
 {
-	struct pci_emul_uc_priv *upriv;
+	struct pci_emul_uc_priv *cpriv;
 	struct udevice *dev;
 	int ret;
 
-	*containerp = NULL;
-	ret = pci_bus_find_devfn(bus, PCI_MASK_BUS(find_devfn), &dev);
-	if (ret) {
-		debug("%s: Could not find emulator for dev %x\n", __func__,
-		      find_devfn);
-		return ret;
+	if (device_is_on_pci_bus(bus)) {
+		ret = sandbox_pci_get_emul(bus->parent,
+					   PCI_MASK_BUS(dm_pci_get_bdf(bus)),
+					   &dev);
+		if (ret)
+			return ret;
+	} else {
+		ret = uclass_get_device_by_phandle(UCLASS_PCI_EMUL_PARENT, bus,
+						   "sandbox,emul", &dev);
+		if (ret) {
+			dev_dbg(bus, "Could not find emulator: %d\n", ret);
+			return ret;
+		}
 	}
-	*containerp = dev;
 
-	ret = uclass_get_device_by_phandle(UCLASS_PCI_EMUL, dev, "sandbox,emul",
-					   emulp);
-	if (!ret) {
-		upriv = dev_get_uclass_priv(*emulp);
+	device_foreach_child_probe(*emulp, dev) {
+		struct pci_emul_uc_plat *plat = dev_get_uclass_plat(*emulp);
 
-		upriv->client = dev;
-	} else if (device_get_uclass_id(dev) != UCLASS_PCI_GENERIC) {
-		/*
-		 * See commit 4345998ae9df,
-		 * "pci: sandbox: Support dynamically binding device driver"
-		 */
-		*emulp = dev;
+		if (PCI_TO_BDF(plat->devfn) == devfn)
+			goto found;
+	}
+
+	dev_dbg(dev, "No emulator for %x.%x\n", PCI_DEV(devfn), PCI_FUNC(devfn));
+	*emulp = NULL;
+	return -ENODEV;
+
+found:
+	cpriv = dev_get_uclass_priv(*emulp);
+	if (!cpriv->client) {
+		int err;
+
+		err = pci_bus_find_devfn(bus, devfn, &cpriv->client);
+		if (err)
+			dev_dbg(*emulp, "Could not find client: %d\n", err);
 	}
 
 	return 0;
@@ -79,6 +104,19 @@ uint sandbox_pci_read_bar(u32 barval, int type, uint size)
 	return result;
 }
 
+static int sandbox_pci_emul_post_bind(struct udevice *dev)
+{
+	struct pci_emul_uc_plat *plat = dev_get_uclass_plat(dev);
+	fdt_addr_t devfn, size;
+
+	devfn = ofnode_get_addr_size_index_notrans(dev_ofnode(dev), 0, &size);
+	if (devfn > 255)
+		return -EINVAL;
+
+	plat->devfn = devfn;
+	return dm_scan_fdt_dev(dev);
+}
+
 static int sandbox_pci_emul_post_probe(struct udevice *dev)
 {
 	struct sandbox_pci_emul_priv *priv = uclass_get_priv(dev->uclass);
@@ -102,10 +140,12 @@ static int sandbox_pci_emul_pre_remove(struct udevice *dev)
 UCLASS_DRIVER(pci_emul) = {
 	.id		= UCLASS_PCI_EMUL,
 	.name		= "pci_emul",
+	.post_bind	= sandbox_pci_emul_post_bind,
 	.post_probe	= sandbox_pci_emul_post_probe,
 	.pre_remove	= sandbox_pci_emul_pre_remove,
 	.priv_auto	= sizeof(struct sandbox_pci_emul_priv),
 	.per_device_auto	= sizeof(struct pci_emul_uc_priv),
+	.per_device_plat_auto	= sizeof(struct pci_emul_uc_plat),
 };
 
 /*
diff --git a/drivers/pci/pci_sandbox.c b/drivers/pci/pci_sandbox.c
index fed0850458d..a55802b6720 100644
--- a/drivers/pci/pci_sandbox.c
+++ b/drivers/pci/pci_sandbox.c
@@ -9,29 +9,22 @@
 #include <log.h>
 #include <pci.h>
 
-#define FDT_DEV_INFO_CELLS	4
-#define FDT_DEV_INFO_SIZE	(FDT_DEV_INFO_CELLS * sizeof(u32))
-
-#define SANDBOX_PCI_DEVFN(d, f)	((d << 3) | f)
-
-struct sandbox_pci_priv {
-	struct {
-		u16 vendor;
-		u16 device;
-	} vendev[256];
-};
-
-static int sandbox_pci_write_config(struct udevice *bus, pci_dev_t devfn,
+static int sandbox_pci_write_config(struct udevice *bus, pci_dev_t bdf,
 				    uint offset, ulong value,
 				    enum pci_size_t size)
 {
 	struct dm_pci_emul_ops *ops;
-	struct udevice *container, *emul;
+	struct udevice *emul;
 	int ret;
 
-	ret = sandbox_pci_get_emul(bus, devfn, &container, &emul);
+	ret = uclass_get_device_by_seq(UCLASS_PCI, PCI_BUS(bdf), &bus);
+	if (ret)
+		return ret;
+
+	ret = sandbox_pci_get_emul(bus, PCI_MASK_BUS(bdf), &emul);
 	if (ret)
 		return ret == -ENODEV ? 0 : ret;
+
 	ops = pci_get_emul_ops(emul);
 	if (!ops || !ops->write_config)
 		return -ENOSYS;
@@ -39,36 +32,24 @@ static int sandbox_pci_write_config(struct udevice *bus, pci_dev_t devfn,
 	return ops->write_config(emul, offset, value, size);
 }
 
-static int sandbox_pci_read_config(const struct udevice *bus, pci_dev_t devfn,
+static int sandbox_pci_read_config(const struct udevice *bus, pci_dev_t bdf,
 				   uint offset, ulong *valuep,
 				   enum pci_size_t size)
 {
 	struct dm_pci_emul_ops *ops;
-	struct udevice *container, *emul;
-	struct sandbox_pci_priv *priv = dev_get_priv(bus);
+	struct udevice *emul, *sub_bus;
 	int ret;
 
+	ret = uclass_get_device_by_seq(UCLASS_PCI, PCI_BUS(bdf), &sub_bus);
+	if (ret)
+		return ret;
+
 	/* Prepare the default response */
 	*valuep = pci_get_ff(size);
-	ret = sandbox_pci_get_emul(bus, devfn, &container, &emul);
-	if (ret) {
-		if (!container) {
-			u16 vendor, device;
+	ret = sandbox_pci_get_emul(sub_bus, PCI_MASK_BUS(bdf), &emul);
+	if (ret)
+		return ret == -ENODEV ? 0 : ret;
 
-			devfn = SANDBOX_PCI_DEVFN(PCI_DEV(devfn),
-						  PCI_FUNC(devfn));
-			vendor = priv->vendev[devfn].vendor;
-			device = priv->vendev[devfn].device;
-			if (offset == PCI_VENDOR_ID && vendor)
-				*valuep = vendor;
-			else if (offset == PCI_DEVICE_ID && device)
-				*valuep = device;
-
-			return 0;
-		} else {
-			return ret == -ENODEV ? 0 : ret;
-		}
-	}
 	ops = pci_get_emul_ops(emul);
 	if (!ops || !ops->read_config)
 		return -ENOSYS;
@@ -76,41 +57,6 @@ static int sandbox_pci_read_config(const struct udevice *bus, pci_dev_t devfn,
 	return ops->read_config(emul, offset, valuep, size);
 }
 
-static int sandbox_pci_probe(struct udevice *dev)
-{
-	struct sandbox_pci_priv *priv = dev_get_priv(dev);
-	const fdt32_t *cell;
-	u8 pdev, pfn, devfn;
-	int len;
-
-	cell = ofnode_get_property(dev_ofnode(dev), "sandbox,dev-info", &len);
-	if (!cell)
-		return 0;
-
-	if ((len % FDT_DEV_INFO_SIZE) == 0) {
-		int num = len / FDT_DEV_INFO_SIZE;
-		int i;
-
-		for (i = 0; i < num; i++) {
-			debug("dev info #%d: %02x %02x %04x %04x\n", i,
-			      fdt32_to_cpu(cell[0]), fdt32_to_cpu(cell[1]),
-			      fdt32_to_cpu(cell[2]), fdt32_to_cpu(cell[3]));
-
-			pdev = fdt32_to_cpu(cell[0]);
-			pfn = fdt32_to_cpu(cell[1]);
-			if (pdev > 31 || pfn > 7)
-				continue;
-			devfn = SANDBOX_PCI_DEVFN(pdev, pfn);
-			priv->vendev[devfn].vendor = fdt32_to_cpu(cell[2]);
-			priv->vendev[devfn].device = fdt32_to_cpu(cell[3]);
-
-			cell += FDT_DEV_INFO_CELLS;
-		}
-	}
-
-	return 0;
-}
-
 static const struct dm_pci_ops sandbox_pci_ops = {
 	.read_config = sandbox_pci_read_config,
 	.write_config = sandbox_pci_write_config,
@@ -126,10 +72,4 @@ U_BOOT_DRIVER(pci_sandbox) = {
 	.id	= UCLASS_PCI,
 	.of_match = sandbox_pci_ids,
 	.ops	= &sandbox_pci_ops,
-	.probe	= sandbox_pci_probe,
-	.priv_auto	= sizeof(struct sandbox_pci_priv),
-
-	/* Attach an emulator if we can */
-	.child_post_bind = dm_scan_fdt_dev,
-	.per_child_plat_auto	= sizeof(struct pci_child_plat),
 };
diff --git a/include/pci.h b/include/pci.h
index 4b0facd6dcf..a8960140525 100644
--- a/include/pci.h
+++ b/include/pci.h
@@ -1630,12 +1630,11 @@ struct dm_pci_emul_ops {
  *
  * @bus:	PCI bus to search
  * @find_devfn:	PCI device and function address (PCI_DEVFN())
- * @containerp:	Returns container device if found
  * @emulp:	Returns emulated device if found
  * Return: 0 if found, -ENODEV if not found
  */
-int sandbox_pci_get_emul(const struct udevice *bus, pci_dev_t find_devfn,
-			 struct udevice **containerp, struct udevice **emulp);
+int sandbox_pci_get_emul(struct udevice *bus, pci_dev_t find_devfn,
+			 struct udevice **emulp);
 
 /**
  * sandbox_pci_get_client() - Find the client for an emulation device
-- 
2.35.1.1320.gc452695387.dirty

