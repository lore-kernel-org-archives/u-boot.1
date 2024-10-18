Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCBDD3DEA4
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC5688D9C;
	Fri, 18 Oct 2024 20:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B83aTPy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAB988D5B; Fri, 18 Oct 2024 20:04:46 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 953B088BEF
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4609d75e2f8so18856851cf.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729274683; x=1729879483; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eUMRr2J9HfN6MYFJ75S8MVP8qxCulSM5BoPoMlu1kRE=;
 b=B83aTPy7msLDlVZa6Zc1gwkpAz6V59MJtvxA8IhIW8a/UIKVhuJBCPkmImSFr2daqY
 FijL20t7NySuColVhGXaoDfrJak8COcsOU/c2SCh0rXd/zflxo0FTFvKyXOXjICUT4ry
 xKCd4mbrmYL/HIrhbBvyUjCgoA6DqnQyN2vUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729274683; x=1729879483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUMRr2J9HfN6MYFJ75S8MVP8qxCulSM5BoPoMlu1kRE=;
 b=KVeEkKq5/r01hlEd4/zc5Jll2KZNRm8jC9d9aMiP7q2z8tLbxeTtODiPBPm2S++IH3
 4aPzOiEFhtpSK0pKJaBDqotA3XgXu64SaRwjHbmqIVJTvqrp0MQABAjyCZHfGODIBhm2
 t6CyO+X3qoyVHg4BeQujIq76ZUwi4PdWTaXI6V2EGEacSAIgaktwhv5hf/JaPJbd+i6L
 1k8x0RddHylFbH0ESzVpjb0ALwnndFriNyHcOJJcwzSUyox1g/GV5un9s6H5dNS3Mdi/
 Mxv5zuLfAJcHn20FHs9jB45eSyZnStpRSO30xkicMq/yrK2hlV0E3US674KNwVKreBca
 qKdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE1qHPY/HrkxyRoRkNGxmLpZ83hUF6C/pzW8UXab9xmTjuh+Y0BdTPPx8g/fSy7jlAqMlO9hI=@lists.denx.de
X-Gm-Message-State: AOJu0YzcE/uzqBoChHoPfssKiiwOSKdG1VlUqiIaYHQwI0eLuo/0rm7x
 3AOa21moPvVDmDK9VcQJbCPemphaG1xongKiJBxxoUlOA2qE5pTf4Oda4KOxPck=
X-Google-Smtp-Source: AGHT+IGN2dAU5frAKpljnaJKbEAkqpHz88oJjDxaCQxTX1+5Yz6GXyCHr1M4Ayo2qeDeZ0gq7avfFg==
X-Received: by 2002:ac8:7f8d:0:b0:456:919a:11e4 with SMTP id
 d75a77b69052e-460aef6ba59mr60849291cf.20.1729274683379; 
 Fri, 18 Oct 2024 11:04:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460ae9485b9sm9355871cf.18.2024.10.18.11.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:04:42 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:04:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
Message-ID: <20241018180439.GD4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
 <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
 <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
 <20241018163303.GZ4959@bill-the-cat>
 <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zsCs+dTy6GsPJT3C"
Content-Disposition: inline
In-Reply-To: <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
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


--zsCs+dTy6GsPJT3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:20:52AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > > >
> > > >
> > > >
> > > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
> > > > >We want to keep track of images which are loaded, or those which c=
ould
> > > > >perhaps be loaded. This will make it easier to manage memory alloc=
ation,
> > > > >as well as permit removal of the EFI set_efi_bootdev() hack.
> > >
> > > I'll change this 'hack' to 'feature'.
> > >
> > > >
> > > > Please, keep in mind that files can be loaded manually, e.g. via th=
e dhcp, the wget, and the loady commands. These are outside bootflows.
> > >
> > > Yes, this series is only going to help if bootstd is used. For ad-hoc
> > > use, EFI will need to rely on the above feature, at least until
> > > someone can think of another solution.
> >
> > Perhaps I need to try and be clearer here than I might have been in the
> > past. The consensus among off the shelf free software operating systems
> > is "just give me an EFI interface". This simplifies things on their end
> > if regardless of architecture it's the same interface. This means that
> > in U-Boot we need to treat EFI as one of the primary interfaces. Not a
> > novelty. Not a "some people might use". It is a frequent and commonly
> > used feature.
>=20
> Yes, EFI is everywhere and growing. All the more reason to tidy up
> this piece. I would like to see bootmgr use this new API, for example.
>=20
> But how does this comment affect this patch?

Because at the very high level, I wonder if I made a mistake a few years
back. As I understand it, the nominal case is "bootefi bootmgr". I was
saying at the time that perhaps bootstd can just fire that off, and move
on. Now it seems like we're going along the path of re-inventing that,
and not integrating well with it either.

So, to try and bring things back together. If U-Boot decides to load
$FOO from device $BAR, at that common point is where we need to:
- Is there an lmb for the location this is supposed to go to (for the if
  we know it, entire size)?
- Note down everything else we know, now.

This means that we can note down enough stuff so that EFI can construct
the path it needs. And if we're being told a filesystem, that filename
is good enough for the IH_TYPE thing you're wanting, or at least a good
chunk of it I hope.

It also means that since it's at the most common point, it doesn't
matter if we were in an EFI application, a boot script, a bootmeth or
someone at the cmdline doing "load mmc 0:1 /boot/Image $kernel_addr_r".

--=20
Tom

--zsCs+dTy6GsPJT3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSozcACgkQFHw5/5Y0
tyykUwwAjmLPyAmRoO43YpVHsBliiQGCJHymh56LdFX6mgLc3FrET7COvdYDrZgJ
V2EftBmth1zujPkKIKyewX9gx8vH+qGzm7nLARa3Bpx5cnqYFHtLQPx0LeZgDZgg
dH8DJWmfDVoO2IevBny5doDIKrIcBM6PLkOAMuP/V4sQqjzapE1kZITeEbhS82xD
q5Xxup8C2eLS0oYqH9JZhDS7l/n+5OFvRlrUI9BoeTjc6sPpPrFluM2ZUbeSuCsH
pY1vr6lMi/OE+0XYQP4SShCbyLbuK4VWyeucX8Go9jUeiiiaiVnZRIMKKOA8ntDJ
dcoCjYZ4o/3axJx3ALQPpp5ZOee7wPSj0mpCvLzInRaDSFWLw/y83WLFldBoBdV8
JofLGEgiHiJdA7yx/KmzcZ+2iAALOFiy3PE+FTqwtqID8XFR+mwbHvliDaj/W3Ap
3ByT2dB/3K7/I0X7CjvjLEVvvJMB7SjJVNkMj2RrYjVlxLjbLo+nelaVVAvpuN3Q
Cy7721m4
=klt7
-----END PGP SIGNATURE-----

--zsCs+dTy6GsPJT3C--
