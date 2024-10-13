Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F9ACF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133BA88EB5;
	Mon, 14 Oct 2024 04:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+MOaRnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D6388EFE; Sun, 13 Oct 2024 16:32:55 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4755D88F85
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c93109d09aso732645a12.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829968; x=1729434768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HE2tgN0B24aRLm11WpPVxtooYl5uWl1zFtAJJLXMl2Y=;
 b=H+MOaRnPcR0H9JUN0v5cs2DYrc7ih3WwGD4E+zjovbqEaNpSUD8865tT0/WPakkkEZ
 WPxEJfk6a/W775/EsQEKLyeXax8OHS5OXyi+krOObEdzUD7ZbEIoqR6DHb/ygsEOtnnW
 kQE2CxdcI+XVa6HDLBb+AJwVpWrzTktgYtsXgxSdHMS6ev9wNkuCS9Y4Pi251qYDlLUV
 luzVfcXlJLZ6xGOnhY5jnbk38lCIMokxBQdpUoW3tejxgSDnOpdWIMCwmvG5xyma6dC1
 3f+LemZpbtUWIzbqvReZwlibR8iwEu7/akw7tcjih2xbTVdq8MN+TkvziNlDz5YdMJKs
 qodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829968; x=1729434768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HE2tgN0B24aRLm11WpPVxtooYl5uWl1zFtAJJLXMl2Y=;
 b=K5/WaihwsoqHlRcjwXuKI8Sl5HaTzs+r1+/V3XAYtd3E0lTR5qEueqazfUJMXoAxbT
 aOQfdCG5IKxPbPXLQsoAjZ2RPr56FFPYBxXrNllXpVFdNU0GwJ3Idfr02v1MSt4JlHdF
 +nxi0FPHC6q72G8i95xAiGoIEDszgNv/DD3mpg/I8GLLF/RhkUAdfXr69N1M34J7FQvB
 Xaka0xXI6wGsh+ce5y1SzHXA0KkRnIUsHavh/usons7TC10XpOHb7tfKeJ/WEKsYqE0J
 LtAqagaswcSdGVIPy61mMok7BPHRSoJWe2LSMeUUBOgSAuy8pqD4cUOFy6gMWKKSwqaH
 mE2g==
X-Gm-Message-State: AOJu0YxdgrLIVsrWhz7+mhxw04kICdMdyDFG+cnT8wwF4aQIILgJtkeg
 qJx6JsVR40XGVanFdQJHQi3sRTj+C9tGcxoim4na36KOZKP/V/AS3Xau/w==
X-Google-Smtp-Source: AGHT+IHEOL898x1836PrNDJI+pyJMaY3KdbVW9ixnapesIy3uNU6IChB/tbHj0ZfA/gFM3XPQhQX8Q==
X-Received: by 2002:a17:907:7290:b0:a99:30f2:ee41 with SMTP id
 a640c23a62f3a-a99b9419853mr332655966b.4.1728829967737; 
 Sun, 13 Oct 2024 07:32:47 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:46 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH 09/10] ARM: dts: arria10: update according to DTSpec
Date: Sun, 13 Oct 2024 14:32:31 +0000
Message-Id: <20241013143232.2090645-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241013143232.2090645-1-l.rubusch@gmail.com>
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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

Update node-names according to DTspec. Add labels for compatibility
and/or add missing nodes in order to make the file compatible with the
corresponding counterpart in dts/upstream. Eventually the u-boot local
file then can be replaced by the dts/upstream, and eventually removed.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/dts/socfpga_arria10.dtsi | 42 ++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/socfpga_arria10.dtsi b/arch/arm/dts/socfpga_arria10.dtsi
index bab34ab56c..5826268823 100644
--- a/arch/arm/dts/socfpga_arria10.dtsi
+++ b/arch/arm/dts/socfpga_arria10.dtsi
@@ -15,13 +15,13 @@
 		#size-cells = <0>;
 		enable-method = "altr,socfpga-a10-smp";
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
 		};
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <1>;
@@ -29,7 +29,16 @@
 		};
 	};
 
-	intc: intc@ffffd000 {
+	pmu: pmu@ff111000 {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&intc>;
+		interrupts = <0 124 4>, <0 125 4>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+		reg = <0xff111000 0x1000>,
+		      <0xff113000 0x1000>;
+	};
+
+	intc: interrupt-controller@ffffd000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
@@ -73,7 +82,7 @@
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
 
@@ -638,7 +647,7 @@
 			reg = <0xffcfb100 0x80>;
 		};
 
-		L2: l2-cache@fffff000 {
+		L2: cache-controller@fffff000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xfffff000 0x1000>;
 			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
@@ -649,7 +658,7 @@
 			arm,shared-override;
 		};
 
-		mmc: dwmmc0@ff808000 {
+		mmc: mmc@ff808000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "altr,socfpga-dw-mshc";
@@ -662,7 +671,7 @@
 			status = "disabled";
 		};
 
-		nand: nand@ffb90000 {
+		nand: nand-controller@ffb90000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "altr,socfpga-denali-nand";
@@ -729,6 +738,16 @@
 					     <37 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			sdmmca-ecc@ff8c2c00 {
+				compatible = "altr,socfpga-sdmmc-ecc";
+				reg = <0xff8c2c00 0x400>;
+				altr,ecc-parent = <&mmc>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+					     <47 IRQ_TYPE_LEVEL_HIGH>,
+					     <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <48 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			dma-ecc@ff8c8000 {
 				compatible = "altr,socfpga-dma-ecc";
 				reg = <0xff8c8000 0x400>;
@@ -760,6 +779,11 @@
 			resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
 			reset-names = "qspi", "qspi-ocp";
 			status = "disabled";
+
+			flash@0 {
+				compatible = "jedec,spi-nor";
+				reg = <0x0>;
+			};
 		};
 
 		rst: rstmgr@ffd05000 {
@@ -828,7 +852,7 @@
 			reset-names = "timer";
 		};
 
-		uart0: serial0@ffc02000 {
+		uart0: serial@ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x100>;
 			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
@@ -839,7 +863,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial1@ffc02100 {
+		uart1: serial@ffc02100 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02100 0x100>;
 			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

