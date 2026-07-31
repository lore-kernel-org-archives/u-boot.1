Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360B8C5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 15:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B37D41125;
	Fri, 31 Jul 2026 15:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBXH1Nukz00m; Fri, 31 Jul 2026 15:30:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48CAD41109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785511835;
	bh=RRPJHVVTo7XuMGQiHVprtDTlRPTaR/gjtfNHNqaufGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n+V7G990qrIgSU82TLezhbMvtQ7rGH9r3pw1NcGYx4hfOSP6kF29CA4IaIOTN9Y8A
	 enCvw+4DwCRcQGsNPuFWCk34tGgZIOA06dt7ICOl+nYTayrxc1kbOp5Qt2bJpVmjUY
	 9uMju6luVYMR2mD1SoaxZlmOi7bTxsn0qe9FRqLMmjPq3o8Qq7zAOj+dKs0DFDhSYb
	 G3bYLW6YeRL6qbaAXFbgz5qkuVh+x+Nu8N2avx+3FPeKijWRhF5Al0JAy4Vo6bFyce
	 +3crPKkCgMPWPQB/q5ZgMvv3RHlHB0i6nvAoMz+hf1IdjxYFuLjeZoGXxNLDpc3hfS
	 8KGKzT6o5+RoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48CAD41109;
	Fri, 31 Jul 2026 15:30:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 550AD37F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32C9841109
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHjex5w2mrSb for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 15:30:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 33172410FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33172410FD
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33172410FD
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:30:33 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso1023313a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785511832; x=1786116632;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RRPJHVVTo7XuMGQiHVprtDTlRPTaR/gjtfNHNqaufGA=;
 b=QTRxgPY3w2/+f0hsOzuYtIBzVyeXblIm3pUibmW1YeDFX/8bJHfZlboYt/AATV8StK
 bSZLDbaoofFUkueZJO44vWkYrpbz5dVeJmceKPX2F5CEeQTmywrWNcZF+GJATGPGu7fT
 Y3tM9PNfx6JhigHepnNej+9QGoQBlkNWkFP87ZvGDRWvY0a1s/+nsi1O4A3K42xcDd6d
 cb+cw/cv+kFr0hFWFwnkp4s30xifH5i6ckFWe90JKSKvBuXybthkR5dpGVybTHGFQhUs
 M8yYY9KL8NVlWrggzDhKOKC2+tDMtv6ptqaLDPnVW0YuGJigwsFXVwTv8e1XnmobmgHc
 G1JQ==
X-Gm-Message-State: AOJu0YzAzqgTe6t8G20K8qTsuFQyK8p9H6w7lH2qgnXqoGP5IcSKSQFT
 VWoALBPnn4Ay+eiBXgJAVeqJhnO35olu/iov9iCcvzC5CdMFgM/YNPHwOW3zTt/ckyI=
X-Gm-Gg: AR+sD115OPwvQG81Vz9AyEF8Ag3VzUFIQC8s76hsyIjFRpIK8DS01Dc5cds+fX/BwVQ
 kF8+FTNs60Cd+q5BMD8PATw3OZKKfEsseSG8cpJgZ+hA8XxSfxcALynWgJ6nW6qIqUVFbmhvxje
 SRL37kjQbPyJyYBL7yb2XYpNZAmHPRYQTsvO3FXuYN1BfJov1et6kLNRlMCPEGO7YJN3Y2iGhRd
 /AtZqpm1nbI38YuvAi+Or3xLToXcpG17sNYaeRZArPy91Ku2EhO8aKn/G+a2pkaEstApxjUMdOc
 hrgai5ab2jGyKFXtfgq06k2hOWp7izvA+Ywx9IH3PtwwgdpEcFEznuDHKthz8+Ww4oYj1t+bFGC
 qj4THXPSgQFlOmgiHHNbjQwEjOjBtKZ+iKXDZ7+55mLrdf+kpsmJDHCq7flSBi4b+NiHctE2TMk
 kotznLJkFBOcL0bSpVBCxuYXWg2OP5d24p0xgUlu/55NwzRz8GsV1IzXMh35JQU98k2bK61AFIg
 fyAC6/DPI2hvT+eRxABMvxKX3/eFwIkClrmWFKLZgIDmrLLLlVA80Z6PFWRjIeS4L6ABFs7b2iq
 UR9ZnA==
X-Received: by 2002:a9d:5d04:0:b0:7de:9b99:a8ee with SMTP id
 46e09a7af769-7f1893c77c8mr1145403a34.9.1785511831675; 
 Fri, 31 Jul 2026 08:30:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed3bd35sm872603a34.2.2026.07.31.08.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 08:30:29 -0700 (PDT)
Date: Fri, 31 Jul 2026 09:30:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: makefile confusion about configuring u-boot in OE (ARCH and
 UBOOT_ARCH)
Message-ID: <20260731153027.GN1773261@bill-the-cat>
References: <68767aba94c02cab3697b18b65de848cfadb7a2b.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jj0pw1LVXfaKUR2b"
Content-Disposition: inline
In-Reply-To: <68767aba94c02cab3697b18b65de848cfadb7a2b.camel@linuxfoundation.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785511832; x=1786116632;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RRPJHVVTo7XuMGQiHVprtDTlRPTaR/gjtfNHNqaufGA=;
 b=OQhycq8+PLBsCFhUsDAPEaXBKC7Ce8qlAwgVMmxqfu095QnvLz6wptd8fR714IQXgV
 sDgOLRTGq6YZe/sc/Ljz0JZq687m/3vG8pKvmxwyMZyhMg9zKAyfuV8D2jKLccHzGl6t
 6wUhAlUyMZOBfLsdhbPh/zmpXXihF1+n4qk3M=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OQhycq8+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--jj0pw1LVXfaKUR2b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 04:01:06PM +0100, Richard Purdie wrote:
> Hi,
>=20
> I'm trying to clean up some class code in openembedded-core and I'm
> getting confused about what the "docs" say I should do vs. what the
> code does (vs. what OE does).
>=20
> https://github.com/u-boot/u-boot/blob/main/Makefile#L381C1-L399C20
> Makefile in u-boot says:
>=20
> """
> # Cross compiling and selecting different set of gcc/bin-utils
> # -----------------------------------------------------------------------=
----
> #
> # When performing cross compilation for other architectures ARCH shall be=
 set
> # to the target architecture. (See arch/* for the possibilities).
> # ARCH can be set during invocation of make:
> # make ARCH=3Dia64
> # Another way is to have ARCH set in the environment.
> # The default ARCH is the host where make is executed.
>=20
> # CROSS_COMPILE specify the prefix used for all executables used
> # during compilation. Only gcc and related bin-utils executables
> # are prefixed with $(CROSS_COMPILE).
> # CROSS_COMPILE can be set on the command line
> # make CROSS_COMPILE=3Dia64-linux-
> # Alternatively CROSS_COMPILE can be set in the environment.
> # Default value for CROSS_COMPILE is not to prefix executables
> # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
> ARCH		?=3D $(SUBARCH)
> """
>=20
> so that implies that ARCH from the environment would configure u-boot.
> Fine.

But is unfortunately a relic of our "copy the kernel Kbuild files in".

> kernel-arch.bbclass in OE exports ARCH and UBOOT_ARCH.
>=20
> I want to stop u-boot.inc inheriting kernel-arch since I'm not
> convinced it is entirely compatible and we need to make changes there
> which we don't want to affect u-boot.

It's not entirely compatible, true. It's largely (for values of being a
few years behind in kernel releases, but not as bad as we were at the
start of this year).

> I therefore naively changed u-boot.inc:
>=20
> -EXTRA_OEMAKE =3D 'CROSS_COMPILE=3D${TARGET_PREFIX} V=3D1'
> +EXTRA_OEMAKE =3D 'ARCH=3D${@oe.kernel.map_kernel_arch(d)} CROSS_COMPILE=
=3D${TARGET_PREFIX} V=3D1'
>=20
> This proceeded to break all our u-boot recipes.

Now that's interesting. For U-Boot, "ARCH" is meaningless. Whereas in
the kernel you have to set ARCH, it's just a Kconfig question in U-Boot.
Usually it's harmless to set.

> I think I'm concluding that:
>=20
> * ARCH from the environment no longer changes u-boot and the comment is w=
rong

The comment is wrong and I don't think it's ever really mattered, but
there's times when it's been non-harmful.

> * OE shouldn't/doesn't need to set ARCH

Correct.

> * we should just drop most of this from u-boot
>=20
> That brings me to UBOOT_ARCH, which takes ARCH and does:
>=20
>     if   re.match('p(pc|owerpc)(|64)', a): return 'ppc'
>     elif re.match('i.86$', a): return 'x86'
>     return a
>=20
> on it.=A0We generally use UBOOT_ARCH with mkimage, e.g. "uboot-mkimage -A
> ${UBOOT_ARCH}". We then have code which does:
>=20
>     UBOOT_ARCH_DIR =3D "${@'arm' if d.getVar('UBOOT_ARCH').startswith('ar=
m') else d.getVar('UBOOT_ARCH')}"
>=20
> to find code u-boot which implies UBOOT_ARCH might not be right.

So, for passing the architecture value to mkimage:
https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/boot/image.c?ref_t=
ype=3Dheads#L62
is the map between strings and values. PowerPC probably still needs a
fixup if powerpc64 is something that needs to be mapped.

> Am I right in thinking the valid values for UBOOT_ARCH are "ls arch" in
> the u-boot tree?=A0
> If so, the arm values in that function look dubious in that arm64
> shouldn't ever be there for example?

Exactly. arm64 is a valid UBOOT_ARCH but is under arch/arm/

> I'm no u-boot expert, I do know something about the OE classes and
> build processes and this all looks a bit of a mess to me. Can anyone
> with a bit more experience tell me if I am missing something obvious
> here and if this is as much of a mess as I think it is?

It's certainly a bit muddy here at times, yes. We use Kconfig to
configure things, and we're a little behind but that language doesn't
evolve quickly either. We use the Kbuild infrastructure to build, but
we're lagging behind and don't use all the features of the kernel
either. We likely use little enough of them that it would make more
sense to just set CROSS_COMPILE as needed via EXTRA_OEMAKE (unless
someone is aiming to build with llvm instead, and so the KERNEL_CC,
KERNEL_LD, etc, options).

--=20
Tom

--jj0pw1LVXfaKUR2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamy/jAAKCRAr4qD1Cr/k
CkD/AQCGlapRBJ/BvQYwV7yD1MnqXXTJKHWrr2Jkp6FWG4N+aAEA02xT53SLw+Zw
dPY1rnjIYt6H++/gNTJYWy9xwoByUgg=
=nbWP
-----END PGP SIGNATURE-----

--jj0pw1LVXfaKUR2b--
