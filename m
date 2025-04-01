Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E5BC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 11:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8D8C820B3;
	Tue,  1 Apr 2025 13:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ikoa9iC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FBA820B7; Tue,  1 Apr 2025 13:27:48 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4510E820B0
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 13:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so974146466b.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743506866; x=1744111666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdtJX8kf0hh6B9uobRvHu1jS3m3yXqmRVVsq2L8FXvk=;
 b=Ikoa9iC2bjzxhrh51fXSkwhBdeEcoQoh7zAyzUe3rPc9rpoxF6tgw2anLQNTHr113E
 lT3DW9X/6QlE60fCTVMdi1J3IY0rZC9IamQGZG83/XB/kjFYBUkxaljmgj5wPqgNeUzv
 qnjy//nLAyESa3qecyhcV5PmseLV6E1402dcIzhrLJTdOAEIhGRW7Jqskcaj7EnUu1as
 J4bzDgFOUGTlVuKyYnHa4xwZTa9aaTDT7RzvyfMfKNrQtfJBpGjURv9oHe1WKpDmuf0c
 L3UAygtr9w7ZcUT+5Wp1lUh9AYITOet3y07EvJE/vzToETwapOfkFS+UmM+L7TUDREU1
 OSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743506866; x=1744111666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdtJX8kf0hh6B9uobRvHu1jS3m3yXqmRVVsq2L8FXvk=;
 b=uw8ECsouixJyrqpOzEJGJqrUkOeiRd7yJOv26B6qifCrA8bo3pA4iL1GRfxvhPQ2na
 fl9SiE2jBc5d/s+lijZmjj32ClYu+2wEQJrkMnvc2oMf5W43UFPud9Ifzq9M6v17sTwZ
 cDQJ56IB8N4SqmX8ID9PPtOgWm/3pnVuUEdwu6tSq8dP8QUbZ7hqLACOnPBLcJ6Qohej
 3lyrFfu795BeOBUf4+cnpIYLfPNIY3wWjNEliEkOrv6Dhs1zV3lgaptAtt0Rk1BShUcj
 2IsfQSMRATE7nMZ/ppcSAbsTUautyerM5WyN+akvRSA4fsitXN/3spI78hKNKs8gkUQI
 LUjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6WVyGH8Q6zA3OBFV3GqiF7XyD7wGb7vr82Hm3IicnO27wfxWT8TII8SwrSNwOkZBXyXpT0QI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8Elv6M22hwg0HnzuMWquPwlmLUYNL2c3bSkNQpGJaOKBP3O/6
 FI8jXMSnyq4m3kicm5x/s3IYUuslx5OXlULfe1Py5y6R+dT382v5GAaykCLm2jk=
X-Gm-Gg: ASbGncvqcCod3gfQz9nPqpDJpYG0mE2uJG+UMRDS6KSfYVkpTvqb2JDNuT77jduKQ+c
 Mgg1VPsrn4ssTV3EcFZ+Ah7KLBPV3coD1LK9gHqVQeGaV0FJ//wwk1Jazrn2F7bEf1mP63jJR6D
 UkmaCdL59ndveK7s0Ub3yuwWMhgbZVQzUQpnPvpSHbblUz8wo6nBRpk8vVRtY5bfNl7zZnRymZJ
 exPeFFR5fcZw+Cldlp7+TobrcZ2lQq0LZifKNYZ9wCqNfXjiUtnOyLPtIiYykVZBhj9lmBMqF+H
 9xlses7gV4S/2u/0+5QAYSMmLIJdtMlUYR+h1kgi8rt4POn+0cb/r8PQ0AqodpikeEnUEMMeNs4
 lf/BWcI2YJcVSZrx9eTlN
X-Google-Smtp-Source: AGHT+IGvD5LlmIExSz1QVb2RQOIe4t2lwECPGqVgNJvqI8G7eKA/joD03V5bHwJQ3+RnMaY/Z9LNwQ==
X-Received: by 2002:a17:907:6092:b0:ac1:fb27:d3a2 with SMTP id
 a640c23a62f3a-ac738a0f3camr1183841266b.5.1743506865638; 
 Tue, 01 Apr 2025 04:27:45 -0700 (PDT)
Received: from localhost.localdomain (ppp089210073071.access.hol.gr.
 [89.210.73.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71967ff9asm760781866b.137.2025.04.01.04.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 04:27:45 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] doc: Update authenticated capsules documentation
Date: Tue,  1 Apr 2025 14:27:26 +0300
Message-ID: <20250401112729.2181793-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401112729.2181793-1-ilias.apalodimas@linaro.org>
References: <20250401112729.2181793-1-ilias.apalodimas@linaro.org>
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

Now that we moved out the capsule signature from the DTB, remove the
relevant documentation.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 48d6110b2ad1..3ca22b572a92 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -597,21 +597,6 @@ and used by the steps highlighted below.
       [--fit | --raw | --guid <guid-string] \
       <image_blob> <capsule_file_name>
 
-4. Insert the signature list into a device tree in the following format::
-
-    {
-            signature {
-                    capsule-key = [ <binary of signature list> ];
-            }
-            ...
-    }
-
-You can perform step-4 through the Kconfig symbol
-CONFIG_EFI_CAPSULE_CRT_FILE. This symbol points to the signing key
-generated in step-2. As part of U-Boot build, the ESL certificate file will
-be generated from the signing key and automatically get embedded into the
-platform's dtb.
-
 Anti-rollback Protection
 ************************
 
-- 
2.49.0

