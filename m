Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516F1C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 21:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5DF84BE8;
	Mon, 13 Jul 2026 23:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YomxjG9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A4D84BE8; Mon, 13 Jul 2026 23:48:10 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0238284B73
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 23:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6a379b68f76so1160095eaf.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783979287; x=1784584087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YqvV8SDQa/vU9BpONmlmlhTE7v/kt+aASfM91XEcY/0=;
 b=YomxjG9F5jLhSa8O7M7NGWftV0Tfn5oyLw2RlyvLrhSvcvcZbckAce/o81gO0zx1U+
 +x0rlrZ3sdIoLJYc03EzZf3x3ZndJVbZ7FkovxiWKLTQbc+J8agRE1BCxqw6z1hFjErl
 ax2NlsKcSGhrhaZ0eIHk6uXbkP35eqtwkv7UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783979287; x=1784584087;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YqvV8SDQa/vU9BpONmlmlhTE7v/kt+aASfM91XEcY/0=;
 b=CS8xf0LkoFG4uzO2jj5ouqgJ3Yt2HipMbGJ+r/NEmUWTnSRq3OOBdq/oZYCTrc75BH
 2PaIibXggUBVKac17N8SgLszwfaQpsROXXGE2Rwqtempet2oap+2Nep+xsmds4EqGGjP
 4kXCLVfMS6o2PSWUFTxypqy/rA3fqq9seEHMgmSowjn1ohIUzj4hU8Tw0Do2Rgjq4Zne
 0554QzGgMppW0ToBJ4y6erKIBOy0F40O4T30StxNpxl3yax7rW7Gc2Uiwo/clgqORBGb
 tCYayZJSfbucdXNROe8bkqN5Ezp17bRMjV0tVLUH8InUa5Y3SzM4TW1/g8f51n5gZAqb
 mOpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qAsTOKHsKLPEujcZzUixcWC/rdfVFv5viGMk62arqbr2oVYvP6fEmHxepmnYl7pMAea+PtQ4=@lists.denx.de
X-Gm-Message-State: AOJu0YwfksosnumjEVRYsMcOh+Ik/16tXTdl8YaK2wngL6+nX2jp7nkC
 xJjd2ICxS6OcO86mXKukpldIjK/u705WAH1tysw1YnSgdjMVVBZf+txQ7djhHRV81AYgQfCu8XZ
 R7IVpCWc=
X-Gm-Gg: AfdE7ckD6ehR34INZPfm4WoN+rNbx200zdeNlxLWPackTwFWIM8ANIXa6KzA+GGTKfo
 l33KVEdLKLTWjmAsAcV1BPXHrqh7Y3fO+XO71cATvw5EXgXy+AvTzAUWrNipuGHufkqeosNNLW/
 vaiPj1O2jl/fSf3tYRLPlB4Rm5tb/IEhjzifTBdKgJaVaWWiAGZG4WdnMrM9ncb8xo9O/o+0GqX
 YS7/f5GxW+Z8mQygYo4Dy+FdnzGfKldfCbfpcXBU2GwZoXXYXz3eprV7amEfbPBD3Oc79oDP8yS
 bz2WoEFxCIGTtnk9sJs8lRTqnp+NIGdL/HvfFlz0QxowFZiH0yAByGk0yce4S2V9v2S6c1CbBug
 S/FHkXD/B/t3Dbe0WcxVEePfV/bA6PkSfZOX2qRYf64J5ghQNZjzv3YHax86+s9XtR+nndNdeI6
 5tSgqkuCR57IJ/gQkEWJRiPof8Prn/UlwXm6c8p02VyXTs2kx580LjB92c4pU+b5kUFwWQ6h/BS
 LNueVy6OXCDF6dp4j6OHcca51Yr/biGuGo7zQ==
X-Received: by 2002:a05:6820:f010:b0:6a3:5c28:101d with SMTP id
 006d021491bc7-6a39a8a3d0amr5465011eaf.70.1783979286606; 
 Mon, 13 Jul 2026 14:48:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451ff78897asm7985572fac.17.2026.07.13.14.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 14:48:05 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:48:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
Message-ID: <20260713214803.GV749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
 <20260709015247.GR749385@bill-the-cat>
 <f544cab6-1db6-481b-8f91-06cc2fb6829b@kwiboo.se>
 <20260710135030.GI749385@bill-the-cat>
 <ec6db006-bd05-4621-a9e6-cba6dd9690bd@kwiboo.se>
 <20260710155636.GL749385@bill-the-cat>
 <975a650f-88cf-4b2d-8f83-2df3f93ab25d@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r/OyXXi5ukhzdh8g"
Content-Disposition: inline
In-Reply-To: <975a650f-88cf-4b2d-8f83-2df3f93ab25d@kwiboo.se>
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


--r/OyXXi5ukhzdh8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 01:52:26AM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 7/10/2026 5:56 PM, Tom Rini wrote:
> > On Fri, Jul 10, 2026 at 05:39:08PM +0200, Jonas Karlman wrote:
> >> Hi Tom,
> >>
> >> On 7/10/2026 3:50 PM, Tom Rini wrote:
> >>> On Thu, Jul 09, 2026 at 09:12:24AM +0200, Jonas Karlman wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On 7/9/2026 3:52 AM, Tom Rini wrote:
> >>>>> On Wed, Jul 08, 2026 at 10:05:34PM +0000, Jonas Karlman wrote:
> >>>>>
> >>>>>> Change to depend on the xPL symbol instead of the SUPPORT_xPL symb=
ol to
> >>>>>> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is ena=
bled.
> >>>>>>
> >>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>>>> ---
> >>>>>>  drivers/i2c/Kconfig | 4 ++--
> >>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> >>>>>> index ab5af17858c8..125dc84819e6 100644
> >>>>>> --- a/drivers/i2c/Kconfig
> >>>>>> +++ b/drivers/i2c/Kconfig
> >>>>>> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
> >>>>>> =20
> >>>>>>  config SPL_SYS_I2C_LEGACY
> >>>>>>  	bool "Enable legacy I2C subsystem and drivers in SPL"
> >>>>>> -	depends on SUPPORT_SPL && !SPL_DM_I2C
> >>>>>> +	depends on SPL && !SPL_DM_I2C
> >>>>>>  	help
> >>>>>>  	  Enable the legacy I2C subsystem and drivers in SPL.  This is u=
seful
> >>>>>>  	  in some size constrained situations.
> >>>>>> =20
> >>>>>>  config TPL_SYS_I2C_LEGACY
> >>>>>>  	bool "Enable legacy I2C subsystem and drivers in TPL"
> >>>>>> -	depends on SUPPORT_TPL && !SPL_DM_I2C
> >>>>>> +	depends on TPL && !TPL_DM_I2C
> >>>>>>  	help
> >>>>>>  	  Enable the legacy I2C subsystem and drivers in TPL.  This is u=
seful
> >>>>>>  	  in some size constrained situations.
> >>>>>
> >>>>> Building on the last email, I think these might need to be
> >>>>> [ST]PL_FRAMEWORK not [ST]PL.
> >>>>>
> >>>>
> >>>> I have mostly tested this series with additional changes that alias
> >>>> putc()/puts() to printch()/printascii() in xPL builds when
> >>>> common/console.o is unavailable and DEBUG_UART=3Dy, patches that will
> >>>> be sent as a separate series.
> >>>>
> >>>> It is possible such change may have hidden some latent issues, now
> >>>> trying to push a branch that contains changes that ends at the patch=
es
> >>>> included in this series, but due to timeouts it was not possible pri=
or
> >>>> to sending this reply.
> >>>>
> >>>> This patch can also be dropped if it causes any issues, I only added=
 it
> >>>> after a search for SUPPORT_xPL and noticed that these depends seem t=
o be
> >>>> incorrect. SUPPORT_xPL is used to tell if xPL can be enabled or not,
> >>>> not if xPL is enabled/disabled.
> >>>
> >>> I don't want to drop this, but there are a handful of platforms that
> >>> change:
> >>> 10: Kconfig: i2c: Depend on correct xPL symbol
> >>>    aarch64: (for 1/1 boards) all -60.0 text -60.0
> >>>             ls1043aqds_tfa : all -60 text -60
> >>>                u-boot: add: 0/-1, grow: 0/-1 bytes: 0/-60 (-60)
> >>>                  function                                   old     n=
ew   delta
> >>>                  board_early_init_f                          68      =
64      -4
> >>>                  i2c_early_init_f                            56      =
 -     -56
> >>>
> >>> Can you please look in to it and see what needs to be changed? Thanks.
> >>
> >> From a quick look this size change may be caused due to use of an
> >> 'imply SPL_SYS_I2C_LEGACY' instead of using an 'imply SYS_I2C_LEGACY'
> >> in arch/arm/cpu/armv8/fsl-layerscape/Kconfig.
> >>
> >> 'config MACH_SUN8I_R40' is another platform that also possible miss
> >> an 'imply SYS_I2C_LEGACY' to match other similar sunxi platforms.
>=20
> I have now done some more digging and it looks like SYS_I2C_EARLY_INIT
> is the culprit.
>=20
>   config SYS_I2C_EARLY_INIT
> 	bool "Enable legacy I2C subsystem early in boot"
> 	depends on BOARD_EARLY_INIT_F && SPL_SYS_I2C_LEGACY && SYS_I2C_MXC
> 	help
> 	  Add the function prototype for i2c_early_init_f which is called in
> 	  board_early_init_f.
>=20
> Not sure what to do here, it is possible that just dropping
> SPL_SYS_I2C_LEGACY from depends would ensure the code is restored.

Ah, good work. Yes, this is tricky.

> However, that also feels strange as the intent of i2c_early_init_f() is
> to initialize I2C_LEGACY, and most of the affected boards use DM_I2C:
>=20
>   > tools/qconfig.py -f ~SPL SYS_I2C_EARLY_INIT
>   5 matches
>   ls1043aqds_tfa_SECURE_BOOT ls1043aqds_tfa ls1046aqds_tfa_SECURE_BOOT ls=
1046aqds_tfa ls2080aqds_qspi
>=20
>   > tools/qconfig.py -f ~SPL SYS_I2C_EARLY_INIT ~DM_I2C
>   1 matches
>   ls2080aqds_qspi
>=20
> (Please note that my qconfig.db does not cover 100% of all defconfigs.)
>=20
> All other code seem to be protected by CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
> so I am not expecting any other change for targets that use xPL=3Dn.

This is tricky, yes. Looking at all the boards which *have*
SYS_I2C_EARLY_INIT guards for calling i2c_early_init_f some presumably
used to, but do not now, set SPL_SYS_I2C_LEGACY. And going back to my
initial conversion of this symbol to Kconfig, I'm not sure it's 100%
right, now. I think we need to add SPL_SYS_I2C_EARLY_INIT and make both
of these symbols be "select ..." in the right board Kconfig, rather than
a prompted question. And with that, we should have:
ls1043aqds_tfa_SECURE_BOOT ls1043aqds_tfa ls1046aqds_tfa_SECURE_BOOT ls1046=
aqds_tfa
be "select SPL_SYS_I2C_EARLY_INIT" and then:
ls2080aqds_nand ls2080aqds_qspi
be doing both "select SPL_SYS_I2C_EARLY_INIT" and "select
SYS_I2C_EARLY_INIT".

There's also (and so I've cc'd Peng) some dead code to remove on other
layerscape platforms that don't call i2c_early_init_f (they're both
full and SPL DM i2c) and so have some dead code now.

--=20
Tom

--r/OyXXi5ukhzdh8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalVdDwAKCRAr4qD1Cr/k
CvLSAP9rlwpweajv/DO5UgBmFbcsl+V2EeUm4jcjvIlacYpnBQD/VS+cdtbNILi4
xsx3OuEH0skiNLx8DtX4DQ4PeMyNNgQ=
=kAgN
-----END PGP SIGNATURE-----

--r/OyXXi5ukhzdh8g--
