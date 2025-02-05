Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DA4C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A224480711;
	Wed,  5 Feb 2025 14:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FRMWD6rs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCF3807A8; Wed,  5 Feb 2025 14:49:37 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AA08070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso5863105ad.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738763374; x=1739368174; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=20rGjhUKKR5FG3gxLBXwTwNXexU3L+mzoHQ3YZaDSEM=;
 b=FRMWD6rs83mM5u7zkt2FdNpeXDjj8MBTeJMXiVP6UiTdIHHQyTMe3/nrk+t6cA47Hk
 kBSSPYncR2fWX0JjXDgJctMX3Z9iQPeq8MdjJ47AWtk1fW5y2D3IQnZT1AA03U2Pm4S3
 Sy/yaix2eMWLSwvTxRbfA0gIMbLUkALea28YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738763374; x=1739368174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20rGjhUKKR5FG3gxLBXwTwNXexU3L+mzoHQ3YZaDSEM=;
 b=Es2Wiy8UP1m/6jOX55v9ZuZr4VeFb27HbqrXYuFasoeSo1vaRryEaItjtI3kmDT0Rb
 gpvFotn1kxj7RHkCDSDb5LxJAyOecjyClwdgBPypc7Z4+Tp/bznmDZll3Ba7h/by/VMC
 ZPbwyz/H+9fvUfFLAI0vS/DCjaG6Pf29AJXA0N4cMr5QGYhtWnnKKdSFy7LyqAI3c9tp
 6BQfUj1CrtYQWWPZa0fZm+SqHyhaLrnL52tLkX5A+yLb1OhYhoa80sHxX6m6ehU2z5gw
 Is9uLbaotfXf6WwpcVjGIOn+zb2dzoEvcfWYvjwKFhA5bQNCGKx1fli+ExTSIKYcr9MF
 HUuA==
X-Gm-Message-State: AOJu0YxCGpF1GyVNB7Eg3aiKZNl3lFhx2jzUhJIrxVCZClbSbN8s2pKc
 0p8WU5TuEc6jp7tXG6MQuSknhyLccbgZY2MzQY0MYwCpTrErmgUHCHQ9qeCNB4g=
X-Gm-Gg: ASbGncs6XG17nGyMyQXZAu5TPEnaYny34EWzO085oqd8LiaI3XROyc262uwpFGiOKg9
 tcr6AQMxMbHahrQVSODMCMTogtE52HveAbtcZQMm6rduMUQ6d2D6YRaxlOnNoMVxEZu7UvcCtaZ
 zNDVmUijm993mENYBD9dS/UL4HK6SxhINv/LVJ6sLcT51UNydpiV7n/ITr0j5PCmmupZZcqgn9z
 ceyCRkTFmheaedI3SRyS78wZ+jMJh1a7dyeadu+lldLdIA8Rss7fyOaQtGFFQUCVZpfdnykm64+
 Ax9S4il3yYOGC5g=
X-Google-Smtp-Source: AGHT+IFWdbhVdt9Lfk+GQN5MBriOQBK1+W/4NAuN0AgrAD2ukjvJzxuuCab/FWzSM0jtbAmHRwCF9w==
X-Received: by 2002:a17:902:ce86:b0:216:5db1:5dc1 with SMTP id
 d9443c01a7336-21f1795cb84mr51137905ad.1.1738763373832; 
 Wed, 05 Feb 2025 05:49:33 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de311917bsm114108035ad.0.2025.02.05.05.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 05:49:32 -0800 (PST)
Date: Wed, 5 Feb 2025 07:49:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 01/29] arm: Support a separate stack for VPL
Message-ID: <20250205134930.GM1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vaHv7kRFMlPty8Jn"
Content-Disposition: inline
In-Reply-To: <20250205015606.2686149-2-sjg@chromium.org>
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


--vaHv7kRFMlPty8Jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 06:54:51PM -0700, Simon Glass wrote:
> VPL has the same needs as TPL in situations where the stack is at the
> top of SRAM. Add an option for this and implement it for arm
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  arch/arm/lib/crt0_64.S |  4 +++-
>  common/spl/Kconfig.vpl | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index 32401f544a7..122e0217470 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -71,7 +71,9 @@ ENTRY(_main)
>   */
>  #if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
>  	ldr	x0, =3D(CONFIG_TPL_STACK)
> -#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
> +#elif defined(CONFIG_VPL_BUILD) && defined(CONFIG_VPL_NEEDS_SEPARATE_STA=
CK)
> +	ldr	x0, =3D(CONFIG_VPL_STACK)
> +#elif defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_STACK)
>  	ldr	x0, =3D(CONFIG_SPL_STACK)
>  #elif defined(CONFIG_INIT_SP_RELATIVE)
>  #if CONFIG_POSITION_INDEPENDENT

We should rename CONFIG_SPL_STACK to CONFIG_SPL_NEEDS_SEPARATE_STACK so
that this can be tidied up to something like:
#if defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(NEEDS_SEPARATE_STACK)
	ldr	x0, =3DCONFIG_VAL(STACK)
#endif

--=20
Tom

--vaHv7kRFMlPty8Jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejbGoACgkQFHw5/5Y0
tyy/UAv/a7P4JW37eBhoRUHxp5ntKBbGQID17yEkyhQFavy2RTQ5JTwc3rZuMrq4
zfIM68JWJrF0mpATkhkKweFvJuVSfgVWu5sWWp2poBiqJMsVGpySKQdRRO0qXrc8
XIq4NrHfcEKCyy3+06biWF0wAeZ6EPHVcHzRcvK6XiinOzaGGciB7HXvVqpyZBJi
nriAjyOXtw3agE8b0AQ+JawgnASLEQPoDCg7U44aVMWVOaUWWxP6FsvHsW16gaqC
xk4pvz5vvllawpYv8hYVEUcloytGuPI6gVSa5K9/ptZkVID9qFrsKhQ6Nb/VG5nT
wT5+TbYy8cvG8xrHA30tGSKVYvg/JcgYaqu9PGiyD6n2F9X8TMhJvMniMspgiGGC
0ZQYHdVfXwiDXOdAWpZ6RD6cY5/YLhzwBL3IPSKer2u4+rwNsct54RlJB2PTkfQw
vj2NVQ5eWVYTCHOtQKpXN2xhxlSv52XHhJ1U/AUzdoXafYJm09dMXLjqzD9558An
04H/1Grb
=yEB1
-----END PGP SIGNATURE-----

--vaHv7kRFMlPty8Jn--
