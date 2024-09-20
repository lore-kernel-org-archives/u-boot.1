Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9838CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4E208945B;
	Fri, 20 Sep 2024 10:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ktJkmtQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D569F893BE; Fri, 20 Sep 2024 10:14:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FE789436
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso5514983a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820023; x=1727424823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StFAs09jWUD1OhI+yKwUVjNmOV2iEgSuChQeHwo+0X4=;
 b=ktJkmtQy0D3rAckhgpG4K3kjwtP6phARFz8x+5aggZD1H+KSatr4cR5j/fgjAvLM49
 6D9wu77SvWtFdT2V4CmMU5hkyeMBPUDoz0fg0fgExL4y4iJZKgtPFZTgjb+EOxNW5h0w
 B2iLyBlxWfAt9B5RfVzCVV8fZEbkQtjz7CYJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820023; x=1727424823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StFAs09jWUD1OhI+yKwUVjNmOV2iEgSuChQeHwo+0X4=;
 b=OUtu9HTjPu97gwAuZ5ZxbA8QH7pkXwFSpPXypb7dCdBYXtx1zhRPffJmDy+2f5aMoD
 vpKelnM6tSMmS7cvx+Jh/YBLwXxMpvTCI5NPlv6FHIR/Ukuy54quqQ5kT1LlVKDxd3z1
 0YOEl/sB9VEylOpQloaNkIyrC8KdtlpR90kAn/KMq5DCXG3TFLtcduQ/wxxwwt+ql0m5
 Nwi8AyIT6xn/SQhegkII+1IrfUvYu+sl/PkqfN/k3+7S1rmaWtDXnuj7kwSH3p0hinal
 sYDwYx7YT9nrVRY1xbN6n+VfuZWoVGedzaDReDMHYY5LMYNLp9iNe7e7v/LOIQm5d/99
 TMAg==
X-Gm-Message-State: AOJu0YwXCygb8upMm26/Qdx9Sc7+P84wUvd1DeLAg/pNMU/YVh2OmWTf
 CdpIoaPkI1mzwftA0LTPv5PAhxUY+rBsHJ+BASjRJ7VCMoy1BYRasmF52JebL75OuQj6Ghxhc8A
 wFJNp
X-Google-Smtp-Source: AGHT+IGI++B5O6XH736fW8G1VSKxy6Dyen6eMJNXDZFw+r5/qxPMgGwcVw5tz3yd6pwmvoVqO7Fbug==
X-Received: by 2002:a05:6402:430d:b0:5c4:2b18:2528 with SMTP id
 4fb4d7f45d1cf-5c4637c2e38mr2622921a12.5.1726820022958; 
 Fri, 20 Sep 2024 01:13:42 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/18] spl: lib: Allow for decompression in any SPL build
Date: Fri, 20 Sep 2024 10:12:53 +0200
Message-ID: <20240920081309.140426-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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
 lib/Makefile |  8 ++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 1dd4f271595..4f754c255e8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -812,12 +812,36 @@ config SPL_LZ4
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
@@ -836,11 +860,22 @@ config SPL_GZIP
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
index d300249f57c..9478257e634 100644
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
2.43.0

