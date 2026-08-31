Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4835C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 08:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88F0D605D2;
	Mon, 31 Aug 2026 08:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mb9hYBMf5O6q; Mon, 31 Aug 2026 08:58:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788166706;
	bh=6ulAGpS6mPSiIrMa5o7+70FBaY0NvDLkJAunD321P/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TDec+6NFNz8WPHFeQFsKXHqNGj5x4U0WJ+XcR7nAt++x4KYrefTqgr9uTzCtxa1m3
	 HJ0v9FcZoGYGUdoWOTW4ZnuDaRUzHKvIB8UDgt5E5tJWheTwyjBYEiA6FZYxWBXfDt
	 mMzxI5IG3+WHrfCI8EdxT7kCvkkXni9ACxNnVf8XjwEZ6iiLuo63b5m1LqV0Bt8K6X
	 dEw8+NIiKdDQa/V2LXPZ1cB/8THBWOJuh35Faokw5lF2vzz58MM2A7hI6rV/QtnbBw
	 l6ZN6PAK1XBlW59Wg3eE0nDKvMKVX4FFOm8C9iIfhJ2f1+tuTQ1moV3kv4BRxf2Xmy
	 S2SE+l30YH7lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A33AE60603;
	Mon, 31 Aug 2026 08:58:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24BD9230
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B16D60603
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iEOsd4sCBm81 for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 08:58:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=R6w7D4kQ
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0B3C605D2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=6ulAGpS6mPSiIrMa5o7+70FBaY0NvDLkJAunD321P/k=; b=R6w7D4kQ9XsAW9hJOSH0v2FAIx
 u5Os74yPDUUFOQaK3C8YyipERFU6dgL+JrZVNsReRJL8DppAajuP5JYBFouIUNsm3KuthZ3OMoWlN
 thECiJGzDQj8iPOF/kRhi8hMkJmF8izqO7WIYQQAC9CDx/d3QppuzOgpwLG3O1+xLvrS/6+xDVgf2
 JBVWWxFv4XheXrmR0FSuLAHdssmY382OaKLJxn8KbsbfPWg97GlmyK8vPkVEoobx673zzpyJ0eMfK
 eQhqqPokyfVfW89ueDhEH9rD+mcNFg1QXPrvT/t0J/UPTxM+Gj/icou5romIXQQPYl5+zECg1sx83
 /jVRP0+g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1x0xqE-00089N-0X; Mon, 31 Aug 2026 10:58:10 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1x0xqD-000PRR-27; Mon, 31 Aug 2026 10:58:09 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 31 Aug 2026 10:58:07 +0200
Subject: [PATCH 2/3] Revert "ARM: dts: tqma6ul: add boot phase properties"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-revert_bootph-v1-2-f7ce897ded63@ew.tq-group.com>
References: <20260831-revert_bootph-v1-0-f7ce897ded63@ew.tq-group.com>
In-Reply-To: <20260831-revert_bootph-v1-0-f7ce897ded63@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28109/Mon Aug 31 08:24:07 2026)
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

With the integration of the Linux 7.2 device trees,
the commit is no longer needed.

This reverts commit 771070a46adc6665c702b408b02229a7fb1b6989.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi     | 32 ----------------------
 arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi   |  2 --
 arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi   |  2 --
 arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi  |  2 --
 arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi |  2 --
 .../arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi |  2 --
 arch/arm/dts/mba6ulx-u-boot.dtsi                   | 26 ------------------
 7 files changed, 68 deletions(-)

diff --git a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
index c9e6cef38a2..06bf91cf1ca 100644
--- a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
@@ -22,14 +22,6 @@
 	};
 };
 
-&clks {
-	bootph-pre-ram;
-};
-
-&flash0 {
-	bootph-pre-ram;
-};
-
 &m24c64_50 {
 	nvmem-layout {
 		compatible = "fixed-layout";
@@ -41,27 +33,3 @@
 		};
 	};
 };
-
-&osc {
-	bootph-pre-ram;
-};
-
-&pinctrl_pmic {
-	bootph-pre-ram;
-};
-
-&pinctrl_qspi {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc2 {
-	bootph-pre-ram;
-};
-
-&qspi {
-	bootph-pre-ram;
-};
-
-&usdhc2 {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
index 0917ecfd82a..b401f169db7 100644
--- a/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
@@ -5,6 +5,4 @@
  * Author: Max Merchel
  */
 
-#include "imx6ul-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
-#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
index 0917ecfd82a..b401f169db7 100644
--- a/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
@@ -5,6 +5,4 @@
  * Author: Max Merchel
  */
 
-#include "imx6ul-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
-#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
index 0917ecfd82a..b401f169db7 100644
--- a/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
@@ -5,6 +5,4 @@
  * Author: Max Merchel
  */
 
-#include "imx6ul-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
-#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
index 21fb2ab4ae9..b401f169db7 100644
--- a/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
@@ -5,6 +5,4 @@
  * Author: Max Merchel
  */
 
-#include "imx6ull-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
-#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi b/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
index 21fb2ab4ae9..b401f169db7 100644
--- a/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
+++ b/arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
@@ -5,6 +5,4 @@
  * Author: Max Merchel
  */
 
-#include "imx6ull-u-boot.dtsi"
 #include "imx6ul-tqma6ul-common-u-boot.dtsi"
-#include "mba6ulx-u-boot.dtsi"
diff --git a/arch/arm/dts/mba6ulx-u-boot.dtsi b/arch/arm/dts/mba6ulx-u-boot.dtsi
deleted file mode 100644
index 73bed319ef2..00000000000
--- a/arch/arm/dts/mba6ulx-u-boot.dtsi
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
-/*
- * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
- * D-82229 Seefeld, Germany.
- * Author: Max Merchel
- */
-
-&uart1 {
-	bootph-pre-ram;
-};
-
-&pinctrl_uart1 {
-	bootph-pre-ram;
-};
-
-&usdhc1 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc1 {
-	bootph-pre-ram;
-};
-
-&reg_mba6ul_3v3 {
-	bootph-pre-ram;
-};

-- 
2.43.0

