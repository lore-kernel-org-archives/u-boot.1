Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953D4C61DE2
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 08:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D56F160627;
	Mon, 31 Aug 2026 08:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DD7b5jW8f5vt; Mon, 31 Aug 2026 08:58:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788166697;
	bh=j8yG3KWqqlguBxHJU/ug6zm44n9qZclacyiejLLKYRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QpizUlUI3f3hylD9PJHm2459jmhLOdiamaoHRU5ZFfTnJmx1Yfvt1zFClmDSOxcKJ
	 DP2yLMVoGLsvfWTEvPr0OsbPAqZAtRu3vCwxRnR0ilIv0zOeqfqn9L+itBd9n4T7Iq
	 RfDO6M58cokg1DgpkBfE7bjOhPXLeIvpS4ctSOthk+g7nAHYdl54PBqNA5l5qcvHaq
	 0nmAN8Mn5WhnUftjlho2BLcSPOsW56Hhu/G8RO8HBfUgRyFKHJYjBWSK5co3W10RRI
	 faKEcYsKWIa9WIn+/re5pq9PLhz3KFKoE5AcgNmIfVyGHRkeuQAJt2hMYVYl67T8hO
	 p1U6diad7WLqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAE1F60623;
	Mon, 31 Aug 2026 08:58:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 327D3F2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2426080C06
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7joTB7EhJrBj for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 08:58:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=nGKJQDjm
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D22380BA4
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=j8yG3KWqqlguBxHJU/ug6zm44n9qZclacyiejLLKYRs=; b=nGKJQDjmwb+Vx8olNoqYydvduf
 OvXfgehYmeXkuBA0G12fGbJ7pXm7GLaAT1RCxqpwpPFjZ3ffl+QIrxoVcw64e8G1WG5V56OP5sFTB
 ycnSSwtjtCzGwl1QZyiqc2TOR6lB/5YIYMtaXl8xiitYoHYS3smuFHIK1FX89xh/WIwYfibKkqUQw
 NnUJp+vuaJ4khXnglq6xFUrTip2G5SK4RZdYjaS0t4009ts/G1Kkz+p/sZZYnUgMalqCbuuD12Cib
 WxTrnvtayrR6T02sK6AMq0VFqDEpCvQd5QMqJEY4ksJLnaQtA4C03aMCERQ7dBk4rG4Rs7sXrCO4k
 8ltEzGbQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1x0xqE-00089Q-1r; Mon, 31 Aug 2026 10:58:10 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1x0xqE-000PRR-0E; Mon, 31 Aug 2026 10:58:10 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 31 Aug 2026 10:58:08 +0200
Subject: [PATCH 3/3] Revert "arch: arm: dts: tqma7x: add boot phase properties"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-revert_bootph-v1-3-f7ce897ded63@ew.tq-group.com>
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

This reverts commit 77375425023b141972091e8f2cd56c3b64c0c9df.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx7s-mba7-u-boot.dtsi  | 21 ---------------------
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 24 ------------------------
 2 files changed, 45 deletions(-)

diff --git a/arch/arm/dts/imx7s-mba7-u-boot.dtsi b/arch/arm/dts/imx7s-mba7-u-boot.dtsi
index bb560f4d85b..53f55304fea 100644
--- a/arch/arm/dts/imx7s-mba7-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-mba7-u-boot.dtsi
@@ -21,28 +21,7 @@
 	};
 };
 
-&gpio4 {
-	/* Deassert BOOT_EN after boot to separate BOOT_CFG circuits from LCD signals */
-	boot-en-hog {
-		gpio-hog;
-		gpios = <3 GPIO_ACTIVE_LOW>;
-		output-low;
-	};
-};
-
 &wdog1 {
 	u-boot,noautostart;
 	timeout-sec = <60>;
 };
-
-&iomuxc {
-	bootph-pre-ram;
-};
-
-&pinctrl_uart6 {
-	bootph-pre-ram;
-};
-
-&uart6 {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
index 2b6bbcc0276..934a4efade5 100644
--- a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
@@ -16,27 +16,3 @@
 		nvmem-cell-names = "device_info";
 	};
 };
-
-&m24c64 {
-	nvmem-layout {
-		compatible = "fixed-layout";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		module_info: module-info@20 {
-			reg = <0x20 0x60>;
-		};
-	};
-};
-
-&soc {
-	bootph-pre-ram;
-};
-
-&aips1 {
-	bootph-pre-ram;
-};
-
-&aips3 {
-	bootph-pre-ram;
-};

-- 
2.43.0

