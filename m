Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9246CE8E62
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CC588EE1;
	Thu, 24 Oct 2024 13:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XSHyKMKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F9B88EF7; Thu, 24 Oct 2024 13:25:14 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9AE088EE0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a3dc089d8so99619866b.3
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729769112; x=1730373912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zs+NGUFYtW9cLpOstJpdzvzW6CNb2t22qVaYqByjTRU=;
 b=XSHyKMKvAyi+v3lZHS7Pg7j81gjNQ1lA3dLOlCBOJZaNsoHzlsmXvNG7z6YjwWVABR
 /NSFYKMD6NhMSp0Q/S6vuL5bghXGTnMaSCn0bq/RXLmCmVvpTDVzLS10STEfwPj06BL1
 2lQgFBRMfS+SmeWfYNPY9HX2QzLEh1nS/R62D/hHE34jGCs9+b2CzYzURy1PsCFcK+wJ
 VrCTNKtoIbMZRpzXX1S6lDR8yqOd+NDhCPG34eV7gk1gW7JNb+V562IX99faEie4+/py
 EPOW2/Mwzf45iGuJ/bLO8QCo+uOxVvFKb5BlVYSE+QLJHxDfDiAPUyr6mm+84DdKiWum
 F6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769112; x=1730373912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zs+NGUFYtW9cLpOstJpdzvzW6CNb2t22qVaYqByjTRU=;
 b=eYzPsUWxgn6EOlp6Khq+AzjAt9nk7ZuxnYv01xz6ZCgSKO/xaWHWY44ZSOFIe5/y1A
 SBNrAoyXT7rfmXJxAhe1fQKQhCqLjTMScW8hhp7RHIpu53VtTC7vCecPWSM0UhaTbZYj
 /yJqqqQuJlsC61I9c8JycPpvQVy+cWypqZHogXHyMZtfB+wSR9oNjaGvIGdbllWV90h5
 tV0LXhK42JHDmp/y4ftThy//hHwcO3AEEChcja59oxlHKgQyWO8mS7WVltsrSigQKCQp
 yk/SxuYbaNfMUO2Ec1Yp2jyjagrlWQo8+3NfF4Hf7U/+noQCWe4lhBBETvXEg2+0Xzfy
 uq6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5BFtT7e78JcPimOUTDBo05BfjDRwiW/QgKmWJ++X5xId5xkEPMuASwkKtp2yK2mN1d1H+Wls=@lists.denx.de
X-Gm-Message-State: AOJu0YyOzEjjQDxjCQsRwACrHS4jOiRCEtGw3qF/gTdr6ZQ1jjnzZCtE
 d98fNJp0EcyZAY5G52pK26eF+Ntq6cZ+rrqqLDzB7kSPHSrO6grSQD9ROmT2TZ0=
X-Google-Smtp-Source: AGHT+IEGtSMTnL+mrcKO5up5w1N6m11mGYTRqsoDVcG5/F0SRkbQ1KjjyS2K+5Ny+XmBfLoUmxxzrQ==
X-Received: by 2002:a17:907:9496:b0:a99:46dd:f397 with SMTP id
 a640c23a62f3a-a9abf96f1f5mr510022966b.64.1729769112305; 
 Thu, 24 Oct 2024 04:25:12 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91572c0dsm611534466b.177.2024.10.24.04.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 04:25:10 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 1/6] mbedtls: Enable TLS 1.2 support
Date: Thu, 24 Oct 2024 14:24:08 +0300
Message-ID: <20241024112449.1362319-2-ilias.apalodimas@linaro.org>
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

Since lwIP and mbedTLS have been merged we can tweak the config options
and enable TLS1.2 support. Add RSA and ECDSA by default and enable
enough block cipher modes of operation to be comatible with modern
TLS requirements and webservers

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/mbedtls/Kconfig              | 12 ++++++++
 lib/mbedtls/Makefile             | 31 +++++++++++++++++++
 lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

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

