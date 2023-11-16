Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F406C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 10:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0856287477;
	Thu, 16 Nov 2023 11:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E3A871D0; Thu, 16 Nov 2023 11:18:25 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 491B487438
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 11:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3AGAI1D4033286;
 Thu, 16 Nov 2023 18:18:01 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 16 Nov 2023
 18:17:58 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>
Subject: [PATCH V2] riscv: binman: fix the load field format
Date: Thu, 16 Nov 2023 18:17:50 +0800
Message-ID: <20231116101750.2624046-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3AGAI1D4033286
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

Using /bits/64 prefix for 64bits address

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/dts/binman.dtsi | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 6b4eb8dc7b..777b1309d0 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -5,9 +5,6 @@
 
 #include <config.h>
 
-#define U64_TO_U32_H(addr)		(((addr) >> 32) & 0xffffffff)
-#define U64_TO_U32_L(addr)		((addr) & 0xffffffff)
-
 / {
 	binman: binman {
 		multiple-images;
@@ -36,8 +33,7 @@
 					os = "U-Boot";
 					arch = "riscv";
 					compression = "none";
-					load = <U64_TO_U32_H(CONFIG_TEXT_BASE)
-						U64_TO_U32_L(CONFIG_TEXT_BASE)>;
+					load = /bits/64 <CONFIG_TEXT_BASE>;
 
 					uboot_blob: blob-ext {
 						filename = "u-boot-nodtb.bin";
@@ -50,7 +46,7 @@
 					os = "Linux";
 					arch = "riscv";
 					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
+					load = /bits/64 <CONFIG_TEXT_BASE>;
 
 					linux_blob: blob-ext {
 						filename = "Image";
@@ -64,10 +60,8 @@
 					os = "opensbi";
 					arch = "riscv";
 					compression = "none";
-					load = <U64_TO_U32_H(CONFIG_SPL_OPENSBI_LOAD_ADDR)
-						U64_TO_U32_L(CONFIG_SPL_OPENSBI_LOAD_ADDR)>;
-					entry = <U64_TO_U32_H(CONFIG_SPL_OPENSBI_LOAD_ADDR)
-						U64_TO_U32_L(CONFIG_SPL_OPENSBI_LOAD_ADDR)>;
+					load = /bits/64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+					entry = /bits/64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
 
 					opensbi_blob: opensbi {
 						filename = "fw_dynamic.bin";
-- 
2.34.1

