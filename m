Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FBEC44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B9984B53;
	Mon, 13 Jul 2026 15:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QfPk7mju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A13784A49; Mon, 13 Jul 2026 08:43:39 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C0584A4A
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb34c17b96so1879945a34.2
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925016; x=1784529816; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AqQopp6IzDYrCHxVVftL3Ql6qliPq7djvE05K+LwNto=;
 b=QfPk7mjug9O30LC4KagfalE/nTGQHW/e5KoCoGrkWQIikaGKa7jzIzeCpbrmQd3t5V
 akd/z4g/UNdi6wmzCRlzoRKRtzCduN6tgY0fgnaGAOg0OxyxW6U83rzAJ1aRGjHjZg+2
 96+ze8vE/W4GzCMAbmufrPrFT+cJ/IMa/A8PkwalbgXV9KnsdWidGkX5BQ1H62/nsxrZ
 n1CJCRBFuiiCCVoLv304RYQBJgVjpOmMkQRd2N2uz1Jnb4IhCCWXsDnkp+FyNaNYsKb/
 OuFHVSHOmhguc5mVu4Ml8yzx6ifNy/U2xGgHA3qvc6NThZQDVbjbP01JPA7WvwziKKrk
 cXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925016; x=1784529816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AqQopp6IzDYrCHxVVftL3Ql6qliPq7djvE05K+LwNto=;
 b=fO3C45z9j0VaDVlsNVkrmMfaQacwdDjl9dFo787bFuxI38iudgAR3V4bBWGLmRHE+M
 QN+/lS/gBUiv6utxeYdwBLgaP8LKCxlYBlRb5e3lrapFJL7VEX01V/g8v7jMR1zhEY/I
 K1Acs2tShdDwaHTLOqDQmkDGCpC66Oa12uhE1onRVeb19ThWY2Zm8+KE5diCY5zQKlXR
 OVodGwzqz06aEUPbLRn4cWjpKdelFUuNxRJI2aJpOjK9tiQkvevpq/25gpxAkENTaGBQ
 1qlDuDmkU18OzCNZfQY627HaagVameZ+YjQ5vpxRJ/EMkwMnZgtCzA1HoL8W+yWnu4yF
 ql3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/ceJWwSaxswN0bW9hqfC298776PWH0JTiio+HMAe620ksiUBLJnfJ/ZyoHECb/tmQl2pLebA=@lists.denx.de
X-Gm-Message-State: AOJu0YxUbns6i6b+glZyi6oTSvKGsssvdeVN++m7xtlpgi5NvXjKEyvP
 s4a66BqwKTccWUSD+RCTPFdzu8h7EF5cW9ZzcZV2ZRrAcLDtIyxkpXwq
X-Gm-Gg: AfdE7cnBH/hiX+O2RRcTmda7Rn9CFVsPejvSQR9s8ykvBa1qCBnEWZ7aSP2TuxaMyzG
 faUPhZg1cK1JpD6yJkkn0WIN7DL6spCUuIfD9QDGCTILqAQpWSbtMe1ToegMNV/kMFFPfYAjhU1
 FmjgjjsrFu3bpCu14uNcUHAbBVeu8WK0nDd35srzXjFktcSTcWYJlSaN85VNZ9UwEYzkEaN9gV5
 wSQW4tm+GmvwMZhYO/qC8fUQMwRyAdK31KB0wLn4NodboBjEpIsyHHn8bkm/xhq+r1KOGDv2SUd
 zlt/QcB2c9CraoCBmEaEazBYlFrJzhvhEMrrymlF6Flu9Iwuj1k65YHVW3925UIldKa8YzqICgz
 xg3j96JZDs9I1Nvxl6ohZzljYpuCrkXlzpLX3zreW/KHYh/RqLrPzlf50WzXeQlyoug6BDyT/J3
 hJdnzXT9aalffGRdfyC+m5Nj52po5vxo04KVfKw0ndAqE2+qtsbNtBxhOsBeQWaQ/yb3oy12tiz
 JSK3DuyRweUShbqVu6WwhOIZZyUaclktX+xqhJRohzdo3i5+DqhznYUkhvdI7Cs
X-Received: by 2002:a05:6820:150d:b0:6a1:40ad:cfb7 with SMTP id
 006d021491bc7-6a39a5c6cf1mr4757893eaf.20.1783925015905; 
 Sun, 12 Jul 2026 23:43:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:42:58 -0600
Subject: [PATCH v4 01/14] cmd: aes: fix DM operation handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-1-ff7edc705b8a@gmail.com>
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

The DM AES command path takes operation-specific arguments after the
common arguments. argv[1] holds the mode, "ecb" or "cbc", while argv[2]
holds the requested operation, "enc" or "dec".

The DM path checked argv[1] for the operation, so the ecb and cbc
commands always returned CMD_RET_USAGE before running. Parse argv[2]
instead.

Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Limit the patch to the argv parsing fix  (suggested by Simon Glass)
  - State that the commands always returned usage  (suggested by Simon Glass)
  - Add a Fixes tag  (suggested by Simon Glass)
---
 cmd/aes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/aes.c b/cmd/aes.c
index 3fd83013ffe..edcd87cf11b 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -175,9 +175,9 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;
@@ -223,9 +223,9 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;

-- 
2.53.0

