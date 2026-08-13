Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DA3C5DF66
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CD0640CED;
	Thu, 13 Aug 2026 20:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ryd1bmozVNiv; Thu, 13 Aug 2026 20:17:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85C5C40CE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652267;
	bh=nfFqn1btDcuwrJHOaGAmXx29nodWtwcgu/zk1iVnurc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xvTMt7/GfOsNABK3t3iJlRkq/DakbV6ua8v59RS/6ffs67RgisJJGMzh+NAfAKQFM
	 UJFoNhYy3Gv89LcTBO2O/OSRwHiacUOXW+FZHktIWTm9yGJ445ll1iZ7mAyaRgad3S
	 uNyrJl/LH8ytuFkR9irRyekNckA67XWwukA511nxfNu6naOjII25wxAt7MoWgTVyBh
	 pXEZf2Mz1NSMNww6CK9QAoWeYK0Za3yFt2C8+0pOWE/jK9ANf2XB/StM1ohpR8au2I
	 IX2KF8U/uVHEwfV8yLQP80PN7fMADgjYDAywKXXZr1A9q5ut+aMvOW9+tE+h+5W4h7
	 Y6YQ6mK9kmoqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85C5C40CE5;
	Thu, 13 Aug 2026 20:17:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E92133B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FE7C40CC8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkCLGGLLd7Wq for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AA0DF40CB3
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA0DF40CB3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Cb7aUq8f
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA0DF40CB3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:16 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6b0ab918216so185411eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651155; x=1787255955;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nfFqn1btDcuwrJHOaGAmXx29nodWtwcgu/zk1iVnurc=;
 b=Cb7aUq8fiunOBAqCyWegm9cvVWVaqzvkd5pJ4vSlKpFSHhko3/QNfAvO71hvXSkJ+h
 3i6Ba2YPp+wE8rTPe0wDWlO8TBYZE7uA4OiKz5zuijq/KkWJx3JjioTwkJbZKYm3I7di
 id58Hx5gEFU+wOdcVtWwtPc45aHJB5uF9zpnCy5XnDQpNkYPbuCPBRR9ou67qyUiuX7F
 0PNXUGoSBzkaojg0s+eMozJ8QGTewsxFq2yAGUHvlsO2JZIHjqwCgVoJUdS0woHHhkb9
 IB6ehwvceK5i4gxur3RfydkHJvOtHY2kwCfY8XVGF9svrKEzlJ+8V6j0u5NfZq3BFek/
 DY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651155; x=1787255955;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nfFqn1btDcuwrJHOaGAmXx29nodWtwcgu/zk1iVnurc=;
 b=CJtErfE96iw+KUYNANt7ifzryKfWFjSAy3xW4csf0eu/T4m4OMIv//yWjSbrySEVQY
 jXn+eHByL3V7c6nBPuTTsdwPQf3uaoNLY0OWPqoBALEs9ibQ09ZMoX9YD0oZhC4kkMZM
 kCgz0vOGZoXwTjKit1kY1enjAavTZdq344mnY79XZRn+TRlWRd5VjTZ3BfLuYB8hdHwX
 aImXGNMyaJCkFkaAY2fXkuR+bePgKc9YLz6+IszEm1rAkohcf+hW0+yUC0CSJaUr1T8Z
 WppK2+btMHRMk/0OP/o9IPpG4bFhSU6Rj0REm6nBw/VI8gyX+/S+k8FL2UAMuLatsqzC
 fyuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhPAfA9U7eBesAe0wHLGSrGrj0dPiEiQ7S6CGVdwna9Avkh7Pn+4DufYiWrj7jVhGC44Idvlo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxwNRSmLvZbEJI+os0IANHQb4so2RkDRUEf2ayLhcYTsHBO5soB
 AEcPDB9Onnav+LfX7ZX52iqEg1P8fOtxWLPRptGbDUTRRdbxw2GOyxDi
X-Gm-Gg: AR+sD1183eOjPYvPaf0eRp6jPH43RrF3r08NurZWcgAlroBKC4ZbCofNYv8wFZkOn96
 ULZaJRSixxTosxrDdE8XTZqjVZ8TpoOjruJDgWylizhBZJgnY5p+8NypF49lUBg0EhwAGMMx1SV
 WmAkv6rKTCKYcK1MneuQKcIG0y3djpEa3JGeUHwI7pLkamUAZrEQxeNBQ+2nC8h919sB++EKyKd
 s8RzhEh1GEyb2BA6vNkQd5qfirBopT3N/H0XT+RUeQ6WVU7V9CVM8rtZOiere6WBqXQer2aJiFs
 wGTyXArFnMWNZcp8ARO9r1xsJ0S6K86w61Uc5qDySHuv1IQORnI38yHiLChZ1NsbGcRTTzSTHVu
 hrauYCTtTb+V4BkFOF/On/6hL07ixv7fmfPtFb/9ErKEN/p1M4ZnwQVHl/CTz+MiaP2qTheawKv
 7EwUFBo4Kl/UVPKO6j0FN2Vp8tjdpZfxGvr+wwQHEL0J2Klz5KeqojdF7kKBYyW/S/46zEkKjuE
 UJnrMGP9N7ZXdmpLpzY6m5koFxe66NOUhtKeF+wNA0Y/OjGeCRQ5i91YGM7k/CX2ncqlzJBTmGm
 r8PhKfg3RDt3aKs2raFrRjTCx6juh/TPLuS6AXVPv1i+4mjorYBxMSlO7KRVcqfXqUlbu/kk6ba
 vBflEv1N+tHREkpW/
X-Received: by 2002:a05:6820:1c90:b0:6a0:a791:6885 with SMTP id
 006d021491bc7-6b0d68d2df0mr781975eaf.23.1786651155526; 
 Thu, 13 Aug 2026 12:59:15 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:58:56 -0600
Subject: [PATCH v7 03/15] crypto: hash: allow DM hash in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-3-593fcd8479fd@gmail.com>
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 20:17:42 +0000
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
Reviewed-by: Tom Rini <trini@konsulko.com>
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

