Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D90E7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38B01895A4;
	Sat,  7 Dec 2024 18:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hS/Fu4Lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C30A89578; Sat,  7 Dec 2024 18:26:44 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B47891CF
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-841a6af60e9so85683639f.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592399; x=1734197199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcTQ9iLyQK9+908ud8ys7S8cbFtHSipk+qWONY5Ajmw=;
 b=hS/Fu4Lbd43eURYdRLbWV2uQpRwiCx+/5+R8ptXdXpydPjO72SOVatwZS63jGBkscA
 UlBjHbxbsoTlVGxzRQiYD59mEMW/RCD/AJ+SZO7QTlEJLSjWR0gAZLQ+nhjUS8HSlWZi
 LZ09PcNvX+n7bVaXPetA5XnlnvSrRWew9W+GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592399; x=1734197199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcTQ9iLyQK9+908ud8ys7S8cbFtHSipk+qWONY5Ajmw=;
 b=s/GnSkzRKlPJh9ptNwdoBp1EOzTMIFglA8HKc0PxRhmRRovOaVfgnq2G0PN8AcBjxZ
 lcfzAZYwRE+JFxGG5eNzzXlDZy3j2g2t9X5K7NRzNj7WEt0MPMOq1x+NTrUCSXwpHVGh
 eCqK4ZLm6PqS46wICSufWsEfRjpTl3BqbEP4CM7//OlhH/DF1cU4zyzEgk6+ZyfZqMou
 SEBAL7VTduvGN9+a/7e1U6OL6eBJ6rD/x6noyK2zr9vPhGfBARcbRJf+VIpQ05Ra8kFT
 m7p7xPdDIW9O2rsU22QSxnb6aFPB/m9KYk69WfPADEjsoOmvXIms/e+G5AMifj48vvq/
 1ncA==
X-Gm-Message-State: AOJu0YwLpwe5SVtcQikZmyUMJIWKdseRjJJue9JynVQQ1P+x/Ohl9Wrt
 FNzbkecolPPYb+V1T6dCUaUZhOQuChsB0MCDBJg1UR+8jq6ew2L4y75RWI3pzSKW0+vmYtBoIv0
 =
X-Gm-Gg: ASbGncsMx9lcVer4HH9sbgyXHyU70VTPpwhjZgUB42AR8aarLhE7s9SJDszfZwRekYF
 pnbKoLiUtAMWJYBYRBbESTIh9bMtY9lxZIAJVhw6MXBLyfZLCXo7G06gJd9ythYMk1ChYn1oiAc
 tNzn16i6jV8KJX5WuMvP9OuM0qObuEZhHvKdrsyA7YpvxMeIV6SVA633jz3VCpqrn+5JT+SrWfc
 ci2WrNnqDfzI1o7qwcizIzhJlgvl2VemirVUTVgSCy7OnM4DQZPTsb+Csyz9LV3dvNYe1g7fx+v
 d/t9hI/kr44=
X-Google-Smtp-Source: AGHT+IHFiSC2GFJP164DFLFvXTZMHuBoP41OCT3WByx0sGoAX8rPXJ0U91Ymzo/O764P29dpNbbEYw==
X-Received: by 2002:a05:6602:2d81:b0:83a:b52b:5cb5 with SMTP id
 ca18e2360f4ac-8447e223b79mr843387039f.5.1733592399357; 
 Sat, 07 Dec 2024 09:26:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 15/19] spl: lib: Allow for decompression in any SPL build
Date: Sat,  7 Dec 2024 10:24:08 -0700
Message-Id: <20241207172412.1124558-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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
index 56ffdfa1839..3fa580ab1eb 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -832,12 +832,36 @@ config SPL_LZ4
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
@@ -856,11 +880,22 @@ config SPL_GZIP
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
index dbcfa87ebd6..31cfbb67aa0 100644
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

