Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A869BC4707C
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D612A87B05;
	Thu, 11 Jan 2024 04:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tVT9q1rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC80987A36; Thu, 11 Jan 2024 04:09:19 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B027D87776
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-203fed05a31so3078069fac.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704942552; x=1705547352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7GKXWpO2ptHHWwGN7NpFJyklyGWVbxuX5E44M+C3tk=;
 b=tVT9q1rrijFQS8QhpGF/42t7QrvV0SjlJ9DztpAMs5SUbp4z7Noy1Ay1JNm2z1Ekan
 +aRizENViFlxKJ5U9pXNu+BVA46UPe6nxXMYnHI/gO8iVKWRy3l5HfHD3u2TKYUAJtlk
 PJ93USHza0o4gSxVfxeKxGgKusstqvmkRuzD8dI2R6NmP5aXZscIFwN7D2iazNca6dPO
 Ru1nTRBoymDUyJjB9+9rLkuEDRMqsQ8cJZWRZaji5ARCnCIsO+gOZk7H3Y2FlayaDcKl
 Cb4GDY+aU5MyQhHC2UUWdzkXvhCIkVePfJ1+5YWAJPexHduvfK+n4zsszEwfkGg13v8i
 4Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704942552; x=1705547352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7GKXWpO2ptHHWwGN7NpFJyklyGWVbxuX5E44M+C3tk=;
 b=sCdejecZGz2dmFkOoCmAXgijru3hqA0VrfA83KtXO1/Lpk6TWvbqs/fp4AtRbE0Ys+
 or+0nCiWnZXJcUZZeXhROeAzq6rW6tzVPMQ22FgiEOEmw0g4BQfiWgy3JMaK123aTZyY
 M2gxmPg7qIXi1Szr7aGH5Dt0Gfvsj4C1GuFlqa2Y3eKo05rDAXjUbDX9BDvtbJ908LpE
 UOjUTWxg+nduCM1fIogYTmo1z2QQHZG0JY3yLGS6HS5KuqOB/Jj79FIte7gL/jbIM5d4
 FvkaivDVXBwLQ8rqDRlzab54kDqnGOvR7Yll93f8+poJkB8dAVsHALXQwiI4E0YY6UQP
 jcSA==
X-Gm-Message-State: AOJu0YxaTThXyg3B1zoSLjtZaYZtZCrzF+s0D98shosSK/kHZjJi6mos
 rtwwVbYJaJBmjdKIxPM0IDnOCHupXKwnRQ==
X-Google-Smtp-Source: AGHT+IEbLGcqj4zkm/9wHRez5r21HADsMeBl4lWpO+eL6gfO2ZhEfqx6m3QwNd3N0fzP6qnmv7NhBQ==
X-Received: by 2002:a05:6870:5e51:b0:206:9b25:4abb with SMTP id
 ne17-20020a0568705e5100b002069b254abbmr119539oac.76.1704942552262; 
 Wed, 10 Jan 2024 19:09:12 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 qw23-20020a0568706f1700b002043b415eaasm8061oab.29.2024.01.10.19.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 19:09:11 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v2 01/13] dt-bindings: soc: samsung: Add Exynos USI
Date: Wed, 10 Jan 2024 21:08:57 -0600
Message-Id: <20240111030909.27373-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111030909.27373-1-semen.protsenko@linaro.org>
References: <20240111030909.27373-1-semen.protsenko@linaro.org>
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

Add USI bindings documentation and header file. Those are taken from
Linux kernel [1,2], but the documentation was reworked a bit to only
describe the compatibles that will be supported in U-Boot soon.

[1] Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
[2] include/dt-bindings/soc/samsung,exynos-usi.h

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 .../soc/samsung/exynos-usi.yaml               | 162 ++++++++++++++++++
 include/dt-bindings/soc/samsung,exynos-usi.h  |  17 ++
 2 files changed, 179 insertions(+)
 create mode 100644 doc/device-tree-bindings/soc/samsung/exynos-usi.yaml
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h

diff --git a/doc/device-tree-bindings/soc/samsung/exynos-usi.yaml b/doc/device-tree-bindings/soc/samsung/exynos-usi.yaml
new file mode 100644
index 000000000000..8e6423f11568
--- /dev/null
+++ b/doc/device-tree-bindings/soc/samsung/exynos-usi.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung's Exynos USI (Universal Serial Interface)
+
+maintainers:
+  - Sam Protsenko <semen.protsenko@linaro.org>
+
+description: |
+  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
+  USI shares almost all internal circuits within each protocol, so only one
+  protocol can be chosen at a time. USI is modeled as a node with zero or more
+  child nodes, each representing a serial sub-node device. The mode setting
+  selects which particular function will be used.
+
+properties:
+  $nodename:
+    pattern: "^usi@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - samsung,exynos850-usi
+
+  reg: true
+
+  clocks: true
+
+  clock-names: true
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  samsung,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register syscon node
+          - description: offset of SW_CONF register for this USI controller
+    description:
+      Should be phandle/offset pair. The phandle to System Register syscon node
+      (for the same domain where this USI controller resides) and the offset
+      of SW_CONF register for this USI controller.
+
+  samsung,mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Selects USI function (which serial protocol to use). Refer to
+      <include/dt-bindings/soc/samsung,exynos-usi.h> for valid USI mode values.
+
+  samsung,clkreq-on:
+    type: boolean
+    description:
+      Enable this property if underlying protocol requires the clock to be
+      continuously provided without automatic gating. As suggested by SoC
+      manual, it should be set in case of SPI/I2C slave, UART Rx and I2C
+      multi-master mode. Usually this property is needed if USI mode is set
+      to "UART".
+
+      This property is optional.
+
+patternProperties:
+  "^i2c@[0-9a-f]+$":
+    $ref: /schemas/i2c/i2c-exynos5.yaml
+    description: Child node describing underlying I2C
+
+  "^serial@[0-9a-f]+$":
+    $ref: /schemas/serial/samsung_uart.yaml
+    description: Child node describing underlying UART/serial
+
+  "^spi@[0-9a-f]+$":
+    $ref: /schemas/spi/samsung,spi.yaml
+    description: Child node describing underlying SPI
+
+required:
+  - compatible
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+  - samsung,sysreg
+  - samsung,mode
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - samsung,exynos850-usi
+
+then:
+  properties:
+    reg:
+      maxItems: 1
+
+    clocks:
+      items:
+        - description: Bus (APB) clock
+        - description: Operating clock for UART/SPI/I2C protocol
+
+    clock-names:
+      items:
+        - const: pclk
+        - const: ipclk
+
+  required:
+    - reg
+    - clocks
+    - clock-names
+
+else:
+  properties:
+    reg: false
+    clocks: false
+    clock-names: false
+    samsung,clkreq-on: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/samsung,exynos-usi.h>
+
+    usi0: usi@138200c0 {
+        compatible = "samsung,exynos850-usi";
+        reg = <0x138200c0 0x20>;
+        samsung,sysreg = <&sysreg_peri 0x1010>;
+        samsung,mode = <USI_V2_UART>;
+        samsung,clkreq-on; /* needed for UART mode */
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+        clock-names = "pclk", "ipclk";
+
+        serial_0: serial@13820000 {
+            compatible = "samsung,exynos850-uart";
+            reg = <0x13820000 0xc0>;
+            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+            clock-names = "uart", "clk_uart_baud0";
+            status = "disabled";
+        };
+
+        hsi2c_0: i2c@13820000 {
+            compatible = "samsung,exynosautov9-hsi2c";
+            reg = <0x13820000 0xc0>;
+            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&cmu_peri 31>, <&cmu_peri 32>;
+            clock-names = "hsi2c", "hsi2c_pclk";
+            status = "disabled";
+        };
+    };
diff --git a/include/dt-bindings/soc/samsung,exynos-usi.h b/include/dt-bindings/soc/samsung,exynos-usi.h
new file mode 100644
index 000000000000..a01af169d249
--- /dev/null
+++ b/include/dt-bindings/soc/samsung,exynos-usi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Device Tree bindings for Samsung Exynos USI (Universal Serial Interface).
+ */
+
+#ifndef __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
+#define __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
+
+#define USI_V2_NONE		0
+#define USI_V2_UART		1
+#define USI_V2_SPI		2
+#define USI_V2_I2C		3
+
+#endif /* __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H */
-- 
2.39.2

