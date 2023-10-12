Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA80CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 07:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 833DD86E39;
	Thu, 12 Oct 2023 09:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cT8XwIms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205E986E07; Thu, 12 Oct 2023 09:26:53 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7112586E6C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 09:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so3765304a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1697095587; x=1697700387;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j++DnANz+fG0784AhBLZ/mXfqFHgwoMrJzt+FvvqMrY=;
 b=cT8XwIms6vHB16RNxGdlu8gbQ4zETN+EpxiTezGeS9Wi+CzHz7aWHz6FDhOacY7nBw
 3tdyAdhQ2QWortiKSxRWugxYgJbCoGFVkR5FT4Phfarxrp3hnFDtTuWcpfTemphxrC7S
 9/CPyeHYv1PBRGvmEQhGkm1JFz7zWnqL/oyi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697095587; x=1697700387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j++DnANz+fG0784AhBLZ/mXfqFHgwoMrJzt+FvvqMrY=;
 b=AiWx60D6SJJuAVM8UT117jZXH4dLiKyaydWEOmChIubwy1+H2PzE5PcOVwSIBHzpYE
 5THJ0YWA9Y3DooIYrY5YO2ry1mfJuMGsMbrIW81V2oqAqSReEiuPKClVSm1Bbg/RK2PR
 2ZWpWGyYDAtKLuQO6g5bxngaV13hxuzCXaCEXI9WZmncVW7ERhw/rxC45VD/I+tmMkDQ
 T8wWenONwL7J7kCqFysBVJ7KNJ/NCAw+nidUTFYWOEBKwG7PwZFitQeMaEAssm0CFhxL
 AuUf/ipMblrIEbM2uGdivzvHJT79AlF8N4YqMaON485CyXj7SBQy3IyFYLVT0w5UPcoO
 WQPA==
X-Gm-Message-State: AOJu0YzMpNlRaGyN4lpzA5udUNMUqIodnQvw+3o7BBLMi69vB8nv7GkU
 iMHWoWytsTXT5trfNP3F0NPaVsrHjMhX/HHqQGE8LA==
X-Google-Smtp-Source: AGHT+IGxIT/bUP49Eeby5q3gnUxhvYc5Z6B+WOfiCE4ztSxo1xhNsRpSmDg9E43UA2iSFFlxEfvDIV7Qa057lUKL8a4=
X-Received: by 2002:a17:907:7204:b0:98e:4f1:f987 with SMTP id
 dr4-20020a170907720400b0098e04f1f987mr16433263ejc.3.1697095587164; Thu, 12
 Oct 2023 00:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-3-seanga2@gmail.com>
 <CAPnjgZ3yH1G13F1r2U00r=sD1mTEn+sY3G0-ggpRvfpLaUxNDA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3yH1G13F1r2U00r=sD1mTEn+sY3G0-ggpRvfpLaUxNDA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 12 Oct 2023 09:26:15 +0200
Message-ID: <CAOf5uw=p=o_50ZzeECEgcqYnaRqJgcRutMQHkyK6dWgUHEEBZg@mail.gmail.com>
Subject: Re: [PATCH 02/26] spl: nor: Don't allocate header on stack
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Roger Quadros <rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 12, 2023 at 5:45=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
> >
> > spl_image_info.name contains a reference to legacy_img_hdr. If we alloc=
ate
> > the latter on the stack, it will be clobbered after we return. This was
> > addressed for NAND back in 06377c5a1fc ("spl: spl_legacy: Fix NAND boot=
 on
> > OMAP3 BeagleBoard"), but that commit didn't fix NOR.
> >
> > Signed-off-by: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> >  common/spl/spl_nor.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
 Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
