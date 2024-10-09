Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6685ACEE34D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4547988CAE;
	Wed,  9 Oct 2024 23:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="icJqTYTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4BBD88D1C; Wed,  9 Oct 2024 23:10:06 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DCD88CAE
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99422c796eso39319866b.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728508204; x=1729113004; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irmgEIgOOflRc1b0+n/4jVuGyds1CyCvPTJDmmlVkTE=;
 b=icJqTYTBXzVzObvC61+EIpT9BnnbqUZieEb12QYanYjX+Cr57O/V74vHqHmLe8M41i
 +WCoiRI2+Uh44aCFAOtut9SUhMgzc8T7syczyFb0amBkiNHLc6tRmcLrmzWHgBiPMFVg
 TjN68/yiCREEwM3m/rJbWalH40bo6iEgmN97JWOU9ta34CCHll5CoSbaQuTsWKGjZnYr
 zlR6EO62JQJNNyrDap5vUVrj6IwfiV0j78tAasKrfiItj9fXiDSjAn7AjiahL9ACrlEw
 rIKp8XZB0OsR1wR+AlBYa4SAkFwQvqqudXkHvR8k9EHwf22Er/oqKAa3GO/eS8MoyDmn
 II3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728508204; x=1729113004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irmgEIgOOflRc1b0+n/4jVuGyds1CyCvPTJDmmlVkTE=;
 b=JsPLpLS3GRE1vA6XnOIWm4jSU7h+MJ9qs8xpum73iZDWSrzDKlFEG6uf+g2rLL3M/7
 ZSSXBYljsjglF8Wpf/dOj1tXOmKXJdz8moeBOEHkQEbmjuu6j68wAorDlgRU6b4aHKgU
 oNMtIREF9ko90RomciguP0no1b6agBTFs/UOdyJl89foNa4IQMXXQBnYNPpAlRHc7iGL
 af8Si16o6+dUwxBP61Iv2RgNGpI8NZX7LSWGqtlcZPAghsYfbp/rwT/yNtiQhuEZxsze
 KZSGAeXI8CL5Xb0jpUZvE1vwNBHXXv5PKQlbFweH9uclQvg0851fE9nxXdp8uxhSSxnf
 t7fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFYgWd8Anyz2hWRmqf3tOCRBm2vi6AdFjmYIbu2oL+VOiPcCIDDpxmm9ORIbyLcymM71UegiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyWn466OaBdYPl/zHD9qBcUE8Xfm+zO+tHpyOtswKyIpCrWpEhD
 qjyjG9Ii38vXSAIkwd3+AKbUXkKayS6AoW05Xq2i7CqpHUXFbP+c64rILSm4XdxYQB1kPcZZmTU
 WPxOuE6iEm9VVI1NsuTI0JGUJGh9lAC1U
X-Google-Smtp-Source: AGHT+IGlyZ6jIT1KGtFz4u9CaCRqYwvOLalN8X4CkP+szF5E56IEzvaxk3p3dU7N4SBzBE9SbCKTXa5oun9fm6kw5Us=
X-Received: by 2002:a17:906:f5a7:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a999e628dd6mr120909466b.13.1728508204164; Wed, 09 Oct 2024
 14:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240919135851.153120-1-bigunclemax@gmail.com>
 <87iku2g39d.fsf@baylibre.com>
In-Reply-To: <87iku2g39d.fsf@baylibre.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Thu, 10 Oct 2024 00:09:52 +0300
Message-ID: <CALHCpMhW+BeCB5rptkkJ-e3UDz_JRHN3pLUO3PXNCGVbB-Gkag@mail.gmail.com>
Subject: Re: [PATCH v1] eth: asix88179: drop ADVERTISE_LPACK and
 ADVERTISE_NPAGE advertise flags
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

Hi Mattijs,

=D0=B2=D1=82, 8 =D0=BE=D0=BA=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 15:58, Matt=
ijs Korpershoek <mkorpershoek@baylibre.com>:
>
> Hi Maksim,
>
> Thank you for the patch and sorry for the review delay.
>
> On jeu., sept. 19, 2024 at 16:58, bigunclemax@gmail.com wrote:
>
> > From: Maksim Kiselev <bigunclemax@gmail.com>
> >
> > Some USB-ETH adapters based on the AX88179 (ex. D-link DUB-2312)
> > has link issue if ADVERTISE_NPAGE flag is set.
>
> Do you see the issue only if ADVERTISE_NPAGE is set? What about
> ADVERTISE_LPACK ?

Removing ADVERTISE_NPAGE fixed link issue for me.
But I decided to remove ADVERTISE_LPACK too.
Because I couldn't find any mention of this flag in the Linux driver.

> Could you detail a bit what you mean by link issue?
>
> >
> > Also Linux drivers for ASIX chips doesn't use these flags.
>
> I've double checked this looking on master,
> commit 87d6aab2389e ("Merge tag 'for_linus' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/mst/vhost")
>
> I inspected asix_devices.c and ax88179_178a.c and I could indeed not
> find anything related to ADVERTISE_LPACK and ADVERTISE_NPAGE.
>
> I'm not super knowledgeable on network so I'd like someone else to test
> this as well, if possible.
>
> >
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > ---
> >  drivers/usb/eth/asix88179.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
> > index 4bd3b9d10d..1f469a1a7d 100644
> > --- a/drivers/usb/eth/asix88179.c
> > +++ b/drivers/usb/eth/asix88179.c
> > @@ -345,8 +345,8 @@ static int asix_basic_reset(struct ueth_data *dev,
> >       asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, t=
mp16);
> >
> >       u16 adv =3D 0;
> > -     adv =3D ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_LPACK |
> > -           ADVERTISE_NPAGE | ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CA=
P;
> > +     adv =3D ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_PAUSE_ASYM |
> > +           ADVERTISE_PAUSE_CAP;
> >       asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_ADVERTISE, 2, &adv);
> >
> >       adv =3D ADVERTISE_1000FULL;
> > --
> > 2.45.2
