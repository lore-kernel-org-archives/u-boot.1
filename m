Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7369C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E156B874D5;
	Wed, 13 Dec 2023 04:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MsxgUtGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64B6877E6; Wed, 13 Dec 2023 04:16:53 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8A18749E
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-58d1b767b2bso4068458eaf.2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437408; x=1703042208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5cYZY0NTqrggQIO5rkiJ0qRyfIIPbB7cCs2v2WjJtA=;
 b=MsxgUtGosxKE17sjY2RTr7swYYx42SecplgZBy3IPzeuaG5daW5u6O7qtSbOMUUXQ1
 jLOdLHLa3a8j77r+DYO9sL852fMJ27fWS3We3Qu9m1ELXGLuvL08lxmxR8MMvF2HTUWI
 QJ1o0koSZLMKgUb4HOL53UweSdqCIcJyZTXa/YRsZJtX+9W6IK88Vwn/A37tWFmRJjOA
 u41ilZLxwPf+/OeMXXhbjRQDTmmqvSsJHk5VS4+n4av3XDjvPwzAcrazk4+mxUpHuUDB
 0CI9IIzbK6iQ409B84OCTNSOn6+T8sWTcMXrp3sK02xU1UJeIMnjWxKRl43yAJurUYhu
 za2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437408; x=1703042208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5cYZY0NTqrggQIO5rkiJ0qRyfIIPbB7cCs2v2WjJtA=;
 b=PxjOQnDuUFzl6RMfyDJ/KDfD397TgnDcwNd4mPzI0dMws1bJMw9HQt3WQNGqFF1RW6
 FSahGs8R8Pm1N6fghyF+mR2NlesRtX1JKJHoCcEYo3FIB755t5Utqpjl4S54zIFzc5Xq
 Nzt7nWupNltKCE/ZKDfFuKKZ5wlxLZ53kAIqBgnk7etZ+X20JQhJSfbIY3Exc/46Wiyl
 E5N6bHR8MKqPcJKqK1z3PDkZT+m2pZiOQxgMKar4QYXkRZEgLC5ZNGZBMNkVMRU911jv
 gIhGXWrre8pIknv6xN7y/g0LzvyXbsZAJMor81U2RHNMQSIMO5h3hYKC2vF47BvngRlw
 bjrw==
X-Gm-Message-State: AOJu0YyOt4KyaIROEB5EW7zgK2FuD9SdYetG5D7DJNvk68G2+7lX2w6R
 Mtod26lspzp64moFH4Dd3nsMwg==
X-Google-Smtp-Source: AGHT+IEqvtNjC1nk6r4MLqYAwcGQc75DRkiLMDR0oNu1awC9SHjY2gVtlUmFRZmxfMNP3lFRWjgbTg==
X-Received: by 2002:a05:6870:f606:b0:1fb:75a:c42b with SMTP id
 ek6-20020a056870f60600b001fb075ac42bmr6899640oab.84.1702437408148; 
 Tue, 12 Dec 2023 19:16:48 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 dx20-20020a056870769400b002032703fa22sm36323oab.8.2023.12.12.19.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:47 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 01/13] dt-bindings: soc: samsung: Add Exynos USI
Date: Tue, 12 Dec 2023 21:16:34 -0600
Message-Id: <20231213031646.28828-2-semen.protsenko@linaro.org>
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

Add USI bindings documentation and header file. Those are taken from
Linux kernel [1,2], but the documentation was reworked a bit to only
describe the compatibles that will be supported in U-Boot soon.

[1] Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
[2] include/dt-bindings/soc/samsung,exynos-usi.h

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

