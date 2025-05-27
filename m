Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A26C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEF383830;
	Tue, 27 May 2025 15:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7WgFOmHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0E683830; Tue, 27 May 2025 15:30:08 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B808387E
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RBAFLM010253;
 Tue, 27 May 2025 15:30:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Db0GU2dIRDLOZkuzMdzfTaOKPUm4p07RQLpvCJek1FE=; b=7WgFOmHCDU4jMErq
 eJb6fTlHMpzIvRxjgHRi3P/FlPFRK0BdSvREXrP211PdNQHvIzygCxJPSqTMyHwn
 0biryhyQxBHxSd1PpHR6Mvojc+u4EWezEDmtm4sEm3FROrx/InY/EqujPip4STs8
 ZSGW3riSNiRG9/yVgTiDV0/9wbinC8tR2owMK6jDBCzOmfNuK1i0VH2eyHCX8Lf2
 g3jQZbrZP9HZPYQ4rsfUA2eXHD38YUVCd+okkTvO3HGV1ftrm5g4+nThJ/9OK6sq
 oHE0BdHKAq2HKW7gpFDOR4Xwt90heAjZmWGTgFOSSvVyJYrsn11v1yjqx+S+hfqH
 oRalsA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u50gkxwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:30:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 98CAA40056;
 Tue, 27 May 2025 15:29:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B35FAEC747;
 Tue, 27 May 2025 15:28:10 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:28:09 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/13] ARM: dts: stm32: switch from fixed to scmi clocks
 for stm32mp257f-ev1
Date: Tue, 27 May 2025 15:27:54 +0200
Message-ID: <20250527132755.2169508-13-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

SCMI clocks are now available, switch from fixed to SCMI clocks.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

(no changes since v1)

 arch/arm/dts/stm32mp25-u-boot.dtsi       |  8 +++
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi | 74 ------------------------
 2 files changed, 8 insertions(+), 74 deletions(-)

diff --git a/arch/arm/dts/stm32mp25-u-boot.dtsi b/arch/arm/dts/stm32mp25-u-boot.dtsi
index 0c8e95b3416..d9aeeb6d510 100644
--- a/arch/arm/dts/stm32mp25-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp25-u-boot.dtsi
@@ -25,6 +25,10 @@
 		optee {
 			bootph-all;
 		};
+
+		scmi {
+			bootph-all;
+		};
 	};
 
 	/* need PSCI for sysreset during board_f */
@@ -93,6 +97,10 @@
 	bootph-all;
 };
 
+&rcc {
+	bootph-all;
+};
+
 &rifsc {
 	bootph-all;
 };
diff --git a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
index d778b8d8d05..9a566e18d3f 100644
--- a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
@@ -10,84 +10,10 @@
 		u-boot,boot-led = "led-blue";
 		u-boot,mmc-env-partition = "u-boot-env";
 	};
-
-	clocks {
-		ck_flexgen_08: ck-flexgen-08 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <64000000>;
-		};
-
-		ck_flexgen_51: ck-flexgen-51 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-		};
-
-		ck_icn_ls_mcu: ck-icn-ls-mcu {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-		};
-	};
-};
-
-&gpioa {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpiob {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpioc {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpiod {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpioe {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpiof {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpiog {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpioh {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpioi {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpioj {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpiok {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&gpioz {
-	clocks = <&ck_icn_ls_mcu>;
-};
-
-&sdmmc1 {
-	clocks = <&ck_flexgen_51>;
-	/delete-property/resets;
 };
 
 &usart2 {
 	bootph-all;
-	clocks = <&ck_flexgen_08>;
 };
 
 &usart2_pins_a {
-- 
2.25.1

