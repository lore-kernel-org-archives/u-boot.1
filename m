Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6A0C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 08:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69D584A0B;
	Fri,  3 Jul 2026 09:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bXWrDl8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BAF849F0; Fri,  3 Jul 2026 03:50:14 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3452684857
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-49190e20a0cso22305b6e.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043411; x=1783648211; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fByOVbe3Q1FZ5kXao2voswi21t3syi5WPTn3S/QRiZI=;
 b=bXWrDl8jndLJsEQi9Pes6K6P0GQl+DCrtAygZckorQS6bm1bW8w+QO0W6tUPwvGhXF
 6Fi6drmyFy8FJHDsEIOFmRmmVImwQLDAyl7nZMNlytyTYABcR5AL6RAaW+CG+mO3Cr46
 1XDxnL1vvapXuBWpnTJJEGIdD/dXSeOnUGtiDfpcBluLKX3+lbyMTwzXNvMLIAAV8a53
 z1SVubpgXSmy97A76luidlcCQZEK4MF/NkRFC1yhn5qkJIL97XQk1yZUw6y/NS+mo8oM
 kOqx1mH2WGyE/zEQDDoz8nmM4+1bJP/syBXBcrgAI0Wtrp7p/BSCSYIES7ZUe6Y5l+4c
 Mg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043411; x=1783648211;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fByOVbe3Q1FZ5kXao2voswi21t3syi5WPTn3S/QRiZI=;
 b=jnEyplwyyxkxMz74nPhlDUIK8FdIEH61euP2F0eabvTJCuWRrLC3fPHEKuE7mpY2GB
 uO+z6kx/qY3F8auzdcbkB54d3XnS01UCf7arsQqpyc6+Flc1D24t7poBffBz7dIHlj75
 UIZY5dIp5yAYlA2tgDPCUgolY8/Da2hFwU98IIRrNfL6dscHhNDz2jlb9BUy9DfmaeJ8
 7xUlLZqZ/7BPNkwiQ/u9Qy65v7ly/OkIC14VAQWFeyGmAba9qvOq15q2oJKCIt3c1C00
 5YB8/vh+2HzTcs76Jyqbi8yosv+mi7fd4qFwE0zhqD/H4QLsgUzNdxlNp9EDXkWpMAxp
 VjyQ==
X-Gm-Message-State: AOJu0YyTGj9ohp0wyacmqZjIdPHIdQaRjelW7mlU8TcN9vCeNO/VtSq0
 EU6qhhxRWEbdIwln07X5V9Ir0VH+spLwnD+gSCjttHGn/bvG1tTHKeXK
X-Gm-Gg: AfdE7cnvadb+T5fXF2kosezBZXlLYpoXnL6upHLSh7KmJZkWcjXktftOmt/hOreL08N
 QseAlTwhvgk2ST/+jkll97HKjFM+YbpZeGSMxmKL6p8KeBiE0wpZRkDhMLSNRL1YJFU3MharB3f
 4WdU2JBfDsDYMvsRjWl8GIw47LnAMBZc6ZpVrfH2uLB7K/dIiPWhELhVjaHuFJHefIgo1cCmEg7
 r+KZAtp3GPaTImbUmNq+KwshuZPWFbR4t2GDlM/a09RSIy74+c7XlHM1VbG4zwLtDXbyNMs9Ae3
 T94TjfY/rEKLDZJYYxBwPlO4SCrAVcH7c3R4Tf8LOsnNzGMSbjgz/fPf1NZ8mlRQ5oDvVvQoDG+
 lzFT+wZIJ8fqj8jScqFwyDsnWYFrPG/xnGE5v/qfBJMtgTbgPxQV+M+LwrlvbubndaVzcpqKP/O
 Q3JgSh5VELDBNKIbXpK5Ce5MgJj+7Y7ZOZuqWmo95eiUbtbfqfXZaRMlnGp8y99868L3e8Fp5A1
 1Cui0HUm7HOeEBDPo29S4sivQs/HkfVkPEE7QXlUj1c2xaycJ5Vcj6CcPHgG/Aek6JuMrvJHvXP
 hqpF
X-Received: by 2002:a05:6808:5089:b0:48a:c065:6fc9 with SMTP id
 5614622812f47-4960efcd709mr7373316b6e.40.1783043410812; 
 Thu, 02 Jul 2026 18:50:10 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:50:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 02 Jul 2026 19:49:54 -0600
Subject: [PATCH v2 09/10] crypto: hash: allow DM hash in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-submit-ce-series-v2-v2-9-ffda5bed58af@gmail.com>
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
To: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ion Agorria <ion@agorria.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Michael Walle <mwalle@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 03 Jul 2026 09:59:22 +0200
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

The hash uclass is currently keyed only by CONFIG_DM_HASH, so SPL cannot
enable UCLASS_HASH independently. Any SPL code using hash_digest*() has to
rely on U-Boot proper also enabling DM_HASH, and the FIT hash path selects
the driver-model implementation with a non-phase-aware preprocessor check.

Add SPL_DM_HASH, build the hash uclass from CONFIG_$(PHASE_)DM_HASH and use
CONFIG_IS_ENABLED(DM_HASH) when selecting the FIT hash implementation. This
lets SPL FIT verification use a UCLASS_HASH provider without requiring the
U-Boot proper hash uclass.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/image-fit.c             | 62 +++++++++++++++++++++++---------------------
 drivers/crypto/hash/Kconfig  | 10 +++++++
 drivers/crypto/hash/Makefile |  2 +-
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index c84cbfaf4a8..a1d8ab742c0 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -32,10 +32,8 @@ extern void *aligned_alloc(size_t alignment, size_t size);
 #include <malloc.h>
 #include <memalign.h>
 #include <asm/global_data.h>
-#ifdef CONFIG_DM_HASH
 #include <dm.h>
 #include <u-boot/hash.h>
-#endif
 #define aligned_alloc(a, s)	memalign((a), (s))
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -1321,43 +1319,49 @@ int fit_set_timestamp(void *fit, int noffset, time_t timestamp)
 int calculate_hash(const void *data, int data_len, const char *name,
 			uint8_t *value, int *value_len)
 {
-#if !defined(USE_HOSTCC) && defined(CONFIG_DM_HASH)
+#ifndef USE_HOSTCC
 	int rc;
 	enum HASH_ALGO hash_algo;
 	struct udevice *dev;
 
-	rc = uclass_get_device(UCLASS_HASH, 0, &dev);
-	if (rc) {
-		debug("failed to get hash device, rc=%d\n", rc);
-		return -1;
-	}
+	if (CONFIG_IS_ENABLED(DM_HASH)) {
+		rc = uclass_get_device(UCLASS_HASH, 0, &dev);
+		if (rc) {
+			debug("failed to get hash device, rc=%d\n", rc);
+			return -1;
+		}
 
-	hash_algo = hash_algo_lookup_by_name(name);
-	if (hash_algo == HASH_ALGO_INVALID) {
-		debug("Unsupported hash algorithm\n");
-		return -1;
-	};
+		hash_algo = hash_algo_lookup_by_name(name);
+		if (hash_algo == HASH_ALGO_INVALID) {
+			debug("Unsupported hash algorithm\n");
+			return -1;
+		};
+
+		rc = hash_digest_wd(dev, hash_algo, data, data_len, value,
+				    CHUNKSZ);
+		if (rc) {
+			debug("failed to get hash value, rc=%d\n", rc);
+			return -1;
+		}
 
-	rc = hash_digest_wd(dev, hash_algo, data, data_len, value, CHUNKSZ);
-	if (rc) {
-		debug("failed to get hash value, rc=%d\n", rc);
-		return -1;
+		*value_len = hash_algo_digest_size(hash_algo);
+		return 0;
 	}
+#endif
 
-	*value_len = hash_algo_digest_size(hash_algo);
-#else
-	struct hash_algo *algo;
-	int ret;
+	{
+		struct hash_algo *algo;
+		int ret;
 
-	ret = hash_lookup_algo(name, &algo);
-	if (ret < 0) {
-		debug("Unsupported hash alogrithm\n");
-		return -1;
-	}
+		ret = hash_lookup_algo(name, &algo);
+		if (ret < 0) {
+			debug("Unsupported hash algorithm\n");
+			return -1;
+		}
 
-	algo->hash_func_ws(data, data_len, value, algo->chunk_size);
-	*value_len = algo->digest_size;
-#endif
+		algo->hash_func_ws(data, data_len, value, algo->chunk_size);
+		*value_len = algo->digest_size;
+	}
 
 	return 0;
 }
diff --git a/drivers/crypto/hash/Kconfig b/drivers/crypto/hash/Kconfig
index 72b955ac791..6efae911a70 100644
--- a/drivers/crypto/hash/Kconfig
+++ b/drivers/crypto/hash/Kconfig
@@ -4,6 +4,16 @@ config DM_HASH
 	help
 	  If you want to use driver model for Hash, say Y.
 
+config SPL_DM_HASH
+	bool "Enable Driver Model for Hash in SPL"
+	depends on SPL_DM
+	select SPL_CRYPTO
+	help
+	  Enable the hash uclass in SPL so SPL code can bind and use
+	  UCLASS_HASH providers through the driver model. This is useful for
+	  FIT verification paths that want to calculate image hashes through a
+	  hardware hash accelerator before U-Boot proper is loaded.
+
 config HASH_SOFTWARE
 	bool "Enable driver for Hash in software"
 	depends on DM_HASH
diff --git a/drivers/crypto/hash/Makefile b/drivers/crypto/hash/Makefile
index 33d88161ed4..9f0d30f9be3 100644
--- a/drivers/crypto/hash/Makefile
+++ b/drivers/crypto/hash/Makefile
@@ -2,5 +2,5 @@
 #
 # Copyright (c) 2021 ASPEED Technology Inc.
 
-obj-$(CONFIG_DM_HASH) += hash-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_HASH) += hash-uclass.o
 obj-$(CONFIG_HASH_SOFTWARE) += hash_sw.o

-- 
2.53.0

