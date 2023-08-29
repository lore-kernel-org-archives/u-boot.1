Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8BEC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 19:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D3D86529;
	Tue, 29 Aug 2023 21:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZiG1winf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A1286519; Tue, 29 Aug 2023 21:18:24 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919708651C
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-77a62a84855so167392639f.1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693336699; x=1693941499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asdwWrQgSDUsQBbMFgdwSUCGxAMIv135nq9+k2HMaa0=;
 b=ZiG1winfIAUh6gbgzqOPplHQl0nZFIFtEBCJTHPsM9W9BDPwvF+GDHIj0tXkFzbq4/
 SBgtTIZX2KC0Ilsx6s0b//nVo1m+bforXPeWa7od7VH9J3UuiHZIWwcQHA37UFIPkieU
 5/LMp7mMuveUEXgxoMygjhOknMx5NNyfNr9XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336699; x=1693941499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asdwWrQgSDUsQBbMFgdwSUCGxAMIv135nq9+k2HMaa0=;
 b=i1+ykStt8KpoWsBNWopqYuKINzVX3p3g+4XIp4lHv+Q9NOhwMeB1ocwM7ZUUZCNfCK
 9jXC8JM8+3a8CS3075khqRZ9w4YVspkDVrlKBkUyl0vMy0rCehWV1Gbau7GkkcNzXiW4
 k+1twM58CTvBkcSH/Hmhugfphm2H/K2kMMWIbk51q9wEyz5qMWkHE5gzf+n4Soo8496P
 7EMRag3Rc1ooiIsFp0ynNvwr7qnYWO37ENqYptCn4+BN5HK9th7YIq+D18uxvNur6fOF
 Df3JtvLP66J7e5fCS/g4xYtpVluLiPwcMJXkNlLEmZkYgGiHlqd1n+G5pV+tXjt8KB9O
 4v4g==
X-Gm-Message-State: AOJu0Ywr/a3HUgM4Ra4KsfZF5756OMYj1rf1QWZkMqSjzmjqjzrtHG82
 S4HCHsdS87Y3pPEDweYA0I97kg==
X-Google-Smtp-Source: AGHT+IGAS+bTigCPmRP0jxu5uZgQG+yMGKUfr6n4pFO5Py5STv9I4dkw/kX8J7iBq5DSVfvEGDSG5w==
X-Received: by 2002:a5d:990f:0:b0:790:fc73:6e3c with SMTP id
 x15-20020a5d990f000000b00790fc736e3cmr332445iol.8.1693336699097; 
 Tue, 29 Aug 2023 12:18:19 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:16d9:c947:1a18:4c10])
 by smtp.gmail.com with ESMTPSA id
 fq8-20020a056638650800b004332f6537e2sm3359798jab.83.2023.08.29.12.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:18:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Dhaval Sharma <dhaval@rivosinc.com>, Mark Rutland <mark.rutland@arm.com>,
 Gua Guo <gua.guo@intel.com>, Tom Rini <trini@konsulko.com>,
 Rob Herring <robh@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 ron minnich <rminnich@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Chiu Chasel <chasel.chiu@intel.com>, lkml <linux-kernel@vger.kernel.org>,
 Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org,
 Guo Dong <guo.dong@intel.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 3/4] schemas: Add a schema for memory map
Date: Tue, 29 Aug 2023 13:18:08 -0600
Message-ID: <20230829191812.135759-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230829191812.135759-1-sjg@chromium.org>
References: <20230829191812.135759-1-sjg@chromium.org>
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

The compatible string is not included, since the node name is enough to
indicate the purpose of a node, as per the existing reserved-memory
schema.

This binding does not include a binding for the memory 'attribute'
property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
to have that as well, but perhaps not as a bit mask.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Make use of the reserved-memory node instead of creating a new one

Changes in v3:
- Reword commit message again
- cc a lot more people, from the FFI patch
- Split out the attributes into the /memory nodes

Changes in v2:
- Reword commit message

 dtschema/schemas/memory-map.yaml              | 61 +++++++++++++++++++
 .../reserved-memory/common-reserved.yaml      | 53 ++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 dtschema/schemas/memory-map.yaml
 create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml

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
diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
new file mode 100644
index 0000000..70cdead
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
+$schema: http://devicetree.org/meta-schemas/base.yaml#
+
+title: Common memory reservations
+
+description: |
+  Specifies that the reserved memory region can be used for the purpose
+  indicated by its node name.
+
+  Clients may reuse this reserved memory if they understand what it is for.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+# always select the core schema
+select: true
+
+properties:
+    $nodename:
+    oneOf:
+      - acpi-reclaim
+      - acpi-nvs
+      - boot-code
+      - boot-data
+      - runtime-code
+      - runtime-data
+
+  reg:
+    description: region of memory that is reserved for the purpose indicated
+      by the node name.
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        boot-code@12340000 {
+            reg = <0x12340000 0x00800000>;
+        };
+
+        boot-data@43210000 {
+            reg = <0x43210000 0x00800000>;
+        };
+    };
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

