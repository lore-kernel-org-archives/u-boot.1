Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58CBD6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7798964E;
	Wed, 20 Nov 2024 01:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QO6SMGp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B1C88EEA; Tue, 19 Nov 2024 23:47:06 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BBB288D7E
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315dfa3e0bso4400815e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056418; x=1732661218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1DbdJx4HjCcpeSfXxC23Hyb//eM2usEzjMLWbd/NNg=;
 b=QO6SMGp3zdyMoRTYLx5rlw7rz8e4MN5CNtqEiQTg+6K7uA+lcP7no3zuVfgR757Sx0
 m0tY6uKDleEUUM+nQ6FB8lI6Mg8Hymn7/bYa2yv27V4aFsUxORhE3wqJ0dRxageRwXW7
 UxVkRRTV1+km5vd06VA2hFlkP3kNU7NWWbpiDi4SCEHWwvyCTFtV+Ko520X/bAWMTr6U
 ptNra0NxrWEgufLOqkYFZwjW7Y1HdLjsx/4utW6r2/f3Im4tFamr7CNkH0H5astpQQQh
 6c2k6Yy4COQUoVRQst3fujOJqn6poZwZnhNix6i4jDRT/YyJuxn8kTRAXTy/06JZ+y/K
 PfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056418; x=1732661218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1DbdJx4HjCcpeSfXxC23Hyb//eM2usEzjMLWbd/NNg=;
 b=c4aqjADf7xK5idi4foRJAqjsj/7yDJO8TrJBvVeCS3/6jVYdWWBOk9tki9MwYjzORJ
 bU+ecRn8MkjyKKna9mH51cUAL+aEqaCoj2zhSqHggPyPf3jE2DzlWC0MWJOvs5pY+Kt1
 p2XrLGi/wLpvsq6MqVaTWihBkP54jkz0/u8A/XhSR8MhZ9r0GRGhpvymgVxx1/oNFyjB
 q+0ZqKUwGuo1F6HLc+wsnZqW/2UFPpQ/kYEPWy4i2v/NZeD5MEj9B3xl2ujl39acxp9h
 K1hAUXqBlT8cPNGnGkM81ADMP7NW4eGTf0FNIqCB4Sb/eX9WcwSaF+mVMFY3B4/SwosU
 N3ow==
X-Gm-Message-State: AOJu0YzYMLfbRkhpCwsKK5f9v3+gi8mV3pwnALZgxy/7Lxf85rNaFYYU
 BR/vV0oTM0fJTEAo4ZeZetg4YDHc+kIl81PZNNvmD/T6vdAe5KOQf+JtYwO8
X-Gm-Gg: ASbGnctc1Rsp/ncRqcV0H153bgqyLj+i4zp/15XEaLX4hLG+xLABu3HLYc4oHw4qop5
 zIJ76l4aYbCzLkEI9RbHoEo0g93FMNPOItEcXdcBW6ywdh7l2TaLzNM2LrZKcu4S/q2RQ/H04QV
 hA2ymU5OJQEGbM5MJ3dxdjJdsoDlhCM409Jm0BoR9O8kFL5kx6fahip7gMLXmnUrtl/8fFjWFh9
 ClrRmVS7TWjPWQAKXlHLT5l3miHABnvnZCHZspi8I8FjwQYr5M/0B9wc4UCBvQNQzS5l5LmECxe
 wwsdTR8z2wO1GOmVCsf7uaJJLCRp
X-Google-Smtp-Source: AGHT+IHy4zKMfDeGu956Ze9WvZpYaooQOiiHN9wfwetrpTPgefeDe5WsULnyZsa8ExvaRJDvTY0lJA==
X-Received: by 2002:a05:600c:35d5:b0:431:5316:6752 with SMTP id
 5b1f17b1804b1-43348986a69mr2359005e9.2.1732056417758; 
 Tue, 19 Nov 2024 14:46:57 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:57 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 08/10] ARM: dts: arria10: update according to DTSpec
Date: Tue, 19 Nov 2024 22:46:41 +0000
Message-Id: <20241119224643.27692-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119224643.27692-1-l.rubusch@gmail.com>
References: <20241119224643.27692-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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
2.39.2

