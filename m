Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B55C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 09:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB4A82977;
	Thu, 26 Jun 2025 11:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ql8lEbfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6755E82B34; Thu, 26 Jun 2025 11:57:42 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C81580E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a522224582so344469f8f.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750931858; x=1751536658; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/uTJ2mMc8uIuvU/XH5keJCymXegtQ+rYVK6vayliG3o=;
 b=ql8lEbfxF0AcmexfbLQHLZ8bPSn+t8NyArL/p3mEOF9XwIya/1TkcsLXCMeMUtb4QN
 8fsd6GJNerhgtiu3r/7TuO8jlayA8HwK7AGCPH9FSGgSahtExkYQ0uwnWqXiv9vslZGk
 Otab7NDeHYP37N0UNDxFjqxwTZ6ISBbvpm4PBa++vy+EkmK62NiWJMPrOdRWPmDHnfvl
 NPXFOAe4uhc8RIQkGy8E3PAnK6d7n0oAvlsASunP3Vd23GVfPf7B+gtAma4HVmEwjnAB
 qSJ3JH76R2LVmq09gIq+UKFJpMo1Q9pGooswsTuLusjSrY2NblzRknXDFY571iWN/tJB
 h8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750931858; x=1751536658;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/uTJ2mMc8uIuvU/XH5keJCymXegtQ+rYVK6vayliG3o=;
 b=En3hZy1qXOTWiqSZGUJDP5nMvfEO58eL+5kWljUVy+SOpFnyxOytO7/IfGDvlCVyh/
 arJAEU12lf5OYL+m4kMf0Tfj/v5c0Dsojby9M5y+Dp42T9YRs+cJkXylwoO26QcxIgZ7
 E82+Ak+EhrGh1yxfMnrpxubEhhQgTPKuWA1BJL+R/u6/mCr9JHlrcku20xbVRF/BzBNo
 7DlgvUdPE+BlyqCz/3rmTdA2Fha8NUV0mKUCwLHb4G4QRHxe2GS5+9jhDBWSFGa2b9HH
 Y6SQ/lAFI3ATDEnhNSGQw85t294JolFCRMS3iv0CP3N1HmH4w/V4PwTM0nLTfV7nmBCW
 FJNQ==
X-Gm-Message-State: AOJu0YwsFoQwobRtX6Xzav7JwX+aS691SOscw1cRx/qQykkFf5BAV3go
 n4ShynIwoPJv/1amzEIpOTihqX2qK78VO3dM2x2jn+O529htliFhyrsBIFZn/VGw6jQ=
X-Gm-Gg: ASbGncvpFBbqKFLl8piqs63jgTaXNi8Am5HtYW+yyhAHIPld/VshyYOfCmPzjiQNXQ1
 cxomwH1DYK3b6nfBHQJdCmuv5cwdjswYrduOUMXiuW4wXPJG8PkCqPH9/ghj+IkCcugdX5vh9oh
 gL8ygX5GrCXFEn9DbwYHs1mfNm8uOU/Ay+i2ZnrmLF1g/CUPMM6OHH19Gml3wFJD6OQVVjz956Y
 xCACt02kmZoAFB4nUkgE0aWHu7DYEUdC+Vr4NjcAa2tW1GNFUEAFJFIZyiRyDdhoIwschwzFM0I
 F0GUJW/cQSBPB3FdTa93wr1oX0qffXoT3laXNQ/KCa5Mdk3BdGROm38r8mDHFShemOz4TKQW258
 lrcUqA+E1cGpaVA==
X-Google-Smtp-Source: AGHT+IFQv3Y20XYJWMYJ0zDGiAU9R/bqR4Vl1BDn6oOlQjMKwidd7ZElajtI+eZ+ikQlLNbGYEMyVQ==
X-Received: by 2002:a05:6000:65a:b0:3a4:e2f4:a86b with SMTP id
 ffacd0b85a97d-3a6f2eac659mr2255886f8f.37.1750931857849; 
 Thu, 26 Jun 2025 02:57:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80ff461sm7097959f8f.67.2025.06.26.02.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 02:57:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 26 Jun 2025 10:57:36 +0100
Subject: [PATCH] cmd: tpm: Fix attempt to return value not in enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-tpm_enum-v1-1-73a1aff0bd4c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI8ZXWgC/x2N0QqDMBAEf0XuuYE0EFF/pZRysaveQ1K5s6Ug/
 ntjH4edZXYyqMBoaHZSfMTkVSpcLw2NC5cZTp6VKfgQfRui29b8QHln5/sO6DkitYmqntjgknI
 Zl/OQ2TboOayKSb7/xu1+HD+wxFhIcwAAAA==
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The function tpm2_name_to_algorithm is defined as returning an
enum for the algorithm specified but it also attempts to return
an error on failure, but that error is not included in the enum.
Add the error to the enum so that it can be returned.

This issue was reported by Smatch.

Fixes: 954b95e77ef0 (tpm-v2: add support for mapping algorithm names to algos)
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/tpm-v1.c                 | 1 +
 cmd/tpm_test.c               | 1 +
 drivers/tpm/sandbox_common.c | 1 +
 include/tpm-v2.h             | 1 +
 4 files changed, 4 insertions(+)

diff --git a/cmd/tpm-v1.c b/cmd/tpm-v1.c
index 6e019d1c729..25402f7543b 100644
--- a/cmd/tpm-v1.c
+++ b/cmd/tpm-v1.c
@@ -8,6 +8,7 @@
 #include <malloc.h>
 #include <vsprintf.h>
 #include <asm/unaligned.h>
+#include <linux/errno.h>
 #include <tpm-common.h>
 #include <tpm-v1.h>
 #include "tpm-user-utils.h"
diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
index af83d78c3fe..1d9644d5aae 100644
--- a/cmd/tpm_test.c
+++ b/cmd/tpm_test.c
@@ -7,6 +7,7 @@
 #include <cpu_func.h>
 #include <log.h>
 #include <time.h>
+#include <linux/errno.h>
 #include <tpm-v1.h>
 #include <linux/printk.h>
 #include "tpm-user-utils.h"
diff --git a/drivers/tpm/sandbox_common.c b/drivers/tpm/sandbox_common.c
index 596e0156389..4bc003a2c09 100644
--- a/drivers/tpm/sandbox_common.c
+++ b/drivers/tpm/sandbox_common.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY	UCLASS_TPM
 
+#include <linux/errno.h>
 #include <tpm-v1.h>
 #include <tpm-v2.h>
 #include <asm/unaligned.h>
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index ece422df0c7..6c516dd3c9b 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -266,6 +266,7 @@ enum tpm2_return_codes {
  * TPM2 algorithms.
  */
 enum tpm2_algorithms {
+	TPM2_ALG_INVAL		= -EINVAL,
 	TPM2_ALG_SHA1		= 0x04,
 	TPM2_ALG_XOR		= 0x0A,
 	TPM2_ALG_SHA256		= 0x0B,

---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250625-tpm_enum-098ee9a5eb6b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

