Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F04E810A2
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 08:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A826086D93;
	Wed, 27 Sep 2023 10:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a5UPeP25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A2586D8D; Wed, 27 Sep 2023 10:21:15 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C69C386B95
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 10:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R8LCVR046013;
 Wed, 27 Sep 2023 03:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695802872;
 bh=j6RYPg99/hqUywiQr+FloMPyivUKNKL3pv1hjOkEdGg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=a5UPeP25v2Cdb6K083WcMGYx4/XbOrZZtozvgXhOzg0KKBloVg04dNq03PGZSqys9
 WKbJZbOcwVOEcRyh43MUFI1UzMJ2Ng3uZ5Q9Fod8KM0szpIYYeGh5Kbx7QHOsXO8ZZ
 XrD7urpFBiWAHDdYh5vTmhfV74ZYIO9DsG/VygLI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R8LCnQ017187
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 03:21:12 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 03:21:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 03:21:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R8LB1L089742;
 Wed, 27 Sep 2023 03:21:11 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 3/4] arm: dts: k3-am62-lp-sk-binman: Add binman support
Date: Wed, 27 Sep 2023 13:51:04 +0530
Message-ID: <20230927082105.3729470-4-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927082105.3729470-1-n-yadav@ti.com>
References: <20230927082105.3729470-1-n-yadav@ti.com>
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

Switch to binman for building bootloader images. Reuse
k3-am625-sk-binman and override the dtb names to that
of AM62 LP SK board.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 arch/arm/dts/k3-am62-lp-sk-binman.dtsi | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm/dts/k3-am62-lp-sk-binman.dtsi

diff --git a/arch/arm/dts/k3-am62-lp-sk-binman.dtsi b/arch/arm/dts/k3-am62-lp-sk-binman.dtsi
new file mode 100644
index 0000000000..6841bea118
--- /dev/null
+++ b/arch/arm/dts/k3-am62-lp-sk-binman.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am625-sk-binman.dtsi"
+
+#ifdef CONFIG_TARGET_AM625_A53_EVM
+
+#define SPL_AM62_LP_SK_DTB "spl/dts/k3-am62-lp-sk.dtb"
+#define AM62_LP_SK_DTB "u-boot.dtb"
+
+&spl_am625_sk_dtb_unsigned {
+	filename = SPL_AM62_LP_SK_DTB;
+};
+
+&am625_sk_dtb_unsigned {
+	filename = AM62_LP_SK_DTB;
+};
+
+&spl_am625_sk_dtb {
+	filename = SPL_AM62_LP_SK_DTB;
+};
+
+&am625_sk_dtb {
+	filename = AM62_LP_SK_DTB;
+};
+
+#endif
-- 
2.25.1

