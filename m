Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EDDC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416E487AE8;
	Thu, 11 Jan 2024 04:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WJNZ38h/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175828309D; Thu, 11 Jan 2024 04:09:20 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25F487A4B
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2041e117abaso2399882fac.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704942553; x=1705547353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uH7lC7fYO/o/++oC1FKh4VtdbRytVuz40e1rB1r1WA8=;
 b=WJNZ38h/TwdK1hixamLq23bwHGBdRQO9U10+UuZlEI/ofJ3FbHJwnidd61p2yHs8dp
 rV4cmmhca1xYLWYfGVj5kpENHce3BoJuTlGOf9d8B0qFdV0Ou+galUCCJCe670S28ahA
 ETwIvOEtmNK3PpJeqq1QIc268OL86H4HghhF7xbG4vm2Fhz25w6eaK3mZ7MzUwX9vWLR
 LaHsqIcGVKlSdb62V4mW4gDCIeSVHB7BtvfBO1UnvzGNOSbzQuT2CAT8x4CRTpezaWlz
 gVnSBZqYQEJW3CyIHFStbV4PtSB3212ym07jYFWsaNFUPpmO4Aq7XURVmnkdBSd1wCf7
 EM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704942553; x=1705547353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uH7lC7fYO/o/++oC1FKh4VtdbRytVuz40e1rB1r1WA8=;
 b=Do4hXXat990rQpFOu/vIKw8kv3iJOC9BPDW4BitMD3Q5XAfK1EVFgqCo3Kq3ymflx4
 phT/v33xYEdk2VGKmkyBLWhgwCyiCJPHVh3keLEG+WEZkxRD7+29B2GOWI3DuemH8jl1
 wNCkMzOGOVckucI5+NRyBYbiVnRkf/QRV7ctYGmM3OxhcUeAx1bzLKqzTjg/UIU0jVBI
 IMvEY3MydOL9ENsMmDJfUZXLl2mAlI51+dPPu2rU4Y/jd855f42lXom3EsuytvSyC4kn
 5bMb4/M9vHZwHAHEqB4/imS3HxxxAO8CJwyHkCxjLebGwtvqcAZRjco1OBAVWFpE2q9P
 DyhA==
X-Gm-Message-State: AOJu0YzKm3RhqUq0giJs8RfnFb1kfcGyzCP+5mYglAIyrdLdMWwCJTfF
 g/c++0IL85bkrGExeHqICHqAkLNqrEVtHQ==
X-Google-Smtp-Source: AGHT+IG5kzFsTZUxEULpDowzZ4HuEyeJczotCX1vM7cdqAZnrcGQAmxpw3ZOu9Ro4P4g0i6DNqg3SA==
X-Received: by 2002:a05:6871:290:b0:204:1304:7df7 with SMTP id
 i16-20020a056871029000b0020413047df7mr603822oae.67.1704942553242; 
 Wed, 10 Jan 2024 19:09:13 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 pk3-20020a0568704c0300b00206892f8a80sm4623oab.48.2024.01.10.19.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 19:09:12 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v2 02/13] dt-bindings: soc: samsung: Add Exynos PMU
Date: Wed, 10 Jan 2024 21:08:58 -0600
Message-Id: <20240111030909.27373-3-semen.protsenko@linaro.org>
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

Add bindings documentation for Exynos PMU hardware block. It was taken
from Linux kernel [1], but minimized and modified to reflect features
that will be actually supported in U-Boot soon. For example,
the "samsung,uart-debug-1" property is not available in Linux kernel
bindings and only present in U-Boot.

[1] Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 .../soc/samsung/exynos-pmu.yaml               | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 doc/device-tree-bindings/soc/samsung/exynos-pmu.yaml

diff --git a/doc/device-tree-bindings/soc/samsung/exynos-pmu.yaml b/doc/device-tree-bindings/soc/samsung/exynos-pmu.yaml
new file mode 100644
index 000000000000..c3e95c33b01d
--- /dev/null
+++ b/doc/device-tree-bindings/soc/samsung/exynos-pmu.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/exynos-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC series Power Management Unit (PMU)
+
+maintainers:
+  - Sam Protsenko <semen.protsenko@linaro.org>
+
+description: |+
+  PMU block controls the power and operation states of Exynos SoC. It contains
+  registers for changing the state of next features::
+
+  - Local power control. Exynos SoCs have various power domains, and it's
+    possible to turn them on and off independently, using corresponding
+    registers in PMU block
+  - System-level power control. That allows putting the system into power-down
+    modes (sleep) by turning off the power for most of the domains
+  - Miscellaneous PMU related features
+
+# Custom select to avoid matching all nodes with 'syscon'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - samsung,exynos850-pmu
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - samsung,exynos850-pmu
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  samsung,uart-debug-1:
+    type: boolean
+    description:
+      Enable this property if AP UART lines (Application Processor UART) must be
+      connected to UART_DEBUG_1 path in PMU block. That's usually needed when
+      the serial console is provided by uart1_pins. If this property is not
+      specified, the default behavior will be used (AP UART lines connected to
+      UART_DEBUG_0 path, which usually means uart0_pins are used for the serial
+      console).
+
+  syscon-poweroff:
+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
+    type: object
+    description:
+      Node for power off method
+
+  syscon-reboot:
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+    type: object
+    description:
+      Node for reboot method
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmu_system_controller: system-controller@11860000 {
+        compatible = "samsung,exynos850-pmu", "syscon";
+        reg = <0x11860000 0x10000>;
+
+        reboot: syscon-reboot {
+            compatible = "syscon-reboot";
+            regmap = <&pmu_system_controller>;
+            offset = <0x3a00>; /* SYSTEM_CONFIGURATION */
+            mask = <0x2>; /* SWRESET_SYSTEM */
+            value = <0x2>; /* reset value */
+        };
+    };
-- 
2.39.2

