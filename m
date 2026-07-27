Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEEDC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDB5B80DD7;
	Mon, 27 Jul 2026 12:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUsMomZ_O5St; Mon, 27 Jul 2026 12:06:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9493480DCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153983;
	bh=f5bQuOL0eihDJmpEILLfNDiJ0UJcMDAEStFwU09TMIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fLAS1Td2J8UIgknoypmYhvv6+m7HMRLM6f5XcCe5WMx9mMvtEFn/RIk5ATovJU2A8
	 FMCwi1EwTGgIamKWo6P4JUKjCWgJ0B5+BNzS0qe4emI2dS/4lAvSUTAlGrCM0hDmHv
	 DF5OEZhXyRWurLvdWYVvyjsFpzkqXGDwMqzfuxXPyaAtOlILiXZiHQWa3MOLQHoy7Q
	 eKDM2vcPkkIEFLbyqlEmmbwjg0aVY2PWAh7KzOzW6lggfwpZQK2+cF2PeS5x12keT/
	 SROm7rvHLXn799WzquxO8AokzTK/w7a0R6dfI+5Bc2fxtggZCAFSFhKBDrLGRk1KiP
	 gSB7MenfGWJag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9493480DCA;
	Mon, 27 Jul 2026 12:06:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24EA14C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0590180D77
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ETnLbYybOaI for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:06:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BB06880C88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB06880C88
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB06880C88
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:19 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK65-000JLi-0V; Mon, 27 Jul 2026 14:06:17 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK64-000I7f-2p; Mon, 27 Jul 2026 14:06:16 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 14:06:15 +0200
Subject: [PATCH RESEND 1/6] board: tqma6: change U-Boot device tree fragments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6_bis_spl-v1-1-27673934830f@ew.tq-group.com>
References: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
In-Reply-To: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=f5bQuOL0eihDJmpEILLfNDiJ0UJcMDAEStFwU09TMIA=; b=Epkbm8SSXsc5LQS36zoQGl3phs
 +PLOoMOCJEN0M7FzXXF7ErG8MEH27WJuHucaGXYbHwhjuH522o6GbthlkBXBxMdcUr+IuaurggKTZ
 8USsMvkLUBwYUZu6vJaC6VnlQsQk66BseX6yWaQeOOeP2KX9lvqs0kTvahxR6DdxocuhpA0Y0WrfU
 YLixtZUuZhbKFJathGem4fmOmhHKUFPJ0GS/TgebG+S8chXsUUOaCf9Pt6ZRrrbs6jpHhcqiBGA6h
 uoLw3/GOtKI05/dQQ4wgu48WF16E2pTdB6rlsGkjI2LUnV7JC0n4QG6Svw5WVkJyqh478oczT5KLN
 QUwUmQxQ==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Epkbm8SS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

We will need GPIO to distinguish between SOM variants with / without
workaround for ENET errata. This is necessary to implement the
appropriate solution and remove code intended for the non-DM use case.
To support reuse, split them in SOM and baseboard specific parts.

Prepare fragments for use with SPL.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6dl-mba6a-u-boot.dtsi   |  8 +++++++
 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi   |  7 +++++-
 arch/arm/dts/imx6q-mba6a-u-boot.dtsi    |  8 +++++++
 arch/arm/dts/imx6q-mba6b-u-boot.dtsi    |  7 +++++-
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi   | 39 +++++++--------------------------
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi  | 18 +++++++++++++++
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi | 10 +++++++++
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi | 10 +++++++++
 8 files changed, 74 insertions(+), 33 deletions(-)

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

