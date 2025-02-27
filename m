Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7670C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B1DD81112;
	Thu, 27 Feb 2025 17:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ubrpapJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A30FE811B2; Thu, 27 Feb 2025 17:09:34 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2B8810F5
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-439a2780b44so7951695e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740672572; x=1741277372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITtlE9O7HzP32DFn3Uy1Zsk/2rnNtHcVc0ynn2ckNAU=;
 b=ubrpapJ9LLZ9uZE9ISl6YHJU09ogW5cRvegCNKiny7N3XBjpk9QrqkKcYM95fAk+eT
 do4aSVCtD6lrseMOOaxfc4i412jMKfuqDh/uQivQHegJu0psAhmLvjmu4lD6wv/BuFCe
 nOt4MOuXWO3A/CV245HFcYKRNlls/61FZO4DKBNTpt8qOxoMKoxU6Ewo7fuEIH7Bre9S
 bvj/l2BQ9hH05QYsgjwpICedJ+Wz/MQOwd8jEyi8zxxCeMSsP4Uxw4uQBOYqSqgZWFlb
 3VZk8XK8p8tbqWP8CbVn1fSJDjmGH2B+egtGUaWDe625PHfGHEJutYxGt5WrgLAqKlqF
 XudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672572; x=1741277372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITtlE9O7HzP32DFn3Uy1Zsk/2rnNtHcVc0ynn2ckNAU=;
 b=v1W0QOCYAgW7oQPlqpJY6wDOiuvOCXHz+/R2QLXsOrtk4CufOgrVunrGfuuH6r7tHW
 nIrsUWsDSKg3n2hmCGu1t0m90dc1v78fL/RVwd4qeZzm/NmYm7FNMTKrOj3IkEK57/GY
 SO4/X6rmBGdDP03PcvRzSaxBdBhjtcSkOI/YFgrAxsu/6OsdOtUVvfB1zKgYQVNW3Edw
 PcRc+RCU9Q40TVK1kY7dYak2rspHm40QldVg9B0KR3eaHnLral1Vrv6KLhdbLvZ8Vm+P
 0+TDw2nz8cuOKoG+/p+7GqHwV3d31fZ6I41gNz8jWZ6idr7FNSu94Awyvr4z3mj3BrZ2
 FpLw==
X-Gm-Message-State: AOJu0Yw1lz/0nrHOiNE42BI8Y+TywKr9/8l/g/jm8WlPwkXlKM60R7Tk
 f+dEMicLF523P/hte9dFBD9auLPBTDjOF9oF2ISjxIKem2j8ZrW/ltTHj8Z0Q1sjqbvsx7rPXoX
 Wcx8=
X-Gm-Gg: ASbGnctWMP/9rMpRrpB7FARcrNMeHESB6U53+od6gFb2KNZipsLw6xbpxebvrj1mR5D
 EIN3qECWkTOKJ43ccBDAmLFT5zElxiWaOXDkhCR+jV1Ax5A/qnKtb5TvtvQyF/cLpxtMX7scy1z
 u32NhBBJG93hi7xI0Vq6GW0Fon+yiVvpwDKqrJrD/JvHPe/V2TZgJF9fBn+Ka9IpQ4hSok7775B
 6jW9SdLq6K/Up1KgiDfeHCJl9HHPF8bMZ2vsyV7rA5TUzK5ZFf+n8PoSIlhQiIw3BsUOXz7IRZv
 ErqzZRLjqQqHtGRddPdL7GP0XTU0z2Hf1jM=
X-Google-Smtp-Source: AGHT+IG27FZ42i1qPqd8UoQ4I2mBFIuV8Muw6lCjVaRqRpQee+y6JOeQKowaoxuEURi1qcJIYT//Xg==
X-Received: by 2002:a05:600c:4fc8:b0:439:955d:7ad9 with SMTP id
 5b1f17b1804b1-43ab8fe9333mr82783595e9.14.1740672571689; 
 Thu, 27 Feb 2025 08:09:31 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b925sm59506795e9.7.2025.02.27.08.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:09:31 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Javier Tia <javier.tia@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/5] lwip: tls: enforce checking of server certificates based
 on CA availability
Date: Thu, 27 Feb 2025 17:09:02 +0100
Message-ID: <f9841a538eae301779e33c4dcf1d0ae126759909.1740672437.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740672437.git.jerome.forissier@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
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

Instead of relying on some build time configuration to determine if
server certificates need to be checked against CA certificates, do it
based on the availability of such certificates. If no CA is configured
then no check can succeed; on the other hand if we have CA certs then
we should not ignore them. It is always possible to remove the CA certs
(via 'wget cacert 0 0') to force an HTTPS download that would fail
certificate validation.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c        | 3 ++-
 .../lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h     | 6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
index 46421588fef..fa3d1d74fed 100644
--- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
+++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
@@ -786,6 +786,7 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
   int ret;
   struct altcp_tls_config *conf;
   mbedtls_x509_crt *mem;
+  int authmode = have_ca ? MBEDTLS_SSL_VERIFY_REQUIRED : MBEDTLS_SSL_VERIFY_NONE;
 
   if (TCP_WND < MBEDTLS_SSL_IN_CONTENT_LEN || TCP_WND < MBEDTLS_SSL_OUT_CONTENT_LEN) {
     LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG|LWIP_DBG_LEVEL_SERIOUS,
@@ -840,7 +841,7 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
     altcp_mbedtls_free_config(conf);
     return NULL;
   }
-  mbedtls_ssl_conf_authmode(&conf->conf, ALTCP_MBEDTLS_AUTHMODE);
+  mbedtls_ssl_conf_authmode(&conf->conf, authmode);
 
   mbedtls_ssl_conf_rng(&conf->conf, mbedtls_ctr_drbg_random, &altcp_tls_entropy_rng->ctr_drbg);
 #if ALTCP_MBEDTLS_LIB_DEBUG != LWIP_DBG_OFF
diff --git a/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h b/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
index e41301c061c..71aa5993935 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
@@ -100,12 +100,6 @@
 #define ALTCP_MBEDTLS_SESSION_TICKET_TIMEOUT_SECONDS  (60 * 60 * 24)
 #endif
 
-/** Certificate verification mode: MBEDTLS_SSL_VERIFY_NONE, MBEDTLS_SSL_VERIFY_OPTIONAL (default),
- * MBEDTLS_SSL_VERIFY_REQUIRED (recommended)*/
-#ifndef ALTCP_MBEDTLS_AUTHMODE
-#define ALTCP_MBEDTLS_AUTHMODE                        MBEDTLS_SSL_VERIFY_OPTIONAL
-#endif
-
 #endif /* LWIP_ALTCP */
 
 #endif /* LWIP_HDR_ALTCP_TLS_OPTS_H */
-- 
2.43.0

