Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63776C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A963884ADB;
	Fri, 10 Jul 2026 15:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qWtuMmmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30EF784AA1; Fri, 10 Jul 2026 15:50:37 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C8484AA1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb64371a2aso665248a34.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783691433; x=1784296233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b64morTZ5YBcJ4Gh7YAIoLxKa2y9gneN8wBIzfH5Iqg=;
 b=qWtuMmmgOZI36QXSR7mhlUNmZwCJNNzHHxa4qZ9gfPEP0EUZp9dy6+N6A9YFzeCph7
 mpDlMV512YSwDWp5J+aZXxjFKZ1Kl2r+P9pJtBZbyW797euPOeWRuea6a7ztdJsXVX+W
 cFumLzsargB4uHipBqZt4HxlbaJVxXuMxpzHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691433; x=1784296233;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b64morTZ5YBcJ4Gh7YAIoLxKa2y9gneN8wBIzfH5Iqg=;
 b=mPJhVMPiEMEWUoKwqu4hewbm1sJJF5etIGxfq3hfn3wsimkALgjhxrybAMZr4J4UbC
 LwllKi4tF52/zXp0Bwdlb9sr553g5zL4Fqy4HQ4If8uZudbXsnHIEPsfKwb7P54ZlC9b
 S3yjUTB+U4MyfJkQo1TfFATScVE/Q07vQ9+MhMSmcGiJ+WC8ZWTw+70NTWRC91QdV8UR
 p7FJqvIqWcvZcHSzyCEUCBbfwwsFSVkX4s1aDqewtbN/mUusInrQPV4d0UfDzkatH63j
 KwcAfvnKameS5fzBiGkmMQF3UjxYYAsEVqibs6oDThp4Ma5ilP0DkN26y17avryUM/e3
 vf/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Kt6LFUkRzEPBS2DOQfH6OHTDDWc/ujMxb7kSBAL2PReD+8yzSRlRlzpRcqdkJ3WJuNsa3CQQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzJgv+5pWVktHTwjzFKkhXnvD9iE7ZY0zxALhEA2gUz1hVw5EXP
 /GQ64zQDbylhEMtUldwuFMACdeY1FS4M9sYDnYtmp/ZWkWV2vNfP8OSXH8Qa9egkCnM=
X-Gm-Gg: AfdE7clwuHjwdHDQzmfYmHho/asmNe92GVyiK9kR5McmAiIMdtOUGyix1hQQH3Nf5oV
 6FHGqr59jURiRSI9ZxI6/enkRfBFk5IwNjjJKxt7HFP/rgC0F/Owgznhl9JgqLqDCNqVkz+I6u/
 lWDyLJlk6V1gtQww4DIzVUGrIBEI9righ5a0kl9ORsHvlTrw5B6WX2LmIlJ5KP9RXijyU0Q96rB
 /oawNtuyG85soyFglIX5Ku2J1b/PxEUBJyrZ7NLOLs56HElBZ8hn1V6RQe4CEnwD+LgyhXi8sO6
 3IYr4zgv1BommkAsT01ILdvd6LVEQt8ZWWqimwzi4PrISwLYlXnjFnhsVNyocNagUm/CdqrOAHz
 magCys+6NeQFNrMcdwm0f5H5SC+ytjLGkUwsN8Jrr3aFjXnvWUx7QKt11Pb/Pa1FwFu7oPMdDv6
 mquKNZ7YUJkx4iWPgECnkxTVmYHeb3GHalfuSjlA1So310GKjIhHq+WAMwWTnJ+BlcZytkBSIi4
 +vIK4JwuYJUlWISlfNj1OuB1xUcxEJZVP+EYA==
X-Received: by 2002:a05:6830:650c:b0:7e9:f8e8:d905 with SMTP id
 46e09a7af769-7ebcff78647mr8776348a34.16.1783691433557; 
 Fri, 10 Jul 2026 06:50:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2630casm6823907a34.18.2026.07.10.06.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:50:32 -0700 (PDT)
Date: Fri, 10 Jul 2026 07:50:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
Message-ID: <20260710135030.GI749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
 <20260709015247.GR749385@bill-the-cat>
 <f544cab6-1db6-481b-8f91-06cc2fb6829b@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V0Pe0U+GwfEc8azy"
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


--V0Pe0U+GwfEc8azy
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
>=20
> This patch can also be dropped if it causes any issues, I only added it
> after a search for SUPPORT_xPL and noticed that these depends seem to be
> incorrect. SUPPORT_xPL is used to tell if xPL can be enabled or not,
> not if xPL is enabled/disabled.

I don't want to drop this, but there are a handful of platforms that
change:
10: Kconfig: i2c: Depend on correct xPL symbol
   aarch64: (for 1/1 boards) all -60.0 text -60.0
            ls1043aqds_tfa : all -60 text -60
               u-boot: add: 0/-1, grow: 0/-1 bytes: 0/-60 (-60)
                 function                                   old     new   d=
elta
                 board_early_init_f                          68      64    =
  -4
                 i2c_early_init_f                            56       -    =
 -56

Can you please look in to it and see what needs to be changed? Thanks.

--=20
Tom

--V0Pe0U+GwfEc8azy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalD4ogAKCRAr4qD1Cr/k
Cu3KAQDiyG2x2gX4wJNKjTWXdIDOZW9je1aqJjY33LmIJHV58gEAwsviKPWlRXPr
XlusVWmbQZQzhxpQJ+6GTCNvyBRg2wY=
=v4M8
-----END PGP SIGNATURE-----

--V0Pe0U+GwfEc8azy--
