Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067A6C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016478141D;
	Wed,  5 Mar 2025 15:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mdssnb0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D6881417; Wed,  5 Mar 2025 15:27:20 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6344E811C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso4147077f8f.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741184837; x=1741789637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqKYtD3GqjUkCBmF0aRwBJEerlGo6a56Ic88y4V845c=;
 b=mdssnb0bWACfl8l4JRXNe0IEYvclXfP5eHVM+NylP6Te+5Dx9g60g7Dn6/zRzMKzPZ
 tDAuBUgrToKbB391yMa4CVfEBZbOKpjVBzCGqDLFHESICAT6cFHGKMRlxNYeXzApgkXf
 0S5WFo/j9OPULvvurs2Wl2VKf0WBU4IC902UEa8Nx9YJdZ+ugiP2kDZkQraEOygjGKyv
 ZS4DPufjNigoqiL5EeEqwezsMMXMSKEaDYB+P/wnnBE5TCr5zu4gCQu5sEwEMGES/+10
 +19WatQnkbdZ2Z8OcfDBRQRPueYUAI75ZXva4T1/z8dDUWe/1slklqZvtpwZY856WXDT
 DrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184837; x=1741789637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqKYtD3GqjUkCBmF0aRwBJEerlGo6a56Ic88y4V845c=;
 b=O+xqMXklKpGWqRBb1G1+J5Ukk2KMz68uj1nHNQ6PMCrYIGyBx/dChtD8zy7Vtc3Yjl
 KsCl94grZ+bPRExY+CpghU0NxgoWHA9OqKGv4t59VIceHd5jGO8pddV13elU9EUXnbed
 Z5TFYeyBz2zdzExnfqisT4XIc1Bc1PgGJsa5dWt0vGfaOFjO+dpbdGy7qbcZ4+x/r4rb
 x9Nnv3YF6ZCVU9ReggaX28JPcj72Vd8Vt+WuNF2wepBA3NLwaoEMKXk+jyEm0WhQ04sX
 vzCCSNCaaMt6PRhZSm8PdTVash++7jeKdYuTsgV8SMlUTBarAGKsZy8YtTQgVxHBoG7P
 6qPg==
X-Gm-Message-State: AOJu0YyJugvdx45P0ubagnWYwaDmRM2q+X84uAWXzmoWG7ks/TjtTpOR
 mtz3viqOgtIvwNkjL/CqB2fj1ySna8eiCUAPAefEb2Fl+BdqMX8PnPchWNJko0dLcNWi3XZB7p1
 D
X-Gm-Gg: ASbGncsWdAgkCZG8FxUwf5Ztyq6ohULAW9dFQPV39b+Jopyov8LifxSegHj1hoXJIfH
 B2ySrdK25W8MSOi6mI2IOpips0g3NAtuDMOBKXh3Deg31gRDNZNf8+D+nMuD/BziBEXL9cm14DG
 rE0kQBvw9455/tD/1H0svI9HfmbfIs2vVuUULNXlQtdqsn+bRfm81Rq91JituWcdomF7KvNHpAe
 2T9/pHOcvmVRMMWikrOnguTqNuAADi6NAqRhyYSITjxIiIBtOKNOQ3GMN71Q2VDSiHrKXmY7/e6
 DBbEYZezF0Zg5TkHFRAHqCHilzdmLS7O3EwOKLAEfkVQRi3G9ddrmg==
X-Google-Smtp-Source: AGHT+IFldCcwlwKD7wUVSWB2/FsnVVY5XEmmYuxB6VNxkr4driC+SpsUhWx99turbC4erblTEjsagw==
X-Received: by 2002:a05:6000:1f8f:b0:391:253b:4046 with SMTP id
 ffacd0b85a97d-391253b4203mr2335945f8f.16.1741184836737; 
 Wed, 05 Mar 2025 06:27:16 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:369c:9bd8:7c87:9a39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm5442456f8f.52.2025.03.05.06.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 06:27:16 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Javier Tia <javier.tia@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 3/6] lwip: tls: warn when no CA exists amd log certificate
 validation errors
Date: Wed,  5 Mar 2025 15:26:44 +0100
Message-ID: <20250305142650.2966738-4-jerome.forissier@linaro.org>
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

Using HTTPS without root (CA) certificates is a security issue. Print a
warning in this case. Also, when certificate verification fail, print
an additional message because "HTTP client error 4" is not very
informative (4 is HTTPC_RESULT_ERR_CLOSED).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

