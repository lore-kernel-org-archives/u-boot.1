Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC675C44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F53C84B51;
	Fri, 10 Jul 2026 14:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r3z336WV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2BB84BFC; Fri, 10 Jul 2026 00:47:09 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6873D84C12
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 00:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso117708fac.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783637225; x=1784242025; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lLjn3hPUwXWfIALAEpjy6ZU7PRr7M0mfrF6I62cXewE=;
 b=r3z336WV7WBlY6J59Yor/yl27MoTrF2h+vSwOxDynyWtziNNvLJ5695F151t165cOD
 Ma6UAPY2FVNYAoNx3yTE2N+1/LEQwEtzi1Jh5cl39zWacCyntsW5wXalvhLm4OCi0DTl
 nbxFqS6YXmeTNl9xJ/xDNBFZefR6/fWfgvbLOlGbBc8sEsOJJ/EqYWDlOYxKShU6EenD
 qcwii9WHaCs7GQgSN8m+7MIKBarHwNmlLiQCdakpLgkHeDlSVALY8BkdooW2B3zV/EHq
 onhJHOp9/ozX3OJqkxylMtA8AosjSqXtdTJb0vUF3Wjru9sN28CzeO/vfdC87SmB7K4U
 kRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783637225; x=1784242025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lLjn3hPUwXWfIALAEpjy6ZU7PRr7M0mfrF6I62cXewE=;
 b=KCgiy9v6R/iW7XvitmTiEV/A15uhCTORn9ewA9cLnjm5/5ywuI8+yu6Rn1gYfRBlcq
 IPvgLhpK5G7JMFg9OqAxh6VE7YgJyEToF+plBU7MdIYtEeq1r8fDYKaJUMhhFbNxlAxI
 M0K8ZCXyeCn6kt5GuNLg0ghjEBJraZxtr9sRqq+A0KHFTyXuevYOxS4TGssnBJopls8M
 uovDU8cHplk4Fow6BbuDzTDGeBvpF8L+xml0w8BNGM2oAC8Sz9sImUbv9Ie93gR+r8if
 PiZzKY6dCPxDqahO8mZ64/jo+laCA8Ldx2kh9zVDnBj/QGSLhIRl3ZheyHz+zaVhBKTc
 F/Cw==
X-Gm-Message-State: AOJu0YynHBENKi+O4NtY+zTTqI2wzxUIRDXrtf1vGPU2zxxHdHg/H9Qm
 Xxe33+0BJHTrQZ1k3KzDIE1ES+jgacFp43xXyls6czMcCcFXB6Fr/6Tr
X-Gm-Gg: AfdE7cm0O/5rlAss7oy6dGl9hVCjK76fGv+T7UqyglcfbD4CuJ80lcFdc+fgewgyEud
 55S3QrkeTwasvz3BUe/YaKmoM8swBu99kYB+XDGM9IXHFZJ8jKpoM2H+Y0wQ6m6Wxk49TkeHCE6
 i5BT90Oj2HnoNRdPfdmMpGHWRaJIF9yIBtNhVWpXgiZWpLO3fMs6ckDkzsmMS9WOi/vNTxNPa6T
 q8xNbs0R8QFLVcDC5ti6TOEPYgSIzgpOvmaYkQ3Hr3CPGUz5smg0xOHAlSDr16PNipVbYV00B6k
 y2LLBHQ6AHiXLRyT1i8eEFfWX6Q/UnG1FSNWCD1EpWsq3YHCwpQcdiGvyKwjxMaE4ZOMZRYGuHH
 JWSfJV2wmo8mPSbOZN+1xWN9iAORwNfLw1DLV4QP8mOCMsp4yH2G31dsilQYT+QyVE7tVoYpNnP
 VZeF31GOzMJgZPP72sL6JR02wyvGSCpf8a7g3vQ6mkBr66JveQLM0mpTrxmFowciA7z8ciJ8sqZ
 8Sf8rDEjJUvJycSsuLTX7i+NZ+j/qH0gorsGo2BEmoaQCCA5PFZj9JF2xv3xzcr
X-Received: by 2002:a05:6871:4506:b0:447:4c65:d956 with SMTP id
 586e51a60fabf-45162de7e20mr5734050fac.0.1783637225153; 
 Thu, 09 Jul 2026 15:47:05 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45191643abdsm3310749fac.11.2026.07.09.15.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 15:47:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 09 Jul 2026 16:46:31 -0600
Subject: [PATCH v3 09/10] crypto: hash: allow DM hash in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-submit-ce-series-v2-v3-9-5017da8c9bef@gmail.com>
References: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
In-Reply-To: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
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
 Jerome Forissier <jerome.forissier@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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
Changes v2 -> v3:
  - Remove the bare software-hash fallback scope  (suggested by Simon Glass)
  - Document that SPL_DM_HASH needs a hardware provider unless a phase-aware
    software hash provider is added  (suggested by Simon Glass)
---
 boot/image-fit.c             | 50 +++++++++++++++++++++++---------------------
 drivers/crypto/hash/Kconfig  | 13 ++++++++++++
 drivers/crypto/hash/Makefile |  2 +-
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index c84cbfaf4a8..e38d84c361f 100644
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
@@ -1321,43 +1319,47 @@ int fit_set_timestamp(void *fit, int noffset, time_t timestamp)
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

