Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C206C83F14
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA648654E;
	Thu, 31 Aug 2023 01:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZPyyAvDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C4F86554; Thu, 31 Aug 2023 01:18:20 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0B1864AA
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so11647839f.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693437496; x=1694042296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HY2cU6JGuZrguIyfLb09NlceqC/Y62AT/KhqZYbIbwU=;
 b=ZPyyAvDXER6O6QELKZIGAcTHIQ++dtlmOO+/rwXBRWdLpgXmOykE8ad53o+4V1nqiw
 2r5LjYljP3NnjlOHpKYCZfMW5l1Q3Y2Sph+Uahu8SmyhDhvBcaYIWLtLUxzyMZh+LXyP
 6IPd0rUfvVEVezda6KH4tXDMRyEpdJZ6sEbxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693437496; x=1694042296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HY2cU6JGuZrguIyfLb09NlceqC/Y62AT/KhqZYbIbwU=;
 b=e8JDI/48K0gYwsslF95SKIdQ1H3LXpJjDtt2e2V3YeI0cLdiP5i2MyrB5BR8RiCLSQ
 ZzwxFqrsfq2JBNk+Q6AgZiyZa/UvlVLQ0xZq358IVv/JJgykq+5BKL3HVv0q1tSCvxdh
 yT0kWESUdR0DYOcFKYgfg5oOdjyi4KfhEzU1ACS4bAVFVDvSFMvBTQMoodxYevLXzesh
 dOJmoS7u5roUR5c/Wc3LdiS3Xfnlff/ojhcJAra6evGrSupE8IDvhmtUlhZoCyBQi+gQ
 LgEWC/p7cxgIw6Nnfo1uoFPSPEldGPO73oDlCI5usJqcpeaisUfcJgjrdcPfA+kSs7NW
 U/Fw==
X-Gm-Message-State: AOJu0YyMexKSy27f9q9m8xI06Bxm5MjC+9loSegY/BB+xacMlHojNSeY
 uOkQVafPrkX7E+5mnKDdALMsBg==
X-Google-Smtp-Source: AGHT+IEDA6Kz+88UsYqnGtgINRuvJ4OfWV7BCV1mSX3IDTB900P56/Cp3vrRoaq3PqkXR21lxfX66Q==
X-Received: by 2002:a6b:6112:0:b0:790:f733:2f9e with SMTP id
 v18-20020a6b6112000000b00790f7332f9emr3861880iob.13.1693437496510; 
 Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 ron minnich <rminnich@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dhaval Sharma <dhaval@rivosinc.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Rutland <mark.rutland@arm.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Gua Guo <gua.guo@intel.com>, Lean Sheng Tan <sheng.tan@9elements.com>,
 Guo Dong <guo.dong@intel.com>, lkml <linux-kernel@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Chiu Chasel <chasel.chiu@intel.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 4/4] memory: Add ECC properties
Date: Wed, 30 Aug 2023 17:17:52 -0600
Message-ID: <20230830231758.2561402-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830231758.2561402-1-sjg@chromium.org>
References: <20230830231758.2561402-1-sjg@chromium.org>
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

Some memories provide ECC detection and/or correction. For software which
wants to check memory, it is helpful to see which regions provide this
feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Redo to make this property specific to ECC
- Provide properties both for detection and correction

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..944aa9f 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -34,7 +34,37 @@ patternProperties:
         description:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
+      ecc-detection:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - none
+          - single-bit
+          - multi-bit
+        description: |
+          If present, this inidcates the type of memory errors which can be
+          detected and reported by the Error-Correction Code (ECC) memory
+          subsystem:
 
+            none       - No error detection is possible
+            single-bit - Detects and reports single-bit ECC errors
+            multi-bit  - Detects and reports multiple-bit ECC errors
+
+          If not present, this is equivalent to 'none'.
+      ecc-correction:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - none
+          - single-bit
+          - multi-bit
+        description: |
+          If present, this inidcates the type of memory errors which can be
+          corrected by the Error-Correction Code (ECC) memory subsystem:
+
+            none       - No error correction is possible
+            single-bit - Corrects single-bit ECC errors
+            multi-bit  - Corrects multiple-bit ECC errors
+
+          If not present, this is equivalent to 'none'.
 
     required:
       - device_type
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

