Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2463AC5DF6A
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 729F781449;
	Thu, 13 Aug 2026 20:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rua5OjPDsJLO; Thu, 13 Aug 2026 20:17:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8544B81446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652269;
	bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/7YhUphjDyX2i3gKCbNyYlaS4qRiMQ6qcCoPtXbbNtQJkDmOn9vLGKGdx9VtqT2g
	 qjEk/K21YwZOnPbIlKxcy3d61oeZpe3hMoo2ASDpNdbb0+pR1oJLgbq+kXfYnLKEyE
	 jS2WlRUO+/Mqh9JRQ/UWAiA1v2Q97qEY5StLCipgorMRfnnALNfXsV1exWo+YPRO3S
	 QPSZVQO4dqhzSi+RojAO5EUBBWPkIGBI5b3mSCaMkzQXYtrJw8c/q4bJsB4i0Fd2Fi
	 yR6nXU4ajjaeBkVSuZbzjT1ZYFYlHSVPL76pMggbVZmCtNnAX1Ndovrz+MY1zxhcCz
	 lCwl4GSUu+oEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8544B81446;
	Thu, 13 Aug 2026 20:17:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5747333B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 555BF80AA2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NuhQhDfJxKke for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7969F80B40
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7969F80B40
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VOLiXu32
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7969F80B40
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:18 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6b0ab918216so185446eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651157; x=1787255957;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
 b=VOLiXu326IpvN45Ki+6E1sDSP1DdDXalragcy0wtwZgg7Vf6DdFiMY86CrsfDswQyr
 r1KaAg195TVhk1D++7+LUvtFVVXd/id0VUbS4eyvpOYR6gy+Sjc7KVoPcXzfFelylOht
 zQEl9hNLWeqgdxVEV/6MnKvOAxxfHPL9Eu0brquMugpoVteadqw+CFYXfFboyCLxQVrg
 dJuyMxLS+nh/jlCRAdYdpnUDYKHPzKaHuCNLRCxKZebzD7L57amOUTIaJyvgyFFtm/i2
 LYJvm9DXubaASUsT8Y/c9mf14Jc71WUz+SiAxll4FjRWtqTy5xOu72IDP7sBMXUrnNaT
 CaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651157; x=1787255957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
 b=A5655g7XEjK7vwIfiItopLSixjXkeYWEAKP98FG+cjdR14GfmHPUtCbP+UMIgRc0dw
 nsTv6i4bmxSaV+CbCA/j6bQr1gfAwOtTfmn4Lpz2mBiVh7Cb18bkP9Bu7RVOFUyWACfa
 9+rwOtopE3f+SkgBeb7g5IOWkEJkZO3i27ZlYrJDKl3FahuEQERzXpoOxIq5BYzmdv6f
 yEcYerSTn0QCdg7x8cisMCTjgT/v34F4LHJXCake5urgFhXxvcED9yDYmBUFeAj1GLWz
 T2kTR6Uq0OIx4bMdDrJ5jJM0H8Mmx3KEp7PRh5ATQ1psj5Jj7vRBz2P3E7kxMJXKCqJl
 /CRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU+ueBKdaVuI1XQddczsT6XXdO112O6vAEr1qPv/hmme9qxKquCaMLB7lRq8BBNRcnH9CzRC4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywbjcz7UQzqXvwkv6GdCmFQo4LUzXwzlDQD9+9eP14WTeA6mDye
 wLhIrgNb+0ym6ieQy0vMEo8U/WYXJhN6seuwJrzV2/pVY0umC+cBbuDa
X-Gm-Gg: AR+sD10noxab9Sq5K7T+XAFijGErEwQ3/z0HbJfagw4nduHIuEeGCqq+S+4t122t272
 mWj/+R0teuW0DseFGbsAgliUKcaB20aZCjHKv7iXJxKuFsClDd40I5L+Su2bj8PqhLDPim6rMls
 06YHo2dBiVkYQzbe0mDKHFCf2dTG1yw6OhrhyMYJxFBanATnt7tPLVCMecPpaFTg4lPBhWZdKNZ
 opwEVSJDBAzTBJmAykQSMPinwT9/U4XaqVUsaMt6TPTL2zfmHfGxhCj3Tzlt2Dm/Rpf1pfP+GIb
 9XXKq8YIbF82pkRJKsFK4BkxJG8d1T8/tZL+W6UeSzno2XEQihi1WcfYIWYHVtbKzz0uKx704fj
 VTyNvSf4jKnDB4Jw0BV+r4QxZOl6559wI60tm83HHfiJveum2UTPMT5CB/rS97Pi7ChmLw0NeOa
 oiV6BFspXWFpjY/5x8Pgosc8hcG1P50B02EQdnEANqQfEu1gAKUUI8TfMjAkd6dtcmfHEPZfLEt
 czxglY/pUm8HnneVpm37OEWxligNK0XopjRIEL4D6TiqogPJqIf9al/7OxjsFj1W2k74fPMOLXS
 tnbNsLKIb1Ao5cR7JGMiY+Tt4ArCf+rUunWxj5JLS4QiWy+/x3TuzRarMIcJSCA/MH2SyMxWzpS
 L3Tw83JxuX+LR/553
X-Received: by 2002:a05:6820:f02d:b0:6a3:7e24:a7f6 with SMTP id
 006d021491bc7-6b0d68c83a3mr790500eaf.22.1786651157366; 
 Thu, 13 Aug 2026 12:59:17 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:58:57 -0600
Subject: [PATCH v7 04/15] boot: image: try all DM hash providers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-4-593fcd8479fd@gmail.com>
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

FIT hash calculation currently selects UCLASS_HASH device zero directly,
so a provider which does not implement the requested algorithm prevents a
later capable provider from being used. It also turns every provider error
into the same generic FIT hash failure.

Use the common hash provider-selection helper. Fall back to the configured
software implementation only when no DM provider supports the algorithm,
and preserve probe and digest failures from providers which accept it.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - New patch
---
 boot/image-fit.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index d7d7c70fe76..9b39696de2d 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1322,30 +1322,22 @@ int calculate_hash(const void *data, int data_len, const char *name,
 #ifndef USE_HOSTCC
 	int rc;
 	enum HASH_ALGO hash_algo;
-	struct udevice *dev;
 
 	if (CONFIG_IS_ENABLED(DM_HASH)) {
-		rc = uclass_get_device(UCLASS_HASH, 0, &dev);
-		if (rc) {
-			debug("failed to get hash device, rc=%d\n", rc);
-			return -1;
-		}
-
 		hash_algo = hash_algo_lookup_by_name(name);
-		if (hash_algo == HASH_ALGO_INVALID) {
-			debug("Unsupported hash algorithm\n");
-			return -1;
+		if (hash_algo != HASH_ALGO_INVALID)
+			rc = hash_digest_wd_lookup(hash_algo, data, data_len,
+						   value, CHUNKSZ);
+		else
+			rc = -EOPNOTSUPP;
+		if (!rc) {
+			*value_len = hash_algo_digest_size(hash_algo);
+			return 0;
 		}
-
-		rc = hash_digest_wd(dev, hash_algo, data, data_len, value,
-				    CHUNKSZ);
-		if (rc) {
+		if (rc != -ENODEV && rc != -EOPNOTSUPP) {
 			debug("failed to get hash value, rc=%d\n", rc);
 			return -1;
 		}
-
-		*value_len = hash_algo_digest_size(hash_algo);
-		return 0;
 	}
 #endif
 

-- 
2.53.0

