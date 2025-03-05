Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0E6C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12F4812C8;
	Wed,  5 Mar 2025 15:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kuEi6mBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A189F811B3; Wed,  5 Mar 2025 15:27:18 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98866808B6
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390dd362848so5296697f8f.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741184836; x=1741789636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2s5Icwnuj6cOD5wt7+DAoUp8NjQQGsscIFURIpb1s8=;
 b=kuEi6mBj9bXqcuummPKsrg24W/QHnadgkZR87J2nD06JyZWAJW+R/TRB7cxOWCv3g1
 zkS0NRTN7Tgd0XkEw7eqkNkimStojUefg9AgRGQu0zJEuyb63vHA1ji9r8EOOhMoG2JT
 Y1JV1alTh79QoDokVcB9TxKAaRiX3D9POoZEq3crVYNXyRFbrpyMlE9DPeFXnSN7/oFF
 g76BIzvmgP7TKYnnIEHzHM4a6/q6q+QLTAiBWMEhXZ/2+eLDUUuj7eGOXjaztB1rRvnV
 oGUzSkSoy4oSOIjkk1jWfkRJvVarlIlQpJYLOd+I4VGU7h5jA4jW1W54QmakXeb6UESB
 2Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184836; x=1741789636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2s5Icwnuj6cOD5wt7+DAoUp8NjQQGsscIFURIpb1s8=;
 b=p/ZJgstaITBUwee0/ePtZhrzoI0VlJKFQ5fMNpYUA9ZQEDbvY90H9vQXQcaEcZ+l0z
 Ht9wjGYoUe1QJ0CcD0vtdlE6jb/SEQVObsdSolSnXO3euB2qSkJawLa0yvla6ED3CeEB
 9btN5Ah7QrCTnfdXWpjzbhmvBQmb5WlElwavpY+XL4/HquKHpr8Y+C3FVWvkq84NOgng
 VZ3aegDUFqeyfJnC0fUUkUWVMkQKvU/ERsdNZDg59jDlSVXzlMbSC6X8R/HXc7uv6fzF
 E5QaFjLwfAXTG6GyIA5mzJYOpBH4hL3tyB4lHFZItCOWJWEWud6XtizIkv5UGd3KC3kA
 5PFw==
X-Gm-Message-State: AOJu0YyQM96dfY64NF4YCycJLDhB4hdFL3zoknWPEPJzehhkPy2q5We5
 DjktIMh76UC7CrCbAxUwSLhPiYUo7o8ANp/s4CeuTJMw8KzoRVmjaseiHa7PnGTgio4doTEZU02
 z
X-Gm-Gg: ASbGncvK085JHjTCG3qdIqqf0Ll7HeFfmmGsr7ZFRYQzNkmBh2smk/w8S2Ga6RGO99P
 8/QQGjgCPjPkj1LErT3uXLUubs5bbV8sHWdGPa+uxd+7vUL8jmXBZFXn15YepUIreuOZ8ZIUmtN
 L9jAyJmEahnrH2uA53W2I+3XVVT4rPYDXx7vCltTw41ZXg3sdK0UHZIUxOOwyQbCsoWK/WHOUU8
 D6vDinphsIQVMTTuJNgS42mYk1tBrpPZrjAxn0Hb2dhqDOBD6pJoVF5v8VbN2R9+JxkytUOPNkj
 MUhBVqzAMkkLbno8yi4AKx99XXPG1JcHCt9fJghJps5EhAqdWMitTg==
X-Google-Smtp-Source: AGHT+IEBCc11uPzTF97IBxzbAKwsOo65KGVVS5CTTN0uXK+w0is9RQOL6MEEHrGpAiBTxLv5ctkNzQ==
X-Received: by 2002:a5d:6da7:0:b0:38f:2766:759f with SMTP id
 ffacd0b85a97d-3911f7a8406mr2848139f8f.41.1741184835910; 
 Wed, 05 Mar 2025 06:27:15 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:369c:9bd8:7c87:9a39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm5442456f8f.52.2025.03.05.06.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 06:27:15 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Javier Tia <javier.tia@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 2/6] lwip: tls: enforce checking of server certificates
 based on CA availability
Date: Wed,  5 Mar 2025 15:26:43 +0100
Message-ID: <20250305142650.2966738-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305142650.2966738-1-jerome.forissier@linaro.org>
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

