Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFAFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE1288466;
	Tue, 16 Apr 2024 21:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M9FkwEz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F40638844E; Tue, 16 Apr 2024 21:02:16 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A178845A
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78d62c1e82bso320103385a.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294123; x=1713898923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6RRCSDMEgMx/hpx69LWzoXEqxByUlbnprNex1uq6No=;
 b=M9FkwEz9xrmBzfbty8hDBjoEtnLZO5aqWwwT4psE2yIfCvBA7MU2sCtCgGqtfMNLBl
 K9TFaw+5OoHg7zAxW9cB9QCWJHy7UY0Oj4aVjZESaGs9DH3IdhnQMwZ/U/YW74tHVoO8
 6CJwpLmjK6KuPSvUf8Eu4b6S1luv/Z/2S2Z8klqxxA6U/ttsyel2pLi6Wrgbhmrqpv2i
 hL8aNtvXAQQf7dnuBabPmHJdg2xAHX1jM/N4mwMsg+vuFlu8RJcDutWBW4wRfXp6H4UB
 MGUaBaZgg2zxamWC5U7yPTRIR4LWtBC7xj+eumj8sVKCM2Et8x9JQ86sfDYVXx2ufcVb
 FU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294123; x=1713898923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6RRCSDMEgMx/hpx69LWzoXEqxByUlbnprNex1uq6No=;
 b=sp1Wg5wqH1iV0vlTij7XCI+PUmW/NEPqhuM4XqULZ0IbisZekIKrkMQg4gcVC36oum
 IaMPNTSUOaoPuARHirC0w/h2uMDwL7vH6NUJtjf2QHPg9gafRv0p80ybie95qZ6Ld6y0
 9r+7hR9IJfO7cZoBRUkL/NUxTuJMTeHx3A2OLX6cHqphssmI2xXZb/Kbu7Y2IyuV45wT
 DbHxTIP5YUxDkt9Dzz3/OTw9qXEup8XHgo51olmJrAZqm/sHT28O8jb0NSpHy4l4am+k
 x+GiaDbc/Lz81ve3GcT/3IfGx65PKsZAqO+DVvUGkBSCJDCILuiADcMVleYiydfrc2oW
 x3xw==
X-Gm-Message-State: AOJu0YzFdQOjsjEiUx07kgVXkBY3HrDojCWMhsAoFCOfA/IUGgnNcfTE
 LandB0EX2FZShhI4xFV9TXDEvWBg3pi/tG2h3mXabclkacDD1EayliB1j2hRIrW3hYqh5BSYW/I
 A
X-Google-Smtp-Source: AGHT+IHbfJwR/Y3AuP0hh335e/frMPdcDRjEg+VDzuUhGE9Tt3WqN2nJj42wGfaEaQsWhr+qkz7BJw==
X-Received: by 2002:a0c:f88e:0:b0:691:8b3a:5acb with SMTP id
 u14-20020a0cf88e000000b006918b3a5acbmr16219484qvn.13.1713294123512; 
 Tue, 16 Apr 2024 12:02:03 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:03 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 16/23] mbedtls/external: update MbedTLS PKCS7 test suites
Date: Tue, 16 Apr 2024 12:00:12 -0700
Message-Id: <20240416190019.81016-17-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Update the PKCS7 test suites for multiple certs.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 .../external/mbedtls/tests/suites/test_suite_pkcs7.data       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
index d3b83cdf0a..2dd1c56109 100644
--- a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
+++ b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
@@ -14,9 +14,9 @@ PKCS7 Signed Data Parse with zero signers
 depends_on:MBEDTLS_MD_CAN_SHA256
 pkcs7_parse:"data_files/pkcs7_data_no_signers.der":MBEDTLS_PKCS7_SIGNED_DATA
 
-PKCS7 Signed Data Parse Fail with multiple certs #4
+PKCS7 Signed Data Parse Pass with multiple certs #4
 depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
-pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE
+pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_PKCS7_SIGNED_DATA
 
 PKCS7 Signed Data Parse Fail with corrupted cert #5.0
 depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
-- 
2.25.1

