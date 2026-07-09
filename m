Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1123EC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7750784AA2;
	Thu,  9 Jul 2026 03:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BiU2Uqmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BF584AA2; Thu,  9 Jul 2026 03:24:59 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4AE384A8F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso559894a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783560297; cv=none;
 d=google.com; s=arc-20260327;
 b=hCZK5LkWJvvJkadLdD50+cPxbUOiwG3R/Q3IPsV/zM6Q7vDI6SVFwmoq0yJxDBdtQA
 hwB7E+Q5gcyaA6Bra8hurUbZMWTOLj8ucB5fTmez4BQJsiVoGPcJJFkurTNG4OQ79zPU
 klvOFVxeDdGpeiKx9vPsa/Q0UUz/nU/Zt0tq+hvYlqcheXFAI60TYDlss+0QKNX4wi6v
 VqSDl7rnwY4htabOlZNQhllONWeQ4vEgCNFIJJVzokhcy2ehaa09OJZQBcpAtkXHGgew
 YYrDZTVRR/c8GJTkSB6I8Q0/wp4kwNZaoO9YJfv2B5yIGXZypeDizxx2sy9itfoNpMH7
 6B0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gKlQeYDPpwvGtP3A05KbCYpzMLdlZ3Z6P5YX42uzWxc=;
 fh=j5AyEtJHdM3P6X8+CT+zzf48tep060SLPcEuUkVeS1I=;
 b=D2q+QsFJTDJyO15obmuxttxJq52MtxS8UuQ3uBt6NJxpR3nG2rOVC8UzneV8uJqj0k
 5Pqf6IGXM3WLthJda+QY0KU7QcSkYL+e3gOskxtqZnAYG/Emx/C4FBDqSwtnLbzPemob
 esRdiBwj5fV5Y6ZKh0KzXPadtOWqRWsgMabW7pTxLiXrL6+tlOhGSDKHKrDtoionguVY
 +3UsWmuU+A187PMAhJYGHk+9Q23dsPvlC5W6PIbMsVgZffgbIT1Uj+2rEgtUPrPgz5xo
 5cZCPlgP9yJ/SdYYjz+9iuJ7qgNcmPDxfluVa3rxpcIDHfuPHdoqdhHx+zzn2c8EM7yU
 Rb5A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783560297; x=1784165097; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gKlQeYDPpwvGtP3A05KbCYpzMLdlZ3Z6P5YX42uzWxc=;
 b=BiU2UqmcYf1MfbBk+dw22LIkKHIfUHwH4nDBIJcY2N6bNr7jE7qAdapHrjBGpliv16
 1+ER5qZcAswR465QhYaSvZuKpOj1UVRhb1riuq26L3W00yZXY679ayHAhF2jJE6aFMuW
 mCF/FKHu0D3Zy+p1CrJQ9199FBIEePpoQRhT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783560297; x=1784165097;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gKlQeYDPpwvGtP3A05KbCYpzMLdlZ3Z6P5YX42uzWxc=;
 b=f0AQAwPK2obSBncb8FDIb9bLrG/e9Z4dwiNoPcuB44RV95qxpOvAe1fJJhuJSHbcJa
 NufvA0WJXxUKyBTB0P5SGiyuHRvxnJQ39jPYK63xc60RlwwhNZhnTtMh6GZspBBIj7Ex
 4B7UN81iBnoUpbeHbv13asiT/AQc8t9XdrMZT9ohIw3IX+9eGcdeOWrl+aEHEoH7PbZa
 f2W6RZvyyab1rwiIXIEaJjTzCgTDrqr2W9e8LZPKCsR+3XdLcVPnspXXAhGLShOfOZSA
 EH+7YbDZYLFDOEV68XN6pZ2aW8s2r1FQ08wEiE44pGkwAR1UYsyCf7JISvqBdN1/xb7h
 wAAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwK7h63cICFrKReXYcogptsX8/Z1QPHeLzjJdJdS+7QBjCfzF3OHXQueyh4sM1BY8m1wFTqPM=@lists.denx.de
X-Gm-Message-State: AOJu0YzN1rS9AJZZAnn+9cx7J/jfCbUKtWuvfU+qnSDTYDmwTUlfvl+h
 Ru6mX77oyjZN/bA7gBlut4ZBcqTirjCb9HwuY/umG8UmNWNUDEXinaCJa8xOkWYBhhrdpAL9/gR
 OjLFzSI8ti6hP3KeO0n9Hfu6w5Mqw94CvDRlRtjpw
X-Gm-Gg: AfdE7ckns+Y97YzC7rmnaNrHwCGD+OQVXToKswMI5IIZwCewRTb3pEGMp7uZxf0w0FY
 VN5mXUI/wfa+HjUDhJsMAMRZ+ixtBS9r+PrjzxmGyeG5hLy/8fVJ+sfuQ/f5NG4e8Cucxj5lIHN
 t9qs3mIjOA/o4PJzLHemn7V6JP/BcWLofYzGKIxb4JdwspMULQNn2h9wSV2eNEboUoP9j31vhS7
 QYZn45PYuj14nDan76llqngFh5SFsDmaeKvjN6tBpMAKS+LdgCvt5vO3l5wxScweejH6cszMI6S
 I+WcPg==
X-Received: by 2002:a05:6402:381a:b0:69a:2ee6:4c95 with SMTP id
 4fb4d7f45d1cf-69ab43eb501mr1954303a12.0.1783560297149; Wed, 08 Jul 2026
 18:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260707205611.65287-1-ccaione@baylibre.com>
In-Reply-To: <20260707205611.65287-1-ccaione@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 19:24:44 -0600
X-Gm-Features: AUfX_mytsmm3NSuUlu4mtFEJuBAzLfbfI6FVFo1SGg9NHAQM22srGK0j8GGzCQA
Message-ID: <CAFLszThaMksN7J_u8-B+eDY6vi5WS-ODGD89GLG1j=wCTyRr6A@mail.gmail.com>
Subject: Re: [PATCH] fit: prefer the default configuration on best-match ties
To: ccaione@baylibre.com
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de, 
 u-boot@lists.denx.de, dlechner@baylibre.com, jstephan@baylibre.com
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

Hi,

On 2026-07-07T20:54:11, Carlo Caione <ccaione@baylibre.com> wrote:
> fit: prefer the default configuration on best-match ties
>
> With CONFIG_FIT_BEST_MATCH, fit_conf_find_compat() selects the
> configuration matching the most specific U-Boot compatible string; on
> equal matches the first listed configuration wins and the configurations
> node 'default' property is never consulted.
>
> A FIT whose configurations all share the same base devicetree compatible
> (e.g. one manifest carrying a base tree plus overlay combinations for a
> single board) therefore always boots the first configuration, silently
> ignoring the default chosen by the manifest author.
>
> Break score ties in favour of the default configuration. A strictly
> better compatible match still wins over it, and FITs without a default
> keep the current first-listed behaviour.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> boot/Kconfig      |  2 ++
>  boot/image-fit.c  | 20 ++++++++++++++--
>  include/image.h   |  4 ++++
>  test/boot/image.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 92 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

This could use a spec tweak, perhaps?

Regards,
Simon
