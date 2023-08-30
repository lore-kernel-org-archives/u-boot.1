Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0648FC83F16
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC1F86545;
	Thu, 31 Aug 2023 01:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XCsuCuZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D0586554; Thu, 31 Aug 2023 01:18:20 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 234AC86547
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7924a3eb5afso12311639f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693437495; x=1694042295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHtRVfZdazalwXF7/K/X+IK1quBJnoh9ttNrkKe1UhE=;
 b=XCsuCuZek8IhrLS9viIYbcPTc3SHFNmNcRDSMAxMTFlQ0V2QU2Naia9AHNbMaj27VB
 QjS0wNQVFkq26HHC62psTzUxoheUkSkJfvxa4ZpAeUDiRF82I+6DuTjdB9nji9l1UsQY
 FDjivRZZSrS/W2T3ZoL6LBVjuRl2rpTCtRE8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693437495; x=1694042295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eHtRVfZdazalwXF7/K/X+IK1quBJnoh9ttNrkKe1UhE=;
 b=F982D9RRDiRtMtr17f+2WE/3DrVkF9CMb0B1wc7cpaFUZEpml0q7q4oLcrabV1Rm+K
 3Cw454ylvFeajy9QeRmObCRDe4152GvUcx+R5YY3MBmexPl69jpWN6iHsICF0kyl1/G1
 LcZawnhTM+nLpapc/EW7/ec3dqcfLUNQ/lDxIeeriR5298/hQHXnAybJRQ/I8Q5Kc30g
 1jlVSe3/zuTOjoOl8Daje0IFVk0qRAsvn8Nd1thoOJZ5IcsuG8zsi8cgouYDqKWVCPjq
 J1NcFKpo5iuMdTDZE64mWW9Plbuibndl+Q5SELBEyaTvIJ/xCQ5B8A2SH2fD8p/5XkRS
 POpg==
X-Gm-Message-State: AOJu0YylWTzi4YisCHm9Ifsf/GjPP7WsPb7Sv8/asU4pYcx3+zFiejjT
 F1joDU6/U9eheQKXoScpW0T48Q==
X-Google-Smtp-Source: AGHT+IEakavImaUnpU6sdboDG8r+uspqLawPT8R+8zuQfCmFsnJ9iwEhtG5lpm0/Jpn3CMcMbrd35w==
X-Received: by 2002:a5e:d510:0:b0:783:6eef:1496 with SMTP id
 e16-20020a5ed510000000b007836eef1496mr3804390iom.19.1693437494858; 
 Wed, 30 Aug 2023 16:18:14 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:18:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 ron minnich <rminnich@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dhaval Sharma <dhaval@rivosinc.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Rutland <mark.rutland@arm.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Gua Guo <gua.guo@intel.com>, Lean Sheng Tan <sheng.tan@9elements.com>,
 Guo Dong <guo.dong@intel.com>, lkml <linux-kernel@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Chiu Chasel <chasel.chiu@intel.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 2/4] Bring in some other reserved-memory files
Date: Wed, 30 Aug 2023 17:17:50 -0600
Message-ID: <20230830231758.2561402-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830231758.2561402-1-sjg@chromium.org>
References: <20230830231758.2561402-1-sjg@chromium.org>
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

Add schema yaml files from v6.5 which are not vendor-specific, nor
Linux-specific.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Trim back to just a subset of mostly generic schemas

Changes in v4:
- New patch

 .../schemas/reserved-memory/framebuffer.yaml  | 52 ++++++++++
 .../reserved-memory/memory-region.yaml        | 40 ++++++++
 .../reserved-memory/shared-dma-pool.yaml      | 97 +++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/framebuffer.yaml
 create mode 100644 dtschema/schemas/reserved-memory/memory-region.yaml
 create mode 100644 dtschema/schemas/reserved-memory/shared-dma-pool.yaml

diff --git a/dtschema/schemas/reserved-memory/framebuffer.yaml b/dtschema/schemas/reserved-memory/framebuffer.yaml
new file mode 100644
index 0000000..851ec24
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/framebuffer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/framebuffer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory framebuffer node
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: framebuffer
+    description: >
+      This indicates a region of memory meant to be used as a framebuffer for
+      a set of display devices. It can be used by an operating system to keep
+      the framebuffer from being overwritten and use it as the backing memory
+      for a display device (such as simple-framebuffer).
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        chosen {
+            framebuffer {
+                compatible = "simple-framebuffer";
+                memory-region = <&fb>;
+            };
+        };
+
+        reserved-memory {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            fb: framebuffer@80000000 {
+                compatible = "framebuffer";
+                reg = <0x80000000 0x007e9000>;
+            };
+        };
+    };
+...
diff --git a/dtschema/schemas/reserved-memory/memory-region.yaml b/dtschema/schemas/reserved-memory/memory-region.yaml
new file mode 100644
index 0000000..592f180
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/memory-region.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/memory-region.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Reserved Memory Region
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+description: |
+  Regions in the /reserved-memory node may be referenced by other device
+  nodes by adding a memory-region property to the device node.
+
+select: true
+
+properties:
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: >
+      Phandle to a /reserved-memory child node assigned to the device.
+
+  memory-region-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: >
+      A list of names, one for each corresponding entry in the
+      memory-region property
+
+additionalProperties: true
+
+examples:
+  - |
+    fb0: video@12300000 {
+        /* ... */
+        reg = <0x12300000 0x1000>;
+        memory-region = <&display_reserved>;
+    };
+
+...
diff --git a/dtschema/schemas/reserved-memory/shared-dma-pool.yaml b/dtschema/schemas/reserved-memory/shared-dma-pool.yaml
new file mode 100644
index 0000000..457de09
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/shared-dma-pool.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory DMA pool
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - const: shared-dma-pool
+        description: >
+          This indicates a region of memory meant to be used as a shared
+          pool of DMA buffers for a set of devices. It can be used by an
+          operating system to instantiate the necessary pool management
+          subsystem if necessary.
+
+      - const: restricted-dma-pool
+        description: >
+          This indicates a region of memory meant to be used as a pool
+          of restricted DMA buffers for a set of devices. The memory
+          region would be the only region accessible to those devices.
+          When using this, the no-map and reusable properties must not
+          be set, so the operating system can create a virtual mapping
+          that will be used for synchronization. The main purpose for
+          restricted DMA is to mitigate the lack of DMA access control
+          on systems without an IOMMU, which could result in the DMA
+          accessing the system memory at unexpected times and/or
+          unexpected addresses, possibly leading to data leakage or
+          corruption. The feature on its own provides a basic level of
+          protection against the DMA overwriting buffer contents at
+          unexpected times. However, to protect against general data
+          leakage and system memory corruption, the system needs to
+          provide way to lock down the memory access, e.g., MPU. Note
+          that since coherent allocation needs remapping, one must set
+          up another device coherent pool by shared-dma-pool and use
+          dma_alloc_from_dev_coherent instead for atomic coherent
+          allocation.
+
+  linux,cma-default:
+    type: boolean
+    description: >
+      If this property is present, then Linux will use the region for
+      the default pool of the contiguous memory allocator.
+
+  linux,dma-default:
+    type: boolean
+    description: >
+      If this property is present, then Linux will use the region for
+      the default pool of the consistent DMA allocator.
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: restricted-dma-pool
+then:
+  properties:
+    no-map: false
+    reusable: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+      reserved-memory {
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+
+          /* global autoconfigured region for contiguous allocations */
+          linux,cma {
+              compatible = "shared-dma-pool";
+              reusable;
+              size = <0x4000000>;
+              alignment = <0x2000>;
+              linux,cma-default;
+          };
+
+          display_reserved: framebuffer@78000000 {
+              reg = <0x78000000 0x800000>;
+          };
+
+          restricted_dma_reserved: restricted-dma-pool@50000000 {
+              compatible = "restricted-dma-pool";
+              reg = <0x50000000 0x4000000>;
+          };
+      };
+
+...
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

