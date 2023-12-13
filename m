Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF198C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5FC8782F;
	Wed, 13 Dec 2023 04:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YEvt2R9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A27887800; Wed, 13 Dec 2023 04:16:58 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE9C871AA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5906df1d2adso2718662eaf.2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437410; x=1703042210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULO/u27h7ZICBjDQ/p+yNKH2bw1pKzo+6dr1prynD90=;
 b=YEvt2R9gxmUdFy6lQf9f607mt2VufxiMqYHa3UF3HwNZahO/YKXlL+mtJ5aQMmrzkM
 8+H5bOiq9hXI21m0oUMK+Fu83YbOpUkv0WSDMVhZrY2YkVnjWy49PurJVhKMTuhz9WHy
 Kw9HCF/YDNS76oIK37L7jguYeVcdWH0iBW9q+UButghFLF/SPz4yyhXWLBHxWzHDdz8K
 oiAP25zRGuv4F8qjS/uQ/JPBQ0cJqgO+fqp85vOkNnwQ4A8D88V64gUKISbv16A2EWDE
 phswZPhReG5XsUyIucCYvlDEI9BpX19BHnXuXkLwRpgayU7K6tIF+aCXSvUQbdC8bKQZ
 Xmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437410; x=1703042210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULO/u27h7ZICBjDQ/p+yNKH2bw1pKzo+6dr1prynD90=;
 b=L6K6DKYWpUyUXMUgp3Q5aG2V9hFywirgN/FPIDyg4k96fMRm/iWxyYa1CH6G6oCaBD
 xS6N4+2AN1/S8ufrDyi2YFUn6kG3L2qADou3jcFkBEyvakzbUCUWfGH40FVUUQxAqYnM
 zZZxRYSe0Io1Wmi5KrZgANTam20gzfCRFjUZ/p7v7NKkcHiH6qNRXDoJgBnKlGR4Oo5j
 5Qd5XKLffm0yaufbHgkHguovW14whj7qRQPsSl4d6EsM6NdoodfW83JwoyXsd+XITvuD
 1kVcsacjUS+hQL7yo6xpuI0SZ8SzltYw9TngkCc0wWLWTiLwFiXYFcwCHLavc1DdCOaW
 0YYA==
X-Gm-Message-State: AOJu0YyOcaA5EUYy/3xCKnpp44gpw2DdGBV6yzfB5N8Wqs7S9xGmJ11n
 3sfsxZ9vFmWRjSxOMDhPomEIBQ==
X-Google-Smtp-Source: AGHT+IHtY52sYumKiUloNkX1se3XeDyj8twdi94ij2ZPVMHNVIX/gPOseHeNwhDuDhn03jyJ9/HwVg==
X-Received: by 2002:a05:6870:1487:b0:1fa:e0df:600d with SMTP id
 k7-20020a056870148700b001fae0df600dmr4479500oab.9.1702437409943; 
 Tue, 12 Dec 2023 19:16:49 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 fr19-20020a056870f81300b001faf0485626sm3695294oab.11.2023.12.12.19.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:49 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 03/13] dt-bindings: clock: Add Exynos850 clock controller
Date: Tue, 12 Dec 2023 21:16:36 -0600
Message-Id: <20231213031646.28828-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
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

Add bindings documentation and the header file for Exynos850 clock
controller. It was taken from Linux kernel [1,2].

[1] Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
[2] include/dt-bindings/clock/exynos850.h

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../clock/samsung,exynos850-clock.yaml        | 307 ++++++++++++++++
 include/dt-bindings/clock/exynos850.h         | 337 ++++++++++++++++++
 2 files changed, 644 insertions(+)
 create mode 100644 doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
 create mode 100644 include/dt-bindings/clock/exynos850.h

diff --git a/doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml b/doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
new file mode 100644
index 000000000000..a0906efe1223
--- /dev/null
+++ b/doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
@@ -0,0 +1,307 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos850-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos850 SoC clock controller
+
+maintainers:
+  - Sam Protsenko <semen.protsenko@linaro.org>
+
+description: |
+  Exynos850 clock controller is comprised of several CMU units, generating
+  clocks for different domains. Those CMU units are modeled as separate device
+  tree nodes, and might depend on each other. Root clocks in that clock tree are
+  two external clocks:: OSCCLK (26 MHz) and RTCCLK (32768 Hz). Those external
+  clocks must be defined as fixed-rate clocks in dts.
+
+  CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
+  dividers; all other leaf clocks (other CMUs) are usually derived from CMU_TOP.
+
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All clocks available for usage
+  in clock consumer nodes are defined as preprocessor macros in
+  'dt-bindings/clock/exynos850.h' header.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos850-cmu-top
+      - samsung,exynos850-cmu-apm
+      - samsung,exynos850-cmu-aud
+      - samsung,exynos850-cmu-cmgp
+      - samsung,exynos850-cmu-core
+      - samsung,exynos850-cmu-dpu
+      - samsung,exynos850-cmu-g3d
+      - samsung,exynos850-cmu-hsi
+      - samsung,exynos850-cmu-is
+      - samsung,exynos850-cmu-mfcmscl
+      - samsung,exynos850-cmu-peri
+
+  clocks:
+    minItems: 1
+    maxItems: 5
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-top
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+
+        clock-names:
+          items:
+            - const: oscclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-apm
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_APM bus clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_clkcmu_apm_bus
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-aud
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: AUD clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_aud
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-cmgp
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_CMGP bus clock (from CMU_APM)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: gout_clkcmu_cmgp_bus
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-core
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_CORE bus clock (from CMU_TOP)
+            - description: CCI clock (from CMU_TOP)
+            - description: eMMC clock (from CMU_TOP)
+            - description: SSS clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_core_bus
+            - const: dout_core_cci
+            - const: dout_core_mmc_embd
+            - const: dout_core_sss
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-dpu
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: DPU clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_dpu
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-g3d
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: G3D clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_g3d_switch
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-hsi
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: External RTC clock (32768 Hz)
+            - description: CMU_HSI bus clock (from CMU_TOP)
+            - description: SD card clock (from CMU_TOP)
+            - description: USB 2.0 DRD clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: rtcclk
+            - const: dout_hsi_bus
+            - const: dout_hsi_mmc_card
+            - const: dout_hsi_usb20drd
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-is
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_IS bus clock (from CMU_TOP)
+            - description: Image Texture Processing core clock (from CMU_TOP)
+            - description: Visual Recognition Accelerator clock (from CMU_TOP)
+            - description: Geometric Distortion Correction clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_is_bus
+            - const: dout_is_itp
+            - const: dout_is_vra
+            - const: dout_is_gdc
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-mfcmscl
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: Multi-Format Codec clock (from CMU_TOP)
+            - description: Memory to Memory Scaler clock (from CMU_TOP)
+            - description: Multi-Channel Scaler clock (from CMU_TOP)
+            - description: JPEG codec clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_mfcmscl_mfc
+            - const: dout_mfcmscl_m2m
+            - const: dout_mfcmscl_mcsc
+            - const: dout_mfcmscl_jpeg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-peri
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_PERI bus clock (from CMU_TOP)
+            - description: UART clock (from CMU_TOP)
+            - description: Parent clock for HSI2C and SPI (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_peri_bus
+            - const: dout_peri_uart
+            - const: dout_peri_ip
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - reg
+
+additionalProperties: false
+
+examples:
+  # Clock controller node for CMU_PERI
+  - |
+    #include <dt-bindings/clock/exynos850.h>
+
+    cmu_peri: clock-controller@10030000 {
+        compatible = "samsung,exynos850-cmu-peri";
+        reg = <0x10030000 0x8000>;
+        #clock-cells = <1>;
+
+        clocks = <&oscclk>, <&cmu_top CLK_DOUT_PERI_BUS>,
+                 <&cmu_top CLK_DOUT_PERI_UART>,
+                 <&cmu_top CLK_DOUT_PERI_IP>;
+        clock-names = "oscclk", "dout_peri_bus",
+                      "dout_peri_uart", "dout_peri_ip";
+    };
+
+...
diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
new file mode 100644
index 000000000000..3090e09c9a55
--- /dev/null
+++ b/include/dt-bindings/clock/exynos850.h
@@ -0,0 +1,337 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Device Tree binding constants for Exynos850 clock controller.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_EXYNOS_850_H
+#define _DT_BINDINGS_CLOCK_EXYNOS_850_H
+
+/* CMU_TOP */
+#define CLK_FOUT_SHARED0_PLL		1
+#define CLK_FOUT_SHARED1_PLL		2
+#define CLK_FOUT_MMC_PLL		3
+#define CLK_MOUT_SHARED0_PLL		4
+#define CLK_MOUT_SHARED1_PLL		5
+#define CLK_MOUT_MMC_PLL		6
+#define CLK_MOUT_CORE_BUS		7
+#define CLK_MOUT_CORE_CCI		8
+#define CLK_MOUT_CORE_MMC_EMBD		9
+#define CLK_MOUT_CORE_SSS		10
+#define CLK_MOUT_DPU			11
+#define CLK_MOUT_HSI_BUS		12
+#define CLK_MOUT_HSI_MMC_CARD		13
+#define CLK_MOUT_HSI_USB20DRD		14
+#define CLK_MOUT_PERI_BUS		15
+#define CLK_MOUT_PERI_UART		16
+#define CLK_MOUT_PERI_IP		17
+#define CLK_DOUT_SHARED0_DIV3		18
+#define CLK_DOUT_SHARED0_DIV2		19
+#define CLK_DOUT_SHARED1_DIV3		20
+#define CLK_DOUT_SHARED1_DIV2		21
+#define CLK_DOUT_SHARED0_DIV4		22
+#define CLK_DOUT_SHARED1_DIV4		23
+#define CLK_DOUT_CORE_BUS		24
+#define CLK_DOUT_CORE_CCI		25
+#define CLK_DOUT_CORE_MMC_EMBD		26
+#define CLK_DOUT_CORE_SSS		27
+#define CLK_DOUT_DPU			28
+#define CLK_DOUT_HSI_BUS		29
+#define CLK_DOUT_HSI_MMC_CARD		30
+#define CLK_DOUT_HSI_USB20DRD		31
+#define CLK_DOUT_PERI_BUS		32
+#define CLK_DOUT_PERI_UART		33
+#define CLK_DOUT_PERI_IP		34
+#define CLK_GOUT_CORE_BUS		35
+#define CLK_GOUT_CORE_CCI		36
+#define CLK_GOUT_CORE_MMC_EMBD		37
+#define CLK_GOUT_CORE_SSS		38
+#define CLK_GOUT_DPU			39
+#define CLK_GOUT_HSI_BUS		40
+#define CLK_GOUT_HSI_MMC_CARD		41
+#define CLK_GOUT_HSI_USB20DRD		42
+#define CLK_GOUT_PERI_BUS		43
+#define CLK_GOUT_PERI_UART		44
+#define CLK_GOUT_PERI_IP		45
+#define CLK_MOUT_CLKCMU_APM_BUS		46
+#define CLK_DOUT_CLKCMU_APM_BUS		47
+#define CLK_GOUT_CLKCMU_APM_BUS		48
+#define CLK_MOUT_AUD			49
+#define CLK_GOUT_AUD			50
+#define CLK_DOUT_AUD			51
+#define CLK_MOUT_IS_BUS			52
+#define CLK_MOUT_IS_ITP			53
+#define CLK_MOUT_IS_VRA			54
+#define CLK_MOUT_IS_GDC			55
+#define CLK_GOUT_IS_BUS			56
+#define CLK_GOUT_IS_ITP			57
+#define CLK_GOUT_IS_VRA			58
+#define CLK_GOUT_IS_GDC			59
+#define CLK_DOUT_IS_BUS			60
+#define CLK_DOUT_IS_ITP			61
+#define CLK_DOUT_IS_VRA			62
+#define CLK_DOUT_IS_GDC			63
+#define CLK_MOUT_MFCMSCL_MFC		64
+#define CLK_MOUT_MFCMSCL_M2M		65
+#define CLK_MOUT_MFCMSCL_MCSC		66
+#define CLK_MOUT_MFCMSCL_JPEG		67
+#define CLK_GOUT_MFCMSCL_MFC		68
+#define CLK_GOUT_MFCMSCL_M2M		69
+#define CLK_GOUT_MFCMSCL_MCSC		70
+#define CLK_GOUT_MFCMSCL_JPEG		71
+#define CLK_DOUT_MFCMSCL_MFC		72
+#define CLK_DOUT_MFCMSCL_M2M		73
+#define CLK_DOUT_MFCMSCL_MCSC		74
+#define CLK_DOUT_MFCMSCL_JPEG		75
+#define CLK_MOUT_G3D_SWITCH		76
+#define CLK_GOUT_G3D_SWITCH		77
+#define CLK_DOUT_G3D_SWITCH		78
+
+/* CMU_APM */
+#define CLK_RCO_I3C_PMIC		1
+#define OSCCLK_RCO_APM			2
+#define CLK_RCO_APM__ALV		3
+#define CLK_DLL_DCO			4
+#define CLK_MOUT_APM_BUS_USER		5
+#define CLK_MOUT_RCO_APM_I3C_USER	6
+#define CLK_MOUT_RCO_APM_USER		7
+#define CLK_MOUT_DLL_USER		8
+#define CLK_MOUT_CLKCMU_CHUB_BUS	9
+#define CLK_MOUT_APM_BUS		10
+#define CLK_MOUT_APM_I3C		11
+#define CLK_DOUT_CLKCMU_CHUB_BUS	12
+#define CLK_DOUT_APM_BUS		13
+#define CLK_DOUT_APM_I3C		14
+#define CLK_GOUT_CLKCMU_CMGP_BUS	15
+#define CLK_GOUT_CLKCMU_CHUB_BUS	16
+#define CLK_GOUT_RTC_PCLK		17
+#define CLK_GOUT_TOP_RTC_PCLK		18
+#define CLK_GOUT_I3C_PCLK		19
+#define CLK_GOUT_I3C_SCLK		20
+#define CLK_GOUT_SPEEDY_PCLK		21
+#define CLK_GOUT_GPIO_ALIVE_PCLK	22
+#define CLK_GOUT_PMU_ALIVE_PCLK		23
+#define CLK_GOUT_SYSREG_APM_PCLK	24
+
+/* CMU_AUD */
+#define CLK_DOUT_AUD_AUDIF		1
+#define CLK_DOUT_AUD_BUSD		2
+#define CLK_DOUT_AUD_BUSP		3
+#define CLK_DOUT_AUD_CNT		4
+#define CLK_DOUT_AUD_CPU		5
+#define CLK_DOUT_AUD_CPU_ACLK		6
+#define CLK_DOUT_AUD_CPU_PCLKDBG	7
+#define CLK_DOUT_AUD_FM			8
+#define CLK_DOUT_AUD_FM_SPDY		9
+#define CLK_DOUT_AUD_MCLK		10
+#define CLK_DOUT_AUD_UAIF0		11
+#define CLK_DOUT_AUD_UAIF1		12
+#define CLK_DOUT_AUD_UAIF2		13
+#define CLK_DOUT_AUD_UAIF3		14
+#define CLK_DOUT_AUD_UAIF4		15
+#define CLK_DOUT_AUD_UAIF5		16
+#define CLK_DOUT_AUD_UAIF6		17
+#define CLK_FOUT_AUD_PLL		18
+#define CLK_GOUT_AUD_ABOX_ACLK		19
+#define CLK_GOUT_AUD_ASB_CCLK		20
+#define CLK_GOUT_AUD_CA32_CCLK		21
+#define CLK_GOUT_AUD_CNT_BCLK		22
+#define CLK_GOUT_AUD_CODEC_MCLK		23
+#define CLK_GOUT_AUD_DAP_CCLK		24
+#define CLK_GOUT_AUD_GPIO_PCLK		25
+#define CLK_GOUT_AUD_PPMU_ACLK		26
+#define CLK_GOUT_AUD_PPMU_PCLK		27
+#define CLK_GOUT_AUD_SPDY_BCLK		28
+#define CLK_GOUT_AUD_SYSMMU_CLK		29
+#define CLK_GOUT_AUD_SYSREG_PCLK	30
+#define CLK_GOUT_AUD_TZPC_PCLK		31
+#define CLK_GOUT_AUD_UAIF0_BCLK		32
+#define CLK_GOUT_AUD_UAIF1_BCLK		33
+#define CLK_GOUT_AUD_UAIF2_BCLK		34
+#define CLK_GOUT_AUD_UAIF3_BCLK		35
+#define CLK_GOUT_AUD_UAIF4_BCLK		36
+#define CLK_GOUT_AUD_UAIF5_BCLK		37
+#define CLK_GOUT_AUD_UAIF6_BCLK		38
+#define CLK_GOUT_AUD_WDT_PCLK		39
+#define CLK_MOUT_AUD_CPU		40
+#define CLK_MOUT_AUD_CPU_HCH		41
+#define CLK_MOUT_AUD_CPU_USER		42
+#define CLK_MOUT_AUD_FM			43
+#define CLK_MOUT_AUD_PLL		44
+#define CLK_MOUT_AUD_TICK_USB_USER	45
+#define CLK_MOUT_AUD_UAIF0		46
+#define CLK_MOUT_AUD_UAIF1		47
+#define CLK_MOUT_AUD_UAIF2		48
+#define CLK_MOUT_AUD_UAIF3		49
+#define CLK_MOUT_AUD_UAIF4		50
+#define CLK_MOUT_AUD_UAIF5		51
+#define CLK_MOUT_AUD_UAIF6		52
+#define IOCLK_AUDIOCDCLK0		53
+#define IOCLK_AUDIOCDCLK1		54
+#define IOCLK_AUDIOCDCLK2		55
+#define IOCLK_AUDIOCDCLK3		56
+#define IOCLK_AUDIOCDCLK4		57
+#define IOCLK_AUDIOCDCLK5		58
+#define IOCLK_AUDIOCDCLK6		59
+#define TICK_USB			60
+#define CLK_GOUT_AUD_CMU_AUD_PCLK	61
+
+/* CMU_CMGP */
+#define CLK_RCO_CMGP			1
+#define CLK_MOUT_CMGP_ADC		2
+#define CLK_MOUT_CMGP_USI0		3
+#define CLK_MOUT_CMGP_USI1		4
+#define CLK_DOUT_CMGP_ADC		5
+#define CLK_DOUT_CMGP_USI0		6
+#define CLK_DOUT_CMGP_USI1		7
+#define CLK_GOUT_CMGP_ADC_S0_PCLK	8
+#define CLK_GOUT_CMGP_ADC_S1_PCLK	9
+#define CLK_GOUT_CMGP_GPIO_PCLK		10
+#define CLK_GOUT_CMGP_USI0_IPCLK	11
+#define CLK_GOUT_CMGP_USI0_PCLK		12
+#define CLK_GOUT_CMGP_USI1_IPCLK	13
+#define CLK_GOUT_CMGP_USI1_PCLK		14
+#define CLK_GOUT_SYSREG_CMGP_PCLK	15
+
+/* CMU_G3D */
+#define CLK_FOUT_G3D_PLL		1
+#define CLK_MOUT_G3D_PLL		2
+#define CLK_MOUT_G3D_SWITCH_USER	3
+#define CLK_MOUT_G3D_BUSD		4
+#define CLK_DOUT_G3D_BUSP		5
+#define CLK_GOUT_G3D_CMU_G3D_PCLK	6
+#define CLK_GOUT_G3D_GPU_CLK		7
+#define CLK_GOUT_G3D_TZPC_PCLK		8
+#define CLK_GOUT_G3D_GRAY2BIN_CLK	9
+#define CLK_GOUT_G3D_BUSD_CLK		10
+#define CLK_GOUT_G3D_BUSP_CLK		11
+#define CLK_GOUT_G3D_SYSREG_PCLK	12
+
+/* CMU_HSI */
+#define CLK_MOUT_HSI_BUS_USER		1
+#define CLK_MOUT_HSI_MMC_CARD_USER	2
+#define CLK_MOUT_HSI_USB20DRD_USER	3
+#define CLK_MOUT_HSI_RTC		4
+#define CLK_GOUT_USB_RTC_CLK		5
+#define CLK_GOUT_USB_REF_CLK		6
+#define CLK_GOUT_USB_PHY_REF_CLK	7
+#define CLK_GOUT_USB_PHY_ACLK		8
+#define CLK_GOUT_USB_BUS_EARLY_CLK	9
+#define CLK_GOUT_GPIO_HSI_PCLK		10
+#define CLK_GOUT_MMC_CARD_ACLK		11
+#define CLK_GOUT_MMC_CARD_SDCLKIN	12
+#define CLK_GOUT_SYSREG_HSI_PCLK	13
+#define CLK_GOUT_HSI_PPMU_ACLK		14
+#define CLK_GOUT_HSI_PPMU_PCLK		15
+#define CLK_GOUT_HSI_CMU_HSI_PCLK	16
+
+/* CMU_IS */
+#define CLK_MOUT_IS_BUS_USER		1
+#define CLK_MOUT_IS_ITP_USER		2
+#define CLK_MOUT_IS_VRA_USER		3
+#define CLK_MOUT_IS_GDC_USER		4
+#define CLK_DOUT_IS_BUSP		5
+#define CLK_GOUT_IS_CMU_IS_PCLK		6
+#define CLK_GOUT_IS_CSIS0_ACLK		7
+#define CLK_GOUT_IS_CSIS1_ACLK		8
+#define CLK_GOUT_IS_CSIS2_ACLK		9
+#define CLK_GOUT_IS_TZPC_PCLK		10
+#define CLK_GOUT_IS_CSIS_DMA_CLK	11
+#define CLK_GOUT_IS_GDC_CLK		12
+#define CLK_GOUT_IS_IPP_CLK		13
+#define CLK_GOUT_IS_ITP_CLK		14
+#define CLK_GOUT_IS_MCSC_CLK		15
+#define CLK_GOUT_IS_VRA_CLK		16
+#define CLK_GOUT_IS_PPMU_IS0_ACLK	17
+#define CLK_GOUT_IS_PPMU_IS0_PCLK	18
+#define CLK_GOUT_IS_PPMU_IS1_ACLK	19
+#define CLK_GOUT_IS_PPMU_IS1_PCLK	20
+#define CLK_GOUT_IS_SYSMMU_IS0_CLK	21
+#define CLK_GOUT_IS_SYSMMU_IS1_CLK	22
+#define CLK_GOUT_IS_SYSREG_PCLK		23
+
+/* CMU_MFCMSCL */
+#define CLK_MOUT_MFCMSCL_MFC_USER		1
+#define CLK_MOUT_MFCMSCL_M2M_USER		2
+#define CLK_MOUT_MFCMSCL_MCSC_USER		3
+#define CLK_MOUT_MFCMSCL_JPEG_USER		4
+#define CLK_DOUT_MFCMSCL_BUSP			5
+#define CLK_GOUT_MFCMSCL_CMU_MFCMSCL_PCLK	6
+#define CLK_GOUT_MFCMSCL_TZPC_PCLK		7
+#define CLK_GOUT_MFCMSCL_JPEG_ACLK		8
+#define CLK_GOUT_MFCMSCL_M2M_ACLK		9
+#define CLK_GOUT_MFCMSCL_MCSC_CLK		10
+#define CLK_GOUT_MFCMSCL_MFC_ACLK		11
+#define CLK_GOUT_MFCMSCL_PPMU_ACLK		12
+#define CLK_GOUT_MFCMSCL_PPMU_PCLK		13
+#define CLK_GOUT_MFCMSCL_SYSMMU_CLK		14
+#define CLK_GOUT_MFCMSCL_SYSREG_PCLK		15
+
+/* CMU_PERI */
+#define CLK_MOUT_PERI_BUS_USER		1
+#define CLK_MOUT_PERI_UART_USER		2
+#define CLK_MOUT_PERI_HSI2C_USER	3
+#define CLK_MOUT_PERI_SPI_USER		4
+#define CLK_DOUT_PERI_HSI2C0		5
+#define CLK_DOUT_PERI_HSI2C1		6
+#define CLK_DOUT_PERI_HSI2C2		7
+#define CLK_DOUT_PERI_SPI0		8
+#define CLK_GOUT_PERI_HSI2C0		9
+#define CLK_GOUT_PERI_HSI2C1		10
+#define CLK_GOUT_PERI_HSI2C2		11
+#define CLK_GOUT_GPIO_PERI_PCLK		12
+#define CLK_GOUT_HSI2C0_IPCLK		13
+#define CLK_GOUT_HSI2C0_PCLK		14
+#define CLK_GOUT_HSI2C1_IPCLK		15
+#define CLK_GOUT_HSI2C1_PCLK		16
+#define CLK_GOUT_HSI2C2_IPCLK		17
+#define CLK_GOUT_HSI2C2_PCLK		18
+#define CLK_GOUT_I2C0_PCLK		19
+#define CLK_GOUT_I2C1_PCLK		20
+#define CLK_GOUT_I2C2_PCLK		21
+#define CLK_GOUT_I2C3_PCLK		22
+#define CLK_GOUT_I2C4_PCLK		23
+#define CLK_GOUT_I2C5_PCLK		24
+#define CLK_GOUT_I2C6_PCLK		25
+#define CLK_GOUT_MCT_PCLK		26
+#define CLK_GOUT_PWM_MOTOR_PCLK		27
+#define CLK_GOUT_SPI0_IPCLK		28
+#define CLK_GOUT_SPI0_PCLK		29
+#define CLK_GOUT_SYSREG_PERI_PCLK	30
+#define CLK_GOUT_UART_IPCLK		31
+#define CLK_GOUT_UART_PCLK		32
+#define CLK_GOUT_WDT0_PCLK		33
+#define CLK_GOUT_WDT1_PCLK		34
+
+/* CMU_CORE */
+#define CLK_MOUT_CORE_BUS_USER		1
+#define CLK_MOUT_CORE_CCI_USER		2
+#define CLK_MOUT_CORE_MMC_EMBD_USER	3
+#define CLK_MOUT_CORE_SSS_USER		4
+#define CLK_MOUT_CORE_GIC		5
+#define CLK_DOUT_CORE_BUSP		6
+#define CLK_GOUT_CCI_ACLK		7
+#define CLK_GOUT_GIC_CLK		8
+#define CLK_GOUT_MMC_EMBD_ACLK		9
+#define CLK_GOUT_MMC_EMBD_SDCLKIN	10
+#define CLK_GOUT_SSS_ACLK		11
+#define CLK_GOUT_SSS_PCLK		12
+#define CLK_GOUT_GPIO_CORE_PCLK		13
+#define CLK_GOUT_SYSREG_CORE_PCLK	14
+
+/* CMU_DPU */
+#define CLK_MOUT_DPU_USER		1
+#define CLK_DOUT_DPU_BUSP		2
+#define CLK_GOUT_DPU_CMU_DPU_PCLK	3
+#define CLK_GOUT_DPU_DECON0_ACLK	4
+#define CLK_GOUT_DPU_DMA_ACLK		5
+#define CLK_GOUT_DPU_DPP_ACLK		6
+#define CLK_GOUT_DPU_PPMU_ACLK		7
+#define CLK_GOUT_DPU_PPMU_PCLK		8
+#define CLK_GOUT_DPU_SMMU_CLK		9
+#define CLK_GOUT_DPU_SYSREG_PCLK	10
+#define DPU_NR_CLK			11
+
+#endif /* _DT_BINDINGS_CLOCK_EXYNOS_850_H */
-- 
2.39.2

