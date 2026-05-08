Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9CDCD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22B6A84C81;
	Fri,  8 May 2026 13:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CX8yfmdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72B584C87; Fri,  8 May 2026 13:53:31 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7026284C7D
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
 bh=akmty+0kJeH/qL8VZ2wh49nTVuvMWj6kSyHcvZzr+4Y=; b=CX8yfmdilb8oaRjnQz+TTDU6ci
 ZQOMDI3UE91bxpvb6ctfK5rrqoAOfQPMQ6fgJrTJKUFDcqkkHMrLR/Rf3S/Cxx8LeiDlHPyVoXn5+
 Aa7kQLP46ONmsMgHHuwU6BlMkDP2Y2N8e2PJhQF5GoRciD00ECFRYC+kXfxUnI34kiUOzr6jFKuKS
 9sqcbR3FcbSLYtBRhzVGYYO/iHTfcBVhdm6cmLJW5jQ4SRJwuKFAZS7/hVJD4HDA8+5ot01UAh9Kl
 ysXmgsYWJIQH9lQPCZ9EV64/9o3qr8sB70cjiXjC88Fjryqi76gp9ZhUWmldFSlF2GlqZTDHKzyqX
 C03u8h8A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJln-000DVp-1F; Fri, 08 May 2026 13:53:27 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJlm-000PER-37; Fri, 08 May 2026 13:53:27 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 3/5] ARM: dts: tqma6ul: add boot phase properties
Date: Fri,  8 May 2026 13:53:08 +0200
Message-ID: <20260508115315.252623-4-Max.Merchel@ew.tq-group.com>
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

Add boot phase properties from U-Boot device tree.
Patches are integrated into Linux v7.1-rc1.
This commit can revert if upstream device trees are synced
with u-Boot.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 .../arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi | 32 +++++++++++++++++++
 .../dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi   |  2 ++
 .../dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi   |  2 ++
 .../dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi  |  2 ++
 .../dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi |  2 ++
 .../imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi    |  2 ++
 arch/arm/dts/mba6ulx-u-boot.dtsi              | 26 +++++++++++++++
 7 files changed, 68 insertions(+)
 create mode 100644 arch/arm/dts/mba6ulx-u-boot.dtsi

diff --git a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
index 2db386d30ba..09f94f23074 100644
--- a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
@@ -15,3 +15,35 @@
 		u-boot,mmc-env-offset-redundant = <0x110000>;
 	};
 };
+
+&clks {
+	bootph-pre-ram;
+};
+
+&flash0 {
+	bootph-pre-ram;
+};
+
+&osc {
+	bootph-pre-ram;
+};
+
+&pinctrl_pmic {
+	bootph-pre-ram;
+};
+
+&pinctrl_qspi {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&qspi {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
index b401f169db7..0917ecfd82a 100644
--- a/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
@@ -5,4 +5,6 @@
  * Author: Max Merchel
  */
 
+#include "imx6ul-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
+#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
index b401f169db7..0917ecfd82a 100644
--- a/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
@@ -5,4 +5,6 @@
  * Author: Max Merchel
  */
 
+#include "imx6ul-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
+#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
index b401f169db7..0917ecfd82a 100644
--- a/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
@@ -5,4 +5,6 @@
  * Author: Max Merchel
  */
 
+#include "imx6ul-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
+#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
index b401f169db7..21fb2ab4ae9 100644
--- a/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
@@ -5,4 +5,6 @@
  * Author: Max Merchel
  */
 
+#include "imx6ull-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
+#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
index b401f169db7..21fb2ab4ae9 100644
--- a/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
@@ -5,4 +5,6 @@
  * Author: Max Merchel
  */
 
+#include "imx6ull-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
+#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/mba6ulx-u-boot.dtsi b/arch/arm/dts/mba6ulx-u-boot.dtsi
new file mode 100644
index 00000000000..73bed319ef2
--- /dev/null
+++ b/arch/arm/dts/mba6ulx-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+&uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&reg_mba6ul_3v3 {
+	bootph-pre-ram;
+};
-- 
2.43.0

