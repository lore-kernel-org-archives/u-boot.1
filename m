Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCDACE8E63
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F62888FA7;
	Thu, 24 Oct 2024 13:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZV9dcrDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DE188F48; Thu, 24 Oct 2024 13:25:34 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A2A188F47
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a4031f69fso106242966b.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729769132; x=1730373932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcu8YE5sVDxrapWp+sBeZLFxERfJYVHXUsD7NwBjx6k=;
 b=ZV9dcrDo3MJnHmYL8/h3lDE6zREfESglz8AjUvwROJY6PCu/QbpaddkCJ3F7MHPuKo
 E2LEgyZM9edATgJloJ9g2XhaEX57cMhxnHhh/KhSs2DykWa6gAdHgR5Js0v4FTkJUwjO
 XkGxvQPj55f+PpD9goZ/Qcf80wiAYxNhxUYsoexEOBCpu4Udepnq5JauR3hiNoOB4bit
 zlUJRzG+nr1crStKo7UOdTVlyWYhuIjqY/WlsFT/ts87navoawkZOXesaEMwC6kctmJr
 FJ2uFQNx7shGGIc+hkC+GXe3dhcCkvqO8v9rj/uXdjwX4qSN5GZjwgi2y5pgoPDA1K3v
 F6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769132; x=1730373932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcu8YE5sVDxrapWp+sBeZLFxERfJYVHXUsD7NwBjx6k=;
 b=RXnn3TKK32f4igMIFLm541r0M1sOxUfe2b1Y4UT0HHUsfXq8fSsCdXS6TgVta/IlY1
 o9xfJrmNJBbOscwQklXVuMbjF9S8FYx2DMHYxyPm4QoFVSeSQ2pcx3+Iv33RE+gDh/TO
 nI/SsB5Nr+GQ5HPvqqa8J9duqsrI2xJ0WJSvn8YsiieYmqCWWNcue4vwzgeUbt1dPGvR
 Tu5lNRxnO+5Ef4xxd7e3FqMBaAId+M3deJI6dgrO0XC8RNILpDrQBbk91iwPyfBi5qDC
 R2eXd2tB+kCKSx0IVA74z2w4fBmcyfYWpzI77Wql8eb+0GDbvGZItT0QdfS3STR0k/hf
 9drw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIaTYYj8Vb2qNngCBXLYxSyNAWDkcjsClT7+mC3uLhOLCj8tnMOHmcGASblj/K0U5LP7U3yVA=@lists.denx.de
X-Gm-Message-State: AOJu0YxJCMOWk6D41ZsTgB3a4wQBw56fZwnz5oFpUv0Jf9hOnm7+uHjH
 6IekMLQAAJykqLM9Uum6NQfbeiTfhOx29xuteFKDMww7K61StaWGjlbsMcVsW2E=
X-Google-Smtp-Source: AGHT+IFOgOXT5GlRPFAqL24Nvm5agBBY3/HBuM7cY5uyXTrZOP4IWoipX4aEhG1e0ub21fkoIMlF4Q==
X-Received: by 2002:a17:907:1c22:b0:a99:f29a:bc9a with SMTP id
 a640c23a62f3a-a9ad2710be1mr170993966b.7.1729769131738; 
 Thu, 24 Oct 2024 04:25:31 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91572c0dsm611534466b.177.2024.10.24.04.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 04:25:29 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Javier Tia <javier.tia@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH v2 3/6] net: lwip: Add Support Server Name Indication support
Date: Thu, 24 Oct 2024 14:24:10 +0300
Message-ID: <20241024112449.1362319-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
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

