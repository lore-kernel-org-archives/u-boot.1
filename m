Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AEFC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3C9184C04;
	Mon, 13 Jul 2026 15:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jAUuxAIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775B684BFC; Mon, 13 Jul 2026 15:31:09 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CA584B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=V1WaHh63hqDfmXXZaN9ayLV+gjA72fndhqhJ6Wwj+7M=; b=jAUuxAImWbXI/NGc57ala1Ijur
 YcedK/P5rVAwgVcW+AZ37EHOobWCSMTDaubqzPWeAm24ax2ft6V+FROzvcR7P8pKBU1EHp5tZYHYa
 jIAgIbXwB/hcw5Tu3OvPb5jp8ZNFM9XOoRm9woGGKS1yVbmkGowZIB3q+KRkhOgRXiwuTzmTAwOFk
 /9U1ufpnx0LdYhSUsk2LPnsLlNk0MTN9WvP7aot5vM49uekMkSBR3GUl0SRb2Ln+x4EVZLzNCN+3n
 KSe9OHLudMiFljTYS5XruSPAQWE0qQGV6i43WMc62EYLcY2QtIFhjEaXeQ2PMXA+7Tvzfjsyht6wu
 F+IHHr9A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHt-000Dls-0T; Mon, 13 Jul 2026 15:01:33 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHs-000Hfn-0o; Mon, 13 Jul 2026 15:01:32 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 2/6] ARM: dts: tqma6: add boot phase properties
Date: Mon, 13 Jul 2026 15:01:02 +0200
Message-ID: <20260713130109.321862-3-Max.Merchel@ew.tq-group.com>
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

Add boot phase properties from U-Boot device tree.
This commit can be reverted if changes are integrated in upstreem
device trees and synced with U-Boot.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi   | 32 ++++++++++++++++++++++
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi  | 36 +++++++++++++++++++++++++
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi |  4 +++
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi |  8 ++++++
 4 files changed, 80 insertions(+)

diff --git a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
index 535fd0c5e48..22f67c6f966 100644
--- a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
@@ -6,3 +6,35 @@
  */
 
 #include "imx6qdl-tqma6-u-boot.dtsi"
+
+&gpio1 {
+	bootph-pre-ram;
+};
+
+&i2c1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_wdog1{
+	bootph-pre-ram;
+};
+
+&uart2 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
index 5b1a65583cf..b5269748058 100644
--- a/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
@@ -16,3 +16,39 @@
 		bootph-pre-ram;
 	};
 };
+
+&aips1 {
+	bootph-pre-ram;
+};
+
+&aips2 {
+	bootph-pre-ram;
+};
+
+&ecspi1 {
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+};
+
+&m25p80 {
+	bootph-pre-ram;
+};
+
+&pinctrl_ecspi1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc3 {
+	bootph-pre-ram;
+};
+
+&usdhc3 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
index cb3f68e859b..af72ac77a79 100644
--- a/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
@@ -8,3 +8,7 @@
 /* SOC specific U-Boot DT adjustments */
 
 #include "imx6qdl-tqma6-u-boot.dtsi"
+
+&i2c1 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
index cb3f68e859b..8ae7f2900f3 100644
--- a/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
@@ -8,3 +8,11 @@
 /* SOC specific U-Boot DT adjustments */
 
 #include "imx6qdl-tqma6-u-boot.dtsi"
+
+&i2c3 {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c3 {
+	bootph-pre-ram;
+};
-- 
2.43.0

