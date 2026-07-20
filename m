Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31797C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 04:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E570849BC;
	Mon, 20 Jul 2026 06:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="grjAk4Od";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FCD838D7; Mon, 20 Jul 2026 06:14:26 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD6680433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so3911324a34.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784520863; x=1785125663; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Byd6ZYKVfX6dp020wqqPwh/HNJ/iTlslQWUc4+3xF4o=;
 b=grjAk4OdO8o4AFS59C3TJsfO7GODKHUw6LHmMTt8gF5zqb0xJBAW1WtlqndrZxGs27
 /QDAoKO4nodiHSB2XgoDOeYKshlvmVB0ririzzsUze3XUWA42G7KWiS3Fl6DGzyWDiBH
 bA5uFc8RqgF/uRYbiwyedunYb9QtyvD9VUPIfqFqlINDDHwOYA59q4TqrAV8A8q6ta8f
 iFUfrpBmgiGImDb9igQW/PXdTwriVnzuoFSPyuIRdbj+W03eOZrDafGpdmaUxmhFPb+h
 8HfKEgZEgX9sco2mADxCMeZxc79KMFMjK3g6rp8aercGX7loSssyCDCL4uNVUCoFhLAW
 feMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784520863; x=1785125663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Byd6ZYKVfX6dp020wqqPwh/HNJ/iTlslQWUc4+3xF4o=;
 b=C9OuRAJJGuhEtOJOGQibD8ZnUW2Fm/p02bAzFyKhQSIrcRiK2vi26jcdFe3ojaxd5q
 0ekxFNFJ4y8yrpLwKnu53tm7pSi1Uaah841gIEjZ1ncK2eRiB1bv/cRwF7UqjrF3QpMb
 HHJRP6KK0bAYY1G8Gwv5Fx7gSflU5LW7QCzWe6jg/xgWI9E/II9IWapc94VLdmCZrnvb
 oBXbK3pK1aH09iI+eg1ZPPKdIMglKyX2Zv8FcO1hPUvwfLBYLNyDZTcVSHkYCm0cxPj/
 G64GBc5ZxDWLPM8SpYTHHNNBsA+30Z5utOkFDOos93WmSjHTnKDjhGq1re8r4yNApR09
 qk+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNi+9ebqOA+yRSdSKszVbiO24KonCbKsvQb6AorvhlGQxdZ6wbMOjdNI9tJbDMbRrVG+wSSwg=@lists.denx.de
X-Gm-Message-State: AOJu0YxHknYbLBZoXr42X+QeTrlbEdpGpIvPzDqjaEt1Fbg8c4DMZFAC
 eALwxPHdnJVRZR3keJ1iGSA1ZubEZT51RnwS8PCpj299zdU8XpOJ2yuG
X-Gm-Gg: AfdE7ckiWtmrYXuhOsuL6iMJHj0R+OkayXgEawEVQp6Ca17JQ0O8l0P/BbWPikD583c
 pxej5Wb2oA/ihDnzC6Ug+1Oxd66JVv59nqoNCIO9ntLI+o+97RoDFAbB3wD/mVRKc2Qk1YWou/N
 2QRN8Ru1zUE+lHASVVSUfVMgMFXAboNFGv0f1PaRRQ+r6J0vcjEuUdvQML5yaLAcBtAR1YIgoBq
 dNacHuNFp5EItmvjI4pX5tA0tCXTC9i79XqtSSjxhnSUxyQXXlivV1F9sMsDtF3M/4GbdVpA1mt
 G9YcIz4iK9eUhFZNHq//t7mZe33/5k7hv4VH0I8x71xDJEc9xXQ78TtPi8HTdIO6EBAu5LE8Kav
 N+4y2PsQksVncKBuIvZpU7uQZmUDWN/TGWbbnOa0dR1PSpoK2OJpxFCIXsNZeCyCJiOfzHllMuq
 N3TDu6OgnQWkLwh9A/ZLLy/zO6qqVIX7nso0VqDCwQWgwSvnYp80T7XLMH/SQC9/KvJ1lPhVxsk
 vDjht/AUgKeJJEnKm1GLxVGGjkE22qAygRz9Wytt11UVmMGz0Y8IA==
X-Received: by 2002:a05:6830:661c:b0:7e9:bd00:c6ad with SMTP id
 46e09a7af769-7eda08ec2e2mr8125164a34.16.1784520863426; 
 Sun, 19 Jul 2026 21:14:23 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf94a737sm7159191a34.15.2026.07.19.21.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 21:14:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 19 Jul 2026 22:13:49 -0600
Subject: [PATCH v5 05/14] boot: image: try all DM hash providers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-submit-ce-series-v2-v5-5-3c41f66d4522@gmail.com>
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

