Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74238C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7482F877F8;
	Wed, 13 Dec 2023 04:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rEkUgQ+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F10876CC; Wed, 13 Dec 2023 04:16:54 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A4F871F0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5906988ab8dso2722924eaf.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437409; x=1703042209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ej0oeHj+1Cf+AC7xJe4DMYSt4r96r/SdsJEDthrCTPA=;
 b=rEkUgQ+0YnNY4U3tBnb0a241FTpNgBUinyUHoKkzim111iPVjyQ6SOli+Tzbt8L/wA
 L0o6KHxlGmmlT4+RvgU0gh3nOp7aQF2FOL8gGL1jhxEhOASml2Dxl84iAY4cN9OLX8sW
 MWyugC567vazreRl+H6QrhzT/ZE2KmrtgKPbloNoKVyqY6hExvddGskJEViprzl+6g3A
 xU4otne6rI+PjkSeg0Mb3i07vUHpzt78IFK8ThOH6SR5A8pP7LjG1IyOPoYH5Ck+KBnW
 NKp/gVaEUoNcZgYiTW9SVKiOmDgPJr8lg+xNRrXy2vkVxnwp+8uPVlrGq91+vkNe6Thh
 zI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437409; x=1703042209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ej0oeHj+1Cf+AC7xJe4DMYSt4r96r/SdsJEDthrCTPA=;
 b=JjwyUpGBd3sD1g/yJTtQ+bURiXSG8Dh0PcYU9rs+Po+65R808JvOK73Z3gCCtdkW3j
 xidpdHw+MMrQ5Zh668fI5H3eabj3XuWudq+ZrBixB8ubn2GfkzK57kOj1595a893j0iQ
 qALkfqn5stJZtO+4aM7zwC3Y+lhml0mhR3CwHNiCs4Hxrn9300ScK4GF/Na6xi3A656B
 lAqdh7RZc0VUvsNv4c5qj/+7uxa/o26rscoQ6Wppfx3N9AFl5Za+PasJBOSzb1iYTjIU
 CJEBQxL1lJ5+Vv0cLgRxk3rvWI5+/GDbw6A3vUkePvEIrKTFPI5qp1YmfipavDgT74d2
 iNmQ==
X-Gm-Message-State: AOJu0YzyqPaxv/TBS7pYrcdL+CKm1F5FNRMI97m+097hAvPTUQyv+IPR
 3rNjf5nNdY3teKW207L0F5xoPJ4thlnBVxJzhbQ=
X-Google-Smtp-Source: AGHT+IGhvjMI0eCOLdKZEPiWKT7F4U6SyAFKPbfJ9kGryIOBOFfP4MA1bNtnV1QENeZ45l1gHlNTTQ==
X-Received: by 2002:a05:6870:171c:b0:1fb:2e4:12ff with SMTP id
 h28-20020a056870171c00b001fb02e412ffmr4563102oae.1.1702437408990; 
 Tue, 12 Dec 2023 19:16:48 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 b24-20020a9d7558000000b006d879d8a4d8sm2567144otl.78.2023.12.12.19.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:48 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 02/13] dt-bindings: soc: samsung: Add Exynos PMU
Date: Tue, 12 Dec 2023 21:16:35 -0600
Message-Id: <20231213031646.28828-3-semen.protsenko@linaro.org>
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

Add bindings documentation for Exynos PMU hardware block. It was taken
from Linux kernel [1], but minimized and modified to reflect features
that will be actually supported in U-Boot soon. For example,
the "samsung,uart-debug-1" property is not available in Linux kernel
bindings and only present in U-Boot.

[1] Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

