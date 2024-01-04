Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9BAC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 198F38798E;
	Thu,  4 Jan 2024 13:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="T42DEhrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF298792C; Thu,  4 Jan 2024 10:14:07 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11A187961
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 10:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rLJne-0008U9-LZ; Thu, 04 Jan 2024 04:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=TNl9kUVZpLjsY++li8P3/Q5/93BdfSqjxzZLHGWxYnA=; b=T42DEhrUJ1hlYIzNIe2T
 SyAYaGQUYPGsHsfSYw6M9PODQwnIrVdMn69uZqLAzuljLS5m0Qu2pXSIKSfeTpddttvFR5vdgH39w
 rhjCk+EgtYAxG2gOvGV5vU1YLig8TRBiQgzmQh+GOrUg6U17SXxQsNLBJmfs7PmnUT7E538R1BOqT
 +v0tBBMmXW5raRpwmxH4KJQpWFkW1hHwXXA/337BygyzcppsETIt7ibbA3f8ljmSWZjw+uYTm06Am
 aHRE08puibb4uhDfDSXdKwGwtBueu9p3oFfqa+yNyHQcY8BN+3IdGcBAGY0vyWpV4vmzm7F5sbrW4
 bakh83vS34oe9A==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 2/3] mach-imx: Add i.MX93 binman support.
Date: Thu,  4 Jan 2024 10:13:49 +0100
Message-ID: <20240104091350.18252-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104091350.18252-1-othacehe@gnu.org>
References: <20240104091350.18252-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jan 2024 13:19:13 +0100
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

From: Mathieu Othacehe <m.othacehe@gmail.com>

Add dedicated Makefile targets for the i.MX93 and a new imx93-u-boot.dtsi
device-tree to create binman images.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 88 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/Makefile     | 22 ++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx93-u-boot.dtsi

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
new file mode 100644
index 00000000000..40e17bbc5ae
--- /dev/null
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Mathieu Othacehe <m.othacehe@gmail.com>
+ */
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&binman {
+	u-boot-spl-ddr {
+		align = <4>;
+		align-size = <4>;
+		filename = "u-boot-spl-ddr.bin";
+		pad-byte = <0xff>;
+
+		u-boot-spl {
+			align-end = <4>;
+			filename = "u-boot-spl.bin";
+		};
+
+		ddr-1d-imem-fw {
+			filename = "lpddr4_imem_1d_v202201.bin";
+			align-end = <4>;
+			type = "blob-ext";
+		};
+
+		ddr-1d-dmem-fw {
+			filename = "lpddr4_dmem_1d_v202201.bin";
+			align-end = <4>;
+			type = "blob-ext";
+		};
+
+		ddr-2d-imem-fw {
+			filename = "lpddr4_imem_2d_v202201.bin";
+			align-end = <4>;
+			type = "blob-ext";
+		};
+
+		ddr-2d-dmem-fw {
+			filename = "lpddr4_dmem_2d_v202201.bin";
+			align-end = <4>;
+			type = "blob-ext";
+		};
+	};
+
+	spl {
+		filename = "spl.bin";
+
+		mkimage {
+			args = "-n spl/u-boot-spl.cfgout -T imx8image -e 0x2049A000";
+
+			blob {
+				filename = "u-boot-spl-ddr.bin";
+			};
+		};
+	};
+
+	u-boot-container {
+		filename = "u-boot-container.bin";
+
+		mkimage {
+			args = "-n u-boot-container.cfgout -T imx8image -e 0x0";
+
+			blob {
+				filename = "u-boot.bin";
+			};
+		};
+	};
+
+	imx-boot {
+		filename = "flash.bin";
+		pad-byte = <0x00>;
+
+		spl: blob-ext@1 {
+			filename = "spl.bin";
+			offset = <0x0>;
+			align-size = <0x400>;
+			align = <0x400>;
+		};
+
+		uboot: blob-ext@2 {
+			filename = "u-boot-container.bin";
+		};
+	};
+};
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index a3b44c93e3d..b87f44193c3 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -129,6 +129,9 @@ DEPFILE_EXISTS := $(shell $(CPP) $(cpp_flags) -x c -o u-boot-dtb.cfgout $(srctre
 else ifeq ($(CONFIG_ARCH_IMX8M), y)
 IMAGE_TYPE := imx8mimage
 DEPFILE_EXISTS := 0
+else ifeq ($(CONFIG_ARCH_IMX9), y)
+IMAGE_TYPE := imx8image
+DEPFILE_EXISTS := 0
 else
 IMAGE_TYPE := imximage
 DEPFILE_EXISTS := 0
@@ -213,7 +216,24 @@ endif
 endif
 
 ifeq ($(CONFIG_ARCH_IMX9), y)
-SPL:
+
+SPL: spl/u-boot-spl.bin spl/u-boot-spl.cfgout u-boot-container.cfgout FORCE
+
+MKIMAGEFLAGS_flash.bin = -n spl/u-boot-spl.cfgout -T $(IMAGE_TYPE) -e $(CONFIG_SPL_TEXT_BASE)
+flash.bin: MKIMAGEOUTPUT = flash.log
+
+spl/u-boot-spl.cfgout: $(IMX_CONFIG) FORCE
+	$(Q)mkdir -p $(dir $@)
+	$(call if_changed_dep,cpp_cfg)
+
+spl/u-boot-spl-ddr.bin: spl/u-boot-spl.bin spl/u-boot-spl.cfgout FORCE
+
+u-boot-container.cfgout: $(IMX_CONTAINER_CFG) FORCE
+	$(Q)mkdir -p $(dir $@)
+	$(call if_changed_dep,cpp_cfg)
+
+flash.bin: spl/u-boot-spl-ddr.bin container.cfgout FORCE
+	$(call if_changed,mkimage)
 endif
 
 else
-- 
2.25.1

