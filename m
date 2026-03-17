Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B49FD876D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 600D684320;
	Tue, 17 Mar 2026 14:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nUdOkJMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF0C384320; Tue, 17 Mar 2026 14:43:03 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9858431C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-46702742c99so3539989b6e.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773754979; x=1774359779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4+kT+zwtsAwjF7fymXfs6SO4kkfsjyDPIb29LDFsaUI=;
 b=nUdOkJMyEVTt88oOFOOS8da6pxofCW0hUGkGHcN56PYQGY+pUl9R1ouVw8Jvw8Easi
 mrFmBufCOSjE1Ak8imvoIox7TxQ2WMCe18UGuwywZALva0p4wMqCKA6hyfzayftAp+1E
 b38pmmus2Wrl6ewhbasuSQYIw6OIPBQjrIiaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773754979; x=1774359779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+kT+zwtsAwjF7fymXfs6SO4kkfsjyDPIb29LDFsaUI=;
 b=o7NKIJvqQQ4UXQlm8ZflCG2jAD1OlGKvDp2XUATlsfWLD0glQJqkuMwSy2zM5F3IqO
 MmRwgsCMWHE4xds45ECWmZos/ATqAkNKpFtu7AhglJ4DL65C9H4wGhTfPoDYkpWK1tyd
 D1eongL8MUxx98oy9UXOgXdqrYAlHhjQ3KAtqHNCqsbDA5ZsnVo1C0507I8Q2UkUzYgL
 KULURpyYO/JYvWJ6pLBpa5/zouqOuwQBiGq8RyvgqCIBmyJp7+G6Eu81hQjokvOCyW0s
 yJGysANhxGtsQJ+gfzjg2FLyFniSMlhmauf+FtNG8mWPEIAWaxPwVwCzwFT2sDYyHkGR
 kEHQ==
X-Gm-Message-State: AOJu0Yx/Ym1N529KDYgBLxUszZRWbizPV5EHM102CcXHEMcKEdc9RZiP
 JK7ncZpSMxMCidgZPCd7Th21AU9rMZNoXvzVdVAhalhxK6+uy8eCRPwms0Tiv2+xx1w=
X-Gm-Gg: ATEYQzwrkzXZWKtOivpNGOIE6DEgdLYrC/Io+rNXPIK1MB8SbDBbxw6tJo6TxAxfmni
 zfVBg/h7XpPuEhermLtVG+BaVr9TDIUcELeLDiTRnK2G68kkKacbsw/l58sol6cUrR2TewkneG3
 ovo70GIBrT8/EjoW3lptKgcfXVQ3fma05c/mmG+QfTW6umXBPQJzvEtKSk3Vhv5SMmA8uSp6/Hm
 oc7f5j/PD7O0eFvca1b5gLRw0O4PPXr0M4aWlIRpTgSFDrZnpv6qKo8TbqYE4FS+e0od2zEcck1
 46Tfu0MFeboOQdpCkp5fxcoPQzc6D8Ez5K/R9lwuvxJcXhtjH2L5TMFtR2sf5xmQsO4z+QCSdDS
 +ct3WGPaBLzhX92iTS7Nbr8yQWtPVB9lT9LOe7cRPEno5PPaGIQoDojmAkY+sYIti7PZbEuwnSt
 /0zgxVMJyUlX9OZMj3o6iAp2DYb+SlOOtBefidn3pkFwEuH41ncb4RT4ieNcHbVaCY7FxlvHOo5
 9VmiBQs0YusZNpUCwN5k986ow0VEL74SEBb34VYMMm5Ndik
X-Received: by 2002:a05:6808:5186:b0:467:3f4:907c with SMTP id
 5614622812f47-46757402a73mr8874881b6e.47.1773754979402; 
 Tue, 17 Mar 2026 06:42:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46734160cebsm11297448b6e.7.2026.03.17.06.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:42:58 -0700 (PDT)
Date: Tue, 17 Mar 2026 07:42:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
Message-ID: <20260317134256.GT502704@bill-the-cat>
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dhss2Osi4b6FqPUV"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
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


--Dhss2Osi4b6FqPUV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 09:03:47AM +0200, Ilias Apalodimas wrote:
> Hi Tom,
>=20
> On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > As exposed by "make randconfig", we have an issue with the dependencies
> > for EFI_HTTP_BOOT. As this is implemeneted by running commands (as seen
> > by what it selects) it must depend on CMDLINE as well.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> In theory, you can configure UEFI with a set of prebuilt boot options.
> If one of them is http(s) the device will boot even if CMDLINE is not
> selected. I am not against this patch, but we will remove the
> possibility to build a firmware without cmdline that just boots to
> whatever is was preconfigured
>=20
> Cheers
> /Ilias
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  lib/efi_loader/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index b5f81e0ff530..a9b2f813e1d5 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> >  config EFI_HTTP_BOOT
> >         bool "EFI HTTP Boot support"
> >         depends on NET || NET_LWIP
> > +       depends on CMDLINE
> >         select CMD_NET
> >         select CMD_DHCP
> >         select CMD_DNS

The select lines here mean that you cannot do that, today :)

--=20
Tom

--Dhss2Osi4b6FqPUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablaYAAKCRAr4qD1Cr/k
CtrmAP9HMEDxku0VuT8rZEeNSgg0yWUwoR1uJ7ZbIxPc+QfgvQEAlGZYfFW5OlnO
an0gb3vwWbHiRhRZLLiIcQXEduyGEAY=
=1d1f
-----END PGP SIGNATURE-----

--Dhss2Osi4b6FqPUV--
