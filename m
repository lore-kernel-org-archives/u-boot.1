Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DF1106F30F
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5644C84027;
	Thu, 26 Mar 2026 10:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Dw+gaD+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA9880517; Thu, 26 Mar 2026 10:12:06 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2268483FD3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3Is3m1VhN99Mv9cFwOQb1v9zVzhZOuUDIGVoak92RCU=; b=Dw+gaD+RG08N4Fz2+W44sqgUdF
 ySsjfjPeCzwlCWEGJ4xJx0lRel3vOh2i1VVOPvyRXhB1sAy33zetYYpy+3ycTzx8eWbYlJkyIgWt6
 9rfXbHO3v+p64p8q4kctq3P9WxQSNOgRomBIEOAiTLF/oBBRDNubSDrjpHu9h9ufUJP8+JyPUhiFI
 wzXRZY+keGTCR1DNz+Y8oxMfHmD2UhbqHJRW0f2jeUGixAiWwoRyEk+ulk/u4Zo4MgUty6nzCQncG
 HGrT4xXzTpWO8FKRNjQoXMFkyuNc1M635F8K44oXAIrbxUfemeem3CmGC8pz1eXmh4N9dCzRIKeVK
 DHWlRROQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gkz-000O7N-0G; Thu, 26 Mar 2026 10:12:01 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gky-000DCP-2x; Thu, 26 Mar 2026 10:12:00 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 5/8] arch: arm: dts: tqma7x: add boot phase properties
Date: Thu, 26 Mar 2026 10:11:33 +0100
Message-Id: <20260326091136.709342-6-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
References: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Revert this commit once the upstream linux device trees are
synchronized.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 arch/arm/dts/imx7s-mba7-u-boot.dtsi  | 23 ++++++++++++++++++++++-
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx7s-tqma7-u-boot.dtsi

diff --git a/arch/arm/dts/imx7s-mba7-u-boot.dtsi b/arch/arm/dts/imx7s-mba7-u-boot.dtsi
index 2ed3f9c4769..bb560f4d85b 100644
--- a/arch/arm/dts/imx7s-mba7-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-mba7-u-boot.dtsi
@@ -7,7 +7,7 @@
  * Author: Steffen Doster
  */
 
-#include "imx7s-u-boot.dtsi"
+#include "imx7s-tqma7-u-boot.dtsi"
 
 / {
 	config {
@@ -21,7 +21,28 @@
 	};
 };
 
+&gpio4 {
+	/* Deassert BOOT_EN after boot to separate BOOT_CFG circuits from LCD signals */
+	boot-en-hog {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_LOW>;
+		output-low;
+	};
+};
+
 &wdog1 {
 	u-boot,noautostart;
 	timeout-sec = <60>;
 };
+
+&iomuxc {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart6 {
+	bootph-pre-ram;
+};
+
+&uart6 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
new file mode 100644
index 00000000000..2d1d614cd57
--- /dev/null
+++ b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Source for TQ-Systems TQMa7S module.
+ *
+ * Copyright (C) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany
+ * Author: Steffen Doster
+ */
+
+#include "imx7s-u-boot.dtsi"
+
+&soc {
+	bootph-pre-ram;
+};
+
+&aips1 {
+	bootph-pre-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+};
-- 
2.34.1

