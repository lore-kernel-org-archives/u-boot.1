Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371FFD5E39B
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 08:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9408089357;
	Sun, 10 Nov 2024 09:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uCKb7lEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D643989359; Sun, 10 Nov 2024 09:31:19 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBAD688FBF
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 09:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a68480164so517528066b.3
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 00:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731227477; x=1731832277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viEi+HFScF82aH3Zr9LnZ1fbegZHAnL/ByGWJd+Q0II=;
 b=uCKb7lEC13nxD4Eq3VkSSrvxgJt3IpzTG2P2rHjfGs0ZUonKEZfU2aLuGSZnSYCvh/
 +L8785N6/3nFsMwEkK+F81b50sdMsRI2ia8Dw3XJX7oFDKVYEHc/bAPqXW75KbBI5Ch2
 k0T+1KU06lVqUAb/cbj5thebNazRx4jMd/zJP31f/1QmgRGI4dBSz+58LSKt+Y+28hAz
 8oacDVrKKbR/PZq9RLo59y1dn8QU9afOGTV84JHJDQC9qxgM5YBdHsYTZtMSKuaXqb3r
 Y36L8iTy209XNERwdV+N0SmgaZ1xsZixqSFSsQ6Efa2v5BTqVATfh1pJXxe8CTLJkkOT
 MGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731227477; x=1731832277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viEi+HFScF82aH3Zr9LnZ1fbegZHAnL/ByGWJd+Q0II=;
 b=EoNP0imQbdgy2mxpUp5D62R2FIogsPEoPAfedt4plEjTSTYnbcBWPAZdo3KZO2UEjM
 RfGiZ132UUoAe5ywYRhBHEJfEStgLJ/AmbWGh4khV7ZEMPR9ZBbMLP91s6pKbZOPNo7K
 6bHcIpcC9LO6kvDKKjAOaQcdIdYgpv32NBrkHR+lwQ3Vg6R5rcgE8MPTJPL28vGMM092
 L1Qt/UoPXLyTH+DuUV/lG8Xy+2sGgFUQoUycH7LHwsBbDM22+4F2sQgFSJ3h3anzIJHZ
 Vp9rIXX/aV48+THi7qSrYyMp3U6/uidgGm5/FrTzo+xnGrVmlE5Ca5qFtVfSX5RU6anG
 ZgPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfRx26ePBs5k4X90G+jO6jENiTqMyGob7arEDvw2lUUKuMyqbUvA0DQo0n51FGaMQWy59heso=@lists.denx.de
X-Gm-Message-State: AOJu0YzKgymbD8XxGaHV6CaiEX1bU6SY6lz/wNzmN2C2zRf6L2dxhS6B
 FJDWk9pUcLdf5eX5N6WF77VvefLbw9ffkFW2p9NCBsB6/JOSb0cfK/OrhLAJIbI=
X-Google-Smtp-Source: AGHT+IHzEBrd7GtiUwDKOJrcVjX4GrgiEdUhIul5R23n6hXoaaNiL0ML+lu0L/bxD5wTseJNErlOJw==
X-Received: by 2002:a17:907:7f2a:b0:a9a:e0b8:5b7c with SMTP id
 a640c23a62f3a-a9eefebd003mr797568566b.7.1731227477153; 
 Sun, 10 Nov 2024 00:31:17 -0800 (PST)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17b3csm451909166b.19.2024.11.10.00.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 00:31:15 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org
Cc: Anton.Antonov@arm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 1/6] mbedtls: Enable TLS 1.2 support
Date: Sun, 10 Nov 2024 10:28:37 +0200
Message-ID: <20241110083017.367565-2-ilias.apalodimas@linaro.org>
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

Since lwIP and mbedTLS have been merged we can tweak the config options
and enable TLS1.2 support. Add RSA and ECDSA by default and enable
enough block cipher modes of operation to be comatible with modern
TLS requirements and webservers

Reviewed-by: Raymond Mao <raymond.mao@linaro.org>
Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/mbedtls/Kconfig              | 12 ++++++++
 lib/mbedtls/Makefile             | 31 +++++++++++++++++++
 lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index d71adc3648ad..78167ffa2520 100644
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
+	  Enable MbedTLS TLS library. Required for HTTPs support
+	  in wget
+
 endif # MBEDTLS_LIB
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 83cb3c2fa705..ce0a61e40541 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -26,6 +26,7 @@ mbedtls_lib_crypto-y := \
 	$(MBEDTLS_LIB_DIR)/platform_util.o \
 	$(MBEDTLS_LIB_DIR)/constant_time.o \
 	$(MBEDTLS_LIB_DIR)/md.o
+
 mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
 mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
 mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
@@ -54,3 +55,33 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
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
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index 1af911c2003f..d27f017d0847 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -87,4 +87,56 @@
 
 #endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
 
+#if IS_ENABLED(CONFIG_MBEDTLS_LIB_TLS)
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
2.43.0

