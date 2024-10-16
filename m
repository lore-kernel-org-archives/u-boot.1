Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D75D2F7D7
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 23:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED68F88DDE;
	Thu, 17 Oct 2024 01:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AxF79DFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C83F88BBE; Thu, 17 Oct 2024 01:49:27 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DED1988BBE
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 01:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46045199e4dso3774891cf.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729122563; x=1729727363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=exzGOn18LUaBnR+iJdnIMXrS1HQIQZeMZuh2RV5wgas=;
 b=AxF79DFqYSwbj/PHzpKU75JjSfkzm8tw+BRuxtrt14aZaPD/wqgVg+uKQ8Yhp0IbeS
 MtGUC35+AcG3SxDHWjupyTyFM8eRjHXUXm8Uas20BRaply9Afe4saEyeBnKHIs4MKgx4
 32QngRBJc8TkJkNQrXg6oOnuWiYxRqN2iwjgiADiNJXDHS3cIwtNTmG/rXyq1tFDeqyr
 cRC9xY6ZALfGxHhgPAal7KosBpXbypaojPcxNJt4ypryeLpGXioeNbyWpOOtjPW34YLC
 N8k7OjfI5PU/avC4BSygWmZokBV7UEpu7KqcjUMSnrr8hvybDL1UIP9JNkniaMUotyzB
 3i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729122563; x=1729727363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=exzGOn18LUaBnR+iJdnIMXrS1HQIQZeMZuh2RV5wgas=;
 b=JVj92ZrheC3BMkdaTEha2z/Chc3NT3x3a9Z8hqc1nm9SJFCl6nYnBrHu1qLVnX2lOZ
 A2apP0Sk5pUct8lcdfw/O+Fxkm7qM5tecoom4nnlXUtejH9FisZv5heduNM9SViWlhwR
 t0UdtZh3PUgR3+uk7+SGtSGJLFrofoEfhGXwNRDVgfbLxVqwtDi1MG0zxz4XV++IT6qt
 BGr3CKoW7ygcQhJorBpjkwx1Z/a03nXDpJX6VE2ZEJCUyGwt086ypOhfwIG8wZ9H58Li
 QJE0Ay4rzoVpszelAiGC1z6G649hgp4+t/TezQfLlCTm3y8SwocwQ4gVmn7ddVmYEzaP
 DeTw==
X-Gm-Message-State: AOJu0YyZUuzNoz605FZxuBbv3V4O2N1HHtpLHPrBxsKAM2yqHouncvkM
 v3oBi6dx50vlZOF50Gqy4RrU2UJ7ZEQxPBj4x+cNkFURPAVNz+VGFVmLKpFMegqiA+DVul1eUNw
 Wk0s=
X-Google-Smtp-Source: AGHT+IH23CKpdJshZMeGGaKfASjhYtsp2x62c/8a41R41rYb3FXrqG+HyH0iQKhG9hKXLXEx6f4YeA==
X-Received: by 2002:ac8:578a:0:b0:45e:ff67:e058 with SMTP id
 d75a77b69052e-460584b4ff8mr289910271cf.44.1729122563540; 
 Wed, 16 Oct 2024 16:49:23 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4609bc1f0b4sm3068211cf.50.2024.10.16.16.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 16:49:22 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] mbedtls: fix defects in coverity scan
Date: Wed, 16 Oct 2024 16:48:26 -0700
Message-Id: <20241016234829.3836359-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Fixes of unreleased buffer, deadcode and wrong variable type detected
by coverity scan.

Addresses-Coverity-ID: 510809:  Resource leaks  (RESOURCE_LEAK)
Addresses-Coverity-ID: 510806:  Control flow issues  (DEADCODE)
Addresses-Coverity-ID: 510794 Control flow issues  (NO_EFFECT)

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/mbedtls/pkcs7_parser.c     | 7 +++----
 lib/mbedtls/x509_cert_parser.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
index 69ca784858e..ecfcc46edfa 100644
--- a/lib/mbedtls/pkcs7_parser.c
+++ b/lib/mbedtls/pkcs7_parser.c
@@ -206,9 +206,6 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
 		p += seq_len;
 	}
 
-	if (ret && ret !=  MBEDTLS_ERR_ASN1_OUT_OF_DATA)
-		return ret;
-
 	msg->have_authattrs = true;
 
 	/*
@@ -361,8 +358,10 @@ static int x509_populate_sinfo(struct pkcs7_message *msg,
 	signed_info->sig = s;
 
 	/* Save the Authenticate Attributes data if exists */
-	if (!mb_sinfo->authattrs.data || !mb_sinfo->authattrs.data_len)
+	if (!mb_sinfo->authattrs.data || !mb_sinfo->authattrs.data_len) {
+		kfree(mctx);
 		goto no_authattrs;
+	}
 
 	mctx->authattrs_data = kmemdup(mb_sinfo->authattrs.data,
 				       mb_sinfo->authattrs.data_len,
diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
index cb42018695c..e163e16b9bc 100644
--- a/lib/mbedtls/x509_cert_parser.c
+++ b/lib/mbedtls/x509_cert_parser.c
@@ -66,7 +66,7 @@ time64_t x509_get_timestamp(const mbedtls_x509_time *x509_time)
 static char *x509_populate_dn_name_string(const mbedtls_x509_name *name)
 {
 	size_t len = 256;
-	size_t wb;
+	int wb;
 	char *name_str;
 
 	do {
-- 
2.25.1

