Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79504C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438D980FDE;
	Tue, 18 Feb 2025 09:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="leRSJdY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4309C80FDE; Tue, 18 Feb 2025 09:36:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5E6809A4
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867780; x=1771403780;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ttHnfjeBfVNh3l203ppLB5OWW5d4YH0eem66z8BiNxo=;
 b=leRSJdY3RXQxnomKLIOwg+lG83tpIASJ5xVxWCN3ZmSMbYq4hEY3YJtj
 cC6ldf3s5d01OO3PdaHhkBFL1OHdVuF6FDNpKG4OvluImoqAdiRfFgGMu
 Lo+8ILJ/4XbRV5+2D26+nAJS+NIU7HOR6uqCoGh85jPaHVT8UDdh/C8B6
 Qj/yo4J30MWtBxGNA9IpZ0R0SNJ9J+vVrGlkq/NoR8+JWdOLui1TxKRAl
 e7sKCxAQp0ZD1tswjjNuSr3hxOdqB1zKPd4cOG7dWyqf7BvuCFbLbGf8b
 VJFvbrlWTwATftE0Zt+VYiRJZ4K4Tc2xiYQwSDTkhsQnNgMagAEmtMMWn g==;
X-CSE-ConnectionGUID: UoAN5k0DSROA3YhXGrZxMw==
X-CSE-MsgGUID: EzOiEXX2TKmypUQOk1cWag==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028229"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028229"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:19 -0800
X-CSE-ConnectionGUID: Mw6agMn9Tqa2K60j/OT30g==
X-CSE-MsgGUID: WW3u5hONSvSR0e8N/W1Ulw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237846"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:36:17 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 24/26] arm: socfpga: soc64: Add support for
 board_boot_order()
Date: Tue, 18 Feb 2025 16:35:09 +0800
Message-Id: <20250218083511.29249-25-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Add board_boot_order() to retrieve the list of boot devices from
spl-boot-order property in device tree. This board_boot_order()
would be used for all Intel SOC64 devices.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/spl_soc64.c | 103 ++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_soc64.c
index df89125cb29..651d9fc9cb8 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -16,6 +16,109 @@ u32 spl_boot_device(void)
 	return BOOT_DEVICE_MMC1;
 }
 
+/* This function is to map specified node onto SPL boot devices */
+static int spl_node_to_boot_device(int node)
+{
+	const void *blob = gd->fdt_blob;
+	struct udevice *parent;
+	const char *prop;
+
+	if (!uclass_get_device_by_of_offset(UCLASS_MMC, node, &parent))
+		return BOOT_DEVICE_MMC1;
+	else if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
+		return BOOT_DEVICE_SPI;
+	else if (!uclass_get_device_by_of_offset(UCLASS_MTD, node, &parent))
+		return BOOT_DEVICE_NAND;
+
+	prop = fdt_getprop(blob, node, "device_type", NULL);
+	if (prop) {
+		if (!strcmp(prop, "memory"))
+			return BOOT_DEVICE_RAM;
+
+		printf("%s: unknown device_type %s\n", __func__, prop);
+	}
+
+	return -ENODEV;
+}
+
+static void default_spl_boot_list(u32 *spl_boot_list, int length)
+{
+	spl_boot_list[0] = spl_boot_device();
+
+	if (length > 1)
+		spl_boot_list[1] = BOOT_DEVICE_SPI;
+
+	if (length > 2)
+		spl_boot_list[2] = BOOT_DEVICE_NAND;
+}
+
+void board_boot_order(u32 *spl_boot_list)
+{
+	int idx = 0;
+	const void *blob = gd->fdt_blob;
+	int chosen_node = fdt_path_offset(blob, "/chosen");
+	const char *conf;
+	int elem;
+	int boot_device;
+	int node;
+	int length;
+
+	/* expect valid initialized spl_boot_list */
+	if (!spl_boot_list)
+		return;
+
+	length = 1;
+	while (spl_boot_list[length] == spl_boot_list[length - 1])
+		length++;
+
+	debug("%s: chosen_node is %d\n", __func__, chosen_node);
+	if (chosen_node < 0) {
+		printf("%s: /chosen not found, using default\n", __func__);
+		default_spl_boot_list(spl_boot_list, length);
+		return;
+	}
+
+	for (elem = 0;
+	    (conf = fdt_stringlist_get(blob, chosen_node,
+			"u-boot,spl-boot-order", elem, NULL));
+	    elem++) {
+		if (idx >= length) {
+			printf("%s: limit %d to spl_boot_list exceeded\n", __func__,
+			       length);
+			break;
+		}
+
+		/* Resolve conf item as a path in device tree */
+		node = fdt_path_offset(blob, conf);
+		if (node < 0) {
+			debug("%s: could not find %s in FDT\n", __func__, conf);
+			continue;
+		}
+
+		/* Try to map spl node back onto SPL boot devices */
+		boot_device = spl_node_to_boot_device(node);
+		if (boot_device < 0) {
+			debug("%s: could not map node @%x to a boot-device\n",
+			      __func__, node);
+			continue;
+		}
+
+		spl_boot_list[idx] = boot_device;
+		debug("%s: spl_boot_list[%d] = %u\n", __func__, idx,
+		      spl_boot_list[idx]);
+		idx++;
+	}
+
+	if (idx == 0) {
+		if (!conf && !elem) {
+			printf("%s: spl-boot-order invalid, using default\n", __func__);
+			default_spl_boot_list(spl_boot_list, length);
+		} else {
+			printf("%s: no valid element spl-boot-order list\n", __func__);
+		}
+	}
+}
+
 #if IS_ENABLED(CONFIG_SPL_MMC)
 u32 spl_boot_mode(const u32 boot_device)
 {
-- 
2.25.1

