Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFC7C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB55987E00;
	Mon, 18 Dec 2023 14:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KUuFHuzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8441987DF8; Mon, 18 Dec 2023 14:37:45 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9838F87CD0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d190df5d0so9898625e9.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 05:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702906661; x=1703511461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=74hbRXhVdXgSDAgGqkd3Z2N/WmcE11nXVnluNKZBVyg=;
 b=KUuFHuzfZS9Lrs+aDlMOOOz+Jm1W1NLIT8IT1eR2dk2m5xrwU4bPvySAIWr6wYHe8y
 Ok3dECuv6TLYI1tiyBQutbmnFJlhz6nX3OM7ICzhOeNRUkcWGFqeBq5AbiM6mOYh91wW
 a67r9E+ThFC+g8+CL7nPakw1AkE0KvwpervHjce1Q4tdTKrqs2cpbn7Rh4V3ZUobO0Pj
 Sa3w4TcrHo4tDKTVpufrRPgcOBb+GepT5neHevc6e+3VWqwvFGPAKVXJI29rv1v+252x
 ZdF+wQuh5v4Ga6XWmTasiTRGxHL6hQHCKTERjwZjsiTsM9tsopl6xALH5rIJlwl9t4hw
 z9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702906661; x=1703511461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=74hbRXhVdXgSDAgGqkd3Z2N/WmcE11nXVnluNKZBVyg=;
 b=nj7dZR7Wdn92ZXhFuPeeLkuO0sqCKnGL8OCKs0eStpmoF124ITdHpegEhPuk5OzsON
 f2Sc8DfCUK7KZjyiaO1U0JsyW2WrJHwc/GWwbAUhob77X4eMoCtXt6Flj7QaXVFTN2/N
 dmw+3JD+6jrBrgxOyRSgJGQD0RTGkBB1I8fRrDnYoNNWu3y0OQ06tZyxd1ELBj7n4sv0
 oTwJn1OEGjDG0MBxusVKTI0i+vxEC0NU+qEfOc3LCWiMk1NKTo5wPYnDKdEMrdclvEFD
 McGLAjcHs5VpbDsVJoA0CKKMGbrIcouRdpzkCURjzMCxUmoQyKn6ENrsLc4VeBe3hSS0
 7seQ==
X-Gm-Message-State: AOJu0YzWdiDxYKWzHbjaMrXVhsIKAVDgcY1Nk950epO29RY5EeoUpFEL
 jP2gC/tB+qZswFpLp9EGknQ=
X-Google-Smtp-Source: AGHT+IHT+hNGJimAnfQ6BtcEMsMSLNWd6wLudFTGCwXIlKzIipmCiwiwJao7CLfyL16Ml1MTDiLl1w==
X-Received: by 2002:a05:600c:3556:b0:40b:5e1e:cf9 with SMTP id
 i22-20020a05600c355600b0040b5e1e0cf9mr7839833wmq.52.1702906659774; 
 Mon, 18 Dec 2023 05:37:39 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 f20-20020a1709067f9400b00a234907311asm1891537ejr.55.2023.12.18.05.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 05:37:39 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/4] dt-bindings: nvmem: layouts: add U-Boot environment
 variables layout
Date: Mon, 18 Dec 2023 14:37:19 +0100
Message-Id: <20231218133722.16150-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot env data is a way of storing firmware variables. It's a format
that can be used of top of various storage devices. Its binding should
be an NVMEM layout instead of a standalone device.

This patch adds layout binding which allows using it on top of MTD NVMEM
device as well as any other. At the same time it deprecates the old
combined binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/nvmem/layouts/u-boot,env.yaml    | 55 +++++++++++++++++++
 .../devicetree/bindings/nvmem/u-boot,env.yaml |  6 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
new file mode 100644
index 000000000000..3a7ec02b3535
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout of U-Boot environment variables
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description:
+  U-Boot uses environment variables to store device parameters and
+  configuration. They may be used for booting process, setup or keeping end user
+  info.
+
+  Data is stored using U-Boot specific formats (variant specific header and NUL
+  separated key-value pairs).
+
+properties:
+  compatible:
+    oneOf:
+      - description: A standalone env data block
+        const: u-boot,env
+      - description: Two redundant blocks with active one flagged
+        const: u-boot,env-redundant-bool
+      - description: Two redundant blocks with active having higher counter
+        const: u-boot,env-redundant-count
+      - description: Broadcom's variant with custom header
+        const: brcm,env
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0x40000>;
+            label = "u-boot";
+            read-only;
+        };
+
+        partition@40000 {
+            reg = <0x40000 0x10000>;
+            label = "u-boot-env";
+
+            nvmem-layout {
+                compatible = "u-boot,env";
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 68214b96f5c9..fd95e611322d 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -26,9 +26,15 @@ description: |
 
   Variables can be defined as NVMEM device subnodes.
 
+  Introduction of NVMEM layouts exposed a limitation of this binding design.
+  Description of NVMEM data content should be separated from NVMEM devices.
+  Since the introduction of U-Boot env data layout this binding is deprecated.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+deprecated: true
+
 properties:
   compatible:
     oneOf:
-- 
2.35.3

