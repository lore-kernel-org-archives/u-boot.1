Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC27BC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AA184B57;
	Thu,  9 Jul 2026 15:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BIIn5Y0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210CE84BD5; Thu,  9 Jul 2026 15:44:01 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AF184AFF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 15:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-495c49f8eccso1300359b6e.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783604637; x=1784209437; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+YXrKATw0ZEI1xbIOVuig3WyqiSfx0xLFRW7c29UpJU=;
 b=BIIn5Y0+tlZVyxY+wdMin+F/YvvG20TZxtjaK7Mk7JBVnNvGMbAPDd5x0HvcIUbOSR
 SFVr7+h801k3NI0xNO/Kj/X1DnAkSlnbs+vVO9TCGxycJmkjk1QgnqEPsomP8MSfpjHz
 Do/AQEgwUVkjPymEUhZccb7iOL0GU4EVM67i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783604637; x=1784209437;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+YXrKATw0ZEI1xbIOVuig3WyqiSfx0xLFRW7c29UpJU=;
 b=NO+50d+m6vRwdUU/pxlK919w/6U3fAi/u4OSNLXmI3SYCb6ibujJRFYlWa9nlWtorj
 w0ejVHVthsaywgRJv3cOCASb7LCxYE57wCIwX/keinEPk9VSLZj9wyblx4lW6HcFcVmY
 GLaFhghkQYdF8QP3aE3mkSB9B9vB1TmBpFd3tPZcH1VmYCq+dMAu9Wrm/wmGa11RREUf
 mawJzBX/4tZ8bdTuaFwzlUMCtmRkFciS1h4PL/DZL1I8SPt5Kg+PjCHrrci9QakILjeh
 eQuQ+YmdHotmg1IZGzlTpzrmlbNGwvCOb11PPeVeOhGKJwdoUFmqE0/QLfjOhw6mv2mE
 0+Jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CDjzFhbZPmlS6J6Mty/4pdvcdLmdXF8QIjxzvaLQ+uhneYtK1goVRFxQqUYrevwd6B3oYJGE=@lists.denx.de
X-Gm-Message-State: AOJu0YyTAh62VsTPc9fb6wy93d2lUdfVS3HmSBA/WsN0ZblL9wsWN0e7
 GkMKQCmUMXL27Xs+O2XvLoF0p7/j8IsuOA1nnHHIaXF4caTBzppoiMvgo+A/JOc8X24=
X-Gm-Gg: AfdE7cm6ilDYd/Qr3cB1EHAjCPUhGytvXDTm6cleGWUTgRYDwMiFnHrXPSJHcjsQ427
 jGOPDtbfxq1FY2xtitqRtWm8sfL1uc8qXvjTNK3lyl6yhj7r2iuDTs1h2a99AsAl6rs9SyYOpsD
 SXNxhgtTxIfOq2Z3Dhwlrdw0XqeDfMsIKRaO3ZfyPjeGtHiZqiisH6KhAuT6MLU40InqY6A87et
 hUcBEzW9+u2/2NDoz4RsO0Yb+X+H6JiQlUII0au/5W6i7fJSBTFuvFI9SV60DEo3mHfSxM7pO7a
 rCeYr4cxYcMtKrNlzezE96qUjwE5i0A7Z//ATomCP7pi2NqdG77M/eRTkG/cDl/qkD1AELw+Wrk
 /2O/xGZ8JmjiVhT6fzyGgxiUTEEQ9bd2BvRlRgk0L731PNdqUwTd9IB7ph+Ca6heO9CVdkgImzx
 ZSzZ7DvVFMevjr/OfzzjmkyK1qCluRrsjg6wC/cs0d7h+rrJHSVlNUivwVNrt0TKgBqVgVy50a9
 Cm9QgIBeeOCjiuSqnNP5/WH95m1NXkcfpS/C20yPGZ0h7LA
X-Received: by 2002:a05:6808:1594:b0:4a3:eece:cbb with SMTP id
 5614622812f47-4a3eece5aa0mr982577b6e.21.1783604637083; 
 Thu, 09 Jul 2026 06:43:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1ad4ac92csm3858401b6e.5.2026.07.09.06.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:43:56 -0700 (PDT)
Date: Thu, 9 Jul 2026 07:43:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
Message-ID: <20260709134354.GX749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
 <20260709015247.GR749385@bill-the-cat>
 <f544cab6-1db6-481b-8f91-06cc2fb6829b@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oUu/hLIZYGCFcaJ/"
Content-Disposition: inline
In-Reply-To: <f544cab6-1db6-481b-8f91-06cc2fb6829b@kwiboo.se>
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


--oUu/hLIZYGCFcaJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 09:12:24AM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 7/9/2026 3:52 AM, Tom Rini wrote:
> > On Wed, Jul 08, 2026 at 10:05:34PM +0000, Jonas Karlman wrote:
> >=20
> >> Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol to
> >> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabled.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >>  drivers/i2c/Kconfig | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> >> index ab5af17858c8..125dc84819e6 100644
> >> --- a/drivers/i2c/Kconfig
> >> +++ b/drivers/i2c/Kconfig
> >> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
> >> =20
> >>  config SPL_SYS_I2C_LEGACY
> >>  	bool "Enable legacy I2C subsystem and drivers in SPL"
> >> -	depends on SUPPORT_SPL && !SPL_DM_I2C
> >> +	depends on SPL && !SPL_DM_I2C
> >>  	help
> >>  	  Enable the legacy I2C subsystem and drivers in SPL.  This is useful
> >>  	  in some size constrained situations.
> >> =20
> >>  config TPL_SYS_I2C_LEGACY
> >>  	bool "Enable legacy I2C subsystem and drivers in TPL"
> >> -	depends on SUPPORT_TPL && !SPL_DM_I2C
> >> +	depends on TPL && !TPL_DM_I2C
> >>  	help
> >>  	  Enable the legacy I2C subsystem and drivers in TPL.  This is useful
> >>  	  in some size constrained situations.
> >=20
> > Building on the last email, I think these might need to be
> > [ST]PL_FRAMEWORK not [ST]PL.
> >=20
>=20
> I have mostly tested this series with additional changes that alias
> putc()/puts() to printch()/printascii() in xPL builds when
> common/console.o is unavailable and DEBUG_UART=3Dy, patches that will
> be sent as a separate series.
>=20
> It is possible such change may have hidden some latent issues, now
> trying to push a branch that contains changes that ends at the patches
> included in this series, but due to timeouts it was not possible prior
> to sending this reply.

OK. You should have access to git.u-boot-project.org now, to run CI
there. To ensure there's no timeout problems you might need to do a
local patch to switch the yaml to use git.u-boot-project.org too when
cloning test hooks.

--=20
Tom

--oUu/hLIZYGCFcaJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak+lmQAKCRAr4qD1Cr/k
Ct5uAP4nQmKXq1wBszCK63wJ8genVS/nD0LMfGsSiRYJCShy+wD/XKNPDuArf7DU
/RWwLX+ww5dm43Mbfvdn+2AGRz3L2ws=
=hoHm
-----END PGP SIGNATURE-----

--oUu/hLIZYGCFcaJ/--
