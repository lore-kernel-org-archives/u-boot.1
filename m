Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49BDCD3431
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 12:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0D5688AA7;
	Wed,  4 Sep 2024 14:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EPmQ1kHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99ADA88AE4; Wed,  4 Sep 2024 14:48:57 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59A2889FF
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 14:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c218866849so6969229a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725454135; x=1726058935; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7dvg1GXJ/xCqU8moMAFTjwv6n3+GjfkSRxExokOEiag=;
 b=EPmQ1kHHYM41hISfY+U5GYu+5CnkRRjJxqNkO4VvKPnIBZ0lbIZqKy1iR9OWqIv+dC
 5HeNsnAD22chLBi8O0sEli3OikBs07CCyHWeFTnHZ/T3YJS8bwL7CWj+Gwfmej8rs/EO
 Ii9kftAV9JHElaGqzzl3Di/0Dt1MKuCUoksUVgyIDPCySFfMbIO+WJB6BrT+4uzIQIyL
 Ro+owFeTaTkpGMrOwAmbbjlDtTldJ2upYJa2+COrCQ2EEmIuLI/Y2ynqodI9I/K3/sWS
 pvNdDpBN+pTu9/8Ot/9gCRvX0C0LC8IC3eoyw2gVasquqZJa+Xk8kyCMRbzgtcEoiA1l
 woig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725454135; x=1726058935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7dvg1GXJ/xCqU8moMAFTjwv6n3+GjfkSRxExokOEiag=;
 b=VBfEY+G89OCAqbSl/Y97pYdszhW0ZKBGBO8lRSThLOYbpx6bSNdB2tMFHrVIXMpFQD
 WTNVdgn0mGdHuUZjdnnyqxHkUfYWSVcmxHppgoqNf9XFQn7t9W2l8Ro8XhWwU4iaufWL
 35ll1m9TuKScJtAPp2hrI3qHghIaODMFOSdKIGZA0AZ2Wni042npAu3S/r8p8Qkc+Ynh
 pXLtU7CLMAJJd2h5qvsmhOn+uCPhASVJ+uQSsnwhsONl34xFM7I1zEUAJ9yewuNNpnmq
 k/dHGfQJ6Cda0+LdKCj7yWY11kXTDZk/E8ahRDP4v6w0XapHrBlwXKWc3fUxjEYspP+g
 HFRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNHE4rpZRwIkRzWkvOyh/QyE2CogZ9O/xwCH1xuhk3G76itrRZb/xdLrb7ppxrzPhFY8INf+A=@lists.denx.de
X-Gm-Message-State: AOJu0YyYuU4V+GZuuUiwO9RQHJ+i5FHSf0q07Oj5upx4xeLtND9QeJEO
 bD5qmdhtqd1SyBcA6bZs82GHRmV+V4kwSjB1fKJ+y0Rl0jy+IeFNQDPbn2mliA5UShXEjXSt3da
 f3XqO2xBZEgOVS2jJh7m54IeE0YY=
X-Google-Smtp-Source: AGHT+IHdBYb3nc7KvlQ2yqvYt0lfEd8OMc9wMML8FBG49c0OZ52hO7AgEUo7p6SoxKlQpRDi8eugd4vFYzBsQ7nA9B4=
X-Received: by 2002:a05:6402:2707:b0:5c2:69f0:8d6c with SMTP id
 4fb4d7f45d1cf-5c269f09289mr4967757a12.18.1725454134411; Wed, 04 Sep 2024
 05:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
In-Reply-To: <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 4 Sep 2024 13:48:43 +0100
Message-ID: <CALeDE9PqT54MH0riLFng3ONi=rtEa53LsxRgYcV1ENX=ikuV0A@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Simon,

> I wonder if we could leave out the SHA stuff? The algorithms are

One of the big advantages of the mbedtls when it comes to all things
security is that it's seen a wide audit of it's code which for a lot
of usecases is very useful from a security PoV, I'm not sure the
amount of audit the U-Boot in project code has had, I'm sure there has
been but I've not seen anything published.

> stable and this would seem to avoid much of the size growth, and all
> the pain of trying to integrate another yet another hashing layer (we
> already have normal, progressive and h/w acceleration, plus

What's the difference between the first two?

> UCLASS_HASH which h/w acceleration should use but that migration never

How hard would it be for UCLASS_HASH to use the mbed hashing underneath?

> happened). I struggle to see any benefit in replacing U-Boot's very
> solid hashing infra with something else, particularly as this series

I would need to look at the HW support in both U-Boot and mbedtls but
given wider use of mbedtls I bet adding HW support there that U-Boot
could utilise may be more apertising to most HW vendors as it means
they only have to write one set of code and have it used much more
widely.

> adds yet another. Better to invest the time to refactor it. I asked
> about this before and was told that it would happen 'later'. Let's
> just not change it at all, then it is more likely someone will sort it

What, like the HW support in UCLASS_HASH? Things clearly don't work like that.

> Also, if MbedTLS is wanting to be a general library for TLS (I assume
> transport-local security, not thread-local storage) perhaps it might
> consider changing to non-Windows newlines, or perhaps even kernel code
> style?

I think the newlines might be a possible ask, they are generally
receptive to change (they relicensed it to be a dual license
compatible with U-Boot when asked), I don't think forcing a separate
to the kernel project to a kernel code style is a fair request.

Regards,
Peter
