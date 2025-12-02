Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3281D1266B
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0D2683F2A;
	Tue,  2 Dec 2025 21:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wzh7Q5zZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBDC83EE4; Tue,  2 Dec 2025 21:10:35 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9621B83F15
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 21:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3f0c93ecf42so161762fac.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 12:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764706231; x=1765311031; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TtsfKl+blzneFbchsoKkJk456piZMcpBquryNraaErU=;
 b=Wzh7Q5zZF2x9HboC8nxng64To5tzG4LtGrZTezYiSO1sIgCR1Jj1enZQvjpJugy2Sc
 jBAqzgvr3lMH0h60K3TcKThqQeUVQO+UglKIAW3uLBvIyKVanJFQuC4Vj1O/E5yXyC8g
 39y1+frRfSxc4N+X9BUbObTtlEbl+tZsSHozs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764706231; x=1765311031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtsfKl+blzneFbchsoKkJk456piZMcpBquryNraaErU=;
 b=r/870kE+KWmByb5e4qe02YLRYrQRZQvay7TKPCytHtcKOS1aWKgEq4WUGlDNwzEaay
 J/+K9XGf9EdntGgDBLQLf2J27HKMz2XiUW4cPiJ4bGjTNxsLWASrW3rsi2W/xdkodV6+
 bMN6rs71Pzx8vYC5sg8PocHujzRYqLgBsDO0e5SloTMQfEw4agOkax8KiMt929dwDwOx
 QxHQFR+n046aGa8zYP28iWtzCadLuqlej4YPwlBMkpphBVmVnsvtYJu/T4ol/Je0PBtQ
 BDxZHgDKuga+tlQPzA7Ix06qhjyYphsS9aEs3IMqPeRDsYdYysHtRQR5y1hfYb+5hBTl
 JUJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVShMEtAsPBZF+QYY6gZboPpEIVoyEMAA+CP6kskQ6elupBzDMDo9cR9EFfJsrAlFg2OmXYah4=@lists.denx.de
X-Gm-Message-State: AOJu0YyLu+3mmWHaCVg4At5BpEDjdsYEg1jZdQN6xzxebRI2NOpFKw8e
 GQZ1JM1q50bYXp4Bh+LD9U8Hhvohi9MVaYL6OIOntdAeKtbolflYnwIUdU3Xg4Sqjys=
X-Gm-Gg: ASbGncuSjnGKPX/Ls7Z7qm5YGVszoRe3Yg2HqCkjiAkZT/lTGXJUwhTXs/8swqF8Xi6
 6QsQtMP6YYufrCQZ3viYlD34pg58w+pEQxqXlgHNO6AKjOuU+WB3S894EabNLid29QFUuFsRStE
 jF05RpYTFSX/n1evuNfzbWPNcnAduRjINyGZ+km4N6His9cg/ou0799ggRz9VONCMQIqiKhmIiK
 eTYLwE9NF4fkcjCCtTtvRlo9Z/Wy/A3Aq0CMuGsFB5bclk8Thu98zsSU6wjE/Wd/SLLtHMHCSNA
 9Xct4aajiKE3eKTGWpcI1nzVcc8z18+kyHJEYLrIf+rHtahTx/I3PmWk5wWEdD+f/UGuOISFRGi
 yKrSseCKJwOZtNPD1tNDYZw7wvk0oOddnj7u0YHzJPnh1y66bTHBbbx+vIpVm8VeBuXIp/PUxJZ
 /I4JUh1XREfMbCgB9p5eEx2OF8WV/aO+BSoL+0xg26iH5+mUOPsA==
X-Google-Smtp-Source: AGHT+IHgj/28swyed3HfZ03vQUuGyvjjaUs74xb6EcPLjz8y0oI0qSk6kUH7PThKJH7R7FqN22xNQQ==
X-Received: by 2002:a05:6808:80a9:b0:44f:def8:2aa5 with SMTP id
 5614622812f47-4535d13150amr2594594b6e.0.1764706231140; 
 Tue, 02 Dec 2025 12:10:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45317113578sm6013232b6e.22.2025.12.02.12.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 12:10:30 -0800 (PST)
Date: Tue, 2 Dec 2025 14:10:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
Message-ID: <20251202201028.GJ303283@bill-the-cat>
References: <20251202182403.GF303283@bill-the-cat>
 <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
 <20251202185222.GG303283@bill-the-cat>
 <CAFLszTg+Q3=6fChTzxWz+wOxOUV-et2qL0phrf-JvQkcP57-4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g72GJxnSDAw4ckt6"
Content-Disposition: inline
In-Reply-To: <CAFLszTg+Q3=6fChTzxWz+wOxOUV-et2qL0phrf-JvQkcP57-4g@mail.gmail.com>
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


--g72GJxnSDAw4ckt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 08:07:28PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 2 Dec 2025 at 18:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 02, 2025 at 07:49:07PM +0100, Mark Kettenis wrote:
> > > > Date: Tue, 2 Dec 2025 12:24:03 -0600
> > > > From: Tom Rini <trini@konsulko.com>
> > >
> > > Hi Tom,
> > >
> > > > Hey all,
> > > >
> > > > I am wondering if at this point in time, anyone still builds our ho=
st
> > > > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> > > > Windows, natively.
> > > >
> > > > I ask for two reasons. The first of which is that a reason we still=
 have
> > > > to support Azure (despite its slowness) for CI is it's where we have
> > > > macOS and Windows hosts. But at this point in time there's so many =
ways
> > > > to have Linux userspace running on Windows or macOS that I don't kn=
ow
> > > > that there's any value to these builds.
> > > >
> > > > The second reason is more macOS specific and is that with:
> > > >
> > > > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> > > > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > Date:   Thu Nov 13 12:54:51 2025 +0100
> > > >
> > > >     boot: Assure FDT is always at 8-byte aligned address
> > > >
> > > >     The fitImage may contain FDT at 4-byte aligned address, because=
 alignment
> > > >     of DT tags is 4 bytes. However, libfdt and also Linux expects D=
T to be at
> > > >     8-byte aligned address. Make sure that the DTs embedded in fitI=
mages are
> > > >     always used from 8-byte aligned addresses. In case the DT is de=
compressed,
> > > >     make sure the target buffer is 8-byte aligned. In case the DT i=
s only
> > > >     loaded, make sure the target buffer is 8-byte aligned too.
> > > >
> > > >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > >
> > > > Which does things we must do, we now don't build on macOS. Why? As =
best
> > > > I can tell (and for a general purpose OS, is a good call), memalign=
(..)
> > > > doesn't exist and you need to use posix_memalign, a not drop-in
> > > > replacement. We could spend some time reworking the code here for t=
hat,
> > > > but for now I've instead gone with this workaround so that CI can
> > > > continue:
> > > > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsu=
lko.com/
> > >
> > > Are you sure about this?
> > >
> > > The code in boot/image-fdt.c is part of U-Boot itself, not the host
> > > tools.  As such it should be irrelevant whether the host OS provides
> > > memalign() or not; U-Boot provides its own implementation.
> >
> > We use parts of this code as-is (and some other less obvious files) when
> > building host tools.
> >
> > > OpenBSD doesn't have memalign() either.  But I can still build the
> > > targets I care about on OpenBSD.
> > >
> > > Or is this about sandbox?  Did sandbox ever work on macOS?
> >
> > It's about "tools-only" build target, but also I suspect that if you try
> > the next branch right now it'll also fail and we'll need to figure
> > something out.
>=20
> If you are interested I would be happy to come up with an alternative.

I'm not particularly interested in seeing what Claude comes up with, no.

--=20
Tom

--g72GJxnSDAw4ckt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS9HsAAKCRAr4qD1Cr/k
Crw9APwMh8KK3muWZ1geM2L/nflOWiZDwHbBcswge2O2IOqUKAEA2OkaxkWUck3V
3bhuNZmoMRLatbCXbuHaFxeL3vzK9gU=
=SRNF
-----END PGP SIGNATURE-----

--g72GJxnSDAw4ckt6--
