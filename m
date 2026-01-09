Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB71FD26D9D
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 21:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BFE843D1;
	Fri,  9 Jan 2026 22:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sJYwckHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73237843D4; Fri,  9 Jan 2026 22:33:24 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFD9843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 22:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7c78d30649aso3267241a34.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 13:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767994400; x=1768599200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P3Oigwjr4QijxrDynIEobEWZe+sHkVjulgTrKa348/U=;
 b=sJYwckHZOHtwKAVCnEKdlKGAsno1DMSUiS+B6wV7SOKFXSevdYw9fk8XutN9wpnVLQ
 v3xhs+ncZhsKqgsgejGzKossdtrqPp9uH605zXGwE5bG4dCNusJ3NORBeIrhnLoFFZil
 tF++ovbu+P7jfLMJpglHUXUTJN+R/zbe2qN8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767994400; x=1768599200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3Oigwjr4QijxrDynIEobEWZe+sHkVjulgTrKa348/U=;
 b=KhfBoiJoR5k8tHiA1I64juaWUobuL0KKhIRLYlBCbJa5eQBenRvpP1clljS/1K7fBG
 YgHClE1sftdDWf3mdf2DIDYXuv4rrxhCzWpJ8mARpDShC2v3EtAnZn6VyAInYlnEQu1V
 rtuyFS741g4c2rgnWJ6m4rh19WwxR3mag0L+w3UY1rTxGnAb0GMIH9GckRPlLXlTOcLU
 XjRUZ1+/dVwEJwpuLYqMeHCTzAtblvo+CLc7MavgQku5o9GPkvN8AEQtQWEdzBc6pg73
 Gnq9fNYBOi+RqN1HKQAjO9VXHe0WWBXhDWAHpjUo1aBNwe3v0S7tPBghV/WA5kpgxnjh
 LyLA==
X-Gm-Message-State: AOJu0YxRDph2388YVZdlGl7LWJ4OJpPWj9N9a/wkBpAFHfKH2a91E5iW
 lHrY3JZ6E4htnWdK0n+cdFCP/aBSqWT+MeSoXx7LD1epaazDVwP0F9cAi7LtD3qz7bo=
X-Gm-Gg: AY/fxX7vtQYuoDxDLsQQ2AA6UpQnD8n3y6fR9jgWognOMo+kBBXbGneSuIn60wvHR7S
 V+jyLdfqLTpxcH6PMEU8WzVPng7JXvz6keg0KWf7GI1si3yxTGBkQtxIS+QCjMG7bXHOfyC7ZXt
 XMHQFBPUFuMvym3xmsMR3medSBZEVWtG2WTPskpDWqOuTZV/CcBGRxFLOEvrEsQsH31L+O8H0MG
 Q2Hit3kmOEZDraB7ugUD0BxtrObN7NX0s33Up1biVlrreOzpQbnnf20e/F+IsnTcBnaqSCnu05p
 lwOf66XBBtqkcLw43cwypA4GMyVxfowSGAIAJGb9CDUaJkJgo2ccEAcJjkCBwsUN2U8W4EagWSo
 5XBWIcDC0nnMtDvYZbxMTXp++SarfcEWpF+ULB2QndIuTxS6hhithm1OuIhB1XdHV94OFQuiEkt
 kBX9a8RJyM+7xPYgJYw/TDnc9MaW7JHFE4Sn/4ObBxQ0tArZzm8YVcXkA8fzbmYL+Bx3ihNMIOS
 BhsNuY28t3gZXo8gxvxzPnEVlJecD3XeROklCd/wg4eayaPBg==
X-Google-Smtp-Source: AGHT+IE2MDKV5NM7vVffRI/nDVU7MuM8RvDCdlFHRy6vPSFifREvYNt/J3yqLOYVvCJJRTC1OkmL4A==
X-Received: by 2002:a05:6830:3c1:b0:7b4:f1e6:4957 with SMTP id
 46e09a7af769-7ce50a02094mr7454904a34.20.1767994400474; 
 Fri, 09 Jan 2026 13:33:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce47820f06sm7928854a34.11.2026.01.09.13.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 13:33:19 -0800 (PST)
Date: Fri, 9 Jan 2026 15:33:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuri Honegger <yuri.honegger@icloud.com>
Cc: u-boot@lists.denx.de
Subject: Re: Placement of FDT in memory
Message-ID: <20260109213318.GM3416603@bill-the-cat>
References: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
 <20260109170958.GE3416603@bill-the-cat>
 <89B99CA3-BA46-4755-BAFE-95C1944AAAAF@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zSuIFkkPs9Jd74Vo"
Content-Disposition: inline
In-Reply-To: <89B99CA3-BA46-4755-BAFE-95C1944AAAAF@icloud.com>
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


--zSuIFkkPs9Jd74Vo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 10:13:25PM +0100, Yuri Honegger wrote:
>=20
>=20
> > Am 09.01.2026 um 18:09 schrieb Tom Rini <trini@konsulko.com>:
> >=20
> > On Thu, Dec 18, 2025 at 11:04:59PM +0100, Yuri Honegger wrote:
> >=20
> >> Hello,
> >> Recently I've been playing around with the imx23-olinuxino=20
> >> (mx23_olinuxino_defconfig) and booting NetBSD using u-boot. During tha=
t, I've=20
> >> noticed that NetBSD panics because u-boot places the device tree in th=
e BSS
> >> section of NetBSD. NetBSD clears the BSS section and then complains=20
> >> that the device tree is corrupt.
> >>=20
> >> Reading the logs, it appears that FDT and kernel get loaded at non-ove=
rlapping
> >> ranges, but then u-boot relocates the device tree right after the kern=
el into
> >> the BSS section.
> >>=20
> >> ## Booting kernel from Legacy Image at 42000000 ...
> >> Image Name: NetBSD/earmv5 11.99.4
> >> Image Type: ARM Linux Kernel Image (no loading done) (uncompressed)
> >> Data Size: 11950164 Bytes =3D 11.4 MiB
> >> Load Address: 00000000
> >> Entry Point: 00000000
> >> Verifying Checksum ... OK
> >> ## Flattened Device Tree blob at 41000000
> >> Booting using the fdt blob at 0x41000000
> >> Working FDT set to 41000000
> >> XIP Kernel Image (no loading done) to 42000040
> >> Loading Device Tree to 42b93000, end 42b99a0a ... OK
> >> Working FDT set to 42b93000
> >> Starting kernel ...
> >>=20
> >> The bootm command seems to insist on having to relocate the device tre=
e.
> >>=20
> >> Is this something the OS is expected to deal with?
> >>=20
> >> In the meantime, I've managed to work around this by running
> >> env set fdt_high 0x41000000;
> >> before bootm. Is there a better solution than this to force the placem=
ent
> >> of the device tree?
> >=20
> > So, interesting setup. It's not a FIT image, it's a legacy image, so
> > there's a few details missing that might be helpful here. But, why are
> > you loading the image so high in memory? And we're calling it a Linux
> > kernel, not a NetBSD image, so we should likely be updating our docs for
> > booting modern NetBSD releases.
>=20
> Yes, NetBSD only generates legacy images when compiling the kernel. I sus=
pect there could be licensing issues with FIT stuffing everything in a sing=
le file depending on how it is distributed. Most device trees are GPL. I ha=
ven=E2=80=99t looked into it all that much to be honest.
>=20
> The memory location for the kernel are the defaults from u-boot for the i=
mx23-olinuxino (see mx23_olinuxino.h and mx23_olinuxino_defconfig) and memo=
ry ranges from 0x40000000 to 0x44000000. Is there an issue with how they ha=
ve been chosen?

It's not so much an issue but rather than OS kernels were smaller 13
years ago. The platform has 128MiB of memory at most? But is yours only
showing 48? It's odd that it's not relocating the device tree towards
the end of 128MiB, or 64MiB but instead 48MiB (base is 0x40000000 so
0x42b93000 looks like 48MiB minus U-Boot itself and malloc pools and so
on).

We were also a lot less careful aobut picking device tree and OS kernel
and ramdisk addresses back then.

> As for u-boot calling the netbsd kernel a linux kernel: That is NetBSDs f=
ault, for some reason it produces images with =E2=80=94os linux, although I=
 don=E2=80=99t know the backstory.

We have some specific NetBSD support but I don't know when the last time
someone tried it was.

> > The big problem is that for a legacy image, we don't (and can't in
> > many/most cases) know where the OS ends it's BSS and so have to hope
> > that we're relocating to the correct spot (in other cases we can see
> > this overlap and avoid it).
>=20
> I agree, we can=E2=80=99t expect u-boot to know where the BSS is. Perhaps=
 I should have explained my question better. Why does u-boot relocate the d=
evice tree before jumping to the kernel? If we have to provide manual addre=
sses anyways during the loading step, we already have to take care of ensur=
ing they don=E2=80=99t overlap and so on. From NetBSD=E2=80=99s point of vi=
ew, they already were in a perfectly acceptable place before the the reloca=
tion.=20

We relocate the device tree because we don't know that it was put in a
valid position or properly aligned. We also normally relocate the OS
kernel to where it was set to be loaded in memory, but in your case it's
instead set as "noload" and so run in place.

> > At
> > https://docs.u-boot.org/en/latest/usage/environment.html#list-of-enviro=
nment-variables
> > we document all of the environment variables and bootm_low / bootm_size
> > / bootm_mapsize are relevant to this case, along with perhaps just
> > loading the kernel image lower in memory to start with?
>=20
> Thank you for pointing them out, I=E2=80=99ll play around some more and s=
ee if I can find a setup that doesn=E2=80=99t require too much fiddling.

A full console log from power on through initial kernel boot might help
too, for making suggestions. Generally, the OS gets loaded towards the
bottom of memory and the device tree moved towards the top of memory and
there's not an overlap.

--=20
Tom

--zSuIFkkPs9Jd74Vo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWF0GgAKCRAr4qD1Cr/k
CjRFAP93cz/lY+/oMSui6NXU6gn5mvXHAa79x9yCxKrSonqnfAEAzkye3fJvCL6A
FQrjgauwrPhTJhBiRIasVmy9ffW3qgo=
=M3Li
-----END PGP SIGNATURE-----

--zSuIFkkPs9Jd74Vo--
