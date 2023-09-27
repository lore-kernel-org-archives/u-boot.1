Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6EBE82CCF
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 20:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED2986DD6;
	Wed, 27 Sep 2023 22:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gK2p5It2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3572586DDF; Wed, 27 Sep 2023 22:21:12 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC3A86484
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 22:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fe6da0049so127134739f.1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695846068; x=1696450868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IIjs+rwErzRuI8OpZgfCnKlE1NGemok/NR/4pjhGmqU=;
 b=gK2p5It2BLcUJGHfre/i25p+T4HYfxJ9PDchuyoNxZHnslBmYvGVuqeZmRydpkgpOJ
 kexkJo7r8PtW2YPo9kEM6fP1hF/EPOrEwkkcAOhNFOIppTM/Zp0pqThRtlaZwsnHsyQE
 BeEzXs3j3+Snt6SC7g2lo8ohOOjrLsYoel7ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695846068; x=1696450868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IIjs+rwErzRuI8OpZgfCnKlE1NGemok/NR/4pjhGmqU=;
 b=ZnKhifqUi7se7PmeIvAhKJle7FkH7k+1Q7GMfmFPgoezm1Lhm1K/H1oEDcG/zcTV2H
 VrvS6mRgrFOzaJU/Gj//JG/xpuX8YSfBHq8+3CWg8Qli2Xwyg5CWN59U5gbavKoDAR3u
 pEhTc7LI9qCA6jeBU4pSje/IBqo2v2IHgOGmuFzIax0xDfA4HPuB0teDBEV18uvHET+6
 +SA38RP47i8kXEDbkDa2mSKBWRyc4WLKFCULSRtNt9I43XimWxh8hwSGor58aC8s9r+a
 WqSL+FtGv2NMnkG69Ebu2QiA49SZcvvEP9Hhz2yjhEG+DuoR2WUQLRft3ewtzuvw5GES
 8/dg==
X-Gm-Message-State: AOJu0YzCTVLEu+Bb6o0El19hppBa27qthHo2SQ6yM/daSOGTCKe5CuDZ
 XXD5umUIDhb+SiZihewmP6QjXw==
X-Google-Smtp-Source: AGHT+IE/xm+sDlsbj5TMwcIX6s89wG1zzgEzTIKDltB0ZdFPBg7kOF1N3Y/GeFEAB8keQ7aPZmfbKQ==
X-Received: by 2002:a5e:dd02:0:b0:79a:b526:2f1c with SMTP id
 t2-20020a5edd02000000b0079ab5262f1cmr3230494iop.21.1695846067982; 
 Wed, 27 Sep 2023 13:21:07 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5d4f:fe51:5575:6f76])
 by smtp.gmail.com with ESMTPSA id
 ei15-20020a05663829af00b0042fec8620e4sm4113299jab.57.2023.09.27.13.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 13:21:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Dhruva Gole <d-gole@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <ptyadav@amazon.de>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: mtd: fixed-partitions: Add binman compatible
Date: Wed, 27 Sep 2023 14:20:51 -0600
Message-ID: <20230927202057.3676497-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

Add a compatible string for binman, so we can extend fixed-partitions
in various ways.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../bindings/mtd/partitions/binman.yaml       | 49 +++++++++++++++++++
 .../mtd/partitions/fixed-partitions.yaml      |  6 +++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 MAINTAINERS                                   |  5 ++
 4 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 000000000000..34fd10c1a318
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman firmware layout
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+select: false
+
+description: |
+  The binman node provides a layout for firmware, used when packaging firmware
+  from multiple projects. It is based on fixed-partitions, with some
+  extensions.
+
+  Documentation for Binman is available at:
+
+  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
+
+  with the current image-description format at:
+
+  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
+
+allOf:
+  - $ref: /schemas/mtd/partitions/fixed-partitions.yaml#
+
+properties:
+  compatible:
+    const: binman
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "binman", "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition-u-boot@100000 {
+            label = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 331e564f29dc..1c04bc2b95af 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -14,6 +14,9 @@ description: |
   The partition table should be a node named "partitions". Partitions are then
   defined as subnodes.
 
+  The Binman tool provides some enhanced features, so provides a compatible
+  string to indicate that these are permitted.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
@@ -24,6 +27,9 @@ properties:
       - items:
           - const: sercomm,sc-partitions
           - const: fixed-partitions
+      - items:
+          - const: binman
+          - const: fixed-partitions
 
   "#address-cells": true
 
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..849fd15d085c 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -15,6 +15,7 @@ maintainers:
 
 oneOf:
   - $ref: arm,arm-firmware-suite.yaml
+  - $ref: binman.yaml
   - $ref: brcm,bcm4908-partitions.yaml
   - $ref: brcm,bcm947xx-cfe-partitions.yaml
   - $ref: fixed-partitions.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index 5f18c6ba3c3c..367c843ec348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3517,6 +3517,11 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
+BINMAN
+M:	Simon Glass <sjg@chromium.org>
+S:	Supported
+F:	Documentation/devicetree/bindings/mtd/partitions/binman*
+
 BITMAP API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
-- 
2.42.0.515.g380fc7ccd1-goog

