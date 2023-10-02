Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055EFE74902
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 17:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F31187127;
	Mon,  2 Oct 2023 19:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EOiDYYOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF86870DE; Mon,  2 Oct 2023 19:50:39 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B2586DF9
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 19:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79f95cd15dfso749239f.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696269036; x=1696873836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LS+wV2LMgqbRwabaSq2Ufumv4REcBt1Upfkm2T5IrI=;
 b=EOiDYYOgWAVFfOEH+BURccaxTjeP5qMSDA2Gs4WE+kMAsAo2bCxCdFTXM3OeIdoEQl
 omJlZGOLmPyynQFuBcTepAJRTwRirL40ViPaw/YualL9BGh23VJNV+kxs0MWoaojFQFm
 qpJJh5G4SiWQij+SasC+TknpaL1wNg76gYpjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696269036; x=1696873836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LS+wV2LMgqbRwabaSq2Ufumv4REcBt1Upfkm2T5IrI=;
 b=G2SUo//0oPZ9ZKJga1oscf9GGnK54fRZoLY5x9roD6Zbz9z2mPRVgoKP8Ni6JSE3W6
 bIDX9KjER5Wfp6fPPQXUbcqLqkNyh9WJxzMYDooJ6C7RfysV8nKnz9w1wR5/yhS5LFgx
 fC2UfhOKKdcbuNzffGvwVeUnf0cUK5XUfnuVfKIeT/eywOnqu+zrwVwds9CNLWwf2dxN
 CZgvw2q4rBW/KNDt4Yqfsc+U3GIH9z0KTjyFDhos2D2EqR3M4avX64Yn2kVkBPZ+Tc5L
 w6OmVAo8NdAChzD4SRc2/r8rtxfryPi95Uo1RJU1UJxrbpKA1Y67wJgXNArGX6APFKVY
 EgAw==
X-Gm-Message-State: AOJu0YxeySK+ItRx7pGdW9F8AQcgVKtTS6Pn1lkHPdgXR6pd+Kcn8U9I
 9DkvuPExN1RLR9zJZmds+0CjWg==
X-Google-Smtp-Source: AGHT+IEB8T0cVFcTkDZ346OUm4Ky/z+eBGTNEVGMP1RopagjT/hUSHBfrulem4VbVa2WRYXv7OLtOg==
X-Received: by 2002:a05:6e02:1d16:b0:349:3756:b1ce with SMTP id
 i22-20020a056e021d1600b003493756b1cemr14675384ila.2.1696269035979; 
 Mon, 02 Oct 2023 10:50:35 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:63cd:2673:520:2e9])
 by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6919562jam.177.2023.10.02.10.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 10:50:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, linux-mtd@lists.infradead.org,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: mtd: binman-partitions: Add alignment
 properties
Date: Mon,  2 Oct 2023 11:49:42 -0600
Message-ID: <20231002174948.1015223-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002174948.1015223-1-sjg@chromium.org>
References: <20231002174948.1015223-1-sjg@chromium.org>
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
just the 'fixed-partitions' node.

These new properties are inputs to the packaging process, but are also
needed if the firmware is repacked, to ensure that alignment
constraints are not violated. Therefore they are provided as part of
the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fix 'a' typo in commit message

 .../mtd/partitions/binman-partition.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
index 406a8997d3e4..be7273a4c9ac 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -27,6 +27,42 @@ properties:
         - u-boot       # u-boot.bin from U-Boot projec6t
         - atf-bl31     # bl31.bin or bl31.elf from TF-A project
 
+  align:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This sets the alignment of the entry. The entry offset is adjusted
+      so that the entry starts on an aligned boundary within the containing
+      section or image. For example ‘align = <16>’ means that the entry will
+      start on a 16-byte boundary. This may mean that padding is added before
+      the entry. The padding is part of the containing section but is not
+      included in the entry, meaning that an empty space may be created before
+      the entry starts. Alignment should be a power of 2. If ‘align’ is not
+      provided, no alignment is performed.
+
+  align-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This sets the alignment of the entry size. For example, to ensure
+      that the size of an entry is a multiple of 64 bytes, set this to 64.
+      While this does not affect the contents of the entry within binman
+      itself (the padding is performed only when its parent section is
+      assembled), the end result is that the entry ends with the padding
+      bytes, so may grow. If ‘align-size’ is not provided, no alignment is
+      performed.
+
+  align-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This sets the alignment of the end of an entry with respect to the
+      containing section. Some entries require that they end on an alignment
+      boundary, regardless of where they start. This does not move the start
+      of the entry, so the contents of the entry will still start at the
+      beginning. But there may be padding at the end. While this does not
+      affect the contents of the entry within binman itself (the padding is
+      performed only when its parent section is assembled), the end result is
+      that the entry ends with the padding bytes, so may grow. If ‘align-end’
+      is not provided, no alignment is performed.
+
 additionalProperties: false
 
 examples:
@@ -39,10 +75,13 @@ examples:
         partition@100000 {
             label = "u-boot";
             reg = <0x100000 0xf00000>;
+            align-size = <0x1000>;
+            align-end = <0x10000>;
         };
 
         partition@200000 {
             label = "atf-bl31";
             reg = <0x200000 0x100000>;
+            align = <0x4000>;
         };
     };
-- 
2.42.0.582.g8ccd20d70d-goog

