Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7633CFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C13888FEF;
	Fri,  4 Oct 2024 06:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Aj5OZsVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF19288D1F; Thu,  3 Oct 2024 23:55:12 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21F488CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4582fb3822eso9120841cf.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992509; x=1728597309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xW/JZhwGDoLpOIoqDDm/SGBCGyyOZU5ATMcGuAzPexo=;
 b=Aj5OZsVUaWNxynwi5uI3BDJ17EcZHJ2XLjX3JVC3Bmx0mOnqy9xmE411TDbmwnVN+w
 YlLAM2SFfJ0h6SvzRTNm+XvmDUV44qY2nBIuHTyG1PV11YYy8kXDqZOgkbk1bP18uecw
 K9u1zaECEi/zjO+qvKNkFhmupOXpah2kjKVSWuHTs6NgxZ0IxJBJN8xuQ4eQS3BtPkhc
 b1pUNLCNKO8B2xKK5brVbEgX/NgoxHRNRntdvNzAITdwVk44yWBBKoWvA+EUCcYfSSeu
 izt2hcq449lM9XMjdzpcaeBKF8Q1XMCp/UxS3aPzjWINI6Bx/Zn9GxOhQIYL6ai14Ig4
 CYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992509; x=1728597309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xW/JZhwGDoLpOIoqDDm/SGBCGyyOZU5ATMcGuAzPexo=;
 b=Dl9S0a7H7g75rcrLtols5fuHUURUVn6wOPCK3GvnZTM7pkuBQdAdGIDIY6PfgETmUr
 afH/iiAU+Mz2Rrdt4Q0R1llrLv3FThjxQDAzeFvc90SaywI9ZD8c0CWZADKLZ/T0D3+e
 lDklMNulpOZl3mUQA9UAw0gUJDn5fGXWjsmcKBdW5/9kShFRmmNiqro6hWzRdcPJUzel
 zg+AOWnlVkqgAN2oC4h5ChR59/oPyHxwlRXaqpfRGYZW7ei9dPZt9a2MvzoOk1x2J/P6
 0OFuJ2xoFbM0v9tS16HxCWN1iETkyEywU2kHp7lo1QE9f0TMIdf48EuFGGZ3qfocYvI2
 D97Q==
X-Gm-Message-State: AOJu0YzEbwX5woblu2ewKajugbv0NPXoskd8E8ojOcgFh035gc72mPhg
 1LH09xhrIEfDtheEBU24wJSKlvtnh4k+UuKGL+MJfPkTIxGKYRL5t5xWgDOtW9YJzL5Y8i5eq7+
 1
X-Google-Smtp-Source: AGHT+IFa89CpxyWSaUX7AGcMTRqKKNCu+N4lzJPJGO9iNqYUIbcK1DVk253Bs/3oXWYcB/6IepAi1A==
X-Received: by 2002:a05:622a:1985:b0:45d:7ebd:43a4 with SMTP id
 d75a77b69052e-45d9bae7a8fmr8159291cf.58.1727992509461; 
 Thu, 03 Oct 2024 14:55:09 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:55:09 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Linus Walleij <linus.walleij@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 07/27] mbedtls: Enable smaller implementation for SHA256/512
Date: Thu,  3 Oct 2024 14:50:20 -0700
Message-Id: <20241003215112.3103601-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v7
- Fixed the config dependencies.
Changes in v8
- None

 lib/mbedtls/Kconfig              | 24 ++++++++++++++++++++++++
 lib/mbedtls/mbedtls_def_config.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 262abb2cec7..8e3a94c6f2b 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -164,6 +164,18 @@ config SHA256_MBEDTLS
 	  This option enables support of hashing using SHA256 algorithm
 	  with MbedTLS crypto library.
 
+if SHA256_MBEDTLS
+
+config SHA256_SMALLER
+	bool "Enable SHA256 smaller implementation with MbedTLS crypto library"
+	depends on SHA256_MBEDTLS
+	default y if SHA256_MBEDTLS
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  smaller implementation with MbedTLS crypto library.
+
+endif
+
 config SHA512_MBEDTLS
 	bool "Enable SHA512 support with MbedTLS crypto library"
 	depends on MBEDTLS_LIB_CRYPTO && SHA512
@@ -172,6 +184,18 @@ config SHA512_MBEDTLS
 	  This option enables support of hashing using SHA512 algorithm
 	  with MbedTLS crypto library.
 
+if SHA512_MBEDTLS
+
+config SHA512_SMALLER
+	bool "Enable SHA512 smaller implementation with MbedTLS crypto library"
+	depends on SHA512_MBEDTLS
+	default y if SHA512_MBEDTLS
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
index 6fba053bd7c..1af911c2003 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -35,6 +35,9 @@
 #if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
 #define MBEDTLS_SHA256_ALT
 #endif
+#if CONFIG_IS_ENABLED(SHA256_SMALLER)
+#define MBEDTLS_SHA256_SMALLER
+#endif
 #endif
 
 #if CONFIG_IS_ENABLED(SHA384)
@@ -48,6 +51,9 @@
 #if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
 #define MBEDTLS_SHA512_ALT
 #endif
+#if CONFIG_IS_ENABLED(SHA512_SMALLER)
+#define MBEDTLS_SHA512_SMALLER
+#endif
 #endif
 
 #if defined CONFIG_MBEDTLS_LIB_X509
-- 
2.25.1

