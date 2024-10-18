Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36002D3C549
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 04:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34664891FD;
	Fri, 18 Oct 2024 06:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tsL63J/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DD2589215; Fri, 18 Oct 2024 06:39:07 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF147891A4
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b154f71885so71492985a.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729226343; x=1729831143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nMP+dmEtttaEJMCJ8eXqJ+6DW9a9aVs/C/UMWZvV/Is=;
 b=tsL63J/b1WUdV/v/LAZ4FR95h9cF4+dcbvzMHqmpEH2wbs/uFqDW8X8cqhdA37V0LI
 u2Cnwfzybwtm4JHzaxJSLmS+34YVwjT3YgFz58YfCB9oNMqki0Ou9+y8yjAoOOFmU5BA
 Fg3OzvBBKSrWHHQk1LlTq/YiQ08m4N/StTk6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729226343; x=1729831143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMP+dmEtttaEJMCJ8eXqJ+6DW9a9aVs/C/UMWZvV/Is=;
 b=mC/+U/N6P5c5iP1n2fBVzDt2Ofwj2sJip8N5u7BOFVTwfs5x2H+FPRZhhQ6qTuTn+9
 U0WX7Z8UGoo+2+aualNSm6EvCCJYh5q+qo1iJ5ksDIzukXhs2b7eBdlEXZJD294WV1AL
 F7K80LvqqxZ4ImatPAiQ9YZh4m4X3Up0rPgRwnGSkrQf1iDWiP7rYYrbehkmDsvuifKX
 JFO1VBPzgimVZvnhf1N3myLtPdvB4772HBATl9Mjq/JNoYjzucRlqhTaVhsH+HOrV4Eu
 anaPMpwXnRKq4ppCq0znAaShN0zcCdHj3Owi6pVYQSkf8nwkg1SvJD5EVRQ9VOXs1lPv
 xulg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXucNsrme87pT3X/8FzQrBDrEgtYug/FrRGfm8xOq0Dd4xnU7rwlJ6uHFxaHHu/E3ztm/6zais=@lists.denx.de
X-Gm-Message-State: AOJu0YwC09yxbA8eDbBNLBKMRj/INrEPi08nOvIpyj32xZ1u6V9Gr+v2
 uUgS8DT123r647If0XYY9OolDsPEWUXLd7eblvCLugLuO+VG4hCB5h7dkCAwrh8=
X-Google-Smtp-Source: AGHT+IHScQYJeod6YTcW9vWVLHGFkzeECfnaAM31/lJs9c6zMm954DskwE30P0CL6+7OJDgLkCnFyQ==
X-Received: by 2002:a05:620a:4620:b0:7b1:43a8:3fe9 with SMTP id
 af79cd13be357-7b157bdfb46mr111512385a.46.1729226342745; 
 Thu, 17 Oct 2024 21:39:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156fe5b4bsm35638085a.88.2024.10.17.21.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 21:39:01 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:38:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
Message-ID: <20241018043858.GV4959@bill-the-cat>
References: <20240901222734.462334-4-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
 <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9l9lkNgwLlDxALHe"
Content-Disposition: inline
In-Reply-To: <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
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


--9l9lkNgwLlDxALHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass wrote:

> In principle bootstd can work without block devices, even if it does
> require driver model to be enabled in that case.
>=20
> The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> is now defined, producing recursive errors through multiple different
> paths, one of which is this (with Linksprite_pcDuino3 and
> BOOTSTD_DEFAULTS enabled):
>=20
>   arch/arm/Kconfig:7:error: recursive dependency detected!
>   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
>   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
>      part of choice <choice>
>   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
>      ARCH_UNIPHIER_V8_MULTI
>   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
>      part of choice SPL
>   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
>   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
>   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
>      choice <choice>
>   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
>      ASPEED_AST2500
>   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
>      choice DM_RESET
>   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
>      by CLK_RCAR_GEN3
>   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
>      CLK_RENESAS
>   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
>   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
>   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
>      POWER_DOMAIN
>   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
>      BCM6318_USBH_PHY
>   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
>   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
>   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
>   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
>   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
>   boot/Kconfig:398: symbol BOOTSTD depends on BLK
>   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
>   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
>   Kconfig:176: symbol XEN depends on ARM64
>=20
> We don't want to revert the change to BLK, which has been in place for
> a year now. We don't want to select BLK in BOOTSTD since it should
> support booting without block devices. The only realistic option is to
> remove BOOTSTD's dependency on BLK.
>=20
> Disable standard boot on the one board which fails.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v3:
> - Drop wip (work-in-progress) comment in commit
>=20
> Changes in v2:
> - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
>=20
>  boot/Kconfig                                   | 2 +-
>  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> Applied to u-boot-dm, thanks!

No, this is wrong, it's pulling in BOOTSTD on a ton of platforms that
didn't have it before.

--=20
Tom

--9l9lkNgwLlDxALHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcR5l4ACgkQFHw5/5Y0
tywGgAwAtffCwTp8ozekMoIvsYevmr0SRHUETwMjrcH0s6VoTfeHMk9NnbVJWDHj
oZVkxuASXaBOnvh1cm2aXQuU2N/6xYxTbizMjb51SgxTp5c4ocUpmq33iEvm0stC
LS6KbyMuvlcFUcASGoy9A1mYVboCTlX/4qKSd9KMAf/YafdAKZU+OxL2hU7G0xqf
tpO1UAa9e2VSXzOW/E6nJD3CnFrOtHT+HdS8Fgjo/SaTrSoOxIv/jo4y1qOmhfeB
3xQP8CFK+5+J2HWcZtwah1WkPs2IrvbtRt9n2TyZ/cEhrccrs4EXcRg8gW0Xml/F
FB3evWBsSFQDJ1/V6MqmttMSnMFZFZPSPMNoYm+6QzAU7pwlP5hFEvbYu8xDqu8K
chzu0eLny8c+00mDZp0PKq9+ctaMTDtpbb6bzTAB2OdAKnU6VE29p7t8Urm9W/Hw
5oLqDrbbaSfv37SFHcf+AcpW5cxy3+6GQtphtjwvHGKar1amaJSur7+0xQNKDQKI
dV20oTGw
=J3y1
-----END PGP SIGNATURE-----

--9l9lkNgwLlDxALHe--
