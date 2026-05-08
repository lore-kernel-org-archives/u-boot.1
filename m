Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C1ECD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6EFF84BBD;
	Fri,  8 May 2026 13:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Mu3iNq1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F7684C83; Fri,  8 May 2026 13:53:29 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F8E84C19
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=p6xVJ51bbhDNKfLfUGn1+5DwzQVFc1W0X0WdzjpHooY=; b=Mu3iNq1yzYkilw7pMR9SKQochz
 5MVmfd2+ATF3MC95RmOK4udeT2qsnc4i6qm8QXirErXFHelzk+Ro7Hs+kdzwfQeibC0QQAwv5UjRl
 hNVKuUTxTPt9kEXAz0J/NP0ki94i6OCeGxEHtNMOObGrdJcVWqxIIEZqK+SV3ZLrEne5DirsCI+C5
 v1Wlb9X1upQYMCFKK01ZUMl+6R/KGwnkbivkoxGuhYLkhdo4P1AznFCLqQoox+3c0/wU+ARtYeQ5n
 JXm/4+BNSj0mrmHYY3byPP3682eDCT6XITVJaaldtRMPclGS9Cnbf5YZi2EPiAy1+p77hlhXXEfUU
 Du0fHNWQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJln-000DVl-0D; Fri, 08 May 2026 13:53:27 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJlm-000PER-26; Fri, 08 May 2026 13:53:26 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 2/5] ARM: dts: add U-Boot additions for TQMa6UL[L]x[L]
Date: Fri,  8 May 2026 13:53:07 +0200
Message-ID: <20260508115315.252623-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
References: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
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

Add U-Boot-specific DTS additions

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi  | 17 +++++++++++++++++
 .../arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi |  8 ++++++++
 .../arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi |  8 ++++++++
 .../dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi    |  8 ++++++++
 .../dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi   |  8 ++++++++
 .../dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi  |  8 ++++++++
 6 files changed, 57 insertions(+)
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi

diff --git a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
new file mode 100644
index 00000000000..2db386d30ba
--- /dev/null
+++ b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+/ {
+	aliases {
+		spi0 = &qspi;
+	};
+
+	config {
+		u-boot,mmc-env-offset = <0x100000>;
+		u-boot,mmc-env-offset-redundant = <0x110000>;
+	};
+};
diff --git a/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
new file mode 100644
index 00000000000..b401f169db7
--- /dev/null
+++ b/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+#include "imx6ul-tqma6ul-common-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
new file mode 100644
index 00000000000..b401f169db7
--- /dev/null
+++ b/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+#include "imx6ul-tqma6ul-common-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
new file mode 100644
index 00000000000..b401f169db7
--- /dev/null
+++ b/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+#include "imx6ul-tqma6ul-common-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
new file mode 100644
index 00000000000..b401f169db7
--- /dev/null
+++ b/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+#include "imx6ul-tqma6ul-common-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
new file mode 100644
index 00000000000..b401f169db7
--- /dev/null
+++ b/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+#include "imx6ul-tqma6ul-common-u-boot.dtsi"
-- 
2.43.0

