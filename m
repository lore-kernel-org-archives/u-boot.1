Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FD4C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 13:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF13826AA;
	Mon,  9 Jun 2025 15:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SK7I74tB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1393A82998; Mon,  9 Jun 2025 15:38:49 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A17811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 15:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70e767ce72eso39201147b3.1
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749476324; x=1750081124;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIDrbDKaGVvC5LkNwSJcJ/SKNA2PP1OpI4qOU8ZINMA=;
 b=SK7I74tBbygnFEuTFbd4rTgOeGeYCda7wRJJnhxMDu2ix83+h8A4P1K5iWMzzyHJ6K
 zODQ5P2p05BiQh14eHQyzgWW+8mnqaVfBnqDMAe9x6YNTn81YoqDYWyxBBPrNMMr+xmX
 tvIbAllAbINJpgfbPYvo02bhut516HSweOPLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749476324; x=1750081124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIDrbDKaGVvC5LkNwSJcJ/SKNA2PP1OpI4qOU8ZINMA=;
 b=YgBPi4x0zRgyxBohS3wC1+dqFYuOvlXC8QnAA7//4VjnF7Kn1Vb1FaV9YUqCOSRxGA
 cz2rrUIzIAlZCcOHi1gyI7w3bLmWhSDjyWwNHEWi/pNYZ9jH10zb+/WQa/WqLYkkvpUr
 Mpl+KvGLK/lq/v+HDdSIbSwNNllKBJqqoQpk7GStOqXVsFJJhRdjnj/U4rsmO9XuC0sy
 1mBxAkvF/gs/gXebiBVsgdsx7q+qGdvIgKo4bRb+qVZbHmWosWy3jIBeUZRt35f9x+ku
 rEWVxMkSIp1QP4O8lf56w3i07HilTFfT2yVWWYhdlaQtFCsMwzSmo/39kJ0Uu/ClCXqx
 kCOA==
X-Gm-Message-State: AOJu0YxaqPVM8kzLa1cbC2Bmg+1Fw6EUWSsacFzJ9Re4PaFY5kVEM2Fn
 nOFnKfResw1NDk/ZVjYZlz3Wg3nVZgKAbxbP3fILPt9hpvEKiRmlS0UQzXqG4r4DSwAvB25qjRi
 qggsrVdwjk/nXV5HcXjYHHdzu+xr7z6qGlyLRtVZasYEnYeDywuB0ayE=
X-Gm-Gg: ASbGncte3UhwGXWY4ZLU6YKwMCwRGRKR6ORkfS2U82uggRH9getPyJVKp09Emkrn4bx
 9RA7eJ2EK/YAoyXDmhT07c4HMDC9RkMMWXqtkUuEDhnX+fbtAdY0Pl9zWv3Bd2/fLlLi4E5P9v8
 40wodo+mB8kMwcghsFLHKvsXxAMDipDA==
X-Google-Smtp-Source: AGHT+IGDJ96HfkSVu0jPauUwZ8SmQu3vA6jLq66Cfm4TgbMX3SWf02GOV90fzVTDcVX66rm548zvA0o7t/Y+WFVBi/A=
X-Received: by 2002:a05:690c:4b81:b0:710:f738:7125 with SMTP id
 00721157ae682-710f769a871mr193941197b3.19.1749476324671; Mon, 09 Jun 2025
 06:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <20250607093730.2249536-2-dario.binacchi@amarulasolutions.com>
 <aEbflAM3LY5thVwf@sumit-X1>
In-Reply-To: <aEbflAM3LY5thVwf@sumit-X1>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 9 Jun 2025 15:38:33 +0200
X-Gm-Features: AX0GCFv_19AHT8e6hljKeL9nZ8wnwIjbRbix_5KxmS-7cmvhnj1euCTaO_2dqBY
Message-ID: <CABGWkvqFXjfc8a94LWJMk4TtRVLpRcbMzxYJ3mcrc-y1+2cjQw@mail.gmail.com>
Subject: Re: [PATCH 1/9] ARM: dts: stm32h7-pinctrl: add _a suffix to
 u[s]art_pins phandles
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
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

Hi Sumit,

On Mon, Jun 9, 2025 at 3:20=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> Hi Dario,
>
> On Sat, Jun 07, 2025 at 11:37:09AM +0200, Dario Binacchi wrote:
> > Allow expanding possible configurations for the same peripheral,
> > consistent with the scheme adopted in Linux.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > Link: https://lore.kernel.org/r/20250427074404.3278732-2-dario.binacchi=
@amarulasolutions.com
> > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> >
> > [ upstream commit: 6a36dca4375fce51b627f5a985a79fc8b8bd7f55 ]
> >
>
> This doesn't show as a proper cherry-pick from devicetree-rebasing tree,
> following fails for me:
>
> $ ./tools/update-subtree.sh pick dts 6a36dca4375fce51b627f5a985a79fc8b8bd=
7f55
> From https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetre=
e-rebasing
>  * branch                    master     -> FETCH_HEAD
> fatal: bad object 6a36dca4375fce51b627f5a985a79fc8b8bd7f55
>
> Has this patch landed in Linux mainline?

Yes, it has already merged in mainline:

git tag --contains 6a36dca4375fce51b627f5a985a79fc8b8bd7f55
v6.16-rc1

Thanks and regards,
Dario

>
> Ditto for all the subsequent patches in this series.
>
> -Sumit
>
> > ---
> >
> >  dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi  | 8 ++++----
> >  dts/upstream/src/arm/st/stm32h743i-disco.dts  | 2 +-
> >  dts/upstream/src/arm/st/stm32h743i-eval.dts   | 2 +-
> >  dts/upstream/src/arm/st/stm32h750i-art-pi.dts | 6 +++---
> >  4 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi b/dts/upstrea=
m/src/arm/st/stm32h7-pinctrl.dtsi
> > index 7f1d234e1024..ad00c1080a96 100644
> > --- a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
> > +++ b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
> > @@ -198,7 +198,7 @@
> >               };
> >       };
> >
> > -     uart4_pins: uart4-0 {
> > +     uart4_pins_a: uart4-0 {
> >               pins1 {
> >                       pinmux =3D <STM32_PINMUX('A', 0, AF8)>; /* UART4_=
TX */
> >                       bias-disable;
> > @@ -211,7 +211,7 @@
> >               };
> >       };
> >
> > -     usart1_pins: usart1-0 {
> > +     usart1_pins_a: usart1-0 {
> >               pins1 {
> >                       pinmux =3D <STM32_PINMUX('B', 14, AF4)>; /* USART=
1_TX */
> >                       bias-disable;
> > @@ -224,7 +224,7 @@
> >               };
> >       };
> >
> > -     usart2_pins: usart2-0 {
> > +     usart2_pins_a: usart2-0 {
> >               pins1 {
> >                       pinmux =3D <STM32_PINMUX('D', 5, AF7)>; /* USART2=
_TX */
> >                       bias-disable;
> > @@ -237,7 +237,7 @@
> >               };
> >       };
> >
> > -     usart3_pins: usart3-0 {
> > +     usart3_pins_a: usart3-0 {
> >               pins1 {
> >                       pinmux =3D <STM32_PINMUX('B', 10, AF7)>, /* USART=
3_TX */
> >                                <STM32_PINMUX('D', 12, AF7)>; /* USART3_=
RTS_DE */
> > diff --git a/dts/upstream/src/arm/st/stm32h743i-disco.dts b/dts/upstrea=
m/src/arm/st/stm32h743i-disco.dts
> > index 2b452883a708..8451a54a9a08 100644
> > --- a/dts/upstream/src/arm/st/stm32h743i-disco.dts
> > +++ b/dts/upstream/src/arm/st/stm32h743i-disco.dts
> > @@ -105,7 +105,7 @@
> >  };
> >
> >  &usart2 {
> > -     pinctrl-0 =3D <&usart2_pins>;
> > +     pinctrl-0 =3D <&usart2_pins_a>;
> >       pinctrl-names =3D "default";
> >       status =3D "okay";
> >  };
> > diff --git a/dts/upstream/src/arm/st/stm32h743i-eval.dts b/dts/upstream=
/src/arm/st/stm32h743i-eval.dts
> > index 5c5d8059bdc7..4b0ced27b80e 100644
> > --- a/dts/upstream/src/arm/st/stm32h743i-eval.dts
> > +++ b/dts/upstream/src/arm/st/stm32h743i-eval.dts
> > @@ -145,7 +145,7 @@
> >  };
> >
> >  &usart1 {
> > -     pinctrl-0 =3D <&usart1_pins>;
> > +     pinctrl-0 =3D <&usart1_pins_a>;
> >       pinctrl-names =3D "default";
> >       status =3D "okay";
> >  };
> > diff --git a/dts/upstream/src/arm/st/stm32h750i-art-pi.dts b/dts/upstre=
am/src/arm/st/stm32h750i-art-pi.dts
> > index 44c307f8b09c..00d195d52a45 100644
> > --- a/dts/upstream/src/arm/st/stm32h750i-art-pi.dts
> > +++ b/dts/upstream/src/arm/st/stm32h750i-art-pi.dts
> > @@ -197,14 +197,14 @@
> >  };
> >
> >  &usart2 {
> > -     pinctrl-0 =3D <&usart2_pins>;
> > +     pinctrl-0 =3D <&usart2_pins_a>;
> >       pinctrl-names =3D "default";
> >       status =3D "disabled";
> >  };
> >
> >  &usart3 {
> >       pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&usart3_pins>;
> > +     pinctrl-0 =3D <&usart3_pins_a>;
> >       dmas =3D <&dmamux1 45 0x400 0x05>,
> >              <&dmamux1 46 0x400 0x05>;
> >       dma-names =3D "rx", "tx";
> > @@ -221,7 +221,7 @@
> >  };
> >
> >  &uart4 {
> > -     pinctrl-0 =3D <&uart4_pins>;
> > +     pinctrl-0 =3D <&uart4_pins_a>;
> >       pinctrl-names =3D "default";
> >       status =3D "okay";
> >  };
> > --
> > 2.43.0
> >



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
