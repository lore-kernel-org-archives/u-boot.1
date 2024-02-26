Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B28FC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 06:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D386487E39;
	Mon, 26 Feb 2024 07:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CYyx/uLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA7987E47; Mon, 26 Feb 2024 07:59:23 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B634D87E06
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 07:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso2647378a12.2
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 22:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1708930761; x=1709535561;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Kk6XZ9aKDj2nh91jgps2t9icBOwXclaEsDLJw/HpcI=;
 b=CYyx/uLokI2kfvDXAqyHNe63UT1YNSWM4iQXpRNfWOzz1seGG9FzbGkz+6yWGm+CDT
 f/MnPp5d29acNfvfnvoHavnHL+VLpqYPNsfu3wuIdfILUaKqgvUfEZI4vvoHwzdmm1l9
 ssWGZ4uMdlhNxwBr9SB1Hxj5Y43gIXJWrNUV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708930761; x=1709535561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Kk6XZ9aKDj2nh91jgps2t9icBOwXclaEsDLJw/HpcI=;
 b=EaTYfntzLwKPfI+DVuuQom9bLRNyIIlXpaDvwsfCeStPCSQb25Bpg2RBEPQl4y5w+E
 SR1E7vAXgBGJbTlDQ91ERt+NYg2pZXMAfLhuh0aZJvFKfbhKNCGopF3ju+5BEWBe6tOi
 daEo2BZ1C7fTwjaVYVz8IFiOGZnq7BxDxqkZlUOnC5qSUKKAIHzM33ggGXgwqaphjr5B
 eHEGuk/WPX0ze0R63zMrpcluhx9/3nteDrQ+nx2DxDT7AVAk+HXmnRz5g3qYFhlylovg
 nkLSrTf26AkEZpHh4muae1+Gj8s5BSDwtLysB9q4KgG7E9zLIOGS3XfKl2mOGJM+SLux
 ujGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaFA89ceJ5y+w4mbFHMzM9w/4pZPaMi0R+5To+qyAcFXbJ9fg5bWbQWLj8zWiBPpenex9TnP8ro0QiQhVo+D6CPhcGug==
X-Gm-Message-State: AOJu0YyylqQHaV8DzeU7SNft9PMK+cJv9eb9NqBfvarCEh4ApfKGca4l
 cnDHrxpIP4yUyUOx8ezD2f4PHa6k6UnOSuwpvMyvTYK/0im40kdNaV1zBW0FQ/9RNd2IqhuxYxn
 4hH2zWJcpOqn0rmTRLecofYy62bZk4n41fVwqCw==
X-Google-Smtp-Source: AGHT+IEdANcdE/apmlzZuuoF4V5UdLsMlOgWBjXSA0+BNoP9dy8YENBx4tj+Fpo/TNoEhtAVkjhfegUcQTnwggLs4y0=
X-Received: by 2002:aa7:c919:0:b0:565:ff53:5359 with SMTP id
 b25-20020aa7c919000000b00565ff535359mr479543edt.41.1708930760974; Sun, 25 Feb
 2024 22:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20240225173834.1637789-1-michael@amarulasolutions.com>
 <c7a255a0-dbc6-4cdb-b46c-3b81d17ce30c@ti.com>
In-Reply-To: <c7a255a0-dbc6-4cdb-b46c-3b81d17ce30c@ti.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Feb 2024 07:59:08 +0100
Message-ID: <CAOf5uwkVA24aX2_=aJMGa=vayHpKpNF71+iiYYqC1vZPjFKpbA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: k3-binman: Make optee optional as requirement
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 "Raghavendra, Vignesh" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, linux-amarula@amarulasolutions.com
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

Hi

On Mon, Feb 26, 2024 at 4:17=E2=80=AFAM Neha Malcom Francis <n-francis@ti.c=
om> wrote:
>
> Hi Michael
>
> + Vignesh
>
> On 25/02/24 23:08, Michael Trimarchi wrote:
> > Boards can use the ti_spl_template but avoid to define a tee
> > node to be loaded. This is true form board with 512Mb or less
>
> s/form board/for boards? I am guessing that is what was meant. I am not r=
eally
> understanding the commit message... does <512MB memory always mean no usi=
ng
> OPTEE? (AM62 SIP would be an exception) The commit message is putting out=
 a
> misleading reason why we don't need OPTEE in some cases, I don't think me=
mory is
> the primary reason.
>

I will adjust commit message. In general when you have module with 256
Mb of memory you
try to arrange the available memory to put the essential components.
Anyway having still not
submitted board I found out that is convenient to use the template but
in the same time remove
from my configuration what is not mandatory and let binman to warning
and not to fail

Michael

> > memory. We can limit this in configuation removing the tee
>
> s/configuation/configuration
>
> > node
> >
> > configurations {
> >       default =3D "conf-0";
> >
> >       conf-0 {
> >               description =3D "k3-am62_ccm_m3";
> >               firmware =3D "atf";
> >               loadables =3D "dm", "spl";
> >               fdt =3D "fdt-0";
> >       };
> > };
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >   arch/arm/dts/k3-binman.dtsi | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> > index 758c8bf6ea..5ef5af315a 100644
> > --- a/arch/arm/dts/k3-binman.dtsi
> > +++ b/arch/arm/dts/k3-binman.dtsi
> > @@ -293,6 +293,7 @@
> >                                               keyfile =3D "custMpk.pem"=
;
> >                                       };
> >                                       tee: tee-os {
> > +                                             optional;
> >                                       };
> >                               };
> >
> > @@ -360,6 +361,7 @@
> >                                       entry =3D <0x9e800000>;
> >                                       tee-os {
> >                                               filename =3D "tee-raw.bin=
";
> > +                                             optional;
> >                                       };
> >                               };
> >
>
> The patch excluding the commit message LGTM.
>
> --
> Thanking You
> Neha Malcom Francis



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
