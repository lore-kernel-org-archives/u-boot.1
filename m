Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48207C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 16:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECD8881F6;
	Fri, 12 Apr 2024 18:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mzKh5rGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07C8881A8; Fri, 12 Apr 2024 17:32:55 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9844880A8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 17:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7c8ad87b2acso28812339f.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1712935972; x=1713540772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uqDcmcdfEAxpSmSYIoRjoyegxjm8YY6DAayxwa7eB28=;
 b=mzKh5rGGHJC0i7oKLP4uQaPezdSh8InJ4sXw/sDgMjQvYYfxCG9sbdLMeAV4pumyAs
 K9GO3gOy9RZULFGlIBEy63o6majxsNZPF1YOTwaSjpHKK6GeWRSG19LKsFoaxZU+pNCF
 Ov2Z51eUWqmthp6MtWftkv+UgVc8jMyguzjIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712935972; x=1713540772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uqDcmcdfEAxpSmSYIoRjoyegxjm8YY6DAayxwa7eB28=;
 b=PXbQZPTJn+LR5BDZKb5hf81gEJn5KJo0g0zs7jjcK6ZhpEIAmBqvH+1nW/Rt6onCHY
 HEdYLN/JjnufsWVzHC6FIWq2jQ367VafPHs5uQhguJliRlvI29LB9mUL1/tkJSB315Dz
 pyAM/OfSWoekxGRilJvpREUpf61ALzrRpwMR9Lm+ACIsCbFnuqmCQnSYEx70yFcHdGzM
 iCIXgI9Astu7pGE1RdFQKFnPpDaX6xVlBqcA+/iCjbDuhHzjmk/pVwwJzqXTgp+roQap
 ixjveg6niEO3qHnjRPZMRAE/7HVOmIlQdtgt5mPtawuAJge4hME+M/pAtNajnY30FVhd
 gQPQ==
X-Gm-Message-State: AOJu0YxelsuseGp2V8NkiKiBFu5WcNAiw2ltrpJ7W7KT8HqzoQ2PcBGC
 400BhqoTCthICyBAY6xkTyN9YmTv94nDbZksmv3M/6pDiwzrQF+jhKzHusAXSA==
X-Google-Smtp-Source: AGHT+IHbtl8u5oM4YD0V1cyL9JOfCkw7w+xIl41C6otd6LoyoE8+lKTPybLQ5MBLMHKFw5O2MCIjbw==
X-Received: by 2002:a05:6602:1a98:b0:7d6:3f52:2f27 with SMTP id
 bn24-20020a0566021a9800b007d63f522f27mr3223842iob.0.1712935972439; 
 Fri, 12 Apr 2024 08:32:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ik14-20020a0566026c0e00b007d65a95d95csm1093828iob.42.2024.04.12.08.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 08:32:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/2] dt-bindings: mtd: fixed-partitions: Add alignment
 properties
Date: Fri, 12 Apr 2024 09:32:48 -0600
Message-Id: <20240412153249.100787-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Apr 2024 18:25:40 +0200
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
'entries' in fixed-partition.

For now there is no explicit mention of hierarchy, so a 'section' is
just the 'fixed-partitions' node.

These new properties are inputs to the Binman packaging process, but are
also needed if the firmware is repacked, to ensure that alignment
constraints are not violated. Therefore they are provided as part of
the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v11:
- Drop mention of Binman
- Use 'content' instead of 'contents'

Changes in v10:
- Update the minimum to 2

Changes in v9:
- Move binding example to next batch to avoid build error

Changes in v7:
- Drop patch 'Add binman compatible'
- Put the alignment properties into the fixed-partition binding

Changes in v6:
- Correct schema-validation errors missed due to older dt-schema
  (enum fix and reg addition)

Changes in v5:
- Add value ranges
- Consistently mention alignment must be power-of-2
- Mention that alignment refers to bytes

Changes in v2:
- Fix 'a' typo in commit message

 .../bindings/mtd/partitions/partition.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 1ebe9e2347ea..31bbeb161396 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -57,6 +57,57 @@ properties:
       user space from
     type: boolean
 
+  align:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2
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
+    minimum: 2
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment of the entry size in bytes. It must be a power
+      of 2.
+
+      For example, to ensure that the size of an entry is a multiple of 64
+      bytes, set this to 64. While this does not affect the content of the
+      entry itself (the padding is performed only when its parent section is
+      assembled), the end result is that the entry ends with the padding
+      bytes, so may grow. If ‘align-size’ is not provided, no alignment is
+      performed.
+
+  align-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment (in bytes) of the end of an entry with respect
+      to the containing section. It must be a power of 2.
+
+      Some entries require that they end on an alignment boundary,
+      regardless of where they start. This does not move the start of the
+      entry, so the content of the entry will still start at the beginning.
+      But there may be padding at the end. While this does not affect the
+      content of the entry itself (the padding is performed only when its
+      parent section is assembled), the end result is that the entry ends
+      with the padding bytes, so may grow. If ‘align-end’ is not provided,
+      no alignment is performed.
+
 if:
   not:
     required: [ reg ]
-- 
2.34.1

