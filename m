Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C14C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 137B280DCF;
	Mon, 27 Jul 2026 12:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qq7ooP0_brih; Mon, 27 Jul 2026 12:06:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43B5180D7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153982;
	bh=lSoieW2dJKh60qgOzGoiLty9gb+DKad3LWEGm8iNNvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/hD9upcD29ti3IkyupmnBVxtQh2vVIT3ubtXoF4dn97p3btcaNvKlVpefm7AWPVc
	 +w5pcqFAZnG07K1hAW0jhneKb5btumfm9roLDTbiOsN5eLFGexzJIXXt56NTfNy9js
	 bugldUcff66QXGJsPhzbhgk/asu+OmnFxiZUe3hvj06tmnmMjEJFW4ZBJ7BGY2H0Uq
	 CaJRcpeTeFjQUjrhiuSKJgLhWLc0q3opV8dGUqbyxTBHCmWWO+ZD1pXoauWeQGBejQ
	 TasWg5QeaDpgW3NYCp/Vkt006/WKC2UDsBpJSq/jYF27tQb1kTH7KA6Cp4SdpFciZT
	 N4bhKmY2fVvVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43B5180D7C;
	Mon, 27 Jul 2026 12:06:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1187F2E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E52DA606DA
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhTgjmWLFXeM for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:06:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E4F35606D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4F35606D9
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4F35606D9
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:19 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK65-000JM0-1g; Mon, 27 Jul 2026 14:06:17 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK65-000I7f-0n; Mon, 27 Jul 2026 14:06:17 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 14:06:16 +0200
Subject: [PATCH RESEND 2/6] ARM: dts: tqma6: add boot phase properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6_bis_spl-v1-2-27673934830f@ew.tq-group.com>
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
 bh=lSoieW2dJKh60qgOzGoiLty9gb+DKad3LWEGm8iNNvk=; b=mFPECSeJY5VmDHKhS70U1pc/sn
 2vh2RjVVeDLxb+lxj09KZq/FFfj6sMQ0exRlfhaZO37sQHo+daazjnP0t3iwayRWQSeJYCu9K3SNz
 SkvidsWhmgdHVbXsHfT2KTpCFGrBMVz53oDx8wpiF7wilJkEBsIoAV8FklqvtDn/Or4fDuz0IVO6g
 H5/urvmB+EeMTERjrHdE1GGcitXqT2La08ChfjGpsMQN+1e2LL5+n9CgwJowyK/oZDnhW4o2vhuNN
 x0VWiPlkg38fAymeNZbug4HX3sGXM9iw/jTc7tpyL9/bjaVV4tovpftOeP+l9Z6YsuCyFGIi4Mik7
 xlZ1vszA==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=mFPECSeJ
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

Add boot phase properties from U-Boot device tree.
This commit can be reverted if changes are integrated in upstreem
device trees and synced with U-Boot.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi   | 32 +++++++++++++++++++++++++++++
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi  | 36 +++++++++++++++++++++++++++++++++
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi |  4 ++++
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi |  8 ++++++++
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

