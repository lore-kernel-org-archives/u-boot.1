Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E55D61020
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 14:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E44783EF9;
	Thu, 29 Jan 2026 15:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jYA6hCv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B174A83F9B; Thu, 29 Jan 2026 15:54:22 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCB983D1A
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 15:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45f171cb842so695113b6e.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769698459; x=1770303259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6nEjoWOynKdx+2pWL2CsueTKW3yjRoWpOOzAID6slrA=;
 b=jYA6hCv3bIBP+GkrEPmbzS5sCuaoXSIq6yOxNloZxSUWsM4lEqn+aXqIUr1UdEA1TI
 RmLytNyNGKvqsP3vssaT41JzavCy6j7F0VEUzpj5fpjOvv0KfXyTRJor3mGa4BcyVWi3
 ryeZc38wxjw94rx4umi3rtRbhfiAvIwPQYC4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769698459; x=1770303259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nEjoWOynKdx+2pWL2CsueTKW3yjRoWpOOzAID6slrA=;
 b=I23J5U8cqaC7qA2dkToljayZYQF407FM7SRij+CSC4b95wKWsL+CsTov9bopKiZd+z
 jNen1WRzTmxmVTMc2cZfHTcT4Bcd81394QDuPXIQkBLm/GhVOSWHg1B2oCxdNgrgZsHq
 6iZgGWOyk93Gxpanfx9pL10RFfFANrbPJ6UhHdpWVbo2MqqIueewgnnU6Qgge+9XRHlB
 ud9tsq95Z/Lge8F5Nfc9z3UA3+opgsskhbQeGZF+mNb8wOf9hAcez63GCrvQPOFQwgt/
 TtAue2khRucHArCoz8wWM3dx2eCOnlBs30OQR8ySn/ki9KOhwNGSpXybziD/luEISEXK
 o13Q==
X-Gm-Message-State: AOJu0YztsNT/UEi4mVZJyfYKv6nYQORoqj0rkZA3qRDceVuJrdshF8JO
 hiGdzi6bkDtqRlBUi/TSUYC80CLF6lQMyYB/9iZoVVIs7B/zh45F0CfCl2DIxbUsljQ=
X-Gm-Gg: AZuq6aLtscTD/Y3eC5W49N3A0LyE0cIHpiM+N0Y79mglS1sy3O/b835NCJ2ZrLDrek7
 H3EQKEAWbqvyGkVzi2g3VQyB4pu2s4Ks+BhsvAUndXs7kF8XJHMmDEEHwkIyYn3+J0ukOmqqm+B
 Qxsvq1MrNlG+h+2Hybg3tr0FyaCxz0XE9VBpFuvpilcgmg5GQkPTpEPbPLVlrgCtqsI+R8W1M75
 AHhq969pjul2LTLUTcGiCTL8D5Nj0s+fnnAcwdZImv039fvteRZe8O7REiUSZ7sli0nP3vOO14K
 URkqzzQqNtLMx9YRNhziUNZIMINJBUp4lHxE7CxK3a4Yd4k/IPZCqNHDBGEdWiJZVOa1Dg/k6WX
 6uvcHiciI9foD2KX52iunQyXd05XZUzEOm8Yl257+n7aJebn7cZNmcpsC012rtbWPKRGKVtQYTa
 ez4Ijk8A/dtB1TofEFNlOyA0L0jBXhBN9JRNh82TPBFTDyQOEpGJrnJKyBAx/euUp2Myohcm+Nz
 FwVVqzshYxnfIw5eRcLBcSmowgfowhddvTk7ww=
X-Received: by 2002:a05:6808:10c3:b0:45f:156c:e5a6 with SMTP id
 5614622812f47-45f1e2fb2a9mr1855632b6e.14.1769698458908; 
 Thu, 29 Jan 2026 06:54:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f22b4e676sm1294604b6e.3.2026.01.29.06.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 06:54:18 -0800 (PST)
Date: Thu, 29 Jan 2026 08:54:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129145416.GR3416603@bill-the-cat>
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EoxfuAYT/4UwX+lF"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
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


--EoxfuAYT/4UwX+lF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:
> >
> > > Hi Tom,
> > >
> > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> > > All Cyclone V boards are unable to boot, not sure this patch is the f=
ix?
> >
>=20
> Hi Tom,
>=20
> > Yes, those commits were unintentional and have been reverted.
>=20
> Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae5dc8d50a
> Same situation that the boards are unable to enter the SPL phase.
> The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works properly.
> After that things are broken.

Please give
https://patchwork.ozlabs.org/project/uboot/patch/20260129035512.639362-1-ma=
rek.vasut+renesas@mailbox.org/
a try as I think it might have been working before by alignment luck
rather than design.

--=20
Tom

--EoxfuAYT/4UwX+lF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXt0kQAKCRAr4qD1Cr/k
CtOaAQDpp5s4/KHSrT18Oxc5gmQJsrkOAwurUESW1OUydBL6AAEA0/YXiD/KQsR7
TppHi86uZ89wGoBuiBaDNjdj4Vk8JQY=
=NqLP
-----END PGP SIGNATURE-----

--EoxfuAYT/4UwX+lF--
