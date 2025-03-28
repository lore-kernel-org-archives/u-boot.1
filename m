Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053FDC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02788144A;
	Fri, 28 Mar 2025 14:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YRk+4SI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BF481951; Fri, 28 Mar 2025 14:49:54 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C658070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2c1c4e364c8so787299fac.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743169791; x=1743774591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jnK9QzJaiZbDojIznCizEZj9O1Hmg77gCjvuP4IFk2U=;
 b=YRk+4SI3wqhrmZtFin/+JlYcq71LNxCLjMbcBgH9AwYHYvU5b+WTLc+0hyuyk4M7H0
 JwyVZ16ZgrpFuQkSCeGSUePKYk+8hp8DJ5QcLhAlOCEHXACUXOOPbPq1vptgiRF/v58F
 f3ARjFJlvruaYU+tuyo8JqDEbqzcOV2f3gqgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743169791; x=1743774591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnK9QzJaiZbDojIznCizEZj9O1Hmg77gCjvuP4IFk2U=;
 b=ORplrHlDUN7VN4nCDAQgoTYS/l0IxWqVpUAdn6QNYj6+nXOVPL39YZ15JFL/6els66
 7y5Wd0LcsWVhIj4VgnTplh0+HXzl+wYwbG1IOS+krfnk3bY/IxC5vca+5uRwjin7PHXW
 50BelgprF2zeoTBWbt2UttVeOFuvQb/OMV/jWG9P0PxxeRnA2aXPf2VH5nQRDKDIPLMM
 MbENyY5fsPm5Gajd65y5swd4xIWofJ7yVtudvjeo90Ya5BdYeMCtOxVTn63qeeaapELW
 igtpqdWs0428/1ZeOdQHPr3xa3MqKWHI8m3sSAUAvcJBDVEsOD7e5y89u9vmc30r4ALR
 Z5GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4bIDIFWmlfX0bs0NSOuFKfxs4jI/3uQ+Z0IQZwW4V0jXixeSc1qn19AiKBZyrq8QP0QHoUHg=@lists.denx.de
X-Gm-Message-State: AOJu0YxkPsy382zMpxFbmT8DIbE0M61h9wHQ83sp9D/RTxu59cNAxJCh
 /lzAz/EE30PBNQSYH07z3LxNv77U80VOuVTrIVOodSxWe6b0N2NgoItdVf3BzZg=
X-Gm-Gg: ASbGncuXu6X8aUnuE/nOvkUQEJ3PciRlam2PSmRNh5E+4mffokm/E3ZyZV+EI+kaJUy
 6fJF/MCFBUdmezqOtYgNJqMAa1Y0xbqZCkW7Oua36Cui1VNSSnue3/Dokzv/IrXu0RRhxVFJ2sF
 E7i5A4uzbr0ID1Ozd4gJv0wnwmBhgyoZnMSPO/H5jShb8jEJcXYY8u8ZYutSHnEBJ3FDpCnVyyN
 1DTteeMr09vvqsy3r8viE9avxzu/ki69+VvRiHB+i1HVqf4MJZQ7x3cFseTlvQzjL5OQ6uFOLQm
 siV7RuKk1olIKQu6b1NPY7cZ7pQvg2Imbf8T5GeOLX6Ta9u52v8vd5JcaHzEm6oqWJ9ZMBINIkh
 gSQbITA==
X-Google-Smtp-Source: AGHT+IE8PSbE45imwYg0exUg5dzEIyjFyhjlIcGPqHHoaS9qGbwlkRCMZR9gaRGas/0SqxK3dpVlzA==
X-Received: by 2002:a05:6870:d88f:b0:29e:3d2a:a4a9 with SMTP id
 586e51a60fabf-2c870c00ef1mr1759606fac.5.1743169791024; 
 Fri, 28 Mar 2025 06:49:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a90e132sm419421fac.45.2025.03.28.06.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:49:50 -0700 (PDT)
Date: Fri, 28 Mar 2025 07:49:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 00/18] Annotate switch/case fallthrough cases
Message-ID: <20250328134947.GT93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <734a1243-53d5-42da-8d51-bec687f83c5b@gmx.de>
 <20250328103959.3980025b@donnerap.manchester.arm.com>
 <20250328134554.496fb357@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tdUDubTwLzcuM8Ew"
Content-Disposition: inline
In-Reply-To: <20250328134554.496fb357@donnerap.manchester.arm.com>
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


--tdUDubTwLzcuM8Ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 01:45:54PM +0000, Andre Przywara wrote:
> On Fri, 28 Mar 2025 10:39:59 +0000
> Andre Przywara <andre.przywara@arm.com> wrote:
>=20
> Hi,
>=20
> > On Fri, 28 Mar 2025 11:28:05 +0100
> > Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >=20
> > Hi,
> >=20
> > > On 27.03.25 16:32, Andre Przywara wrote: =20
> > > > C's implicit fallthrough behaviour in switch/case statements can le=
ad to
> > > > subtle bugs. Quite some while ago many compilers introduced warning=
s in
> > > > those cases, requiring intentional fallthrough's to be annotated.
> > > >
> > > > So far we were not enabling that compiler option, so many ambiguiti=
es
> > > > and some bugs in the code went unnoticed.
> > > >
> > > > This series adds the required annotations in code paths that the fi=
rst
> > > > stage of the U-Boot CI covers. There is a large number of cases left
> > > > in the libbz2 code. The usage of switch/case is borderline insane t=
here,
> > > > labels are hidden in macros, and there are no breaks, but just goto=
's.
> > > > Upstream still uses very similar code, without any annotations. I s=
till
> > > > am not 100% sure those are meant to fall through or not, and plan t=
o do
> > > > further investigations, but didn't want to hold the rest of the pat=
ches
> > > > back. You can see for yourself by applying patch 18/18 and building=
 for
> > > > sandbox64, for instance.   =20
> > >=20
> > > Can we use something like
> > >=20
> > > CFLAGS_REMOVE_bzlib.o =3D -Wimplicit-fallthrough =20
> >=20
> > Ah, didn't know we have that in U-Boot as well! Sounds promising, and
> > fixes the sandbox build for me (when using bzlib_decompress.o). I will =
add
> > this to the last patch and will check what the CI has to say about this.
>=20
> So for the records: silencing the libbzip2 warnings uncovered a whole new
> bunch of warnings, in stage 1 still. Some compilers used in the CI (clang=
?)
> seem to be more picky about how to annotate, so a pure comment (/* fall
> through */) would not cut it, it has to be the attribute - provided by our
> "statement macro".
> So I fixed those quickly, stuffed them into some patch, and now the first
> CI stage (test.py) passes - but only to uncover a large number of new
> warnings in the world build.
> So I will keep on patching, as some kind of procrastination project ;-)

So, for the flag, what I would like is to borrow the
CONFIG_CC_IMPLICIT_FALLTHROUGH logic from the kernel. Then we should be
able to do:
CFLAGS_REMOVE_bzlib.o +=3D $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
I think.

Then as follow-up convert any of our just /* fallthrough */ to
'fallthrough;'.

--=20
Tom

--tdUDubTwLzcuM8Ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmqPcACgkQFHw5/5Y0
tyyz8Qv/eEhlWh9wIE3DZpfmEV2q5CcWIKID4iw5TUn9TwUtZZ7DN9BegLDPXt0P
qY0Vz0cQb+8H6p4KRccxmvNSR1OmoTS4FEhKVb1xX6H44oNQR4Ht32pMhLZoo+xq
dezLUnMat608ccpi2vSOwz/OBaxefkxVzHMUjkPLIfE/d+JxPBDFcBqApzbmvUf+
eHSKErqRPX+C64XoEESN5LEcF4uWnDl7r1iF6VD6XeBVMFxE6sznbAsojh3P5uQ3
AJj+LOZQvurnRtvMk/greWqND0GHNPWpzlu+zNAzLn4unJNktKFIywR2vC9dFwk5
uCPVBJEG/xtZoMK5gU+cH5p5Z0/OyAJP4V5+GaT/kP/OERJ22UYKGjTAlrXtMHFK
iItHuHI1QPRqinkmSwRvhLFYwSWNzUavAaobhF5i5MDZcfgp2hdqnxt1R8ayptj8
RdGxmKC9OAc/qR8Ojoic4BHmRzaQ+u8lLwMghLHmzIqx5wWhvHYd40OKf480vFZM
RHFcee9r
=fLG+
-----END PGP SIGNATURE-----

--tdUDubTwLzcuM8Ew--
