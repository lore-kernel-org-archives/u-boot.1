Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5373AC5DF6D
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11E8C8133D;
	Sat, 15 Aug 2026 13:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLtv-pBIMf1X; Sat, 15 Aug 2026 13:01:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23909812B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798891;
	bh=98tl0PJP6gpGLJrzAaOaDQF8wIvsdcZ/BBwkThktPsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vFVKvCrz/bBIWsWwy1ewYDySY2Tj8IzXaUFEuhxY2pT32DdgU3q/dE+xQZxglN/S9
	 cg5lxiJVpgL2TuxF/ePXX00QwrF9GB5zS6MTm9e9mNXuOnTjaslQLXpTonB4Jq+yrd
	 pcCvwHxB3X5vrI24AOFEbHx8H0UqbxYWeolewchV4kxWE9GMwSSfgevDTpPBvXzvyz
	 Q51GPCHKDTZX5u6BjiYFnBRTRiAtkDwVftMq1KMiAx2s0dwjbcmbNLz9MCBwugovBl
	 KHLIaDFfwHUoC4g7d30qRdaVYpILJR148M7iz1PqPMjDYr+ihprTKuWHOuvYW4k3YE
	 /Z30BdLCkp4Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23909812B6;
	Sat, 15 Aug 2026 13:01:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9463B194
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8618C81366
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRm4h9w02Ilu for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:48:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 07E9581364
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07E9581364
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SZLXnCyE
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07E9581364
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:52 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7f3b2c92428so728882a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772932; x=1787377732;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=98tl0PJP6gpGLJrzAaOaDQF8wIvsdcZ/BBwkThktPsM=;
 b=SZLXnCyEtfZ6SSDNq0crpTIeslSyxKdy2UPFYbPHT3WqBzQ/44ErZHc0rq2dE0kUDJ
 u6S6amme3561hcoIpetaYHRVK7bD67j85/SKh3JKqNLe/w/95NyYOL2UffrySDGombtC
 q7mnhmW4Gtag8f3IvmtE2I+Y52kso8qXTtXVBmnJnNHLz/mtxnWlb+sBL+BWcSLpuUFY
 sL7UnkJRmp+XlrOlmkcM6kStAFAC5GqRaLav3vKXou7XGtCXaSoT5fRGwwAh+3WxohRc
 Qgbsx2yR4U+kn3kmqQ0NNEmmcQ6ycqDoB4huxM6c8jI0JB0xKmSTeAtQDIIw8WLyh4xW
 HPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772932; x=1787377732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=98tl0PJP6gpGLJrzAaOaDQF8wIvsdcZ/BBwkThktPsM=;
 b=JCEwyWKey4myA3OeQcyZOnrMOiYPzeRyNfRzlQl3mjQfhvOdYm7P77Qzv8RTdbBWQv
 w13QemuJA/sLtxBL7GA26YxlG4AKZANLCXeIhWBjBsRI31ef2oUDygvC8mMmQEfqLtgB
 E/VOR7B8GqwbSNvDiTNdhJ/axs4BSnz8S7tv2/7XO4Gn368IVFBOMHrvwqCRqGOV/a3A
 cHj3oP8FSCYQn3h4MzoO7xTmOvvSZzfkrmfajfrysOMfH7TvYyedwf2m5HMn2N3JhH1B
 0d13//xBmECe9Bh93c5O5reJOlrFsLXtmheEd4NCUObobIjyuzZsKKnp8bmeRT1KQ4Qj
 aWOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RomuR+6y+8Tnzitz4t8QodqzN8akJUQQHvmzfydxnr5VnxxOS6lalYfJW5INqRjSxboiBdHeo4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YykYaIT9Rer2IljRC8X7KJUuOoMCnEUSE2WO+4MOQIfVB0eJ1tU
 3BhY/ZWFg+9WV1ZlqFLb3O32oXisLBG18MF51tA6CuJy8b1UphXXMMXw
X-Gm-Gg: AR+sD10/b1NRmOV2dWhh1AqEfPLJCGMVxcH0UBGpBcUuBO3a4k9jII0y7m3+wDFp3L0
 onNaJUtEOR1UvWlfPE1djI0v3W9AyLfaQbapSeNBqg4TQooL1pc1rM4pS2a2w0Hr+q0Bw4iWIxa
 U/jQ2LGIirOn4KTAGOwcDQCS0kYs5G2OP92oBrEG3SLKa+wyeb98SHPoHWgXW9D3HsA65l9Uleq
 RkyYpxaiRd127U7OjzGOWDi0VbizxXS/F3HCRmspXwuCJBk7WuCtz8wgH7/0UkwVyAG94xb9haI
 tdUgzDl88t9FDcpG1y8wlktHZaD6UtWPtEBlhcliDY9o6pUKXCN+2w76dhS+VcoQIDss2TUyjHJ
 AAihNehNEP2vjarH+lgt1ETMQc6W/MaSJMnfc5c9HkXTKHMIWknSwR6+EOnSScuzzeFJEZCMrHS
 v5A6Z4phnfoKoRr2ppCiKItjKaUTW92Whv4QS3T4JjZAerkt/vWqrEn9uxw4Byy81G0G7FNfiWl
 u/7DP881AQ5UKnMZK6y8yUy98hdB0UStjdtAq2yaUOZ50lOu/Cti3MTA/bQLq+Qk3hqp9+SlcLo
 XCnIG8TXpHYN2Ua8jB49R2vaku8Jf5fh1m8165/EZMiDPwUDF6hNaZqPmfhowRcp1Q3dWKuuxiw
 631yt2/cIE8z37AYb//FUOhoXzoM=
X-Received: by 2002:a05:6830:dc9:b0:7d7:d524:bc88 with SMTP id
 46e09a7af769-7f3de6225e6mr10608189a34.10.1786772931813; 
 Fri, 14 Aug 2026 22:48:51 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:48:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:13 -0600
Subject: [PATCH v8 06/15] crypto: hash: support hardware-only progressive
 hashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-6-fe9212431a94@gmail.com>
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

FIT configuration signatures hash multiple discontiguous regions through
the legacy progressive hash interface. This still requires a software
implementation even when image hashes use a driver-model hardware
provider.

Add provider selection for progressive driver-model hashing and use it
from hash_calculate(). Allow SPL_SHA256_LEGACY to be disabled explicitly,
link the SHA-256 software support only for a selected software backend,
and make legacy fallback paths reject an algorithm whose software
callbacks are absent.

Make a successful driver-model initialization require the complete init,
update, finish and abort lifecycle. Add the abort operation to existing
providers and use it to release a provider context after any update
failure.

Enable DM_HASH in the sandbox configuration so these driver-model
paths are built and exercised by the standard sandbox tests. Extend
the hash provider-selection test to cover progressive initialization
and error cleanup.

This permits SPL to retain SHA-256 FIT support while relying exclusively
on a hardware hash provider.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v7 -> v8:
  - Add an explicit abort operation and release provider contexts after
    update failures  (suggested by Simon Glass)
  - Add the progressive provider-selection and error-cleanup test omitted
    from v7
  - Enable DM_HASH in sandbox so the hash provider tests are built and run
    by normal sandbox CI

Changes v6 -> v7:
  - New patch
---
 boot/image-fit.c                    |   2 +-
 common/hash.c                       |  21 +++++-
 configs/sandbox_defconfig           |   1 +
 drivers/crypto/aspeed/aspeed_hace.c |  18 ++++-
 drivers/crypto/aspeed/cptra_sha.c   |  34 +++++++---
 drivers/crypto/hash/hash-uclass.c   |  44 +++++++++++-
 drivers/crypto/hash/hash_sw.c       |  20 ++++--
 include/u-boot/hash.h               |  30 ++++++++
 lib/Makefile                        |   4 +-
 lib/hash-checksum.c                 |  30 +++++++-
 lib/mbedtls/Kconfig                 |   2 +-
 test/dm/hash.c                      | 132 ++++++++++++++++++++++++++++++++++++
 12 files changed, 312 insertions(+), 26 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 9b39696de2d..86ebf58680d 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1342,7 +1342,7 @@ int calculate_hash(const void *data, int data_len, const char *name,
 #endif
 
 	ret = hash_lookup_algo(name, &algo);
-	if (ret < 0) {
+	if (ret < 0 || !algo->hash_func_ws) {
 		debug("Unsupported hash algorithm\n");
 		return -1;
 	}
diff --git a/common/hash.c b/common/hash.c
index 5cbb4926c1d..8bbf9aa4825 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -38,6 +38,14 @@
 #include <u-boot/md5.h>
 #include <u-boot/sm3.h>
 
+#ifdef USE_HOSTCC
+#define SHA256_SOFTWARE_ENABLED 1
+#else
+#define SHA256_SOFTWARE_ENABLED \
+	(CONFIG_IS_ENABLED(SHA256_LEGACY) || \
+	 CONFIG_IS_ENABLED(SHA256_MBEDTLS))
+#endif
+
 static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
 {
 	sha1_context *ctx = malloc(sizeof(sha1_context));
@@ -65,6 +73,7 @@ static int __maybe_unused hash_finish_sha1(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
+#if SHA256_SOFTWARE_ENABLED
 static int __maybe_unused hash_init_sha256(struct hash_algo *algo, void **ctxp)
 {
 	sha256_context *ctx = malloc(sizeof(sha256_context));
@@ -91,6 +100,7 @@ static int __maybe_unused hash_finish_sha256(struct hash_algo *algo, void *ctx,
 	free(ctx);
 	return 0;
 }
+#endif
 
 static int __maybe_unused hash_init_sha384(struct hash_algo *algo, void **ctxp)
 {
@@ -273,14 +283,14 @@ static struct hash_algo hash_algo[] = {
 		.chunk_size	= CHUNKSZ_SHA256,
 #if CONFIG_IS_ENABLED(SHA_HW_ACCEL)
 		.hash_func_ws	= hw_sha256,
-#else
+#elif SHA256_SOFTWARE_ENABLED
 		.hash_func_ws	= sha256_csum_wd,
 #endif
 #if CONFIG_IS_ENABLED(SHA_PROG_HW_ACCEL)
 		.hash_init	= hw_sha_init,
 		.hash_update	= hw_sha_update,
 		.hash_finish	= hw_sha_finish,
-#else
+#elif SHA256_SOFTWARE_ENABLED
 		.hash_init	= hash_init_sha256,
 		.hash_update	= hash_update_sha256,
 		.hash_finish	= hash_finish_sha256,
@@ -634,6 +644,13 @@ int hash_command(const char *algo_name, int flags, struct cmd_tbl *cmdtp,
 					goto done;
 			}
 		}
+		if (!algo->hash_func_ws) {
+			printf("Hash algorithm '%s' has no available provider\n",
+			       algo_name);
+			unmap_sysmem(buf);
+			free(output);
+			return CMD_RET_FAILURE;
+		}
 		algo->hash_func_ws(buf, len, output, algo->chunk_size);
 done:
 		unmap_sysmem(buf);
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 79f46317e45..1d9542f815d 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -198,6 +198,7 @@ CONFIG_CLK_K210_SET_RATE=y
 CONFIG_SANDBOX_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_CPU=y
+CONFIG_DM_HASH=y
 CONFIG_DM_AES=y
 CONFIG_AES_SOFTWARE=y
 CONFIG_DM_DEMO=y
diff --git a/drivers/crypto/aspeed/aspeed_hace.c b/drivers/crypto/aspeed/aspeed_hace.c
index 2469f53472f..3be1809c89e 100644
--- a/drivers/crypto/aspeed/aspeed_hace.c
+++ b/drivers/crypto/aspeed/aspeed_hace.c
@@ -205,6 +205,13 @@ static int aspeed_hace_update(struct udevice *dev, void *ctx, const void *ibuf,
 	return 0;
 }
 
+static int aspeed_hace_abort(struct udevice *dev, void *ctx)
+{
+	free(ctx);
+
+	return 0;
+}
+
 static int aspeed_hace_finish(struct udevice *dev, void *ctx, void *obuf)
 {
 	int rc = 0;
@@ -269,7 +276,7 @@ static int aspeed_hace_finish(struct udevice *dev, void *ctx, void *obuf)
 	memcpy(obuf, hace_ctx->digest, hash_algo_digest_size(hace_ctx->algo));
 
 free_n_out:
-	free(ctx);
+	aspeed_hace_abort(dev, ctx);
 
 	return rc;
 }
@@ -297,16 +304,20 @@ static int aspeed_hace_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
 				chunk = chunk_sz;
 
 			rc = aspeed_hace_update(dev, ctx, cur, chunk);
-			if (rc)
+			if (rc) {
+				aspeed_hace_abort(dev, ctx);
 				return rc;
+			}
 
 			cur += chunk;
 			schedule();
 		}
 	} else {
 		rc = aspeed_hace_update(dev, ctx, ibuf, ilen);
-		if (rc)
+		if (rc) {
+			aspeed_hace_abort(dev, ctx);
 			return rc;
+		}
 	}
 
 	rc = aspeed_hace_finish(dev, ctx, obuf);
@@ -359,6 +370,7 @@ static const struct hash_ops aspeed_hace_ops = {
 	.hash_init = aspeed_hace_init,
 	.hash_update = aspeed_hace_update,
 	.hash_finish = aspeed_hace_finish,
+	.hash_abort = aspeed_hace_abort,
 	.hash_digest_wd = aspeed_hace_digest_wd,
 	.hash_digest = aspeed_hace_digest,
 };
diff --git a/drivers/crypto/aspeed/cptra_sha.c b/drivers/crypto/aspeed/cptra_sha.c
index 0dc00f306f1..72ea3860eb5 100644
--- a/drivers/crypto/aspeed/cptra_sha.c
+++ b/drivers/crypto/aspeed/cptra_sha.c
@@ -75,8 +75,11 @@ static int cptra_sha_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
 	cs = dev_get_priv(dev);
 
 	/* get CPTRA SHA lock */
-	if (readl_poll_timeout(cs->regs + CPTRA_SHA_LOCK, reg, reg == 0, 1000000))
-		return -EBUSY;
+	if (readl_poll_timeout(cs->regs + CPTRA_SHA_LOCK, reg, reg == 0,
+			       1000000)) {
+		rc = -EBUSY;
+		goto free_n_out;
+	}
 
 	/* zero clear SHA */
 	writel(CPTRA_SHA_CTRL_ZEROIZE, cs->regs + CPTRA_SHA_CTRL);
@@ -133,6 +136,17 @@ static int cptra_sha_update(struct udevice *dev, void *ctx, const void *ibuf, ui
 	return 0;
 }
 
+static int cptra_sha_abort(struct udevice *dev, void *ctx)
+{
+	struct cptra_sha *cs = dev_get_priv(dev);
+
+	writel(CPTRA_SHA_CTRL_ZEROIZE, cs->regs + CPTRA_SHA_CTRL);
+	writel(0x1, cs->regs + CPTRA_SHA_LOCK);
+	free(ctx);
+
+	return 0;
+}
+
 static int cptra_sha_finish(struct udevice *dev, void *ctx, void *obuf)
 {
 	struct cptra_sha_ctx *cs_ctx;
@@ -158,12 +172,7 @@ static int cptra_sha_finish(struct udevice *dev, void *ctx, void *obuf)
 	for (i = 0; i < (cs_ctx->dgst_len / sizeof(*p32)); ++i, p32++)
 		*p32 = be32_to_cpu(readl(cs->regs + CPTRA_SHA_DIGEST(i)));
 
-	/* release CPTRA SHA lock */
-	writel(0x1, cs->regs + CPTRA_SHA_LOCK);
-
-	free(cs_ctx);
-
-	return 0;
+	return cptra_sha_abort(dev, ctx);
 }
 
 static int cptra_sha_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
@@ -189,16 +198,20 @@ static int cptra_sha_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
 				chunk = chunk_sz;
 
 			rc = cptra_sha_update(dev, ctx, cur, chunk);
-			if (rc)
+			if (rc) {
+				cptra_sha_abort(dev, ctx);
 				return rc;
+			}
 
 			cur += chunk;
 			schedule();
 		}
 	} else {
 		rc = cptra_sha_update(dev, ctx, ibuf, ilen);
-		if (rc)
+		if (rc) {
+			cptra_sha_abort(dev, ctx);
 			return rc;
+		}
 	}
 
 	rc = cptra_sha_finish(dev, ctx, obuf);
@@ -237,6 +250,7 @@ static const struct hash_ops cptra_sha_ops = {
 	.hash_init = cptra_sha_init,
 	.hash_update = cptra_sha_update,
 	.hash_finish = cptra_sha_finish,
+	.hash_abort = cptra_sha_abort,
 	.hash_digest_wd = cptra_sha_digest_wd,
 	.hash_digest = cptra_sha_digest,
 };
diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/hash-uclass.c
index ffca19af2de..0340eecf3f6 100644
--- a/drivers/crypto/hash/hash-uclass.c
+++ b/drivers/crypto/hash/hash-uclass.c
@@ -119,11 +119,43 @@ int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
 	return found ? -EOPNOTSUPP : -ENODEV;
 }
 
+int hash_init_lookup(enum HASH_ALGO algo, struct udevice **devp, void **ctxp)
+{
+	struct udevice *dev;
+	int first_probe_err = 0;
+	bool found = false;
+	int ret;
+
+	for (ret = uclass_first_device_check(UCLASS_HASH, &dev); dev;
+	     ret = uclass_next_device_check(&dev)) {
+		found = true;
+		if (ret) {
+			if (!first_probe_err)
+				first_probe_err = ret;
+			continue;
+		}
+
+		ret = hash_init(dev, algo, ctxp);
+		if (!ret) {
+			*devp = dev;
+			return 0;
+		}
+		if (!hash_op_unsupported(ret))
+			return ret;
+	}
+
+	if (first_probe_err)
+		return first_probe_err;
+
+	return found ? -EOPNOTSUPP : -ENODEV;
+}
+
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
 {
 	struct hash_ops *ops = (struct hash_ops *)device_get_ops(dev);
 
-	if (!ops->hash_init)
+	if (!ops->hash_init || !ops->hash_update || !ops->hash_finish ||
+	    !ops->hash_abort)
 		return -ENOSYS;
 
 	return ops->hash_init(dev, algo, ctxp);
@@ -149,6 +181,16 @@ int hash_finish(struct udevice *dev, void *ctx, void *obuf)
 	return ops->hash_finish(dev, ctx, obuf);
 }
 
+int hash_abort(struct udevice *dev, void *ctx)
+{
+	struct hash_ops *ops = (struct hash_ops *)device_get_ops(dev);
+
+	if (!ops->hash_abort)
+		return -ENOSYS;
+
+	return ops->hash_abort(dev, ctx);
+}
+
 UCLASS_DRIVER(hash) = {
 	.id	= UCLASS_HASH,
 	.name	= "hash",
diff --git a/drivers/crypto/hash/hash_sw.c b/drivers/crypto/hash/hash_sw.c
index 4590e225481..63a775d904f 100644
--- a/drivers/crypto/hash/hash_sw.c
+++ b/drivers/crypto/hash/hash_sw.c
@@ -218,6 +218,13 @@ static int sw_hash_update(struct udevice *dev, void *ctx, const void *ibuf, uint
 	return 0;
 }
 
+static int sw_hash_abort(struct udevice *dev, void *ctx)
+{
+	free(ctx);
+
+	return 0;
+}
+
 static int sw_hash_finish(struct udevice *dev, void *ctx, void *obuf)
 {
 	struct sw_hash_ctx *hash_ctx = ctx;
@@ -225,9 +232,7 @@ static int sw_hash_finish(struct udevice *dev, void *ctx, void *obuf)
 
 	hash_impl->finish(hash_ctx->algo_ctx, obuf);
 
-	free(ctx);
-
-	return 0;
+	return sw_hash_abort(dev, ctx);
 }
 
 static int sw_hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
@@ -253,16 +258,20 @@ static int sw_hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
 				chunk = chunk_sz;
 
 			rc = sw_hash_update(dev, ctx, cur, chunk);
-			if (rc)
+			if (rc) {
+				sw_hash_abort(dev, ctx);
 				return rc;
+			}
 
 			cur += chunk;
 			schedule();
 		}
 	} else {
 		rc = sw_hash_update(dev, ctx, ibuf, ilen);
-		if (rc)
+		if (rc) {
+			sw_hash_abort(dev, ctx);
 			return rc;
+		}
 	}
 
 	rc = sw_hash_finish(dev, ctx, obuf);
@@ -284,6 +293,7 @@ static const struct hash_ops hash_ops_sw = {
 	.hash_init = sw_hash_init,
 	.hash_update = sw_hash_update,
 	.hash_finish = sw_hash_finish,
+	.hash_abort = sw_hash_abort,
 	.hash_digest_wd = sw_hash_digest_wd,
 	.hash_digest = sw_hash_digest,
 };
diff --git a/include/u-boot/hash.h b/include/u-boot/hash.h
index 7dba66047f5..f07363845e3 100644
--- a/include/u-boot/hash.h
+++ b/include/u-boot/hash.h
@@ -51,10 +51,39 @@ int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
  */
 int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
 			  const u32 ilen, void *obuf, u32 chunk_sz);
+/**
+ * hash_init_lookup() - Start hashing with the first supporting provider
+ *
+ * Probe each hash device in order and initialize the first one which supports
+ * @algo. The selected device is returned for the matching update and finish
+ * operations.
+ *
+ * @algo: Hash algorithm
+ * @devp: Returns the selected hash device
+ * @ctxp: Returns the provider's progressive-hash context
+ * Return: 0 on success, -ENODEV if there are no providers, -EOPNOTSUPP if no
+ * provider supports @algo, or another negative error from a provider
+ */
+int hash_init_lookup(enum HASH_ALGO algo, struct udevice **devp, void **ctxp);
+
+/*
+ * A successful hash_init() returns a context which must be consumed by
+ * exactly one hash_finish() or hash_abort() call. Both operations release all
+ * provider resources, including when they return an error.
+ */
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp);
 int hash_update(struct udevice *dev, void *ctx, const void *ibuf, const uint32_t ilen);
 int hash_finish(struct udevice *dev, void *ctx, void *obuf);
 
+/**
+ * hash_abort() - Discard a progressive hash operation
+ *
+ * @dev: Hash device selected by hash_init() or hash_init_lookup()
+ * @ctx: Progressive-hash context to release
+ * Return: 0 on success, or a negative provider error
+ */
+int hash_abort(struct udevice *dev, void *ctx);
+
 /*
  * struct hash_ops - Driver model for Hash operations
  *
@@ -66,6 +95,7 @@ struct hash_ops {
 	int (*hash_init)(struct udevice *dev, enum HASH_ALGO algo, void **ctxp);
 	int (*hash_update)(struct udevice *dev, void *ctx, const void *ibuf, const uint32_t ilen);
 	int (*hash_finish)(struct udevice *dev, void *ctx, void *obuf);
+	int (*hash_abort)(struct udevice *dev, void *ctx);
 
 	/* all-in-one operation */
 	int (*hash_digest)(struct udevice *dev, enum HASH_ALGO algo,
diff --git a/lib/Makefile b/lib/Makefile
index 222378a8531..777c48a5728 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -79,8 +79,8 @@ obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
 
 obj-$(CONFIG_$(PHASE_)MD5_LEGACY) += md5.o
 obj-$(CONFIG_$(PHASE_)SHA1_LEGACY) += sha1.o
-obj-$(CONFIG_$(PHASE_)SHA256) += sha256_common.o
-obj-$(CONFIG_$(PHASE_)SHA256_LEGACY) += sha256.o
+obj-$(CONFIG_$(PHASE_)SHA256_LEGACY) += sha256_common.o sha256.o
+obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256_common.o
 obj-$(CONFIG_$(PHASE_)SHA512_LEGACY) += sha512.o
 obj-$(CONFIG_$(PHASE_)SM3) += sm3.o
 
diff --git a/lib/hash-checksum.c b/lib/hash-checksum.c
index 1970a741294..e3e7f6adb7f 100644
--- a/lib/hash-checksum.c
+++ b/lib/hash-checksum.c
@@ -4,11 +4,13 @@
  */
 
 #ifndef USE_HOSTCC
+#include <dm.h>
 #include <fdtdec.h>
 #include <asm/byteorder.h>
 #include <linux/errno.h>
 #include <asm/unaligned.h>
 #include <hash.h>
+#include <u-boot/hash.h>
 #else
 #include "fdt_host.h"
 #endif
@@ -20,13 +22,39 @@ int hash_calculate(const char *name,
 		    int region_count, uint8_t *checksum)
 {
 	struct hash_algo *algo;
-	int ret = 0;
+	int ret;
 	void *ctx;
 	int i;
 
 	if (region_count < 1)
 		return -EINVAL;
 
+#ifndef USE_HOSTCC
+	if (CONFIG_IS_ENABLED(DM_HASH)) {
+		enum HASH_ALGO hash_algo = hash_algo_lookup_by_name(name);
+		struct udevice *dev;
+
+		if (hash_algo != HASH_ALGO_INVALID)
+			ret = hash_init_lookup(hash_algo, &dev, &ctx);
+		else
+			ret = -EOPNOTSUPP;
+		if (!ret) {
+			for (i = 0; i < region_count; i++) {
+				ret = hash_update(dev, ctx, region[i].data,
+						  region[i].size);
+				if (ret) {
+					hash_abort(dev, ctx);
+					return ret;
+				}
+			}
+
+			return hash_finish(dev, ctx, checksum);
+		}
+		if (ret != -ENODEV && ret != -EOPNOTSUPP)
+			return ret;
+	}
+#endif
+
 	ret = hash_progressive_lookup_algo(name, &algo);
 	if (ret)
 		return ret;
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..a805b1d4a48 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -335,7 +335,7 @@ config SPL_LEGACY_HASHING
 	bool "Use U-Boot legacy hashing libraries (SPL)"
 	select SPL_MD5_LEGACY if SPL_MD5
 	select SPL_SHA1_LEGACY if SPL_SHA1
-	select SPL_SHA256_LEGACY if SPL_SHA256
+	imply SPL_SHA256_LEGACY if SPL_SHA256
 	select SPL_SHA512_LEGACY if SPL_SHA512
 	select SPL_SHA384_LEGACY if SPL_SHA384
 	help
diff --git a/test/dm/hash.c b/test/dm/hash.c
index fe949e33de5..b5ab80d0525 100644
--- a/test/dm/hash.c
+++ b/test/dm/hash.c
@@ -10,13 +10,83 @@
 #include <dm/root.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <image.h>
 #include <u-boot/hash.h>
+#include <u-boot/hash-checksum.h>
 #include <test/test.h>
 #include <test/ut.h>
 
 static int unsupported_calls;
 static int success_calls;
 static int hard_error_calls;
+static int unsupported_init_calls;
+static int success_init_calls;
+static int hard_error_init_calls;
+static int update_error_calls;
+static int finish_calls;
+static int abort_calls;
+
+static int hash_test_unsupported_init(struct udevice *dev,
+				      enum HASH_ALGO algo, void **ctxp)
+{
+	unsupported_init_calls++;
+
+	return -EOPNOTSUPP;
+}
+
+static int hash_test_success_init(struct udevice *dev, enum HASH_ALGO algo,
+				  void **ctxp)
+{
+	success_init_calls++;
+	*ctxp = dev;
+
+	return 0;
+}
+
+static int hash_test_hard_error_init(struct udevice *dev,
+				     enum HASH_ALGO algo, void **ctxp)
+{
+	hard_error_init_calls++;
+
+	return -EINVAL;
+}
+
+static int hash_test_update_error_init(struct udevice *dev,
+				       enum HASH_ALGO algo, void **ctxp)
+{
+	*ctxp = dev;
+
+	return 0;
+}
+
+static int hash_test_progressive_update(struct udevice *dev, void *ctx,
+					const void *ibuf, u32 ilen)
+{
+	return 0;
+}
+
+static int hash_test_update_error(struct udevice *dev, void *ctx,
+				  const void *ibuf, u32 ilen)
+{
+	update_error_calls++;
+
+	return -EIO;
+}
+
+static int hash_test_progressive_finish(struct udevice *dev, void *ctx,
+					void *obuf)
+{
+	finish_calls++;
+
+	return 0;
+}
+
+static int hash_test_progressive_abort(struct udevice *dev, void *ctx)
+{
+	abort_calls++;
+
+	return 0;
+}
 
 static int hash_test_unsupported(struct udevice *dev, enum HASH_ALGO algo,
 				 const void *ibuf, const uint32_t ilen,
@@ -47,17 +117,36 @@ static int hash_test_hard_error(struct udevice *dev, enum HASH_ALGO algo,
 }
 
 static const struct hash_ops hash_test_unsupported_ops = {
+	.hash_init = hash_test_unsupported_init,
+	.hash_update = hash_test_progressive_update,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_abort = hash_test_progressive_abort,
 	.hash_digest_wd = hash_test_unsupported,
 };
 
 static const struct hash_ops hash_test_success_ops = {
+	.hash_init = hash_test_success_init,
+	.hash_update = hash_test_progressive_update,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_abort = hash_test_progressive_abort,
 	.hash_digest_wd = hash_test_success,
 };
 
 static const struct hash_ops hash_test_hard_error_ops = {
+	.hash_init = hash_test_hard_error_init,
+	.hash_update = hash_test_progressive_update,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_abort = hash_test_progressive_abort,
 	.hash_digest_wd = hash_test_hard_error,
 };
 
+static const struct hash_ops hash_test_update_error_ops = {
+	.hash_init = hash_test_update_error_init,
+	.hash_update = hash_test_update_error,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_abort = hash_test_progressive_abort,
+};
+
 U_BOOT_DRIVER(hash_test_unsupported_drv) = {
 	.name = "hash_test_unsupported",
 	.id = UCLASS_HASH,
@@ -76,6 +165,12 @@ U_BOOT_DRIVER(hash_test_hard_error_drv) = {
 	.ops = &hash_test_hard_error_ops,
 };
 
+U_BOOT_DRIVER(hash_test_update_error_drv) = {
+	.name = "hash_test_update_error",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_update_error_ops,
+};
+
 static int hash_test_unbind_all(void)
 {
 	struct udevice *dev;
@@ -105,7 +200,13 @@ static int hash_test_bind(const struct driver *drv, const char *name)
 
 static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 {
+	const struct image_region region = {
+		.data = "test",
+		.size = 4,
+	};
+	struct udevice *dev;
 	u8 digest[32];
+	void *ctx;
 	int ret;
 
 	ut_assertok(hash_test_unbind_all());
@@ -124,6 +225,18 @@ static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 	for (int i = 0; i < sizeof(digest); i++)
 		ut_asserteq(0x5a, digest[i]);
 
+	unsupported_init_calls = 0;
+	success_init_calls = 0;
+	ret = hash_init_lookup(HASH_ALGO_SHA256, &dev, &ctx);
+	ut_assertok(ret);
+	ut_asserteq(1, unsupported_init_calls);
+	ut_asserteq(1, success_init_calls);
+	ut_asserteq_str("hash-success", dev->name);
+	ut_asserteq_ptr(dev, ctx);
+	abort_calls = 0;
+	ut_assertok(hash_abort(dev, ctx));
+	ut_asserteq(1, abort_calls);
+
 	ut_assertok(hash_test_unbind_all());
 	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_hard_error_drv),
 				   "hash-hard-error"));
@@ -137,6 +250,25 @@ static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 	ut_asserteq(1, hard_error_calls);
 	ut_asserteq(0, success_calls);
 
+	hard_error_init_calls = 0;
+	success_init_calls = 0;
+	ret = hash_init_lookup(HASH_ALGO_SHA256, &dev, &ctx);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(1, hard_error_init_calls);
+	ut_asserteq(0, success_init_calls);
+
+	ut_assertok(hash_test_unbind_all());
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_update_error_drv),
+				   "hash-update-error"));
+	update_error_calls = 0;
+	finish_calls = 0;
+	abort_calls = 0;
+	ret = hash_calculate("sha256", &region, 1, digest);
+	ut_asserteq(-EIO, ret);
+	ut_asserteq(1, update_error_calls);
+	ut_asserteq(0, finish_calls);
+	ut_asserteq(1, abort_calls);
+
 	return 0;
 }
 

-- 
2.53.0

