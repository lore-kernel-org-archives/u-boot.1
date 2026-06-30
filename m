Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9ADC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 16:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFA48498C;
	Tue, 30 Jun 2026 18:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="dXw5FK5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95280849AC; Tue, 30 Jun 2026 18:10:00 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB188494B
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 18:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4CD5B11765F; Tue, 30 Jun 2026 18:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782835795; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=TRy6PIMfxPfBkhXnRTprmYZ5HMvrMKe5TF2vyyypOkI=;
 b=dXw5FK5zKSqjd4zRnY3LWPLvI8PUmTpM0m4muXUnmo6erJpjio1hOXA+Hj5328g5DnbhhV
 zNH6OYE4n3wzXsGssSGnlp/onYkrQL1+8Y5zpUiT7AsS7cThF7yC8XGENZSJGS/AwMKJSi
 Moc4trq5sjBWJ8Uxr4tyuHgdeQX7/Wsf61oQFclQlznvz9o0D8Qy86MzvvChxa8pBjIBSA
 j4S7Eg/JqMWc9gPwoWmP2wHVDD5m30VV53x5yi2oTBW6llU1svDPEM/g04aoXqOKsLAzkY
 BJNQHqnrJtM7ykBXaJfeBrNI5J6AqtuM3gUGjuSVnesKFv9543zI5wMQENpBsw==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Date: Tue, 30 Jun 2026 18:08:56 +0200
Message-ID: <20260630160951.122230-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Since b57ed147939c ("dts: imx8m{m,n,p,q}: Make optee packaging optional")
the TEE node is always present in U-Boot proper fitImage, even if the
CONFIG_OPTEE is disabled because the u-boot.itb should not contain any
tee.bin. This is wasteful, and produces the following warning which is
also confusing to users:

"
Image 'image' is missing optional external blobs but is still functional: tee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
"

Reinstate the CONFIG_OPTEE ifdeffery to mitigate the problem, but retain the
binman "optional" keyword at tee.bin .

Before:
"
$ mkimage -l u-boot.itb
FIT description: Configuration to load ATF before U-Boot
Created:         Tue Jun 30 17:23:54 2026
 Image 0 (uboot)
...
 Image 2 (tee) <------------------------------ bogus empty image entry
  Description:  OP-TEE                                 |
  Created:      Tue Jun 30 17:23:54 2026               |
  Type:         Trusted Execution Environment Image    |
  Compression:  uncompressed                           |
  Data Size:    0 Bytes = 0.00 KiB = 0.00 MiB <--------'
 Image 3 (fdt-1)
...
"

After:
"
$ mkimage -l u-boot.itb
FIT description: Configuration to load ATF before U-Boot
Created:         Tue Jun 30 17:58:15 2026
 Image 0 (uboot)
...
 Image 1 (atf)
...
 Image 2 (fdt-1)
...
"

Fixes: b57ed147939c ("dts: imx8m{m,n,p,q}: Make optee packaging optional")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yannic Moog <y.moog@phytec.de>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 6 ++++++
 arch/arm/dts/imx8mn-u-boot.dtsi | 6 ++++++
 arch/arm/dts/imx8mp-u-boot.dtsi | 6 ++++++
 arch/arm/dts/imx8mq-u-boot.dtsi | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index ab135fc8a47..56ab70e54ea 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -165,6 +165,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -179,6 +180,7 @@
 							optional;
 						};
 					};
+#endif
 
 					binman_fip: fip {
 						arch = "arm64";
@@ -208,7 +210,11 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
+#else
+						loadables = "atf";
+#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 8993605af3c..e4918bf5975 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -241,6 +241,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -255,6 +256,7 @@
 							optional;
 						};
 					};
+#endif
 
 					binman_fip: fip {
 						arch = "arm64";
@@ -284,7 +286,11 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
+#else
+						loadables = "atf";
+#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index d9d220c70db..58b6863f003 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -189,6 +189,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -203,6 +204,7 @@
 							optional;
 						};
 					};
+#endif
 
 					@fdt-SEQ {
 						description = "NAME";
@@ -223,7 +225,11 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
+#else
+						loadables = "atf";
+#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index ed2c704f2e5..2f9b4a504c3 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -173,6 +173,7 @@
 				};
 #endif
 
+#ifdef CONFIG_OPTEE
 				tee: tee {
 					description = "OP-TEE";
 					type = "tee";
@@ -187,6 +188,7 @@
 						optional;
 					};
 				};
+#endif
 
 				fdt {
 					compression = "none";
@@ -208,7 +210,11 @@
 					fdt = "fdt";
 					firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
 					loadables = "atf", "tee";
+#else
+					loadables = "atf";
+#endif
 #endif
 				};
 			};
-- 
2.53.0

