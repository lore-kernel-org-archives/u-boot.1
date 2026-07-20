Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DFBC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 04:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1441984949;
	Mon, 20 Jul 2026 06:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G0466seC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20CE838D7; Mon, 20 Jul 2026 06:14:23 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E2F80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso3149813a34.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 21:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784520860; x=1785125660; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DQ4ICS4c1cV1sSwdq8A002d7NgCqFtYXX1nbZAt+aJM=;
 b=G0466seCr8LwKaVrWpGFGCiRZw26EcNUtvKgia0JqtUM7Sz4qTrkptF4tHTDvK4VTw
 CWz4uqddVLWbkeTveYzl2dwSg6ygepBDMRuDtZMG74uFciPwP4ivlDbArhX8Qi22afGT
 9RG/kI80iyy0p6+sUwF3XG/ObsotAWlN+c9BLF+8OnzCo/6BNqyzB0cq23deeOOwvE4O
 fKTL9LDDLU8xwJ5BnQ0uaDaWpclZNPkbcBHKnZHtOqJi9ve63DEj6/HB9JchtFl7FxNp
 mWcVgh1Xh86+aTnj2d7LKfYOa30iPhQdWZUrrUvMV9FYhWLYOO7HQrTV2aRzsBe9EkJ7
 JmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784520860; x=1785125660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DQ4ICS4c1cV1sSwdq8A002d7NgCqFtYXX1nbZAt+aJM=;
 b=PUJv2fzAhmmInGLgFloRUrTVZt8OwhT+efB85IxKsy3yoajn8uza/tPvMpLKEFQkRE
 n2G2VzyxD+rorOf7maXhv33qnjQ9kEGEBrPiSTbFPZG8OFUZqNQk6QeRbMTGd2M465vl
 6J0y39UtmmXFGxT1C/VbZKRCK16N7YEEM/Yax5uY7Gu5AHB4GGouzCpWKk56cfb+g1Fe
 EVujAbLibSCo8USJO5F2Qv5rCGmys0M1hPlmcGIXGVTCbvsiC7HDNXQuCoVXN6MJwtte
 vys8ug8yeJBDgs60gkBUwp4vyYVylT1d7VPM3aF4QB0f+Uq25aeMlLpMgorVmcoBfcv7
 M+7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4GYWGINu7YQcmtaVDAqU/hxM2Y+yI9h1ZLhtZhJ+t4fY2IbCnpYBMEYnfkWpzpmCZUzIC2jA=@lists.denx.de
X-Gm-Message-State: AOJu0YwHBO6sBOiiKrKBks8e010tnpQWiVvebgn3iQ8Csn3Jgnd1Gp5W
 /2Z0c2lPq+AiCIQJtpIWgplv+6my3OWm/+SdsorNCvFg3j4izgT9yxBz
X-Gm-Gg: AfdE7cnvNfTlGHKc3bhZR65QLZRPmfzURWjLJ8Qcu60hBX6kCb4Ohz7I4++bP1dMas3
 GilcHE5MngjJSuHSLGPrvuPOJig5B3tqlXCVhQPHrVzaT/wvdAkf3x0CGRpY8c6ogvbxgIgS2ai
 yhtbeVsIa27mb8l84/suPx/4y4Ria4djgNpyDveSe6Oe631TRpufM2ouNCuJ7B2D2h/DRBjWghq
 IDZEl6wnmYO8b5eA6dWUxBh1leUcgl8UjsKZ7tySMaJYfjUo27bM4c+vqGc7YuoFY8rmiddrbQa
 EV0Btkp+KyHdcnHHzFQHrTvs0IoClnc/7AYezRmumCDagTya1REl/qPh2zl/RtYZgh7Sy3kjUSV
 ygVfEKzDvudlSRFxwZRxdIEMBZeu008CIQDgjBJLRZ45bM+51VRpI/DjWgZSCpDofX4uECCMf/G
 fPyO1JEfmUwca1A3UTcm/ng2/Kxd5QxpSt6f0m7+Moetg/VjUI+82EYDm1wx10XtrFZeukICrIT
 O9r6i8IqDfK1X5c/wJNjJ4TcASSOzbPj+XwmTGbe67rxnxPVpyTcg==
X-Received: by 2002:a05:6830:6485:b0:7e9:cf5d:b7c3 with SMTP id
 46e09a7af769-7eda1586482mr6360206a34.23.1784520859914; 
 Sun, 19 Jul 2026 21:14:19 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf94a737sm7159191a34.15.2026.07.19.21.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 21:14:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 19 Jul 2026 22:13:48 -0600
Subject: [PATCH v5 04/14] crypto: hash: allow DM hash in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-submit-ce-series-v2-v5-4-3c41f66d4522@gmail.com>
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 20 Jul 2026 06:33:25 +0200
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Remove the bare software-hash fallback scope
    (suggested by Simon Glass)
  - Document that SPL_DM_HASH needs a hardware provider unless a
    phase-aware software hash provider is added
    (suggested by Simon Glass)
---
 boot/image-fit.c             | 50 +++++++++++++++++++++++---------------------
 drivers/crypto/hash/Kconfig  | 13 ++++++++++++
 drivers/crypto/hash/Makefile |  2 +-
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 044a40e1910..555cbf81348 100644
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
@@ -1318,43 +1316,47 @@ int fit_set_timestamp(void *fit, int noffset, time_t timestamp)
 int calculate_hash(const void *data, int data_len, const char *name,
 			uint8_t *value, int *value_len)
 {
-#if !defined(USE_HOSTCC) && defined(CONFIG_DM_HASH)
+	struct hash_algo *algo;
+	int ret;
+
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
+		}
 
-	rc = hash_digest_wd(dev, hash_algo, data, data_len, value, CHUNKSZ);
-	if (rc) {
-		debug("failed to get hash value, rc=%d\n", rc);
-		return -1;
-	}
+		rc = hash_digest_wd(dev, hash_algo, data, data_len, value,
+				    CHUNKSZ);
+		if (rc) {
+			debug("failed to get hash value, rc=%d\n", rc);
+			return -1;
+		}
 
-	*value_len = hash_algo_digest_size(hash_algo);
-#else
-	struct hash_algo *algo;
-	int ret;
+		*value_len = hash_algo_digest_size(hash_algo);
+		return 0;
+	}
+#endif
 
 	ret = hash_lookup_algo(name, &algo);
 	if (ret < 0) {
-		debug("Unsupported hash alogrithm\n");
+		debug("Unsupported hash algorithm\n");
 		return -1;
 	}
 
 	algo->hash_func_ws(data, data_len, value, algo->chunk_size);
 	*value_len = algo->digest_size;
-#endif
 
 	return 0;
 }
diff --git a/drivers/crypto/hash/Kconfig b/drivers/crypto/hash/Kconfig
index 72b955ac791..272af7bce18 100644
--- a/drivers/crypto/hash/Kconfig
+++ b/drivers/crypto/hash/Kconfig
@@ -4,6 +4,19 @@ config DM_HASH
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
+	  HASH_SOFTWARE depends on DM_HASH, so SPL_DM_HASH alone does not
+	  provide a software hash device. Enable a hardware hash provider for
+	  SPL when selecting this option.
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

