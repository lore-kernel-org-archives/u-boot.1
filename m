Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5A9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BCC88474;
	Tue, 16 Apr 2024 21:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cfnd6EaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4708F88440; Tue, 16 Apr 2024 21:02:26 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6388B8846E
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-699320fcbc1so25448656d6.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294136; x=1713898936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uo5I8z0i/eg+kIXbLre4my7Sq8NO1NkAADN/I0R0R1Q=;
 b=Cfnd6EaV3MkO6XasutscHLI/kXs0fr9lXXnb2SIvZIrU+Xuq/EZBmEeO4vbyu/lfiW
 MBSK3wkqM1kJ6gGrVxvCGdmp4tLXZDI+BxTJ/a1RUaXtv7YB2NW4aXET9A3B+CozkYLZ
 j4I60c2RWllmJzKTlxs+Hf8+pWqvzdfNWa3l1iRj4EH4IVMxzeoTpIZrWdNL7tCTkBdy
 EoYRAGymN2z24zgMEf+1b+2An65KaCTQCtrVjnKjM2RCZdWq+MAbWWzc3D2bOYzVkqYq
 EJ97urmxGsxUNxzH+gd8cyrV2PNJiaQX78mdgjppg5XuOmHLACGxbu82dqBM1P/ULU1n
 BvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294136; x=1713898936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uo5I8z0i/eg+kIXbLre4my7Sq8NO1NkAADN/I0R0R1Q=;
 b=tg0I1S+UOFxbb3bWKt6fXscothjyCSxBLXmuI6gxSzAC3kseQQFlKJSU23ixA+MpTZ
 xkk8SoxS7iZgSOscDAh3P/iD5v2UpwpQru55pEI6KYUjF3slFrVqUuI6e4XIAans6PpA
 1ql5mZmiX274XAEFGpXLG5LGojUA4GwB7dUKJjlG9XfvLze7tTmaFQPBUWxsH84/8Fbp
 7V3RQOQe/fLXAmwvad6H5NceTbEIXXW4/wsy2757tlk5oPdi2hn1t/kVKYH+U2eqwm/P
 RRHrybQzsJLDx7V+MJXK7ovCR1n9tOTkTNEwIj3fvNUFbzS+A6BB8EuhQo0Bq/oWdBPA
 W/Bw==
X-Gm-Message-State: AOJu0YxRft9Y8zqd+RSmC8DQr7udTxXMe+Co5dHGCqApyVoV8Vss03dX
 S6/sTcoTChtlBhWqbisOuLdkR1HcIJDQSj4Ho2iDzkd9zAccyIb3gCVKJ51jMDatYKlgCmki+LO
 V
X-Google-Smtp-Source: AGHT+IEmssfcpA3CjO8uBAGl7CkKGcaFCGqjjP10t43ARIyKgdkVk8hGa+EhMr70mJPtW7XKks6YPQ==
X-Received: by 2002:ad4:4bcb:0:b0:69b:55a4:cdff with SMTP id
 l11-20020ad44bcb000000b0069b55a4cdffmr12769569qvw.23.1713294135941; 
 Tue, 16 Apr 2024 12:02:15 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:15 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 22/23] mbedtls: disable the unused features
Date: Tue, 16 Apr 2024 12:00:18 -0700
Message-Id: <20240416190019.81016-23-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Disable the unused features of MbedTLS to reduce the target size.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/mbedtls/mbedtls_def_config.h | 186 +++++++++++++++----------------
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index 6e6d66716a..2a31ad7603 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -49,7 +49,7 @@
  *
  * Comment to disable the use of assembly code.
  */
-#define MBEDTLS_HAVE_ASM
+//#define MBEDTLS_HAVE_ASM
 
 /**
  * \def MBEDTLS_NO_UDBL_DIVISION
@@ -650,35 +650,35 @@
  *
  * Enable Cipher Block Chaining mode (CBC) for symmetric ciphers.
  */
-#define MBEDTLS_CIPHER_MODE_CBC
+//#define MBEDTLS_CIPHER_MODE_CBC
 
 /**
  * \def MBEDTLS_CIPHER_MODE_CFB
  *
  * Enable Cipher Feedback mode (CFB) for symmetric ciphers.
  */
-#define MBEDTLS_CIPHER_MODE_CFB
+//#define MBEDTLS_CIPHER_MODE_CFB
 
 /**
  * \def MBEDTLS_CIPHER_MODE_CTR
  *
  * Enable Counter Block Cipher mode (CTR) for symmetric ciphers.
  */
-#define MBEDTLS_CIPHER_MODE_CTR
+//#define MBEDTLS_CIPHER_MODE_CTR
 
 /**
  * \def MBEDTLS_CIPHER_MODE_OFB
  *
  * Enable Output Feedback mode (OFB) for symmetric ciphers.
  */
-#define MBEDTLS_CIPHER_MODE_OFB
+//#define MBEDTLS_CIPHER_MODE_OFB
 
 /**
  * \def MBEDTLS_CIPHER_MODE_XTS
  *
  * Enable Xor-encrypt-xor with ciphertext stealing mode (XTS) for AES.
  */
-#define MBEDTLS_CIPHER_MODE_XTS
+//#define MBEDTLS_CIPHER_MODE_XTS
 
 /**
  * \def MBEDTLS_CIPHER_NULL_CIPHER
@@ -757,20 +757,20 @@
  * Comment macros to disable the curve and functions for it
  */
 /* Short Weierstrass curves (supporting ECP, ECDH, ECDSA) */
-#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
-#define MBEDTLS_ECP_DP_BP256R1_ENABLED
-#define MBEDTLS_ECP_DP_BP384R1_ENABLED
-#define MBEDTLS_ECP_DP_BP512R1_ENABLED
+// #define MBEDTLS_ECP_DP_SECP192R1_ENABLED
+// #define MBEDTLS_ECP_DP_SECP224R1_ENABLED
+// #define MBEDTLS_ECP_DP_SECP256R1_ENABLED
+// #define MBEDTLS_ECP_DP_SECP384R1_ENABLED
+// #define MBEDTLS_ECP_DP_SECP521R1_ENABLED
+// #define MBEDTLS_ECP_DP_SECP192K1_ENABLED
+// #define MBEDTLS_ECP_DP_SECP224K1_ENABLED
+// #define MBEDTLS_ECP_DP_SECP256K1_ENABLED
+// #define MBEDTLS_ECP_DP_BP256R1_ENABLED
+// #define MBEDTLS_ECP_DP_BP384R1_ENABLED
+// #define MBEDTLS_ECP_DP_BP512R1_ENABLED
 /* Montgomery curves (supporting ECP) */
-#define MBEDTLS_ECP_DP_CURVE25519_ENABLED
-#define MBEDTLS_ECP_DP_CURVE448_ENABLED
+// #define MBEDTLS_ECP_DP_CURVE25519_ENABLED
+// #define MBEDTLS_ECP_DP_CURVE448_ENABLED
 
 /**
  * \def MBEDTLS_ECP_NIST_OPTIM
@@ -781,7 +781,7 @@
  *
  * Comment this macro to disable NIST curves optimisation.
  */
-#define MBEDTLS_ECP_NIST_OPTIM
+// #define MBEDTLS_ECP_NIST_OPTIM
 
 /**
  * \def MBEDTLS_ECP_RESTARTABLE
@@ -858,7 +858,7 @@
  *
  * Comment this macro to disable deterministic ECDSA.
  */
-#define MBEDTLS_ECDSA_DETERMINISTIC
+// #define MBEDTLS_ECDSA_DETERMINISTIC
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
@@ -878,7 +878,7 @@
  *      MBEDTLS_TLS_PSK_WITH_CAMELLIA_128_GCM_SHA256
  *      MBEDTLS_TLS_PSK_WITH_CAMELLIA_128_CBC_SHA256
  */
-#define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_DHE_PSK_ENABLED
@@ -907,7 +907,7 @@
  *             See dhm.h for more details.
  *
  */
-#define MBEDTLS_KEY_EXCHANGE_DHE_PSK_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_DHE_PSK_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_ECDHE_PSK_ENABLED
@@ -925,7 +925,7 @@
  *      MBEDTLS_TLS_ECDHE_PSK_WITH_AES_128_CBC_SHA
  *      MBEDTLS_TLS_ECDHE_PSK_WITH_CAMELLIA_128_CBC_SHA256
  */
-#define MBEDTLS_KEY_EXCHANGE_ECDHE_PSK_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_ECDHE_PSK_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_RSA_PSK_ENABLED
@@ -948,7 +948,7 @@
  *      MBEDTLS_TLS_RSA_PSK_WITH_CAMELLIA_128_GCM_SHA256
  *      MBEDTLS_TLS_RSA_PSK_WITH_CAMELLIA_128_CBC_SHA256
  */
-#define MBEDTLS_KEY_EXCHANGE_RSA_PSK_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_RSA_PSK_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_RSA_ENABLED
@@ -1005,7 +1005,7 @@
  *             See dhm.h for more details.
  *
  */
-#define MBEDTLS_KEY_EXCHANGE_DHE_RSA_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_DHE_RSA_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
@@ -1030,7 +1030,7 @@
  *      MBEDTLS_TLS_ECDHE_RSA_WITH_CAMELLIA_128_GCM_SHA256
  *      MBEDTLS_TLS_ECDHE_RSA_WITH_CAMELLIA_128_CBC_SHA256
  */
-#define MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
@@ -1054,7 +1054,7 @@
  *      MBEDTLS_TLS_ECDHE_ECDSA_WITH_CAMELLIA_128_GCM_SHA256
  *      MBEDTLS_TLS_ECDHE_ECDSA_WITH_CAMELLIA_128_CBC_SHA256
  */
-#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
@@ -1078,7 +1078,7 @@
  *      MBEDTLS_TLS_ECDH_ECDSA_WITH_CAMELLIA_128_GCM_SHA256
  *      MBEDTLS_TLS_ECDH_ECDSA_WITH_CAMELLIA_256_GCM_SHA384
  */
-#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
@@ -1102,7 +1102,7 @@
  *      MBEDTLS_TLS_ECDH_RSA_WITH_CAMELLIA_128_GCM_SHA256
  *      MBEDTLS_TLS_ECDH_RSA_WITH_CAMELLIA_256_GCM_SHA384
  */
-#define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
+// #define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
 
 /**
  * \def MBEDTLS_KEY_EXCHANGE_ECJPAKE_ENABLED
@@ -1139,7 +1139,7 @@
  *
  * Disable if you only need to support RFC 5915 + 5480 key formats.
  */
-#define MBEDTLS_PK_PARSE_EC_EXTENDED
+// #define MBEDTLS_PK_PARSE_EC_EXTENDED
 
 /**
  * \def MBEDTLS_PK_PARSE_EC_COMPRESSED
@@ -1152,7 +1152,7 @@
  *       the only unsupported curves are MBEDTLS_ECP_DP_SECP224R1 and
  *       MBEDTLS_ECP_DP_SECP224K1.
  */
-#define MBEDTLS_PK_PARSE_EC_COMPRESSED
+// #define MBEDTLS_PK_PARSE_EC_COMPRESSED
 
 /**
  * \def MBEDTLS_ERROR_STRERROR_DUMMY
@@ -1167,7 +1167,7 @@
  * Disable if you run into name conflicts and want to really remove the
  * mbedtls_strerror()
  */
-#define MBEDTLS_ERROR_STRERROR_DUMMY
+// #define MBEDTLS_ERROR_STRERROR_DUMMY
 
 /**
  * \def MBEDTLS_GENPRIME
@@ -1176,7 +1176,7 @@
  *
  * Requires: MBEDTLS_BIGNUM_C
  */
-#define MBEDTLS_GENPRIME
+// #define MBEDTLS_GENPRIME
 
 /**
  * \def MBEDTLS_FS_IO
@@ -1296,7 +1296,7 @@
  *
  * Comment this macro to disable support for external private RSA keys.
  */
-#define MBEDTLS_PK_RSA_ALT_SUPPORT
+// #define MBEDTLS_PK_RSA_ALT_SUPPORT
 
 /**
  * \def MBEDTLS_PKCS1_V15
@@ -1484,7 +1484,7 @@
  *
  * Enable the checkup functions (*_self_test).
  */
-#define MBEDTLS_SELF_TEST
+// #define MBEDTLS_SELF_TEST
 
 /**
  * \def MBEDTLS_SHA256_SMALLER
@@ -1524,7 +1524,7 @@
  *
  * Enable sending of all alert messages
  */
-#define MBEDTLS_SSL_ALL_ALERT_MESSAGES
+// #define MBEDTLS_SSL_ALL_ALERT_MESSAGES
 
 /**
  * \def MBEDTLS_SSL_DTLS_CONNECTION_ID
@@ -1548,7 +1548,7 @@
  *
  * Uncomment to enable the Connection ID extension.
  */
-#define MBEDTLS_SSL_DTLS_CONNECTION_ID
+// #define MBEDTLS_SSL_DTLS_CONNECTION_ID
 
 /**
  * \def MBEDTLS_SSL_DTLS_CONNECTION_ID_COMPAT
@@ -1570,7 +1570,7 @@
  *
  * Requires: MBEDTLS_SSL_DTLS_CONNECTION_ID
  */
-#define MBEDTLS_SSL_DTLS_CONNECTION_ID_COMPAT 0
+// #define MBEDTLS_SSL_DTLS_CONNECTION_ID_COMPAT 0
 
 /**
  * \def MBEDTLS_SSL_ASYNC_PRIVATE
@@ -1611,7 +1611,7 @@
  *
  * Comment to disable the context serialization APIs.
  */
-#define MBEDTLS_SSL_CONTEXT_SERIALIZATION
+// #define MBEDTLS_SSL_CONTEXT_SERIALIZATION
 
 /**
  * \def MBEDTLS_SSL_DEBUG_ALL
@@ -1643,7 +1643,7 @@
  *
  * Comment this macro to disable support for Encrypt-then-MAC
  */
-#define MBEDTLS_SSL_ENCRYPT_THEN_MAC
+// #define MBEDTLS_SSL_ENCRYPT_THEN_MAC
 
 /** \def MBEDTLS_SSL_EXTENDED_MASTER_SECRET
  *
@@ -1659,7 +1659,7 @@
  *
  * Comment this macro to disable support for Extended Master Secret.
  */
-#define MBEDTLS_SSL_EXTENDED_MASTER_SECRET
+// #define MBEDTLS_SSL_EXTENDED_MASTER_SECRET
 
 /**
  * \def MBEDTLS_SSL_KEEP_PEER_CERTIFICATE
@@ -1683,7 +1683,7 @@
  * Comment this macro to disable storing the peer's certificate
  * after the handshake.
  */
-#define MBEDTLS_SSL_KEEP_PEER_CERTIFICATE
+// #define MBEDTLS_SSL_KEEP_PEER_CERTIFICATE
 
 /**
  * \def MBEDTLS_SSL_RENEGOTIATION
@@ -1707,7 +1707,7 @@
  *          configuration of this extension).
  *
  */
-#define MBEDTLS_SSL_RENEGOTIATION
+// #define MBEDTLS_SSL_RENEGOTIATION
 
 /**
  * \def MBEDTLS_SSL_MAX_FRAGMENT_LENGTH
@@ -1716,7 +1716,7 @@
  *
  * Comment this macro to disable support for the max_fragment_length extension
  */
-#define MBEDTLS_SSL_MAX_FRAGMENT_LENGTH
+// #define MBEDTLS_SSL_MAX_FRAGMENT_LENGTH
 
 /**
  * \def MBEDTLS_SSL_RECORD_SIZE_LIMIT
@@ -1773,7 +1773,7 @@
  *
  * Uncomment this macro to enable the support for TLS 1.3.
  */
-//#define MBEDTLS_SSL_PROTO_TLS1_3
+// #define MBEDTLS_SSL_PROTO_TLS1_3
 
 /**
  * \def MBEDTLS_SSL_TLS1_3_COMPATIBILITY_MODE
@@ -1807,7 +1807,7 @@
  * effect on the build.
  *
  */
-#define MBEDTLS_SSL_TLS1_3_KEY_EXCHANGE_MODE_PSK_ENABLED
+// #define MBEDTLS_SSL_TLS1_3_KEY_EXCHANGE_MODE_PSK_ENABLED
 
 /**
  * \def MBEDTLS_SSL_TLS1_3_KEY_EXCHANGE_MODE_EPHEMERAL_ENABLED
@@ -1825,7 +1825,7 @@
  * effect on the build.
  *
  */
-#define MBEDTLS_SSL_TLS1_3_KEY_EXCHANGE_MODE_EPHEMERAL_ENABLED
+// #define MBEDTLS_SSL_TLS1_3_KEY_EXCHANGE_MODE_EPHEMERAL_ENABLED
 
 /**
  * \def MBEDTLS_SSL_TLS1_3_KEY_EXCHANGE_MODE_PSK_EPHEMERAL_ENABLED
@@ -1839,7 +1839,7 @@
  * have any effect on the build.
  *
  */
-#define MBEDTLS_SSL_TLS1_3_KEY_EXCHANGE_MODE_PSK_EPHEMERAL_ENABLED
+// #define MBEDTLS_SSL_TLS1_3_KEY_EXCHANGE_MODE_PSK_EPHEMERAL_ENABLED
 
 /**
  * \def MBEDTLS_SSL_EARLY_DATA
@@ -1873,7 +1873,7 @@
  *
  * Comment this macro to disable support for DTLS
  */
-#define MBEDTLS_SSL_PROTO_DTLS
+// #define MBEDTLS_SSL_PROTO_DTLS
 
 /**
  * \def MBEDTLS_SSL_ALPN
@@ -1882,7 +1882,7 @@
  *
  * Comment this macro to disable support for ALPN.
  */
-#define MBEDTLS_SSL_ALPN
+// #define MBEDTLS_SSL_ALPN
 
 /**
  * \def MBEDTLS_SSL_DTLS_ANTI_REPLAY
@@ -1897,7 +1897,7 @@
  *
  * Comment this to disable anti-replay in DTLS.
  */
-#define MBEDTLS_SSL_DTLS_ANTI_REPLAY
+// #define MBEDTLS_SSL_DTLS_ANTI_REPLAY
 
 /**
  * \def MBEDTLS_SSL_DTLS_HELLO_VERIFY
@@ -1915,7 +1915,7 @@
  *
  * Comment this to disable support for HelloVerifyRequest.
  */
-#define MBEDTLS_SSL_DTLS_HELLO_VERIFY
+// #define MBEDTLS_SSL_DTLS_HELLO_VERIFY
 
 /**
  * \def MBEDTLS_SSL_DTLS_SRTP
@@ -1962,7 +1962,7 @@
  *
  * Comment this to disable support for clients reusing the source port.
  */
-#define MBEDTLS_SSL_DTLS_CLIENT_PORT_REUSE
+// #define MBEDTLS_SSL_DTLS_CLIENT_PORT_REUSE
 
 /**
  * \def MBEDTLS_SSL_SESSION_TICKETS
@@ -1976,7 +1976,7 @@
  *
  * Comment this macro to disable support for SSL session tickets
  */
-#define MBEDTLS_SSL_SESSION_TICKETS
+// #define MBEDTLS_SSL_SESSION_TICKETS
 
 /**
  * \def MBEDTLS_SSL_SERVER_NAME_INDICATION
@@ -1987,7 +1987,7 @@
  *
  * Comment this macro to disable support for server name indication in SSL
  */
-#define MBEDTLS_SSL_SERVER_NAME_INDICATION
+// #define MBEDTLS_SSL_SERVER_NAME_INDICATION
 
 /**
  * \def MBEDTLS_SSL_VARIABLE_BUFFER_LENGTH
@@ -2150,7 +2150,7 @@
  *
  * Comment this to disable run-time checking and save ROM space
  */
-#define MBEDTLS_VERSION_FEATURES
+// #define MBEDTLS_VERSION_FEATURES
 
 /**
  * \def MBEDTLS_X509_TRUSTED_CERTIFICATE_CALLBACK
@@ -2232,7 +2232,7 @@
  *
  * This modules adds support for the AES-NI instructions on x86.
  */
-#define MBEDTLS_AESNI_C
+// #define MBEDTLS_AESNI_C
 
 /**
  * \def MBEDTLS_AESCE_C
@@ -2331,7 +2331,7 @@
  *
  * PEM_PARSE uses AES for decrypting encrypted keys.
  */
-#define MBEDTLS_AES_C
+// #define MBEDTLS_AES_C
 
 /**
  * \def MBEDTLS_ASN1_PARSE_C
@@ -2371,7 +2371,7 @@
  *
  * This module is required for PEM support (required by X.509).
  */
-#define MBEDTLS_BASE64_C
+// #define MBEDTLS_BASE64_C
 
 /**
  * \def MBEDTLS_BIGNUM_C
@@ -2446,7 +2446,7 @@
  *      MBEDTLS_TLS_PSK_WITH_CAMELLIA_128_GCM_SHA256
  *      MBEDTLS_TLS_PSK_WITH_CAMELLIA_128_CBC_SHA256
  */
-#define MBEDTLS_CAMELLIA_C
+// #define MBEDTLS_CAMELLIA_C
 
 /**
  * \def MBEDTLS_ARIA_C
@@ -2498,7 +2498,7 @@
  *      MBEDTLS_TLS_ECDHE_PSK_WITH_ARIA_128_CBC_SHA256
  *      MBEDTLS_TLS_ECDHE_PSK_WITH_ARIA_256_CBC_SHA384
  */
-#define MBEDTLS_ARIA_C
+// #define MBEDTLS_ARIA_C
 
 /**
  * \def MBEDTLS_CCM_C
@@ -2513,7 +2513,7 @@
  * This module enables the AES-CCM ciphersuites, if other requisites are
  * enabled as well.
  */
-#define MBEDTLS_CCM_C
+// #define MBEDTLS_CCM_C
 
 /**
  * \def MBEDTLS_CHACHA20_C
@@ -2522,7 +2522,7 @@
  *
  * Module:  library/chacha20.c
  */
-#define MBEDTLS_CHACHA20_C
+// #define MBEDTLS_CHACHA20_C
 
 /**
  * \def MBEDTLS_CHACHAPOLY_C
@@ -2533,7 +2533,7 @@
  *
  * This module requires: MBEDTLS_CHACHA20_C, MBEDTLS_POLY1305_C
  */
-#define MBEDTLS_CHACHAPOLY_C
+// #define MBEDTLS_CHACHAPOLY_C
 
 /**
  * \def MBEDTLS_CIPHER_C
@@ -2573,7 +2573,7 @@
  * Requires: MBEDTLS_CIPHER_C, MBEDTLS_AES_C or MBEDTLS_DES_C
  *
  */
-#define MBEDTLS_CMAC_C
+// #define MBEDTLS_CMAC_C
 
 /**
  * \def MBEDTLS_CTR_DRBG_C
@@ -2595,7 +2595,7 @@
  *
  * This module provides the CTR_DRBG AES random number generator.
  */
-#define MBEDTLS_CTR_DRBG_C
+// #define MBEDTLS_CTR_DRBG_C
 
 /**
  * \def MBEDTLS_DEBUG_C
@@ -2610,7 +2610,7 @@
  *
  * This module provides debugging functions.
  */
-#define MBEDTLS_DEBUG_C
+// #define MBEDTLS_DEBUG_C
 
 /**
  * \def MBEDTLS_DES_C
@@ -2626,7 +2626,7 @@
  * \warning   DES/3DES are considered weak ciphers and their use constitutes a
  *            security risk. We recommend considering stronger ciphers instead.
  */
-#define MBEDTLS_DES_C
+// #define MBEDTLS_DES_C
 
 /**
  * \def MBEDTLS_DHM_C
@@ -2648,7 +2648,7 @@
  *             See dhm.h for more details.
  *
  */
-#define MBEDTLS_DHM_C
+// #define MBEDTLS_DHM_C
 
 /**
  * \def MBEDTLS_ECDH_C
@@ -2666,7 +2666,7 @@
  *
  * Requires: MBEDTLS_ECP_C
  */
-#define MBEDTLS_ECDH_C
+// #define MBEDTLS_ECDH_C
 
 /**
  * \def MBEDTLS_ECDSA_C
@@ -2683,7 +2683,7 @@
  *           and at least one MBEDTLS_ECP_DP_XXX_ENABLED for a
  *           short Weierstrass curve.
  */
-#define MBEDTLS_ECDSA_C
+// #define MBEDTLS_ECDSA_C
 
 /**
  * \def MBEDTLS_ECJPAKE_C
@@ -2705,7 +2705,7 @@
  * \warning If using a hash that is only provided by PSA drivers, you must
  * call psa_crypto_init() before doing any EC J-PAKE operations.
  */
-#define MBEDTLS_ECJPAKE_C
+// #define MBEDTLS_ECJPAKE_C
 
 /**
  * \def MBEDTLS_ECP_C
@@ -2719,7 +2719,7 @@
  *
  * Requires: MBEDTLS_BIGNUM_C and at least one MBEDTLS_ECP_DP_XXX_ENABLED
  */
-#define MBEDTLS_ECP_C
+// #define MBEDTLS_ECP_C
 
 /**
  * \def MBEDTLS_ENTROPY_C
@@ -2760,7 +2760,7 @@
  * This module enables the AES-GCM and CAMELLIA-GCM ciphersuites, if other
  * requisites are enabled as well.
  */
-#define MBEDTLS_GCM_C
+// #define MBEDTLS_GCM_C
 
 /**
  * \def MBEDTLS_HKDF_C
@@ -2775,7 +2775,7 @@
  * This module adds support for the Hashed Message Authentication Code
  * (HMAC)-based key derivation function (HKDF).
  */
-#define MBEDTLS_HKDF_C
+// #define MBEDTLS_HKDF_C
 
 /**
  * \def MBEDTLS_HMAC_DRBG_C
@@ -2789,7 +2789,7 @@
  *
  * Uncomment to enable the HMAC_DRBG random number generator.
  */
-#define MBEDTLS_HMAC_DRBG_C
+// #define MBEDTLS_HMAC_DRBG_C
 
 /**
  * \def MBEDTLS_LMS_C
@@ -2828,7 +2828,7 @@
  *
  * Requires: MBEDTLS_AES_C and MBEDTLS_CIPHER_C
  */
-#define MBEDTLS_NIST_KW_C
+// #define MBEDTLS_NIST_KW_C
 
 /**
  * \def MBEDTLS_MD_C
@@ -2861,7 +2861,7 @@
  *
  * Uncomment to enable generic message digest wrappers.
  */
-//#define MBEDTLS_MD_C
+#define MBEDTLS_MD_C
 
 /**
  * \def MBEDTLS_MD5_C
@@ -2956,7 +2956,7 @@
  *
  * This modules adds support for the VIA PadLock on x86.
  */
-#define MBEDTLS_PADLOCK_C
+// #define MBEDTLS_PADLOCK_C
 
 /**
  * \def MBEDTLS_PEM_PARSE_C
@@ -2978,7 +2978,7 @@
  *
  * This modules adds support for decoding / parsing PEM files.
  */
-#define MBEDTLS_PEM_PARSE_C
+// #define MBEDTLS_PEM_PARSE_C
 
 /**
  * \def MBEDTLS_PEM_WRITE_C
@@ -2994,7 +2994,7 @@
  *
  * This modules adds support for encoding / writing PEM files.
  */
-#define MBEDTLS_PEM_WRITE_C
+// #define MBEDTLS_PEM_WRITE_C
 
 /**
  * \def MBEDTLS_PK_C
@@ -3058,7 +3058,7 @@
  *
  * This module adds support for the PKCS#5 functions.
  */
-#define MBEDTLS_PKCS5_C
+// #define MBEDTLS_PKCS5_C
 
 /**
  * \def MBEDTLS_PKCS7_C
@@ -3093,7 +3093,7 @@
  *
  * This module enables PKCS#12 functions.
  */
-#define MBEDTLS_PKCS12_C
+// #define MBEDTLS_PKCS12_C
 
 /**
  * \def MBEDTLS_PLATFORM_C
@@ -3113,7 +3113,7 @@
  *
  * This module enables abstraction of common (libc) functions.
  */
-#define MBEDTLS_PLATFORM_C
+// #define MBEDTLS_PLATFORM_C
 
 /**
  * \def MBEDTLS_POLY1305_C
@@ -3123,7 +3123,7 @@
  * Module:  library/poly1305.c
  * Caller:  library/chachapoly.c
  */
-#define MBEDTLS_POLY1305_C
+// #define MBEDTLS_POLY1305_C
 
 /**
  * \def MBEDTLS_PSA_CRYPTO_C
@@ -3190,7 +3190,7 @@
  * Caller:  library/md.c
  *
  */
-#define MBEDTLS_RIPEMD160_C
+// #define MBEDTLS_RIPEMD160_C
 
 /**
  * \def MBEDTLS_RSA_C
@@ -3433,7 +3433,7 @@
  *
  * Requires: MBEDTLS_SSL_CACHE_C
  */
-#define MBEDTLS_SSL_CACHE_C
+// #define MBEDTLS_SSL_CACHE_C
 
 /**
  * \def MBEDTLS_SSL_COOKIE_C
@@ -3443,7 +3443,7 @@
  * Module:  library/ssl_cookie.c
  * Caller:
  */
-#define MBEDTLS_SSL_COOKIE_C
+// #define MBEDTLS_SSL_COOKIE_C
 
 /**
  * \def MBEDTLS_SSL_TICKET_C
@@ -3456,7 +3456,7 @@
  * Requires: (MBEDTLS_CIPHER_C || MBEDTLS_USE_PSA_CRYPTO) &&
  *           (MBEDTLS_GCM_C || MBEDTLS_CCM_C || MBEDTLS_CHACHAPOLY_C)
  */
-#define MBEDTLS_SSL_TICKET_C
+// #define MBEDTLS_SSL_TICKET_C
 
 /**
  * \def MBEDTLS_SSL_CLI_C
@@ -3470,7 +3470,7 @@
  *
  * This module is required for SSL/TLS client support.
  */
-#define MBEDTLS_SSL_CLI_C
+// #define MBEDTLS_SSL_CLI_C
 
 /**
  * \def MBEDTLS_SSL_SRV_C
@@ -3484,7 +3484,7 @@
  *
  * This module is required for SSL/TLS server support.
  */
-#define MBEDTLS_SSL_SRV_C
+// #define MBEDTLS_SSL_SRV_C
 
 /**
  * \def MBEDTLS_SSL_TLS_C
@@ -3557,7 +3557,7 @@
  *
  * This module provides run-time version information.
  */
-#define MBEDTLS_VERSION_C
+// #define MBEDTLS_VERSION_C
 
 /**
  * \def MBEDTLS_X509_USE_C
-- 
2.25.1

