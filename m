Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C47C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DF3811C5;
	Thu, 27 Feb 2025 17:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lyt4ugn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1317811B3; Thu, 27 Feb 2025 17:09:36 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8302F81115
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394a823036so11752235e9.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740672573; x=1741277373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTbwl3F9OXzHhhDZT6BDLFMulx1o2E75GIczBDbdv8A=;
 b=Lyt4ugn9S9FwCH5nTn4Bhz4T5i/hFOkSOgrVso8UyqLjtVBxlvoRQ/DjYz1NsxS7Ix
 Al2XCl4fq8+gK9kiMhxbjUTTer7WL9I99m1Q1o630t0091kzG2L64oXhmYksQsu/cOYf
 hD2NYmU/VC10yljVeXW2nYdKygn9FhbLhFDqpCNRWxvZtrAxLT67irv7tTnl6EiyFnQL
 q5RCvkR+ZV3zIFMwH5GBNeChIiGPcyVPf8j36ARjClOzE7YeZZRDg1PPG8HYM9ch+omB
 vKKqKoE67rnhD4CkElQ03PsToWlTMEjO2cqAsJ7S3hHkEV4pjU+sJfWXDmZX5SbYfQVT
 y5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672573; x=1741277373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTbwl3F9OXzHhhDZT6BDLFMulx1o2E75GIczBDbdv8A=;
 b=HyKmy8CDxjykaZpLLV7e/p6s8fMNR0QDFHUxEyXeH8I6hr4+heYyh/BGkqFthgrlMd
 1Bez/4XZOOCvtrJriTGi6dzIawXc5+JVaz+slHijWE1nkO6qCsFK6x4P+VnYBQuluGpe
 Deo4YMzJRJLzOOiJ9TvOPj90353bsMuhkLZT5uiqHx93Jz7opzq8ByoCSFqqjkJ6bqw0
 jJO7chnduUHu2cZyFXhmiMk0XTYEtV00Hs6C6+Q4ul6C8HcndsnwzuF9WhoZl8UhaTHB
 nVWGGx1dHZuOnZy1dAnJLZWYyvnfNlnHXe4SdHdPp03yBkMlSX49zXEC6dXMqhl++pW1
 uwjw==
X-Gm-Message-State: AOJu0YyTyCxev1Xg98HU3u2DGZV/q50q5lNmSXp5U60/THc9OryymaXb
 06D4iVCEjQbioaMDHpEpczgyvd1/yDvlGu4t8ugC8dXd8dCqWE1mPDeolRuz9rEGy7nPIHdcwBp
 ghHk=
X-Gm-Gg: ASbGncvLGN1AC5FCe1GcnuG94URc4HYv8RPGBsxmwgTzsQr9X6mtsJanVppQVpHM+Dv
 SrNPjMKdqY4XoPNmaHas5uxfd5ygLiPDj4xS9GhCzliVZqkjInOnwMDJyVLtQG6sS49G0W3tx8Z
 GfsygkaiE2DjqGTfv3GVkM+9vWGKEArBovVcRxQmJmS04DVvV6HUqx0CaRZsOZQp4Lc5PcHi0Nf
 rdOmzJHu3uOvr8oM3+8MS2Q9D4m/mU+t/I7nheAze+GrB/lmdOtDk2fJQX6OU7ixuXd6UfTh/OZ
 cfNFvmVI+jl1Idrqz3e7e+CB/pgSI/c4aBk=
X-Google-Smtp-Source: AGHT+IGwPJ6ki4RPOOdLrCT/khoNZxAEJqc9v0lvwxp/EtLmTdTmxTsDOWCMjRqXclqqY2kE9n5ORQ==
X-Received: by 2002:a05:600c:3ca1:b0:439:9595:c8e7 with SMTP id
 5b1f17b1804b1-439aea9d78bmr244851715e9.0.1740672572679; 
 Thu, 27 Feb 2025 08:09:32 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b925sm59506795e9.7.2025.02.27.08.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:09:32 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Javier Tia <javier.tia@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 3/5] lwip: tls: warn when no CA exists amd log certificate
 validation errors
Date: Thu, 27 Feb 2025 17:09:03 +0100
Message-ID: <13cea41b33f62ddbd606a926bd1f79ddff8569fb.1740672437.git.jerome.forissier@linaro.org>
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

Using HTTPS without root (CA) certificates is a security issue. Print a
warning in this case. Also, when certificate verification fail, print
an additional message because "HTTP client error 4" is not very
informative (4 is HTTPC_RESULT_ERR_CLOSED).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
index fa3d1d74fed..ef51a5ac168 100644
--- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
+++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
@@ -298,6 +298,9 @@ altcp_mbedtls_lower_recv_process(struct altcp_pcb *conn, altcp_mbedtls_state_t *
     if (ret != 0) {
       LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG, ("mbedtls_ssl_handshake failed: %d\n", ret));
       /* handshake failed, connection has to be closed */
+      if (ret == MBEDTLS_ERR_X509_CERT_VERIFY_FAILED) {
+        printf("Certificate verification failed\n");
+      }
       if (conn->err) {
         conn->err(conn->arg, ERR_CLSD);
       }
@@ -841,6 +844,9 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
     altcp_mbedtls_free_config(conf);
     return NULL;
   }
+  if (authmode == MBEDTLS_SSL_VERIFY_NONE) {
+     printf("WARNING: no CA certificates, HTTPS connections not authenticated\n");
+  }
   mbedtls_ssl_conf_authmode(&conf->conf, authmode);
 
   mbedtls_ssl_conf_rng(&conf->conf, mbedtls_ctr_drbg_random, &altcp_tls_entropy_rng->ctr_drbg);
-- 
2.43.0

