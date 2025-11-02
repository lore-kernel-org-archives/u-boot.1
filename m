Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D315FCCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63405838CC;
	Sun,  2 Nov 2025 20:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q7dGunyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107FD838E7; Sun,  2 Nov 2025 20:54:19 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81E2830A0
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-640b2a51750so1032735a12.0
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113256; x=1762718056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4PVRcIFmA9mocovxQVI7ucuq5bG/LgvxBOkIpFyHJTo=;
 b=Q7dGunyXnvEg7DROs7MqoaABst8OSQcBbwmUFU5biJ/fd8NTaqjfQHkMpg+7abBwWc
 YNJ2W+Y1LmyIbMosNq0hNxOPWI6gWyLTF0/vlsUFLWGRzBJSHP46RX4Gujmf+6YYNCWw
 GL/1n5U5mAg5J4okUcoEhMafev18EgIn9VzTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113256; x=1762718056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4PVRcIFmA9mocovxQVI7ucuq5bG/LgvxBOkIpFyHJTo=;
 b=K+Tmz97gs4Bbkn1/hZuLcV37mPSpxMSNJ3K+6amzESWkQrVEzwPzvQcF7GyreaVTkL
 QmxJpi+ikSC2nYXY+QfsIaL6qZe08/FkhBQfr7LDuQFg+gikA9MeX3ixhmuo6aEKLVIL
 PROjqUxWpMi3/mfL5vxdE6KnTjPwcdynJq5NGPtVLsP5E3LYetSBbIGONSOouLGaId3k
 t0d2NYa6N531DRHVhVNqtuS26i7O89UsCVAlQB7c8JYpoTmdjXD/Z8xydrwN0xTHjYMX
 ubVyswCUH2LpQuejZTNgn8wLRr0o92oVPwcQb4XVLvQD4Kf1I1/5k0istMMNGgtBkTwb
 1aPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXduzthRMZaNEMZknra+7r/LqvTwtOImA2xS6dRq4cbSCsUEhYxnBIKJIdj48v9Nro1pRI7Mmc=@lists.denx.de
X-Gm-Message-State: AOJu0YwIIqfcvw/kICKZP1pWjopFjS1MszlaLVLBXPDDmc+1rSGP9OPB
 kt84YFoWAJUW18Cp1JHhAOSCyJ61Myz2Oq+bBGsTRkaKSXK0JDOIb1G2+WRS+IRK0hOG+g09oDK
 u5LYWCKs/9sXXc+/F2p4uhD2BWkHFimYnj0EtP7IM
X-Gm-Gg: ASbGncsaq7z/gt4SEPl1xJKer/O95CBajj5vxGpUtK/Yji/IENaj2Vgjp1povTJQLsE
 30Al0HMHUthJowQbDaozf79m8jMx0DPQ/wwcWa1EWtpLQWvDNYe3Ls8K8dOtz/pKrnk9dYn3pe2
 hUUkTHdfWeDifxoql0T0Ea/RiWAno7ddMa6kn7CUIG5R9L4z//uso3ClwcwV3lcMfy5/ZIyXuxp
 cSIZ0BuMLjwIPFEwFoegVpWnWpVhtMDOs6PpD5dhDgc5Si65lT3ChRsYFeoyVAknTKYuPYt
X-Google-Smtp-Source: AGHT+IGXUeTXGhjqYXW6Dunw0RJjkyTBKVQ0F5gU00AV/2lOOjF3YODRwRJLI4CeCvbd1yvD3AI/hwDHds2Yw2ImFz8=
X-Received: by 2002:a17:907:3da7:b0:b1d:285d:185d with SMTP id
 a640c23a62f3a-b706fe2d658mr1093432366b.0.1762113256075; Sun, 02 Nov 2025
 11:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-1-b42847884974@foss.st.com>
 <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
 <aQavXq6jVagkIa53@thinkstation>
In-Reply-To: <aQavXq6jVagkIa53@thinkstation>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:53:43 +0100
X-Gm-Features: AWmQ_blxBK7i8H7pxtavLpVYErx4InspOeRjgchXJTJe7SWrzcj70gU7RXDBI0M
Message-ID: <CAFLszThdV7cZ-uBXzqRYWv-HsGbNJV9BVKVOC4FQUD1yjZDNkg@mail.gmail.com>
Subject: Re: [Uboot-stm32] [PATCH v3 1/7] ofnode: support panel-timings in
 ofnode_decode_display_timing
To: =?UTF-8?Q?Rapha=C3=ABl_Gallais=2DPou?= <rgallaispou@gmail.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Sumit Garg <sumit.garg@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min <dillon.minfei@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
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

Hi Raphael,

On Sun, 2 Nov 2025 at 02:10, Rapha=C3=ABl Gallais-Pou <rgallaispou@gmail.co=
m>
wrote:
>
> Le Sat, Nov 01, 2025 at 10:03:59AM +0100, Simon Glass a =C3=A9crit :
> > Hi Raphael,
> >
> > On Thu, 4 Sept 2025 at 14:53, Raphael Gallais-Pou
> > <raphael.gallais-pou@foss.st.com> wrote:
> > >
> > > The "Display Timings" in panel-common.yaml can be provided by 2
properties
> > > - panel-timing: when display panels are restricted to a single
resolution
> > >                 the "panel-timing" node expresses the required
timings.
> > > - display-timings: several resolutions with different timings are
supported
> > >                    with several timing subnode of "display-timings"
node
> > >
> > > This patch update the parsing function to handle this 2 possibility
> > > when index =3D 0.
> > >
> > > Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > > Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> > > Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> > > ---
> > >  drivers/core/ofnode.c | 17 ++++++++++-------
> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > > index
e040e3f2806ffe74c58dcd82f36307351acd5a99..5a721b46e5a3214e7bd437739776362c2=
d22a3c9
100644
> > > --- a/drivers/core/ofnode.c
> > > +++ b/drivers/core/ofnode.c
> > > @@ -1221,13 +1221,16 @@ int ofnode_decode_display_timing(ofnode
parent, int index,
> > >         int ret =3D 0;
> > >
> > >         timings =3D ofnode_find_subnode(parent, "display-timings");
> > > -       if (!ofnode_valid(timings))
> > > -               return -EINVAL;
> > > -
> > > -       i =3D 0;
> > > -       ofnode_for_each_subnode(node, timings) {
> > > -               if (i++ =3D=3D index)
> > > -                       break;
> > > +       if (ofnode_valid(timings)) {
> > > +               i =3D 0;
> > > +               ofnode_for_each_subnode(node, timings) {
> > > +                       if (i++ =3D=3D index)
> > > +                               break;
> > > +               }
> > > +       } else {
> > > +               if (index !=3D 0)
> > > +                       return -EINVAL;
> > > +               node =3D ofnode_find_subnode(parent, "panel-timing");
> > >         }
> > >
> > >         if (!ofnode_valid(node))
> > >
> > > --
> > > 2.25.1
> > >
> >
> > Please add a test for this in test/dm/ofnode.c
>
> Hi Simon,
>
> I'll gladly do that, but I haven't write and use any test in U-Boot.  So
> it is a bit foggy how to implement it.

There is some info here:

https://docs.u-boot.org/en/latest/develop/testing.html

>
> Do we want to create a fake device-tree and test each configuration or
> do we want to test in the _current_ device-tree if timings are correctly
> set according to the index value ?

It looks like there is a 'display-timings' node in test.dts, with three
subnodes, so you should just be able to get an ofnode for that and then
read out one of them and check it.

Regards,
Simon
