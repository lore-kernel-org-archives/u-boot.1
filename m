Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA98C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 15:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 634F7812C8;
	Mon, 27 Jan 2025 16:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jueBFxCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE22B81417; Mon, 27 Jan 2025 16:17:10 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE2581292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 16:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so677913685a.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737991027; x=1738595827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2/WOmvzbHYjYeCNpb9Z8xJEE1nR1ZMZ5Z99f2akL9Uc=;
 b=jueBFxCqyZxCZbdEvrI2iZjm9T5fF20RB8SgixYGjmcp3Azp0pGrt0+tg3OP+Aorn+
 JFs0MM4GDwvSBqpqcr9QiTFUG4FNS0DwB+opj/wa/Z5KvbW3kNQxDXZbk4YNGvfjpR96
 qRACV6XapZklT2JBqyjHZG2mTsT7y4xeTOgJsWWXGDpBSn8Dfm5wp2q1JzEdJH1IMEgp
 mtFglNPacNNua4o06iJE+WtxyDYRVDi1FfN/GEBDwARNNMArjfyz+XpGHBtdRUIV5ux9
 bdvRx4u7oPchD7odWbCMUV8RDQwuZAI3mBJxjYwYmKCk9APxahf9XqkLTBVvDN1E4UFl
 E46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991027; x=1738595827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/WOmvzbHYjYeCNpb9Z8xJEE1nR1ZMZ5Z99f2akL9Uc=;
 b=YGBKP169FGRA5bLWc8eZ+xkU62UJp2OhPqHBXLzAjffQ03uZrhNt2VShAu8u66mk1e
 hCm4vSD/dHURcVY/L8UkDt85XZ6u6lSdZwli10YdDlvkxKXFXEC5TnIGp/nUjIR/vcS4
 kdgyEkyFkyFaXYF9znJ3RUOJgJCWxLINLVxMcmq9Rp6Px8zTqZupuNUEua49XJQVMWAT
 g6GpV/yehc9VQI1DK1gVNQP/9vYNT3eZCEZHSg2mPe2UUxzyho7RcmTk0M8Rx4fwb/Z5
 cEcOIEU1fWaqafrZf3QVE5AffRagIRGL3TIJQQYNEDjbSlFF3urzoSz6EuHuqptSSTCo
 QjWw==
X-Gm-Message-State: AOJu0YxvC91ZqzFbhi7wzJQuDK3AZxxxhEQ03LSH2FCB5b69921iQhJ8
 DQOIJPVO74WpCi7r2B5hA6C94fEgHZi4PGNAyaOzP1z/if/nyj3i3MToK6aBt10ZYb+lKfr7l/7
 xW3o=
X-Gm-Gg: ASbGncsZktKjNf5bx/dY0cSVWAwr75072VhxtgYZWFyRr5lw2Bw43Khy6cCjVDeMSGM
 Ctet6R3wuGw86QEWVRHYaV0thzlvNDvKs0nWtmCRm6VFJj2Zy4you8q2VuKQ0aADnzA8YI71tHD
 IlghM3DHULQ2xOceaW+xmN/4hvN7pFS4onsaGydmkTIlwrJaPVzuLlvRBIQslQlGhagi7IQ12tp
 JjuKdRSIMk+lVE7eDpuZ7VtuwHtqZZAY+1w24o/TFjrahQGZCDYnVx4q0ZsI3ickeugtjjWaXVf
 eWVVw6HdFp10SdUjhQ1UyQByR1RQLC20ymyrMiYj49wuoZGNCfL5CHJQ2QBXAvovGf5uBAo661o
 mFsk=
X-Google-Smtp-Source: AGHT+IHZUJn7/nuKlWkoDeUPqTs8tbxkKHjA63pEsnUwkxKCbuJNoYwlK986k3TubhMWh34YidSARA==
X-Received: by 2002:a05:620a:25cf:b0:7be:3965:7452 with SMTP id
 af79cd13be357-7be6320d293mr6257631585a.32.1737991027136; 
 Mon, 27 Jan 2025 07:17:07 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af11709sm396693385a.112.2025.01.27.07.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 07:17:06 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 1/3] mbedtls: fix incorrect kconfig dependencies on mbedtls
Date: Mon, 27 Jan 2025 07:16:48 -0800
Message-Id: <20250127151657.648255-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Currently building with WGET_HTTPS,NET_LWIP and MBEDTLS_LIB failed
due to a few incorrect kconfig dependencies.
Fix these and clarify what is the purpose of MBEDTLS_LIB_CRYPTO_ALT.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 cmd/Kconfig         | 1 -
 lib/mbedtls/Kconfig | 8 +++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1a0985ca479..071601b5ac2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2161,7 +2161,6 @@ config WGET_HTTPS
         select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
         select X509_CERTIFICATE_PARSER
         select PKCS7_MESSAGE_PARSER
-	select MBEDTLS_LIB_CRYPTO
 	select MBEDTLS_LIB_TLS
 	select RSA_VERIFY_WITH_PKEY
 	select X509_CERTIFICATE_PARSER
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index aa82336ef14..17ed2bc71de 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -116,6 +116,7 @@ endif # LEGACY_CRYPTO_BASIC
 
 config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
+	depends on LEGACY_CRYPTO
 	select ASN1_DECODER_LEGACY if ASN1_DECODER
 	select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
@@ -210,12 +211,13 @@ endif # LEGACY_CRYPTO
 if MBEDTLS_LIB
 
 config MBEDTLS_LIB_CRYPTO_ALT
-	bool "MbedTLS crypto alternatives"
+	bool "Use legacy crypto libraries as MbedTLS alternatives"
 	depends on MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
 	select LEGACY_CRYPTO_BASIC
 	default y if MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
 	help
-	  Enable MbedTLS crypto alternatives.
+	  Enable MbedTLS crypto alternatives and replace it with legacy crypto
+	  libraries.
 	  Mutually incompatible with MBEDTLS_LIB_CRYPTO.
 
 config MBEDTLS_LIB_CRYPTO
@@ -451,7 +453,7 @@ config MBEDTLS_LIB_TLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	depends on ASN1_DECODER_MBEDTLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
-	depends on MBEDTLS_LIB_CRYPTO
+	depends on MBEDTLS_LIB
 	help
 	  Enable MbedTLS TLS library. Required for HTTPs support
 	  in wget
-- 
2.25.1

