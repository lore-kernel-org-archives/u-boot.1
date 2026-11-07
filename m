Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5320606A333
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y1P6kIQE;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=qiboJXgc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD5E181491;
	Sat,  7 Nov 2026 14:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7kQQE75885Wb; Sat,  7 Nov 2026 14:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48C1E816E2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062009;
	b=fu5s4tb95mPqgY1jTy0GHjDKsKnmou5LAtXlHg8J/4so1v7gDZtRDLEyDkVLF+qQUHdf
	 wSyKnLAuFsu0PyfiU4p3/XpC7GRJKL4PuygvrulpY9uaP5SaMREc+wQMxkWSZ6mfuYvby
	 K9kepsihXPg2WK4PQ9Ik4TIEQ4UP8k4pSv8JQDdcIi5Nc1bG+pXKlkpmULr/HoP30xGKj
	 EapS6aYXTdLiRApWUCB6iAex6hxoRW+TZqP+sKoT8fhlqQ1zOiFnBgnaCqFEsV0JJ1uHl
	 KGsY+pL9VfWhBSROFgUiKN9xCT0RvdlxK2gjzMKeo9SH2UrEWHn8V1gDsOjf9qeVMyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JiGfoos7PUk0bJ6NVUVRXeAOA61vV9a+suVvuN2Xu+g=;
	b=dqr5AMJvgs7VwKuTfwUvD+ZZFkc9xasWiUg0lRHz4lEHYe9LY58jcxiYotCBmQFmbZxP
	 D6Wji4/1GhL5WGYumhPJmVwLGazDt7rk7UuSs4djHyDapXzoiCygQNWZnE81617sTgzJb
	 Mv+1ez/STg0EK0VPULYt2b1fEitnS3aIYa+T/R4GdFhGhVZgrQbPcuUh35HSm/f+FRDy3
	 eKa96ytZ2LKkaJA2xd8TSMnlkGh9zM7xfzbv/ddwOoZ+TsERw5+8fQzWE+np6TKM/04WL
	 lwLBvOXS4q5w0ixN+cnGAhm75tYkqiFAWuP1tWF2qioaQ4RGFj8H0drWbgbDPMGP2rA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062009;
	bh=JiGfoos7PUk0bJ6NVUVRXeAOA61vV9a+suVvuN2Xu+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y1P6kIQEKG/5bOvQ1L7HIOOTDunePxPZpZ/qyVnNOXJ1UbR1flQjnV1iFkVj2K715
	 kRY3ZQizVk7RM70ej4JYnW2sPEGoC5sMDyJdum+JItkbeBmY2SlDRfk+tYUCDnG3y2
	 5V8J8qZ5LsvyaJQeN3dPapEerg53gep36wFT4RnaFp6xCoD6V6qC9CjE3qCRMqkXce
	 immaAkVy1ocaZQKW0iHPpoWMUeOoZXWKDRXj4R9fNvC2gF6b5dp23cLFQ8we2wcRkb
	 KHKPZotNKMwDGLTUBpSOJW8EpY65DYnc1q5MP9a9o36dUMcVI11KwhwnczBr0gPcNy
	 FMlgrgH1I1yVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48C1E816E2;
	Sat,  7 Nov 2026 14:33:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79B5834D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AA964075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rEuvc7OAi8NE for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 25F4C40757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=qiboJXgc
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25F4C40757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:20 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1684044f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061998; x=1794666798;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JiGfoos7PUk0bJ6NVUVRXeAOA61vV9a+suVvuN2Xu+g=;
 b=qiboJXgctoOsTMNBc6v3bqlH3XpfTEzrrfSHGgGFNGgqusKEWzGNU/u8gvlY88gNPn
 +wDta9EYnNFIDWhOUgI9HxmpjQaxr+1G8b6BXzHmOKiYblhlwuyNuX5zQtccP971pZoM
 Pvs+uAm75JZ9f9o20E11TYoPWkaQjKcmZNSaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061998; x=1794666798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JiGfoos7PUk0bJ6NVUVRXeAOA61vV9a+suVvuN2Xu+g=;
 b=BgCaS7hS6EDTLKgrHdrEtqCAcviRSUxeaW0obtl4i3kRUxaG/Ecmio9W5/pa1TK0My
 nboQEHJDmXaouSHi+9Mz6xB6HPy2+oFI6lFrgQaMS1JoN4/n/39XpTnN+wAWMNk/pvjs
 lX/FXbyYAttBTxo5MUi18oS6MBtSjFK8j+XwU7rpB7SWtG3/yB9YLITmW2FWl4asJJYj
 Fsl5wQK7oqSgVD6cVO/OywzmejFAJ2UTWDIDAxZ0kfesZVDUWn66iii0bZtrO9naGkNd
 2zSLdZH0tcE1wlrmEc/9VvPMr/JTMwrKi+VoO0oN4Gj2FHF7Wpiqknlt3kSoCdMTxXVe
 A+4A==
X-Forwarded-Encrypted: i=1;
 AL+hErHU79oGI2h3QzmWwCh7u5VlZhijn4ykEuTxuCDCyp1aTLrFprc0kYpJa68n28+bhZ5wq+NKLac=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/LPb1FTZzKjzoL8tXTPHoOn3s7kfJNIqb0CQ6Q1oJHVPjW4eTE
 FKbDQlJ17IYlrFn5Jva4i7j6j8uW8ACdigiBXbtiA7oK9Sm/zd26K6Aeh+wlHNweIZQ=
X-Gm-Gg: AYBFou08s+Ms60d3vKXwZV4kXY9MUmy5jbgaLeX7ec/cI4s79JLNy+F4KBsMD1miyvs
 cE5q1XPhrbMslRNCasALQRaor172lJaTvsL3njn9I+9XeARvxFPm6/eA+aFr/1d58pAmhyjXVIx
 jWLAtuBXQbskL/dqBb6r40wlgbF8s+1//hB+oQGZXprKauTdFtoIxzGNwreDbnUW0aBQlHpQns/
 KcxZgEhvp7jbTpn2/8Da+ziVufCpJ4q0zSGj7UndVGXbscUyWCQxoS8si1AMcsRJSiGQJ+9N4mU
 Y5z3DCVjG8VcdU2k2Dfcp+IZXgdyaSUudCuXOh8tJ+IHX15crfBwasr/hqTJtohKckVAT6qQnrS
 XLgtVAyBDpcrMj6lc0Pud26dzHDhxIRfm/W1ttsBYzmZgYH8GQITmrVmxfC6eCYfpN/eVrnukRd
 DkyLRhGKOdusoIiNk7yVCO6GcutAW6D33+82VnYg9pXIG3ypBngoRkBBPdcjY3/SkHqn4Y4b6hb
 wIIH/AxnF031cpNeuIpdEoNt9UeQZ5Xk2u3KLvfT9LvjEUKkhvI7Ib8izMoyHbW0rsHTcpKcvoX
 QhOtImYc04tUTIwnP8upVgO9BfYLNx8FTGf4UnNAfy9WL7isEage4uVzEG63kz+O/8usMY8rwH2
 vkhTbKWeFgRSuEhB5r/yzbzPj5UOqvpmVfZUPBG4PkfIVjC/mGfBYpTknGbGJFjUn2euZg1vc2Y
 Li4MLIWe4siY8HYs8OLb5KivcU0yPRZP5Sk6mcaN4MnQUX2cQ=
X-Received: by 2002:a05:6000:4914:b0:48f:bcdf:6f83 with SMTP id
 ffacd0b85a97d-4927678e028mr9479106f8f.22.1794061998501; 
 Sat, 07 Nov 2026 06:33:18 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:18 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 16/35] arm64: dts: st: move Engicam
 MicroGEA-STM32MP257D-RMM display to an overlay
Date: Sat,  7 Nov 2026 15:32:06 +0100
Message-ID: <20261107143241.2236511-17-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The board is fitted with different displays depending on the product
variant. Keep in the board dts only what is common to all variants and
move the RK050HR345-CT106A RGB panel and its touchscreen to an overlay.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260923155333.610134-2-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: c82d6c52a2514b0a5a7968b6fed8ff212b80e5e1 ]

(cherry picked from commit 8fbbd1cc0edb754a6653ec4af418e02887cb3bdb)
---

(no changes since v1)

 ...icrogea-rmm-overlay-rk050hr345-ct106a.dtso | 68 +++++++++++++++++++
 .../st/stm32mp257d-engicam-microgea-rmm.dts   | 46 +------------
 2 files changed, 69 insertions(+), 45 deletions(-)
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso

diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso
new file mode 100644
index 000000000000..f89641bdb23b
--- /dev/null
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ *
+ * Rocktech RK050HR345-CT106A 5" 480x854 RGB panel with EDT FT5306
+ * I2C touchscreen controller.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+		interrupt-parent = <&gpiob>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpiod 1 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <854>;
+	};
+};
+
+&ltdc {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-1 = <&ltdc_sleep_pins_a>;
+	status = "okay";
+
+	port {
+		ltdc_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&spi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	display@0 {
+		compatible = "rocktech,rk050hr345-ct106a", "ilitek,ili9806e";
+		reg = <0>;
+		vdd-supply = <&reg_3v3>;
+		spi-max-frequency = <10000000>;
+		reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&ltdc_out>;
+			};
+		};
+	};
+};
diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
index f5af0913bf1b..faedddc2c914 100644
--- a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
@@ -116,25 +116,9 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&i2c1_pins_a>;
-	pinctrl-1 = <&i2c1_sleep_pins_a>;
-	i2c-scl-rising-time-ns = <185>;
-	i2c-scl-falling-time-ns = <20>;
-	status = "okay";
-	/* spare dmas for other usage */
+	/* dt overlays don't support /delete-property/ */
 	/delete-property/dmas;
 	/delete-property/dma-names;
-
-	touchscreen@38 {
-		compatible = "edt,edt-ft5306";
-		reg = <0x38>;
-		interrupt-parent = <&gpiob>;
-		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&gpiod 1 GPIO_ACTIVE_LOW>;
-		touchscreen-size-x = <480>;
-		touchscreen-size-y = <854>;
-	};
 };
 
 &i2c2 {
@@ -179,19 +163,6 @@
 	};
 };
 
-&ltdc {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&ltdc_pins_a>;
-	pinctrl-1 = <&ltdc_sleep_pins_a>;
-	status = "okay";
-
-	port {
-		ltdc_out: endpoint {
-			remote-endpoint = <&panel_in>;
-		};
-	};
-};
-
 &m_can1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&m_can1_pins_a>;
@@ -259,21 +230,6 @@
 	#size-cells = <0>;
 	cs-gpios = <&gpioh 8 GPIO_ACTIVE_LOW>, <&gpioh 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-
-	display: display@0 {
-		compatible = "rocktech,rk050hr345-ct106a", "ilitek,ili9806e";
-		reg = <0>;
-		vdd-supply = <&reg_3v3>;
-		spi-max-frequency = <10000000>;
-		reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
-		backlight = <&backlight>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&ltdc_out>;
-			};
-		};
-	};
 };
 
 &timers2 {
-- 
2.43.0

