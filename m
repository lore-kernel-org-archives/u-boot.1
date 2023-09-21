Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFE9E7D0A2
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 18:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE105869F1;
	Thu, 21 Sep 2023 20:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l832ZPKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0BA986BEC; Thu, 21 Sep 2023 20:45:28 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E1FE869F1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 20:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79f7e7342e3so47969339f.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695321925; x=1695926725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DnKiy3ihwgd/VOoqSanohGN5ffhK+cZ/VpjdYKJUjf8=;
 b=l832ZPKwAszo8A4z+F4IunJy6zr8PT+K58IfkKifkq5loiVpzv9j3HzEKenT8TEEQW
 aw6vacJMjAU22WOMcoqA8OI+HhVCpP/VBeo9SKj9Bh5m1GcdJzfDPYHY4+yMPOAmfSa4
 R5JTeQmHW9ZO6agGPnCM2Miw1BmcZ1r182B4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695321925; x=1695926725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnKiy3ihwgd/VOoqSanohGN5ffhK+cZ/VpjdYKJUjf8=;
 b=rLLtSF5JDxelDs+B7ZPiYy2ALJwxxfKYAaROU3dZB2gvQ/1CO7QemFGYUEmipbYtOs
 JYQehFbWIAjbUjS8tdOaezNUiGxXc5hg4S0fdB/ACSjr+L7IqQ+ImvIlkYX/RP7N6ku6
 Tw5yKUJUAMR84Szpbva2vJMvWKLDz5dcCxffyoXivtlGhqNh6L5UtztQW+PFY1+PDOEX
 6yEMMilQc5e8WjmeK1p8uhqkXooemhUvd7tC8tboyCOia72gwVtfEzdBa01YwO/lYvd+
 awG6lUieXxM28CrQaoOFhn6Wxk5rC23UeH7Bxh7PX9RQOI0MTRV1xZVSQnHqByjZEIC2
 G8OQ==
X-Gm-Message-State: AOJu0YyJVesIl/819AbfpQcZ/Ni8V565E5RFKPgMtbpIBzMs9KxMkwm9
 f2ugLr9o+9KbWsE5/3ijIQ5bbg==
X-Google-Smtp-Source: AGHT+IFLx+QxNqVoEsIFpwCXXYW/u8hYUS5LzSu0VrhuBFkVi/scOpz5E7kCyC+9y88eBDeWXVQ/9A==
X-Received: by 2002:a6b:7303:0:b0:787:34d:f223 with SMTP id
 e3-20020a6b7303000000b00787034df223mr7074088ioh.11.1695321924839; 
 Thu, 21 Sep 2023 11:45:24 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a636:e615:ea83:bc42])
 by smtp.gmail.com with ESMTPSA id
 d26-20020a02a49a000000b004290fd3a68dsm511017jam.1.2023.09.21.11.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 11:45:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, linux-mtd@lists.infradead.org,
 Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Dhruva Gole <d-gole@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: Add a schema for binman
Date: Thu, 21 Sep 2023 12:45:14 -0600
Message-ID: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

Binman[1] is a tool for creating firmware images. It allows you to
combine various binaries and place them in an output file.

Binman uses a DT schema to describe an image, in enough detail that
it can be automatically built from component parts, disassembled,
replaced, listed, etc.

Images are typically stored in flash, which is why this binding is
targeted at mtd. Previous discussion is at [2] [3].

[1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
[2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
[3] https://www.spinics.net/lists/devicetree/msg626149.html

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../bindings/mtd/partitions/binman.yaml       | 50 +++++++++++++++
 .../bindings/mtd/partitions/binman/entry.yaml | 61 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 MAINTAINERS                                   |  5 ++
 4 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 00000000000000..c792d5a37b700a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,50 @@
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
+description: |
+  The binman node provides a layout for firmware, used when packaging firmware
+  from multiple projects. For now it just supports a very simple set of
+  features, as a starting point for discussion.
+
+  Documentation for Binman is available at:
+
+  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
+
+  with the current image-description format at:
+
+  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
+
+properties:
+  compatible:
+    const: u-boot,binman
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      binman {
+        compatible = "u-boot,binman";
+
+        u-boot {
+          size = <0xa0000>;
+        };
+
+        atf-bl31 {
+          offset = <0x100000>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
new file mode 100644
index 00000000000000..8003eb4f1a994f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman/entry.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman entry
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+description: |
+  The entry node specifies a single entry in the firmware.
+
+  Entries have a specific type, such as "u-boot" or "atf-bl31". If the type
+  is missing, the name is used as the type.
+
+  Note: This definition is intended to be hierarchical, so that entries can
+  appear in other entries. Schema for that is TBD.
+
+properties:
+  $nodename:
+    pattern: "^[-a-z]+(-[0-9]+)?$"
+
+  type:
+    $ref: /schemas/types.yaml#/definitions/string
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Provides the offset of this entry from the start of its parent section.
+      If this is omitted, Binman will determine this by packing the enclosing
+      section according to alignment rules, etc.
+
+  size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Provides the size of this entry in bytes. If this is omitted, Binman will
+      use the content size, along with any alignment information, to determine
+      the size of the entry.
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      binman {
+        compatible = "u-boot,binman";
+
+        u-boot {
+          size = <0xa0000>;
+        };
+
+        second-area {
+          type = "atf-bl31";
+          offset = <0x100000>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747bd7..849fd15d085ccc 100644
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
index a4c30221eb305d..ebcbfb4292e8dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3505,6 +3505,11 @@ F:	Documentation/filesystems/bfs.rst
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

