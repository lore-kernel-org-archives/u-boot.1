Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D53C7EE30
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 00:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A89FC82B34;
	Fri, 27 Jun 2025 02:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WlUsNaAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7F380C83; Fri, 27 Jun 2025 02:13:21 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595D382B34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 02:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-408fa4be483so1045290b6e.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 17:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750983191; x=1751587991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dqnMJuqFbFlPi6Ip7zzL5aMvNOKXivKapkQRTkQJ+xQ=;
 b=WlUsNaABEpmyTVxINj+PG72JReGrW2zUAyPbMYIW3b2G+7y2VZvQWk1lIOBDYd46uM
 uy+f5OHMO03uLVG2iRTQ1QvxI9Qh87VIKuvFMcJ4/MEbDSQv61+/a5dS1oHw298ZpVxb
 yfC41dlZiEyCndfJrd+r73NPWwNKCowYS1FNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750983191; x=1751587991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqnMJuqFbFlPi6Ip7zzL5aMvNOKXivKapkQRTkQJ+xQ=;
 b=XYbTZ6vet4tB8zLBeQoiuOnWUcgnv4U84I4ScnG5k1C1JZ4kbZnBc78z+xZ1G3EUXo
 2ZSpO1zYL9tIAHAFyKR+bMNHa8/lW00RbJ5zv0/89GSPMMBxnKEeLnZldznXzbrhVitM
 X1gOQdV5nA1GNbyRsZhAAa5KVt1JZmualJUuC73gdo6Oz4esd5SDwM4OPui5rXH4rEmP
 HtO5LH8tth/fUotuQMppkj/U+v7sZTCUj4jNOCqDreF+RbRrp1fy1NlCB8C7XcgqIpv5
 HPb0ZtD0obFQAAAucbtQpqCmp9g4ave43+U5aL7Qng/bsjdHQH04UZWVjG07Xki0BRDe
 hejA==
X-Gm-Message-State: AOJu0Yxdu4MvI4bvEx5uPpAwbgLgx260IhmRXx5YQDD58T/u7VTbcJCW
 7TtJetPtTPcKVkX/tTNTxujIjUkO+hUDDWjakA67byY9hJE7LZIkyMeI54KDa8VFUrM=
X-Gm-Gg: ASbGncuSw0IN/u1G0lebP20jRrw7GFvw394z5C5BHBQGdy+uJAS+sZdX7h3Go1fbwtr
 9hD4u8MPtwZdGWj4bA3GrmG+KW2XyYUYM7hrbn2NgsDq4rSSadplPy9VMlo3pBLg/Z8NEKcB1PS
 Aod11K/KQKOxDDxIMf1SLZzR6YFk3RqJ1q8kSd9Z+eOnRLfhuJzglR27+WKdPGMDEZ5F+KLm3cZ
 EXzqT3fh1G8pvh6HxFe3H9tyKC3q8dksj97OdDxTgSSzSrOlcGfw+jPHkJ2wv4ugLDuCfbNAB9J
 lC3AW0YkZielu+SxIdV9erjwRIPWEL5gOOuWwvTN0D3L5e9fdcnNFpolVNC48q7ZetvC894+enX
 RkX+9OpFHJbaJbehJnIUHD9s=
X-Google-Smtp-Source: AGHT+IFaf3yiuzIS2bK8PFJkX9gdAvttfW+eGFpPq5eH5wz54QG9VsdikT7YfhwnCWF5oZo7rRjVFw==
X-Received: by 2002:a05:6808:1688:b0:409:f8e:7296 with SMTP id
 5614622812f47-40b33acfe0cmr1057392b6e.0.1750983190987; 
 Thu, 26 Jun 2025 17:13:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32421052sm160179b6e.37.2025.06.26.17.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 17:13:09 -0700 (PDT)
Date: Thu, 26 Jun 2025 18:13:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [RFC PATCH v1 2/4] spl: Kconfig: allow disabling fallback during
 os boot
Message-ID: <20250627001307.GD4003484@bill-the-cat>
References: <20250626120443.1405409-1-anshuld@ti.com>
 <20250626120443.1405409-3-anshuld@ti.com>
 <20250626234723.GZ4003484@bill-the-cat>
 <DAWVHAV5O7DD.319BE0HLA4EF4@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XSfqr+dI+COyzmn9"
Content-Disposition: inline
In-Reply-To: <DAWVHAV5O7DD.319BE0HLA4EF4@ti.com>
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


--XSfqr+dI+COyzmn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 05:31:03AM +0530, Anshul Dalal wrote:
> On Fri Jun 27, 2025 at 5:17 AM IST, Tom Rini wrote:
> > On Thu, Jun 26, 2025 at 05:34:40PM +0530, Anshul Dalal wrote:
> >
> >> During falcon boot in FS mode, if the SPL fails to load the payload
> >> (kernel image and args), the execution fallbacks to standard u-boot bo=
ot
> >> mode.
> >>=20
> >> This might not be desired in cases when u-boot payload (tifalcon.bin in
> >> our case) is dysfuncitonal by itself or user's access to standard u-bo=
ot
> >> should be restricted (for security reasons for example).
> >>=20
> >> In our falcon use case, this fallback allows the user to bypass
> >> authenticated boot by just deleting the fitImage which causes SPL to
> >> reload tifalcon.bin. The boot proceeds as usual until ATF jumps to
> >> PRELOADED_BL33_BASE where the kernel has not been loaded causing the
> >> core to execute whatever else was written at that address.
> >>=20
> >> Therefore this patch adds a new config symbol SPL_FALCON_ALLOW_FALLBACK
> >> that explicitly toggles the fallback for MMC FS boot. It is set to 'y'
> >> by default so as to not break any existing falcon mode systems.
> >>=20
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >>  common/spl/Kconfig   | 10 +++++
> >>  common/spl/spl_mmc.c | 87 ++++++++++++++++++++++++++++----------------
> >>  2 files changed, 65 insertions(+), 32 deletions(-)
> >>=20
> >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> >> index 8d153c2e9c9..d5d3a41ce61 100644
> >> --- a/common/spl/Kconfig
> >> +++ b/common/spl/Kconfig
> >> @@ -1203,6 +1203,16 @@ config SPL_SECURE_OS_BOOT
> >>  	  Enables support for secure boot in falcon mode by restricting the =
SPL to
> >>  	  only loading a fitImage instead of raw kernel images or DTBs.
> >> =20
> >> +config SPL_FALCON_ALLOW_FALLBACK
> >
> > SPL_OS_BOOT_ALLOW_FALLBACK please.
> >
> >> +	bool "Allow fallback to regular boot if falcon mode fails"
> >> +	depends on SPL_OS_BOOT && SYS_MMCSD_FS_BOOT && !SPL_SECURE_OS_BOOT
> >
> > This should just be SPL_OS_BOOT && !SPL_OS_BOOT_SECURE.
> >
> > Then in a follow-up patch we need to go and modify spl_*_load_os to make
> > use of the new flag and if fail to load the OS image we panic() if we
> > can't fall back.
>=20
> A quick general question here, in cases where we want a function to lead
> to a boot failure. Is it better to return an error, hoping the caller to
> handle it and stop the boot process or panic within the function body to
> begin with?
>=20
> int spl_do_*_os_boot() {
> 	int ret =3D spl_load_kernel_image(...);
>=20
> 	if (ret && !CONFIG_IS_ENABLED(OS_BOOT_ALLOW_FALLBACK))
> 		return ret; OR panic("Failed to os boot");
>=20
> 	/* fallback */
> }
>=20
> From a security PoV, I see the point in explicitly halting the boot
> right within the function body but returning the error conforms to
> standard error handling practices.

As part of implementing this, it's a little bit up to you here. I didn't
immediately see a good fall back path to panic at the higher level but
I could have just missed it. But the important thing is that if we're
secure and we fail to load and fallback is disabled, we need to panic
somewhere.

--=20
Tom

--XSfqr+dI+COyzmn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhd4hAACgkQFHw5/5Y0
tyxEoAwAlqQUgo41pWisH3q6WdL36B09qqYedR8+bmKAFBCQlOdX8HQiuFys0UD1
TbQiLYzOfjHpsDeVyCYymATvj6nCoK5yVX56wdc7aEItFtq05qA2rejq6/KsJSrL
mkh1LfKZTBa8ALy346uZbgmR3Wg6oFJHVOzneiOatz5v9nefCzeVb5sLzrkZAx33
f6R6VO6SwckbmKnukO9CFmlULcOb7sjrM0d28EdBOqwY8gSIIYL7R5WIbdnC6q+b
8OtMIkGRFqRUIRLeAOhN699X0YANn5sMW+QTnAmUcnSq8GCHyU/xA+XuHt2TqfMG
IOOHDuzndaPCWZEKSby0hsJ0IUlcIDFpllTVCh30ZcHLhXlJlPPoTl01tsUUPKQJ
hKYQAxviL+7oemMAo6041sirAACJB8vsVcAAPZ8+sRR5GkyKQPO5GczIHDJ/Z158
8PBmBagi5x+XLxQ6Dbfv2MIuzxZ+PDiEOoXQdC/tv+1tvu2G9URERZCRz83viVHu
SSgjt5rN
=KVLv
-----END PGP SIGNATURE-----

--XSfqr+dI+COyzmn9--
