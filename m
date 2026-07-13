Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9165CC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C15084BD0;
	Mon, 13 Jul 2026 15:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Rkl21+KP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADB384BD5; Mon, 13 Jul 2026 15:30:59 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3730784B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Lfi2C/M+urFlUWr1dAhZZ80BJ6lh9tSrbueOKCMcLCU=; b=Rkl21+KPiTSfxaVaUislj4fiVK
 Sa3EyRvF67EbZvPwmUlsq0DFIPgnrV2JP58Q1Uo+eTLA+cfiWTeEXmHP1+gvk1CgcY2TZkgJ3InB1
 z6BUkF60LPiAcLieNSKzKzplbvAX0iI78mF1jFqftW58A28iAsZ/Ed4LLUsWI8wEmE1jboXz/9WHv
 dJBEhguaZ6qEN3hOhZOOo7q7TkJgmPxXJvy460v+LIznZLsljkPfNiRAEFAJe+OQy2W2RYEifIGN2
 yJiE7UO8aCa1ZosluoqIFmVAskgwUWjf79YW9o/GWJbuMlnj7raFCfpYhIH79aaJtYI9OVZiymWQa
 ttxyDxNQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHs-000Dlm-2t; Mon, 13 Jul 2026 15:01:32 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHr-000Hfn-2z; Mon, 13 Jul 2026 15:01:32 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 1/6] board: tqma6: change U-Boot device tree fragments
Date: Mon, 13 Jul 2026 15:01:01 +0200
Message-ID: <20260713130109.321862-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
References: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

We will need GPIO to distinguish between SOM variants with / without
workaround for ENET errata. This is necessary to implement the
appropriate solution and remove code intended for the non-DM use case.
To support reuse, split them in SOM and baseboard specific parts.

Prepare fragments for use with SPL.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6dl-mba6a-u-boot.dtsi   |  8 +++++
 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi   |  7 ++++-
 arch/arm/dts/imx6q-mba6a-u-boot.dtsi    |  8 +++++
 arch/arm/dts/imx6q-mba6b-u-boot.dtsi    |  7 ++++-
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi   | 39 +++++--------------------
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi  | 18 ++++++++++++
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi | 10 +++++++
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi | 10 +++++++
 8 files changed, 74 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/dts/imx6dl-mba6a-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6q-mba6a-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi

diff --git a/arch/arm/dts/imx6dl-mba6a-u-boot.dtsi b/arch/arm/dts/imx6dl-mba6a-u-boot.dtsi
new file mode 100644
index 00000000000..d484a5dda00
--- /dev/null
+++ b/arch/arm/dts/imx6dl-mba6a-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#include "imx6qdl-mba6-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6dl-mba6b-u-boot.dtsi b/arch/arm/dts/imx6dl-mba6b-u-boot.dtsi
index bb17ba9b424..d484a5dda00 100644
--- a/arch/arm/dts/imx6dl-mba6b-u-boot.dtsi
+++ b/arch/arm/dts/imx6dl-mba6b-u-boot.dtsi
@@ -1,3 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
 
 #include "imx6qdl-mba6-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6q-mba6a-u-boot.dtsi b/arch/arm/dts/imx6q-mba6a-u-boot.dtsi
new file mode 100644
index 00000000000..d484a5dda00
--- /dev/null
+++ b/arch/arm/dts/imx6q-mba6a-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#include "imx6qdl-mba6-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6q-mba6b-u-boot.dtsi b/arch/arm/dts/imx6q-mba6b-u-boot.dtsi
index bb17ba9b424..d484a5dda00 100644
--- a/arch/arm/dts/imx6q-mba6b-u-boot.dtsi
+++ b/arch/arm/dts/imx6q-mba6b-u-boot.dtsi
@@ -1,3 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
 
 #include "imx6qdl-mba6-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
index c8c0fc1fba7..535fd0c5e48 100644
--- a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
@@ -1,31 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include "imx6qdl-u-boot.dtsi"
-
-/ {
-	wdt-reboot {
-		compatible = "wdt-reboot";
-		wdt = <&wdog1>;
-		bootph-pre-ram;
-	};
-};
-
-&aips2 {
-	bootph-all;
-};
-
-&pinctrl_uart2 {
-	bootph-all;
-};
-
-&soc {
-	bootph-all;
-};
-
-&uart2 {
-	bootph-all;
-};
-
-&wdog1 {
-	bootph-pre-ram;
-};
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#include "imx6qdl-tqma6-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
new file mode 100644
index 00000000000..5b1a65583cf
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+/* SOC specific U-Boot DT adjustments */
+
+#include "imx6qdl-u-boot.dtsi"
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+};
diff --git a/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
new file mode 100644
index 00000000000..cb3f68e859b
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+/* SOC specific U-Boot DT adjustments */
+
+#include "imx6qdl-tqma6-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
new file mode 100644
index 00000000000..cb3f68e859b
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+/* SOC specific U-Boot DT adjustments */
+
+#include "imx6qdl-tqma6-u-boot.dtsi"
-- 
2.43.0

