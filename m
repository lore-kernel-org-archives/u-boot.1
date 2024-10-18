Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8E9D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC5989128;
	Fri, 18 Oct 2024 16:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H9vOB6gq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D5B88FA4; Fri, 18 Oct 2024 16:23:15 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EB4891E7
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4305413aec9so22895175e9.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729261382; x=1729866182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcu8YE5sVDxrapWp+sBeZLFxERfJYVHXUsD7NwBjx6k=;
 b=H9vOB6gqOnkP4SB6xbS3B39/AKrVkxxr60COayiM7KGMJ3fTF2evQ7KVclSSFnDA1c
 +/ktjuPDVz9oEEihtKSpDO2K3ym5tVb825ZNqxLbglr7F8XImeDlL9ONOnGVg67U92lj
 2ZTaYf8F2GCH0CdnlnU3KgXNJGs8VsHlFc8PXGmr7EDqWUwe/DwY4mZKNCdTYu/ArFBf
 iwwf5+6B074Rta0Dea5hvUEpo6S633hd3c2gX2MWSLg272LMNAjx6x7JCmBcv1khcrCs
 kcEt/4y3fVTqei7yWDO7edfcL7AQcuf0WhdGf7EoQKAOHU8jx//mCJ0IKqjQg68UOs7z
 zxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261382; x=1729866182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcu8YE5sVDxrapWp+sBeZLFxERfJYVHXUsD7NwBjx6k=;
 b=Sv9MrBBxlCc8+X74wH2Lj5xt/Jfqckvt0Uxs2I59+1aYtiKz5igY3FoRYoKM3tpBei
 kWWtTLBRfpsWX0SQn5gfTuCsb2QrHsXlw4a8dERNkY5oHVDyNM0kdX61MDElKPvOcOMi
 GaZa7WcKMEC2+a8DAWb0C50wZwFxeXzqriJyQLbxWP7SIELqgczyscgC72vUuMFtEiPt
 BgFJgT6JCoAYZBVlZOoHpi4aTCEz8ruYFUYIpaKsI4upXp2bnJJ9p3J6Js7dvNkkLbDP
 lkk1sYfot4Y1ujYwhyWA/u0dF+CynpvbJ2ewYH8oc0SsDoTGVGFEaq9jFZpYca1KBAFy
 Wn3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9dZHPargya1/tsQxTwD5BG54+KJKC+DERdqpNPQbiZC9+Osok4oaj4g6MATaQ/NOkV4LIuQ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6qqZxTld4tv4u8HJjK7vUYiZoRXuzAD6K7pzfzsQ3/XtCMYh1
 PO4XoDWMF5JdHrAQxO9jVyz3zFFl9GqmM5/eF8hzFzZvRWKvhI7VysqOE/zYa8A=
X-Google-Smtp-Source: AGHT+IE42exk4aQnjGcpDlY8bkYQGwy6BbkFS47+ZvpzrhgJ/6ZwJ6c7gMCZnHgVb/qVHQAcwBG+CA==
X-Received: by 2002:a05:600c:1d1a:b0:430:5654:45d0 with SMTP id
 5b1f17b1804b1-431616418c0mr22389835e9.14.1729261381963; 
 Fri, 18 Oct 2024 07:23:01 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm28781665e9.10.2024.10.18.07.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:23:01 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Javier Tia <javier.tia@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 3/6] net: lwip: Add Support Server Name Indication support
Date: Fri, 18 Oct 2024 17:21:57 +0300
Message-ID: <20241018142235.715571-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
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

From: Javier Tia <javier.tia@linaro.org>

SNI, or Server Name Indication, is an addition to the TLS encryption
protocol that enables a client device to specify the domain name it is
trying to reach in the first step of the TLS handshake, preventing
common name mismatch errors and not reaching to HTTPS server that
enforce this condition. Since most of the websites require it nowadays
add support for it.

It's worth noting that this is already sent to lwIP [0]

[0] https://github.com/lwip-tcpip/lwip/pull/47

Signed-off-by: Javier Tia <javier.tia@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 11 +++++++----
 lib/lwip/lwip/src/include/lwip/altcp_tls.h           |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
index ef19821b89e0..24b432966312 100644
--- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
+++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
@@ -106,6 +106,7 @@ struct altcp_tls_config {
   u8_t pkey_count;
   u8_t pkey_max;
   mbedtls_x509_crt *ca;
+  char host[256];
 #if defined(MBEDTLS_SSL_CACHE_C) && ALTCP_MBEDTLS_USE_SESSION_CACHE
   /** Inter-connection cache for fast connection startup */
   struct mbedtls_ssl_cache_context cache;
@@ -642,6 +643,7 @@ altcp_mbedtls_setup(void *conf, struct altcp_pcb *conn, struct altcp_pcb *inner_
   /* tell mbedtls about our I/O functions */
   mbedtls_ssl_set_bio(&state->ssl_context, conn, altcp_mbedtls_bio_send, altcp_mbedtls_bio_recv, NULL);
 
+  mbedtls_ssl_set_hostname(&state->ssl_context, config->host);
   altcp_mbedtls_setup_callbacks(conn, inner_conn);
   conn->inner_conn = inner_conn;
   conn->fns = &altcp_mbedtls_functions;
@@ -951,7 +953,7 @@ altcp_tls_create_config_server_privkey_cert(const u8_t *privkey, size_t privkey_
 }
 
 static struct altcp_tls_config *
-altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2wayauth)
+altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2wayauth, char *host)
 {
   int ret;
   struct altcp_tls_config *conf = altcp_tls_create_config(0, (is_2wayauth) ? 1 : 0, (is_2wayauth) ? 1 : 0, ca != NULL);
@@ -973,13 +975,14 @@ altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2way
 
     mbedtls_ssl_conf_ca_chain(&conf->conf, conf->ca, NULL);
   }
+  memcpy(conf->host, host, sizeof(conf->host));
   return conf;
 }
 
 struct altcp_tls_config *
-altcp_tls_create_config_client(const u8_t *ca, size_t ca_len)
+altcp_tls_create_config_client(const u8_t *ca, size_t ca_len, char *host)
 {
-  return altcp_tls_create_config_client_common(ca, ca_len, 0);
+  return altcp_tls_create_config_client_common(ca, ca_len, 0, host);
 }
 
 struct altcp_tls_config *
@@ -995,7 +998,7 @@ altcp_tls_create_config_client_2wayauth(const u8_t *ca, size_t ca_len, const u8_
     return NULL;
   }
 
-  conf = altcp_tls_create_config_client_common(ca, ca_len, 1);
+  conf = altcp_tls_create_config_client_common(ca, ca_len, 1, NULL);
   if (conf == NULL) {
     return NULL;
   }
diff --git a/lib/lwip/lwip/src/include/lwip/altcp_tls.h b/lib/lwip/lwip/src/include/lwip/altcp_tls.h
index fcb784d89d70..fb0618234481 100644
--- a/lib/lwip/lwip/src/include/lwip/altcp_tls.h
+++ b/lib/lwip/lwip/src/include/lwip/altcp_tls.h
@@ -92,7 +92,7 @@ struct altcp_tls_config *altcp_tls_create_config_server_privkey_cert(const u8_t
 /** @ingroup altcp_tls
  * Create an ALTCP_TLS client configuration handle
  */
-struct altcp_tls_config *altcp_tls_create_config_client(const u8_t *cert, size_t cert_len);
+struct altcp_tls_config *altcp_tls_create_config_client(const u8_t *cert, size_t cert_len, char *host);
 
 /** @ingroup altcp_tls
  * Create an ALTCP_TLS client configuration handle with two-way server/client authentication
-- 
2.45.2

