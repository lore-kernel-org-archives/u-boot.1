Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED002E81DE0
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 11:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A016386BDF;
	Fri,  6 Oct 2023 13:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7634F86ED6; Fri,  6 Oct 2023 13:26:20 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B69E86844
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 13:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 396BQBk0058216;
 Fri, 6 Oct 2023 19:26:11 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Fri, 6 Oct 2023 19:26:07 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH RESEND 1/7] riscv: dts: Introduce SPL_LOAD_FIT_CONFIG symbol
Date: Fri, 6 Oct 2023 19:23:45 +0800
Message-ID: <20231006112351.2275090-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006112351.2275090-1-randolph@andestech.com>
References: <20231006112351.2275090-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 396BQBk0058216
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

Introduce common Kconfig symbol for riscv architecture
This symbol SPL_LOAD_FIT_CONFIG for binman itb layout selection
Default is using binman.dtsi

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/Kconfig               | 7 +++++++
 arch/riscv/dts/ae350-u-boot.dtsi | 1 +
 arch/riscv/dts/ae350_32.dts      | 1 -
 arch/riscv/dts/ae350_64.dts      | 1 -
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index aff1f33665..ec1cfcaaa7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -422,4 +422,11 @@ config TPL_USE_ARCH_MEMSET
 
 endmenu
 
+config SPL_LOAD_FIT_CONFIG
+	string "Default FIT configuration for SPL"
+	default "binman.dtsi"
+	depends on SPL_LOAD_FIT
+	help
+	  Specify corresponding FIT configuration for SPL modes.
+
 endmenu
diff --git a/arch/riscv/dts/ae350-u-boot.dtsi b/arch/riscv/dts/ae350-u-boot.dtsi
index aef9159b7a..ff5725501f 100644
--- a/arch/riscv/dts/ae350-u-boot.dtsi
+++ b/arch/riscv/dts/ae350-u-boot.dtsi
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
+#include CONFIG_SPL_LOAD_FIT_CONFIG
 
 / {
 	cpus {
diff --git a/arch/riscv/dts/ae350_32.dts b/arch/riscv/dts/ae350_32.dts
index 61af6d5465..2caabad888 100644
--- a/arch/riscv/dts/ae350_32.dts
+++ b/arch/riscv/dts/ae350_32.dts
@@ -2,7 +2,6 @@
 
 /dts-v1/;
 
-#include "binman.dtsi"
 #include "ae350-u-boot.dtsi"
 
 / {
diff --git a/arch/riscv/dts/ae350_64.dts b/arch/riscv/dts/ae350_64.dts
index 8c7db29b4f..9d5f6c743c 100644
--- a/arch/riscv/dts/ae350_64.dts
+++ b/arch/riscv/dts/ae350_64.dts
@@ -2,7 +2,6 @@
 
 /dts-v1/;
 
-#include "binman.dtsi"
 #include "ae350-u-boot.dtsi"
 
 / {
-- 
2.34.1

