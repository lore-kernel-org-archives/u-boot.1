Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DD7C7EE30
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 00:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F1983046;
	Mon, 30 Jun 2025 02:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x4fp4eSv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D4hCuLST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8516F83010; Mon, 30 Jun 2025 02:11:32 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13DF081FEE
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 02:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bVmm85SDcz9stG;
 Mon, 30 Jun 2025 02:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWVfB8ucDu8eQFcwOy2lsbl18zEyjgbEBDkaOR6EQE0=;
 b=x4fp4eSvoAMWykqthsszJSc7CqB3NDUi8FJMXLY/6BMu3/lncejP0sFaY//Xuxpbq/5Sy4
 Ca1YMrya2sNWq5gMMguAAASeOd2SA+0peNLRJuoENyJu6TgOjJ/WARbFP3JlzWuT9sHVXq
 iQW42u784Nz5FFvgprTdf9xKJrIU7kBhpzWiTrHY3TydKK/9W0PrBhyqvIfGGTpxdncS4F
 +hBeCKBg4DLls6PL5df8vBAl6kf/XwzhjtmdzxK6NIGqVMCwsJAmCFGlB4OmUeDBhdob7t
 oJ6kSKfnCZjb36WLaBp8OGJED7Y/JDXsWQgZB4vABalZoVBEvJP/phupo63Nyw==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWVfB8ucDu8eQFcwOy2lsbl18zEyjgbEBDkaOR6EQE0=;
 b=D4hCuLST775rmyNxrfKTlzw4Qiz5bCRt7hm5LULqqS2oGcRVTOq1x4RoBUv1XFcNWrIR2q
 A6wedy3BeJ2QxwRhsY1m6VukV2i0kmd0/iIPELXf8klKdB6xHjR21aDYK5gYpjr9mtoSLf
 hf7YBLvjqdk9u4woJCRJVlE/j293Gkzn4IOYjxz8VTBd/CEJ3vVyLhFOebkXC2H9UWOQj4
 Ry6pDFaB8PMz6LXKyZ3WoeJ5IcsG5Lc1PwsPDUQpq821+sfzFuAbqhCKFFjHTkQclO3INp
 6Jh8op8R9eR8rnpOqsq5iIR0X2phKTmFRAPxScsohoaSF3RA8Mp2dEfFyxqKFA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 08/10] ARM: dts: stm32: Add STM32MP13x SPL specific DT
 additions
Date: Mon, 30 Jun 2025 02:10:34 +0200
Message-ID: <20250630001053.952342-8-marek.vasut@mailbox.org>
In-Reply-To: <20250630001053.952342-1-marek.vasut@mailbox.org>
References: <20250630001053.952342-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 116uh7dxb9cr7wtpdhis5ehs69ufsepe
X-MBO-RS-ID: 25c63f41fe73a3c4443
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

Add DT additions required by U-Boot SPL to bring up the hardware.
This includes binman node to generate STM32 Image v2.0 which can be
booted by the BootROM, clock entries used by the SPL clock driver
during clock tree initialization, and syscon-reboot node so U-Boot
can reset the system without having to rely on PSCI call.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Cheick Traore <cheick.traore@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Lionel Debieve <lionel.debieve@foss.st.com>
Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Add RB from Patrice
---
 arch/arm/dts/stm32mp13-u-boot.dtsi | 89 ++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-u-boot.dtsi b/arch/arm/dts/stm32mp13-u-boot.dtsi
index 1fe6966781c..ad63d5027b2 100644
--- a/arch/arm/dts/stm32mp13-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp13-u-boot.dtsi
@@ -17,6 +17,7 @@
 		pinctrl0 = &pinctrl;
 	};
 
+#if defined(CONFIG_TFABOOT)
 	firmware {
 		optee {
 			bootph-all;
@@ -27,6 +28,86 @@
 	psci {
 		bootph-some-ram;
 	};
+#else
+	binman: binman {
+		multiple-images;
+
+		spl-stm32 {
+			filename = "u-boot-spl.stm32";
+			mkimage {
+				args = "-T stm32imagev2 -a 0x2ffe0000 -e 0x2ffe0000";
+				u-boot-spl {
+					no-write-symbols;
+				};
+			};
+		};
+	};
+
+	clocks {
+		bootph-all;
+
+		clk_hse: ck_hse {
+			bootph-all;
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		clk_hsi: ck_hsi {
+			bootph-all;
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <64000000>;
+		};
+
+		clk_lse: ck_lse {
+			bootph-all;
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		clk_lsi: ck_lsi {
+			bootph-all;
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+		};
+
+		clk_csi: ck_csi {
+			bootph-all;
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <4000000>;
+		};
+	};
+
+	cpu0_opp_table: cpu0-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+		bootph-pre-ram;
+		opp-650000000 {
+			bootph-pre-ram;
+			opp-hz = /bits/ 64 <650000000>;
+			opp-microvolt = <1200000>;
+			opp-supported-hw = <0x1>;
+		};
+		opp-1000000000 {
+			bootph-pre-ram;
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1350000>;
+			opp-supported-hw = <0x2>;
+		};
+	};
+
+	reboot {
+		bootph-all;
+		compatible = "syscon-reboot";
+		regmap = <&rcc>;
+		offset = <0x114>;
+		mask = <0x1>;
+	};
+#endif
 
 	soc {
 		bootph-all;
@@ -52,6 +133,14 @@
 	bootph-all;
 };
 
+#if !defined(CONFIG_TFABOOT)
+&cpu0 {
+	nvmem-cells = <&part_number_otp>;
+	nvmem-cell-names = "part_number";
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+#endif
+
 &gpioa {
 	bootph-all;
 };
-- 
2.47.2

