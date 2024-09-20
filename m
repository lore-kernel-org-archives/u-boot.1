Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A91CF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E412893C0;
	Fri, 20 Sep 2024 09:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AgVTg5W0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA78893BF; Fri, 20 Sep 2024 09:03:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDDF893BD
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815835; x=1758351835;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2wReknbTQ353XTrv1k2f19xn6aGsE+oRhXxCEb/DpiI=;
 b=AgVTg5W04CFGAEPnBubA6vv6j9pB4Ch59TIpd642Le/LcBlqvttZ7p0L
 K7tOyz/ROcIe5QkeI4nS5hsmSN4S7yG2KFfgJl1ACMqLIXUjlSuItQgr4
 ZBWKHyIsAR5wRKpumfhqaIdsZRQ8p9635u2FRR0J+mA3vSFbQNHdeEyuG
 SSlvHowwOtVR9l5oTpuVXgvSy9JvDuI1KFFzLoDzOzTvMT4xDb5Oy41d1
 ES+gFR1PxJ5KvqkcOOktrdROWGFhrrlDL8dOORkBo4Vfyuuk5klEq/vXb
 ob2/C68xSc4e5Mnw1KdEx4Z9N/bDNNH3qM/P0H+qlZZt4gr8a5B6wHpLb A==;
X-CSE-ConnectionGUID: b8ad9jwlRAaMDVfQvhp67A==
X-CSE-MsgGUID: iRdY6oxmQ+23T7fY2zpd5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961121"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961121"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:55 -0700
X-CSE-ConnectionGUID: 54wx0oVpTgq8Bo1fXW/z5A==
X-CSE-MsgGUID: PqO9i69eS0KF53wON7fqTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235295"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:53 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 19/20] arm: socfpga: soc64: Add support for
 board_boot_order()
Date: Fri, 20 Sep 2024 15:02:41 +0800
Message-Id: <20240920070242.20884-20-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
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

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/spl_soc64.c | 103 ++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_soc64.c
index 3bfe4bb9dd3..9bfa15e9ded 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -15,6 +15,109 @@ u32 spl_boot_device(void)
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

