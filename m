Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6547ACCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ACBD8313B;
	Wed, 15 Oct 2025 16:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ENVjVwER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFB03800D7; Wed, 15 Oct 2025 16:15:42 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5B08313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7b4f7a856acso2525691a34.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760537739; x=1761142539; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2+JoVB94YaL0A+0EG2gQimaIH3Vv1lKnlElCmPjhGVI=;
 b=ENVjVwER6tc3sacpiNDAEcg2KXYWVSDgWBh4a2TlCGxGD3RN5PRvpKZsa+weVC+dYp
 riSHnFnTK6tXlpoeAqkN0jifNkW58u5JlcVh7ZBdJuVyL7IQf6RPWPfoo0xI/IQ+tlpV
 CsTd2LxEf1fQZ4uF6/8iLHvmC7PK7Gt2/bneg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760537739; x=1761142539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+JoVB94YaL0A+0EG2gQimaIH3Vv1lKnlElCmPjhGVI=;
 b=UGbRIVjM1m3Uc7o8qbzYVzWHfpbdjXeK2hAPr3FYGMVJHvsi1xhBlo6nIxSSycz0t3
 L5Z/6lDN7e/gStWb069uadpBSY6XIpj8q3KVLcZJjP6n3Uo1cSh/p+dOTqNqPfHrVI4k
 wONdRY1ZjDaWoSQgTad8Oz2HVNKjZDo9tNmM8xL+N+ji/FPLKIT1VAvUmV475VXUMMzX
 gyEQOs1d8YoGyVb7LFUlD7jRGPrDedVv3zObfrHOTUa/g9oKtkB8CzJHWnkeXNiFPOTz
 7ivI3b8tlOBUKT4loyGpP77rVYV+m3EMyu67l5x8uZiFqPWaUZE4t765qzhEcgeYzTK0
 6BKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT8+ShGyB1ZL0C5SYTdy03ub/A5LRyA1dx6kPQuV+6rr1sGQzkLDfWIJYKvCRPO0mpvLbOtSg=@lists.denx.de
X-Gm-Message-State: AOJu0YwdpuC1Y/tfOOSjn97+R8v5Ez4rHDuoEWxrzVkjdTOvliBV+NdJ
 RjdIkJ5zuZMRDS+ap3TMQvDwDwzig+WCVA8f+ceDfTvC/GUnDt2GSKa7k6pg+hsjYzo=
X-Gm-Gg: ASbGncu1bX+BEBwygFkXxOEo7MDs7SukzBE/NzABGIFgxw+GmPO6fIKRpknLEFNIWS8
 O810aWQapTMylFUzgN2xs5tt0XMrwVsvaP732OgzuyFIX53vmHcWHs/dIqUcYIOVDqB2SU48JB5
 aM7cFPep5YeSu+FzIeB4XtzbXSYkLnmvz2iBXLZLO9NZVMa9nDmazzZEMXnmQRySqVggZZ0pXcy
 eL60aeHbKCD2lwqIvOc+B9enHDPJW3PEpFaQPxcVp55LIDXlg0FIQNqVPrPp+hy6m21vdt4AuZs
 bYXG43EtWefbtp1cQa3v4oe+b9NPWAG9dkMOSrE8E536hpK1qO5tzg/zrgtF45BnDHKuIlwFWE3
 iEAbaMj84Y2epdNiutbaKHP+wPQ7eF63717Qwn5rLIESXh0jSuFgCopGnOhKDhR5e5iEi2c5fLD
 W7EUBMR99cN3GAAp8=
X-Google-Smtp-Source: AGHT+IH6Qr5Z5sQo+ZQ6XiIo7UvKZXWfH8GSge9AVN+d6LP7qDFRcXLXEJ7Y0UbZu59Dw/r9SABDiQ==
X-Received: by 2002:a05:6808:bd6:b0:441:8f74:f32 with SMTP id
 5614622812f47-4418f741b5cmr9555885b6e.60.1760537738937; 
 Wed, 15 Oct 2025 07:15:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419887fd8bsm4001430b6e.2.2025.10.15.07.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:15:38 -0700 (PDT)
Date: Wed, 15 Oct 2025 08:15:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] test: Do not build expo and cedit test if no SDL
Message-ID: <20251015141535.GO6113@bill-the-cat>
References: <20251006164506.380308-1-kory.maincent@bootlin.com>
 <CAFLszTg+2-xRo1N3zzqY3BEUUqM989xifttbar_+mOE_X12PYg@mail.gmail.com>
 <20251006214436.GE298503@bill-the-cat>
 <20251015152538.7fccb0f6@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wvUFBdE7LJK0Ow9C"
Content-Disposition: inline
In-Reply-To: <20251015152538.7fccb0f6@kmaincent-XPS-13-7390>
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


--wvUFBdE7LJK0Ow9C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 03:25:38PM +0200, Kory Maincent wrote:
> Hello Tom,
>=20
> On Mon, 6 Oct 2025 15:44:36 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Oct 06, 2025 at 02:38:10PM -0600, Simon Glass wrote:
> > > Hi Kory,
> > >=20
> > > On Mon, 6 Oct 2025 at 10:45, Kory Maincent <kory.maincent@bootlin.com>
> > > wrote: =20
> > > >
> > > > expo and cedit tests depend on the host having the SDL library.
> > > > Build these tests only if VIDEO_SANDBOX_SDL config is enabled.
> > > >
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > ---
> > > >  test/boot/Makefile | 2 ++
> > > >  1 file changed, 2 insertions(+) =20
> > >=20
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >=20
> > > We should be careful that a future CI change doesn't cause these tests
> > > to stop running. =20
> >=20
> > Given how HOST_HAS_SDL is defined, CI will be fine.
>=20
> What is the status on this fix? I see that it is still not merged. Is the=
re a
> reason for this?

It's on my list to pick up very soon. The general window for applying
patches is about 2 weeks to allow time for feedback.

--=20
Tom

--wvUFBdE7LJK0Ow9C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO+shAAKCRAr4qD1Cr/k
Cs1ZAP99Bh53G+S/qyRlxd2fjRMGkbMAYdt7RfR8XqthK+SOEQD/b0uja05lBGqL
pCvxkILBMzR25YA+fTF75Z8Q1jZ9KwQ=
=zF0B
-----END PGP SIGNATURE-----

--wvUFBdE7LJK0Ow9C--
