Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D00C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 19:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164A186511;
	Tue, 29 Aug 2023 21:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O18d519m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8DE86517; Tue, 29 Aug 2023 21:18:22 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2255486517
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34dea77cbe6so3798405ab.2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693336698; x=1693941498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14UxKbnagyJ+cKoRi1AZAoVSOHI5uNMgHy0vJsUOsMA=;
 b=O18d519maBdUGp//16+YE/p/5f8RcFsHQBtyPM5hQ/hugf5hOXzcm+r23F5RuzCXGG
 6KL4Jsg40/peOvStkGRRRY1fG8Iw8419xrGw79mvvNTp3KSosyFdORhL0j061rsNVISY
 yf14RD1dwT3kX6MDKFhMaR8F2eG27zZ2JDIdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336698; x=1693941498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14UxKbnagyJ+cKoRi1AZAoVSOHI5uNMgHy0vJsUOsMA=;
 b=WIG4l+YP64+dM32q/5DwsTaCO11Ob9JsPaaBqV99bmp/9RwY+CIUHYiKo7scm/ihjo
 FXRlTvXXZKwFwulPr2MwjvYbpBU468Io1slSvNBREXq+tz5u9YFKIYV5zUXc8IW0DsVT
 rbNri2Di+M+e8pTLzIKpKLdRmI2q7x8kw9nWTm3fpX5mkiLvLj/ERTDHXV0pBF9xrdIF
 ZhfoQghdF46mpS5FIXAD+szarlCacyggwgIWxLjnO80AipYY4GCsbllg+jBQk07xvUNx
 wNfYH0MPTJosFOC5YmCvFLdlZMF5s9CtORzvtk7WxKIyjY/iIRRUSDmZz7pKIKodBZVI
 9IHw==
X-Gm-Message-State: AOJu0YyBOzYLphz7U32SEMml9q22euuEE3+c50zEpiy5XFqzrVJwSRC1
 G9pK9itfz8gxTWCXSckisJkmxg==
X-Google-Smtp-Source: AGHT+IE1yHxc4xwKVY+xA8BVBZr+iPnWbfnWpXJJgJRBuHtfcpQBPLXqlKibsUJZ5kxX0hMOB+ms6w==
X-Received: by 2002:a92:de08:0:b0:34b:b16d:aa38 with SMTP id
 x8-20020a92de08000000b0034bb16daa38mr287639ilm.29.1693336697691; 
 Tue, 29 Aug 2023 12:18:17 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:16d9:c947:1a18:4c10])
 by smtp.gmail.com with ESMTPSA id
 fq8-20020a056638650800b004332f6537e2sm3359798jab.83.2023.08.29.12.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:18:17 -0700 (PDT)
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
Subject: [PATCH v4 2/4] Bring in other reserved-memory files
Date: Tue, 29 Aug 2023 13:18:07 -0600
Message-ID: <20230829191812.135759-2-sjg@chromium.org>
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

Add those files from v6.5 which are already converted to yaml.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- New patch

 .../schemas/reserved-memory/framebuffer.yaml  |  52 +++++++
 .../reserved-memory/google,open-dice.yaml     |  46 ++++++
 .../reserved-memory/memory-region.yaml        |  40 +++++
 .../nvidia,tegra210-emc-table.yaml            |  31 ++++
 .../nvidia,tegra264-bpmp-shmem.yaml           |  47 ++++++
 dtschema/schemas/reserved-memory/phram.yaml   |  47 ++++++
 .../schemas/reserved-memory/qcom,cmd-db.yaml  |  46 ++++++
 .../reserved-memory/qcom,rmtfs-mem.yaml       |  55 +++++++
 dtschema/schemas/reserved-memory/ramoops.yaml | 144 ++++++++++++++++++
 .../reserved-memory/shared-dma-pool.yaml      |  97 ++++++++++++
 10 files changed, 605 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/framebuffer.yaml
 create mode 100644 dtschema/schemas/reserved-memory/google,open-dice.yaml
 create mode 100644 dtschema/schemas/reserved-memory/memory-region.yaml
 create mode 100644 dtschema/schemas/reserved-memory/nvidia,tegra210-emc-table.yaml
 create mode 100644 dtschema/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
 create mode 100644 dtschema/schemas/reserved-memory/phram.yaml
 create mode 100644 dtschema/schemas/reserved-memory/qcom,cmd-db.yaml
 create mode 100644 dtschema/schemas/reserved-memory/qcom,rmtfs-mem.yaml
 create mode 100644 dtschema/schemas/reserved-memory/ramoops.yaml
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
diff --git a/dtschema/schemas/reserved-memory/google,open-dice.yaml b/dtschema/schemas/reserved-memory/google,open-dice.yaml
new file mode 100644
index 0000000..c591ec3
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/google,open-dice.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/google,open-dice.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Open Profile for DICE
+
+description: |
+  This binding represents a reserved memory region containing data
+  generated by the Open Profile for DICE protocol.
+
+  See https://pigweed.googlesource.com/open-dice/
+
+maintainers:
+  - David Brazdil <dbrazdil@google.com>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: google,open-dice
+
+  reg:
+    description: page-aligned region of memory containing DICE data
+
+required:
+  - compatible
+  - reg
+  - no-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        dice: dice@12340000 {
+            compatible = "google,open-dice";
+            reg = <0x00 0x12340000 0x2000>;
+            no-map;
+        };
+    };
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
diff --git a/dtschema/schemas/reserved-memory/nvidia,tegra210-emc-table.yaml b/dtschema/schemas/reserved-memory/nvidia,tegra210-emc-table.yaml
new file mode 100644
index 0000000..e2ace3d
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/nvidia,tegra210-emc-table.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra210-emc-table.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra210 EMC Frequency Table
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+description: On Tegra210, firmware passes a binary representation of the
+  EMC frequency table via a reserved memory region.
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: nvidia,tegra210-emc-table
+
+  reg:
+    description: region of memory reserved by firmware to pass the EMC
+      frequency table
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
diff --git a/dtschema/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml b/dtschema/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
new file mode 100644
index 0000000..f9b2f0f
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra CPU-NS - BPMP IPC reserved memory
+
+maintainers:
+  - Peter De Schrijver <pdeschrijver@nvidia.com>
+
+description: |
+  Define a memory region used for communication between CPU-NS and BPMP.
+  Typically this node is created by the bootloader as the physical address
+  has to be known to both CPU-NS and BPMP for correct IPC operation.
+  The memory region is defined using a child node under /reserved-memory.
+  The sub-node is named shmem@<address>.
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: nvidia,tegra264-bpmp-shmem
+
+  reg:
+    description: The physical address and size of the shared SDRAM region
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - no-map
+
+examples:
+  - |
+    reserved-memory {
+       #address-cells = <2>;
+       #size-cells = <2>;
+       dram_cpu_bpmp_mail: shmem@f1be0000 {
+           compatible = "nvidia,tegra264-bpmp-shmem";
+           reg = <0x0 0xf1be0000 0x0 0x2000>;
+           no-map;
+       };
+    };
+...
diff --git a/dtschema/schemas/reserved-memory/phram.yaml b/dtschema/schemas/reserved-memory/phram.yaml
new file mode 100644
index 0000000..65c7cac
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/phram.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/phram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTD/block device in RAM
+
+description: |
+  Specifies that the reserved memory region can be used as an MTD or block
+  device.
+
+  The "phram" node is named after the "MTD in PHysical RAM" driver which
+  provides an implementation of this functionality in Linux.
+
+maintainers:
+  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+
+allOf:
+  - $ref: reserved-memory.yaml
+  - $ref: /schemas/mtd/mtd.yaml
+
+properties:
+  compatible:
+    const: phram
+
+  reg:
+    description: region of memory that can be used as an MTD/block device
+
+required:
+  - compatible
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
+        phram: flash@12340000 {
+            compatible = "phram";
+            label = "rootfs";
+            reg = <0x12340000 0x00800000>;
+        };
+    };
diff --git a/dtschema/schemas/reserved-memory/qcom,cmd-db.yaml b/dtschema/schemas/reserved-memory/qcom,cmd-db.yaml
new file mode 100644
index 0000000..610f8ef
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/qcom,cmd-db.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/qcom,cmd-db.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Command DB
+
+description: |
+  Command DB is a database that provides a mapping between resource key and the
+  resource address for a system resource managed by a remote processor. The data
+  is stored in a shared memory region and is loaded by the remote processor.
+
+  Some of the Qualcomm Technologies Inc SoC's have hardware accelerators for
+  controlling shared resources. Depending on the board configuration the shared
+  resource properties may change. These properties are dynamically probed by the
+  remote processor and made available in the shared memory.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: qcom,cmd-db
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
+        ranges;
+
+        reserved-memory@85fe0000 {
+            reg = <0x85fe0000 0x20000>;
+            compatible = "qcom,cmd-db";
+            no-map;
+        };
+    };
diff --git a/dtschema/schemas/reserved-memory/qcom,rmtfs-mem.yaml b/dtschema/schemas/reserved-memory/qcom,rmtfs-mem.yaml
new file mode 100644
index 0000000..bab982f
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/qcom,rmtfs-mem.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/qcom,rmtfs-mem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Remote File System Memory
+
+description: |
+  This binding describes the Qualcomm remote filesystem memory, which serves the
+  purpose of describing the shared memory region used for remote processors to
+  access block device data using the Remote Filesystem protocol.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: qcom,rmtfs-mem
+
+  qcom,client-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      identifier of the client to use this region for buffers
+
+  qcom,vmid:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: >
+      Array of vmids of the remote processors, to set up memory protection
+    minItems: 1
+    maxItems: 2
+
+required:
+  - qcom,client-id
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        rmtfs@86700000 {
+            compatible = "qcom,rmtfs-mem";
+            reg = <0x86700000 0xe0000>;
+            no-map;
+
+            qcom,client-id = <1>;
+        };
+    };
diff --git a/dtschema/schemas/reserved-memory/ramoops.yaml b/dtschema/schemas/reserved-memory/ramoops.yaml
new file mode 100644
index 0000000..45cc39e
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/ramoops.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/ramoops.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ramoops oops/panic logger
+
+description: |
+  ramoops provides persistent RAM storage for oops and panics, so they can be
+  recovered after a reboot. This is a child-node of "/reserved-memory", and
+  is named "ramoops" after the backend, rather than "pstore" which is the
+  subsystem.
+
+  Parts of this storage may be set aside for other persistent log buffers, such
+  as kernel log messages, or for optional ECC error-correction data.  The total
+  size of these optional buffers must fit in the reserved region.
+
+  Any remaining space will be used for a circular buffer of oops and panic
+  records.  These records have a configurable size, with a size of 0 indicating
+  that they should be disabled.
+
+  At least one of "record-size", "console-size", "ftrace-size", or "pmsg-size"
+  must be set non-zero, but are otherwise optional as listed below.
+
+maintainers:
+  - Kees Cook <keescook@chromium.org>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: ramoops
+
+  reg:
+    description: region of memory that is preserved between reboots
+
+  ecc-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: enables ECC support and specifies ECC buffer size in bytes
+    default: 0 # no ECC
+
+  record-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum size in bytes of each kmsg dump
+    default: 0
+
+  console-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for kernel messages
+    default: 0
+
+  ftrace-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for function tracing and profiling
+    default: 0
+
+  pmsg-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size in bytes of log buffer reserved for userspace messages
+    default: 0
+
+  mem-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: if present, sets the type of mapping is to be used to map the reserved region.
+    default: 0
+    oneOf:
+      - const: 0
+        description: write-combined
+      - const: 1
+        description: unbuffered
+      - const: 2
+        description: cached
+
+  max-reason:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2 # log oopses and panics
+    maximum: 0x7fffffff
+    description: |
+      If present, sets maximum type of kmsg dump reasons to store.
+      This can be set to INT_MAX to store all kmsg dumps.
+      See include/linux/kmsg_dump.h KMSG_DUMP_* for other kmsg dump reason values.
+      Setting this to 0 (KMSG_DUMP_UNDEF), means the reason filtering will be
+      controlled by the printk.always_kmsg_dump boot param.
+      If unset, it will be 2 (KMSG_DUMP_OOPS), otherwise 5 (KMSG_DUMP_MAX).
+
+  flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description: |
+      If present, pass ramoops behavioral flags
+      (see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
+
+  no-dump-oops:
+    deprecated: true
+    type: boolean
+    description: |
+      Use max_reason instead. If present, and max_reason is not specified,
+      it is equivalent to max_reason = 1 (KMSG_DUMP_PANIC).
+
+  unbuffered:
+    deprecated: true
+    type: boolean
+    description: |
+      Use mem_type instead. If present, and mem_type is not specified,
+      it is equivalent to mem_type = 1 and uses unbuffered mappings to map
+      the reserved region (defaults to buffered mappings mem_type = 0).
+      If both are specified -- "mem_type" overrides "unbuffered".
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+anyOf:
+  - required: [record-size]
+  - required: [console-size]
+  - required: [ftrace-size]
+  - required: [pmsg-size]
+
+examples:
+  - |
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reserved-memory {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            ramoops@bfdf0000 {
+                compatible = "ramoops";
+                reg = <0xbfdf0000 0x10000>; /* 64kB */
+                console-size = <0x8000>;    /* 32kB */
+                record-size = <0x400>;      /*  1kB */
+                ecc-size = <16>;
+            };
+        };
+    };
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

