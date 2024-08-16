Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7412AC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 22:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB8988C50;
	Sat, 17 Aug 2024 00:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kAVda/1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6B988C33; Fri, 16 Aug 2024 23:48:01 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C0C8752A
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf8b41b34dso151296d6.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844877; x=1724449677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fqjz9/lL4p3//d4SwUyGbtWHCPHMfd0kEx0dPLT1YD8=;
 b=kAVda/1ecPOxTy4LEWs4y1seD3qRxTImEUC0MRQ1zztfJHVcyqwC4pvMcjpPF0Uyhf
 rsiLqYpWQ4UrZxxvwiuJ+5qOahyW3bmHaRP4RCtLI2Mdhlho5/wrWe43nQWaGaEBTqbk
 wikOqhXOJK87meJRsIVsNSS5t+NcODEKJcjTBsC+dsq6yE0vrfXEhjTV6gusfvYVPp27
 Qh5XzJ7TGS2uMOnVNJJPr2gvvEDLnHMI46jxSUtKATrX2pfWvZXmFZYTjQV0262vuI5M
 hXE1yJlOsxc5G61frF0cvnD/sSHkLG/zPNfV4wd88NDZka2j8kAIaoqwZ5O7po1VpKD7
 pwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844877; x=1724449677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fqjz9/lL4p3//d4SwUyGbtWHCPHMfd0kEx0dPLT1YD8=;
 b=EvrhgkzpM8424padSFuCO1678396o37ZLLz8ZCMut9vETp3XnSK0mSGDXll5KvH+m/
 4SnOdav0PKWmOzZzQHQJxb/TFOPSNZTzWduPADdgCTevvND7EskM3yOZWYuoKIpmlZuz
 q5VLujm6g5KeSNFiOVeSDkSs8mi78KVCsR/Yy4UdFL2JpJYsLspj6BmgoNzyyYdHsYsS
 SW/qCcyZYLqKY/dkPdeVCZqFxCF2DOvkCKEi+Vl52HNGJ3mhxxvFUjSQ7Qy3dODwhkZZ
 nQ+oJVo1B3w7JTCRfgSYwVdKdgLW5ijUyAHLU/9O6xtQlEus+Pu3Qs3d9cXRhSDCKbvk
 fcCg==
X-Gm-Message-State: AOJu0YySGzgZeA8nsWjKEDFBunWbfz7IL5GRIAJ4A792zIjxIF9i05hP
 ttWQkg5e/wNB29IxWMsxaHxU/JerjotDpRU761UwaViJLK3OtU1oWJyV/sit6xQbwHpBxy2Rkr5
 myYA=
X-Google-Smtp-Source: AGHT+IH79gAm/rGybSksce6h95yRpax3EpWgvrTmh+pWU6uS6pMp/45BsvR6nHfHjodX8DQ1vCp/xQ==
X-Received: by 2002:a05:6214:418d:b0:6bf:7fd7:36ce with SMTP id
 6a1803df08f44-6bf894defe3mr8447526d6.21.1723844877490; 
 Fri, 16 Aug 2024 14:47:57 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:47:57 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 08/28] mbedtls: Enable smaller implementation for SHA256/512
Date: Fri, 16 Aug 2024 14:43:57 -0700
Message-Id: <20240816214436.1877263-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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

Smaller implementation for SHA256 and SHA512 helps to reduce the
ROM footprint though it has a certain impact on performance.
As a trade-off, enable it as a default config when MbedTLS is
enabled can reduce the target size significantly with acceptable
performace loss.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v6
- Initial patch

 lib/mbedtls/Kconfig              | 24 ++++++++++++++++++++++++
 lib/mbedtls/mbedtls_def_config.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 12f8c965f5a..0e22edf1b6c 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -151,18 +151,42 @@ config SHA1_MBEDTLS
 config SHA256_MBEDTLS
 	bool "Enable SHA256 support with MbedTLS crypto library"
 	depends on MBEDTLS_LIB_CRYPTO && SHA256
+	select SHA256_SMALLER
 	help
 	  This option enables support of hashing using SHA256 algorithm
 	  with MbedTLS crypto library.
 
+if SHA256_MBEDTLS
+
+config SHA256_SMALLER
+	bool "Enable SHA256 smaller implementation with MbedTLS crypto library"
+	depends on SHA256_MBEDTLS
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  smaller implementation with MbedTLS crypto library.
+
+endif
+
 config SHA512_MBEDTLS
 	bool "Enable SHA512 support with MbedTLS crypto library"
 	depends on MBEDTLS_LIB_CRYPTO && SHA512
 	default y if TI_SECURE_DEVICE && FIT_SIGNATURE
+	select SHA512_SMALLER
 	help
 	  This option enables support of hashing using SHA512 algorithm
 	  with MbedTLS crypto library.
 
+if SHA512_MBEDTLS
+
+config SHA512_SMALLER
+	bool "Enable SHA512 smaller implementation with MbedTLS crypto library"
+	depends on SHA512_MBEDTLS
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  smaller implementation with MbedTLS crypto library.
+
+endif
+
 config SHA384_MBEDTLS
 	bool "Enable SHA384 support with MbedTLS crypto library"
 	depends on MBEDTLS_LIB_CRYPTO && SHA384
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index 38de6b0b9af..750db8705e8 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -25,6 +25,9 @@
 
 #if CONFIG_IS_ENABLED(SHA256)
 #define MBEDTLS_SHA256_C
+#if CONFIG_IS_ENABLED(SHA256_SMALLER)
+#define MBEDTLS_SHA256_SMALLER
+#endif
 #endif
 
 #if CONFIG_IS_ENABLED(SHA384)
@@ -33,6 +36,9 @@
 
 #if CONFIG_IS_ENABLED(SHA512)
 #define MBEDTLS_SHA512_C
+#if CONFIG_IS_ENABLED(SHA512_SMALLER)
+#define MBEDTLS_SHA512_SMALLER
+#endif
 #endif
 
 #endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
-- 
2.25.1

