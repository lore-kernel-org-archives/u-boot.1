Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C60C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 17:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5B6874EA;
	Thu, 16 Nov 2023 18:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cZaITHqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA374874F6; Thu, 16 Nov 2023 18:29:18 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DED64874DB
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 18:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35932aa21a3so4004125ab.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 09:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700155745; x=1700760545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SiGKNWTogg5s8I4hI4hsWN1in2XeMZfNUWjSe8vt1c=;
 b=cZaITHqFX0dnatxvzR0yoEc/b6XHvSK54cXJoThFrGG7CregBQNa7zbfSsyqr2GXO6
 4yxkt7H83kMPz4rQJOj3A4lFieAnPDl2udOXFWHltNBt2HMgwAQwn/oKgUJUD1vuEK+G
 x330AXmm81VxZd3K11lYKHstKbQi//3srRGv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700155745; x=1700760545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SiGKNWTogg5s8I4hI4hsWN1in2XeMZfNUWjSe8vt1c=;
 b=kTXJlXo4IzANIi2ceTIBcKwLEadd+3h2bgYsOvtUWRLyfOJWhugPqFiaC34SKRMGUN
 orYwXX6vehB+xe0CgVXzUQDggHHC2u0MJVOKHlJFy40U7aTaZkp/qiGRIBO7nkwwnvH/
 Kt9/vVjmonRQSK7dbthvD2JyVl2rAo2g7dU9L/3DKuKXrdbNCO3CH4dOeyDPAT3MNv0D
 fANnpbkfcbjC0bZOXJ2Fl+Mi6o+R6unOX5Ti5aZ7US13gFtLPYiR9E/EyIgcCRFfgHVy
 v3FtzAdxhWoFnbUQj3V2s883c+BkI9d6zlrVpiRMwg9QuKlCtS1092czgQemzREKcm8c
 lz3A==
X-Gm-Message-State: AOJu0YwMI1lCCjZE6ZCQwnKbM0CweeQY53qiGAp9gp7nf20sT6665Kb+
 8QfqdhygXaY9Vlf5KIdm5F6D8nN/E/d70gnc4mnsbw==
X-Google-Smtp-Source: AGHT+IGaQokizqpcI2eRtxwCmzms3L1z6RJ8KYtnH3CEjTb902LoLcNtEnVdFaWX+2iO6b6M/mjAaA==
X-Received: by 2002:a05:6e02:1c07:b0:359:5b5c:9ce4 with SMTP id
 l7-20020a056e021c0700b003595b5c9ce4mr22860439ilh.19.1700155745274; 
 Thu, 16 Nov 2023 09:29:05 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a056e02092800b0035ab8cc4a4bsm1914348ilt.17.2023.11.16.09.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 09:29:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
 Michael Walle <mwalle@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Date: Thu, 16 Nov 2023 10:28:51 -0700
Message-ID: <20231116172859.393744-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116172859.393744-1-sjg@chromium.org>
References: <20231116172859.393744-1-sjg@chromium.org>
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

Add two compatible for binman entries, as a starting point for the
schema.

Note that, after discussion on v2, we decided to keep the existing
meaning of label so as not to require changes to existing userspace
software when moving to use binman nodes to specify the firmware
layout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

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

 .../mtd/partitions/binman-partition.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..83222ac9aa78
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman partition
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  This corresponds to a binman 'entry'. It is a single partition which holds
+  data of a defined type.
+
+  The vendor is specified as binman since there are quite a number
+  of binman-specific entry types, such as section, fill and files,
+  to be added later.
+
+allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  compatible:
+    enum:
+      - binman,entry # generic binman entry
+      - u-boot       # u-boot.bin from U-Boot project
+      - tfa-bl31     # bl31.bin or bl31.elf from TF-A project
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            compatible = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition@200000 {
+            compatible = "tfa-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.43.0.rc0.421.g78406f8d94-goog

