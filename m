Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3E5C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D4C82AA7;
	Tue, 13 May 2025 11:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="NOC/j1go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDAC182AA4; Tue, 13 May 2025 11:07:40 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197718294C
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CF56325D16;
 Tue, 13 May 2025 11:07:38 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxb3smpJq-Rw; Tue, 13 May 2025 11:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747127258; bh=L33eXeAl+SPF+3hTQQTYwkxMnAKG9W99NlQ7KMrKGnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NOC/j1gowvKMG9d4z4S0uSZ+bWil5cSL3P0ICZQZFMAno+uN/Z/ckGsi7MArHMgW4
 2zc7H8VXiMgQzDkjr/rYZ5mkYCGTstqYCdxkydfDlRgd2l9ZoEwQRQD2hFIOAY2j2t
 crktLbvOy7KrRbybyK8Qf45lWQ+BfKH5H0xgLEhdh1dzOWI49G05gOv06WlUCF9x0Q
 YngP5VuOCwCxo0NTp0kswsZI5ypOeBDUGfgPf0h6slUoDhZdMOvYQCzjZXhLqN99QI
 s9dH5mWuH8GPH+5jV1MbvwUPFxUpDt0ekPkOaassP0zVq2ZNt5WsHua2tiSjkD/y9n
 Ly20M77Ui+Ahw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 08/10] riscv: dts: th1520: Add binman configuration
Date: Tue, 13 May 2025 09:05:01 +0000
Message-ID: <20250513090503.46670-9-ziyao@disroot.org>
In-Reply-To: <20250513090503.46670-1-ziyao@disroot.org>
References: <20250513090503.46670-1-ziyao@disroot.org>
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

Add binman configuration for TH1520 SoC, whose BROM loads the image
combined into SRAM and directly jumps to it. The configuration creates
u-boot-with-spl.bin where the SPL code locates at the start and the DDR
firmware is shipped.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/dts/thead-th1520-binman.dtsi | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 arch/riscv/dts/thead-th1520-binman.dtsi

diff --git a/arch/riscv/dts/thead-th1520-binman.dtsi b/arch/riscv/dts/thead-th1520-binman.dtsi
new file mode 100644
index 00000000000..f060639e1c6
--- /dev/null
+++ b/arch/riscv/dts/thead-th1520-binman.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+#include <config.h>
+
+/ {
+	binman: binman {
+	};
+};
+
+&binman {
+	filename = "u-boot-with-spl.bin";
+
+	u-boot-spl {
+	};
+
+	ddr-fw {
+		filename = "th1520-ddr-firmware.bin";
+		type = "blob-ext";
+	};
+
+	fit {
+		offset = <CONFIG_SPL_PAD_TO>;
+
+		description = "Configuration to load M-mode U-Boot";
+
+		#address-cells = <2>;
+		fit,fdt-list = "of-list";
+
+		images {
+			uboot {
+				description = "U-Boot";
+				type = "standalone";
+				os = "U-boot";
+				arch = "riscv";
+				compression = "none";
+				load = /bits/ 64 <CONFIG_TEXT_BASE>;
+
+				uboot_blob: u-boot {
+				};
+			};
+		};
+
+		configurations {
+			default = "conf-th1520-lichee-pi-4a";
+
+			conf-th1520-lichee-pi-4a {
+				description = "th1520-lichee-pi-4a";
+				loadables = "uboot";
+			};
+		};
+	};
+};
-- 
2.49.0

