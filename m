Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8769DCEBF60
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 00:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53D688F4C;
	Fri, 27 Sep 2024 02:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jP6/r+4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58B488F4C; Fri, 27 Sep 2024 02:20:52 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A133388FAF
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 02:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a99e8d5df1so136295785a.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 17:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727396449; x=1728001249; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nAcO4octDlncgMSVB+ANS+w86feWCa3BuzuKr6sP0Zc=;
 b=jP6/r+4RaVLzqpZov/zx6FRQvfYo6TLYN7mZX0FvFrnJv2itQMe7Sm88SHgy5SeIRf
 G8KOIFITRYbCJAvJ5XFhDpb8F5Zh60C8M8pElnWwuwiHnW4gJEwwDD03Go8BJZwWspTd
 pKL1s7T1V+FyeMijFudUTNRMhxMAUPSVXKkvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727396449; x=1728001249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAcO4octDlncgMSVB+ANS+w86feWCa3BuzuKr6sP0Zc=;
 b=DQrCdUXwZ7AqbnJy1eonpNyW6ZC/888cY4mdAmfOXz7olUuzAFqQlerJNED4HarsGc
 maH0UMlX/6JKfZ+4rM43DdhVTnDUXdNf58+jQ0OAZO/7dGUojo33xUqjEjpS8akr8SoY
 ucsqz7Wxu++couQkkgeBgIGFUbnLVusJ+0bd4C68k98ZjHGZn1fI7DwxsCN1iFBcY+gp
 vplXIExzaB2IEx1+NIRgnIzoqaDlA8EV0B0kMmeYsf+WbFLQYbHnivxYskVWiUa8X2P+
 P4QpS04ZtRSRnzUja7B8m+JuzzMm7OpaNG9mMplzZHKVBucsYY+DzzPBKakbR+Gk8npp
 rg7w==
X-Gm-Message-State: AOJu0YyU8fayPBwPCmX8hkGCbVw/LnkhtazmNS5GqwCIKnw4JSmmNF8n
 S2cVABopcPZA5npPnLdU87hq9gdZ1lgRVkT4n0cHlG5dk7SgAEmQ7vVL8r0ty48=
X-Google-Smtp-Source: AGHT+IFzxSngzsMGwbHGS46cYP1aMluVUivsz1SLxqGLAI+T4lpRMpghwwpgtiJDxpG27L8nWhL90w==
X-Received: by 2002:a05:620a:24cf:b0:7a9:9f5e:26bd with SMTP id
 af79cd13be357-7ae3783b57dmr237854285a.15.1727396449430; 
 Thu, 26 Sep 2024 17:20:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae3782c6c0sm37014685a.88.2024.09.26.17.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 17:20:48 -0700 (PDT)
Date: Thu, 26 Sep 2024 18:20:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tim Lunn <tim@feathertop.org>,
 huang lin <hl@rock-chips.com>
Subject: Re: [PATCH 14/42] rockchip: Simplify check for SPL
Message-ID: <20240927002045.GO4252@bill-the-cat>
References: <20240926223814.1276764-1-sjg@chromium.org>
 <20240926223814.1276764-15-sjg@chromium.org>
 <8615c7b6-37b2-4c2f-989a-b1780310ff86@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GHqRbOpw7HCF2wQk"
Content-Disposition: inline
In-Reply-To: <8615c7b6-37b2-4c2f-989a-b1780310ff86@kwiboo.se>
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


--GHqRbOpw7HCF2wQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 02:13:32AM +0200, Jonas Karlman wrote:
> Hi Simon,
>=20
> On 2024-09-27 00:35, Simon Glass wrote:
> > Now that SPL means SPL (only) and is not defined for TPL, simplify some
> > checks for SPL.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >=20
> >  arch/arm/include/asm/arch-rockchip/boot0.h |  3 +--
> >  arch/arm/mach-rockchip/rk3399/rk3399.c     |  2 +-
> >  drivers/clk/rockchip/clk_rk3368.c          |  8 ++++----
> >  drivers/ram/rockchip/sdram_rk3288.c        | 10 +++++-----
> >  drivers/ram/rockchip/sdram_rk3399.c        |  2 +-
> >  drivers/ram/rockchip/sdram_rv1126.c        |  9 +++------
> >  6 files changed, 15 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/incl=
ude/asm/arch-rockchip/boot0.h
> > index edb2a31c348..918f0495fa0 100644
> > --- a/arch/arm/include/asm/arch-rockchip/boot0.h
> > +++ b/arch/arm/include/asm/arch-rockchip/boot0.h
> > @@ -54,7 +54,6 @@ _start:
> >  	ARM_VECTORS
> >  #endif
> > =20
> > -#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \
> > -	(CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
> > +#if defined(CONFIG_SPL_BUILD) && (CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
>=20
> This was changed from SPL to XPL just to be changed back to SPL in this
> patch?, such change probably just clutter git blame, was the change to
> use XPL really necessary in the first place?
>=20
> Because SPL_BUILD was used together with !TPL_BUILD it is pretty obvious
> that SPL_BUILD did not need to change to XPL_BUILD in the first place.

This comment applies more globally to the series too. Once you have the
knowledge of when "SPL_BUILD is just building for SPL" reworking things
in light of that will make an easier to review series I believe.

--=20
Tom

--GHqRbOpw7HCF2wQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb1+lkACgkQFHw5/5Y0
tyxsRQv/a19ZSSTnh0QNKzGnVPAbrIrX7HITAiT72/kMODT3QWh235R2eQL3RdCF
bhkrxPRDaZ6x2ltFDJ+zV3wB06RrWutx5LJoa36rKh2Mjzurkw2Cxy9t8C4rMznk
UqChlCXSG7jo7CIiwFrCo11hbFK6ph3crfadY7w/UeG4N2kCRNhQy7p5X6U0C5p+
UqNRJughWQ1TpnNNwkZt0M2qffL008AHe36O5NwlwUCeeGt1bfDvkQZfuuWHo8yC
/Zl1Aycy4ZiQbRUk4ucQEcbFez04z63ealfnnjtWTXNat1H6cs8s4YAyl+z1h0mQ
oaXIK14/5KAaa6Xz1fB5E+SkX4qHuwZ+v2mC5+bZ0W+z9nY+seE+YdLJbp/AxuPJ
a1QxJWneREBeOO6g9c7TYJ5D8EM8mR1IVfbr2eIrI0AlGNO24wTcdNDB7uS5F2JH
TnpCDQHNCk3ix8S0TMTZZen/upM3NjG+hlkbQuFDXRDHucHhHZ1YRR4tcJRVspFd
JTh1Jc9g
=nrEA
-----END PGP SIGNATURE-----

--GHqRbOpw7HCF2wQk--
