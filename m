Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50903C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 19:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B69E86530;
	Tue, 29 Aug 2023 21:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JEshIHPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7558651C; Tue, 29 Aug 2023 21:18:24 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B4F8056D
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-792717ef3c9so140197639f.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693336700; x=1693941500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2EOlIsyyalVzQJ+ySIW4EY7rt0WpPcDJsD4cRWVzLc=;
 b=JEshIHPF2R5FZBhdrSTmWOT9Qgo2WLrsa0/+ENKljN6q5CO5TMUW6WZQt+c/duX387
 Ualoqkxba91pw0YIGgneTUSd74k5KkZ+hyAnJ/jC5rdEOavNviyaCE5EcyfCuHyBb4B1
 MdhuNWq/wprrpIF/q22/Ff9u0bldH3nq66YGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336700; x=1693941500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2EOlIsyyalVzQJ+ySIW4EY7rt0WpPcDJsD4cRWVzLc=;
 b=JI+7Zt6+BqeNviafI84UT9E9qd4Do6xzRK643pAwg1SpgToIx2sibVRvXMH4ZZzScx
 eCB33YT7lK2n/vm3tCh+N55Ku6XPRDLiWULY7CY6Py8Q2La+cdRudHhZ+cp7PP7Hj53c
 IteSsO/h9HkXKRIgpTuWiDTcQRdO8wpJws8Aw9AS+xg3iBagNFMOMpP6YFDBb9WMiTU7
 aTQ7vbJmNi3veSZymW+/h5ZICzv8czD3xCrvhbkslLqqKfTNwkyTP9SDip2cmjrTx91H
 3bjGHVyfIM4wrIe69e2ROs2UX25Nx97emfXEUV1V9vJS7Vr414S7CFX3OZATjIBFpTl7
 Zgiw==
X-Gm-Message-State: AOJu0YyxNg6BRJ5CyE/gFBlBflaLLfCwvQ75on6CzdNeiPpGMbcFuPhT
 ozH5Ad+4Osa7W2GrKPrJedWJYg==
X-Google-Smtp-Source: AGHT+IHcNTUDqeWuGnguf30MnbXSWVIEQf0YgXYlNufXHWllcBHuQB7tTPrRkRrNldw414bQICnkvA==
X-Received: by 2002:a6b:a05:0:b0:795:16b8:85fc with SMTP id
 z5-20020a6b0a05000000b0079516b885fcmr406492ioi.0.1693336700070; 
 Tue, 29 Aug 2023 12:18:20 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:16d9:c947:1a18:4c10])
 by smtp.gmail.com with ESMTPSA id
 fq8-20020a056638650800b004332f6537e2sm3359798jab.83.2023.08.29.12.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:18:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Dhaval Sharma <dhaval@rivosinc.com>, Mark Rutland <mark.rutland@arm.com>,
 Gua Guo <gua.guo@intel.com>, Tom Rini <trini@konsulko.com>,
 Rob Herring <robh@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 ron minnich <rminnich@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Chiu Chasel <chasel.chiu@intel.com>, lkml <linux-kernel@vger.kernel.org>,
 Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org,
 Guo Dong <guo.dong@intel.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 4/4] memory: Add ECC property
Date: Tue, 29 Aug 2023 13:18:09 -0600
Message-ID: <20230829191812.135759-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230829191812.135759-1-sjg@chromium.org>
References: <20230829191812.135759-1-sjg@chromium.org>
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

Some memories provides ECC correction. For software which wants to check
memory, it is helpful to see which regions provide this feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..981af04 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -34,7 +34,14 @@ patternProperties:
         description:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
-
+      attr:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description: |
+          Attributes possessed by this memory region:
+
+            "single-bit-ecc" - supports single-bit ECC
+            "multi-bit-ecc" - supports multiple-bit ECC
+            "no-ecc" - non-ECC memory
 
     required:
       - device_type
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

