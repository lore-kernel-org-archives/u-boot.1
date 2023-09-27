Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137C0E82CB0
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 16:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6398C86E02;
	Wed, 27 Sep 2023 18:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DD2y5a3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8900886E05; Wed, 27 Sep 2023 18:47:29 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7060586BD7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 18:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-35133097583so26361795ab.1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695833246; x=1696438046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xi0NPAXOKB2g4KhPtyHEVHOc+BFF5U0uejfT8FKn0j4=;
 b=DD2y5a3wtB/ob71q2OlZN6UOSQHqrbHwrofT8SVwx5NhwBiYbejLhO4mDaWhZetz+Z
 9RDDvw2xGseAV3sGedvuTtbua/RUz7bsUnR7pcOSISavRbaAE4wLA5Yn1b7f+j1Xki7y
 qCHKqiI8T4h09RpwAQ2AjU5OirhlZ8YPaiAEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695833246; x=1696438046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xi0NPAXOKB2g4KhPtyHEVHOc+BFF5U0uejfT8FKn0j4=;
 b=Sp8uzvP96RfNTbap9YxwAFaXVzP/FTJ6Gpzp1aX1DWOVRrgpFBIxuNJvrrRH5WlSgR
 QREmCDjXeGBBNjooApYaVUhL5rK+W2Ee0NKCxl0tVnZHCCkmtfjsVauo03jFJoUC5bNM
 GDRJJr22Vmu3z6ENkKU22Dc4M8fFvmRNdtw4OcpxNCdAHolkpVtsf3YUUvhwGMCNaBVU
 EeKjnpWjKloQdtMqrooTe6vB+ybL7dBNB/5LA8CmUM771c7wac9ooRI9PIF2Ph0Y9xbP
 UsC2KtmbwWOCZCDlOBdwIdSIC18yS7tLcoC4e1r08ogr/aSQebR5kEOlgbQo26h3faB9
 dQLw==
X-Gm-Message-State: AOJu0YxBRmBg/ak9UFBrtPHeOGSgUKnA2bfeQVJz0YHZwM62pJ8W/Xq+
 ix+U0w7Yl9LD0XoLYVslkzxPEQ==
X-Google-Smtp-Source: AGHT+IH+JcaNhVNz7FfFGoWF8iw2OSTtskunRegjjj1eGuC9QOYwU8eTORJoA1lvodxfPDArPEpPZw==
X-Received: by 2002:a05:6e02:12c5:b0:34c:ecc8:98e7 with SMTP id
 i5-20020a056e0212c500b0034cecc898e7mr3216823ilm.9.1695833246163; 
 Wed, 27 Sep 2023 09:47:26 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5d4f:fe51:5575:6f76])
 by smtp.gmail.com with ESMTPSA id
 ei25-20020a05663829b900b00439eda8c1c1sm3980500jab.111.2023.09.27.09.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 09:47:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Rob Herring <robh@kernel.org>, linux-mtd@lists.infradead.org,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nick Terrell <terrelln@fb.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: mtd: fixed-partitions: Add compression
 property
Date: Wed, 27 Sep 2023 10:46:51 -0600
Message-ID: <20230927164654.3397353-1-sjg@chromium.org>
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

Changes in v3:
- Just add a compression property for now

Changes in v2:
- Use "binman" for compatible instead of "u-boot,binman"
- Significantly rework the patch
- Use make dt_binding_check DT_SCHEMA_FILES=Documentation/../partitions

 .../mtd/partitions/fixed-partitions.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 331e564f29dc..13ff313cabda 100644
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
-- 
2.42.0.515.g380fc7ccd1-goog

