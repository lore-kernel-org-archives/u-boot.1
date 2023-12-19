Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEAAC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1D786D33;
	Tue, 19 Dec 2023 18:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AheWE3n7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3441187603; Tue, 19 Dec 2023 18:40:41 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F043586D2E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a2331e7058aso416904866b.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703007638; x=1703612438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WUAvVSVhxfpG8xQnwKnlglz0LVM7Vn2JPxTl2XGCxyQ=;
 b=AheWE3n7CVMvKJGVyF/45xb/q3ow8Ho5gbUzgtTvsrFi3qtd0Fb2klbLKI9wSPASyN
 DJyXHFwHf78Ibco3vuwxDSoOIq8XCcr3e+9kyDPDsjUoybirewFkOEECAskLdVEZahIF
 9xDofBKMh9I3ss6cmvuTTeMKLDsIQBqwzd+eWfD9OsLWvwBs1POHgmHbn+dklrAwCq2V
 1tAKbUcFYDDVJeEjXr6Hf7mtcDNauAuiqQ7/T7WMn9B2cdcHMWLtwnlLDwbzZxLjXOWb
 5dCZZI+Z+Ut+S+NUD20hJNEmSiiJ9aUcC4HyWh4/TfY5gpRgmGqjoSluowaNTTBpgILf
 NWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007638; x=1703612438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUAvVSVhxfpG8xQnwKnlglz0LVM7Vn2JPxTl2XGCxyQ=;
 b=wsEmKCKjMh2o+EksyObxzdoSm34nEAnCiRt4ZygqX2LQBlskggegtTFyD7P/C9H1Mt
 pFdOm/Y/yKQNxLS+SroQ715zY8OR34m20hbukYJA5Fv8tMsR3Ge2b8kNnlU3BNilVfg/
 viWvUjoettIsTNRUBWlpYL5C5GT7UnS2j7gWTxu0a58ldq+FXNNt0cWvuUWWBvBOMKv1
 Mt0p0sZkfKMtWtarbep4RAvXzxrTp72wRpBzURxim96hOGI47wuZWikmx2l6E7NxosrD
 cP6tGRWCU+7K7jsLET+YLANevR1VENjJa7alZx9hA8AErqaPKB+ost9pClgkj4WkLhR1
 DrEA==
X-Gm-Message-State: AOJu0Yzp90D8TWqyouk58eNTBjkANRnKNpltT5Dhg4BiskINuOKBC5SU
 GoU9ryXwYzDzOdXhY9EEkuw=
X-Google-Smtp-Source: AGHT+IGj03k4tKfPpLbPbo44mQ331d1Cth9MTNhfOJCUqRXauznoIRp+BrTJhH+JppWzVsGZ3iN7Rw==
X-Received: by 2002:a17:907:764c:b0:a26:8ab0:43b8 with SMTP id
 kj12-20020a170907764c00b00a268ab043b8mr48795ejc.41.1703007638248; 
 Tue, 19 Dec 2023 09:40:38 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 tx27-20020a1709078e9b00b00a1c85124b08sm15834840ejc.94.2023.12.19.09.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:40:37 -0800 (PST)
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
Subject: [PATCH V2 1/5] dt-bindings: nvmem: layouts: add U-Boot environment
 variables layout
Date: Tue, 19 Dec 2023 18:40:21 +0100
Message-Id: <20231219174025.15228-1-zajec5@gmail.com>
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
V2: Add "-layout" suffix to compatibles to avoid conflict

 .../nvmem/layouts/u-boot,env-layout.yaml      | 55 +++++++++++++++++++
 .../devicetree/bindings/nvmem/u-boot,env.yaml |  6 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/u-boot,env-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env-layout.yaml
new file mode 100644
index 000000000000..3b4d8f2a44e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env-layout.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env-layout.yaml#
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
+        const: u-boot,env-layout
+      - description: Two redundant blocks with active one flagged
+        const: u-boot,env-redundant-bool-layout
+      - description: Two redundant blocks with active having higher counter
+        const: u-boot,env-redundant-count-layout
+      - description: Broadcom's variant with custom header
+        const: brcm,env-layout
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
+                compatible = "u-boot,env-layout";
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 9c36afc7084b..6c2a3ca5f051 100644
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

