Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C83CC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 09:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8302982E52;
	Fri, 27 Jun 2025 11:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ofeJALmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 797A082E35; Fri, 27 Jun 2025 11:37:33 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21BA282E35
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso13650315e9.1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751017048; x=1751621848; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AZQh3AqTbRXAO0xp+S5TWiIsaPdsE67scTPNLXXSDRI=;
 b=ofeJALmn/o8uMKSr0CoH8ulMwrylpW6lcsqpuVNNvFZ+XabWLqLy/Vvy9ponJ5XKDe
 vqmrMHfSWsSQR7FqehDkiZUa+/w8ycMxEh/OT+E7uoVVBiYsTsL1VCK0kUPHzTniVVhD
 2J+7GMam41wtbH85qrzcOGwIKjs5W4CHLa1+5XBS0nTR5mbOmWFMk1HRAjzoKwMpn6ZU
 yTZCBDfCQ8aN4IdiPmZ+DqUthEyPK2b+E8MIHrPUBUGaijiU7q+q8oRvw4974FcanTdp
 xL/5ZyIFDuhUrIB2NCdqXrssGXtQilxHnjv1hBcDefe+Webj3l90ZngtJjvdnq6USez2
 LOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751017048; x=1751621848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZQh3AqTbRXAO0xp+S5TWiIsaPdsE67scTPNLXXSDRI=;
 b=MTlM/Q+usvnWjFJ6Jh//tAvMdNWOHucwiZoaHWOPhKAaln4rdl+bOVtmbTbWLpB++M
 uHi/rnrh0d7lin6wUubtgeWRaVlvNwn7PrMQ0E/M4o/3Ih50B1lbm2dcVLjliORtJWHd
 k0biP+USTA+KcakiI3dZgVuh4mniIrbZnxaY15l2KKNo1ZV8zMpRczNCM+DEGsXUgdJw
 /Kjw+Ydmx27IhZf25iHgNnXfw8tZl8VmUK/9iJt2VCvk9AHCOaewZsob+q5QYouBRz8u
 ZqTs2peoKHX9fC2akQPgZBN8F1MGj0BfaMCrkLTUFrs6TyyrIzd/sOt7/3dcpJh2Adp2
 r+uw==
X-Gm-Message-State: AOJu0Yx25d2+MtZBhtO6frLlEsom7uWAuLzxlmlq/pOVMX56Hgj4GoH5
 GqgqWTGoZBnkln+INr4G+bJfUJbxIFou5tgEb+OR/2jqFJKPG25u0wJPasOA2/HNmN5q79KnldS
 sc6l3VLwIvw==
X-Gm-Gg: ASbGnct9/8rm4tVlGyEDlzBwces1dqlHPOQ2UoSflMYIqsjYQ51URiDSLSvpz2XtOV2
 Q87HruVVlU/ZbCByQzVh1acudjcU235plPpcnO0YnPKBVEicPQekurGFvg9VGVPxXGdgwQEJIDY
 zDv0nVL2fSlBBxVYOvUOnvtRDIeijfqAPgvp3Vy6VcE81qQhLgqAetyoUyHwCn5tBisX31VCmlD
 Bnx8HshuU2tgdEdspoaMJVEGHcpgUDepWRay5Rw/68i+ND0luNGz25AHNalxLXi+KYtyeW/3NZx
 gT7nVPLdjZbuG9xVbm8jwBvOnqD8+cPKafkJeaMZNk01TlqnKYrBjibNeyLa/M5Nxy4T8RB2cwq
 E1CHtlJgidRhQiPS0jIQ2bIS4
X-Google-Smtp-Source: AGHT+IGJZi1a257BhbwlaU1OhsNIkwy+17DFeXvM8GbcwX2ZKsFP93gVAE67kYkpLGx90iEljP73JA==
X-Received: by 2002:a05:600c:1549:b0:450:d019:263 with SMTP id
 5b1f17b1804b1-4538ee5d63emr29783845e9.18.1751017048537; 
 Fri, 27 Jun 2025 02:37:28 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:c61f:677:c14a:b7e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e9d1csm2234958f8f.13.2025.06.27.02.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 02:37:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 27 Jun 2025 10:37:26 +0100
Subject: [PATCH v2 1/2] cmd: tpm: Fix attempt to return value not in enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-tpm_enum-v2-1-ea3f84f6b639@linaro.org>
References: <20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org>
In-Reply-To: <20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org>
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

-- 
2.39.5

