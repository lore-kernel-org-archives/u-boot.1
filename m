Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CD7C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD4488874;
	Mon, 15 Jul 2024 15:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JXs1iFB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283B188865; Mon, 15 Jul 2024 15:56:16 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D035888835
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a79a7d1a0dbso311030766b.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721051773; x=1721656573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zJEofbM7JJv/OPvTziaKTUDT40OBgVWW/o2FBZFQ/8c=;
 b=JXs1iFB0xEGziKum9sNM14sLeaZXxD6ZdU9DhcSVKW03lYFjlakoFP/u4ai2BRCcH6
 DoBMfeeP+Pe5zReIvaG0MW2LHyBgeuu4DNDb+jgeS3q3Q0D8P7FaEk0CNAPmQK6yBDmM
 pN0Zya9dhFofRTMGHJCCgf2TlAoNss5EBc4wZlyv5EDaVRhye2ex8udKtBUgxmjMU3EX
 2VLGS8jnF8UVCN3sITT4NqWpWC+3TdPOrI8kKnySexakaJExlhF6vaMFgF2Pa7n02Jxo
 x3gZRRs5FyqbbPI7+VIJZ4udrdKOnnuytvZrLyHc3BdxakwX2lzI9d12mfqg3eYnNKG7
 MAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721051773; x=1721656573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJEofbM7JJv/OPvTziaKTUDT40OBgVWW/o2FBZFQ/8c=;
 b=oQ7d7OEeVHf2i8lfmBjJN/tg4jRc9CntOU/R09NSkEiyd3z/xqp9Qq6bBqwer1YEwn
 o8mLZsgM1tMnafxj8ZImJxSE5aMJK8KhYsn6f4/m7lZ7kmW9EbOQCinEZIS3kyfRjAdq
 JCSUfZFz/UulQ2X/zrH+BZZZ4fLxhnDWdy4knArWGQQpGjYJBvuxan8tbnWB57kjK2BR
 2mxHh0lyVeziIxWehIrDzcA4YWXZoP7eIPqt/i4DeTaeAAd0qsXnljmgst9XEwld8GXy
 MfUGtsxMBtK3XRXOPl5e2hUS/rPwWmofNVrJsZwSwCj+9iK5GLIMVh4F8zvzr1BQDvNi
 aEJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQHjfpzoGTLSHUSw6fOYRPISyXhEFk6B9/C7t22QaTtl+pg0WNMaeibLpNBQaV/fRSPEvxLT9WhMws1DelsfyVaTWneA==
X-Gm-Message-State: AOJu0YzrJ8FoMfy07pQ4pEbkU79Otr5wF6+xyOnvjRIckKc+ZYzK0spM
 IqqGWaPaIwrTSzrLH0I+fcui9wHcVC1ejoDEHzh+6uHNweWSyYMZ
X-Google-Smtp-Source: AGHT+IGFwyv96gykRh2WQAFospTSXU2UQACz9q8YtryxBrJrikNX9BsuYSLrXYopy2ZsFmRYUjaEzg==
X-Received: by 2002:a17:906:2797:b0:a77:c5e4:eebf with SMTP id
 a640c23a62f3a-a780b87ef50mr1185426566b.54.1721051773034; 
 Mon, 15 Jul 2024 06:56:13 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc820fb5sm214152666b.212.2024.07.15.06.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:56:12 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: nvmem: convert U-Boot env to a layout
Date: Mon, 15 Jul 2024 15:54:33 +0200
Message-Id: <20240715135434.24992-1-zajec5@gmail.com>
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

U-Boot environment variables can be stored in various data sources. MTD
is just one of available options. Refactor DT binding into a layout so
it can be used with UBI volumes and other NVMEM devices.

Link: https://lore.kernel.org/all/20231221173421.13737-1-zajec5@gmail.com/
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
I'm resending this approved by Rob PATCH in a proper series

 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
 .../nvmem/{ => layouts}/u-boot,env.yaml       | 39 ++++++++++++++++---
 2 files changed, 35 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (75%)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index 3b40f7880774..382507060651 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -21,6 +21,7 @@ oneOf:
   - $ref: fixed-layout.yaml
   - $ref: kontron,sl28-vpd.yaml
   - $ref: onie,tlv-layout.yaml
+  - $ref: u-boot,env.yaml
 
 properties:
   compatible: true
diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
similarity index 75%
rename from Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
rename to Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
index 9c36afc7084b..56a8f55d4a09 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
+$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: U-Boot environment variables
+title: U-Boot environment variables layout
 
 description: |
   U-Boot uses environment variables to store device parameters and
@@ -21,9 +21,6 @@ description: |
   This binding allows marking storage device (as containing env data) and
   specifying used format.
 
-  Right now only flash partition case is covered but it may be extended to e.g.
-  UBI volumes in the future.
-
   Variables can be defined as NVMEM device subnodes.
 
 maintainers:
@@ -42,6 +39,7 @@ properties:
         const: brcm,env
 
   reg:
+    description: Partition offset and size for env on top of MTD
     maxItems: 1
 
   bootcmd:
@@ -58,6 +56,17 @@ properties:
         description: The first argument is a MAC address offset.
         const: 1
 
+allOf:
+  - if:
+      properties:
+        $nodename:
+          not:
+            contains:
+              pattern: "^partition@[0-9a-f]+$"
+    then:
+      properties:
+        reg: false
+
 additionalProperties: false
 
 examples:
@@ -101,3 +110,23 @@ examples:
             };
         };
     };
+  - |
+    partition@0 {
+        reg = <0x0 0x100000>;
+        label = "ubi";
+        compatible = "linux,ubi";
+
+        volumes {
+            ubi-volume-u-boot-env {
+                volname = "env";
+
+                nvmem-layout {
+                    compatible = "u-boot,env";
+
+                    ethaddr {
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.35.3

