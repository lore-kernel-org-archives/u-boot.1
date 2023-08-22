Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A762DEE49B2
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 20:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24630864A9;
	Tue, 22 Aug 2023 22:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XBVW9o6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B04864AE; Tue, 22 Aug 2023 22:35:00 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07FAC864A0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 22:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-792388ea4b3so73831439f.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692736495; x=1693341295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EQi7QRj3DomGJNq77fSPrkeQ/5P45CBX8SOOZ9egyGY=;
 b=XBVW9o6x4KH2aCFdnr1+cajztmT4qOPkS38+3KWb80IYCTIE/cDT2m7Q1cGzg9b1Vf
 G6ylQeW1DnqKRObzW2ZE014/yIgDz0TNNYo2juLa948F8fSNiNUUILFzGCIm1/B2lVgJ
 7w1aZCUpmGCvqJPGioKkUOs4lrVT4dj2CIHCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692736495; x=1693341295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQi7QRj3DomGJNq77fSPrkeQ/5P45CBX8SOOZ9egyGY=;
 b=T1opGivUZG9RCRzKdI4kpezyAGlTzTrEphfZ5X0PhkGfSCCOTM/fF2OIAjbVXjYWXY
 qfPEKNyMcYUHW5Lfi6nl4XJaXQzhmaXOY8NAkVDbqu5pQdLdBrHRbvh8Ikeor4aww/tJ
 Db9A8t251I49r7Bi8QPfFDozNn0wIrTe4QhMwGB7NnjQ+DTeI8Mi+vL2n4cWWuUc14Hf
 74vVKxdv1dM4VpP6bcQZ0Tx2OiYvUKAY+kf4U3WpwBorXKb+7zRKD+Pru1LvmnQStSUN
 xTKIgnGCvH5JpqVbLgU6KzGm9EbBigYyO7+pbdm43Eo9pMtiWQ2z9Mxw+A58ac3Zo+8e
 rmKQ==
X-Gm-Message-State: AOJu0YwZsrqbKxUN7c89I1lGgPT4um+HhpEEyVGan98HUpXD+pEkLSaq
 iAF2P2jn1Xf7xLUd1oqTZcUWxQ==
X-Google-Smtp-Source: AGHT+IG7GwprJP1540358w3OKonK7RTDA7jAtXMa1F0tKSSk5KGEYAodBigGr7WB4czbJykGoyCX8Q==
X-Received: by 2002:a5d:930c:0:b0:790:fab3:2052 with SMTP id
 l12-20020a5d930c000000b00790fab32052mr815521ion.5.1692736495526; 
 Tue, 22 Aug 2023 13:34:55 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b7f:10f7:eb5:da54])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a5eaa14000000b0078754bed499sm3500745ioe.37.2023.08.22.13.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 13:34:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Chiu Chasel <chasel.chiu@intel.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Gua Guo <gua.guo@intel.com>,
 linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Yunhui Cui <cuiyunhui@bytedance.com>, ron minnich <rminnich@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lean Sheng Tan <sheng.tan@9elements.com>,
 Mark Rutland <mark.rutland@arm.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/2] schemas: Add a schema for memory map
Date: Tue, 22 Aug 2023 14:34:42 -0600
Message-ID: <20230822203446.4111742-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

The Devicetree specification skips over handling of a logical view of
the memory map, pointing users to the UEFI specification.

It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.

This aims to provide an initial schema for this mapping.

Note that this is separate from the existing /memory and /reserved-memory
nodes, since it is mostly concerned with what the memory is used for. It
may cover only a small fraction of available memory.

For now, no attempt is made to create an exhaustive binding, so there are
some example types listed. This can be completed once this has passed
initial review.

This binding does not include a binding for the memory 'attribute'
property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
to have that as well, but perhaps not as a bit mask.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Reword commit message again
- cc a lot more people, from the FFI patch
- Split out the attributes into the /memory nodes

Changes in v2:
- Reword commit message

 dtschema/schemas/memory-map.yaml | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 dtschema/schemas/memory-map.yaml

diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
new file mode 100644
index 0000000..4b06583
--- /dev/null
+++ b/dtschema/schemas/memory-map.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: BSD-2-Clause
+# Copyright 2023 Google LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-map.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /memory-map nodes
+description: |
+  Common properties always required in /memory-map nodes. These nodes are
+  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEFI")
+  in the Devicetree Specification.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+properties:
+  $nodename:
+    const: 'memory-map'
+
+patternProperties:
+  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        minItems: 1
+        maxItems: 1024
+
+      usage:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: |
+          Describes the usage of the memory region, e.g.:
+
+            "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
+            "runtime-code", "runtime-data".
+
+            See enum EFI_MEMORY_TYPE in "Unified Extensible Firmware Interface
+            (UEFI) Specification" for all the types. For now there are not
+            listed here.
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-map {
+        acpi@f0000 {
+            reg = <0xf0000 0x4000>;
+            usage = "acpi-reclaim";
+        };
+
+        runtime@12300000 {
+            reg = <0x12300000 0x28000>;
+            usage = "runtime-code";
+        };
+    };
+...
-- 
2.42.0.rc1.204.g551eb34607-goog

