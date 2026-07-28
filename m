Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFACC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7812860AAE;
	Wed, 29 Jul 2026 04:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4seYc7CE49fH; Wed, 29 Jul 2026 04:55:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 707CB607DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300938;
	bh=rC9iLEXmlhTjBmnbxiVy7V59I/eo9Q65DsT689aU2qo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tIevi8ioFmgkobY9td9iZeQ0mRbcqqutRBQD3RGdNart5tP9BJDY+SAiZafIDoqBW
	 eqjCaObcEc+cXwMmvHBTffK+7VF+Rej+LQi5WCWOCoDzcq6Pnu0/UZhzfVu/ZED0HY
	 YtLm9ylO3eLkYG7bcAtMGBXiOAwlHbKVtqWscL/WteD6qnsdzmD73s0PwfOdDoMbLk
	 8h5jkwBFNre7pszx/2iJGlffs+I78f5osRmThxrVl9gajoAdigx18rUYJsr+glbV2q
	 UxfalChEn61t1+J+0zxbMBZkjgAocGnySv+7Ge1CWzcIBOVfDDzWgoSjXTkbQlCm6x
	 G4v7juNzpB6fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 707CB607DB;
	Wed, 29 Jul 2026 04:55:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CEF42490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0C40409D5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NO9jL7Dhk5US for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:44:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ECE014096A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECE014096A
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECE014096A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:01 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7ee4399c423so146487a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260641; x=1785865441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rC9iLEXmlhTjBmnbxiVy7V59I/eo9Q65DsT689aU2qo=;
 b=mdvshkbruFagGDSSkMeOH7H/GXib8xWjGnTyKNfxhunfcLI/MmVSky0Ym89Y0Mr1Pf
 5/R//ZWYW6WbfcmeI9gjwcLrBn3nCXNSfj5aVXkaOybiFmmLok2QT+rCQZYCQYtH1bI5
 /tOjmGVk9utDyOPv2QP0wQv18Y3YLk6aRo/mGR+dgOtkEece/fuLn3RxYVgARVOXcxAy
 2DxFl72HJmDmN2nLXtz1SAJoOPQjdaNP8yroa4u98pVCG47vtqa8Fjc7xbTVwndLWIQC
 Xloan867JB24/qdmERy+9OuFnVgjUVGGADq88c5+TYhJlacvLdIeM4Ly6I53QArcGsFo
 UpAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RohIWuPll2gshjk2EfNKWObvXWzAnuDOZ0OMxTu5HItMDDgF/TLgEsov9ZnB0PXeqISeWrBfQY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwYQlpXLsZvAbpSjaxtSKIJCxonuoqHdWWf/YFWJ7gEdqUdWkqV
 g404F+3gvo28GkhcC5zkW/p226iSgEt1DFNg2X2oGQwFdi5qRqf2lHre
X-Gm-Gg: AR+sD12ELgcuKAfB6029qg3A9LMfhfIqnWQdgFJLylDccbwV4Hp+MMiN6aVuglXi/L1
 P7nZlA7Ow6FBctJ+c9cnjS6nuLtCUswwqkyonKUTkyiP7roPDS5Ba3+BXrAT7gOTOhMtyGTyulJ
 gWEze+UZyEiAm8c/r3O/GjnRDaSUujUMI7IdN+kR7lbgoHHxW5GghPU6hGe33kH/yXx3lqtJ/le
 AkDEhv7+xsPPjefdiGAxknDc4bzCWNNlbVTZFZGz8QAyZmw/kOq/fMFK1oNexjcWtl+xiCVf5cs
 UUX/Jq/HuejZxlIWQMMVuh4cqvW4PePpzzzNZ85EzkrzrjvlBhKTHOf2+oTxTwBDMv2jWi/qamu
 cvVtzu3YPGFpNKkzssLClD7RsSex/uOejsPdEaOHr3GmXvO5JfiASDDxs5qUXtxeRoSITN1Ls06
 YNtBiHHyry63odi44r/FXmWCvfs0be52kSxf7PC3DhAqIepXZtRwG6nhdsUewnHT/MBL0MdDEda
 REoZqcDhorrHvvv/1Duco3bIth1ms7FzBdpJPJdYWbLIdhLAqYP14qx
X-Received: by 2002:a05:6830:6085:b0:7e6:f406:2cfa with SMTP id
 46e09a7af769-7efff26f0e6mr1856967a34.17.1785260640799; 
 Tue, 28 Jul 2026 10:44:00 -0700 (PDT)
Received: from [127.0.1.1] (71-218-31-69.hlrn.qwest.net. [71.218.31.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94389dsm271103a34.21.2026.07.28.10.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:44:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 28 Jul 2026 11:41:46 -0600
Subject: [PATCH v6 03/13] crypto: hash: allow DM hash in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-submit-ce-series-v2-v6-3-80c1f7daffa5@gmail.com>
References: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
In-Reply-To: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
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
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785260641; x=1785865441;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rC9iLEXmlhTjBmnbxiVy7V59I/eo9Q65DsT689aU2qo=;
 b=Q+dmo9vRjJf8mOriKBD0AQ96CYf6Ngxk9VnNE/vfwluwgEuul1Hj9ttnD1Zm2rU6Gl
 Z5EZ5lfDqSQ3fxRPJ4YPabZqL1Q/K4XjG2Ske9nlbChuvsGImSKrgGnLNT+HxR0ySrfh
 +JYcdSiBK1pofXRjTksB+es1zPJmiHHlJ8LYG5kfsUSgcf+rdOHHlDagtxWrSQACImHU
 /JbTLoAf2eGewQ2AFpWSEuGN2cxfrxsg0alKeUjtVnlHC06NhL6rGPuCkKv/1kE+V1eK
 ZmAuKwPJETv8baxf6AOCZwYe9nACaXwPv4FLHQbBor+vYShjFGpTSv8+DSzP2e7KsrPM
 mutw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Q+dmo9vR
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The hash uclass is currently keyed only by CONFIG_DM_HASH, so SPL cannot
enable UCLASS_HASH independently. Any SPL code using hash_digest*() has to
rely on U-Boot proper also enabling DM_HASH, and the FIT hash path selects
the driver-model implementation with a non-phase-aware preprocessor check.

Add SPL_DM_HASH, build the hash uclass from CONFIG_$(PHASE_)DM_HASH and use
CONFIG_IS_ENABLED(DM_HASH) when selecting the FIT hash implementation. This
lets SPL FIT verification use a UCLASS_HASH provider without requiring the
U-Boot proper hash uclass.

No in-tree configuration enables both DM_HASH and SPL_CRYPTO, so the
Makefile object key switch does not remove hash-uclass.o from an existing
SPL build.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - Document that no in-tree configuration relies on the old SPL object key
    (suggested by Tom Rini)

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
index ef90c5abd18..d7d7c70fe76 100644
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

