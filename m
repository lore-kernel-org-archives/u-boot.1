Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BBFD1627F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D3B8912A;
	Mon, 14 Oct 2024 17:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ePxYDVei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 774978913C; Mon, 14 Oct 2024 17:06:45 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C4888A3C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbd092f7f0so30411766d6.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728918402; x=1729523202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IYehgMqveXkQPIQGBmLddJNS5WwEbf3sRRMHn6dV9+k=;
 b=ePxYDVeidpct9/20mOifgIkS5YNxJJqTGPkfDhULbgWGPtLeHkfZEAMwnN0QV6MIm7
 Ur463mJQCj6oF+SIjgyzeYWgoZR/GQErAZzLf5EAAmcGNyQcrpLBlu5R8CUs5py2Ymum
 D3aX58SvLiRPX+dKM37EfpLY3o/bJYrhNZIqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728918402; x=1729523202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYehgMqveXkQPIQGBmLddJNS5WwEbf3sRRMHn6dV9+k=;
 b=hf1F63jWqGsAuLiRqjDoQ/caZp3SnvOAJxXN5XUsZPFVnNEAzuT5oGiPlHLRpPA6hn
 e5zpx//3tRgokm1CuJsIn5K07cdbm6sv+zRTybZzktV9FWTYHVqO8gJJyzTCWVOu+1NN
 A9gBZZlPkdxE20BliFuRHlsyWDZGrzQjXWaAo35PfOBa8Ir0ZzZPmT6JLcMTC+bRQjQ/
 cxohXhC21LprETID7T1Fd+sljjggm9eJyEaqh42vWNr/TSdutI+fnMUMmYz0T74LDoFN
 UVOC3nbuakxwYeib5xC8BRHxjNuOY1uIPid+e+bA3ejfFd40iyCwUP6ecARL775wFxya
 PMcw==
X-Gm-Message-State: AOJu0YyhLNvIZr4tyhjB4eX3Uzkr3rC0y/xBubm8N/gZ7c7WrgrPwJ2Z
 3DA57Y0+LD31daksbonGHv36ebVh5puRtn8U8eGeFBYf0y5jnSNQXba8iVwVW04=
X-Google-Smtp-Source: AGHT+IH3fB3Ype7T/eHAPmJPM6v5tKZJHsomPAYIEbWTi5viGR070vKjc84xf2AqOQ5X+BCVJ+s6Nw==
X-Received: by 2002:a05:6214:4987:b0:6cb:f8b1:8ad6 with SMTP id
 6a1803df08f44-6cbf8b19624mr146066206d6.16.1728918402152; 
 Mon, 14 Oct 2024 08:06:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe862f60asm45759946d6.104.2024.10.14.08.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:06:41 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:06:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 04/15] lib: Kconfig: add a config symbol for getting
 lmb memory map updates
Message-ID: <20241014150638.GM53053@bill-the-cat>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-5-sughosh.ganu@linaro.org>
 <20241013153005.GK14210@bill-the-cat>
 <CADg8p95iGXO-o6ngz6fC=qXAq+0n6MXeRTHp08r_hjfF3s16cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dYUcNOjMU9vSMbk5"
Content-Disposition: inline
In-Reply-To: <CADg8p95iGXO-o6ngz6fC=qXAq+0n6MXeRTHp08r_hjfF3s16cA@mail.gmail.com>
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


--dYUcNOjMU9vSMbk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 12:18:55PM +0530, Sughosh Ganu wrote:
> On Sun, 13 Oct 2024 at 21:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Oct 13, 2024 at 04:25:11PM +0530, Sughosh Ganu wrote:
> > > Add a Kconfig symbol to enable getting updates on any memory map
> > > changes that might be done by the LMB module. This notification
> > > mechanism can then be used to have a synchronous view of allocated and
> > > free memory.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V2: None
> > >
> > >  lib/Kconfig | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index 1dd4f27159..61452f7ac9 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -75,6 +75,23 @@ config LIB_UUID
> > >       bool
> > >       select SHA1
> > >
> > > +config MEM_MAP_UPDATE_NOTIFY
> > > +     bool "Get notified of any changes to the LMB memory map"
> > > +     default y if EFI_LOADER
> > > +     help
> > > +       Enable this option to get notification on any changes to the
> > > +       memory that is allocated or freed by the LMB module. This will
> > > +       allow different modules that allocate memory or maintain a me=
mory
> > > +       map to have a synchronous view of available and allocated mem=
ory.
> > > +
> > > +config SPL_MEM_MAP_UPDATE_NOTIFY
> > > +     bool "Get notified of any changes to the LMB memory map in SPL"
> > > +     help
> > > +       Enable this option to get notification on any changes to the
> > > +       memory that is allocated or freed by the LMB module. This will
> > > +       allow different modules that allocate memory or maintain a me=
mory
> > > +       map to have a synchronous view of available and allocated mem=
ory.
> > > +
> > >  config RANDOM_UUID
> > >       bool "GPT Random UUID generation"
> > >       select LIB_UUID
> >
> > Both of these symbols need to be select'd by the other parts of the code
> > which require them, not prompted. Please do leave the help text for the
> > entry, just remove the text after "bool" and select from the other code
> > which requires this. Thanks.
>=20
> Currently, there isn't a consumer of the SPL variant of this symbol. I
> have introduced the SPL variant as the LMB module also gets enabled in
> SPL. Do you think the SPL variant be dropped, and introduced only when
> needed ?

Yes, lets drop it.

--=20
Tom

--dYUcNOjMU9vSMbk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNM34ACgkQFHw5/5Y0
tyz6Ugv/fJCirFUgWl9pcU4wEMQ2AsSkI0tPBwxD5IfwH++ukU04LGYJOlQmN/Cg
hokquB4JnETXsPta4gk/usgzz7m+jbhdQH1qEhUb3vx8s333P5kSpY8a8Gx5RmxL
SyRDVx9r0uHZezg2rqgAL5x3Z1c4NMSU+wMqG7lXVj2YgUYhYqB7tdUqWUcX74Oo
2Av21cxkSBin6kF166I/Tu9MMSl8rxhUi1XJrAEskD7w/t0O62+Q5+MS60Stn0SY
slpycnv+qDR3c2j/dHtg6rJTOpKTFwghc2B967NPhuB0iK4v2vlPOQwY0JbZLSSC
wuaw8ECpSRrOP7wS4zg8GVAqAoTgVVxh4IA7NI/Cbr12WL5hRdIrbzmGFIErWkC9
rCnx36/FVLH9zpqL5G08zb851IwM+rkGVoOh21Aq6E7uFVCaM97RGMelcNP0gmZ7
ktZsCbxkgvdW97TrNSgwIpHKKG5shIM4XFbbdwqnH+I24Xi3K5DJQmIv1+FIaZnn
5jcrUa6z
=LwVZ
-----END PGP SIGNATURE-----

--dYUcNOjMU9vSMbk5--
