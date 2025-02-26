Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6710FC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 17:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B2FB80FFC;
	Wed, 26 Feb 2025 18:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K8T2rPJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798F880F96; Wed, 26 Feb 2025 18:33:01 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E684780FD4
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5dcc3b0c77so15023276.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591177; x=1741195977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUM3/01zwWv0b8AmOBR+3jTnF+yEPsnSso2nwR/TDHs=;
 b=K8T2rPJJqvQZ+oUyenc4y8Tj8twwFOb/3wrhSoogNQPupwWKQveC7Qy3/0GXiMC/xz
 4EOps8UyLVKPDUaHr8wPVwZx4b5OyhweDolSc9Jes+iqPflbJKCctL2+MdZa8bQS41Xi
 tHoy6r5Zkwcze4seAHDeXU/vcrq7nrmZjmidBMQeuNz6gKS+VlfeDEZa9TMn2swBo3VO
 fH5cIR+PMNg4McWrZ1wfadC4ez4p4Tx3f15MpugE33ImMGvY87t9nAMsToiB8lX1/TLI
 Z17ykV6g+3BxA0yrr2mxd973HFahYjBeWIiQiW8MyF47DXQq5Fkq/TUMVDKVlPSjN+bY
 tFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591177; x=1741195977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUM3/01zwWv0b8AmOBR+3jTnF+yEPsnSso2nwR/TDHs=;
 b=WVVWwXBS+t9h5p0A4aRUuFxmZkPACytzAg0WjsaycA11boRduOkK5JfoL/X6ZWk+kw
 F8/4Xcl/jPKyf6F026bivcmvX7T1EHzYozibWvtes1+PAR4fS1QMULnEjIOfMY4kwd4r
 xpT0/UBA+6wDoAcUr8Z/pyfFA2HkJrvNkKGRnlb7BktC8Qs4ZyZ0fPZf7L56DaQxzZ4w
 rAKOCVRHkh5KjPFaS231O7Ct+vobjePozhaj5eVNEknhqgwMEeDiRVcDwmHiIsHXiYlJ
 Rg4qEW2toozNKDyBVJeawx5oMTMcwoj6MnrT6bp19bucOi6I5wEimmJKq2syHYxkZiWh
 gmkg==
X-Gm-Message-State: AOJu0YwwX5GKOTRhqAXAMLj51tzaGdCeWqNCVXT4O5bhLyrlwFQdXJUz
 UXmL/NC1lDuFYIJ5r//2pvCuLCQJSaFVaCZJhZNYWxcgZNOvxyMslcxzHhg=
X-Gm-Gg: ASbGncvC2iFZofC/KUIFUgXvrchyPFjV56w32H+GN1NCSVuq8HHxbdSneWMUBdXOsgs
 VSvaxPFKZ3JXnA41D1MWTkGzq1xafE4vj1Q0UpAk79OC9VJSmf65WI+/hq81HZNTD0rlekyOT9S
 v+8LLLI1LWCGhAEv9RiO1ZsNgunOwdcE77+bQh8R6cL2krBVXei8xME4omgSrAM3Q9j3T9SDipb
 RPPYD3hrJOdxlO1iYFMmlTUhYDhtdesUEPIrC6eeBd8O0sEA7dULWpFbBBoetIVlJtgO9O1sb7V
 EoDP7veWZ/XOhfyZdbyKCTM+aFEGR37CY1+IwjXz9w==
X-Google-Smtp-Source: AGHT+IFrP1L7IBwj6wlx8XwObackaMxh5irTiUKwTy8HjSgIbI2S3l8Km1QxZZUwrH0NEosi9SDxGw==
X-Received: by 2002:a05:6902:2b06:b0:e5d:ad43:9b36 with SMTP id
 3f1490d57ef6-e608a6c40c7mr4168868276.20.1740591177216; 
 Wed, 26 Feb 2025 09:32:57 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:32:56 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 02/12] doc: Add dt-bindings and descriptions for ADI
 SC5xx-family pinctrl
Date: Wed, 26 Feb 2025 12:30:24 -0500
Message-ID: <20250226173150.13198-3-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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

This adds the necessary dt-bindings and documentation to use the ADI
SC5xx pinctrl driver in a device tree. It is not yet available upstream
in the Linux kernel. Eventually, it will be moved there.

Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

(no changes since v1)

 MAINTAINERS                                   |  2 +
 .../pinctrl/adi,adsp-pinctrl.yaml             | 73 +++++++++++++++++++
 include/dt-bindings/pinctrl/adi-adsp.h        | 21 ++++++
 3 files changed, 96 insertions(+)
 create mode 100644 doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/adi-adsp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index af8d0b7d5e9..abdb418b599 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -629,12 +629,14 @@ F:	arch/arm/mach-sc5xx/
 F:	board/adi/
 F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
 F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
+F:	doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
 F:	doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
 F:	drivers/clk/adi/
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
 F:	include/configs/sc5*
+F:	include/dt-bindings/pinctrl/adi-adsp.h
 F:	include/env/adi/
 
 ARM SNAPDRAGON
diff --git a/doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml b/doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
new file mode 100644
index 00000000000..418ebd5ce41
--- /dev/null
+++ b/doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/adi,adsp-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pinctrl Driver for Analog Devices SC5xx Processors
+
+maintainers:
+  - Vasileios Bimpikas <vasileios.bimpikas@analog.com>
+  - Utsav Agarwal <utsav.agarwal@analog.com>
+  - Arturs Artamonovs <arturs.artamonovs@analog.com>
+
+description: |
+  This driver provides an interface for performing pin configuration
+  Analog Devices SoCs using the ADSP PORT hardware for pin
+  configuration according to the HRM. Currently this is only the
+  SC5xx series.
+
+properties:
+  compatible:
+    const: adi,adsp-pinctrl
+
+  reg:
+    maxItems: 1
+
+  adi,npins:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Total number of pins available to this SoC's pin controller,
+      found in the HRM.
+
+patternProperties:
+  '_pins$':
+    type: object
+
+    properties:
+      adi,pins:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          For n pins, 2n values must be provided as a sequence of pin
+          name as identified with the ADI_ADSP_PIN() macro and a pin
+          function constant, both defined in
+          include/dt-bindings/pinctrl/adi-adsp.h.
+
+    required:
+     - adi,pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - adi,npins
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/adi-adsp.h>
+
+    soc {
+      pinctrl0: pinctrl@0x31004000 {
+        compatible = "adi,adsp-pinctrl";
+        reg = <0x31004000 0x500>;
+        adi,npins = <135>;
+        uart0_default: uart0_pins {
+          adi,pins = <ADI_ADSP_PIN('A', 6) ADI_ADSP_PINFUNC_ALT1>,
+                     <ADI_ADSP_PIN('A', 7) ADI_ADSP_PINFUNC_ALT1>;
+        };
+      };
+
+    };
diff --git a/include/dt-bindings/pinctrl/adi-adsp.h b/include/dt-bindings/pinctrl/adi-adsp.h
new file mode 100644
index 00000000000..7dc8a1ef5c4
--- /dev/null
+++ b/include/dt-bindings/pinctrl/adi-adsp.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ */
+
+#ifndef DT_BINDINGS_PINCTRL_ADI_ADSP
+#define DT_BINDINGS_PINCTRL_ADI_ADSP
+
+#define ADI_ADSP_PIN(port, pin) (16 * ((port) - 'A') + (pin))
+#define ADI_ADSP_PINFUNC_ALT0 0
+#define ADI_ADSP_PINFUNC_ALT1 1
+#define ADI_ADSP_PINFUNC_ALT2 2
+#define ADI_ADSP_PINFUNC_ALT3 3
+
+#endif
-- 
2.45.2

