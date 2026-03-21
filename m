Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067961094489
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 17:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41AB483FED;
	Sat, 21 Mar 2026 18:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LwLX0mMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57DB83F00; Sat, 21 Mar 2026 18:10:36 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C65583F00
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 18:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-467161c4b89so1597393b6e.3
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774113033; x=1774717833; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uKYoVjZkKAdZeJWnNa91xVLBtVPq+PV8zPZ5AJJuZOU=;
 b=LwLX0mMTL9E5hJfhDY1lepcALm44wLDmjV/lDuc/4QIkayLv+bqLF1m08tl6Ijw993
 ilplLR10XX6EWgx9I9Q+ipNlXUHO04bFfjYF5NmQ/rf32iHDV6e5G4jr/dcwDnvd3c5W
 T1zpLvvj6wHI/Fy7xa2ebhdpWyovm+oAdzQZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774113033; x=1774717833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKYoVjZkKAdZeJWnNa91xVLBtVPq+PV8zPZ5AJJuZOU=;
 b=NOIxl27dWSgDXXwTU4iCY4+vJiFQdtlRdIKW5NvJMuU2eAmb1Ts8fy6d3eJSuEw5NZ
 hVoi0AZEBVm5C9wVDuuRGnXsfQygpRZjlu2PwVBJd/wgyzHSIap5l1g/JrM6h3F+mxTK
 BwsZtLKL06Od3ijVl3izq/ZJ+ZCGWQeHFHkVdZjHnqtq1GumHLBwJbqr9Ho4eWKu9PZV
 3BBUtV9r2mvqR33IK0P3kQEM+ubHZcItpaeQxHP0pbGRg28c/KLtG4H6TWA2SO2aOUcS
 uD3iP5jHTRTl4gae/8ptQJVRNBqsWRUq3ZV/toRhjC2MF5U24egOK9p7zrcICQapeC6k
 yjpQ==
X-Gm-Message-State: AOJu0YzmsRS/ZPkTG+fDhOXPciK8ZKSfARnNrNttcLsjUavNB8lQYcn2
 0tkJCJgV65OlWiG3l9s/OypCsUdnhbTGrJAbkCIK+G7wOp4Nc+kOp/3bIpVvyqEZlU8=
X-Gm-Gg: ATEYQzwIRFZnaYYqwxufhfu4JwRbDWVCcmeVQiH8aLDiXbO73LCo+NKw8M8tT827q0h
 GM04pQowx1i/VcIvkzUhuN2f9BWcQYjbssGY7kAI1J7U3l36TJvfxOOSNWef/VfslAHBX+pej7M
 nImmYFhyaOJwgjUGB7cqWW/ka7g9Md7lchdUf69NCU5Xi3DS/SiDsK87B/CuRfaCCYrBv3SVCw8
 4V3lw9atre9mPz4e49gr0qdjZrLdaJQZvDBwx7gIOTtHFATvVAgw8UiQk+nVZWqq6PF5Eblp/dj
 cL1Z/MkVcCHXXN13ae23Wv6yPZiE09m5Ji7Ow2Tb4tFQrxPmzLSCnU9Q2tVc+3hLwg5QHQFIl9j
 Fr5KZ/4kEsTqACChLkGi0H6nLIM9uYXCSQSEiBG2EpbZdWOpZgxFw+YwdxWKhHJQCyyqPFmFygW
 iUw/308DK4zrpvLiQufLnFNOrDngWQV5llPi94Nf2v7G/6Bg/NOL2yL/SXzSMPhEDF/gMnpy+Ci
 ML+qpCra/4T6/wLuvg7kFr/AR2XBtccQWCuLvCdAcIK8YbG
X-Received: by 2002:a05:6808:820d:b0:467:58e:5d6e with SMTP id
 5614622812f47-467e5f419bamr3539004b6e.30.1774113033302; 
 Sat, 21 Mar 2026 10:10:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7f21e8dsm3434423b6e.16.2026.03.21.10.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:10:32 -0700 (PDT)
Date: Sat, 21 Mar 2026 11:10:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
Message-ID: <20260321171030.GF502704@bill-the-cat>
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
 <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
 <20260318012557.GF502704@bill-the-cat>
 <34a0c151-f8ff-4b91-92b3-d6f63097440e@mailbox.org>
 <20260319134128.GP502704@bill-the-cat>
 <11128ed2-a53d-4286-84cc-dc5c6d932405@mailbox.org>
 <20260320135616.GY502704@bill-the-cat>
 <2446be00-c67d-4dd7-b45c-da3925b23cd0@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v/FfW+BfhQplWGSk"
Content-Disposition: inline
In-Reply-To: <2446be00-c67d-4dd7-b45c-da3925b23cd0@mailbox.org>
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


--v/FfW+BfhQplWGSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 03:23:35AM +0100, Marek Vasut wrote:
> On 3/20/26 2:56 PM, Tom Rini wrote:
> > On Fri, Mar 20, 2026 at 04:58:13AM +0100, Marek Vasut wrote:
> > > On 3/19/26 2:41 PM, Tom Rini wrote:
> > >=20
> > > [...]
> > >=20
> > > > > > So I think the answer is if you fire up menuconfig, and turn off
> > > > > > RESET_RZG2L_USBPHY_CTRL and REGULATOR_RZG2L_USBPHY and DM_REGUL=
ATOR and
> > > > > > then enable RESET_RZG2L_USBPHY_CTRL things will become mad beca=
use
> > > > > > RESET_RZG2L_USBPHY_CTRL has select'd REGULATOR_RZG2L_USBPHY but=
 we don't
> > > > > > have DM_REGULATOR.
> > > > > How is it possible to enable RESET_RZG2L_USBPHY_CTRL without enab=
ling its
> > > > > dependencies ? This is what I do not understand.
> > > >=20
> > > > The way I said in the part you quoted? If you don't like the way I'm
> > > > solving the problem with the dependency graph here please propose an
> > > > alternate. But it is possible to encounter this problem, or randcon=
fig
> > > > wouldn't expose it.
> > > What I do not understand is, how is it possible to enable Kconfig sym=
bol
> > > without enabling its dependencies. Is that a bug in Kconfig ?
> >=20
> > There is nothing ensuring that when you enable RESET_RZG2L_USBPHY_CTRL
> > today that DM_REGULATOR is enabled. But since you're telling it to
> > select REGULATOR_RZG2L_USBPHY it then will give an error.
> Hmmm, I see it now. If I have both CONFIG_REGULATOR_RZG2L_USBPHY=3Dy and
> CONFIG_RESET_RZG2L_USBPHY_CTRL=3Dy in .config, and I delete
> CONFIG_DM_REGULATOR=3Dy from .config , then I can select CONFIG_DM_REGULA=
TOR=3Dn
> .

Right.

> But isn't the right fix the elimination of 'select' ? Linux Kconfig
> documentation now hints that 'select' should only be used for hidden

As a much longer term goal, yes, this is largely where we should go. But
we're still at the point where I'm catching these kind of dependency
issues in the Kconfig side of things, let alone build time problems.

> symbols. So how about this fix instead , that should retain the transitive
> dependency on REGULATOR_RZG2L_USBPHY , which depends on DM_REGULATOR :
>=20
> "
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2fd91d6299c..a7acd5cfa69 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -239,8 +239,7 @@ config RESET_AT91
>=20
>  config RESET_RZG2L_USBPHY_CTRL
>         bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
> -       depends on DM_RESET
> -       select REGULATOR_RZG2L_USBPHY
> +       depends on DM_RESET && REGULATOR_RZG2L_USBPHY
>         help
>           Enable support for controlling USB 2.0 PHY resets on the Renesas
>           RZ/G2L SoC. This is required for USB 2.0 functionality to work =
on

This is fine too, yes, please do a patch for it and you'll need to make
sure that renesas_rzg2l_smarc_defconfig gets updated with
CONFIG_REGULATOR_RZG2L_USBPHY=3Dy too so there's no functional change.

--=20
Tom

--v/FfW+BfhQplWGSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab7RBgAKCRAr4qD1Cr/k
CjSmAP9b8CI9oOHTEzIjX+zaGM5xAKOnbiRSHqzJLY0Zr1iBlAEAg2FEyZLuMPKE
sIZbT04rZC4Wxlog0ecPPb+oPDy9Rw8=
=62VD
-----END PGP SIGNATURE-----

--v/FfW+BfhQplWGSk--
