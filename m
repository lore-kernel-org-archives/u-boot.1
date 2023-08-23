Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6113EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286218650C;
	Wed, 23 Aug 2023 16:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oH2EB7yj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A4186504; Wed, 23 Aug 2023 16:42:59 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21429864FA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d7485d37283so3889765276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801776; x=1693406576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CdlRF/mJoSd4lgTSgbKuXIR4/WbyRIRkLfDlo1M2v3w=;
 b=oH2EB7yjJ+c6I3s3ji4IZaAd8rvxGvs2sLEFwbyYSfLWWEzcKw8SlUejFZAUxO/4K2
 +fT7sWrTC5B6HEs30t7r6O2Gfv/mmat3fn1Kb4T3YHh9v8I/axYLcQdnRMBKBOdGOXUj
 nHqTKZkEXiGLasJKz34hGxmPcRUvCvXdlAVF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801776; x=1693406576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdlRF/mJoSd4lgTSgbKuXIR4/WbyRIRkLfDlo1M2v3w=;
 b=iTak+0V7+NVKD+6NGwcCqH5dqqTQjRdIA63yOl+LUu/VorfgweBnIIRkK8gxviCybs
 YZIm1QaKMXajUgBNyAxTT0SXx+lZ0d4ZkAETYXTejYG4t/tr/n/+3elqSmuTsawLifVH
 W/e+b/lanXxvIuO8dKp/82ewuRsivZ+chs5cwdMXAnrDg7Bgv+lFZVNr4uQ57lB4FHIR
 sSNYcKu66tFFQgLSaFjzwnDPEf6Lmwdv4QQytjpuQBcQEYZgphi1EDUwLsFbeX2C8boF
 VfT3/62NIz66CWjCuK3uYjswvQfmbzLMg15lhSTSiV8378LSESLP89CJxkgNYnDM8qE2
 kXYw==
X-Gm-Message-State: AOJu0Yy15W1REt34cx9foqmGAJUMZhr/2ociFI+Nxz2milBrweYrIN/n
 F3BFo9balEb8HzrJzFsP3iA2Ew==
X-Google-Smtp-Source: AGHT+IGHZzrPOahhkyVjZxstlTxTfwnImL2+8M4AsqQEtzyicTdRCAwTgzvK5AX2aGCuhszmtNpHcw==
X-Received: by 2002:a25:9243:0:b0:d1c:2b66:30a with SMTP id
 e3-20020a259243000000b00d1c2b66030amr12355175ybo.8.1692801775731; 
 Wed, 23 Aug 2023 07:42:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a056902038900b00d071631665fsm2738006ybs.59.2023.08.23.07.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:55 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH V4 1/8] env_default: Allow CONFIG_EXTRA_ENV_TEXT to
 override CFG_EXTRA_ENV_SETTINGS
Message-ID: <20230823144253.GF3953269@bill-the-cat>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RPgU1yc4cgpcoAAm"
Content-Disposition: inline
In-Reply-To: <20230822184135.2328409-2-nm@ti.com>
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


--RPgU1yc4cgpcoAAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 01:41:28PM -0500, Nishanth Menon wrote:

> CFG_EXTRA_ENV_SETTINGS is set in common board config files, This allows
> for majority of the settings to be set in a common manner. However, the
> minor variations between various board can be addressed by the board.env
> files. The board.env files are converted into CONFIG_EXTRA_ENV_TEXT.
>=20
> However, this creates a minor problem. For example:
> distro_bootcmd.h and used by ti_armv7_common.h uses it as:
>  #define BOOT_TARGET_DEVICES(func) \
> 	func(MMC, mmc, 0) \
> 	func(MMC, mmc, 1)
>=20
> Which in turn generates:
> boot_targets=3Dmmc0 mmc1
>=20
> And this probably works fine for most boards, However when the
> boot_targets need to be reversed, the preferred behavior would have been
> to define it in board.env file as:
> boot_targets=3Dmmc1 mmc0
>=20
> By changing the order of the inclusion, we allow for the
> CONFIG_EXTRA_ENV_TEXT to have a higher priority in the definition.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>=20
> New patch
>=20
>  include/env_default.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/env_default.h b/include/env_default.h
> index b16c22d5a28c..714dfa9e845e 100644
> --- a/include/env_default.h
> +++ b/include/env_default.h
> @@ -112,12 +112,12 @@ const char default_environment[] =3D {
>  #ifdef CONFIG_MTDPARTS_DEFAULT
>  	"mtdparts=3D"	CONFIG_MTDPARTS_DEFAULT		"\0"
>  #endif
> +#ifdef	CFG_EXTRA_ENV_SETTINGS
> +	CFG_EXTRA_ENV_SETTINGS
> +#endif
>  #ifdef CONFIG_EXTRA_ENV_TEXT
>  	/* This is created in the Makefile */
>  	CONFIG_EXTRA_ENV_TEXT
> -#endif
> -#ifdef	CFG_EXTRA_ENV_SETTINGS
> -	CFG_EXTRA_ENV_SETTINGS
>  #endif
>  	"\0"
>  #else /* CONFIG_USE_DEFAULT_ENV_FILE */

The problem is that I believe we intend for CFG_EXTRA_ENV_SETTINGS to be
where we can override things in a more final manner.

--=20
Tom

--RPgU1yc4cgpcoAAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGu0ACgkQFHw5/5Y0
tyza8Av/ftz6rb/KkiwCYGWkaR4WvIlSc1yuTZ9lHqPv1anN5K0rFTkunUeSMxjW
0aaTavMXiuO7bwvmh2LYUbx/c6VpZ8FrM9MmKUsWl+7rUlKRkOjTxZB6bZsYjB9R
bVbkeX/qPpfaozQC/wzBTO6UyD4W02N7jKSa+r+UR2dWGdwmVE1OgCardI0Lyuwe
eNDc/7ydanlyuBFenetwKgcgCq6IFfSgEvB+hOIoSCbFpD5JGdjXZtbc/kZGTcUf
TvAXSDgW/CW5gI7ez6w2/ML6wsrT/ULEJp6yZQ15iBZBnHtRmLLKpuWc0diaItkB
zVfLSTMN/ZRZj1g1L8878a1lX85VqV2LZIQnYt0sXqaYWQh9u6XijKl/jGPwhZ11
etCyxb2R2UjCLnqQJIUvOk/Strom75vzSLc323BKKjr5DgDF9xS+CwFBvIHLV27d
K0/hmeEVkJ9L2M1TizappVLiTnGYrLQvqD1Ew1eb17Ea8NlyuBpmR4zJXGC92gst
i0IbqmdT
=rDsG
-----END PGP SIGNATURE-----

--RPgU1yc4cgpcoAAm--
