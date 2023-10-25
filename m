Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A4EC25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 21:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9D587A97;
	Wed, 25 Oct 2023 23:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hOCfdbz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC8287A95; Wed, 25 Oct 2023 23:06:59 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECC886F9E
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 23:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so1135855ad.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698268013; x=1698872813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pF/ordmyMYgWe1Uu/l3iCAlozeYeU+RXukpZaUtD30Y=;
 b=hOCfdbz9fkyEqCaw4u/v0iTxjsHw/oKW8sikn7x83CAgVw4ksRS9dTHLeGSQpiztmp
 HbMFkUFXBFj103GNOFedm7xDk937GAprgHPKqzDZT3oJIk6XihQPki4bNxTS7ZZfrUS6
 koP+Hxfd4xy6pqgRYkQc5FvO5GFdaO28YkhVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698268013; x=1698872813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pF/ordmyMYgWe1Uu/l3iCAlozeYeU+RXukpZaUtD30Y=;
 b=h8y6EulNMdFH39wJB1z33CD+KrN5b9oI4Kg+ViNhSxNiRx6hnLOxwizS3bdm5BOv0B
 ctBA86c3DPNdrfCA2NCM0e1AsT/J1/LmkdExr49jC47eBGX4KDhKziFHwNGgYTNZ6Igm
 JAoejvuQgwqsLzPvye7CZWQDqaIKy9SbcBXIGihwXUQgsqOp1aGbiSdkw6yMGBoax+ET
 qPD68VYcY5KraX/AWkcS9EzmR8XBGF621jh1/wgSUj6DtkScLRiWD5RkcMfxk+eMnlfb
 n4Xvkbtteh27ELOdq/9XDSgIU2ByHWziYHaUY/tsxU423TmtA8uuA0Nz4SeA4NEeA4hU
 X+9w==
X-Gm-Message-State: AOJu0YybkcikSBMQJBo51ubYZ17hAIxFbXPLMOb5x5KKLIcqAwprq5rO
 L5B/XaAi85ZGBQ0mbRUVu2uiow==
X-Google-Smtp-Source: AGHT+IEYJE06QosRYGT0A1ENbZcTTEfgZ/obEURE1Bi+knZeZm3lfZ+35MZQ58edxdw31TbPoPLpDg==
X-Received: by 2002:a17:903:2342:b0:1c9:dff6:58f2 with SMTP id
 c2-20020a170903234200b001c9dff658f2mr16108624plh.59.1698268013528; 
 Wed, 25 Oct 2023 14:06:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 ix4-20020a170902f80400b001bc5dc0cd75sm9689447plb.180.2023.10.25.14.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 14:06:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Rob Herring <robh@kernel.org>, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Date: Thu, 26 Oct 2023 10:06:11 +1300
Message-ID: <20231025210616.3201502-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231025210616.3201502-1-sjg@chromium.org>
References: <20231025210616.3201502-1-sjg@chromium.org>
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
2.42.0.758.gaed0368e0e-goog

