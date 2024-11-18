Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A0DD5E393
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52CD689441;
	Mon, 18 Nov 2024 07:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911253;
	bh=IzXLB9wKE1/bCq5TfSDJBVVhcx7DvzWq3yxohCazD1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCOZou9BKpEvOD+nUasEfMieLkuKpuYCaxmxBHBdffo0/kk83yJSlG9puKdzLPOMm
	 NuO2MXkSXD0GR5weJLWxsZWoKWfTr+2+E3Szv7ZgHgvBvvfvL6aS1a1uVWMOCj3s45
	 LZn8bWfp2Rz2ARcN78XedBBg27XkDfp50krDUadNcFIlggPVw74bvtkE/eTCRa4SSQ
	 DPr6QvfXX0N5uL9Pi+90kyvdIjvE6BZNXz/7RuLqqN7cn6EY3ia4DCbxXiodBb2bLI
	 XtVgqdoJvgjKby9DW3mqWotxwmBzxctj2Ajst3zDcpVz1T/R4+uAhJD1oio3sotdDt
	 QHbq155vs4tsw==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8B1CC89445;
 Mon, 18 Nov 2024 07:27:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911251;
 bh=IzXLB9wKE1/bCq5TfSDJBVVhcx7DvzWq3yxohCazD1A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SuaLEMnseVsHX4Q6Z4A+sBfmGQwz1eE2nRwhBNTpDOo4+bwWmDDK7+LEdw6trJcYr
 vkNrwQ1M7jfR+165fcTXt2txO1+lVAP1ZoohHVsEg7BMkXtmk7qPq6AZi9sedUyc7a
 VnZM6s/znDy20OF9RIYriYI/OpmkYM6ulSZylE/cmqt8TR7oGI+EL0ArGjxH97gk3J
 Ply69eNMC294VVQjays6vUoP4kXoMoUorrttIq7l9/b97//YD+sbOF35kx/jHfIzGe
 YL9KrPJWrIr3cWOBi6fvPHDfSOM3u6Pndx/4RWBzK5WuFjUoMh53XoCvs8pocIwF1r
 SxZAfgXXzmOOg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/20] siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
Date: Mon, 18 Nov 2024 07:27:01 +0100
Message-Id: <20241118062715.32989-8-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

current generated flash.bin image does not longer
boot on cxg3 board.

Rename bootph-pre-ram to bootph-all so flash.bin
boots again!

Add u-boot specific change (add bootph-all property)
in A35_0 node to imx8qxp-capricorn-u-boot.dtsi

Signed-off-by: Heiko Schocher <hs@denx.de>
---

Changes in v2:
- add "bootph-all" in A35_0 node to u-boot.dtsi not
  in dts for the board!

 arch/arm/dts/imx8-capricorn-u-boot.dtsi | 67 +++++++++++++------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/arm/dts/imx8-capricorn-u-boot.dtsi b/arch/arm/dts/imx8-capricorn-u-boot.dtsi
index cba56188f86..ad5309bd969 100644
--- a/arch/arm/dts/imx8-capricorn-u-boot.dtsi
+++ b/arch/arm/dts/imx8-capricorn-u-boot.dtsi
@@ -6,130 +6,133 @@
 #include "imx8qxp-u-boot.dtsi"
 
 &{/imx8qx-pm} {
+	bootph-all;
+};
 
-	bootph-pre-ram;
+&A35_0 {
+        bootph-all;
 };
 
 &mu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &clk {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &iomuxc {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio3 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio4 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio5 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio6 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_lsio_gpio7 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_dma {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_dma_lpuart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_dma_lpuart2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_conn {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_conn_sdch0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_conn_sdch1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pd_conn_sdch2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio3 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio4 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio5 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio6 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio7 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &lpuart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &lpuart2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usdhc1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usdhc2 {
-	bootph-pre-ram;
+	bootph-all;
 };
-- 
2.20.1

