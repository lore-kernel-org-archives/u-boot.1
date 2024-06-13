Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B0C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD72387F9F;
	Thu, 13 Jun 2024 17:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKrHbK+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB4D8817C; Thu, 13 Jun 2024 17:42:12 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E36587D87
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3cabac56b38so646383b6e.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718293329; x=1718898129; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9mdEa2G8TLu7a41ZX9pIxomBGEvIDi/S6JGgnlDPTGU=;
 b=rKrHbK+qDgr7pOAo5K3F/0YwzN42UNUmxK5v/oO9IsHK+NL4LWAVHbHGWFRKzbW0pB
 L1G3aH7PA914usRo5UB0s7FgHfNcS/o5Gp/EiUp+PKIqLV/LTLIU6P8C5UCmHxsaitup
 w69izDrg9ae3JfCnJILDOzmIsDK24/V2yPcjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718293329; x=1718898129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mdEa2G8TLu7a41ZX9pIxomBGEvIDi/S6JGgnlDPTGU=;
 b=heqa8c26Tj1WM/wX0F8brkKkg3d3iUa3n7GLil/6uAANUHYrKKqgmKl9dBQ+ViFuZb
 qgR+gCBpO4gxxvGRKql0eQGd719D5f2g/p/oX4DKLF3+zcfykPtDb3VY7mDjl9ognRiA
 39nez/HA6ytvYZDw1DVKmuZSjVpD8SILIZsoBzOPI529fUXZuXepkZuy7+bSfVmyNCKD
 4y3+IpiLh3NYGgQyS7wOqMIt8e04JVGdhvLH4BPwVjVIl4lmavv24rX24GoGPGWj1VCt
 UXNjTvlh5Ab++rgUe71pnNumhbrDQXhDmiSxEScI6IXwjXdVN0wr5AdUMGlK24dj3pqU
 53Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHN1O0NzygtH9jYsRt/7Bs+s83m7Azt9sAS13bTCZ3ZGdDBxdqanYekp6YrRDl69jMAxgyqPWO02jC21Zt6tGQoCXPkQ==
X-Gm-Message-State: AOJu0YwcykQMqfztxLRKNrKX17uhG5GqIUV/9hbka51FdO1FsF4PuF0h
 +8qBkyRXvRGC9BsuNhx1nIy31u8rgX9akPR9dItIHPsitkHhe5w90YdCSw14K8lH3+t0M2qRtkG
 n784=
X-Google-Smtp-Source: AGHT+IGo94ihxE+qHI9OhUxoVIX6LiKqVxVoUtWfxR6Cp6SLeYXBRq047z1It2KXfZ3omU8a3Up69g==
X-Received: by 2002:a05:6808:3096:b0:3d2:2703:2573 with SMTP id
 5614622812f47-3d23dfb5b5amr6083960b6e.8.1718293329180; 
 Thu, 13 Jun 2024 08:42:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2475e4b37sm225102b6e.4.2024.06.13.08.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:42:08 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:42:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
Message-ID: <20240613154206.GO68077@bill-the-cat>
References: <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
 <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
 <20240612214001.GI68077@bill-the-cat>
 <CAFLszTiZSu+aN53kAPd2GXosXv09Ams+jFDi2xGU0wh+faO=dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zvpfnwZYqoMmNcoK"
Content-Disposition: inline
In-Reply-To: <CAFLszTiZSu+aN53kAPd2GXosXv09Ams+jFDi2xGU0wh+faO=dg@mail.gmail.com>
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


--zvpfnwZYqoMmNcoK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 09:22:15AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 12 Jun 2024 at 15:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
> > > >
> > > > [snip]
> > > > > Also IMO there is only really one LMB list today. We create it at=
 the
> > > > > start of bootm and then it is done when we boot. The file-loading
> > > > > stuff is what makes all this confusing...and with bootstd that is
> > > > > under control as well.
> > > > >
> > > > > At lot of this effort seems to be about dealing with random scrip=
ts
> > > > > which load things. We want to make sure we complain if something
> > > > > overlaps. But we should be making the bootstd case work nicely and
> > > > > doing things within that framework. Also EFI sort-of has its own
> > > > > thing, which it is very-much in control of.
> > > > >
> > > > > Overall I think this is a bit more subtle that just combining all=
ocators.
> > > >
> > > > I think this gets to the main misunderstanding. The problem isn't
> > > > handling bootstd, or EFI boot, or even assorted scripts. Those are =
all
> > > > cases where things are otherwise (sufficiently) well-defined. The
> > > > problem is "security" and that a "carefully crafted payload" could =
do
> > > > something malicious. That's why we have to do all of this stuff soo=
ner
> > > > rather than later in our boot process.
> > >
> > > That's the first I have heard of this, actually, but a bit more detail
> > > would help. How does the payload get loaded? I'm just not sure about
> > > the overall goals. It seems that everyone else is already familiar -
> > > can someone please take the time to point me to the details?
> >
> > Well, the short version I believe of the first CVE we got (and so
> > started abusing LMB) was along the lines of "load an image near where
> > the U-Boot stack is, smash things for fun and exploits".
>=20
> OK. I am surprised that LMB does not catch that. It is supposed to add
> the stack and various other things right at the start before loading
> any file. So even if it clears the LMB each time, it should not be
> able to do that. Having said this, the code may be buggy as I don't
> think we have tests for U-Boot's overall functional behaviour in these
> situations.

Right, LMB does catch the example I gave (because we made all of the
load from storage/network functions init an lmb and we always make sure
a new lmb gets U-Boot stack/etc). The next thing we didn't catch was
"what if EFI does the loading?" and we've kludged around that, and in
turn had some of the thorny questions. Some of that is what I think
you're asking about in this part of the thread, to which the answer is
"EFI spec says you need to place X in memory", so we just need to
reserve it when it's asked for, so that something else can't come along
and smash it maliciously.

But that also raised the more general problem, and why we need a
persistent reservation list, of allowing boards/SoCs to say they want to
reserve a block of memory for whatever, and have that obeyed, for real.
For example, the mach-apple logic of "just pick some memory locations to
use for kernel/dtb/initrd" isn't really as safe as it should be since
those reservations aren't really seen anywhere once the function
returns, it's just setting some environment variables.

--=20
Tom

--zvpfnwZYqoMmNcoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrE04ACgkQFHw5/5Y0
tywGgwv/T/yyTVt/s0hYd5EN1juCEivtTk1nPcqCO/4vBr7oEv37MsZ71HqTLBGX
9x33GuygxwyWnndDmNBBWs9tCs2nP7xhguNdddig9JJBlI9uXx3oGKE3h1qp7kgV
1h86FX66WfoAEDBIMuYd88RRCUYNhjS0+Gbaaz8xxzdgslP+em+44Ox33hFmsBQz
lSBhvPYFh+23//cYG6hVfUczShrouMwdFV4fXOy+ddd106j9pJGcgiG1gNMS85tZ
q8VtdkaFECyad4lw7KI+5SSjtP66lME+lQCyinano3JeeHojkXFfo6cSZKDGurOG
QbMUYyhI1GcWhLzGDbfkzX/2Sd2fUdk/hZpKEXQrh9g/wGyh47efOHg9U9xjBsXJ
0wXJVrTp1ItCZ1PM9MjGrttbZzYUTo70zR94tw5CC2H4F/PS+kG9GpHTe6CtCClz
NMsyxrlK1ekG/WMZTw14Sxb1KrveNx56bsJpWOHkG9awHj9W46QgY7i1VxIYvs3e
6yUUVtT/
=kcGN
-----END PGP SIGNATURE-----

--zvpfnwZYqoMmNcoK--
