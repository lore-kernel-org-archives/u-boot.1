Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2C606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZaJYvCfz;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=LX3XltF4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 153B3810FC;
	Sat, 28 Nov 2026 13:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkbzbx8Qn9fm; Sat, 28 Nov 2026 13:12:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A22D081108
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871533;
	b=czZKgPuEyW2Iga8v8WlQXOOS8G75pfE6TKzxRUbCT5NYRaMrUKrRkUk0qEmh9SV8lZig
	 TAYkCIZfbVpj7NJlC2ltIB3t/0gwgL2flIH/7NqKq4gcQeWRZkZTNTErVU912I74SeCg/
	 O5THM5I+ppza62Yh0nh6oU0DU2oLrhS/vFP7a6MpkOOTE80neKZgav106V949Em/JnmYD
	 5UYp3SDoXpZgN93w0r5ttp92yoqonvLcNJ4hZQMMip9Scz12LIsh9XOWuH+fPrK4ezjTX
	 EZjK+2Y37GS7aErLv3Tx+MYQt/FlOf9isMam8gc5Iml5QuG/tsU0SC055WhrsSWfuBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871533;
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
	b=YGw2Q8NBtP2+mglldj3BDK06SP7O/KfmsUNtqGbQgklalDIiydid2K6rzeRdr/K4AmPm
	 dCH5DpvPezk10u9XXk2E0N2K6Z8ljLnjKTRCf0NT5QTFotEvw6NtBmunt9QOL9j5doGTE
	 1QH7QAIv4pPkmADBoMlEXtgnJpjspTGrOaHg59zkkF45Efdo4mOtqPs+ssR/UwfMMsJd8
	 Ln07CSbyKFVk22YGnbxMVJ71ghPcG+rVKPMK+60g0z03U44IE/YMlshbi6162lnSJv8KK
	 OTAj/2p+q8Rc5UNpkReUPXc7WMXOlQoVbwmHdTidt/t/44k7otHxqb+cBUmvkH2O+Og==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=LX3XltF4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871533;
	bh=JiGfoos7PUk0bJ6NVUVRXeAOA61vV9a+suVvuN2Xu+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZaJYvCfzIHt/HYujOl+4fXEeVhvY2tdIKO1sFhTZz0PX1c0zvrfnLqjQjmm3XozGD
	 mZY4fFORGF/e/+/U/vVo08r+ff/d/0TIQb5ev+ANKBaG0JZJUspw/4v5RyankzcieK
	 bOJlCCT0Tpx1Z0dEE8m0oA0oMVSnCFrAv9NJplhQsBGMRanftArnykZg4thgoJWhVH
	 BlcV1O/9AcUlpFuf65qPNDil/KA8jkLKlBE3fhO3QeWYkmWUVRYWWonpzJw0IAeIcB
	 IEZKf5vX/wJza6DmJwkEDrsVJdvYbM5OU1oYPubZE51Nr7h/7GopLeuVKdFuOv/MFH
	 yDPKoGKvDehIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A22D081108;
	Sat, 28 Nov 2026 13:12:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C4F4EBF4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B277B810C0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ORVNced8Nky for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4164D810DE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=LX3XltF4
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4164D810DE
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:58 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so84522215e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871517; x=1796476317;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JiGfoos7PUk0bJ6NVUVRXeAOA61vV9a+suVvuN2Xu+g=;
 b=LX3XltF4naoDzSEULy8ru3rYNIrqPx7KsT6WTFPSUImuUBwkQNk/KTcVh1sQ2VOWmQ
 s8f2FSLDLsemMIjhp7z+SwRuUcBUlBFU7tesUmu1GqOvf7atzJR5a6t8noYBzmeGgtZQ
 ywLSY97WdXT1aQRgMOJk7dYLkREPtbysdYgSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871517; x=1796476317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JiGfoos7PUk0bJ6NVUVRXeAOA61vV9a+suVvuN2Xu+g=;
 b=Ak1cnFrQecPo4yy2PfJ9wl3zCcYkznq+Tux3vayfEPV416dI272eV9ao97O4E1KS8e
 EIix1LYxSxaP9i6S9Ted9dWACKGcnduOOn01lX4vyDA4MunceM4wiyh+PHNh0U/8Vh+l
 sl3GxFsoAWsQs8avSL0F8gRxkE2f1GA18S3VbcrVljOQdpLVF8CwXKhdNm0ii9vkb1Tx
 7RYpygBix+vufEx6gwsCUgDLUstWzmQn368PqoBhQn8rEZJ1fGfUG0SJAiVMF9ob62cF
 lsFfsZndnZyfOzsY/XsAKIzynbQ1PiuDiaxJzjA4rdh2ciBOsC3CpkjOeg8wpNlgpsmD
 RF/w==
X-Forwarded-Encrypted: i=1;
 AL+hErHo+Zs7wV2mQfAyxSAqiNFyLeLIuV1Xk59dDOu0sxgQFYANKCw6eK46ZIC4AHq8w+ehMPPB00c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8GZ3I4bB9ucbuc0hIDPQoWdFX5yrXvrCckwcQ1nA/Qz+f/+Bij
 r0/KatgqFpt0DVQj1qSinxn9yKshu3pWuqsNxJBADuAsfx3r8jPJbYvo16GNL2a15ooswtW5NpM
 ktwAQ
X-Gm-Gg: AZFdTZc1OAvbVb5K5Wrv9UwgGTQ7VFLPea+KOToUQt+uhkAjNQuAlN2W9zivqOq+pgQ
 ik8lVm43UaNIcDZ02gBBonHPFTTJ5/r8FP/sg3MxNf9lFIJAHJIkc/l0/MTdV6nyesasMVstxHX
 +F+1zJPC+rldDF2ApAyZHShmOqkbzX/YIRMnzOmDj6iwIKyuozn9WBI0DGiXvpHyNPG2eYjWkgn
 FXhTyX9xadi9mzUX4vi5bog4UwUyXBnMB8T2UYCb6r7/gj/6g7odyeAXOYKCKFbA6mKILX37Gpy
 fDaqHo7RuwiGT6YpGZnKKUxQR/gocqvm6dy0Z/PMimvnvJLQArvcP7a00gH3Wx9t/TRpOqDDvJM
 TNRHWsYVZT1Xv3EHDj7BtDXMY6a4WezXqLRbB2gW6Cgg5+zTIxb61Zqffq0iIwHysRIXqmgHcvp
 5oCuBo9G3feQWRuBylVgU/+Yph265YOxjgEBNsDVbIubH1VYi/imI1LKJMAAQpkAbP1srnwvPRE
 HI6GIP1cnUC4kOpDDyJi/642sD1HTTSVJU6K58B3Jm6W9j90kVw7+AVtN1R+hTgzUW8uLWAYNmS
 IoigmMXEEZYhBlQ2FYDnm3pVgvnPAgjJEQhTAEoODhGbq5QMrmn3Ey24epG5OSfZbX3f7btAv/9
 lyTQfWoxOkiKYVES+w1FGPYYv3z7Gn+guIJu6mPEQ8QzaXSs+cQEf41ez3gUMyyAKWr0xLo4GdY
 fTj/5z3mnzf6IzbP2Yx87rORE81g==
X-Received: by 2002:a05:600c:154c:b0:4a2:729:f7ce with SMTP id
 5b1f17b1804b1-4bb8881c378mr558348815e9.8.1795871517125; 
 Sat, 28 Nov 2026 05:11:57 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 16/29] arm64: dts: st: move Engicam
 MicroGEA-STM32MP257D-RMM display to an overlay
Date: Sat, 28 Nov 2026 14:10:33 +0100
Message-ID: <20261128131125.2141352-17-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

