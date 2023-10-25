Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6133CC25B6E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 21:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C34A87AB0;
	Wed, 25 Oct 2023 23:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m6hTgBHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F3187A95; Wed, 25 Oct 2023 23:07:04 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BD287AA2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 23:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc04494653so1044725ad.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698268019; x=1698872819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IdohqfpG/gdF3wirCpdcxePGouLjdXX9N31xMFKe2w=;
 b=m6hTgBHJwoqPKJcnWAw2kTXbhiWDnGNe9xhp766Al++t6D1ZNzxg5Rbl+yCsnX+15w
 Qk/3hSx3hJpZRooZln8PUhXyd+vAr6xMCPbA+kU+SOVgHiauvvDxzXzJXR0qpvYbvIVa
 CuybFXGgbFCF9N4/0/qCeOwR9z3utrKHDM5h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698268019; x=1698872819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IdohqfpG/gdF3wirCpdcxePGouLjdXX9N31xMFKe2w=;
 b=XN8s61rkEYmMSXN7AXh/d4ueSl7+Pzn5ZogLLvYOvjkufW0b0bRtp5yOG3zq8mymsU
 BC4JiT/sQipXa8JAm4OgPNsFNVcPs3Zon+f7n+NlfzX08wwrwacy4MNap9Y2kQmuNXMw
 qTdPDkEMROGR0C761mHNaJiKycw2t9vgCoH8DflzouEm9ez/Ofr+0uY1B1nd3+Q5b4KZ
 HZ37Ub5GNhEoWfUoa5A0MlqQxk1bdR5URjWsLKn63NR1pxKI4QvfRkG0lds6Pt1CwWQb
 l/r28SN8jIZ94WC5XrgJV5eMthb8o9j+q7J8iBZSnCinNLNbDJPa9LfjJIhQIHHsC6Fc
 QQjw==
X-Gm-Message-State: AOJu0YxdafnqZ9a9SHlru5yQYdDZjgVfwlBTJHHjiz2Mx0e7DXhJJR9Y
 mj5nNWUURt7ge8NB2QDHvTmi+jmgxfdTuc5Sm51csA==
X-Google-Smtp-Source: AGHT+IFnYu/xqKemRScJTcQjBe6USxgn3fG2r+kl8UXZa4BqRGhtLWHTLuta2cTb0ciL0LID92X1Rw==
X-Received: by 2002:a17:903:110d:b0:1c9:e508:ad43 with SMTP id
 n13-20020a170903110d00b001c9e508ad43mr15865350plh.8.1698268019179; 
 Wed, 25 Oct 2023 14:06:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 ix4-20020a170902f80400b001bc5dc0cd75sm9689447plb.180.2023.10.25.14.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 14:06:58 -0700 (PDT)
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
Subject: [PATCH v6 3/3] dt-bindings: mtd: binman-partitions: Add alignment
 properties
Date: Thu, 26 Oct 2023 10:06:12 +1300
Message-ID: <20231025210616.3201502-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231025210616.3201502-1-sjg@chromium.org>
References: <20231025210616.3201502-1-sjg@chromium.org>
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

Add three properties for controlling alignment of partitions, aka
'entries' in binman.

For now there is no explicit mention of hierarchy, so a 'section' is
just the 'binman' node.

These new properties are inputs to the packaging process, but are also
needed if the firmware is repacked, to ensure that alignment
constraints are not violated. Therefore they are provided as part of
the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v6:
- Correct schema-validation errors missed due to older dt-schema
  (enum fix and reg addition)

Changes in v5:
- Add value ranges
- Consistently mention alignment must be power-of-2
- Mention that alignment refers to bytes

Changes in v2:
- Fix 'a' typo in commit message

 .../mtd/partitions/binman-partition.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
index 83222ac9aa78..2bc80c24bb9b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -33,6 +33,57 @@ properties:
     minItems: 1
     maxItems: 2
 
+  align:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment of the entry in bytes.
+
+      The entry offset is adjusted so that the entry starts on an aligned
+      boundary within the containing section or image. For example ‘align =
+      <16>’ means that the entry will start on a 16-byte boundary. This may
+      mean that padding is added before the entry. The padding is part of
+      the containing section but is not included in the entry, meaning that
+      an empty space may be created before the entry starts. Alignment
+      must be a power of 2. If ‘align’ is not provided, no alignment is
+      performed.
+
+  align-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment of the entry size in bytes. It must be a power
+      of 2.
+
+      For example, to ensure that the size of an entry is a multiple of 64
+      bytes, set this to 64. While this does not affect the contents of the
+      entry within binman itself (the padding is performed only when its
+      parent section is assembled), the end result is that the entry ends
+      with the padding bytes, so may grow. If ‘align-size’ is not provided,
+      no alignment is performed.
+
+  align-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment (in bytes) of the end of an entry with respect
+      to the containing section. It must be a power of 2.
+
+      Some entries require that they end on an alignment boundary,
+      regardless of where they start. This does not move the start of the
+      entry, so the contents of the entry will still start at the beginning.
+      But there may be padding at the end. While this does not affect the
+      contents of the entry within binman itself (the padding is performed
+      only when its parent section is assembled), the end result is that the
+      entry ends with the padding bytes, so may grow. If ‘align-end’ is not
+      provided, no alignment is performed.
+
 additionalProperties: false
 
 examples:
@@ -45,10 +96,13 @@ examples:
         partition@100000 {
             compatible = "u-boot";
             reg = <0x100000 0xf00000>;
+            align-size = <0x1000>;
+            align-end = <0x10000>;
         };
 
         partition@200000 {
             compatible = "tfa-bl31";
             reg = <0x200000 0x100000>;
+            align = <0x4000>;
         };
     };
-- 
2.42.0.758.gaed0368e0e-goog

