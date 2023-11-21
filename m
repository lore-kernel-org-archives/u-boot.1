Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F380C61D94
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A932C875A1;
	Tue, 21 Nov 2023 14:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EH4iHk0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388B0875BA; Tue, 21 Nov 2023 14:34:07 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F55387253
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-42033328ad0so32863621cf.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700573643; x=1701178443; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l6AsQLOtLXqnp2TAJl+2PczA8EG2/aLFdDNnU5gerH8=;
 b=EH4iHk0E/ui2vAs8miCJtwToRwTf9Kt59sX4a+uqPZStwQyVcQaHtfR4AtVIlqv+QF
 zMVyoi66+gkxCmgIXu5Sc/BNu3CbmEyQzS+/QdE/UyduGOjOWVoePndzQ4Ie/GWXQIVq
 9oxLINEmJVR6B0uRXuLWrijL7NK5eSsnJAik8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700573643; x=1701178443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6AsQLOtLXqnp2TAJl+2PczA8EG2/aLFdDNnU5gerH8=;
 b=SyRTdGri2pgW/GSF84HLR+PifE6BW4V9wYCb7dS28dhBsB76BnNicDCPUnx3Krqjbu
 aarzE4bMeXqcMpljBimrCp/AZbfzd0vX9mbcVLU+dCOH01V850mT8VpGWnXDASeYE5k1
 f0RuBFeGoyUYahrl+G3yhkgwLFkUgB9kYURLudCpRXbFPWNCxNygwfwUNPhgmnh1DtIq
 JZY8WyryXzURz+r7iocB41DUbkmyFpfxmsYc3crjxemk7XwH5/FJktAyCUIeT3igHB/E
 yKC8qeZMv82gwf3G/SacfQ/a78r2XkjGYMc9qQqmYDnztN15GP7e6TDotnOPmFcGHsmz
 x86w==
X-Gm-Message-State: AOJu0Yy/VLpc57wY7SJcDkZKTmxbjxAws1avePB1PRmHV3/l5qAIFx5h
 xDdrJXdvnP6YQmJzH+K1kwObHA==
X-Google-Smtp-Source: AGHT+IEGOCUsSZx5MFw6hz1TkQgsO4iAkvC6fPFlnyxOeKLlbqjBRQkgHTp3jjKVrpgAO25MYONt0g==
X-Received: by 2002:a05:622a:5443:b0:423:6e50:5fdc with SMTP id
 eo3-20020a05622a544300b004236e505fdcmr1890854qtb.67.1700573642945; 
 Tue, 21 Nov 2023 05:34:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 g18-20020ac870d2000000b00417dd1dd0adsm3589194qtp.87.2023.11.21.05.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 05:34:02 -0800 (PST)
Date: Tue, 21 Nov 2023 08:34:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] configs: keystone2: Do not include hardware.h
Message-ID: <20231121133400.GR2513409@bill-the-cat>
References: <20231117223829.346652-1-afd@ti.com>
 <20231117223829.346652-2-afd@ti.com>
 <20231117224044.GD170968@bill-the-cat>
 <5fc3cee0-5b79-4cd2-a153-94b25c37e5f8@ti.com>
 <20231120152649.GI2513409@bill-the-cat>
 <CAPnjgZ0XLdpXxjGMr58i6gBU3KPw7qpKTu2jQp9jMLrSVG4dhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6l7U8G/Rmlh3AcAj"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0XLdpXxjGMr58i6gBU3KPw7qpKTu2jQp9jMLrSVG4dhw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--6l7U8G/Rmlh3AcAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 07:16:03PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 20 Nov 2023 at 08:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Nov 20, 2023 at 08:49:32AM -0600, Andrew Davis wrote:
> > > On 11/17/23 4:40 PM, Tom Rini wrote:
> > > > On Fri, Nov 17, 2023 at 04:38:28PM -0600, Andrew Davis wrote:
> > > >
> > > > > This is a hacky way to have this file included in all source file=
s that
> > > > > include common.h, instead just include from the files that need i=
t.
> > > > >
> > > > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > > > ---
> > > > >   drivers/memory/ti-aemif.c            | 1 +
> > > > >   drivers/soc/ti/keystone_serdes.c     | 1 +
> > > > >   include/configs/ti_armv7_keystone2.h | 1 -
> > > > >   3 files changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> > > > > index c4bc88c1510..41325eb0f94 100644
> > > > > --- a/drivers/memory/ti-aemif.c
> > > > > +++ b/drivers/memory/ti-aemif.c
> > > > > @@ -7,6 +7,7 @@
> > > > >    */
> > > > >   #include <common.h>
> > > > > +#include <asm/arch/hardware.h>
> > > > >   #include <asm/ti-common/ti-aemif.h>
> > > > >   #define AEMIF_WAITCYCLE_CONFIG          (KS2_AEMIF_CNTRL_BASE +=
 0x4)
> > > > > diff --git a/drivers/soc/ti/keystone_serdes.c b/drivers/soc/ti/ke=
ystone_serdes.c
> > > > > index 2ece1a8f647..0e1bf8ff39d 100644
> > > > > --- a/drivers/soc/ti/keystone_serdes.c
> > > > > +++ b/drivers/soc/ti/keystone_serdes.c
> > > > > @@ -8,6 +8,7 @@
> > > > >   #include <errno.h>
> > > > >   #include <common.h>
> > > > > +#include <asm/io.h>
> > > > >   #include <asm/ti-common/keystone_serdes.h>
> > > > >   #include <linux/bitops.h>
> > > >
> > > > Is there going to be a follow-up to remove common.h from these files
> > > > then? Thanks.
> > >
> > > Yes I can take a look at that next.
> > >
> > > Wasn't there some automation around this? Dropping headers from commo=
n.h
> > > one at a time until it disappears IIRC.
> >
> > Simon has posted a python tool he wrote that partially did this, but I
> > wasn't quite happy with the results at the time. It might work out
> > better now, or on top of the series I posted to remove it from include/
>=20
> My tool inserts #includes based on the symbols referenced in a file.
> For example, reference to strcpy() or memcmp() would result in the
> script adding '#include <linux/string.h>' to the top of the file.

But that's not how we typically work, nor is it how the kernel works. In
a semi-current kernel tree:
$ git grep -l '<linux/string.h>' *.c | wc -l
2177
$ git grep -l '<linux/string.h>' *.h | wc -l
146
$ git grep -l 'memset(' *.c | wc -l
6957

So most C files that call memset(..) get <linux/string.h> indirectly.
Which is why I'm trying to clean up the header files first.

> I still believe this is a reasonable approach. My original series to
> handle this was posted at [1] over 3 years ago. It foundered in part
> due to the number of files it touched, but I still believe the
> principle of 'include what you use' makes sense in U-Boot.
>=20
> Other problems are that in a few cases it results in some ugly code,
> or misordering of includes
>=20
> On the plus side, it gets us past this problem. We shouldn't make
> perfect an enemy of good and I am disappointed that we are still
> trying to get this over the line.

What makes this hard to get over the line is the less clear examples.
Dealing with <config.h> and CFG symbols gets pretty odd. And the failure
in https://source.denx.de/u-boot/u-boot/-/jobs/739662 was just really
odd.

--=20
Tom

--6l7U8G/Rmlh3AcAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcscUACgkQFHw5/5Y0
tyyhJQv/QNVqu/nN7NGwy3SO8vJzYEMd0tsV7TwlOb8eGEZo04Ud8/ZQ31M545p/
PzJ6ZMo7o80UGSWzfnDPQx4VeHQbYbC6cCXtv7bvUSRBt6HljBWpEbqkB5bTjSwj
n51tk7nZZZDxW06BLDsUMT9zjqPopr3L0gYRV6SmNotuJCCg8YjjzPAtEg4impap
wATFnCk1OYO4lLSSsx0gHedAlbgOhHbZLZXTMTab6ZqjPasB/NcE2JKPOG2IBDP7
6SxwDKQ0A4MQVmCj+GWPdvAp4SEP5CddQ3lqCBXpkA1zUF3CziUoPDtaLGYE2JiI
McG1WA1dnPCnHti588H4MBnC2ExsXRhXH3rWMVO8ppoIQZMEO7PHkf5b+uZMBfYM
RWkh7al58v5STh+Gd9HCLqJI9B3QcThvnhg7pOs8D5Y2Os3xc95/PybiJTkDVlKE
Aly3UDuGrbCQ6KMLMhldTmK3VX4BTjJNo4lRb9MeaPFRaQWSJQWyPpSu5XXuEWbY
kbKoE/wB
=Td9E
-----END PGP SIGNATURE-----

--6l7U8G/Rmlh3AcAj--
