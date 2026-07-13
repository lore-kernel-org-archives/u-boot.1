Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58655C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 01:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E5238494B;
	Mon, 13 Jul 2026 03:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jgmQQPV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ADBA8490A; Mon, 13 Jul 2026 02:17:15 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB26782991
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso5894946a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901832; cv=none;
 d=google.com; s=arc-20260327;
 b=CowBkJ2rgIc3zANyylC7nwzN5DMGjWaugIuMWpESpk1OvXLPElF2aqSuGrBpaPX4t3
 RP3JaMv9PhW1+BCJQYeVvCPgxhw4ePmYd/OcWW9BstTL5A45H/fMHNo5t9LEYaAyGJYt
 FaTXTRpJI2LX9npUrogzpqmeKvlpOJwXFHfO8nQfO8oyQfMf9UHeKRaktZhtQFxXuVdG
 5tvZC+0bL4y3Y47xVZ3SEiLH6nqwzQLQbHa5nkIMLJmtKi55q+ucp1s+s1OYFf8urfzT
 9eU/ScsM03Tk82F3kAE3W14I2TGjFeZGfT0otxnEHul/joX565UBPyl5qinExPrLsHyL
 2vBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n1Nw9EEWL2tkoi9wlz0jFs4TpR3HNj1nBSxLN2fGV/4=;
 fh=o0sOm2vp2y3CWH0wXZkGsEhY/jVD/FgGEsUTF4L6s7w=;
 b=OtjQus617HlNQZVfS0nJALDg1PVx+9eNwUYLpqabjeDLqceyfaRgtG1HAKOPWcvtLS
 fbdEFiTNU5VYkmK3pbVWTws0N/mu0pTw1fJBVoTgmFNCfU716oAxCDzlEKnmj0mtukb7
 ntVdVnUY1tZ7Fh4Bc/tBUOpbts2wldx2nEp34XEycIFcDGGtyMID1tEU2Yu4To50MOMU
 8LN6M3qCz8zyrvOm8JwSrGRDqvMRMulY6FJ3Zx97+0un7XnpyHgJdSmvIxi7TYZXk5Vx
 FGJQfRVjbX6w/0ZxtEmWKLySTqCTzeQdmaf980lF1wqwgxoMdkT/+JF/P2NO79nBFkkJ
 N8/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901832; x=1784506632; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n1Nw9EEWL2tkoi9wlz0jFs4TpR3HNj1nBSxLN2fGV/4=;
 b=jgmQQPV/D6sQvy24uAxgB57nMmVQPPzOI87lGaoSYguGaOcedaATpPXhSnVUKEVC9m
 BZqFXl4+xRth0XvVnRNQY0HQ5ZrcrdQXDGl8l4V/Yk5KmyG2IdcZ0sKFwPyf5Y1JMjXV
 DFkdJteSfs+9k2GC/PgMuwlKOyOEPXkL95DfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901832; x=1784506632;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n1Nw9EEWL2tkoi9wlz0jFs4TpR3HNj1nBSxLN2fGV/4=;
 b=dQK2tdRvlH2b7IA9PxaovfbzNNvYFhD1/V4fcc3cXM15cw9qnb+ARXr+WHQ6iVw8p1
 uzEJt9oggoroZ/w0HmYYM9LEUr/Z/FiS3k6SPszN4SJGbg3NRKK9TBNJclztXGMyi4bC
 OeW/N8n7CVqdA8dKs8hlIZUAbfTb1SkseHRiieukfAhpVHzUCEyWH35PlWck4/xOEA6P
 5xmZX3PyKabQyg/Yt0+bjnwc7Ybz3Y8H0geoDQdD1rafJdhO5crWweQE+cm9l3B+hq3S
 nnceIQa1jYUKkf7ZpeLEo/UZJk6BwhMzXJoE5AXfQer2f8c3ApgxkW5tVg4mOM+hpsO8
 VQ3w==
X-Gm-Message-State: AOJu0YzPQiQ0/wb/Yp9Hr1Knss0eFp29vs/DYAW+U57ipSDWBXe/eAt/
 ceMujGkjchhkG/pcDPjNMb7GypIT4V7Q2zQaKsjxhJV0ucFH+8sBLQXyNo9VznqCSSp5hSrH21b
 lX05MgWlAp8km2YtfcO28hJpVm5LQbd3g0sNLIZma
X-Gm-Gg: AfdE7cnv5ncJuSbPnm1vWQDKCi1QV6lavw4V4FHtMEsUgzbUy8Dr2SoGhbo5jrZexwQ
 TMrbG/RwnsdfEXELnFfBQnk0pgXdpwmEd4zvzivloBz/GMMG6ozpW49uuObXQ3GaQ7iRParZmY9
 PDEdEj7Ut73DpKWs1riG/3M0njX7pDDzv8mBMhynSqdEXNpUmZaAqSRFlBh2sh+fQR/y6pHBaHe
 RQDwjodsPxxzx8/hfbn7qvQw4XGCARn8Zc5EwvosicKiTUtNIJsSeVghJ1vM/Zm58ogkeY=
X-Received: by 2002:a50:c908:0:b0:69a:b449:f8cf with SMTP id
 4fb4d7f45d1cf-69c24e21c25mr3700813a12.4.1783901832415; Sun, 12 Jul 2026
 17:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
 <20260709-submit-ce-series-v2-v3-9-5017da8c9bef@gmail.com>
In-Reply-To: <20260709-submit-ce-series-v2-v3-9-5017da8c9bef@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:16:56 -0600
X-Gm-Features: AUfX_mw_EJ5vpgRUGdkKEc0-ijnQrpG14t1f3eBFX3JufWpZ5h_5BVxtkNvmwH0
Message-ID: <CAFLszThb4oXZNStq=fyUObH34M71b01Pz0sE835pNB_pKRiqYQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] crypto: hash: allow DM hash in SPL
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 13 Jul 2026 03:41:08 +0200
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

On 2026-07-09T22:46:22, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: hash: allow DM hash in SPL
>
> The hash uclass is currently keyed only by CONFIG_DM_HASH, so SPL cannot
> enable UCLASS_HASH independently. Any SPL code using hash_digest*() has to
> rely on U-Boot proper also enabling DM_HASH, and the FIT hash path selects
> the driver-model implementation with a non-phase-aware preprocessor check.
>
> Add SPL_DM_HASH, build the hash uclass from CONFIG_$(PHASE_)DM_HASH and use
> CONFIG_IS_ENABLED(DM_HASH) when selecting the FIT hash implementation. This
> lets SPL FIT verification use a UCLASS_HASH provider without requiring the
> U-Boot proper hash uclass.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/image-fit.c             | 50 +++++++++++++++++++++++---------------------
>  drivers/crypto/hash/Kconfig  | 13 ++++++++++++
>  drivers/crypto/hash/Makefile |  2 +-
>  3 files changed, 40 insertions(+), 25 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
