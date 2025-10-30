Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF614CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3628B83849;
	Thu, 30 Oct 2025 14:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NJPnKvAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7837783887; Thu, 30 Oct 2025 14:39:05 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5167283826
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-654ecc2af9aso537274eaf.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761831542; x=1762436342; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aD64b1r35JrJfTvw5B8Jx295JG33hMAy1+LvcGb44lg=;
 b=NJPnKvANlxFiHQnQ+m7iFmKcm3D8wlZw2QZM4dmY7cwRtO6It0lGOHgzWit+HGxAkF
 Czh1Wza452XAOo7Y0kwgvuplRl9Mk7QoLZj1/Ce/QVAXW0tAyguEgY4gf7hAzbG4T9DM
 4Fxefcx9N062Wm4qXobX168OYVttFxhOReiGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761831542; x=1762436342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aD64b1r35JrJfTvw5B8Jx295JG33hMAy1+LvcGb44lg=;
 b=RZMP0YJAUco1NsFztMHp8EDQWdcgbl1/yDaZuia1mYYchgDe2GM+oq2lA17XnKAKmr
 dUaj1ve68XDKEhhCHnyQJVMw0OLzVrjOtHfgzVSlQKDjhfF3qaPBM/RUkvtnahlIM+jX
 AjIi7LxpA7n5AmO1YhlhPvHlz5LuWBEr/WwQwMs25ZViRtVFD2rzHOpAWVLIJi8yD3vz
 htWchcJXQ9hcauTg8sPBuAGgjBlNac7IRD1ECCm1TQMeKBwNNbxPxEisxmA1OjYJgKVO
 eBj4Pn+cXx18Q9reqeK3j2/FPqqMdtA/kf/+ntqmqIzRcooteGJPBKk2IOy/dSLtI9Ip
 uKbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsLneX2XmvLX+31kEqGMbHsKrGN/VExqh/jfzzcweVpSgUD1ObC37PtFRaOqcSNEazlMWxDlk=@lists.denx.de
X-Gm-Message-State: AOJu0YyjaE0wk9uYEGYWu4V06s9LHos198AfTBM6jJgfFVMvjOy3vqhs
 MLfSeYfNEwxZshCgTI1wUtvYbMyTIVdsw0ge/uHnOFMd6iZnCXZ4KVHQ96Rytt+7oK0=
X-Gm-Gg: ASbGncu0payZ7gx/aS10iEJYafq2xuwfL2JH3XVBd6lQ49SBvbNjldUqF80GfgX1DOr
 /VrIAIduKTtV3BKSzynQcNVZOFcB6JmmfMLm5KzsbGD1FeDmNevd40yE85Cm8D897INORix/hzV
 wGmoXuy1xNsXenH31jkNaiM04bIuPmL3iSYBtS4VNsspwM8M/Nf1CIkhr3O2y/K0MMkscDfOGfQ
 kVjOFFUEI9b9AvX4tF2rCEXF77yZ+9VfQag6dGvid1tvdoHa1LhTCEh2dRD0MnSR3nogOWc6BvC
 WXXeJNQHupPWRYC8AZSZcbqs0nepBFbM3V2gyiXVLQt1tibySB7ulDiL3NGujd441WCk/EN5ARr
 m9Hn3mzwBX9LxQjeULJBHLpZup0Vf90hpzH4kPf4k4jCay4Vjxy2J4kHVhig9h1aETLDqJS9v6e
 0mkCKPentdMePb+HZ4QCFmw0uicdBjJPt6I3pxnUg=
X-Google-Smtp-Source: AGHT+IHD1gzGLNnXgnkzxZg7AD7vkbdSuBS84QCNx3imC6N+MFY3v/le5zhOy2PItmtkOrXv2FsZrw==
X-Received: by 2002:a05:6808:3a09:b0:44d:a96d:eaf1 with SMTP id
 5614622812f47-44f89da0010mr1497309b6e.20.1761831541897; 
 Thu, 30 Oct 2025 06:39:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44f6d71330asm2282247b6e.19.2025.10.30.06.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 06:39:00 -0700 (PDT)
Date: Thu, 30 Oct 2025 07:38:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v4 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251030133857.GS6688@bill-the-cat>
References: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
 <20251030003136.GA2558427@bill-the-cat>
 <20251030105537.0b1df227@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QuJkx23cjQOt1oAT"
Content-Disposition: inline
In-Reply-To: <20251030105537.0b1df227@kmaincent-XPS-13-7390>
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


--QuJkx23cjQOt1oAT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:55:37AM +0100, Kory Maincent wrote:
> On Wed, 29 Oct 2025 18:31:36 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, Oct 22, 2025 at 05:20:11PM +0200, Kory Maincent (TI.com) wrote:
> >=20
> > > This series converts the extension board framework to use UCLASS as
> > > requested by Simon Glass, then adds extension support to pxe_utils
> > > and bootmeth_efi (not tested) to enable extension boards devicetree l=
oad
> > > in the standard boot process.
> > >=20
> > > I can't test the imx8 extension scan enabled by the
> > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > > I also can't test the efi bootmeth change as I don't have such board.=
 =20
> >=20
> > This has fail to build problems on:
> > sandbox_spl sandbox_noinst sandbox_vpl
>=20
> Ok I will take a look at these build errors.

Thanks.

> > Seems otherwise fine however, size growth on platforms not utilizing
> > this looks good. It's a big big when you need it, but it's main U-Boot
> > and I think in the end, something we can live with.
>=20
> Do you see some improvement I could make in v5 to decrease the footprint =
of this
> support?

No, I think it's fine enough, just the general growth for these kind of
changes.

--=20
Tom

--QuJkx23cjQOt1oAT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQNqcQAKCRAr4qD1Cr/k
Cr8eAQDuUQs9H3zchknEjKqiVY2q21EkpACxSsi9rltpHKKtWAEApZ/H+aRDBUMr
RWMl6Q//StoSYfxMvatocyTL5ITzIwE=
=0+VF
-----END PGP SIGNATURE-----

--QuJkx23cjQOt1oAT--
