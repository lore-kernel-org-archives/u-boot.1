Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A75C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E6F80FB8;
	Sun, 26 Jan 2025 19:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q6wqhNBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40BCF80F85; Sun, 26 Jan 2025 19:44:03 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0181F80F53
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844e161a957so285847739f.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917033; x=1738521833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PBh9z3vqQyp8S1MCDdRmO732NxGlfXEYkHXww3ypbU=;
 b=Q6wqhNBjIv3wxZYWM1+dlkru2Wlh4cnrokuYrvYY6+1vNeTdwlqXC+dlSyhcPsFaGu
 wHR0B6Z6Cmxo6gJsFMeNZZsnNTGSL4lCMA589HxI80y3IGnQg7dlyNXG4OiRUtulgBnG
 0wOgZY1p3a6u0KXzD2N8Y+TMZ193DXe8K4+m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917033; x=1738521833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PBh9z3vqQyp8S1MCDdRmO732NxGlfXEYkHXww3ypbU=;
 b=Zfv1Ng5S0Y1J6dg646ZlUsxd3ZfbTpe9RdoXy8UizIUVqTEBO8laLukZReKirDkmcd
 WZfBGxHZuoHMblMwnHNhim3RBL6mCZku7IsTKlA69or4yJ50D04/Cl5sqTlZvGEYD358
 +SPGwGhMp4Dyo9alsdfskkGeY0yjWq6omLpVVYk60uKjwawMnk9xvEveS17VKaxvxqJY
 jiMAPonzgV9mE281OjwnWhih1GLuLLPLI8uvVS3P/+rjGarHMHZui85wNyhdl1qxxqmC
 YMCmYGu3vAlc0lDBBRaUV1itfZ2RTxYNDmEkei7bvCirpC+DoJJ18iOQ6ZpXDBAe8The
 7jlw==
X-Gm-Message-State: AOJu0Yw1DENGB8sTsfRN5tWnDRNdy3+p/TNyilM1YUNakpdgD4/OK5nG
 t+Q2JpEpmuoSBhdqdYc1ID396RQCn1SVcjCeARkjL3Hat/7I2lHGQ3Ds4NOZB7k8cPMF1d5xrXM
 =
X-Gm-Gg: ASbGncs0IFmuuYP+FhjIWsfTuyIfHejgm/Zf7epAb4ck2B9i/FLF/bCtspcyha83c9Q
 29oBQbDQG6n/LsZyuBMeKo56D7QpBO9uTD9FBxYe7C953ejVkxcZc7gvYU9+zK9T6P6QnKfWFge
 6OjP4IWkGdisFeuutzaQpwGdoirP9KwLBySoMqTg5MW03NkgRliO8SYQ/MdT3UWa4ujyRKfibGv
 ePqSCROqXS1UWTVnaRS2jJklkdoj0+RFhEZAfxm14GrefY081KYboVdznoX42jEhVf2GHt3fg6n
 EC1fmAysXUM5NOkU22aq2EkoBSMRyl+olBukmQe4dQ==
X-Google-Smtp-Source: AGHT+IFnMsbVLwr8ztPsnFGyghtDfL9PKVDPjOXsb5WvDktGf4vQNzz7SBDjgt466FNmlmCJ43QOxw==
X-Received: by 2002:a05:6602:1682:b0:84a:810c:cf43 with SMTP id
 ca18e2360f4ac-851b6515dd3mr3667687139f.9.1737917033178; 
 Sun, 26 Jan 2025 10:43:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:43:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 04/19] lib: Allow crc16 code to be dropped
Date: Sun, 26 Jan 2025 11:43:14 -0700
Message-ID: <20250126184333.4058848-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

This code is not necessarily needed in VPL, even if SPL uses it, so
adjust the rules to allow it to be dropped.

Do the same for the hash API.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/hash.c | 17 +++++++++++------
 lib/Kconfig   | 10 ++++++++++
 lib/Makefile  |  3 +--
 tools/Kconfig |  5 +++++
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/common/hash.c b/common/hash.c
index 8dd9da85768..0c45992d5c7 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -143,7 +143,8 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
-static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
+static int __maybe_unused hash_init_crc16_ccitt(struct hash_algo *algo,
+						void **ctxp)
 {
 	uint16_t *ctx = malloc(sizeof(uint16_t));
 	*ctx = 0;
@@ -151,16 +152,18 @@ static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
 	return 0;
 }
 
-static int hash_update_crc16_ccitt(struct hash_algo *algo, void *ctx,
-				   const void *buf, unsigned int size,
-				   int is_last)
+static int __maybe_unused hash_update_crc16_ccitt(struct hash_algo *algo,
+						  void *ctx, const void *buf,
+						  unsigned int size,
+						  int is_last)
 {
 	*((uint16_t *)ctx) = crc16_ccitt(*((uint16_t *)ctx), buf, size);
 	return 0;
 }
 
-static int hash_finish_crc16_ccitt(struct hash_algo *algo, void *ctx,
-				   void *dest_buf, int size)
+static int __maybe_unused hash_finish_crc16_ccitt(struct hash_algo *algo,
+						  void *ctx, void *dest_buf,
+						  int size)
 {
 	if (size < algo->digest_size)
 		return -1;
@@ -295,6 +298,7 @@ static struct hash_algo hash_algo[] = {
 #endif
 	},
 #endif
+#if CONFIG_IS_ENABLED(CRC16)
 	{
 		.name		= "crc16-ccitt",
 		.digest_size	= 2,
@@ -304,6 +308,7 @@ static struct hash_algo hash_algo[] = {
 		.hash_update	= hash_update_crc16_ccitt,
 		.hash_finish	= hash_finish_crc16_ccitt,
 	},
+#endif
 #if CONFIG_IS_ENABLED(CRC8) && IS_ENABLED(CONFIG_HASH_CRC8)
 	{
 		.name		= "crc8",
diff --git a/lib/Kconfig b/lib/Kconfig
index c8ac99df78e..c228e4ca661 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -737,6 +737,16 @@ config VPL_CRC8
 	  checksum with feedback to produce an 8-bit result. The code is small
 	  and it does not require a lookup table (unlike CRC32).
 
+config CRC16
+	bool "Support CRC16"
+	default y
+	help
+	  Enables CRC16 support. This is normally required. Two algorithms are
+	  provided:
+
+	    - CCITT, with a polynomical x^16 + x^12 + x^5 + 1
+	    - standard, with polynomial x^16 + x^15 + x^2 + 1 (0x8005)
+
 config SPL_CRC16
 	bool "Support CRC16 in SPL"
 	depends on SPL
diff --git a/lib/Makefile b/lib/Makefile
index 31cfbb67aa0..3f0936b0a27 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -35,8 +35,6 @@ obj-$(CONFIG_CIRCBUF) += circbuf.o
 endif
 
 obj-y += crc8.o
-obj-y += crc16.o
-obj-y += crc16-ccitt.o
 obj-$(CONFIG_ERRNO_STR) += errno_str.o
 obj-$(CONFIG_FIT) += fdtdec_common.o
 obj-$(CONFIG_TEST_FDTDEC) += fdtdec_test.o
@@ -66,6 +64,7 @@ endif
 
 obj-$(CONFIG_$(PHASE_)CRC8) += crc8.o
 obj-$(CONFIG_$(PHASE_)CRC16) += crc16.o
+obj-$(CONFIG_$(PHASE_)CRC16) += crc16-ccitt.o
 
 obj-y += crypto/
 
diff --git a/tools/Kconfig b/tools/Kconfig
index 5c75af48fe3..01ff0fcf748 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -9,6 +9,11 @@ config MKIMAGE_DTC_PATH
 	  some cases the system dtc may not support all required features
 	  and the path to a different version should be given here.
 
+config TOOLS_CRC16
+	def_bool y
+	help
+	  Enable CRC32 support in the tools builds
+
 config TOOLS_CRC32
 	def_bool y
 	help
-- 
2.43.0

