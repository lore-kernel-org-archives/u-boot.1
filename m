Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4770C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA71584AFA;
	Fri, 10 Jul 2026 14:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aIq6N9ke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73AD284BF6; Thu,  9 Jul 2026 20:38:18 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E94884A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so242837a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622296; cv=none;
 d=google.com; s=arc-20260327;
 b=RDcs4i4mHB0bedTe8ypxiBDchYamWtG2m0vqguq3RO6eGZuEvzfgrBW7rBQDc3Yuaz
 pygG8wYV1JBpJm8NQivfY8bLRY0t1g/XnH5e8nO6ZBZe6dqAStloz/JqiigYPYKqqBlw
 TAXERU/DH8wqqUXUY3C6zil/kOlJLLSEY48tZ23HT7jQiplNfbR4aVjByDMy1M/IGLWw
 10L2OieYYObMZUYoAz4xnkVkSOnmQfjESF3P9G16SgJ5LUCEsAXRsB59pUp7BkRi2ukl
 HzRKTZ/UEOfoA16Q4GIKeEwio17fSlYP5igku86oUC/bfutj43EfwdAVt7CPGF/C8CzJ
 9Ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OS4vIaVOq4HZcGsc8FXTU15ewiYxpLV/fV1x+EyEpEE=;
 fh=syXcLE83OFDraqGbuQhMyZ13Rvk/iT7U0hwLRfOyT4s=;
 b=NeTfJA+GDwqbkZjvn7LpAUGI2J4RUsJjJVtStCZfIxKQmhvgdvI5s0bar8f2LQ4XSW
 voD/73kLgxVZL0Pk9f1JFeYO1396R01rI2rsGZ5pVa/EnacsPmiSnOZU68fXe5t69hRY
 ZmgcmnEMmP5bgsdmDMS/A+b7TFdutWkwasTVace9Tu2JkX3ElTOQmbGu80wDToDtz4qB
 udM9PQY+0R1pr0dDkA+C8KH1tsumha3bKXf4cs1VU6dDVASpwMEXL/3e0osVnl8ij0BZ
 x69TRJ7ges8rCSp4KGY3OmcDfOuyUytbAFKfzTE3MBzOb7k1Vv9KeSH3TvqQum+tGIrS
 dYrg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783622296; x=1784227096; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OS4vIaVOq4HZcGsc8FXTU15ewiYxpLV/fV1x+EyEpEE=;
 b=aIq6N9kevU42zQNNfMqxYawXnaulOTSjQLCNw4e5uuOIcu+MYvQB92XSOWq9TuvxbT
 GBc44nPZSb5MBMjQOvclZBTfHOYihtZnxuGS4LGz67KW6SD9VuKioCULt8fS4UjGbbA/
 3Mc7ErsBiU0NglPaLm1YpvD/JMCmAPHwGOmF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622296; x=1784227096;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OS4vIaVOq4HZcGsc8FXTU15ewiYxpLV/fV1x+EyEpEE=;
 b=HKeO7j+YFp0GXf6ocHt3L8YgTuWrTPn0X/Ea8MUpJwXYRL9EmY0BHv2jDRXJnjBgf7
 Ra1GR0e+lY6nJHcYTILKM2rnoHspvvdTNg7y07Exb4i/I+P98uPSQI2ByUJIoQmpnZab
 KRidAsZpa7YZMTwhb1mtkrP69XlHqnjW2vyUHLUJgkbOEbUXu4l3wFiKpSCuao1sY7IB
 nT9B3pxNXHRTTi7Oo/9+MlQJaGFHEbfdXqHOjv/Buea9hnrMtnM9nPF6OazhIdIOy5xX
 juBdEU6b6O2jR7cNRMsnbR8/hWOzMkaVG+HEwcdZhX2xtWtv0VuCgCbrw+sGB2IOoXH0
 ixrg==
X-Gm-Message-State: AOJu0YyGgbE5A2WZuVe5/LGo9F+D7ueHiyIVyHNPXjUGEa/hNVvH14RD
 iRC4YyD6k9HL0aIdrGIuSuWuztxKEozl/pK7k3whAF67EyXeSY+QmS6npqnHxWFBBvZcsxP+4Ye
 ebfiuCibhr90u321Zy0EC7hziTsbeQih5PgrXe2Q1
X-Gm-Gg: AfdE7cmQbQ0aCb5my/ZNJjhYGY+y/IimsbcwPJ72y9bpCBJ1Iy78ITiXM7gRz6oScBn
 jaIPwFnf7vaSeJDV99ae6Th+LcW7qVfGrK79AXcT/DDRbWzHaQxBf4BcgneOj2o8KFmScEJFYax
 ZWVjvAuvxWq6dfFnO42VPTG7IM13kFDjZPw1LJrPDOPFY1+QwGZwvY/uDP2Nr5PNMEkrmtxm5EE
 SZRJW2bjZcVb7XsGOAezy2p+7aLx8Pns7l4r+J+Yl62BDO7EAHOoijSMddv4DkKfE6T86Y=
X-Received: by 2002:a05:6402:2692:b0:69a:a4cb:2882 with SMTP id
 4fb4d7f45d1cf-69ab4453dc0mr3835533a12.9.1783622296021; Thu, 09 Jul 2026
 11:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <20260702-submit-ce-series-v2-v2-8-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-8-ffda5bed58af@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:38:03 -0600
X-Gm-Features: AUfX_mz2Vs_442MMBch9agkh_f1znMPpdXhSLehz_dWRf6LQ56nSJWsLJk_UK6I
Message-ID: <CAFLszTgOD6-Giue2HQiXEADLOS1dZ-tMxEOsuYMXuTJOvcWbVQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] crypto: allwinner: add sun8i-ce ECDSA verifier
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
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

On 2026-07-03T01:49:45, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: allwinner: add sun8i-ce ECDSA verifier
>
> The H616 Crypto Engine includes an ECC engine which can verify ECDSA
> signatures. Add a UCLASS_ECDSA child for the sun8i-ce parent so FIT
> signature verification can use the hardware block from U-Boot proper and
> SPL.
>
> The CE takes explicit curve parameters for each operation. Provide tables
> for the curves accepted by U-Boot's FIT ECDSA parser: secp224r1,
> prime256v1, secp384r1 and secp521r1. Make each curve independently
> selectable for U-Boot proper and SPL so SRAM-constrained builds can keep
> only the curves they need. The task input layout follows the ECC verify
> buffer order used by Allwinner's CE implementation.
>
> The CE input buffer uses fixed-width curve fields. Reuse the parameter
> packing logic for the message digest as well, so wider digests are
> truncated to the leftmost curve-width bytes according to ECDSA rules.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/allwinner/sun8i-ce/Kconfig          |  93 +++++
>  drivers/crypto/allwinner/sun8i-ce/Makefile         |   1 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |   8 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 434 +++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |   4 +
>  5 files changed, 540 insertions(+)

Not my area, but it looks OK so:

Reviewed-by: Simon Glass <sjg@chromium.org>
