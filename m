Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371DAE9A047
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 16:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693CA83AA9;
	Wed, 18 Feb 2026 17:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SPU4BGLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 820BC83C19; Wed, 18 Feb 2026 17:17:22 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7A282BF2
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 17:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-413d8b8e98aso965442fac.3
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771431438; x=1772036238; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EsMttGxlTX5XOnqN6hFH7kZ6CxQ8JmBAMwq82SrdDEk=;
 b=SPU4BGLBa8Anibab4kRSalrpWwwtrANUvcXbTPUnSsOoTUpw9quam3E27O8XNNEOjJ
 T1+Ou27KQwvVm8PyLrQBPEmvPP9ODSaJjD8NsT+DopPeqo/r3R9L074QfOCv9j+THHEU
 6eDc9w1Wr4G1e6oSazrstf9DVXFChZD8DFu/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771431438; x=1772036238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EsMttGxlTX5XOnqN6hFH7kZ6CxQ8JmBAMwq82SrdDEk=;
 b=LEeUQhNNeBIEgLX3qBrzx1YaNbEANC2KzjoLq29zYELrzBtwET1TEj23d1x2ax2e5b
 qt3CMAya9qDrgTdtvrCsb+tGmVHSFbp5KejigubXJgPlP0AW7/FDMfQo4bcOW+A12eRT
 YTTypaRRn4GDN7/wz4G3a6RMwSWTD64XsD+9wb2UPlCR6HJatTBIb4ecWku6IBwk58SU
 pqs7wmAKe4bxjjerIZyGBjjS25h6eCmWpZMa8YPakTX8MqP3R1h4w+4kWiyKB1b0hND1
 AR2hLSF9l0X7M6vBs/FpWKvWAo4HPnPh37KL+ybA1QBZFOwSvQql9lqZddP/dYLUNRtp
 Oj2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUHERFSk8YZVd4QTqpWbn7kbFaprEtnJ5uaEfGjO1ZUDgDAF6AkNXbF5byZ0kiXAOtNYCeaAY=@lists.denx.de
X-Gm-Message-State: AOJu0YzvYICXgvxF3fwKqvILP2aGTCsDiNyeQHIBlo7fwegMkiLjpVOK
 G/5/E1U6IpKHY2og+6ResRCGf+nTkdbC72w6+bkuj19/NJa14FhLji7XtJaHgMvgCyg=
X-Gm-Gg: AZuq6aLqhUbL8yA6HKCDRs9IPzwxHtnvI6/GJ/e2EkLsnDsRqhll6ik8/qqzkB/IOs4
 Ybt8s3cY4yhPd60r6/t0u0zq/lTMYS//TuCHxJMkOXDkUAbD+1EqCkSFMk3TeSBl/TsCy+XvPn5
 uRD84GwgVOuYt+cY8h86NAJ0kOyk03on0drULKZjNe26lSnhbI+PZq/7FmIwKYaPDuch+76LdVD
 Fl3l7DRtEJpcknY9727+UbHMlCAWKioqHJlToXoWtBFRSD1RgieC2nAM4uIGUVcPEJ4ysfGR/pv
 w8OO0I2zvJoQcnAuOyzDWweu4mZ+lx/ZlSpsUylZl99MHEFmUJ3ePlULomGaWP43of0AH3FRGH/
 xx9jNwBwqsklkK5QOa7QkYMOnNYqZJqHCizRWYyUn2UNfjwSwBZU8IfWYOH9Bv5wnHZKfMRGiky
 i8OLsELx5yjLByXDWqUK7VR6HQedoqbFlucSA+9/ELniNjvjlAe3Difz8M4hmABMCQvRyOmINJu
 dCxjc8r
X-Received: by 2002:a05:687c:2610:b0:40f:2ae3:2601 with SMTP id
 586e51a60fabf-40f2ae327bamr7118420fac.10.1771431436030; 
 Wed, 18 Feb 2026 08:17:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40f18df8a64sm12635154fac.14.2026.02.18.08.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:17:13 -0800 (PST)
Date: Wed, 18 Feb 2026 10:17:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 git@amd.com
Subject: Re: [PATCH] xilinx: mbv: Update stack, heap, and OpenSBI memory
Message-ID: <20260218161711.GD3233182@bill-the-cat>
References: <20260218063329.396968-1-padmarao.begari@amd.com>
 <20260218141224.GA3233182@bill-the-cat>
 <363a86e6-8ebc-4b76-8bc9-34e317362b71@amd.com>
 <20260218143243.GB3233182@bill-the-cat>
 <3010524b-9d61-4c03-86ee-af06f995d686@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HH58ab12f5/3uD0Y"
Content-Disposition: inline
In-Reply-To: <3010524b-9d61-4c03-86ee-af06f995d686@amd.com>
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


--HH58ab12f5/3uD0Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 04:17:38PM +0100, Michal Simek wrote:
>=20
>=20
> On 2/18/26 15:32, Tom Rini wrote:
> > On Wed, Feb 18, 2026 at 03:18:37PM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 2/18/26 15:12, Tom Rini wrote:
> > > > On Wed, Feb 18, 2026 at 12:03:15PM +0530, Padmarao Begari wrote:
> > > >=20
> > > > > A 2=E2=80=AFMB region of DDR memory is allocated for U=E2=80=91Bo=
ot SPL, with the
> > > > > heap starting at address 0x80000000 and the stack at 0x80200000.
> > > > > However, U=E2=80=91Boot fails when using OpenSBI v1.8 because Ope=
nSBI begins
> > > > > execution at 0x80100000, causing an overlap between the SPL stack
> > > > > and the malloc region.
> > > > > To resolve this conflict, the SPL heap and stack are moved to
> > > > > higher memory addresses, and OpenSBI is relocated to 0x80000000.
> > > > > The SPL heap now starts at 0x8C000000, and the stack is placed
> > > > > at 0x8F000000. The MB-V requires at least 256MB of DDR to run U-B=
oot.
> > > > >=20
> > > > > 	_________________
> > > > > 	|		|0x8FFFFFFF
> > > > > 	|_______________|
> > > > > 	|  SPL- Stack	|0x8F000000
> > > > > 	|		|
> > > > >       	|		|
> > > > > 	|  SPL - Heap	|
> > > > > 	|_______________|0x8C000000
> > > > > 	|		|
> > > > > 	|		|
> > > > > 	| Full U-Boot	|
> > > > > 	|_______________|0x81200000
> > > > > 	|Load FIT Image |
> > > > > 	|_______________|0x80200000
> > > > > 	|   OpenSBI     |
> > > > > 	|_______________|0x80000000
> > > > >=20
> > > > > Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> > > > > ---
> > > > >    configs/xilinx_mbv32_defconfig       | 4 ++--
> > > > >    configs/xilinx_mbv32_smode_defconfig | 2 +-
> > > > >    configs/xilinx_mbv64_smode_defconfig | 2 +-
> > > > >    3 files changed, 4 insertions(+), 4 deletions(-)
> > > >=20
> > > > As general feedback, this is something that ought to be in doc/boar=
d/
> > > > somewhere too. One such existing example is doc/board/ti/am62x_sk.r=
st
> > > > and follow-up patches are fine.
> > >=20
> > > Just curious. Memory layout is something what every platform has to d=
eal with.
> > > Don't we have any script for it?
> >=20
> > My still current preference is putting reasonable default values in
> > Kconfig, so that it's not something that has to be managed in defconfigs
> > as it's not typically on the developer to modify per board, but rather
> > on whomever is doing the upstream SoC/etc support to say what it is. But
> > that's also a little less true for FPGA platforms?
>=20
> This platform is soft core as classic Microblaze is. Difference is pretty
> much that this is risc-v based ISA. It means memory location is not fixed,
> memory size is not fixed (because there will be users of openamp where sm=
all
> amount of memory can be also used).
> And IPs base is also moving from one design to another on the same board.
>=20
> Anyway setup is that SPL is running from small memory - we can call it as
> OCM which by default starts at 0 (but can be changed). And we got only 64=
kB
> of memory that's why spl stack and heap need to be placed in DDR (which is
> already configured). We had it at DDR start but it is not practical becau=
se
> after handoff to opensbi that memory is unused.
> That's why make sense to have opensbi at ddr start to use it fully.
>=20
> Currently BSS is the part of OCM but I can imagine that we will move it to
> DDR too to have more space for text/data/rodata. But the problem is the s=
ame
> how to define BSS location.
> I don't think this is going to be a problem to get it via tool machinery.

Thanks for the explanation. Yes, some tooling could indeed spit out a
config fragment that's correct for the configuration you have. And I
think it would be good to capture some of the above in documentation in
U-Boot as well.

--=20
Tom

--HH58ab12f5/3uD0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZXl/QAKCRAr4qD1Cr/k
CocOAQC8hjBcT2SEL1UhRGQ4o5Ua+ddzgkZvziCSe99Vl9fZkAEAvzDipI6kn7wA
nAplkgEf95MYnUH/Z7hDwzkXNcqfxQg=
=MHpL
-----END PGP SIGNATURE-----

--HH58ab12f5/3uD0Y--
