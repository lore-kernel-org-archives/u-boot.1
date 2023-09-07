Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BFEEC875B
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 21:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 781B9869B9;
	Thu,  7 Sep 2023 23:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZktXCRML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012C686A3C; Thu,  7 Sep 2023 23:40:22 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D8F86A2F
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 23:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34ccc0fca24so5580595ab.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694122817; x=1694727617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5daRRTdLNlkY+bK37VVR4v3WldsBabAY6GSX8MwLbs=;
 b=ZktXCRMLmCpJ6P/pEMQUYrCvqpp9SXkOesqMJJVoWss5QqJIo5PsEmSoo9wJRFLamM
 FkUCtDsh0UL20akWZYG08OrOibj95nHYdu5LApUDjRXF2pvseVu4BmZJhJWk7YNRk1uH
 45RWY9cZ9Mzs8bMTdqXvi1PElKgpKgp2zxtns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694122817; x=1694727617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5daRRTdLNlkY+bK37VVR4v3WldsBabAY6GSX8MwLbs=;
 b=SCjVGfhadpOvQyLVf5s75lNrJ9DQ4mcnI6TowAQ2lzzGW+Q/yXVMGyHp2pyOsqg+rH
 6TsL8so/Drk6t0fhQNgdarxcqbR/K8Iv3WlxKPZ1pXCaO3/KkzoXqK1AWPW+g7LgM3nN
 Nwq/cbLxaY+yMVX/AAxBal27CpWxOlBuubL6wYdZAWUKR1PIYLgrtHje+zYTIgJrrsSv
 yNA6pzIYgtShvrBpcljG9R37dq1jfoZ/aVMWYINk9bd4Kwrpzz6kraTcNRzZhaDeoTWA
 OBkzYRoYpCo5jshdOCTIlTWLeB5/GngLiNDcBHFN1hKckRJ/HOfpChaVrlFHT2mbKxD5
 1iYw==
X-Gm-Message-State: AOJu0Yy4+M//E5V9P8/nHRf6FX8X8FtZihN3uNAUeQFnPIDfzzXHIyyo
 hvc/JU12wAH6II9OTcWUT3xCEw==
X-Google-Smtp-Source: AGHT+IEOo9i8+AV7SDMWoVUID/hLd8I+L2Kc4qthbyfM9QnHCrPKzqJp7ucAuhasGZkxp4mk+KwwGw==
X-Received: by 2002:a05:6e02:219b:b0:34a:c751:28ca with SMTP id
 j27-20020a056e02219b00b0034ac75128camr1176329ila.15.1694122817229; 
 Thu, 07 Sep 2023 14:40:17 -0700 (PDT)
Received: from sjg1.lan (c-73-243-118-188.hsd1.co.comcast.net.
 [73.243.118.188]) by smtp.gmail.com with ESMTPSA id
 x14-20020a92d30e000000b00348edca2abesm72006ila.47.2023.09.07.14.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 14:40:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Dhaval Sharma <dhaval@rivosinc.com>, Guo Dong <guo.dong@intel.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Ard Biesheuvel <ardb@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Gua Guo <gua.guo@intel.com>,
 ron minnich <rminnich@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 2/2] schemas: memory: Add ECC properties
Date: Thu,  7 Sep 2023 15:40:11 -0600
Message-ID: <20230907214012.74978-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907214012.74978-1-sjg@chromium.org>
References: <20230907214012.74978-1-sjg@chromium.org>
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

Changes in v6:
- Use a number of bits instead of a string property
- Fix inidcates typo

Changes in v5:
- Redo to make this property specific to ECC
- Provide properties both for detection and correction

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..1a48b1c 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -31,10 +31,21 @@ patternProperties:
 
       numa-node-id:
         $ref: types.yaml#/definitions/uint32
-        description:
+        description: |
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
-
+      ecc-detection-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be detected and reported by the Error-Correction Code (ECC) memory
+          subsystem (typically 0, 1 or 2).
+      ecc-correction-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be corrected by the Error-Correction Code (ECC) memory subsystem
+          (typically 0, 1 or 2).
 
     required:
       - device_type
-- 
2.42.0.283.g2d96d420d3-goog

