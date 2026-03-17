Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B82FD8770
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5C184326;
	Tue, 17 Mar 2026 14:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MfCzj28U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9E084329; Tue, 17 Mar 2026 14:44:33 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D51484320
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7c76e1951so112610a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773755070; x=1774359870; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5eVZgN3m2PJEIzoOTNY9Cr+Q41UvsyjcdCd+F0NHhqI=;
 b=MfCzj28USVzzLaD2LkQFwTpJkV48ydkIGz+YuyJJknLh43eF4cNEUHdDss/jlSl6x3
 Az4Szs3u4R9MVQq0243ZtEAWtVWxqUumUbUEtTgu3tZ7FuKO7HCkOAvouAr8ZrJNuttx
 UrB2y0fTJbjBbJ1Xs4kuKM8GlipqtKuSVvcgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773755070; x=1774359870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eVZgN3m2PJEIzoOTNY9Cr+Q41UvsyjcdCd+F0NHhqI=;
 b=SjEtnLCSAN3pyEOe9O6vCGwSiBCas9a3v5vl3CTyt0YUyjpbn+a8pkHydP7Mr09NGX
 5PqUT1GTD8O6fRHft1hr3hTnUYVZnxhERe9wefokW6j7KyDNgNGCvt+KFA73jfv4GULI
 v55zCxYNBDT0ev1HNTqd50WMw4DCAqukj1Q6NcBmPJ2adK8/YkUQQ990wMY9Ooh1Dbpy
 YS3+Ofl0NHNMWImU6zZ1t23ZUvRDiEbLj51GA4mq5nahMwTn147FoI5Y/xThJ/ZZq04J
 GJ4xZ954EzBG4m01Zgvz95EOxYeSfGbXrnK8UmfPJM/MOBM6uD6BjGvq1LtMEk/nlo9c
 LzlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj8b1qtqtQJakjsoc0edrc15VSzDFc2lqGGbjb2yukU1xlzvcfWvOC3wPpmSbn6/0DHMQ8ejQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyywQSqNuX49vfqaoZ3twr8+hN7oAL+Mblg0P6jZ7uazx19mSpV
 wXAu6gWuooePmdd6gtsOK1YssiNJcSLrsqb/KtQ9/usHH6405rr5pyI5wKK6k1z6rK80Glz08cj
 bPhc6AAk=
X-Gm-Gg: ATEYQzyo4h29hFlztk0QR2Y9CeCS1P75v+ZyF/PC9Iu8IJ9mIHZ9NjxaWa8XDwK3ut7
 zN9ZieP2ACiz9e1qv9dQL9qzOXt9eHt5BFWj7uhC6pu9Qf/VnRzffuTqGApFAH6JWl7bhsi4LFj
 0fd4ODVgDZ1Ie641R/82Cvlebt+81gy8HJHlifsCHZ0gFCrBS/pa2y9kVcsC4RQkA2wIHWoQ+xi
 pXgipOgWTKdezqSneQgPijn7ETMp6qNsPdtEm+i5TrVq7qDxd4CKIWzITllyTILlRQgekWa+URI
 poB1//L8OHx1yr2qqwh8sMEkc4QCksjQuUltCSrk5UwGu09DfSnr2paX7dug62azwQqrplua6/b
 tlCNH5+tMJRP+2rezPFoi5wnq6E6BMxAWicQxCip4FmPGTqo3MkyJrytk3fyB0ian0xtAKDp+bP
 /oDhn0GLkjqG+SOHgfXzYPRMOvzz+Xysp8WqbjQIU4FgXWAEwVHOdZp3CwRprMy/tfxCJWshg1v
 ubn/0AulaVy6ThQ5uuO15Lvca+A/+3zO6FF7S5YJ0JkPa+9
X-Received: by 2002:a05:6830:6a9b:b0:7d7:58b0:8e72 with SMTP id
 46e09a7af769-7d78246abd1mr11560373a34.4.1773755069711; 
 Tue, 17 Mar 2026 06:44:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aa5dcc7sm15040288a34.0.2026.03.17.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:44:29 -0700 (PDT)
Date: Tue, 17 Mar 2026 07:44:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
Message-ID: <20260317134427.GU502704@bill-the-cat>
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+PvuCo+M3NyYwVMm"
Content-Disposition: inline
In-Reply-To: <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
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


--+PvuCo+M3NyYwVMm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 08:42:39AM +0100, Heinrich Schuchardt wrote:
> Am 17. M=E4rz 2026 08:03:47 MEZ schrieb Ilias Apalodimas <ilias.apalodima=
s@linaro.org>:
> >Hi Tom,
> >
> >On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> As exposed by "make randconfig", we have an issue with the dependencies
> >> for EFI_HTTP_BOOT. As this is implemeneted by running commands (as seen
> >> by what it selects) it must depend on CMDLINE as well.
> >>
> >> Signed-off-by: Tom Rini <trini@konsulko.com>
> >
> >In theory, you can configure UEFI with a set of prebuilt boot options.
> >If one of them is http(s) the device will boot even if CMDLINE is not
> >selected. I am not against this patch, but we will remove the
> >possibility to build a firmware without cmdline that just boots to
> >whatever is was preconfigured
> >
> >Cheers
> >/Ilias
> >> ---
> >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>  lib/efi_loader/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >> index b5f81e0ff530..a9b2f813e1d5 100644
> >> --- a/lib/efi_loader/Kconfig
> >> +++ b/lib/efi_loader/Kconfig
> >> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> >>  config EFI_HTTP_BOOT
> >>         bool "EFI HTTP Boot support"
> >>         depends on NET || NET_LWIP
> >> +       depends on CMDLINE
> >>         select CMD_NET
> >>         select CMD_DHCP
> >>         select CMD_DNS
>=20
> Having to select commands here to get network is what needs to change. Th=
e network commands and EFI_HTTP_BOOT both should depend on configuration sy=
mbols for the protocol implementations.

Yes. And this is about fixing missing dependencies, today.

> @Tom: Do we have a target release when to finish the move to the LWIP sta=
ck?

We do not. I'm not yet sure if all the various use cases of the legacy
stack are fully supported now (I don't recall off-hand the NFS series
state right now for example).

--=20
Tom

--+PvuCo+M3NyYwVMm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablaugAKCRAr4qD1Cr/k
CnDrAP9ctubgE5XnwegVYqfTEPHirHL4Qat4qw2XL3iVwgtssgEAlJbwDnXvjVGu
GV+d0pcF42UF9bkuMDOjCSUyFhcjBgI=
=tfcl
-----END PGP SIGNATURE-----

--+PvuCo+M3NyYwVMm--
