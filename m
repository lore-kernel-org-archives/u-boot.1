Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56613CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A12386E07;
	Thu, 12 Oct 2023 08:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0CD86CDD; Thu, 12 Oct 2023 08:38:12 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22C786E07
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39C6c1TE019934;
 Thu, 12 Oct 2023 14:38:01 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 12 Oct 2023 14:37:57 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH V2 3/7] riscv: dts: binman: add condition for opensbi os boot
Date: Thu, 12 Oct 2023 14:35:05 +0800
Message-ID: <20231012063509.2963258-4-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012063509.2963258-1-randolph@andestech.com>
References: <20231012063509.2963258-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39C6c1TE019934
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

Add condition for OpenSBI OS boot mode, by default it is not enabled.
By default, binman creates the output file u-boot.itb.
If SPL_OPENSBI_OS_BOOT is enabled, linux.itb will be created
after compilation instead of the default u-boot.itb.

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/dts/binman.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 156cb00971..1a55097d71 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -13,7 +13,12 @@
 
 &binman {
 	itb {
+
+#ifndef CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
 		filename = "u-boot.itb";
+#else
+		filename = "linux.itb";
+#endif
 
 		fit {
 			description = "Configuration to load OpenSBI before U-Boot";
@@ -21,6 +26,7 @@
 			fit,fdt-list = "of-list";
 
 			images {
+#ifndef CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
 				uboot {
 					description = "U-Boot";
 					type = "standalone";
@@ -33,6 +39,20 @@
 						filename = "u-boot-nodtb.bin";
 					};
 				};
+#else
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
+#endif
 
 				opensbi {
 					description = "OpenSBI fw_dynamic Firmware";
@@ -68,7 +88,11 @@
 #endif
 					description = "NAME";
 					firmware = "opensbi";
+#ifndef CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
 					loadables = "uboot";
+#else
+					loadables = "linux";
+#endif
 #ifndef CONFIG_OF_BOARD
 					fdt = "fdt-SEQ";
 #endif
-- 
2.34.1

