Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4E1C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 15:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC55882C4;
	Sun, 19 May 2024 17:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ls7Xh/vT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1164F884A3; Sun, 19 May 2024 17:08:13 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C230B882C4
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 17:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e651a9f3ffso49141345ad.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716131289; x=1716736089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORxTS7tqVyUA4qe6oHu1E0MQhrVU+mQHWmhI1YmNdPk=;
 b=ls7Xh/vTn5xjwAYtTY1XJ3YN1ZCu1dypF6D8+0NLaLeRz3ZfdzHsqDzXwfc036nmGh
 HEcvxLM032xMTmBAqisti7XgPq+Rbdt36CpRSI8VnT9jLLcF3Fgxzavi46hzBhOilPq3
 3ROi62FILKpJ1z5H7VrBG8lt8zhVn7vD5nyYb6RINdKS8zmy30dFHXtrlVRuf/nFVcgy
 evRvZ7rWyieZRZrne+mPlg2yGLrUhBB7+2NX7E2HOewTi0ARF+H6nqbOR7jgrFrFEz4+
 90ivzGo0LtGwK3aq7tqdrb29679bfdFReSaeQxesb5AxYlof8iVw6z1sag+T4jFLhoPE
 u0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716131289; x=1716736089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORxTS7tqVyUA4qe6oHu1E0MQhrVU+mQHWmhI1YmNdPk=;
 b=ABdWeF8p01q8HYkneotOxje6pSlb6QAtOuyuMGvZ/ccpNiaBetmBIUFX+EZPKF1iyh
 r5KkvSf1ldUpnz1NZzoQFmK+ICm3rTcRfcqbUJZGPsavFa4RjyNH1pHulEfJJKv3yXAE
 02kxvodklX3v8wnzBI09k2fB5lefzMt2yahDT+bJp0wmcohJFbr7uVT+S95RSCiXj31M
 egmVI5ppN9KFc8MMWpALwAZKHufom0g8j8xgWvmiW7VTxMrM0dHIrpkHOgEeWE+3edUa
 9M47B57KknITmKC5b9oXaboBYNwt09CszmTRvbDFWFz36GmOyxmJMZtqfN5k0GOvtSEK
 X8nQ==
X-Gm-Message-State: AOJu0YwAK+QHMmZJKVUGdXuwheRZHnou7Aa2u3hXyxVTeySqJs2yCj7T
 fwSgiR0L08/HQM4SExOCJl4tkKpGP9anrOmmdU+MacLKnijnXKuZhbW8EoZSLbg=
X-Google-Smtp-Source: AGHT+IHbr7JsZqShAVvO3MIE2EjDd96zyXaCZFzVx0bZ3vFQgSlC8fZB26KOwkBGovOT296i3IUbFA==
X-Received: by 2002:a05:6a00:cc3:b0:6ed:cbe2:3bc8 with SMTP id
 d2e1a72fcca58-6f4e0347667mr30016420b3a.22.1716131288586; 
 Sun, 19 May 2024 08:08:08 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2b3493asm17692711b3a.191.2024.05.19.08.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 08:08:08 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] riscv: dts: sophgo: Replace device clocks with real
 clocks.
Date: Sun, 19 May 2024 23:07:10 +0800
Message-ID: <20240519150736.13203-5-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240519150736.13203-1-seashell11234455@gmail.com>
References: <20240519150736.13203-1-seashell11234455@gmail.com>
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

Replace device clocks with real clocks from the clock controller, and
remove dummy clocks.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 arch/riscv/dts/cv18xx.dtsi | 40 +++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
index 4b0143450e..8a7386b76e 100644
--- a/arch/riscv/dts/cv18xx.dtsi
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,cv1800.h>
 
 / {
 	#address-cells = <1>;
@@ -45,13 +46,6 @@
 		#clock-cells = <0>;
 	};
 
-	sdhci_clk: sdhci-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <375000000>;
-		clock-output-names = "sdhci_clk";
-		#clock-cells = <0>;
-	};
-
 	eth_csrclk: eth-csrclk {
 		compatible = "fixed-clock";
 		clock-frequency = <250000000>;
@@ -66,13 +60,6 @@
 		#clock-cells = <0x0>;
 	};
 
-	spif_clk: spi-flash-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <300000000>;
-		clock-output-names = "spif_clk";
-		#clock-cells = <0>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -163,8 +150,8 @@
 			compatible = "sophgo,cv1800b-dwmac";
 			reg = <0x04070000 0x10000>;
 			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&eth_csrclk>, <&eth_ptpclk>;
-			clock-names = "stmmaceth", "ptp_ref";
+			clocks = <&clk CLK_ETH0_500M>, <&clk CLK_AXI4_ETH0>;
+			clock-names = "stmmaceth", "pclk";
 			status = "disabled";
 		};
 
@@ -172,7 +159,8 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
 			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -182,7 +170,8 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04150000 0x100>;
 			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -192,7 +181,8 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04160000 0x100>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART2>, <&clk CLK_APB_UART2>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -202,7 +192,8 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04170000 0x100>;
 			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART3>, <&clk CLK_APB_UART3>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -212,7 +203,8 @@
 			compatible = "snps,dw-apb-uart";
 			reg = <0x041c0000 0x100>;
 			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -222,8 +214,8 @@
 			compatible = "sophgo,cv1800b-dwcmshc";
 			reg = <0x4310000 0x1000>;
 			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sdhci_clk>;
-			clock-names = "core";
+			clocks = <&clk CLK_AXI4_SD0>, <&clk CLK_SD0>;
+			clock-names = "core", "bus";
 			status = "disabled";
 		};
 
@@ -232,7 +224,7 @@
 			reg = <0x10000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			clocks = <&spif_clk>;
+			clocks = <&clk CLK_AHB_SF>;
 			interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
-- 
2.41.0

