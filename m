Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB293C44508
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F40984B7E;
	Mon, 13 Jul 2026 15:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mfLBcrqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1077F84A4A; Mon, 13 Jul 2026 08:43:47 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EACE584A4B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4513435cdd2so968780fac.2
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925024; x=1784529824; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Byd6ZYKVfX6dp020wqqPwh/HNJ/iTlslQWUc4+3xF4o=;
 b=mfLBcrqG/uU8Lzreb6Bs/idsBJG+zrnv3Ku6cpXiZ+A1H5RfY/XA78HZhTWirdrFvh
 XG72kyOEOn81c+QsoujBlG8KsNx+2tB5F4MbMcmk65IpLltHDH/Mt8sSZhTvEzXZ1qw5
 7R1Sfq11j+XOl0catfRQHLQSlEKz5zsgN1tkBEoAbtnogqk26hkAZYmUk2bfA6QLTOju
 owNqujjOCudVPEQ2/Zrv45KNgo4E//XkfPR1yxAAkFL7Tee1btiaf2ItsFVJnByT3yTQ
 qBKA83zgGrEfEG3AtcBmd/xqF2DM7mKAkIcbcDUFjHYGix4RFdt/Yh9ouD1nyZxRDVk1
 Kakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925024; x=1784529824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Byd6ZYKVfX6dp020wqqPwh/HNJ/iTlslQWUc4+3xF4o=;
 b=FBVTwK0Ko6pug7rojfTszyjbBzIDcle9IDI25O2f15eT56lBJKx3EuaIFVes6XWLUj
 OeJQHAtAcu5WTAAKtx16YG0iYz5xKSB9LjYCy6Foa6rb1PVWYBJArnqqA4bPXv/uvAt6
 0TYVM1RB+LYEh9JIu9TVOznqMXMRaZ2R2gg+E5Rh+IiRwdSK6LbKukDPXiaBQM/8Fi9d
 Zhr1tZBMv+pclKDnsV/zqpyeBwhg3ButuwDbLkoxzA2ALgEyNcWphesknWNwbcx/TFgl
 tlPZu2KkXeXrkjpnIj5oxGnJRF/hvf3yvcqsv5seTDOK/T0/8gOlYU9TvMDQ4vcixOVr
 4TQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zLnMu9TT5KX4VEEhQLCZNgYw/NVeWd1vCc9tFc9UJ2y3p0VcQWDKm0az/Mmm2bXS5k1fDqzU=@lists.denx.de
X-Gm-Message-State: AOJu0YyidswkfFdM/8/runAnihhyi/AwA/36F6zVH1gbMwVNv5ieAwl/
 neYlMYiWvT2QAhC4hODrTXVVNjVMIJiOxtYphYXZlquTqgFLsCgexKbm
X-Gm-Gg: AfdE7ckEwePIBm5FeYb8/6iwVu2kf56osIh9mXH8blLjbvJm7jy/iFjmTnYcruL7UpU
 Is5NcTybz/Hx0AdLffRhzBFfZwsM8l8ujtAohGSTErN2RD29HvOU28NAp3CpoIrWqLmmTXwVHTy
 Mw3ibhLbcG72vXxxybGUmj+MzZjlOeQQcWErd4Cv/7/timpq3fgeldnpmInK8DhUCEBv4zFOqnK
 dYIYfE9V3CpZa82pUGmds1BVgTmZ3vzQVnkRBfvmFUImGqmhvaqImlzxI2dSuOWC43gzUeoEjmA
 UQtyRjBFhC/nsPvZ1SIAfAQOjU1JTsAXettGAHaTleeWN1SdlzenSY8liJ185Yb9gOPs/6FECKM
 t4RCv7S8es3KZAY5JgUmCii2n1NX5ehDI4C+u/bf+kNI1CuBGgwAW84YPMYMVYf6b/3ni674QWC
 x+ZgFePJKag7TZ7Ev/vbKIIQBhN8943+Fgt8pwrnc0WaHSuK313T7kit8DGaV2xrWA+NqTBM1id
 Vh3tuR5efJp1bgpCYNli/RuOCQ8+r3rYJrErtMj0v9Q5XHyXmNKbC/1W7df+hvrlEfZk4UVpYk=
X-Received: by 2002:a05:687c:3394:20b0:451:fec6:8371 with SMTP id
 586e51a60fabf-451fec68c8fmr2624467fac.8.1783925023534; 
 Sun, 12 Jul 2026 23:43:43 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:43:02 -0600
Subject: [PATCH v4 05/14] boot: image: try all DM hash providers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-5-ff7edc705b8a@gmail.com>
References: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
In-Reply-To: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
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
 Heiko Stuebner <heiko@sntech.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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

FIT hash calculation currently selects UCLASS_HASH device zero directly,
so a provider which does not implement the requested algorithm prevents a
later capable provider from being used. It also turns every provider error
into the same generic FIT hash failure.

Use the common hash provider-selection helper. Fall back to the configured
software implementation only when no DM provider supports the algorithm,
and preserve probe and digest failures from providers which accept it.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - New patch
---
 boot/image-fit.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 555cbf81348..9af38ed8d82 100644
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

