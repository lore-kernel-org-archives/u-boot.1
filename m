Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3D4C83F14
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F9886549;
	Thu, 31 Aug 2023 01:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MQMDgqDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CFE086546; Thu, 31 Aug 2023 01:18:14 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEA5864AA
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79536bc6697so11583039f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693437489; x=1694042289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IomW+Mec9sthmR9cu2/c2HOTyUZrOLUcRUv85KAO91E=;
 b=MQMDgqDxbSlKkE2l0zD4clmcnnGLqj8qJdQ0v6gJq7PalF4ZAjUqIvZTQfuGzH1Bxw
 aD+6YmnIvTDkXeeil4rSGQKom2d1bcxKjmac1/st8+1bvY2ldg2qrupy4Y2Tt8Ok0bpH
 GzXvoCfZomCUdiNWMgoJuiId0k6n5ayFxfl9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693437489; x=1694042289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IomW+Mec9sthmR9cu2/c2HOTyUZrOLUcRUv85KAO91E=;
 b=eamIXjt7+lAk+EPuu8LjRAWNygv6XXejV27fjgDMqiqgyaNQyk+erNrsHYn/EL9A+F
 bTDQtTuGmyoTYwC3LTi5vva8+URl83ZGX1KTHOesxQPeS/AxUTX1zhwrS5l8D3qaxbK5
 b00a4a4MNfMPTalC+cp7QRMO0v6/22F+nunmuSydDrSkV1rHAldLXmI7tT2fLVayEPAt
 mNrFjdiajlmChnh7OFPlf54v1GKUvOfcedv7gmAVP1/e2i5w6lTPqcuployE2//E6RCU
 Qv1IFGaJFA3kLqM7Li6ZTEvsuqN/0B0FsPHcXJnx6jJzdiiLIe4fQR7xIGdqG3BdqfZ/
 eIxQ==
X-Gm-Message-State: AOJu0YxknZYgo9sXilcdJGN1bZLv/ACr3/Qi9KPkaQQ3xihJpELtLOHD
 Nz/JujI/ZOTssntZI7jmNWTjlw==
X-Google-Smtp-Source: AGHT+IEYGJNH1CGCeQsbWkow001Dg/4CtvKV/pF2SGqYbrCiviXf5gzS1igFQo1OGrX4mpY8x0Tnlg==
X-Received: by 2002:a5e:a706:0:b0:78b:d0a9:34fb with SMTP id
 b6-20020a5ea706000000b0078bd0a934fbmr3795029iod.20.1693437489546; 
 Wed, 30 Aug 2023 16:18:09 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:18:09 -0700 (PDT)
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
Subject: [PATCH v5 1/4] Add reserved-memory
Date: Wed, 30 Aug 2023 17:17:49 -0600
Message-ID: <20230830231758.2561402-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
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

Bring in this file from Linux v6.5

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- New patch

 .../reserved-memory/reserved-memory.yaml      | 181 ++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/reserved-memory.yaml

diff --git a/dtschema/schemas/reserved-memory/reserved-memory.yaml b/dtschema/schemas/reserved-memory/reserved-memory.yaml
new file mode 100644
index 0000000..c680e39
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/reserved-memory.yaml
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/reserved-memory.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory Child Node Common
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+description: >
+  Reserved memory is specified as a node under the /reserved-memory node. The
+  operating system shall exclude reserved memory from normal usage one can
+  create child nodes describing particular reserved (excluded from normal use)
+  memory regions. Such memory regions are usually designed for the special
+  usage by various device drivers.
+
+  Each child of the reserved-memory node specifies one or more regions
+  of reserved memory. Each child node may either use a 'reg' property to
+  specify a specific range of reserved memory, or a 'size' property with
+  optional constraints to request a dynamically allocated block of
+  memory.
+
+  Following the generic-names recommended practice, node names should
+  reflect the purpose of the node (ie. "framebuffer" or "dma-pool").
+  Unit address (@<address>) should be appended to the name if the node
+  is a static allocation.
+
+properties:
+  reg: true
+
+  size:
+    oneOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - $ref: /schemas/types.yaml#/definitions/uint64
+    description: >
+      Length based on parent's \#size-cells. Size in bytes of memory to
+      reserve.
+
+  alignment:
+    oneOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - $ref: /schemas/types.yaml#/definitions/uint64
+    description: >
+      Length based on parent's \#size-cells. Address boundary for
+      alignment of allocation.
+
+  alloc-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: >
+      Address and Length pairs. Specifies regions of memory that are
+      acceptable to allocate from.
+
+  iommu-addresses:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: >
+      A list of phandle and specifier pairs that describe static IO virtual
+      address space mappings and carveouts associated with a given reserved
+      memory region. The phandle in the first cell refers to the device for
+      which the mapping or carveout is to be created.
+
+      The specifier consists of an address/size pair and denotes the IO
+      virtual address range of the region for the given device. The exact
+      format depends on the values of the "#address-cells" and "#size-cells"
+      properties of the device referenced via the phandle.
+
+      When used in combination with a "reg" property, an IOVA mapping is to
+      be established for this memory region. One example where this can be
+      useful is to create an identity mapping for physical memory that the
+      firmware has configured some hardware to access (such as a bootsplash
+      framebuffer).
+
+      If no "reg" property is specified, the "iommu-addresses" property
+      defines carveout regions in the IOVA space for the given device. This
+      can be useful if a certain memory region should not be mapped through
+      the IOMMU.
+
+  no-map:
+    type: boolean
+    description: >
+      Indicates the operating system must not create a virtual mapping
+      of the region as part of its standard mapping of system memory,
+      nor permit speculative access to it under any circumstances other
+      than under the control of the device driver using the region.
+
+  reusable:
+    type: boolean
+    description: >
+      The operating system can use the memory in this region with the
+      limitation that the device driver(s) owning the region need to be
+      able to reclaim it back. Typically that means that the operating
+      system can use that region to store volatile or cached data that
+      can be otherwise regenerated or migrated elsewhere.
+
+allOf:
+  - if:
+      required:
+        - no-map
+
+    then:
+      not:
+        required:
+          - reusable
+
+  - if:
+      required:
+        - reusable
+
+    then:
+      not:
+        required:
+          - no-map
+
+oneOf:
+  - oneOf:
+      - required:
+          - reg
+
+      - required:
+          - size
+
+  - oneOf:
+      # IOMMU reservations
+      - required:
+          - iommu-addresses
+
+      # IOMMU mappings
+      - required:
+          - reg
+          - iommu-addresses
+
+additionalProperties: true
+
+examples:
+  - |
+    / {
+      compatible = "foo";
+      model = "foo";
+
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        adsp_resv: reservation-adsp {
+          /*
+           * Restrict IOVA mappings for ADSP buffers to the 512 MiB region
+           * from 0x40000000 - 0x5fffffff. Anything outside is reserved by
+           * the ADSP for I/O memory and private memory allocations.
+           */
+          iommu-addresses = <&adsp 0x0 0x00000000 0x00 0x40000000>,
+                            <&adsp 0x0 0x60000000 0xff 0xa0000000>;
+        };
+
+        fb: framebuffer@90000000 {
+          reg = <0x0 0x90000000 0x0 0x00800000>;
+          iommu-addresses = <&dc0 0x0 0x90000000 0x0 0x00800000>;
+        };
+      };
+
+      bus@0 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x0 0x0 0x40000000>;
+
+        adsp: adsp@2990000 {
+          reg = <0x2990000 0x2000>;
+          memory-region = <&adsp_resv>;
+        };
+
+        dc0: display@15200000 {
+          reg = <0x15200000 0x10000>;
+          memory-region = <&fb>;
+        };
+      };
+    };
+...
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

