Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5E8C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6756281F45;
	Fri, 18 Apr 2025 16:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jCa94+KA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012EA82012; Fri, 18 Apr 2025 16:08:51 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA1E81E72
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72ec4634414so1192676a34.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744985327; x=1745590127; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P1CCiySXYWgjLdaxTNfipRWtGW+rRpkdsISY0j7ELNQ=;
 b=jCa94+KAnsc6oSyRZk0jPRvv37ksqtJn5NdHHOH6RtMkm8c6wncv3uMsjhdgLFWdWp
 z3vsXgWT6ooVO1OkoCVJPZnDAY+ixHnGasvIah9Z/RaDg5ef5ZIzZN6IktpZhPfc97a0
 YJiZ23q1N7ygfpDBSUGEEQvJcyVGZF+LY2paQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985327; x=1745590127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1CCiySXYWgjLdaxTNfipRWtGW+rRpkdsISY0j7ELNQ=;
 b=qwsgtjtrk8WcRerXNJloJAXNaEw06DQF7DcYM+NTdjiQkyvMQSGAhKilkQIQBi2iY9
 xDyU9R/zuPt8RGS0E9DUVL9XMd5zEw/qD/c2R9Rf7yQD84POvVoZRsczOXIAMgmaxoTe
 tv81SqRCUshChhgvb6q3JIspZze5L5GQem67vxixQ/caNtDtHlVm+GKvldxrI1HkpjBX
 HCTvaIcl/BtOU+2fXNXunyyM2FXGpVqx0A6DscwIs77InStbl0zQnt/jjavJnFA/ARES
 3sAXH7Y8i+kYN75f25hEYrn3Zr0BL1aVzPlq7vi5ppCGe6SLB6wlmBSJVvw3iwSMERCz
 UUPA==
X-Gm-Message-State: AOJu0Yx1wX3TjWMOmMttk92GwWDJIYx25uwta9CPJikFL7GdjNE6og+E
 bIKGRNtYm6HfxtQxoCo8a4iH5ehIqifxEtd3NAiGeDusm9ffEZXf0KA/FGPiC5DS1qn003eB9Vz
 7
X-Gm-Gg: ASbGncvbXJ7cW3QKX8R5O3wzGrejhKJygb33ky7i/i+lUzVJ7YcDMUtObCf6bYZfAmG
 whox79a7dTZaiQKuhGggUA+S5w584JnrLGf5Z1uWNhIHxgECeRhqzzNLxL5OuVtdgaKlqDLNuwU
 V1lGdrXhWMnb02Xp45jYO/F0Y7BK3TMQFYCZzV+K5U6OMADBqt5JwJoz7cgNKyTCbXJEh7eSrjp
 /WDT/qa9CLwF2dSvDoIeXe8z6LclulmJZ2eBdOiahSXRDzV8jFbzaB+v5C8psjL4NpGH/Q6QRph
 vF3o672Y9dv94PsNvNKnQx2qutq/ljUzWCemVOTbUIeUgpW2Xuwzzw2gk2Ox4UBXiSqKSinRUmQ
 Dow==
X-Google-Smtp-Source: AGHT+IG/+0NSVG13N/+W3Uv9croylyu8MOaGBM6PduEGa+UlbsOyGLmc+47FpZ8fZAHHi7R4as1Dvg==
X-Received: by 2002:a05:6830:6687:b0:72c:320b:fc8c with SMTP id
 46e09a7af769-730062f81f0mr1965499a34.21.1744985327106; 
 Fri, 18 Apr 2025 07:08:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-730048847b6sm358692a34.44.2025.04.18.07.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:08:46 -0700 (PDT)
Date: Fri, 18 Apr 2025 08:08:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Message-ID: <20250418140844.GP5495@bill-the-cat>
References: <20250418125111.2193434-1-sjg@chromium.org>
 <20250418133315.GJ5495@bill-the-cat>
 <CAFLszTg45QDjKT=5JH=Cpoy6Efv8KSPQbQ6KnA8QE6nM_bk+xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rA5AYzczXi+cgw9O"
Content-Disposition: inline
In-Reply-To: <CAFLszTg45QDjKT=5JH=Cpoy6Efv8KSPQbQ6KnA8QE6nM_bk+xw@mail.gmail.com>
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


--rA5AYzczXi+cgw9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 07:46:59AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Apr 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 18, 2025 at 06:50:59AM -0600, Simon Glass wrote:
> >
> > > This series restores the original behaviour of extlinux booting linux
> > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead us=
es
> > > a limit of 10x the compressed size.
> > >
> > > It also adds RISC-V support, since it uses a similar format to ARM64.
> > >
> > > Future work should integrate the code in 'booti' into main 'bootm'
> > > logic.
> > >
> > >
> > > Simon Glass (3):
> > >   boot: Add a function to check if a linux Image is supported
> > >   bootm: Add RISC-V support in booti_is_supported()
> > >   booti: Allow ignoring SYS_BOOTM_LEN with the booti command
> > >
> > >  boot/bootm.c    | 31 +++++++++++++++++++++++++------
> > >  cmd/booti.c     |  1 +
> > >  include/bootm.h |  3 +++
> > >  3 files changed, 29 insertions(+), 6 deletions(-)
> >
> > This is like pulling teeth. We aren't ignoring SYS_BOOTM_LEN so much as
> > it was never relevant here to start with. The documentation
> > (doc/usage/cmd/booti.rst) has explained that we use 10 x
> > kernel_comp_size for the limit. The "bootm" namespace has largely been
> > about uImage (and then FIT images when not using it's own namespace)
> > images and not applied elsewhere, which is why bootz/booti handled
> > things outside that namespace. And then, still, this series doesn't
> > unify cmd/booti.c with your changes, it just introduces duplicated
> > functionality, which is generally understood to be a bad thing.
> >
> > So again, please do similar to what you did for cmd/bootz.c and that
> > report and move the existing functionality over. We can then look at
> > cleaning it up (which should look like / abstract what we do for
> > compressed FIT images) as a follow up, in order to make bisecting any
> > regressions here easier down the line. Thanks.
>=20
> Well, I still don't understand what you are getting at here.
>=20
> The existing functionality for booti is already there. Marek added it
> a few years back. Can you please be more specific as to what
> functionality you think is missing?

With:
https://patchwork.ozlabs.org/project/uboot/patch/20250409155723.431102-1-sj=
g@chromium.org/
You moved the functionality from cmd/bootz.c and over to boot/bootm.c

You need to do the same thing here.

> Yes, the bootm implementation is separate from the booti command at
> present. They both call booti_setup(). But the booti command uses
> kernel_comp_addr_r which we shouldn't be using in bootm. In fact I'd
> like to get rid of those vars, not proliferate them. There is
> certainly some more common code which can be teased apart, but it's
> not the subject of this bugfix. I have to stop somewhere.
>=20
> Perhaps you should let me do this refactoring in the way that I
> believe it should be done?

One of the big lessons learned I've had from all of the code refactors
you've done over the years is we need to do them small and bisectable
because corner cases become a nightmare to understand and resolve. So
perhaps you should do the refactoring the way I believe it needs to be
done.

--=20
Tom

--rA5AYzczXi+cgw9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCXOQACgkQFHw5/5Y0
tyyC8Av/SU3dILiVHXFt7j2V7XQCQBFEbu9ep5lwB8Fxl19c8ef/GzatadvbdDrU
sKbwqy9QfDQxhVk1dpdBm3S98bFDnt24CZjjir/dhN2TGlPKZbDMggAJpmejWHFB
R8nU8DnZMxB3tQxjPSfqsrZKco7UHUed4L2FlmLducw1xzDpbbOAnnPehxk1ARvj
NKVoyqpCAxH2pPcgTlnIwjDD+1rIgkDZP8/sRjdJj1Xx8whk15nyWKBzEXACRzED
OAAZG9C//qk62PmTwGrmpaHSIpcrzhI1q+QZ3SIWJagipwXw3MmZgwTqRgKt39vo
IAOK9sHyMRuD0wyyyhYTDGGtho2OjnglwCh9SpGUVYkn7ySqdPShIC9wQ0iL+Y1T
cpbUzTg0SKVU9PS0xUYkuYRFdWG2olHLKvDbI/pJQIoCjYqxK5dckxSuS+gX1WvL
WtbuekufWp5qo8C4uPLiDmBzX4Hij8e4XM1kDgHzA2WxPGwrIpVm8xUqWjJ2jlWs
aISg6n61
=zq6h
-----END PGP SIGNATURE-----

--rA5AYzczXi+cgw9O--
