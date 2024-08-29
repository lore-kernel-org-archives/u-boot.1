Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE6C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9850488CB6;
	Thu, 29 Aug 2024 16:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AkT3pYCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF3E88CA8; Thu, 29 Aug 2024 16:58:32 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FF988C3E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39f370a944bso2610895ab.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943509; x=1725548309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fN1LFjtOGpMay28yScUBX9npNVOkoNtSLy1JSwW+LYo=;
 b=AkT3pYCri7/Ce5R54uA3CkADsqN1zwbuClKI93weayHPneVCqbcHMmSVXRZAngtabQ
 pRNNPxsA10AlAJnRMTZlhWHe6YO84lM6O5SZQWE9QmQrOm5wRIEnW5OPkUmbzjSQsk4B
 JSSGkPIFUPSrJfGRO6NxY5KOwGYxle/PtDFkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943509; x=1725548309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fN1LFjtOGpMay28yScUBX9npNVOkoNtSLy1JSwW+LYo=;
 b=Z1BQ4khJFjcPb6jQrqqUUtjfkzn8sEZ9SQ3nUH5RvfQqfBF6HOnb3kM4Y8sZeeGdRH
 DumP1MslJXkQyVPoWlTX1U2NaNO+C10NZXSqrFHqhju1gor3rbGDj8p6UKZAFOMWOF4h
 cWh1IdVZQ6JLpZag+5kf1u28akwRO7xuozX/nR6TLdMjPuRe89rt867CwB436sy8y7bV
 NfxUoV2hh+d/28jOmnjVkCVHmmYY8/u60TtTeBI2J1dCAXQlFQTIZTH7OQAsfX5WzVpk
 PRMQymoN4OHVeVwY99e0kn4eMGClZ4BJVib6ZiWzpfuhTrrI8fHeK5VfnY8Bgu2v/7qV
 /AVw==
X-Gm-Message-State: AOJu0YwmTx4saLAdotLxTr1XTBReKWBihYThZlvv1b59iVxexknKuXGE
 Sj6M2WaoO/26Zv9DstjGHWbopjeQyOMC+u4n6KXl6RPUNE+KFZMLdYFmb1eVVTf/CIcVl1qgTxQ
 =
X-Google-Smtp-Source: AGHT+IGXb/VpkR5bzWXODGmgmkSR7e1kbK/GYDnPtY6FzMrhH0gMP//NJuFZXBEhg4rHx3LMfl5BLA==
X-Received: by 2002:a05:6e02:1b09:b0:382:b3f8:9f72 with SMTP id
 e9e14a558f8ab-39f37820a2emr42453005ab.15.1724943508944; 
 Thu, 29 Aug 2024 07:58:28 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/19] spl: lib: Allow for decompression in any SPL build
Date: Thu, 29 Aug 2024 08:57:58 -0600
Message-Id: <20240829145802.1827952-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

 lib/Kconfig  | 35 +++++++++++++++++++++++++++++++++++
 lib/Makefile |  8 ++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 2059219a120..72a5f3cb04f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -811,12 +811,36 @@ config SPL_LZ4
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
@@ -835,11 +859,22 @@ config SPL_GZIP
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
index 81b503ab526..d122f764f9f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -82,12 +82,12 @@ obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
 
-obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
+obj-$(CONFIG_$(SPL_TPL_)ZLIB) += zlib/
 obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
-obj-$(CONFIG_$(SPL_)GZIP) += gunzip.o
+obj-$(CONFIG_$(SPL_TPL_)GZIP) += gunzip.o
 obj-$(CONFIG_$(SPL_)LZO) += lzo/
-obj-$(CONFIG_$(SPL_)LZMA) += lzma/
-obj-$(CONFIG_$(SPL_)LZ4) += lz4_wrapper.o
+obj-$(CONFIG_$(SPL_TPL_)LZMA) += lzma/
+obj-$(CONFIG_$(SPL_TPL_)LZ4) += lz4_wrapper.o
 
 obj-$(CONFIG_$(SPL_)LIB_RATIONAL) += rational.o
 
-- 
2.34.1

