Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E877C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43E8340CF8;
	Thu, 13 Aug 2026 20:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKAUE7SSu8Nu; Thu, 13 Aug 2026 20:17:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C56740CF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652273;
	bh=E3h6PWU3nOzfJlM1BD2VRPWSXEZfFZnPVjBp9n9d5wY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=npVctktODVEz9NwrLQv9WIOSpWh+5SUmEO5v6BdvtRK5yHyERvA4fATlPKXuEdsuh
	 qoIRLPT4sr9rmiZhKtHo2HIeIm2aO108bXESkxeGmAFE8HFCk5B1blOngRVPhypGNZ
	 WWZCvBW7wieGgfcEb3jEB8KogroiS1O4p7zG5L0MhGv8jZkxOWWP4vYuWITquBPH/6
	 pui+lgJWBJarTlSPGIa9VkSRHlL0NVH3LYuv+ViPZ26rZQ4LPw261Y/vKRpHHHjE5e
	 YPKxy3fBf59G3VOZM66k1GNcRZxWUmsKBHlwJbD/5cE5TFtNGw/JZbFx+SU8aboZVo
	 6BThjQ0kq7F8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C56740CF9;
	Thu, 13 Aug 2026 20:17:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 92805194
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8434580B39
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KyKpOOe3H3IL for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6F86280AA2
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F86280AA2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NNkVsUxp
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F86280AA2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:22 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-455ca262ccbso197127fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651161; x=1787255961;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E3h6PWU3nOzfJlM1BD2VRPWSXEZfFZnPVjBp9n9d5wY=;
 b=NNkVsUxphS81KqKoCR1fzZoNTW50HGchQxHLuE0nc70mu0KUZcle4u2ILVqk5MYhoH
 7BHxxXS6MzydkViuQ31bQLUqn2NTXMWFhzcaV+lpDbiBNd2CP0HhLMpewYHfMYabsQtd
 0CtV1Wm8+zro9GLCvG/HNBOLUl2mfUJ1YhDh7wY9aY93VkLFlHbfDHYqOfmViVwAAeZ8
 ccCE3dhUA90QfI/xFcP4dEowEATFEixiYbZMcfXo56e0JGDy9J2a3M7Sa5NeKVUSJxpZ
 xTv/T4fUQ4K3uGjRVUBKJDUF4Hxqk/VDEA57FO92Z3TJlpUzKUkitBRV/CiFArCucHpH
 eq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651161; x=1787255961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E3h6PWU3nOzfJlM1BD2VRPWSXEZfFZnPVjBp9n9d5wY=;
 b=XLZuLjuA8r5RYKwtBnHvQsuSxdreWSEwVXP59smZnCBb3Hr0ueA7S0eUftyDQ/1MG8
 nfbVlTtZTStblmP88h+KhqUiEeLC0EWN2oKhnaD8sRjYox+a1O8BIqFMABRSm3NQx2mp
 GWHYzxhkkmtoybnorLQqEJFcv2g0CPh6vM5XWYMW1tjpEs5X7ZNz/dCfb4T9S8nit2nx
 9D9ucfOvdYoHk4ahHfR6CfYP1Em22woqx+BrnxuDM4uFz+M9es+YXM0XFJuGM6u7hd4A
 mIaOGe/Od2kt6bI2n5+6O+ehgIqI1CyaLZZrRTwvX5y7TDQlB+WHPRVbTxuFtQKP4qiv
 wq7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbdKZTGVf6RYe+3gIf3XAmaVGKQPgp7zXuH8qf0MnzK2Z5Q0q4kxgiULA1pSYf18G1q+cZ4xs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwVN9qFFSmJa74I6pLqtpLpbxlMk2f/4E8ygWLyguOOBGT3EKqg
 HjhnTdNnYAm9FBMYhQ3Cmbi+KmGQNgaL+BZMVqMBsGXU+nDaTlymC9IX
X-Gm-Gg: AR+sD13EUrl87hdF0a4B8TZtY29eLkxMWfSimG3xXKWHYpO+NLfmMGegLL1reBJjgTD
 nzaGaNfK5oriC+53C3uezF6km8N94piiltEdDA03UFkyvkDAp61BXYbksyZXAuDyNvNDYSBDk1T
 q9cRyv+qUO9AJ+Xq+cdQvuIaN7wMZbqMcZVCm2DcZt3V6s3mXr0cu1inF96CdDphBtuFhFkDd2P
 eqgXFH1bNae5ZyVrTxG2Q3g3MTqa66sNpePH2hDA1wNHCatRCyd/jB0VOcfcIdz9Ig6gk6qCI2E
 fogBzqgf0HlMP2VBK3dYHIxlOyupWhSiYfWzNhkUwSu6JWLOxz/skEBjpq1Xhs6Qv8jr6cMqkg/
 rVy/Sxz5xTVWAlS4IgJIJ2so88ohPUR2PhWP+12OW+roe7wKVb4CmjOLl2vhYUEZQTI0m9dnfm5
 S7ehwyk19jUTWkUnjHKd3KOYj2naE/OsrU36oNrch6bqGvMOZiyz/ri1iC7QotgyXMulc3nYDpa
 XPCZArW0v3fvW0QPoh4uCYkrzWQgAysV/1n8rWl5RVZUgFfqyC2+Bzx8Phpw5QBaHp+00+Vu2gE
 FxA4uDOcAMj2hJKzeHUCwFxDXOI3Nj+N5muHBxNzPtV8fjcCpaEpxooUIBMwV/Yd8Rk2AZ/AEJB
 owYL1cwa283Dra0O8rpljmGTtOk4=
X-Received: by 2002:a05:6820:200f:b0:6ae:9b39:68ce with SMTP id
 006d021491bc7-6b0d6ed1e24mr842304eaf.24.1786651161167; 
 Thu, 13 Aug 2026 12:59:21 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:58:59 -0600
Subject: [PATCH v7 06/15] crypto: hash: support hardware-only progressive
 hashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-6-593fcd8479fd@gmail.com>
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

FIT configuration signatures hash multiple discontiguous regions through
the legacy progressive hash interface. This still requires a software
implementation even when image hashes use a driver-model hardware
provider.

Add provider selection for progressive driver-model hashing and use it
from hash_calculate(). Allow SPL_SHA256_LEGACY to be disabled explicitly,
link the SHA-256 software support only for a selected software backend,
and make legacy fallback paths reject an algorithm whose software
callbacks are absent.

Extend the hash provider-selection test to cover progressive
initialization.

This permits SPL to retain SHA-256 FIT support while relying exclusively
on a hardware hash provider.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - New patch
---
 boot/image-fit.c                  |  2 +-
 common/hash.c                     | 21 +++++++++++++++--
 drivers/crypto/hash/hash-uclass.c | 31 +++++++++++++++++++++++++
 include/u-boot/hash.h             | 14 +++++++++++
 lib/Makefile                      |  4 ++--
 lib/hash-checksum.c               | 28 +++++++++++++++++++++-
 lib/mbedtls/Kconfig               |  2 +-
 test/dm/hash.c                    | 49 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 144 insertions(+), 7 deletions(-)

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
diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/hash-uclass.c
index ffca19af2de..81828e45f69 100644
--- a/drivers/crypto/hash/hash-uclass.c
+++ b/drivers/crypto/hash/hash-uclass.c
@@ -119,6 +119,37 @@ int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
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
diff --git a/include/u-boot/hash.h b/include/u-boot/hash.h
index 7dba66047f5..065c6f96830 100644
--- a/include/u-boot/hash.h
+++ b/include/u-boot/hash.h
@@ -51,6 +51,20 @@ int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
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
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp);
 int hash_update(struct udevice *dev, void *ctx, const void *ibuf, const uint32_t ilen);
 int hash_finish(struct udevice *dev, void *ctx, void *obuf);
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
index 1970a741294..afd4dbfc343 100644
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
@@ -20,13 +22,37 @@ int hash_calculate(const char *name,
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
+				if (ret)
+					return ret;
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
index fe949e33de5..fe0a617ef3a 100644
--- a/test/dm/hash.c
+++ b/test/dm/hash.c
@@ -17,6 +17,34 @@
 static int unsupported_calls;
 static int success_calls;
 static int hard_error_calls;
+static int unsupported_init_calls;
+static int success_init_calls;
+static int hard_error_init_calls;
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
 
 static int hash_test_unsupported(struct udevice *dev, enum HASH_ALGO algo,
 				 const void *ibuf, const uint32_t ilen,
@@ -47,14 +75,17 @@ static int hash_test_hard_error(struct udevice *dev, enum HASH_ALGO algo,
 }
 
 static const struct hash_ops hash_test_unsupported_ops = {
+	.hash_init = hash_test_unsupported_init,
 	.hash_digest_wd = hash_test_unsupported,
 };
 
 static const struct hash_ops hash_test_success_ops = {
+	.hash_init = hash_test_success_init,
 	.hash_digest_wd = hash_test_success,
 };
 
 static const struct hash_ops hash_test_hard_error_ops = {
+	.hash_init = hash_test_hard_error_init,
 	.hash_digest_wd = hash_test_hard_error,
 };
 
@@ -105,7 +136,9 @@ static int hash_test_bind(const struct driver *drv, const char *name)
 
 static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 {
+	struct udevice *dev;
 	u8 digest[32];
+	void *ctx;
 	int ret;
 
 	ut_assertok(hash_test_unbind_all());
@@ -124,6 +157,15 @@ static int dm_test_hash_provider_selection(struct unit_test_state *uts)
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
+
 	ut_assertok(hash_test_unbind_all());
 	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_hard_error_drv),
 				   "hash-hard-error"));
@@ -137,6 +179,13 @@ static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 	ut_asserteq(1, hard_error_calls);
 	ut_asserteq(0, success_calls);
 
+	hard_error_init_calls = 0;
+	success_init_calls = 0;
+	ret = hash_init_lookup(HASH_ALGO_SHA256, &dev, &ctx);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(1, hard_error_init_calls);
+	ut_asserteq(0, success_init_calls);
+
 	return 0;
 }
 

-- 
2.53.0

