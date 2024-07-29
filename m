Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC25DC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 595D8887DB;
	Mon, 29 Jul 2024 10:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V4qimzYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB873887D6; Mon, 29 Jul 2024 10:08:03 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95781887C0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a15c2dc569so3025764a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722240481; x=1722845281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rl8HdNLgtv5Fxv2Nk9Of+lDPOeD8hPV7F8FWHfhtTmU=;
 b=V4qimzYc0AJ+kDbQX2Dw/34Mu/VaTRPzPt1bn6f0m/jTZS88N2pSAEg9j+Yhtyzw5D
 YpzCcF/hS8MxlJ4nxw0cPJdcVDFnniUGPNL2fK8TijjcHz0Je4ATtcQymBq5k8CGDjBJ
 vA77rnIOso4kFp7nd9OV2fiawLi/NV3nYY0kRu9TQwQ99aluOPMl/8CI6IN6Etut36Lg
 rcFWRbgZ9iE8E7f69MVSM0/lPWF3usOcUU8fl1h+eTBSxEeOKJBNdSOHV3hNqdzw+H4s
 hG0XZfVgrOHSlP+xLy180OlZ1gdOOvelnDm/HSjwypP8LkFhRSaGWjj2LMKvoY4l95PH
 NsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722240481; x=1722845281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rl8HdNLgtv5Fxv2Nk9Of+lDPOeD8hPV7F8FWHfhtTmU=;
 b=PqqH8riTnFacY5oetDEWw95FwqWbWkg1qMsSWg7G3ua9oAAKPycunU3vOh5UYIfsZS
 UUp0sfqB1WEeIWeiCVY36/E8vvafSpH8l/H1KcY6bpJC8MgzGDh8R1Kf9IlyTGVM6jOx
 nn12dyggYutlFHy86CHWURsUfwUeorJZS73ZYpnP/gNkKxOHr9n2aW3DnqwWAduvGAhE
 s/vom61JHrsJTHRp+JNtozUAtTpcbOrbDRdBe9E+3hR/7oFkKcf4b9/C6J8Ny1ps2Ni4
 8Hv2P7l7UfH+zYCJSzUWNmlxvQjZUhLYeX2tFd0C/iPBpD45djw9NRviFLeglFC5DTqi
 ZPTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhcZIGYGLDXEYqrRZb097DObD2oP/RYOO5+3WXp4p4BW8/YgaQNdLClFYxVoM2lKeGruq1qZtK7dKdtubX/q+szXeUHg==
X-Gm-Message-State: AOJu0YzggJd9N0S1qC8O/tRJg7Xtqvy6fdEvbhnbsFb6aWE7mMjZmFTY
 y6dHWsIJMF1JrDBlSpGMbywUJs1FZU5AYmeJuF35Yqeu8CI4J3qF
X-Google-Smtp-Source: AGHT+IGSPZPkd0loh76eNxSCbXh4tWMsSkZqipMIwMD0/JvF8wieYG1nkZYy/AvmyWaLsR5QnAao4Q==
X-Received: by 2002:a05:6402:51cc:b0:5a1:de88:a5ef with SMTP id
 4fb4d7f45d1cf-5b02317f4c0mr5275599a12.27.1722240480627; 
 Mon, 29 Jul 2024 01:08:00 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590cedsm5352868a12.29.2024.07.29.01.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 01:08:00 -0700 (PDT)
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
Subject: [PATCH V2 2/3] dt-bindings: nvmem: convert U-Boot env to a layout
Date: Mon, 29 Jul 2024 10:07:32 +0200
Message-Id: <20240729080733.16839-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240729080733.16839-1-zajec5@gmail.com>
References: <20240729080733.16839-1-zajec5@gmail.com>
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

