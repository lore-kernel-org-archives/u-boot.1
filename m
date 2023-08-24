Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC30C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC38886532;
	Thu, 24 Aug 2023 21:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FD786901; Thu, 24 Aug 2023 21:05:24 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE1F383F7B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qZFdu-008JVo-Nl; Thu, 24 Aug 2023 19:05:18 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] arm: imx: imx8m: add optee configuration to ft_system_setup
Date: Thu, 24 Aug 2023 12:05:17 -0700
Message-Id: <20230824190517.981411-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

If optee is detected configure it in the Linux device-tree:
 - add /firmware/optee node
 - add /reserved-memory nodes for optee_core and optee_shm

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
v2: add rb tag for Peng
---
 arch/arm/mach-imx/imx8m/soc.c | 78 ++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index d5254886bed9..5d92d9c982a4 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1245,6 +1245,82 @@ static int fixup_thermal_trips(void *blob, const char *name)
 	return 0;
 }
 
+#define OPTEE_SHM_SIZE 0x00400000
+static int ft_add_optee_node(void *fdt, struct bd_info *bd)
+{
+	struct fdt_memory carveout;
+	const char *path, *subpath;
+	phys_addr_t optee_start;
+	size_t optee_size;
+	int offs;
+	int ret;
+
+	/*
+	 * No TEE space allocated indicating no TEE running, so no
+	 * need to add optee node in dts
+	 */
+	if (!rom_pointer[1])
+		return 0;
+
+	optee_start = (phys_addr_t)rom_pointer[0];
+	optee_size = rom_pointer[1] - OPTEE_SHM_SIZE;
+
+	offs = fdt_increase_size(fdt, 512);
+	if (offs) {
+		printf("No Space for dtb\n");
+		return 1;
+	}
+
+	path = "/firmware";
+	offs = fdt_path_offset(fdt, path);
+	if (offs < 0) {
+		path = "/";
+		offs = fdt_path_offset(fdt, path);
+
+		if (offs < 0) {
+			printf("Could not find root node.\n");
+			return offs;
+		}
+
+		subpath = "firmware";
+		offs = fdt_add_subnode(fdt, offs, subpath);
+		if (offs < 0) {
+			printf("Could not create %s node.\n", subpath);
+			return offs;
+		}
+	}
+
+	subpath = "optee";
+	offs = fdt_add_subnode(fdt, offs, subpath);
+	if (offs < 0) {
+		printf("Could not create %s node.\n", subpath);
+		return offs;
+	}
+
+	fdt_setprop_string(fdt, offs, "compatible", "linaro,optee-tz");
+	fdt_setprop_string(fdt, offs, "method", "smc");
+
+	carveout.start = optee_start,
+	carveout.end = optee_start + optee_size - 1,
+	ret = fdtdec_add_reserved_memory(fdt, "optee_core", &carveout, NULL, 0,
+					 NULL, FDTDEC_RESERVED_MEMORY_NO_MAP);
+	if (ret < 0) {
+		printf("Could not create optee_core node.\n");
+		return ret;
+	}
+
+	carveout.start = optee_start + optee_size;
+	carveout.end = optee_start + optee_size + OPTEE_SHM_SIZE - 1;
+	ret = fdtdec_add_reserved_memory(fdt, "optee_shm", &carveout, NULL, 0,
+					 NULL, FDTDEC_RESERVED_MEMORY_NO_MAP);
+	if (ret < 0) {
+		printf("Could not create optee_shm node.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 #ifdef CONFIG_IMX8MQ
@@ -1394,7 +1470,7 @@ usb_modify_speed:
 	    fixup_thermal_trips(blob, "soc-thermal"))
 		printf("Failed to update soc-thermal trip(s)");
 
-	return 0;
+	return ft_add_optee_node(blob, bd);
 }
 #endif
 
-- 
2.25.1

