Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDFAD5E37B
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 08:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440F688FCB;
	Sun, 10 Nov 2024 09:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jjl+0tam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE75889368; Sun, 10 Nov 2024 09:31:51 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA0388FBF
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 09:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so541753866b.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 00:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731227509; x=1731832309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/C1Mgr2FaVCgTqvSk7UzY3gLKlYCDdfALXgmnhzHth8=;
 b=jjl+0tamHoExAoN+JuBSB7yjo2aeSyEKVc025nBbl9Xtv6k+QXnVfuRh/OaBhMYMtM
 R3yuN54JNI5dIhIKnBgKdTIbc5P/8yFZfeyFXuysL78xWmorBv1ACS7UFP96tD8oPDLh
 kpQoEXna/iX2RwFJ7K7iAWXo7DR4jT9xH8Tfb2E+IouFYTlmnpbXQRjp3TmhFb0NVGr2
 OZRyvb47mp9kKhTZuYrDZ/HkZiRgXSA3At625jHlYDQm0afsyreMCLLnnisPvR6J8MJt
 KD1DQiT3ygEpMUf38YuRKiZqZkSGvURO0wEmIiGYGp58eGBD4VVyXnPMSHavkWQGt+gE
 Tiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731227509; x=1731832309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/C1Mgr2FaVCgTqvSk7UzY3gLKlYCDdfALXgmnhzHth8=;
 b=uX7Kg4rs1pqnBkaflRqyb/c28Z5q2SFflddrhUIzMdytOqvIwXHK4f/g99Uf+lmDnx
 CcVURqQ+rNm74mhv1tQgT+C/mCIBHr55dfEu1voBAIIrQoR8jym7iDUqpu+4Kr0SILRq
 nHs2DiEJMjLwCiGk4n3zR67rHWOcwgLBZf4+OeJoEFRwk9bzRVKAIfCi/4hM88DzgRzU
 EDFCRZvihD9wqO0k+Uzu/2wYxH6uVxhfLCAZ/5YMV+lEv7C8Y7ifiiortzcz9KXtbUFY
 +wmrirShi+PCGtdEVgMAFDqg8NUTO0PjRTTsOkG1LQmBVF8mjOi2slqZsAqcl6iaIBqy
 PzLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR0wHtlVzMGto6Ii1tggtrL28oInGimkAAgGunyk2DeJvqFgg6RfW62Drk6oFOtqvNaSpjtTw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7+3KiKW2DCBcauK9PC2uw+LuaYWNOyGX8AYNx+EEeH1P3Pr1C
 6+AR5WC8FeWz//DcYAwLkh6KKG2cCIlG29XaNidRoFyypiJxNs0Zv8Z8M4mq3Rs=
X-Google-Smtp-Source: AGHT+IGmsgau5Lp4Ske2AdgE+nWP1ATl64O1vKPhMjP0O1ark4HCQZjXc/WomT6Pd2OU6rLM0vVQog==
X-Received: by 2002:a17:907:1c20:b0:a9a:558:3929 with SMTP id
 a640c23a62f3a-a9eefff12d2mr871712466b.48.1731227508811; 
 Sun, 10 Nov 2024 00:31:48 -0800 (PST)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17b3csm451909166b.19.2024.11.10.00.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 00:31:47 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org
Cc: Anton.Antonov@arm.com, Javier Tia <javier.tia@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 3/6] net: lwip: Add Support Server Name Indication support
Date: Sun, 10 Nov 2024 10:28:39 +0200
Message-ID: <20241110083017.367565-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
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
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c    | 14 +++++++++-----
 lib/lwip/lwip/src/core/tcp_out.c                   |  2 +-
 lib/lwip/lwip/src/include/lwip/altcp_tls.h         |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
index ef19821b89e0..6643b05ee94d 100644
--- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
+++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
@@ -3,7 +3,7 @@
  * Application layered TCP/TLS connection API (to be used from TCPIP thread)
  *
  * This file provides a TLS layer using mbedTLS
- *
+ * 
  * This version is currently compatible with the 2.x.x branch (current LTS).
  */
 
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
@@ -973,13 +975,15 @@ altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2way
 
     mbedtls_ssl_conf_ca_chain(&conf->conf, conf->ca, NULL);
   }
+  strlcpy(conf->host, host, sizeof(conf->host));
+
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
@@ -995,7 +999,7 @@ altcp_tls_create_config_client_2wayauth(const u8_t *ca, size_t ca_len, const u8_
     return NULL;
   }
 
-  conf = altcp_tls_create_config_client_common(ca, ca_len, 1);
+  conf = altcp_tls_create_config_client_common(ca, ca_len, 1, NULL);
   if (conf == NULL) {
     return NULL;
   }
diff --git a/lib/lwip/lwip/src/core/tcp_out.c b/lib/lwip/lwip/src/core/tcp_out.c
index b5d312137368..6dbc5f96b60e 100644
--- a/lib/lwip/lwip/src/core/tcp_out.c
+++ b/lib/lwip/lwip/src/core/tcp_out.c
@@ -2028,7 +2028,7 @@ tcp_rst(const struct tcp_pcb *pcb, u32_t seqno, u32_t ackno,
         u16_t local_port, u16_t remote_port)
 {
   struct pbuf *p;
-
+  
   p = tcp_rst_common(pcb, seqno, ackno, local_ip, remote_ip, local_port, remote_port);
   if (p != NULL) {
     tcp_output_control_segment(pcb, p, local_ip, remote_ip);
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
2.43.0

