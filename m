Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12612D26D8F
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8159D843AD;
	Fri,  9 Jan 2026 20:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L0TkMXKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC95843D0; Fri,  9 Jan 2026 20:33:28 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD03984390
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-455a461ab6eso1932883b6e.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767987204; x=1768592004; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iEkQByCUcPHCUzV1JmefgGURSoaLNrIKZ8mmwLSJjRg=;
 b=L0TkMXKCd1wCWsI7Q4g8c08YUVJ3qnbAZDtLsxuCXp/72ow5P+5KmAaBrEAyqhVU74
 r0AMZlzzNI4+7+NmDJWJSSdenMgVkSYY8fTlphC6hReWgxwCK+h8MmZbSHFGa3oDK7Lx
 xeQY6+qytcph94TYE1y8nyeEI0L22lHwCiqDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767987204; x=1768592004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEkQByCUcPHCUzV1JmefgGURSoaLNrIKZ8mmwLSJjRg=;
 b=NH71OCj3iXP/oHuzQYizArdKZDCFUToIOZiD3rhLpHgkMLQgtIvWAbq5mJcUPxgHGw
 ih1g1Qhqpi6fbmW6tKx8PLAw08nc7pJromH3txPnhFO663t8JZ12JA3PTq74q41kF6Az
 9ZocKmBAJ71LFBHA7SRIIeH9AQfcMXesNDOqxcwqcVnILN/g1qW4H7ap+N8HVOcc3lJF
 thoXq2GHRD6WjUk3wEZc0EoK6QuuKh98vNWXOYuZO+ihEl7wqkW/x3l+kdO0rXo96p0Y
 wqX4YJKKmsYKsO23SLzhdxGX6VJ2XPW5WGIuPPl9z8T28fcXOgqs0JfY6y9V0JC9TV1F
 il/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlTj2pttuHR5TL27OIuKxwr/8Olantjg8/SR/8sxPEOOMbuNxOShyxue01CeXAdHlyH2uVt08=@lists.denx.de
X-Gm-Message-State: AOJu0YyiGTq/Lz9ooOKqx0PX1QKEZ4AKuxgQIYbWVMgD4TLwdZs4TT3r
 5NQvRgSvJB78/kURuWID64gKFSeG53rnfkzi/OeoeSl9/Vsz9bI8yNYJIJiH8EyRgu4=
X-Gm-Gg: AY/fxX6z8QxQLH+VAUizMZE8G4D0rSVYrYJGBiDv4PlNv/5DTBEHIT+QkDgp/eRKuO6
 KOORQfIAd1QVpuIeXDA5fl0elx8gqDI3KW5X6ZNoz0XU8B8A2uvJ0mtqPkRcJnN/e6fEIZn4H6I
 lyiHpmSMKhWAz3YF+Pj1lBo6GB8EuMxUcFZ29X+B7zpnX4y2Ai159HiYBxTVNwrbSo42zNK3p79
 UOfaLVQUn26AhmN+ulnnxk2PTRQk0M0GRfksk+2MDiQYgobh6yJZEZSYXXRxdzKYGheccGpLbiU
 h4IHuBwyd46DJuILT0xwzXpQo3DX34OAZjMcprcoVbugpldraVdHxkxNlmz5+ZYBUTl2PFv7Xg0
 6UhN8AigY+DX+ZbcAmeD0CuSOuz+/K+hnHdr5g87U/gAeEDzRztFQAIqzgEzZG0u7lRKxu5KCk6
 1pDWMMTdhpYExcpxTJ27UmG7z4RXBtV4hCy/7DUbhAQk0ZQtfewgQBd2GIo4KvnouXt3t32DdnR
 FGaX1tlxprc3lCSlLABV8XDjUnbbRoqH7vnAVssm4EWFSH/nA==
X-Google-Smtp-Source: AGHT+IHNlwZ3U7z/P10Q32tE0SObKbwet6hBrwnj3DDlENW8QTYRkPQInrbZws05FEdq0hGGlw5mbg==
X-Received: by 2002:a05:6808:19a0:b0:43f:5c61:448c with SMTP id
 5614622812f47-45a6bebc4cdmr7530925b6e.39.1767987204468; 
 Fri, 09 Jan 2026 11:33:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50ecb58sm7377776fac.18.2026.01.09.11.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 11:33:23 -0800 (PST)
Date: Fri, 9 Jan 2026 13:33:21 -0600
From: Tom Rini <trini@konsulko.com>
To: "Padhi, Beleswar" <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com,
 anshuld@ti.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
Message-ID: <20260109193321.GK3416603@bill-the-cat>
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-3-b-padhi@ti.com>
 <20260109191054.GJ3416603@bill-the-cat>
 <48022594-212f-4f43-ba9b-0802711e88e5@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ycTTsZ4OGUmlUFsu"
Content-Disposition: inline
In-Reply-To: <48022594-212f-4f43-ba9b-0802711e88e5@ti.com>
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


--ycTTsZ4OGUmlUFsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 12:51:39AM +0530, Padhi, Beleswar wrote:
> Hi Tom,
>=20
> On 1/10/2026 12:40 AM, Tom Rini wrote:
> > On Sat, Jan 10, 2026 at 12:30:26AM +0530, Beleswar Padhi wrote:
> >=20
> > > The OMAP2 SPL linker script (also used for K3 platforms) currently us=
es
> > > 4-byte alignment after the __u_boot_list section. Change this to 8-by=
te
> > > alignment to meet the device tree specification requirement for DTB
> > > alignment.
> > >=20
> > > However, this alignment directive only advances the location counter
> > > without padding the actual binary output. When objcopy extracts
> > > u-boot-spl-nodtb.bin, it includes only actual data, stopping at the l=
ast
> > > byte of __u_boot_list (e.g., 0x41c359fc), not the aligned address (e.=
g.,
> > > 0x41c35a00). When the FIT image containing device trees is concatenat=
ed
> > > to the above SPL binary, it gets appended at the unaligned file size,
> > > causing libfdt validation failure.
> > >=20
> > > To fix this, add an alignment directive inside the __u_boot_list sect=
ion
> > > itself. This forces the linker to include padding as part of the sect=
ion
> > > data, ensuring objcopy includes the padding bytes in the binary and t=
he
> > > appended FIT image starts at an 8-byte aligned boundary.
> > >=20
> > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > ---
> > >   arch/arm/mach-omap2/u-boot-spl.lds | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2=
/u-boot-spl.lds
> > > index 3bb759d8a1c..081323e6599 100644
> > > --- a/arch/arm/mach-omap2/u-boot-spl.lds
> > > +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> > > @@ -35,9 +35,10 @@ SECTIONS
> > >   	. =3D ALIGN(4);
> > >   	__u_boot_list : {
> > >   		KEEP(*(SORT(__u_boot_list*)));
> > > +		. =3D ALIGN(8);
> > >   	} >.sram
> > > -	. =3D ALIGN(4);
> > > +	. =3D ALIGN(8);
> > >   	__image_copy_end =3D .;
> > >   	_end =3D .;
> > >   	_image_binary_end =3D .;
> > Do we need both of these? Shouldn't we just need the one inside the sram
> > section with a comment that this ensures the end of the SRAM portion is
> > 8-byte aligned?
>=20
>=20
> Yes, we need only the first directive. But second one is just defensive
> programming, if someday someone changes the memory layout, this just hints
> that __image_copy_end should always be 8-byte aligned... Doesn't hurt to
> have
> it? Let me know what you think!

I think a comment is better defensive programming than extra ALIGN
statements. And with this discovery, we should also I think audit the
rest of the linker scripts with a ". =3D ALIGN(4)" to see if they're
likely in similar spots.

--=20
Tom

--ycTTsZ4OGUmlUFsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWFX/QAKCRAr4qD1Cr/k
Ct9FAQC4M0ba1Rm4cLwl0oYDRKQHr2kYyvJe4XgvAbJ1v62GYQD7Bp6g9OL86tdz
9ol05oTMs35MO7u1I7yvlpiyrtHP7A4=
=ZHm9
-----END PGP SIGNATURE-----

--ycTTsZ4OGUmlUFsu--
