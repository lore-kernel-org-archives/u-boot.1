Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98793E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169C789300;
	Sun,  3 Nov 2024 01:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cn3By+fi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C6C28931D; Sun,  3 Nov 2024 01:39:12 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64A88932F
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20cb47387ceso29995705ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594344; x=1731199144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vXbVwOj+F+HJd/E/fENquLsJiyYrxOhliRgRd5Ckjg=;
 b=cn3By+fi0mZzQxc/kRo/fFYI4Lu2t62Lny30REqe80aA+y2oMYOjvZVGG8c8k+KrQk
 pDtPQgLN+hbT/s3d7RHrY/vkErm4CJyxvmXMqHl9ib0IphUbe1D6LOtJ8oiLkCfhEq3c
 lFuJhRyKLBWdA+8LckGvweoBcZfOm5KfX4PiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594344; x=1731199144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vXbVwOj+F+HJd/E/fENquLsJiyYrxOhliRgRd5Ckjg=;
 b=EC07eHmUaKAQ43e/oabGMcdCW+6r6moasJ8ZIYK6NAo3xYMN3AZTJP/aJpzo+RmHDa
 LVTVvI7zRnRvTsQ6c45+kmWAMdH5zUGElnNLXgKGtB+nvrP65gJV/CZEmXoMz8FXfJBW
 BPUfCsTj15Lz1X7EmdmNNV0B9Ow/AvzhP63MvHFnR+LDsqKTwOhcSV/geuM2llAwseYJ
 C6Vbo604WcZ7WCH6/bSGR5uySZjPonp/Jx6qepfS5LSRSwxrWmViUVDUeSSBjDp23G1u
 m5+59eG9AOR3FciViZRmCico4OL1bO4WnoEVWMptdvhvGj8tkBg4/dLz7l2JPXDbZjwm
 f6sw==
X-Gm-Message-State: AOJu0YyGkQgS3hHFPnOWJfda9k7NTxFg86vAGTIII7fCgErNK08Bf3Aa
 HBT97WZ8gMRlvIOaiKw1p+IKQsj6zZo5X7DylDaYSIPmhXFwOnLnd1Yw5pv8i3b31lrQ2PqxdF6
 7JA==
X-Google-Smtp-Source: AGHT+IEAq7BR8cfMhKmDQGkv0L5qwJdDwPeDHh7R18dpsqn8YQfWX+7ZdPj31Bq0Fg5Z/u+DfWERsg==
X-Received: by 2002:a17:903:228b:b0:20b:fd73:32bb with SMTP id
 d9443c01a7336-210c6872da0mr374289515ad.2.1730594344125; 
 Sat, 02 Nov 2024 17:39:04 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:39:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 25/25] doc: Add devicetree bindings for options
Date: Sat,  2 Nov 2024 18:33:17 -0600
Message-ID: <20241103003322.626036-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

Some of U-Boot's options have made it upstream, so bring in the binding
file.

This is taken from dt-schema commit c9b4797

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Enable LED on the 5 affected platforms
- Reorder patches for bisectability
- Add dt-schema bindings for LED

 doc/device-tree-bindings/options.yaml        |  79 +++++++++++
 doc/device-tree-bindings/options/u-boot.yaml | 136 +++++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 doc/device-tree-bindings/options.yaml
 create mode 100644 doc/device-tree-bindings/options/u-boot.yaml

diff --git a/doc/device-tree-bindings/options.yaml b/doc/device-tree-bindings/options.yaml
new file mode 100644
index 00000000000..d6f5bbb00db
--- /dev/null
+++ b/doc/device-tree-bindings/options.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-clause
+# Copyright 2021 Google LLC
+#
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/options.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /options Node
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  The '/options' node does not represent a real device, but serves as a place
+  for passing data into and between firmware components, such as memory
+  mappings. Data in the '/options' node does not represent the hardware. It is
+  ignored by operating systems.
+
+  Properties in this node should be common to (and used by) at least two
+  firmware projects, such as U-Boot and TF-A. Project-specific subnodes can be
+  used for properties which are specific to a single project.
+
+  This is based on the precedent set by IEEE 1275-1994 IEEE Standard for Boot
+  (Initialization Configuration) Firmware: Core Requirements and Practices
+  at https://www.openfirmware.info/data/docs/of1275.pdf
+
+  Purpose of '/options' node
+  --------------------------
+
+  A common problem with firmware is that many builds are needed to deal with the
+  slight variations between different, related models of the same hardware. For
+  example, one model may have a TPM and another may not. Devicetree provides an
+  excellent solution to this problem, in that the devicetree to actually use on
+  a platform can be injected in the factory based on which model is being
+  manufactured at the time.
+
+  A related problem causing build proliferation is dealing with the differences
+  between development firmware, developer-friendly firmware (e.g. with all
+  security features present but with the ability to access the command line),
+  test firmware (which runs tests used in the factory), final production
+  firmware (before signing), signed firmware (where the signatures have been
+  inserted) and the like. Ideally all or most of these should use the same
+  firmware build, with just some options to determine the features available.
+  For example, being able to control whether the UART console or JTAG are
+  available, on any image, is a great debugging aid.
+
+  When the firmware consists of multiple parts (various U-Boot phases, TF-A,
+  OP-TEE), it is helpful that all operate the same way at runtime, regardless of
+  how they were built. This can be achieved by passing the runtime configuration
+  (e.g. 'enable UART console', 'here are your public keys') along the chain
+  through each firmware stage. It is frustrating to have to replicate a bug on
+  production firmware which does not happen on developer firmware, because they
+  are completely different builds.
+
+  The '/options' node provides useful functionality for this. It allows the
+  different controls to be 'factored out' of the firmware binaries, so they can
+  be controlled separately from the initial source-code build. The node can be
+  easily updated by a build or factory tool and can control various features in
+  the firmware binaries. It is similar in concept to a Kconfig option, except
+  that it can be changed after firmware binaries are built.
+
+  The '/options' node is similar in concept to /chosen (see chosen.yaml) except
+  that it is for passing information *into* and *between*) firmware components,
+  instead of from firmware to the operating system. Also, while operating
+  systems typically have a (sometimes extremely long) command line, firmware
+  binaries typically do not support this. The devicetree provides a more
+  structured approach in any case.
+
+properties:
+  $nodename:
+    const: options
+
+  "#address-cells": true
+  "#size-cells": true
+
+additionalProperties:
+  type: object
diff --git a/doc/device-tree-bindings/options/u-boot.yaml b/doc/device-tree-bindings/options/u-boot.yaml
new file mode 100644
index 00000000000..c9894ff5c48
--- /dev/null
+++ b/doc/device-tree-bindings/options/u-boot.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2021 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/options/u-boot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot configuration node
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  The u-boot,config node provides basic configuration information to U-Boot,
+  for use during its execution. It can be used to control U-Boot's behaviour
+  in various ways.
+
+properties:
+  $nodename:
+    const: u-boot
+
+  compatible:
+    const: u-boot,config
+
+  bootcmd:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Allows overwriting of the boot command used by U-Boot on startup. If
+      present, U-Boot uses this command instead. Note that this feature can
+      work even if loading the environment is disabled, e.g. for security
+      reasons. See also bootsecure.
+
+  bootdelay-sec:
+    description: |
+      Allows selecting of the U-Boot bootdelay, to control whether U-Boot
+      waits on boot or for how long. This allows this option to be configured
+      by the build system or by a previous-stage binary. For example, if the
+      images is being packed for testing or a user holds down a button, it may
+      allow a delay, but disable it for production.
+
+      If this property is not present, a default value is used instead.
+
+      Note that this uses the 'sec' property unit, even though it allows a
+      negative value.
+
+      Values:
+
+      -1: no bootdelay and the user cannot interrupt boot
+      0: no bootdelay but use user can still interrupt boot by holding down a
+        key, if enabled
+      >= 1: delay for this many seconds
+
+
+  bootsecure:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    maximum: 2
+    description: |
+      Controls the execution of the boot command in U-Boot, e.g. selecting
+      between using a special function to run commands, or the normal CLI. This
+      can be used in production images, to restrict the amount of parsing done
+      or the options available, to cut back on the available surface for
+      security attacks.
+
+      Values:
+
+      0: normal boot using CLI (default if not present)
+      1: use secure boot mechanism instead to parse and run commands
+        other values are reserved for future use
+      2: use simplified command line (e.g. avoid hush)
+      3... reserved
+
+  bootscr-address:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    default: 0x0
+    description:
+      Holds the full address of the boot script file. It helps in making
+      automated flow easier by fetching the 64bit address directly from DT.
+      Value should be automatically copied to the U-Boot 'scriptaddr' variable.
+      When it is defined, bootscr-ram-offset property should be ignored.
+      Actually only one of them should be present in the DT.
+
+  bootscr-ram-offset:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    default: 0x0
+    description:
+      Holds the boot script file offset from the start of the ram base address.
+      Platforms with run-time RAM-detection algorithms should use this property
+      because it is not clear exactly where the script address should be placed.
+      Using it will provide the option to specify boot script offset from
+      detected RAM start. The U-Boot 'scriptaddr' variable should be composed as
+      detected RAM start plus value of bootscr-ram-offset property.
+      It should be used only when bootscr-address is not defined.
+
+  silent-console:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    maximum: 2
+    description: |
+      This allows the console to be silenced by default on boot. This can allow
+      easy disabling of console output on a production build, for example. When
+      suppressed, the console is still active. This feature only suppresses the
+      console output itself, on all output devices.
+
+      Values:
+
+      0: console output appears as normal (default)
+      1: console output is suppressed but console recording still operates (if
+        enabled)
+      2: console output is suppressed and not recorded
+
+required:
+  - compatible
+
+if:
+  required:
+    - bootscr-address
+then:
+  properties:
+    bootscr-ram-offset: false
+
+additionalProperties: false
+
+examples:
+  - |
+    options {
+      u-boot {
+        compatible = "u-boot,config";
+        bootcmd = "vboot go auto";
+        bootdelay-sec = <(-1)>;
+        bootsecure = <1>;
+        bootscr-address = /bits/ 64 <0x1000>;
+        silent-console = <1>;
+      };
+    };
-- 
2.43.0

