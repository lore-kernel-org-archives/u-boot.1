Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AD3C54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B4E88003;
	Tue, 26 Mar 2024 21:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DFLm2tGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE6C87C62; Tue, 26 Mar 2024 21:06:58 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A5F87E3D
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3688ff3ca52so9374435ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1711483614; x=1712088414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8EEc3adyFE7Wxfe+nLm4ZchWJV+nLrr+8hBvhQE2L0=;
 b=DFLm2tGeTlcTjRQgijJp+pttdslSbvYJQaPIRms2Vp7woH6h6CJ1EKAhVbib2sNrnA
 rZ4bb+UqN1sMBaLS9Po3tFVKWb9HyoeADaLQZn8vrWJVqUW39e5PdozQ8IwkIdSiU1ld
 Ck8M9/W6e6r209fDFh1N5iPC/Sk6I6HCJl2lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711483614; x=1712088414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8EEc3adyFE7Wxfe+nLm4ZchWJV+nLrr+8hBvhQE2L0=;
 b=MXqFZ6Dzrehipt6QB7DI7VEqd+1RHTK6LzVutvIE4spobFpoifs5i+Gmbl8I+fMEZr
 +3R6iP8POw/qypHcMFcgEstDfGB5rLglIAY1/rOAqRthaVNyrObMLteJvcyLeleb54+m
 G26bfKAUTnOorqqn3y5h+qsNx39JhOrDCZoCvNxnlriKeym9tAz+PsLnFnxU0KWnkkI4
 LTao4/THCIdFuaKKpAKc9S9nH5wrlQfF6OUi/H9+e+3eYnviOdMKQj3v1gBFD7MgRahS
 Zipo1bUPDVq3MXOcUrB2AsMtEiP6ENZt945D7B5kLvteiZ4N9v5WXiokMRPvtYQhXZtw
 b9jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvGW0vuBoHn403pO/kK22k7+6HzUOlGkH5p0jpL6S2HUN6ufCvtibvW2tYvBksh25CACa7SQljX0OOnCPGBg+fxH8GGA==
X-Gm-Message-State: AOJu0YxKVaZhEYmx9n7JISpqrkKaJzuv4P0v5AFHH8BG0CDwUM70DmdO
 pQmTjybppMw6GwJnaHYtLavyG6yFri679B/JAcXptm6VNx9ARGf8inL/ww4fNA==
X-Google-Smtp-Source: AGHT+IEEDeZcsz5sXCNnD2ZC6a2Wo23FMused7zzkcdVuJSmg7qZ+plRlZe/HcCYGC8F13GS4tmU/w==
X-Received: by 2002:a05:6e02:1a8f:b0:368:8d20:b18a with SMTP id
 k15-20020a056e021a8f00b003688d20b18amr10568423ilv.29.1711483613849; 
 Tue, 26 Mar 2024 13:06:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 f4-20020a92cb44000000b0036896f76593sm1002343ilq.85.2024.03.26.13.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 13:06:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Rob Herring <robh@kernel.org>, linux-mtd@lists.infradead.org,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] dt-bindings: mtd: fixed-partition: Add binman
 compatibles
Date: Tue, 26 Mar 2024 14:06:45 -0600
Message-Id: <20240326200645.1182803-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326200645.1182803-1-sjg@chromium.org>
References: <20240326200645.1182803-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Mar 2024 21:19:54 +0100
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

Add two compatibles for binman entries, as a starting point for the
schema.

Note that, after discussion on v2, we decided to keep the existing
meaning of label so as not to require changes to existing userspace
software when moving to use binman nodes to specify the firmware
layout.

Note also that, after discussion on v6, we decided to use the same
'fixed-partition' schema for the binman features, so this version
adds a new 'binman.yaml' file providing the new compatibles to the
existing partition.yaml binding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v10:
- Drop binman,entry since it is likely not necessary
- Put the description back

Changes in v8:
- Switch the patch ordering so the partition change comes first

Changes in v7:
- Adjust MAINTAINERS entry
- Put compatible strings into the 'fixed-partition' binding

Changes in v5:
- Add mention of why 'binman' is the vendor
- Drop  'select: false'
- Tidy up the compatible setings
- Use 'tfa-bl31' instead of 'atf-bl31'

Changes in v4:
- Correct selection of multiple compatible strings

Changes in v3:
- Drop fixed-partitions from the example
- Use compatible instead of label

Changes in v2:
- Use plain partition@xxx for the node name

 .../bindings/mtd/partitions/binman.yaml       | 53 +++++++++++++++++++
 .../bindings/mtd/partitions/partition.yaml    | 21 ++++++++
 MAINTAINERS                                   |  5 ++
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 000000000000..bb4b08546184
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman entries
+
+description: |
+  This corresponds to a binman 'entry'. It is a single partition which holds
+  data of a defined type.
+
+  Binman uses the type to indicate what data file / type to place in the
+  partition. There are quite a number of binman-specific entry types, such as
+  section, fill and files, to be added later.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  compatible:
+    enum:
+      - u-boot       # u-boot.bin from U-Boot project
+      - tfa-bl31     # bl31.bin or bl31.elf from TF-A project
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            compatible = "u-boot";
+            reg = <0x100000 0xf00000>;
+            align-size = <0x1000>;
+            align-end = <0x10000>;
+        };
+
+        partition@200000 {
+            compatible = "tfa-bl31";
+            reg = <0x200000 0x100000>;
+            align = <0x4000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 656ca3db1762..bb3c326c6588 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -118,3 +118,24 @@ then:
 
 # This is a generic file other binding inherit from and extend
 additionalProperties: true
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            compatible = "u-boot";
+            reg = <0x100000 0xf00000>;
+            align-size = <0x1000>;
+            align-end = <0x10000>;
+        };
+
+        partition@200000 {
+            compatible = "tfa-bl31";
+            reg = <0x200000 0x100000>;
+            align = <0x4000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a848d6ca67e4..1eeb6ebde21f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3639,6 +3639,11 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
+BINMAN
+M:	Simon Glass <sjg@chromium.org>
+S:	Supported
+F:	Documentation/devicetree/bindings/mtd/partitions/binman*
+
 BITMAP API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
-- 
2.34.1

