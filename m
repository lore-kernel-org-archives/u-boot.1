Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C96C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69FBE8861D;
	Sat,  6 Jul 2024 00:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LOFvUiH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC5588629; Sat,  6 Jul 2024 00:58:41 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEBC6885AE
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-58b447c51bfso2684070a12.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720220319; x=1720825119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FiMeeVhiLcAlXej3uBvwyk/ojiuyjSIG1S2ztz0XYNs=;
 b=LOFvUiH3oqUpvVr0grqmOSSayVm852i/7gN6WJG1SG5a6Ds6jlY5AbPTN11sJgUAGg
 jeMjV2muLJXbdRiSQEkVaiUJAojsHU7jOk9sL3d/cjHCSD1ftofWVzLG5OwnPTuPxXxt
 N3GWGNUViSo/KLsea3qANEe/nsG+B18yyyEn7PCwCk8zj/8HojXa+rqBQuhOIa+Xxvyg
 6udOpkz65Yz1NOCY08hBnnFdsD4tsirHFpQpPCETZAdsvfXTRZf9CPlFcAMwV8i5Hbnt
 EqhD6xynzdFuQ1aPYPCF77tWdI7FmzHxsw355nrTQdLkIY1gDEXUKtUNPj5HKKFSs3vA
 oX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720220319; x=1720825119;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FiMeeVhiLcAlXej3uBvwyk/ojiuyjSIG1S2ztz0XYNs=;
 b=w9HtM1GeQLop6KkbcYb7KlvPib9FZs/Jswx85EvrfnGFRp+pb+1qOtjOKuVOAfEMjW
 t4gOdRV+7arr2cw3Qe+SgOg34rgRoFyrPsloj2keTSA8y4HKXICP1aKH6nEwTY9R7KZX
 bbFLirwlqxCuvQbklfQdDvhV8S/NGVmgutX2p8XhAx0ejXmCJJ3urGqQkg2bBWk5+Mgq
 Wqn+UBjmbKAYWeHRKFQwRLgdm9OLulfRd2Xr5hsXELl/Tgwwq2oFfx369GuFS8SvRC7E
 VZ5KPZb79mchESXeFXFlhRsWhxmXT6pdHXJqQ9Jg5ABLbW+eHDgPgss0vMWQ0kBBX8IE
 qASQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgEsbw7puL9wqn7arc93A6Yd8q+nAGk8PXQHZR32Edbi61ktNcxJ4fLGx0XU42dGfqBtUdypyPyFxrbQ8xDgB0QmyDzQ==
X-Gm-Message-State: AOJu0YxkxSji6ShjdylCSCULaQQg2oM1JVuXom3052/J9rnbsIGPTvyJ
 mEV9O/lrpC7kA/BHEeiSnTuOkrd4nabJ1mFriEtkrDhEG/sCNZPt
X-Google-Smtp-Source: AGHT+IF/EnTZ+25wxqkBsWXqxU8jobntZQ97ZpwWquicNED9QnU285ETFWo0voXR6AyZFnJzN7nEIA==
X-Received: by 2002:a05:6402:254a:b0:586:6365:b3cf with SMTP id
 4fb4d7f45d1cf-58e596592cbmr4608643a12.10.1720220318886; 
 Fri, 05 Jul 2024 15:58:38 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861381868csm10052128a12.55.2024.07.05.15.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:58:38 -0700 (PDT)
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
Subject: [PATCH] dt-bindings: nvmem: convert U-Boot env to a layout
Date: Sat,  6 Jul 2024 00:58:21 +0200
Message-Id: <20240705225821.13196-1-zajec5@gmail.com>
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
---
I'm sending this PATCH without Linux changes to see if this is the
right approach - for developers and (DT) maintainers to review it first.

My previous attempt (see above Link) turned out in refusal so I'm just
trying to save some time in case this one goes wrong as well.

Hopefully the included example (which I really think we should add)
explains well how I think this binding should be used with layouts.

If I get some positive feedback I'll work on V2 with actual Linux
changes.

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

