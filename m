Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43101D68B28
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5F289282;
	Thu, 14 Nov 2024 15:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o9omjWk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C1289282; Thu, 14 Nov 2024 15:22:30 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6D788C66
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5ee9db85af0so421652eaf.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731594146; x=1732198946; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=atYg/GCAt0vVgFEmfNntwttiVp6ZmZL7RewYWsGzF48=;
 b=o9omjWk4GiHVyYFVemZo7xi23FE7jDQJ/p2JsjQ/wee4HKA0bSITJe1iG873Oo5CgA
 Myo+R26ThRz4T7WxE9BT7X2JYHWy4uIWHwYnA3tTKc69jtlivsmzz1XF3xEfMYBY2dbA
 nPYQawGZhZg+UyOxPy7vaihepxSXiKBqLrZiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594146; x=1732198946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=atYg/GCAt0vVgFEmfNntwttiVp6ZmZL7RewYWsGzF48=;
 b=QZ29xEq11PFtQEQrSSRL/iXHHfnDLg5oggGu7r8OdRwE7algE+DttHQidwBm0gEiPl
 XygfKdeg62Y2IspeH4e8YwOW4wKsHq7igpC9uTgcbIEqer8AuxeKcJ1hV8uNTql+ppVl
 nfpBNgUuJAMrF6u2Q+Ahy7MrQvjEdNpn1/GtMwoy3MVB0XNT2yNs8O54u8cwXr08jNOQ
 if3Tl4LzLLi99wYNl2OAy75cVJZ6YP0H2gCJBKgzD0HY8HiIYxDvMfy8964vJDtzXvqU
 mAhYbbGxucHs/IvxHKRuI84U3hvtQ4tSiHhTpda+oGrHIa5wlYfuWoahMjpMJTPL2/A1
 g3nQ==
X-Gm-Message-State: AOJu0Yw0w8PntcnwVbJIYIQFoPoVm0Tg40K8OjhVulOWGJy1CrxNFp40
 ijQsnmW0UKHWA7bxJvZpjmt4yvJH+dVyLRld24NP/XqCotPcKWf95xtQ6MNvv7M=
X-Google-Smtp-Source: AGHT+IG1BO1bEmppw7s5YJ9mXVcXQLOoHLuDeAIU5cN/W1nT91rN5e4uycyCCZq6ig/IAOUUHfAUQA==
X-Received: by 2002:a05:6870:2e0a:b0:296:116a:4274 with SMTP id
 586e51a60fabf-296116a87d9mr1141202fac.5.1731594145970; 
 Thu, 14 Nov 2024 06:22:25 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a6eb451c7sm382661a34.46.2024.11.14.06.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:22:24 -0800 (PST)
Date: Thu, 14 Nov 2024 08:22:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5 1/8] bootstd: Avoid depending on BLK
Message-ID: <20241114142221.GD3600562@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-2-sjg@chromium.org>
 <20241113174707.GR3600562@bill-the-cat>
 <CAFLszTjW2bGPRvUQC9pxvhKixpov8u2GxzzeUYeKo1FNFyuHug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9idUsM7CY2NzUZ/T"
Content-Disposition: inline
In-Reply-To: <CAFLszTjW2bGPRvUQC9pxvhKixpov8u2GxzzeUYeKo1FNFyuHug@mail.gmail.com>
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


--9idUsM7CY2NzUZ/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 08:53:31PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 13 Nov 2024 at 10:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 08:09:31AM -0700, Simon Glass wrote:
> >
> > > In principle bootstd can work without block devices, even if it does
> > > require driver model to be enabled in that case.
> > >
> > > The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> > > is now defined, producing recursive errors through multiple different
> > > paths, one of which is this (with Linksprite_pcDuino3 and
> > > BOOTSTD_DEFAULTS enabled):
> > >
> > >   arch/arm/Kconfig:7:error: recursive dependency detected!
> > >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MU=
LTI
> > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > >      part of choice <choice>
> > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
> > >      ARCH_UNIPHIER_V8_MULTI
> > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > >      part of choice SPL
> > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
> > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2=
600
> > >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
> > >      choice <choice>
> > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
> > >      ASPEED_AST2500
> > >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
> > >      choice DM_RESET
> > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
> > >      by CLK_RCAR_GEN3
> > >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
> > >      CLK_RENESAS
> > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
> > >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
> > >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends =
on
> > >      POWER_DOMAIN
> > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
> > >      BCM6318_USBH_PHY
> > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
> > >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
> > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
> > >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
> > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > >   Kconfig:176: symbol XEN depends on ARM64
> > >
> > > We don't want to revert the change to BLK, which has been in place for
> > > a year now. We don't want to select BLK in BOOTSTD since it should
> > > support booting without block devices. The only realistic option is to
> > > remove BOOTSTD's dependency on BLK.
> > >
> > > Disable standard boot on the one board which fails.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v3)
> > >
> > > Changes in v3:
> > > - Drop wip (work-in-progress) comment in commit
> > >
> > > Changes in v2:
> > > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> > >
> > >  boot/Kconfig                                   | 2 +-
> > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 7dd30a030e3..b5433e88f10 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -393,7 +393,7 @@ config BOOT_DEFAULTS
> > >  menuconfig BOOTSTD
> > >       bool "Standard boot"
> > >       default y
> > > -     depends on DM && OF_CONTROL && BLK
> > > +     depends on DM && OF_CONTROL
> > >       help
> > >         U-Boot supports a standard way of locating something to boot,
> > >         typically an Operating System such as Linux, provided by a di=
stro such
> >
> > This ends up being a massive size bloat on all of the boards which did
> > not use BOOTSTD before, and still can't (because there's no appropriate
> > methods). You need to not just disable it on the one board that fails
> > but on everything not currently enabling it, which now does enable it.
>=20
> Looking through the list it is hard to know which boards can't use
> bootstd, nor what the missing methods are. See [1]. I could perhaps
> disable bootstd for all of the boards?

Well, since you cannot have a block device without BLK at this point,
none of them can use bootstd since there's no methods for whatever flash
they use?

> > Or you need to better explain what's going on here, exactly and why
> > depending on BLK here is wrong, for what you're doing.
>=20
> I tried that already. We had quite a long thread about it.

Yes, can you remind me please? I still don't see why this is required
for sunxi support. And I think this is another good example of where
your commit message explains your solution, but not the underlying
problem you're solving. None of the platforms in [1] are ARCH_SUNXI.

--=20
Tom

--9idUsM7CY2NzUZ/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2B5MACgkQFHw5/5Y0
tyyb7Qv/aKWY6xMviJhbvzIFdW+5B+KC3RQGBuy5tUet8NW6YRw49N8cL/vzwCWC
gbwGQCoylXvakUcm19FJAWPn6IiXlfxNb9pBlhwQnuT+bzGTDq9mFn7Jj62c1P0j
M0n1xkcqGtI5l55MJWG4AHn3NFRF/ojzs5ePH11l1/6bIs1966n4KChnRymmZ/wV
zdMIMmDZwTnmN49MTaCPvsYEkt5egihBguuQ8W5b/qBaPypty7dXGrVMTwgL/Lk/
wiRVSOlIH4X6ztyHvCtHsGbVi/umGNMPEZsBBeChtYEl7lFrPkri4qyZmKbq3e1V
sTkb9z+LDvQwnA8Qpjsi3g47mCJCB7AFyex/ydkOo2wrLlMFziNLJBgejCqcunAy
FJyqiqGo2VSewA87RQKeRIqklPtyTg0XjAMuz9TkMnP48jSNPHhZp9zP42GENynD
zsIbBkO1lVGPymKvDkNprdf2g6ERsjYy+t+yJpNbYcWhgitaDhWwLV9FCYHYDp1D
Cuww4uF3
=LiLu
-----END PGP SIGNATURE-----

--9idUsM7CY2NzUZ/T--
