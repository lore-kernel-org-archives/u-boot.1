Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420EFC5DF6A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74D2F8100F;
	Sat, 15 Aug 2026 13:01:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynDYfdOzt1os; Sat, 15 Aug 2026 13:01:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 453F281202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798884;
	bh=nfFqn1btDcuwrJHOaGAmXx29nodWtwcgu/zk1iVnurc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uxrD99LtJH1aMaKgHQBY4fMZmuI9frPR3WEATf+CZPukRsD3XC0RVYOatPomsIlhB
	 PuwM0zYa39Ml37v6wsKbRS0/ZgTq/qnIDIFS+ENKn47sV9hbngMxc7OQinwWP4UmBs
	 x581+ZXEm3maBCvUhiJL0h48Z8SQEzyIUSfbTtqCPwtD0U5VuDQ9g5ibLN9huBbm4o
	 Tl1jTZe/yAyZvXEsyGX+tgw4i5umXn0o8P2yRLZ5t/cxKSLe5OViCB1atINhErNiF7
	 fDS0ly0Zu/8/sWDitnjY8/DZGHMzFpFiPKzR/kzz7kTqZZgd3RxND98hEXAqWRCM+f
	 LEHoTvlqbtFdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 453F281202;
	Sat, 15 Aug 2026 13:01:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2342B361
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1597A4005A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pRJGr6H3KBKM for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:48:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3B5AA40026
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B5AA40026
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mDRAFvnj
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B5AA40026
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:46 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so1308659a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772925; x=1787377725;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nfFqn1btDcuwrJHOaGAmXx29nodWtwcgu/zk1iVnurc=;
 b=mDRAFvnjwS0D4TwjJL3/nWW7K6PBYLiByCq/vmdGTC/x7ZlNT9CZ0BZbZCJ9i9N+J2
 pOpXThfXtTWnweSlcyv58QUW/eSqA0GEXk9CxUo4K2rcIJ/Nbj8kkua092SiLIObMIYl
 +yrpfYFPi79T0SCro5MsKBA2q9GEVswzirK7uweayueDzIHftDyVNjZHY0+YjuRlNsX3
 olBZB4DPcPX0luQVv29BZlQpUINEagzAV4abqskBbiynm9RyevjrLsD6+ydVp8ava0KO
 cb0Ae2Ur3qgZSnzPccZ6goLcXqlmKjZJ/EfBbyccygaNAaHs4wRxj7J4MS4/SKdboDL5
 dGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772925; x=1787377725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nfFqn1btDcuwrJHOaGAmXx29nodWtwcgu/zk1iVnurc=;
 b=BLAktv3dz+kGEjlpis0Eex5XpP8rJBfw87sYK66s+52AjZsQdl0ndHwBzMtWgfy4d4
 xwNqluMhUB6yAaWh36wHNBW7j2RlfIREhnUshDKlypiL6u++DT1ZrmBMLgBKL2WyDp/0
 qk8pehIVJPv3Bteum4uagxvbfGbMQhXoLualCvVMdQp2DDHaJ0KHkZThWje8CcVEobUj
 0CTDF0Va07CBfxTpJghEf48S6aHZXezFkaSfSb2Hbz5cte9gSuHPQ7Lb/igjWkOohSfz
 4ziwQGtd9EXOGQKxJVP1Tpwws48P0ERixLz9SMUXxmLgV9WzHC9BESE4RimbgWXQ6V0q
 hrwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcbAbASJMt0oBrJUGKA98e+nrsdX4Fc5iXUEW8Z+BE45YEzYaGT8a5yPhtuHzKBuWt+GQEUPk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwREbWttFl/HZ8/A8FF8JIK65+iAPRMfRFV9tSt4Y8bjKuKaMmP
 i1fd52a3OofoKeERhMLrOQ4dQeUw//0AjAMrIhihavNiWk2zc7XC7+7U
X-Gm-Gg: AR+sD118Bus4WycKvBDRv7kYZneU4IjL4k63/BpAVKPkzrIfmiXKNzYW5yjfnVXz4FS
 g/kA9Cg604mKDInKoJsk+TxLfqnxcunxf4o/faSsGuh8TaFyvYIbJLLiFdKT2/ZC121hlL3Wxvv
 Z8TfZXg5vFALKmn5KMWjZaDATX5vv+ySB22WBNy3lfvxu5g4Mxl6M67kgoFPiY+yqPm6oOQ/Cyp
 bOj6ooAx1sRAEQa4mC2OEePwqK1QbihZLDflbsWEwOy6Bc30ZHSNUthOqVpPtBm0sRuFskyP9Qq
 tgj2dd7G4cc2ZMB/WTVBSTC/zWDidO/cSM33WTBT/KSw/W94PNCZg3wnRZycVrB3hmHH2CAWZMO
 DNBszuZE/X3aflSND+WdsbxYPWnM4bZBcYFU/16RGcGM6gd4Q3ihAc71TtKvzGvT5ZgA1RWJ/ew
 4DAWOLLcVur2dJUxHgLYRF0v44DohZJ2HpPpZ1nADLEzl8qRIv54lEIhhmpjacNYV8El3GVTNIg
 Gh0E0SL8rtVlPaQDXDes0sHFzsnBknElK/6/Ae+0OPIXQW2vYzOLOaer8UoQlEjNv0RfHRJtlKd
 ezscT9yKaJwRWzHlFHpX9eaY7Cobs+8u4Z4TRKxp8Su/rTOdYjyrubV7AOCvBYg6Xy8kCFejQvR
 CGIgSMqPwrxogNHwM
X-Received: by 2002:a05:6830:398c:b0:7e6:f7fb:9678 with SMTP id
 46e09a7af769-7f3de419859mr10503660a34.1.1786772925034; 
 Fri, 14 Aug 2026 22:48:45 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:48:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:10 -0600
Subject: [PATCH v8 03/15] crypto: hash: allow DM hash in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-3-fe9212431a94@gmail.com>
References: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
In-Reply-To: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
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
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
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
X-Mailman-Approved-At: Sat, 15 Aug 2026 13:01:17 +0000
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

