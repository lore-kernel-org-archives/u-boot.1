Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5BBC7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 23:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C7C82E08;
	Fri, 27 Jun 2025 01:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s/lLPlHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB4D80E9A; Fri, 27 Jun 2025 01:47:37 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA0AA82CEB
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 01:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-610cbca60cdso945880eaf.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750981646; x=1751586446; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zkMP5E7g4TuAGddlYi86pe8Uo32XnD6OpKOPggpAg6w=;
 b=s/lLPlHAhtYO7RQ9WpWJmrGvCYluyddaCTCElaOM885Nlt2zBLZMe2x/COfnIr7FxF
 SIz868ue94HNIP7oHHKOZHEgjI7eiUfpvnNfOSI2tVGZDf7h4BixziDZ+9djrGjbA0nI
 YyTQKYDrtf6fN1etvr9Ojhy5XqyF1uGN9SHwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750981646; x=1751586446;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkMP5E7g4TuAGddlYi86pe8Uo32XnD6OpKOPggpAg6w=;
 b=HjySqOE9cjPEgtCXzrrmNgRjGcj4qcqd8imtWqWaXIXEqWlYriTC9Kvzt/aZERuWWT
 qXPBkYF7oxrPm/zeQNne8INdTSdIvN9ghbdIWdUmWtd9pJOwG1LA+1NyR2S+4H7UrMWE
 e1H3QgYFK1Y92pU91DqJuvUIDATR05t6eGN3APXjZ4zGeeY7wVBoYxi01jzCbbyZq0jo
 g4/Ve41XmFaGz4jhCKO8Wz5ZcscNbEmLqW7o2v1LPf2VOyxx1f/LGb9cVleSgltd4TER
 aM3El1jINiFCgTITse7GdFjGnqmiifhlZKYbUgu9JmGv5m9gQyk1b/Cz8zgrd0hCi1Wp
 YyZg==
X-Gm-Message-State: AOJu0YxWraMPQ61QKLNjNS2EYisz88MGX/+E7AHvYdzsrKDqFI1URo7z
 8+2Tq8sKx8Yhy5jqAdUUI5wx0G3cbHTHblJF9FlxsJutuRCco7gQ25uw+j4LbtC+O2Q=
X-Gm-Gg: ASbGnctJZr7bB/NpZNpzVFGz4BQ43hQYym3cd9TdPqS5KyPt0EAHgVvOav3Z7HFhrQZ
 N2SJo8B+7CdTaAbxZGaojkX+tk9Fzf9wOMO69HtsNujy0zmfCpAv4SjWA5seqxkGSPaWiZc2Uv5
 v0IFjQLm2DCpbLBkFKuOKKbeUM6QUkBqyngKybepLBc81oGASS8Z/ObWjrYSshNmZz60VuMrcUn
 eCNBNI5DKtFmrWG+7uMd5Kh7FAvqorVC0qdyx8v6K0EKMYgvYyAIx0ph3D80u0nvkMQEUi8dU9f
 RkC9PoMNPweP8WN+XTZMZYx2Yb9IUlGQUbKRRMUUGiuw0/nUWIRWtTx7HqgcF/8ZrFWtTwdHbb1
 ROdsp/lYC69Xh9A1rVJNVK9mNbTxsI8S/pg==
X-Google-Smtp-Source: AGHT+IELZW2u1lnTexT/G/6rQyvzhfQU3jOO1GqR+Xsoz8DCiXtQl35ilWcocIxQw3JfVuv22NZmvg==
X-Received: by 2002:a05:6870:f61c:b0:2d5:4d2d:9525 with SMTP id
 586e51a60fabf-2efed444350mr728573fac.8.1750981646567; 
 Thu, 26 Jun 2025 16:47:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b20dfsm600950fac.25.2025.06.26.16.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 16:47:25 -0700 (PDT)
Date: Thu, 26 Jun 2025 17:47:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [RFC PATCH v1 2/4] spl: Kconfig: allow disabling fallback during
 os boot
Message-ID: <20250626234723.GZ4003484@bill-the-cat>
References: <20250626120443.1405409-1-anshuld@ti.com>
 <20250626120443.1405409-3-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WygcBsnA0gI7uv+u"
Content-Disposition: inline
In-Reply-To: <20250626120443.1405409-3-anshuld@ti.com>
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


--WygcBsnA0gI7uv+u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 05:34:40PM +0530, Anshul Dalal wrote:

> During falcon boot in FS mode, if the SPL fails to load the payload
> (kernel image and args), the execution fallbacks to standard u-boot boot
> mode.
>=20
> This might not be desired in cases when u-boot payload (tifalcon.bin in
> our case) is dysfuncitonal by itself or user's access to standard u-boot
> should be restricted (for security reasons for example).
>=20
> In our falcon use case, this fallback allows the user to bypass
> authenticated boot by just deleting the fitImage which causes SPL to
> reload tifalcon.bin. The boot proceeds as usual until ATF jumps to
> PRELOADED_BL33_BASE where the kernel has not been loaded causing the
> core to execute whatever else was written at that address.
>=20
> Therefore this patch adds a new config symbol SPL_FALCON_ALLOW_FALLBACK
> that explicitly toggles the fallback for MMC FS boot. It is set to 'y'
> by default so as to not break any existing falcon mode systems.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  common/spl/Kconfig   | 10 +++++
>  common/spl/spl_mmc.c | 87 ++++++++++++++++++++++++++++----------------
>  2 files changed, 65 insertions(+), 32 deletions(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 8d153c2e9c9..d5d3a41ce61 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1203,6 +1203,16 @@ config SPL_SECURE_OS_BOOT
>  	  Enables support for secure boot in falcon mode by restricting the SPL=
 to
>  	  only loading a fitImage instead of raw kernel images or DTBs.
> =20
> +config SPL_FALCON_ALLOW_FALLBACK

SPL_OS_BOOT_ALLOW_FALLBACK please.

> +	bool "Allow fallback to regular boot if falcon mode fails"
> +	depends on SPL_OS_BOOT && SYS_MMCSD_FS_BOOT && !SPL_SECURE_OS_BOOT

This should just be SPL_OS_BOOT && !SPL_OS_BOOT_SECURE.

Then in a follow-up patch we need to go and modify spl_*_load_os to make
use of the new flag and if fail to load the OS image we panic() if we
can't fall back.

--=20
Tom

--WygcBsnA0gI7uv+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhd3AsACgkQFHw5/5Y0
tywV+wv+MXKRXdDKXK80hDzel4ML3Q0vhSB/6kDm3jTTlV9X5GvaOAJN421JgKT9
cWbxPdO+lxVpHFybpFlFKsoo8rLL5wLNFKUtg2GqdHV3Z7HqWyMLTkQCzHH4Ghcw
nbw4YBpiaMS47bMH4gq+yE1M/DooDIjc9a9nDDmIPBBLgqIHwqGFULpLWLGOazPj
b81NgMPEcSKqEIEF/LDQdE7rggdr2bEH/MT77NmTMyI4n3bjCpaxZgIEVUyEoZuQ
hzCKTQQYPlQuqvDs0LHcrABrjRtoeEHljKaTY/s+X1kl5Qy/fyMBWGyA7eArQegr
X8FP8jSoTfLlan3bnPQiR4vW29FsAzIcCdotLrVXJvn7qctDRM6+BxyRxFP1ims9
fU2PriE9yhLSJxfTFwOKyFCVPexfZODEWbtqlDKI60o1JG0Pk5uvfuXuF90kwafg
jHxW4SPXEttfVQ+2NnfjHAvD9/JvY1XYROr7RzxhsQz8Iok2DgkuLAK6fX0TRnKi
JDdKCDZ4
=HQ2B
-----END PGP SIGNATURE-----

--WygcBsnA0gI7uv+u--
