Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15F7C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D23581298;
	Thu, 27 Feb 2025 17:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="invJZlMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10259810F5; Thu, 27 Feb 2025 17:26:21 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF08A81298
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2234bec7192so30940175ad.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740673577; x=1741278377; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cM7LS9rjKzmuTlZiYe6B8VOMtZdF9p1+iJiRsHo5fCM=;
 b=invJZlMBXeXQj+p9e/cIcH8jd3k8qpovi3bcU+ssjAmkV+wdTC7n9qDGydY8SGXlO0
 hlEqi9PqoQzVYZPWEceK8iitvxMcN0f+i/8vH0aY9tvS7tgF2qD0+YS09p+wekdIDqti
 NN9AHL4mgugAagdRIY+iLiEc1GcKX4thmjs6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673577; x=1741278377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cM7LS9rjKzmuTlZiYe6B8VOMtZdF9p1+iJiRsHo5fCM=;
 b=Q9JYqnOkGntK8URdcOqU38QkZQJE4ecx61ftF4PkRXHn98OrGQVz4SAeDqRtOOFSAS
 cQt2iu/xHOBj9Ce3CT4ZEj2kyppxeM8Lp2MdWYmA3dkOlYGFr5HSUcajbEc4ZfNiO1gB
 CUbe4nXsEh9o6l5ovjQ7JqDMPxh4EAJ3dHD2Bn0PN+yfFWDbhsyOU46Vg87sqwYzfP5m
 GQ88rL6ooYJSLWuCeTfcag7ufA9cciG9YTTgIsEy2crrnu8NviVvGwSe0h7IiVewPhNf
 MwN8YvIpUve0ZJCNKw1klp9AgOWOhTt7li6n/NGQSPU7maFo0Jtwd1RcNaD7CKSAlfEf
 yfpQ==
X-Gm-Message-State: AOJu0YzCmMDDcG2KAHmjwOQ9k51qSzqJUjJ9bQP60LC362QrT0bQioQJ
 zmlMiHqg2gIw716kVibDmG8GZWdnDtOadls/BMUvpknWW3PKMKfa7E33QcFLioM=
X-Gm-Gg: ASbGncveT8r7x0v6fqjhXOdGn9ZXeIoNFWRggxYal1tN5aG2cXvmBZ6ZLBiphe6Fn+F
 PyLKPVin3yExve0YAjDhJi0vPgfScpefgmy4r+I47TrDO3EIRMHEFoKMaisdi4dDkM7vc1Ln8Jn
 jEuoWEU/kUN4SsyvacVHGg0o844TJjzdqmdU2FbAOAIZK2us7VuqN22r7Yq5mWwCbv//FkqMZOJ
 4H0xVXISjrh4qpfiHCUQJ05ubZkx69AXT0cbj/TgNEJBY6hypPbhNIeeLp5YuRrW0X9WlRhVxFu
 GIUB9PFmcd9daZ776wArQYC+
X-Google-Smtp-Source: AGHT+IEu+0EEW31JndB+JQ65REDKjLKQXEYiLEM8qqOXMBVva8IYg6NGpJ5hCzo7zjXzUksNPzrH7w==
X-Received: by 2002:a05:6a00:cce:b0:732:1bad:e245 with SMTP id
 d2e1a72fcca58-734ac34dc5emr88093b3a.7.1740673577187; 
 Thu, 27 Feb 2025 08:26:17 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe2a62asm1889318b3a.18.2025.02.27.08.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:26:16 -0800 (PST)
Date: Thu, 27 Feb 2025 10:26:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>
Subject: Re: [PATCH v2 2/5] samsung: snow: Use BLOBLIST_FIXED
Message-ID: <20250227162613.GY2640854@bill-the-cat>
References: <20250226162621.2681677-1-sjg@chromium.org>
 <20250226162621.2681677-3-sjg@chromium.org>
 <20250226211335.GM2640854@bill-the-cat>
 <CAFLszTjCQUb=vcNt5m9TqJC0AGcpEOanYwf7kOZoBS=DQDoK_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wyR7ORwR7eG5EN/6"
Content-Disposition: inline
In-Reply-To: <CAFLszTjCQUb=vcNt5m9TqJC0AGcpEOanYwf7kOZoBS=DQDoK_g@mail.gmail.com>
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


--wyR7ORwR7eG5EN/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 09:17:15AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 26 Feb 2025 at 14:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 09:26:15AM -0700, Simon Glass wrote:
> >
> > > Snow requires a fixed bloblist to operate, so re-enable this option.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: 864106f3c47 ("bloblist: Make BLOBLIST_ALLOC the default")
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  configs/snow_defconfig | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/configs/snow_defconfig b/configs/snow_defconfig
> > > index 7a1dc80b1cc..f9fd76daa67 100644
> > > --- a/configs/snow_defconfig
> > > +++ b/configs/snow_defconfig
> > > @@ -33,7 +33,9 @@ CONFIG_DISTRO_DEFAULTS=3Dy
> > >  CONFIG_SYS_PBSIZE=3D1024
> > >  CONFIG_SILENT_CONSOLE=3Dy
> > >  CONFIG_BLOBLIST=3Dy
> > > +CONFIG_BLOBLIST_FIXED=3Dy
> > >  # CONFIG_SPL_BLOBLIST is not set
> > > +CONFIG_BLOBLIST_ADDR=3D0x43d00000
> > >  # CONFIG_SPL_FRAMEWORK is not set
> > >  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
> > >  CONFIG_SPL_MAX_FOOTPRINT=3D0x3800
> >
> > I'm not going to NAK the patch, but:
> > - "snow" does not require a bloblist to operate, just to run the
> >   bloblist tests on hardware
>=20
> That's right. 'snow' is the platform I chose to try to run more of the
> sandbox tests, although I haven't done much with that.

I use a Pi for trying to run more tests on and yes, good to know.

> >   as implied by d985f1dbddb2 ("bootstd: Add a
> >   test for the bootstd menu"), which also don't seem to run anyhow?
>=20
> The bootstd tests all need sandbox at present, since there are images
> required. If you were interested in my idea of building the
> 'image-setup' stuff into the pytests, then we could change that.

I just mean it wasn't clear that test/common/bloblist.c was run when
BLOOBLIST is enabled on snow. But I didn't dig too hard and compare the
output with sandbox when we pass stdout through pytest output too.

> > - We could just as easily continue to use an allocated bloblist if
> >   CONFIG_SYS_MALLOC_F_LEN is increased to say 0x800 from 0x400 (which is
> >   the same size as the requested bloblist allocation).
>=20
> OK
>=20
> > - This very tiny SYS_MALLOC_F_LEN is just the old default value from
> >   when it was bumped up to 0x2000 for most platforms and is also safe
> >   from a quick test.
>=20
> OK. I didn't get time to look at bloblist last weekend and this one is
> not looking good either, but I will get to it.

OK.

--=20
Tom

--wyR7ORwR7eG5EN/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAkh4ACgkQFHw5/5Y0
tywaywv+IUL7sOIzHOJ8KZKif6hahbla1PtJDkPOBWcFgNVtwO8zM7K5u5zpJ7EU
QkJo8gqRQMHRjnq0Jh56nAYyTAvDgmyMO5iS6UmHArCzy4/48semXs0wm6MkRReK
9H7YTPyxQVlhcfz4y+71Oedj6oN3DxYKI5uxntT4r+YaCoQO9ANYehUnKs9f7JjY
x3TMRxJCpgbEo9h1kkqjA/n9cDKtNcnhcVn2wCAF5SHQYE6st730CJPT1mwwUUsY
3wDaf2VnHzxSgh7+HWiXhQtM+k544TFtK0C1Q0UXBaY31N1/a54Ba3IZ94ephAu5
shYxPu5aiBTwxIUv4gMb+53JDZAI7HujNdkkB1ZETOGH187eY0X7XVP1YMHVYtv/
Zyw/sD/Nl6Lz3x9+Q4/Mz6/dXlIkSH/PnLzLGfpEz3AQvpg8xaIqFfKXAgTHNYDY
4OyCOAVGYICHTm10wFlNyHc9Wajw0OCl3UmR0dfoncKD65lP6aOeHEsJFzzdDrp/
lGmXItie
=V9oi
-----END PGP SIGNATURE-----

--wyR7ORwR7eG5EN/6--
