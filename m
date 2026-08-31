Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5856C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 08:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A95F40549;
	Mon, 31 Aug 2026 08:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IY-hMVYyO4Km; Mon, 31 Aug 2026 08:58:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788166702;
	bh=xj/1exgi/kaZnQ8LPDkfkx/Pq1ZquyYovvPhRMREvKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YO79NpYzfIuj7FNZwLLcWF1aOQId5v88NE6NTuXRqmYCZoaYtiIh1Jw/vN/WAuisf
	 AVpOBfrrG9wUHgL42rLKeUZczPHN/zBir/ohng+uwb79r4jcgP1xVX2RYPgR2k/DZg
	 F5WHs3paQO6qGCQJwYjh1XnjZhCg8tiIiUZvpsAFPcGw2BYcLhms09WvrK6Wq35fGD
	 5BCC1BtiCXHKrnG0/L3nPWtK5ZFTiu/EC7VKegvGnA0eBxFYNSpXtcBPp3Jq06vTjx
	 ej79/uEmm/qgIuog/ayTIHeuDAAr5agA8LcLxv334Z2zi2I2o+odC1wUEQvt3RC7m9
	 C58f3YFdRyBOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 696F540536;
	Mon, 31 Aug 2026 08:58:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CDDCF2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F31F340536
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JsaV8XkMSkex for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 08:58:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=bz/WzMKC
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A47C40534
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=xj/1exgi/kaZnQ8LPDkfkx/Pq1ZquyYovvPhRMREvKk=; b=bz/WzMKCk85nfraDOd0NNFG+zg
 moAVJk8XfptLWoX3yPvZ5qRuvyWjOqZRsV+mi1uEFWo4+41HdwlHNPsefEsP654XSzTywrt4t2W4v
 lRtzEo7VWqkMiuJae6YxotG+F0BuVBbmKRFj5oWf1krq1Kg5F4EgGOsnwRCHsND4IfAlhc48B0xVs
 JCt6v+Mmvvoi/4/nOVIx/pcjJlDuzmH8j3yfSY9doqNWlFDBF+wV+9vrYf10vN6rlMsr9iZaW7gKg
 6trTm3KxtYWmcw8kLRj+WxTCXPcXSWtvowOF4UYP2b5t8QCvyFSBATx19Q8vgxYMCIeZt13M5kBIO
 TjBpMvoA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1x0xqD-00089G-2T; Mon, 31 Aug 2026 10:58:09 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1x0xqD-000PRR-0m; Mon, 31 Aug 2026 10:58:09 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 31 Aug 2026 10:58:06 +0200
Subject: [PATCH 1/3] Revert "ARM: dts: tqma6: add boot phase properties"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-revert_bootph-v1-1-f7ce897ded63@ew.tq-group.com>
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

This reverts commit c644dec64af5182b8fbb142dbf62484f1583d5b1.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi   | 32 -----------------------------
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi  | 36 ---------------------------------
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi |  4 ----
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi |  8 --------
 4 files changed, 80 deletions(-)

diff --git a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
index 22f67c6f966..535fd0c5e48 100644
--- a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
@@ -6,35 +6,3 @@
  */
 
 #include "imx6qdl-tqma6-u-boot.dtsi"
-
-&gpio1 {
-	bootph-pre-ram;
-};
-
-&i2c1 {
-	bootph-pre-ram;
-};
-
-&pinctrl_uart2 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc2 {
-	bootph-pre-ram;
-};
-
-&pinctrl_wdog1{
-	bootph-pre-ram;
-};
-
-&uart2 {
-	bootph-pre-ram;
-};
-
-&usdhc2 {
-	bootph-pre-ram;
-};
-
-&wdog1 {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
index b5269748058..5b1a65583cf 100644
--- a/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
@@ -16,39 +16,3 @@
 		bootph-pre-ram;
 	};
 };
-
-&aips1 {
-	bootph-pre-ram;
-};
-
-&aips2 {
-	bootph-pre-ram;
-};
-
-&ecspi1 {
-	bootph-pre-ram;
-};
-
-&gpio3 {
-	bootph-pre-ram;
-};
-
-&m25p80 {
-	bootph-pre-ram;
-};
-
-&pinctrl_ecspi1 {
-	bootph-pre-ram;
-};
-
-&pinctrl_i2c1 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc3 {
-	bootph-pre-ram;
-};
-
-&usdhc3 {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
index af72ac77a79..cb3f68e859b 100644
--- a/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
@@ -8,7 +8,3 @@
 /* SOC specific U-Boot DT adjustments */
 
 #include "imx6qdl-tqma6-u-boot.dtsi"
-
-&i2c1 {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi b/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
index 8ae7f2900f3..cb3f68e859b 100644
--- a/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
@@ -8,11 +8,3 @@
 /* SOC specific U-Boot DT adjustments */
 
 #include "imx6qdl-tqma6-u-boot.dtsi"
-
-&i2c3 {
-	bootph-pre-ram;
-};
-
-&pinctrl_i2c3 {
-	bootph-pre-ram;
-};

-- 
2.43.0

