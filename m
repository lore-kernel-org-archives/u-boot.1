Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816AAE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 21:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31155805E9;
	Thu,  9 Jan 2025 22:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="DjnZr+k3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3A0800D0; Thu,  9 Jan 2025 20:41:35 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B34A8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 20:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=david.regan@broadcom.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f2f5e91393so254521a91.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1736451690; x=1737056490; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JWD+e4ehn6aGsAU55QB2ORYSdPgAm52iuEhteLmTJLc=;
 b=DjnZr+k3LtpF1bNZHxHi8vSo8hhCFHfLMM1Dhm+XYSf2DQhYtB70sp/TBKNVJlB5u9
 FczbRXcyhIw6Z80MrnOFbZPFn/thWRWKcsM6+Y//H9OjG/9ngVXoTxxkVbfNvbf6ugLu
 Yf2yaRHOKh1el3bBA6X4mBfOo6forihzpjips=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736451690; x=1737056490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWD+e4ehn6aGsAU55QB2ORYSdPgAm52iuEhteLmTJLc=;
 b=PRU+usxI+ZSvyR805CaNvIRZuq387s07M1mT75p7G99xW8VVgVSvd3wosGGOmjA2SH
 ZyfnRA73q6FQ9sGdZ2Snc+FP6b0rfoJMh4J/l1PRBBTRjMS3Udj126YVbK4FOCVqKPae
 Qs0yzVE76Nl+IlPGvFjvnB0jRgCiDWFsOlTJJNJ1ul985hdyd/fdt3S+EBJ+m9wD2EJU
 l06Ijm2Aq4nynwjVMx1D3XbEGjXd4aNub0e63YM2SH/h7FBkNNCya/TCju8ZRYKfrM3l
 fcC689FcztYqUMdkHOPl2rg9qWYgFO3MLJtDlL/VVuY+r4jB5trtUi4RiN/DgJl78QRX
 o2jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ9WUVHV6aW7hqVkGatFysttrYPJ73IXvOvR3VpGzZri2NkddAeson0qY6VQiadzHgRp2Zevc=@lists.denx.de
X-Gm-Message-State: AOJu0YwjLTmsluMIKdJlOQo1ck6VCsXBxPuNkZ6euSw563y0Xo5Y/DZg
 jGliACAOzKVT/oxjHQq2IyERCAl0Dr4fLEmJ65OT3kSD21COU5H6TFVdztHGkIHYNKrPie2E2fS
 0j4e3prWLOfXfugIo6R6zRKbyhhiuJTjODFxQ
X-Gm-Gg: ASbGncsvi/8xyTfSjBPscmLqqoFZPYUh//ByBdqQAYXMcQS9G/+g38R7A5oTBBAWDUT
 M8szlvOFg6w7g19VJGR7Qtj+xBZAsAovIZznL+Y4=
X-Google-Smtp-Source: AGHT+IG3i29aDqDnAxyc+gSFKx1BIseEenN+josBBQq+1oHQ0b7zaNWABoS0gM1EAMEfA4DC4Ja9aP56EYx3h11LdvE=
X-Received: by 2002:a17:90a:f945:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2f548eb3faamr4140769a91.3.1736451690064; Thu, 09 Jan 2025
 11:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20241219184953.226978-1-dregan@broadcom.com>
 <20241219184953.226978-3-dregan@broadcom.com>
 <CACRpkdZKL7-KQ7u=Y1Vm5AY1mzJbzS9BtJ0W_XZW8EFRF1Yjcg@mail.gmail.com>
 <CAA_RMS450FuLAg0J=arP2mDKDJqZv5Tcd6w1_C6-jhLwKMDzQQ@mail.gmail.com>
In-Reply-To: <CAA_RMS450FuLAg0J=arP2mDKDJqZv5Tcd6w1_C6-jhLwKMDzQQ@mail.gmail.com>
From: David Regan <dregan@broadcom.com>
Date: Thu, 9 Jan 2025 11:41:19 -0800
X-Gm-Features: AbW1kvZK6C00l3BaMysyqvxRBSUGjRopeXhDbYzvPBPpAKzQnqMea1uuJk9G8UA
Message-ID: <CAA_RMS7KLBJ2krwywKLiTTXtCkB1Vg9MZ1kr_GaTXDkzyJ023Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: Update nand node for bcmbca board dts
To: David Regan <dregan@broadcom.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de, 
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
X-Mailman-Approved-At: Thu, 09 Jan 2025 22:34:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I'm not seeing any response back from the author and since I didn't create
the files I will post a patch
update taking into account other suggestions but leave the original
non-strap settings in place.

-Dave

On Fri, Dec 20, 2024 at 2:18=E2=80=AFPM David Regan <dregan@broadcom.com> w=
rote:

> On Fri, Dec 20, 2024 at 12:04=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org>
> wrote:
> >
> > On Thu, Dec 19, 2024 at 7:50=E2=80=AFPM david regan <dregan@broadcom.co=
m> wrote:
> >
> > > Update bcmbca dts to current nand node naming convention.
> > >
> > > Signed-off-by: david regan <dregan@broadcom.com>
> > > Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > > Reviewed-by: Anand Gore <anand.gore@broadcom.com>
> >
> > Looks like a reasonable step
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > But:
> >
> > > -       nandcs@0 {
> > > -               compatible =3D "brcm,nandcs";
> > > -               reg =3D <0>;
> > > -               nand-ecc-strength =3D <4>;
> > > -               nand-ecc-step-size =3D <512>;
> > > -               brcm,nand-oob-sector-size =3D <16>;
> > > -       };
> > > +&nandcs {
> > > +       nand-on-flash-bbt;
> > > +       nand-ecc-strength =3D <4>;
> > > +       nand-ecc-step-size =3D <512>;
> > > +       brcm,nand-oob-sector-size =3D <16>;
> >
> > So you're adding nand-on-flash-bbt, maybe we should notice this?
>
> We don't need this option, I'll remove it.
>
> >
> > Do you have to use the explicit ECC config, or can you just use
> > Williams new option
> > brcm,nand-ecc-use-strap;
> > ?
>
> Looks like Phillipe Reynes created this file, Phillipe do you have a
> preference?
>
> >
> > (This can be changed in an additional patch.)
> >
> > Yours,
> > Linus Walleij
>
> Thanks for your input!
>
> -Dave
>
