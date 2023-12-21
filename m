Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33752C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 903F08785E;
	Thu, 21 Dec 2023 18:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BO5Fbr2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D197C87862; Thu, 21 Dec 2023 18:34:32 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960A187858
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a235e394758so118817066b.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703180070; x=1703784870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WUAvVSVhxfpG8xQnwKnlglz0LVM7Vn2JPxTl2XGCxyQ=;
 b=BO5Fbr2V+y6Apas/6cHn3HWi8QdkFHoGF/21sQyYRgRcmb2PQaZQsMdfHT0spWVDnr
 op97cCitcaCDQ4RNSVxnz6zY/5oJwUQZNbqng4wLcgz7u859HXw6+ZNlPxdXK5NV3x7J
 u4MEA+BjkVHzqHQXTuH9CwqigCBzir16EIu4YfARHR/85LLmEMu/imdIJG/3SPoHqasL
 vOFWU42i6cjvwWHGllvXYgPsHlTsQtqHxtC5sHxBJxxXjkBrxj/ltkzxD8zuzQiZKC4q
 5sy5z+4sJtSVwcB/+8Lyh+nsnwFkLT0HBrEA6XoAFkqVgJDZNgYJ3fTTfDuBHS9H/BjQ
 hDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703180070; x=1703784870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUAvVSVhxfpG8xQnwKnlglz0LVM7Vn2JPxTl2XGCxyQ=;
 b=MFujUz13kqERZh6UcFuEHyp0NXmx7MNCoks0/W9hbvOzGzXoAY00J+5cnryaeksFe5
 40DX6AOC2hmb0RTO6XHMedrgo3gV/8JrRv7uuU8hZAH8VNrgZYQjthf296QqGDzxLTRS
 yWLZoJevcE/To2+whIRvFg4IiX3CwvKtJpH0YHk2R4CfuqbzdsvX4QVSCht88nghOsfH
 83sA6LF99cMoXKr1RwsR3hZ8zgDBLmJAKtF10QqwN6iu6WYp0R2sN+pu++K9XufwQXE0
 omqpdG+v4QNSxch6sTYrn13+X0Lg8Ac/vPRuNkfPl62sAhNXDZCXDI1QsLsvDn1wKh/o
 4WEQ==
X-Gm-Message-State: AOJu0Yzewg9GdWZrwhAx1BY5FnyX2AbidyY17LI5moSjdDNINUIQj0G/
 GGk64ja78LRmH07wAW+Qv9k=
X-Google-Smtp-Source: AGHT+IFhvgdzoX/pSzYG9L+mNveigbIiVGhQYxcEzlqMYOH+0jGOj+DcvcKDRwemDM4HbX3utBRWiA==
X-Received: by 2002:a17:906:1db:b0:a26:8c3a:5133 with SMTP id
 27-20020a17090601db00b00a268c3a5133mr61852ejj.99.1703180069801; 
 Thu, 21 Dec 2023 09:34:29 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:34:29 -0800 (PST)
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
Subject: [PATCH V3 1/6] dt-bindings: nvmem: layouts: add U-Boot environment
 variables layout
Date: Thu, 21 Dec 2023 18:34:16 +0100
Message-Id: <20231221173421.13737-1-zajec5@gmail.com>
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

