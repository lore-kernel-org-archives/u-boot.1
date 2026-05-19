Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D60CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6676A843B6;
	Tue, 19 May 2026 14:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="db9hG129";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E431846B0; Tue, 19 May 2026 14:24:24 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 158FC846B0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 14:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Y6YweX2bP1j/eXCWXSujksy55WQv6wnx6lx/nKSAVqo=; b=db9hG129ozO3S0QtFSupyblLa9
 mmC6vftl8p4VFqgObxGweqV0M4GhyCg0IxuoymCzAOTgDvvYKFIq7IhmeF486zyJyoItfHiEgeMpf
 Jc/8lF8Rw9/Nv74DdUQt0sauWqkQGbN34etXooc1nJvSmHUwrOPUxxMvc8OUrKxshW5PCSrK3IYpi
 D27vjtK6WFTdiez2YtL43ZrzSeRXT1ivMy+i3llyNSPkHIZEJNi2EJuttk8bl+K/gucvW9L5Lz/6w
 y33B72gQZBbUUzcCPhTG0Li/4ntuYjLNcqwSyd/MtRjbVJV3lKfXh/dYDs63GXO4Ri4oD8nC51Ori
 pvF4akmw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wPJUj-00096P-0w; Tue, 19 May 2026 14:24:21 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wPJUi-000DyU-1v; Tue, 19 May 2026 14:24:21 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/4] ARM: dts: tqma6ul: add boot phase properties
Date: Tue, 19 May 2026 14:24:05 +0200
Message-ID: <20260519122412.588963-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519122412.588963-1-Max.Merchel@ew.tq-group.com>
References: <20260519122412.588963-1-Max.Merchel@ew.tq-group.com>
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
Revert this commit once the upstream linux device trees are
synchronized.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---

Changes V2:
- unchanged

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

