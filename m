Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B79C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 05:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73B980713;
	Fri, 17 Jan 2025 06:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q8PHvJTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE630801B0; Fri, 17 Jan 2025 04:15:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F7680312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 04:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737083749; x=1768619749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eo9RVbJxjbJa3lUhR3Von32TMf1IrETVyeHG1kXQawo=;
 b=Q8PHvJTVrU1QYQ6yEugX726FREnoGwG8Q9MW4JtlLRNpK65dUIjXwXNE
 yFtAEm0QXHs9B/rBQ6R8IekUT/mHZiUVZxm3mSbbuLCt1E01gUUMZDdkC
 EdFkr0Y/Su4INZGny3oKdR79DJEJndjadIqQlbzVz5Mgnq69dv2clRo3O
 QNNuNdbvHhobxogcYUVitZGdGef13PYSBwqxl8CA9T2oGep+bpurh+ye4
 +tfdwVcZJdwjQL9+YXrXdIv+M793PcLpQL7raCXibqaXa0gmuTCHidfKC
 rl0Yu2C/tAklRcv0STUwHSe+tsyy1VxoXIVGmdKT8rKH65pOPOYfScOs4 w==;
X-CSE-ConnectionGUID: Sjqhv9SUR5m1hNR13Qwi5Q==
X-CSE-MsgGUID: vyDb2UvXQmmbuON/SgNmyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="47992630"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="47992630"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 19:15:49 -0800
X-CSE-ConnectionGUID: 3CxZ14JISRqiZmIKfX67Cw==
X-CSE-MsgGUID: ci/diNuURj+MyBvyuCSwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="110313903"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by fmviesa005.fm.intel.com with ESMTP; 16 Jan 2025 19:15:46 -0800
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Uboot Open List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tom Rini <trini@konsulko.com>, Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
Date: Fri, 17 Jan 2025 11:15:34 +0800
Message-Id: <20250117031535.19595-2-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250117031535.19595-1-boon.khai.ng@intel.com>
References: <20250117031535.19595-1-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 06:52:46 +0100
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

The Synopsys DWC XGMAC is a configurable Ethernet MAC/DMA IP block which
supports multiple options for bus type, clocking and reset structure, and
feature list.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 .../net/snps,dwc-xgmac-ethernet.txt           | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.txt

diff --git a/doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.txt b/doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.txt
new file mode 100644
index 0000000000..98a188fe5d
--- /dev/null
+++ b/doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.txt
@@ -0,0 +1,67 @@
+* Synopsys DWC Ethernet 10G Ethernet MAC IP version 2.10 driver (XGMAC)
+
+This binding supports the Synopsys Designware Ethernet 10G Ethernet MAC
+IP block. The IP supports multiple options for bus type, clocking and reset
+structure, and feature list. Consequently, a number of properties and list
+entries in properties are marked as optional, or only required in specific HW
+configurations.
+
+Required properties:
+- compatible: One of:
+  - "intel,socfpga-dwxgmac", "snps,dwxgmac-2.10"
+    Represents the IP core when integrated into the Agilex5 Intel (R) SoC FPGA.
+- reg: Address and length of the register set for the device
+- clocks: Phandle and clock specifiers for each entry in clock-names, in the
+  same order. See ../clock/clock-bindings.txt.
+- clock-names:
+  - stmmaceth
+
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- interrupts: Should contain the core's combined interrupt signal
+- phy-mode: See ethernet.txt file in the same directory
+- resets: Phandle and reset specifiers for each entry in reset-names, in the
+  same order. See ../reset/reset.txt.
+- reset-names: May contain any/all of the following depending on the IP
+  configuration, in any order:
+
+Optional properties:
+- dma-coherent: Present if dma operations are coherent
+- mac-address: See ethernet.txt in the same directory
+- local-mac-address: See ethernet.txt in the same directory
+- phy-handle: See ethernet.txt file in the same directory
+- mdio device tree subnode: When the XGMAC has a phy connected to its local
+    mdio, there must be device tree subnode with the following
+    required properties:
+    - compatible: Must be "snps,dwxgmac-mdio".
+    - #address-cells: Must be <1>.
+    - #size-cells: Must be <0>.
+
+    For each phy on the mdio bus, there must be a node with the following
+    fields:
+
+    - reg: phy id used to communicate to phy.
+    - device_type: Must be "ethernet-phy".
+    - fixed-mode device tree subnode: see fixed-link.txt in the same directory
+- altr,sysmgr-syscon: This propertise is a platform specific propertise to
+  control the system manager whether to set or reset the XGMAC. This is specific
+  to Intel SoC FPGA Family device.
+
+Examples:
+gmac0: ethernet@10810000 {
+	compatible = "intel,socfpga-dwxgmac", "snps,dwxgmac-2.10", "snps,dwxgmac";
+	reg = <0x10810000 0x3500>;
+	interrupts = <0 190 4>;
+	interrupt-names = "macirq";
+	mac-address = [00 00 00 00 00 00];
+	resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
+	reset-names = "stmmaceth", "stmmaceth-ocp";
+	tx-fifo-depth = <32768>;
+	rx-fifo-depth = <16384>;
+	snps,multicast-filter-bins = <256>;
+	iommus = <&smmu 0>;
+	altr,sysmgr-syscon = <&sysmgr 0x44 0>;
+	clocks = <&clkmgr AGILEX5_EMAC0_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
+};
-- 
2.26.2

