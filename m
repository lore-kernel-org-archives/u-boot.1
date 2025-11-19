Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61BECF397E
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995FD84021;
	Wed, 19 Nov 2025 18:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NKGJijn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21CE484021; Wed, 19 Nov 2025 18:34:57 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1BE08006D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so2287466b.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763573694; x=1764178494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aMad0xSUrWJ0gBpDPvM8FM+yJpnlAOJ8Z9R6Z1Igcjc=;
 b=NKGJijn/toUlI2YnZrGJpg99/7miWP2M9nLJbqflGtLQXKr06dDSOQq4oEj6w6like
 mNn+uyS6UM+VI/8nIfM3gifQaiamiMny67KtL5/FhMw4wS5FO0S+BYxyC/aAyfXPYRLf
 A60VnY0oo82iCRk8x/rAj4A1DsofJMaAlSZTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573694; x=1764178494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMad0xSUrWJ0gBpDPvM8FM+yJpnlAOJ8Z9R6Z1Igcjc=;
 b=u/wJlrRiKSatAa5jUgTHEMjvV7oivEpaYa3X1MNA1x7SApeEs+tmoMWOu1/UAlQvkL
 PgiW7gjL1aXnKZXAgWa5MnIIKtHBEsHW6IUqljBww5VtOu11O8MSzXf/p2UbhY+Ct7pQ
 ssnH9J/btpg9Q/hHu9Zc5l5CzdAcdP7JR/Ai9xLL+iNHE2xH/bYlIGZ0BtzdsMID+Ur/
 xgtCP2zcExw4DK41RvZIj3a3AHOapaqDcwlgec5l2v24m1vYjlJv/kwjseeLXyssNcXY
 oYSY8nrUGWOGccUe3oqRR5idIPtObmmh4MjzJIjHNP8ZHE7Dq0KXCT7cKS8EV1NkfmMK
 w+iA==
X-Gm-Message-State: AOJu0YwnWu2ZF7oixkobI5uDtdK3vH02qC2N/43DnY4msr1U6JU7EoJw
 KKQ1IT/NMDzJrTJE6NTimWaMBPlL4LTDHgVpDorG0IAOIXRY1Yn4clrukY+5tHrSewWkAjJ0ZhU
 xzE6Eubx6aVZEoHPqbiLf4//7R8Zfh+h4A1+tfzco
X-Gm-Gg: ASbGncvsWKK2iVct+DEncBwtQmDBFeQfYeVwOaE8OCle2O0oh4nrUA1KhTL+u+6as7L
 STHDktnGLXM5wq+1/zHaDDwcv7rycp5jsmx4/ur35VNNvRgire/trWvsypeQeUDag/pilZxU09l
 L/oIOkiKaQIBkR/sQb6fX+k9I6wgi1xo1QWuVp8YbiRG/8arU7beyKVmqL3Ddf/AYhWAv55y5ha
 bc+02KUNX3NDYFKvazYxScaYmGav2mYOPedOtMksBXwtSiy3msc4Wd+kgUTHiB1N0F89w==
X-Google-Smtp-Source: AGHT+IHVqME19oIVAmrnlZbZUvnCrF/6IpH5xIkkKbsM6vp5Ikap2ID8q2JnXVaR2VImRSoaHHdAHJhYlVvppFSl5zU=
X-Received: by 2002:a17:907:1c81:b0:b72:d2df:641c with SMTP id
 a640c23a62f3a-b736795d498mr2183121866b.49.1763573694078; Wed, 19 Nov 2025
 09:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
In-Reply-To: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 10:34:39 -0700
X-Gm-Features: AWmQ_bnUAoTeI86Qrgebzxtvzh9KVrWU2UPKXPtvlXin8gMJ6lfxc6fWgDcVKz8
Message-ID: <CAFLszTgvp7kVMw9BQj55SMYVb_rYjifLUCcoH2+kG6GXEu89ug@mail.gmail.com>
Subject: Re: [PATCH 0/5] led: remove unused legacy LED code
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <hackpascal@gmail.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>,
 =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>, 
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Wed, 19 Nov 2025 at 09:44, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> This is a follow-up to:
> - https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
> - https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
>
> to continue the effort of getting rid of the legacy LED API. This series
> depends on the series listed above.
>
> Multiple other smaller series are coming. I split the whole thing into
> different chunks as separate series:
> - should not raise too many questions (this series)
> - "easy" migrations
> - "shot in the dark" migration of Socfpga Softing Vining board
> - removal of LED support for a board with no easy migration path
> - make Sunxi community bear the cost of maintaining the last part of the
>   legacy API by making it Sunxi-specific,
> - migrate Olinuxino to new API (which requires net/bootp.c to use the
>   new API at the same time) + remove everything related to legacy LED
>   API,
>
> @Patrice, b4 seems to have an issue with patch 17 (and possibly later, I
> don't remember) when using b4 shazam (or b4 prep --check-deps for this
> series when run locally). Not sure if the patches are somehow/somewhat
> broken or if it's b4 :)
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (5):
>       led: remove code guarded by always false conditions
>       led: remove coloured_LED_init, yellow and blue status LEDs in legacy API
>       arm: omap3: remove leftover from CM_T35 support removal
>       net: remove unreachable legacy LED code
>       powerpc: remove unused legacy LED API
>
>  arch/arm/lib/crt0.S               |  1 -
>  arch/arm/mach-omap2/omap3/Kconfig |  6 ------
>  arch/powerpc/lib/interrupts.c     |  7 -------
>  cmd/legacy_led.c                  | 13 -------------
>  common/board_f.c                  |  5 -----
>  common/miiphyutil.c               | 25 -------------------------
>  doc/README.omap3                  |  6 ------
>  doc/api/led.rst                   |  7 +------
>  drivers/led/Kconfig               | 28 ----------------------------
>  drivers/misc/gpio_led.c           | 24 ------------------------
>  drivers/timer/mpc83xx_timer.c     |  5 -----
>  include/miiphy.h                  |  3 ---
>  include/status_led.h              | 33 +--------------------------------
>  net/Kconfig                       | 11 -----------
>  net/net.c                         | 35 -----------------------------------
>  15 files changed, 2 insertions(+), 207 deletions(-)
> ---
> base-commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
> change-id: 20251119-legacy-led-unused-code-d635c95cfae0
> prerequisite-message-id: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
> prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
> prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
> prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
> prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
> prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
> prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
> prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
> prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
> prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
> prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
> prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
> prerequisite-message-id: <20251114162417.4054006-1-patrice.chotard@foss.st.com>
> prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
> prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
> prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
> prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
> prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
> prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
> prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
> prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
> prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
> prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
> prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
> prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
> prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
> prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
> prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
> prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
> prerequisite-patch-id: b92d833519a5a605c2129ea08a4dc32cbdbab36f
> prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
> prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
> prerequisite-patch-id: 3600c976c13534519ca5d0891a9c4f665dd761ed
> prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
> prerequisite-patch-id: aa471cc044809dab0ca6068615cfeba8f3bce121
> prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>

So great, thanks for doing this.

Regards,
Simon
