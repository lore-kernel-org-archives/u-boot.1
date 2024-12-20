Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ECFE77184
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 07:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB04803E0;
	Sat, 21 Dec 2024 08:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="c1SF7Rbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC126803B5; Fri, 20 Dec 2024 23:18:46 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C11E8034E
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 23:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=david.regan@broadcom.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2162f968cd7so2718475ad.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 14:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1734733122; x=1735337922; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGF/vxPzSCi3oluHi3hNOUxtnzOmSkP3Fc+rlGPo3FY=;
 b=c1SF7RbtmIlNaLk0T12GQI3OSfnfjbbZlVE2oIhqStXmd2UsRx/kiRRrO93nuuKrF5
 xM1EgglaFCduPV5Nyxov7WnGI6fW0C10DQxJmTzjUTUTyqrj+wVNIkPvXYkz+pCr8/Xu
 x6BUQJ50Gc7055d5W28eXINRKLyEi/picDPRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734733122; x=1735337922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGF/vxPzSCi3oluHi3hNOUxtnzOmSkP3Fc+rlGPo3FY=;
 b=aqnKMgyxWkfRAnWs0T68/4PqpA0P1IeakAThP/8G85sp815j32Xs5AcWSQ9QmVmT7I
 35NN7LxOp7Kwz19nmakmGyKYJHQoXebvKm6creGDUIXDO6ifJvl3rAODMsvSi6DRNVTD
 1/sgGXK4Bki9W46OqXuaD3lH4X6GnOS1iyx2uvH7d3DHsDGjO6eWJyf3dN+I4MSQJAjR
 pxGyDANUc3N9YJx01kQqFu8SCfpcc1Zv/0Q8QY+4HLvIrybVghAt9s4rb7LaSfccHOUV
 i7l8W7SIkxlhsIzEEqEtE+W0TEp1Ir3++nZxRm3rpStOWKm19X/lv/6+Ovffw2oQkoxw
 cSEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB1vBgLstOEcPzwNnZlRsrskPz2UxxNsDXIVNEiCkvJW6ZeARE0YcPZ87/ZFtl7caEMr2yQco=@lists.denx.de
X-Gm-Message-State: AOJu0YwsofKPykAEsDZJb6usgKJ97rmxhkp6vwdnZz4w9QSijlfhFTEJ
 mQB6LhGZ4S6QzlpvHBCFxu01N1vrH3z9oxLj3R6QPeH0ney0iCmPSL6lSxxZy7ScW1vrMYRHZAk
 6DHQOuFLcvXkSCMomuOUmWRoHolWtqy9d/mSy
X-Gm-Gg: ASbGncvDuaMGxwBzSvU4YnAmcwmGd4nyimkESoRnI7TsumcI5HYBvXGxW965/YjNI6i
 TPlAWBYYMMtus+grQbd0hAW3vuxO7R06G5i8OQbg=
X-Google-Smtp-Source: AGHT+IHTmdelEFOGXyg40yVVCi5iibUDOhA/DncQ52y77i244zxzGx5Vp/SZk/wqcTH/j4bvrkAeWw+IOXnAfEY4xVU=
X-Received: by 2002:a17:90b:520a:b0:2ee:f1e3:fd0c with SMTP id
 98e67ed59e1d1-2f452efa94bmr2638926a91.8.1734733121935; Fri, 20 Dec 2024
 14:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20241219184953.226978-1-dregan@broadcom.com>
 <20241219184953.226978-3-dregan@broadcom.com>
 <CACRpkdZKL7-KQ7u=Y1Vm5AY1mzJbzS9BtJ0W_XZW8EFRF1Yjcg@mail.gmail.com>
In-Reply-To: <CACRpkdZKL7-KQ7u=Y1Vm5AY1mzJbzS9BtJ0W_XZW8EFRF1Yjcg@mail.gmail.com>
From: David Regan <dregan@broadcom.com>
Date: Fri, 20 Dec 2024 14:18:30 -0800
Message-ID: <CAA_RMS450FuLAg0J=arP2mDKDJqZv5Tcd6w1_C6-jhLwKMDzQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: Update nand node for bcmbca board dts
To: Linus Walleij <linus.walleij@linaro.org>
Cc: david regan <dregan@broadcom.com>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 21 Dec 2024 08:14:43 +0100
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

On Fri, Dec 20, 2024 at 12:04=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Thu, Dec 19, 2024 at 7:50=E2=80=AFPM david regan <dregan@broadcom.com>=
 wrote:
>
> > Update bcmbca dts to current nand node naming convention.
> >
> > Signed-off-by: david regan <dregan@broadcom.com>
> > Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > Reviewed-by: Anand Gore <anand.gore@broadcom.com>
>
> Looks like a reasonable step
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> But:
>
> > -       nandcs@0 {
> > -               compatible =3D "brcm,nandcs";
> > -               reg =3D <0>;
> > -               nand-ecc-strength =3D <4>;
> > -               nand-ecc-step-size =3D <512>;
> > -               brcm,nand-oob-sector-size =3D <16>;
> > -       };
> > +&nandcs {
> > +       nand-on-flash-bbt;
> > +       nand-ecc-strength =3D <4>;
> > +       nand-ecc-step-size =3D <512>;
> > +       brcm,nand-oob-sector-size =3D <16>;
>
> So you're adding nand-on-flash-bbt, maybe we should notice this?

We don't need this option, I'll remove it.

>
> Do you have to use the explicit ECC config, or can you just use
> Williams new option
> brcm,nand-ecc-use-strap;
> ?

Looks like Phillipe Reynes created this file, Phillipe do you have a prefer=
ence?

>
> (This can be changed in an additional patch.)
>
> Yours,
> Linus Walleij

Thanks for your input!

-Dave
