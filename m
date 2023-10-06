Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CE9E81DE3
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 11:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8A186EDE;
	Fri,  6 Oct 2023 13:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68EC986EDB; Fri,  6 Oct 2023 13:26:31 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B7E86EBC
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 13:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 396BQGSj058236;
 Fri, 6 Oct 2023 19:26:16 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Fri, 6 Oct 2023 19:26:12 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH RESEND 2/7] riscv: dts: add binman_linux.dtsi for opensbi os
 boot mode
Date: Fri, 6 Oct 2023 19:23:46 +0800
Message-ID: <20231006112351.2275090-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006112351.2275090-1-randolph@andestech.com>
References: <20231006112351.2275090-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 396BQGSj058236
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

The binman_linux.dtsi is a fork of binman.dtsi, just change the first
section image from the "u-boot" to "linux". Note that the filename
is also changed. In binman.dtsi, the filename of u-boot section filename
is called "u-boot-nodtb.bin". In binman_linux.dtsi, the filename should
be called "Image", which is located in linux/arch/riscv/boot.

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/dts/binman_linux.dtsi | 79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 arch/riscv/dts/binman_linux.dtsi

diff --git a/arch/riscv/dts/binman_linux.dtsi b/arch/riscv/dts/binman_linux.dtsi
new file mode 100644
index 0000000000..334d64bc40
--- /dev/null
+++ b/arch/riscv/dts/binman_linux.dtsi
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <config.h>
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&binman {
+	itb {
+		filename = "linux.itb";
+
+		fit {
+			description = "Configuration to load OpenSBI before Linux";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				linux {
+					description = "Linux";
+					type = "standalone";
+					os = "Linux";
+					arch = "riscv";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+
+					linux_blob: blob-ext {
+						filename = "Image";
+					};
+				};
+
+				opensbi {
+					description = "OpenSBI fw_dynamic Firmware";
+					type = "firmware";
+					os = "opensbi";
+					arch = "riscv";
+					compression = "none";
+					load = <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+					entry = <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+
+					opensbi_blob: opensbi {
+						filename = "fw_dynamic.bin";
+						missing-msg = "opensbi";
+					};
+				};
+
+#ifndef CONFIG_OF_BOARD
+				@fdt-SEQ {
+					description = "NAME";
+					type = "flat_dt";
+					compression = "none";
+				};
+#endif
+			};
+
+			configurations {
+				default = "conf-1";
+
+#ifndef CONFIG_OF_BOARD
+				@conf-SEQ {
+#else
+				conf-1 {
+#endif
+					description = "NAME";
+					firmware = "opensbi";
+					loadables = "linux";
+#ifndef CONFIG_OF_BOARD
+					fdt = "fdt-SEQ";
+#endif
+				};
+			};
+		};
+	};
+};
-- 
2.34.1

