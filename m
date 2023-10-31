Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119ECC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8DE687C8F;
	Tue, 31 Oct 2023 14:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nBQiim3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715D287CAE; Tue, 31 Oct 2023 14:28:21 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069B887B5D
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSGuk015971;
 Tue, 31 Oct 2023 08:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698758896;
 bh=6Cp84QzYlpOupOc4eeWK/2uyj4hi+KoCySA+Oi8Ji4s=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nBQiim3v+gYL/L5h2WeNVVwyiF6NteGpJDN/UK2LsqPKFGxbpoET5lnbTH8LAnf/3
 xMCwZ/BvaS2UXXlDYdvXGZcVC7cqgSgd+uvBUKY3adGdYnl5jNFks00DVs8IWAeS5I
 wUmm+srTVc83JDBoHZ5WtZBWGwTqutQ/JS90AKLs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDSGQm111292
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:28:16 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:28:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:28:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSF9w003477;
 Tue, 31 Oct 2023 08:28:16 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 4/6] arm: dts: Add support for AM62x SIP SKEVM at R5 SPL
Date: Tue, 31 Oct 2023 18:58:07 +0530
Message-ID: <20231031132809.1524341-5-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031132809.1524341-1-n-yadav@ti.com>
References: <20231031132809.1524341-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The AM62x SIP SKEVM board has different type of DDR than
AM62x SK board. This requires different r5 SPL device tree.
These dt changes add support for AM62x SIP SKEVM at R5 SPL.

SK-AM62-SIP: https://www.ti.com/tool/download/SPRR482

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 arch/arm/dts/Makefile             |  1 +
 arch/arm/dts/k3-am62sip-r5-sk.dts | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 arch/arm/dts/k3-am62sip-r5-sk.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 72ea57885f..e611dc1b3c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1339,6 +1339,7 @@ dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
 			      k3-am625-r5-sk.dtb \
 			      k3-am62-lp-sk.dtb \
 			      k3-am62-r5-lp-sk.dtb \
+			      k3-am62sip-r5-sk.dtb \
 			      k3-am625-beagleplay.dtb \
 			      k3-am625-r5-beagleplay.dtb \
 			      k3-am625-verdin-wifi-dev.dtb \
diff --git a/arch/arm/dts/k3-am62sip-r5-sk.dts b/arch/arm/dts/k3-am62sip-r5-sk.dts
new file mode 100644
index 0000000000..c95d80852a
--- /dev/null
+++ b/arch/arm/dts/k3-am62sip-r5-sk.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM62x SIP SKEVM dts file for R5 SPL
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am625-sk.dts"
+#include "k3-am62x-sip-ddr-lp4-50-800.dtsi"
+#include "k3-am62-ddr.dtsi"
+
+#include "k3-am625-sk-u-boot.dtsi"
+#include "k3-am62x-r5-sk-common.dtsi"
+#include "k3-am625-sk-binman.dtsi"
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		/* 512M RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x20000000>;
+
+		bootph-pre-ram;
+	};
+};
-- 
2.25.1

