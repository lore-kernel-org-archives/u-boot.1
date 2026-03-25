Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D86FEA83E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1AE83FD3;
	Wed, 25 Mar 2026 10:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ii2qHYry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C36FE83A41; Wed, 25 Mar 2026 10:58:18 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E8E68352B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3gqTM7J59MsEiSzP8+UDQ5IFcC1CvW+D5ymRepUZAV4=; b=ii2qHYryQprGfmhIUE1H0je3mz
 mCk+tEGSRpyirw4I58rdtjGN/1laZN3dMqo91E2pcnYlh2B9brjlnA1PmR4jSP9UAkbxRF8a6lRA4
 7qAOKaN+t9KpxDBoDeLDLgp+94JN4d5LgtmRWn724wuvo3SudPdmgz7AJxUZVVxVvRXM3uA+rsOus
 tpCL1aGoZl0Df/mmb17h1TYd8LY+mji9YqjflFO3GwUtczg1X2KnI+uzHBPjUgqqkqdwHL7KF7GKA
 gpfRLA4u/sP2rihYi01LA0+bYuUCScRQRi97vlUGXxrK2RpuvBUFSMvjVmXLs62zlsBju4zMC1fIU
 8mlLiwWA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5L09-0009m7-0B; Wed, 25 Mar 2026 10:58:13 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5L08-000HPv-2c; Wed, 25 Mar 2026 10:58:12 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 4/8] arch: arm: dts: tqma7x: add u-boot device tree
 fragments
Date: Wed, 25 Mar 2026 10:57:57 +0100
Message-Id: <20260325095801.47706-5-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
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

Add u-boot specific device tree properties.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 arch/arm/dts/imx7d-mba7-u-boot.dtsi | 10 ++++++++++
 arch/arm/dts/imx7s-mba7-u-boot.dtsi | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm/dts/imx7d-mba7-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx7s-mba7-u-boot.dtsi

diff --git a/arch/arm/dts/imx7d-mba7-u-boot.dtsi b/arch/arm/dts/imx7d-mba7-u-boot.dtsi
new file mode 100644
index 00000000000..3ccc95a7ac6
--- /dev/null
+++ b/arch/arm/dts/imx7d-mba7-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Source for TQ-Systems TQMa7D board on MBa7x carrier board.
+ *
+ * Copyright (C) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany
+ * Author: Steffen Doster
+ */
+
+#include "imx7s-mba7-u-boot.dtsi"
diff --git a/arch/arm/dts/imx7s-mba7-u-boot.dtsi b/arch/arm/dts/imx7s-mba7-u-boot.dtsi
new file mode 100644
index 00000000000..2ed3f9c4769
--- /dev/null
+++ b/arch/arm/dts/imx7s-mba7-u-boot.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Source for TQ-Systems TQMa7S board on MBa7x carrier board.
+ *
+ * Copyright (C) 2025-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany
+ * Author: Steffen Doster
+ */
+
+#include "imx7s-u-boot.dtsi"
+
+/ {
+	config {
+		u-boot,mmc-env-offset = <0x100000>;
+		u-boot,mmc-env-offset-redundant = <0x110000>;
+	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+	};
+};
+
+&wdog1 {
+	u-boot,noautostart;
+	timeout-sec = <60>;
+};
-- 
2.34.1

