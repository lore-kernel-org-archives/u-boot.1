Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442A2E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03FD5803F6;
	Thu, 19 Dec 2024 19:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E7/jqzRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061F0803D2; Thu, 19 Dec 2024 19:29:51 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B39E880312
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a77bd62fdeso7161035ab.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632987; x=1735237787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iR2Dk2i7DdWznt0rkE5Y+cl/XrfUQz2nJM796xsGhLA=;
 b=E7/jqzRcJnDozY1z/oNfe87IpG3A6jsS6alXbOddrwVP5nNCKp6+bZ4aCuRmDx4TiH
 c77p9Fgwyg9/zJC5ttWI50tQkOnmS+06zX4I3vFe9pRAgJ4uqFpdlDV6rvy5moPn29r/
 ApHiUQ/amPBRmTrn1O4TUzlkcq92zNA2bUUbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632987; x=1735237787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iR2Dk2i7DdWznt0rkE5Y+cl/XrfUQz2nJM796xsGhLA=;
 b=Y+Cma8aelWwaTB8yetAMT23ARqVCPKFm3TRw2s+d1cKalpCwvSjXHJXhOJypMARIBu
 EspZkNyy/fz5PxKMAi0Eim8nGp3+m6wF7ptI3iiAXPM+pJgUbYDCZI3Kt5WzXzfQOlfr
 +I8BUf7iSg4s8fLXYW5MMp7XwUPpRUxQLgpcl8Q1nagFwPVIhmEB07qUmXiqCFrzgf+f
 R3n63wgcG3XbMGpLJyG3m1FbLT40U/9PmEXVI8FMu08tqDKtJe60H/mfjMxMNfhPyQkd
 vig+NR+/DDb5qNamK5xyDYNrauBjyfYw+2IbI6+2U9WYCkjf33PbIdSIaA0wnG8PLstW
 pqeg==
X-Gm-Message-State: AOJu0YzpxTco2F4I2R46JotZwo1OcSns+yi09RqlTBF4FhBzImwBuqaL
 GQUULaE6WSgmZjsMVKnsfUtbyBYkBph3ZSnNomIhh5/YyvmXYaGH5SoVVmX6/zaAU6qxo1EtScY
 =
X-Gm-Gg: ASbGnctG1ZnjpIQUW/mvCWivqoDmelZd/E6ggcIz+hYTRUgalbwI2cydW49qZYwk0ql
 OdqW7ctJybHu6WeRrdgTwQi6kzOsReTufVTPCv6ul18sqrT9n1sWf4l6IAL3NX+QpS90GnoY4Wl
 69t6jYfvdrAKUh1Lc97Xugc+HEUMNReypirVv10pywLl5T3ZvEwcHEsArF5hXlqYP7/Hx3dLzOd
 2/7qRfeqdB6Ss/LquoLtp6Y02W85X1L6Cnn/mS1porGv7l+WP24mumXuX+DfLx07JifdLFu09B1
 meONdKTFjCO86QUl0Q==
X-Google-Smtp-Source: AGHT+IEgGniHO1m+E4w+9SWLtaAYtmb2htjvMMp9gcksTkuWF8ZoscsZj9+AukREMl6oJxQT+3P9UQ==
X-Received: by 2002:a92:cdaa:0:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3c2d2780fbbmr1359485ab.6.1734632986987; 
 Thu, 19 Dec 2024 10:29:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 15/19] spl: lib: Allow for decompression in any SPL build
Date: Thu, 19 Dec 2024 11:29:03 -0700
Message-Id: <20241219182907.2609704-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

Add Kconfig symbols and update the Makefile rules so that decompression
can be used in TPL and VPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/Kconfig  | 35 +++++++++++++++++++++++++++++++++++
 lib/Makefile | 12 ++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 0b089814d14..203f40e2662 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -841,12 +841,36 @@ config SPL_LZ4
 	  fast compression and decompression speed. It belongs to the LZ77
 	  family of byte-oriented compression schemes.
 
+config TPL_LZ4
+	bool "Enable LZ4 decompression support in TPL"
+	depends on TPL
+	help
+	  This enables support for the LZ4 decompression algorithm in TPL. LZ4
+	  is a lossless data compression algorithm that is focused on
+	  fast compression and decompression speed. It belongs to the LZ77
+	  family of byte-oriented compression schemes.
+
+config VPL_LZ4
+	bool "Enable LZ4 decompression support in VPL"
+	depends on VPL
+	help
+	  This enables support for the LZ4 decompression algorithm in VPL. LZ4
+	  is a lossless data compression algorithm that is focused on
+	  fast compression and decompression speed. It belongs to the LZ77
+	  family of byte-oriented compression schemes.
+
 config SPL_LZMA
 	bool "Enable LZMA decompression support for SPL build"
 	depends on SPL
 	help
 	  This enables support for LZMA compression algorithm for SPL boot.
 
+config TPL_LZMA
+	bool "Enable LZMA decompression support for TPL build"
+	depends on TPL
+	help
+	  This enables support for LZMA compression algorithm for TPL boot.
+
 config VPL_LZMA
 	bool "Enable LZMA decompression support for VPL build"
 	default y if LZMA
@@ -865,11 +889,22 @@ config SPL_GZIP
 	help
 	  This enables support for the GZIP compression algorithm for SPL boot.
 
+config TPL_GZIP
+	bool "Enable gzip decompression support for SPL build"
+	select TPL_ZLIB
+	help
+	  This enables support for the GZIP compression algorithm for TPL
+
 config SPL_ZLIB
 	bool
 	help
 	  This enables compression lib for SPL boot.
 
+config TPL_ZLIB
+	bool
+	help
+	  This enables compression lib for TPL
+
 config SPL_ZSTD
 	bool "Enable Zstandard decompression support in SPL"
 	depends on SPL
diff --git a/lib/Makefile b/lib/Makefile
index d24ed629732..5cb3278d2ef 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -83,12 +83,12 @@ obj-$(CONFIG_$(XPL_)SHA512_LEGACY) += sha512.o
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(XPL_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
-obj-$(CONFIG_$(XPL_)ZLIB) += zlib/
-obj-$(CONFIG_$(XPL_)ZSTD) += zstd/
-obj-$(CONFIG_$(XPL_)GZIP) += gunzip.o
-obj-$(CONFIG_$(XPL_)LZO) += lzo/
-obj-$(CONFIG_$(XPL_)LZMA) += lzma/
-obj-$(CONFIG_$(XPL_)LZ4) += lz4_wrapper.o
+obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
+obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
+obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o
+obj-$(CONFIG_$(PHASE_)LZO) += lzo/
+obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
+obj-$(CONFIG_$(PHASE_)LZ4) += lz4_wrapper.o
 
 obj-$(CONFIG_$(XPL_)LIB_RATIONAL) += rational.o
 
-- 
2.34.1

