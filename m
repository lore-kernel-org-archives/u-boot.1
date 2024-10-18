Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD38D30013
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F6A891E1;
	Fri, 18 Oct 2024 16:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KlY1Nu+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D1A891E9; Fri, 18 Oct 2024 16:23:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C36489130
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4305413aec9so22891885e9.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729261368; x=1729866168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nVaCe/5c3Pgv6MVW0O0cTyZuIeAelWqXzVeLvHfcko=;
 b=KlY1Nu+d0z+p04HEqG/Z5LQTHOnRrumrkod/pb0TwvNGAMYgDryYSDb8+OZNGYRUn3
 LFoT6ZIRQPTdG0ggN1aF8+oFV4dWnveZo92bmjlws34wm667guGBAhFHn3/xh5hdjwkc
 JgC7i4hvQ+cHRmx0HmXxeHUeZDHhwTKsAK8I0TKA4oRVbn/G3IKPANamd6DIu1ptQ7Hh
 XlW7QciEmQO6twvQVValxTPBG/T8FOAWzPtjB9aA4Uv0TCltVZr9NwWPQC6v8YwSu82f
 waEvgPAltGyhbf9J+B5LtTZhlQn/VLYU7eoQPryozv+hWotrjuur/TJkkxmSviY2wfLv
 8F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261368; x=1729866168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nVaCe/5c3Pgv6MVW0O0cTyZuIeAelWqXzVeLvHfcko=;
 b=Bqw/QkBuqitoFP1RgP5GSTRkg+v1haAiabZgdmpgcef/nw8GgerLKjfZOL88LFhbev
 l/DyFkJL38QYqgJmSdKNr81fuqNXI0DDAo0djSENvW8rem6SJWzUT4yzON9UrmwH7Ny8
 ol1Cuf6LNEnT+TO+nYZCxaDnGqalD2YNUTGTBLbf4970Nk+41lvg8HhCc7HOzVwBde4e
 vzCL9PaR0n+utRA9vANL09G3dMSQTyWJUJxV5wdO2u2k9iSM087bR2aS8PLL74TSuSrK
 jbXjVeP0REKUxWZxwTlBbzHGKs9/L3cqqkJfJTQjIJo+wASENomcpAdHZV7JOYLAYLlY
 ZhHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9Tp7lqKllKlO7j60InNp5wzFoUgRP6m0kFGzOvydzdPyopUDdpLf5sGYVRW7GCz/6A0wiGjk=@lists.denx.de
X-Gm-Message-State: AOJu0YyI27Cz5NZX1OYD7EbtmZ33+MH4bcb26NeroZKmKYF3QZKx+sMR
 9RRcuQZkNgvEgT4Dx3XnMJWoO/Vc45K2TNYgEErlOfZ8SUIv74yYxf2ZO5KJoyg=
X-Google-Smtp-Source: AGHT+IH7ZIMar9Kci4+bDZLgj1ihn6X98i6X2KsVMlK4rAQGvU6UlYNILXrnVfVW+3E5lD+0j1Ssjw==
X-Received: by 2002:a05:600c:4e12:b0:431:1d97:2b0a with SMTP id
 5b1f17b1804b1-43161641793mr22843545e9.15.1729261368454; 
 Fri, 18 Oct 2024 07:22:48 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm28781665e9.10.2024.10.18.07.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:22:47 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 1/6] mbedtls: Enable TLS 1.2 support
Date: Fri, 18 Oct 2024 17:21:55 +0300
Message-ID: <20241018142235.715571-2-ilias.apalodimas@linaro.org>
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

Since lwIP and mbedTLS have been merged we can tweak the config options
and enable TLS1.2 support. Add RSA and ECDSA by default and enable
enough block cipher modes of operation to be comatible with modern
TLS requirements and webservers

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/mbedtls/Kconfig              | 12 ++++++++
 lib/mbedtls/Makefile             | 33 +++++++++++++++++++-
 lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index d71adc3648ad..f3e172633999 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -430,4 +430,16 @@ endif # SPL
 
 endif # MBEDTLS_LIB_X509
 
+config MBEDTLS_LIB_TLS
+	bool "MbedTLS TLS library"
+	depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
+	depends on X509_CERTIFICATE_PARSER_MBEDTLS
+	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	depends on ASN1_DECODER_MBEDTLS
+	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	depends on MBEDTLS_LIB_CRYPTO
+	help
+	  Enable MbedTLS TLS library. If enabled HTTPs support will be enabled
+	  in wget
+
 endif # MBEDTLS_LIB
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 83cb3c2fa705..845284799a11 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -25,7 +25,19 @@ obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
 	$(MBEDTLS_LIB_DIR)/platform_util.o \
 	$(MBEDTLS_LIB_DIR)/constant_time.o \
-	$(MBEDTLS_LIB_DIR)/md.o
+	$(MBEDTLS_LIB_DIR)/md.o \
+	$(MBEDTLS_LIB_DIR)/entropy.o \
+	$(MBEDTLS_LIB_DIR)/entropy_poll.o \
+	$(MBEDTLS_LIB_DIR)/aes.o \
+	$(MBEDTLS_LIB_DIR)/cipher.o \
+	$(MBEDTLS_LIB_DIR)/cipher_wrap.o \
+	$(MBEDTLS_LIB_DIR)/ecdh.o \
+	$(MBEDTLS_LIB_DIR)/ecdsa.o \
+	$(MBEDTLS_LIB_DIR)/ecp.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
+	$(MBEDTLS_LIB_DIR)/gcm.o \
+
 mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
 mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
 mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
@@ -54,3 +66,22 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/x509_crt.o
 mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pkcs7.o
+
+#mbedTLS TLS support
+obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
+mbedtls_lib_tls-y := \
+	$(MBEDTLS_LIB_DIR)/mps_reader.o \
+	$(MBEDTLS_LIB_DIR)/mps_trace.o \
+	$(MBEDTLS_LIB_DIR)/net_sockets.o \
+	$(MBEDTLS_LIB_DIR)/pk_ecc.o \
+	$(MBEDTLS_LIB_DIR)/ssl_cache.o \
+	$(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
+	$(MBEDTLS_LIB_DIR)/ssl_client.o \
+	$(MBEDTLS_LIB_DIR)/ssl_cookie.o \
+	$(MBEDTLS_LIB_DIR)/ssl_debug_helpers_generated.o \
+	$(MBEDTLS_LIB_DIR)/ssl_msg.o \
+	$(MBEDTLS_LIB_DIR)/ssl_ticket.o \
+	$(MBEDTLS_LIB_DIR)/ssl_tls.o \
+	$(MBEDTLS_LIB_DIR)/ssl_tls12_client.o \
+	$(MBEDTLS_LIB_DIR)/hmac_drbg.o \
+	$(MBEDTLS_LIB_DIR)/ctr_drbg.o \
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index 1af911c2003f..ac8f0bbf2c0e 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -87,4 +87,56 @@
 
 #endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
+#include "rtc.h"
+
+/* Generic options */
+#define MBEDTLS_ENTROPY_HARDWARE_ALT
+#define MBEDTLS_HAVE_TIME
+#define MBEDTLS_PLATFORM_MS_TIME_ALT
+#define MBEDTLS_PLATFORM_TIME_MACRO rtc_mktime
+#define MBEDTLS_PLATFORM_C
+#define MBEDTLS_SSL_CLI_C
+#define MBEDTLS_SSL_TLS_C
+#define MBEDTLS_CIPHER_C
+#define MBEDTLS_MD_C
+#define MBEDTLS_CTR_DRBG_C
+#define MBEDTLS_AES_C
+#define MBEDTLS_ENTROPY_C
+#define MBEDTLS_NO_PLATFORM_ENTROPY
+#define MBEDTLS_SSL_PROTO_TLS1_2
+#define MBEDTLS_SSL_SERVER_NAME_INDICATION
+#define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
+
+/* RSA */
+#define MBEDTLS_KEY_EXCHANGE_RSA_ENABLED
+#define MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
+#define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
+#define MBEDTLS_GCM_C
+
+/* ECDSA */
+#define MBEDTLS_ECDSA_C
+#define MBEDTLS_ECDH_C
+#define MBEDTLS_ECDSA_DETERMINISTIC
+#define MBEDTLS_HMAC_DRBG_C
+#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
+#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
+#define MBEDTLS_CAN_ECDH
+#define MBEDTLS_PK_CAN_ECDSA_SIGN
+#define MBEDTLS_ECP_C
+#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
+#define MBEDTLS_ECP_DP_BP256R1_ENABLED
+#define MBEDTLS_ECP_DP_BP384R1_ENABLED
+#define MBEDTLS_ECP_DP_BP512R1_ENABLED
+
+#endif /* #if defined CONFIG_MBEDTLS_LIB_TLS */
+
 #endif /* #if defined CONFIG_MBEDTLS_LIB */
-- 
2.45.2

