Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D33106F311
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA3683FEC;
	Thu, 26 Mar 2026 10:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="btsNmP0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DFC83E76; Thu, 26 Mar 2026 10:12:06 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB3483F00
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=hy4AVE/nbgrJDBCb9Jwxiv2MjCMqZPsSF1aIcQWtWSI=; b=btsNmP0k3Kr3lfIM/QBmdzPgAy
 pDA56ZIYPcsPyN4czkG3LQYgW09ij0YntvaMtUf8o8gjTvTF/Qp2gPsxaDhsQQ6h6BHjxwxOPj1Ma
 jzqqG+iuGkHbOQ7C4v43/Mm5BKy8MKn8tvjsGHN8t0cdTQr1wciptY2uIWo0UVK6XtrSsVyaBZOZO
 oB8KrqM8fMog0BXWQLWtmenYkMxtZwfYLVq3NCgersvkjXaMRzaYgSJJqTaFl2Advxce8yPd1POCd
 0KYPpWtSmcL04dAydoNBQIa5ZbN29AiY+PSIak5fNu/G/RmgjHmsTd5UPlIAerI8Rv9NumqrnZbiF
 7+sw5j3g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gky-000O7D-2K; Thu, 26 Mar 2026 10:12:00 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gky-000DCP-1i; Thu, 26 Mar 2026 10:12:00 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 4/8] arch: arm: dts: tqma7x: add u-boot device tree
 fragments
Date: Thu, 26 Mar 2026 10:11:32 +0100
Message-Id: <20260326091136.709342-5-Alexander.Feilke@ew.tq-group.com>
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

Add u-boot specific device tree properties.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

