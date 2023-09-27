Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935DAE82CBB
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 18:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BA686A3A;
	Wed, 27 Sep 2023 20:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aJWV5Yac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C19803AE; Wed, 27 Sep 2023 20:05:53 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EEE286BD7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 20:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79fb64b5265so301757139f.1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695837950; x=1696442750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4GrqlkQ0I1JKG3CG9kC5zFGUFrlkl3FrQ5k9bmVUJsY=;
 b=aJWV5YacMGyVp8tJK9BSCcf+AsS/3uaZLS10Tl8IdHwRHivvEDfMa74Qjz4JDAoU3y
 xd5hzoC7OqjKLx6ukKAGgHC1TQMDETfl0cM5RqeeMiwPYL4yjyT/JbgZmUvy7d/34yZT
 TpSNUfdhTc1A58ZJIs6UUaVV7b1M4kdNEM0/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695837950; x=1696442750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4GrqlkQ0I1JKG3CG9kC5zFGUFrlkl3FrQ5k9bmVUJsY=;
 b=CYDEDRIPPMhi3D3YAjEU4ONJx6qWO0znbct71YIRJpmeHBHOcrDPZprrLBiwtP5S4/
 1SsL68JvZynADJpKH+EAX9zempCAM2YsYtMTPoP9MRD7diyZ19BC2LjS+4uFrTnoP167
 ZApbNfR8TB7F9mrG/r2jDao0tZL/f9EcmVS6H6tI+hbXKMgsacinSBalU3XPWa3ZtQxu
 uks5KUV4VNL2w/MmsHFedqXDy5Xtrmd+AG7ukiBUHTrv1jKBjfeusYu8WtBI91XG9gmB
 UlDvekc6HkIU0a7uhYf0alfcpbXKNhXlGJ+S0nTOVNRaM1eMboI4KUlKYZveKIH6ZZSz
 g2cQ==
X-Gm-Message-State: AOJu0YwVwwWJhjkIPJnIg+mKLu6Ar8F/9YyLnYblIEUj5C2EFJfoCLT1
 yqEhZrXd0fow83YisZCRDybk1w==
X-Google-Smtp-Source: AGHT+IEaajljv/uey+1Fqd1NIa3A9BpHMaQNWVA3f2Xydq8XNThDYOjFx6Y3UKwlj27CGNI0r8qbOQ==
X-Received: by 2002:a6b:ea10:0:b0:795:13ea:477a with SMTP id
 m16-20020a6bea10000000b0079513ea477amr2843824ioc.8.1695837950050; 
 Wed, 27 Sep 2023 11:05:50 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5d4f:fe51:5575:6f76])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a05663801b100b00439fa6ff6a9sm4032583jaq.70.2023.09.27.11.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 11:05:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, U-Boot Mailing List <u-boot@lists.denx.de>,
 Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nick Terrell <terrelln@fb.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: mtd: fixed-partitions: Add compression
 property
Date: Wed, 27 Sep 2023 12:05:43 -0600
Message-ID: <20230927180545.3522628-1-sjg@chromium.org>
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

Sometimes the contents of a partition are compressed. Add a property to
express this and define the algorithm used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add an example

Changes in v3:
- Just add a compression property for now

Changes in v2:
- Use "binman" for compatible instead of "u-boot,binman"
- Significantly rework the patch
- Use make dt_binding_check DT_SCHEMA_FILES=Documentation/../partitions

 .../mtd/partitions/fixed-partitions.yaml      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 331e564f29dc..058253d6d889 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -29,6 +29,24 @@ properties:
 
   "#size-cells": true
 
+  compression:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Compression algorithm used to store the data in this partition, chosen
+      from a list of well-known algorithms.
+
+      The contents are compressed using this algorithm.
+
+    enum:
+      - none
+      - bzip2
+      - gzip
+      - lzop
+      - lz4
+      - lzma
+      - xz
+      - zstd
+
 patternProperties:
   "@[0-9a-f]+$":
     $ref: partition.yaml#
@@ -64,6 +82,7 @@ examples:
 
         uimage@100000 {
             reg = <0x0100000 0x200000>;
+            compress = "lzma";
         };
     };
 
-- 
2.42.0.515.g380fc7ccd1-goog

