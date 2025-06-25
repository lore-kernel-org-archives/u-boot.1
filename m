Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6045FC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 06:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919CF82977;
	Wed, 25 Jun 2025 08:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750834341;
	bh=5t/nInhrmzkyxppHMD9AutQ2jYqrrirbQVcQN80ejd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hm+qflt2RLD58DG8jn+S9e+eu8Zx4pW+DdVVT4YG3KSXrrDE5eJ11HbMo+r3J3y2d
	 TQ0g0fVr7w4vv9ihXpPmhXn40LVSh6XK+QbMa1vNOwaqBXzd+VHGk0O1b3ITiD3gVJ
	 Yss0zBHnpSqwb5AxkXiccGE6/Dr3vT4V7MUfyuOeKn49rKgRuxqNYsM6W5DrT7SO5P
	 buL45eCvjMsJRjhCimq0f+pX9bpB3t0udIfok1nBz9/G6U3DPPssoLNo/0oYDmbRJG
	 522CkrS0HU2ZBTk3cFfgyH4lVChDaVmL63zUr05mo5Y6MNveWaa/WJHb36FC5b4rmO
	 FIlFAF5gowaDQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5D482B18; Wed, 25 Jun 2025 08:52:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C69803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 08:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="I0lCHkBd"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 78F4F1039BD04; 
 Wed, 25 Jun 2025 08:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750834337; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=5t/nInhrmzkyxppHMD9AutQ2jYqrrirbQVcQN80ejd4=;
 b=I0lCHkBdE+JdG+j+7cwwJ33+eDmLKjciGnQGy42AmQw1ag1aLqJjxgg3enl73rJCiWJ2Oz
 7GN27MUxxgJi/RInoAq3mVxG0lNL13/3NpZseiG5rlCApu/5Wqx4BYuPgneOW2W42uf5kt
 H4GWCEr2x7rwa/Xgya8RVVblljcmf9bjpryeorZkbBZQeL4cb+QpSzF4gwkXLt0yFg1H2a
 OIgx5cyCBNHvAG1RPFnfBk3lx05lovtJ17h/YqU+1/NMG7zL4joLj7Mp1IWBUTmT2Z5Mcm
 FJuz9v+MjEQUh3SjE9BUa/J5elNwZ7dgv7EcGK2f/Sk+Oa4YSWmpoKaOBuHUcA==
Date: Wed, 25 Jun 2025 08:52:14 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com, Tom Rini
 <trini@konsulko.com>, albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] config: nxp: bk4: Increase size of
 CONFIG_SYS_MALLOC_F_LEN (to 0x1000)
Message-ID: <20250625085214.6cc15b46@wsk>
In-Reply-To: <CAOMZO5Dfw4PDRR1zBMr_8vgZey-X06RPhoCZkwz=kpFyZDY49w@mail.gmail.com>
References: <20250624204700.972663-1-lukma@denx.de>
 <CAOMZO5Dfw4PDRR1zBMr_8vgZey-X06RPhoCZkwz=kpFyZDY49w@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Domo4rzSiVAJIDkAk=HlA.B";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3
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

--Sig_/Domo4rzSiVAJIDkAk=HlA.B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Tue, Jun 24, 2025 at 5:47=E2=80=AFPM Lukasz Majewski <lukma@denx.de> w=
rote:
> >
> > The commit c69103218ee4 ("i2c: mxc_i2c: add DM_FLAG_PRE_RELOC flag")
> > has enabled by default the i2c initialization in the pre-relocation
> > phase.
> > It turned out that vf610 based BK4 board had too small
> > SYS_MALLOC_F_LEN pool size.
> >
> > After increasing it to 0x1000 the board boots again.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> It seems other Vybrid boards also have the same issue.
>=20
> What about removing CONFIG_SYS_MALLOC_F_LEN from all the Vybrid boards
> so that the default of 0x2000 is used?
>=20

Good idea.

I will check if this can be safely done - for some reason smaller
values were used on Vybrid boards.

> diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
> index 2b72ec916327..82ebf704c605 100644
> --- a/configs/bk4r1_defconfig
> +++ b/configs/bk4r1_defconfig
> @@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=3Dy
>  CONFIG_ARCH_VF610=3Dy
>  CONFIG_TEXT_BASE=3D0x3f401000
>  CONFIG_SYS_MALLOC_LEN=3D0x402000
> -CONFIG_SYS_MALLOC_F_LEN=3D0x800
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_ENV_SIZE=3D0x2000
>  CONFIG_ENV_OFFSET=3D0x200000
> diff --git a/configs/pcm052_defconfig b/configs/pcm052_defconfig
> index d0d558ab11ad..81d703ec679d 100644
> --- a/configs/pcm052_defconfig
> +++ b/configs/pcm052_defconfig
> @@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=3Dy
>  CONFIG_ARCH_VF610=3Dy
>  CONFIG_TEXT_BASE=3D0x3f401000
>  CONFIG_SYS_MALLOC_LEN=3D0x202000
> -CONFIG_SYS_MALLOC_F_LEN=3D0x400
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_ENV_SIZE=3D0x2000
>  CONFIG_ENV_OFFSET=3D0xA0000
> diff --git a/configs/vf610twr_defconfig b/configs/vf610twr_defconfig
> index c823cb0a30ee..8129484513dd 100644
> --- a/configs/vf610twr_defconfig
> +++ b/configs/vf610twr_defconfig
> @@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=3Dy
>  CONFIG_ARCH_VF610=3Dy
>  CONFIG_TEXT_BASE=3D0x3f401000
>  CONFIG_SYS_MALLOC_LEN=3D0x202000
> -CONFIG_SYS_MALLOC_F_LEN=3D0x400
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_ENV_SIZE=3D0x2000
>  CONFIG_ENV_OFFSET=3D0xC0000
> diff --git a/configs/vf610twr_nand_defconfig
> b/configs/vf610twr_nand_defconfig index 84e73c0c6657..51365990d0fb
> 100644 --- a/configs/vf610twr_nand_defconfig
> +++ b/configs/vf610twr_nand_defconfig
> @@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=3Dy
>  CONFIG_ARCH_VF610=3Dy
>  CONFIG_TEXT_BASE=3D0x3f401000
>  CONFIG_SYS_MALLOC_LEN=3D0x0220000
> -CONFIG_SYS_MALLOC_F_LEN=3D0x400
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0x180000




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Domo4rzSiVAJIDkAk=HlA.B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhbnJ8ACgkQAR8vZIA0
zr3jEAgA3TU6+JHhOdrwIWpkEofEv9+F561uKYpceC9m96F9sIypLnZW3w0dDRc1
s6T/yj1YVveE6Gex4WbslMa2m4sIwUVabeAlOpr5yLbTcxxY0Bvv+lad1Dy06SGC
y10TGvRfBK+ukaj5tK5CHHxvhqxK4XxK48BKFC01fUaNi2rBcXQ2EKBnA9u6gbLT
EHabCm7X1K4YpgDhdH3hUG9P4sL1SnC03XomhtG9ioI2hdZcIGK4fRckO45Hc+6x
plN3IlQVFucRpNEW51ljtxQaOmLaBGFKexdb7D1Kwls73lDfm59DXUOEKgnJCGwe
7YHz7Ipgl8WPVr0mbEg6TeTNvlFzyw==
=mu9t
-----END PGP SIGNATURE-----

--Sig_/Domo4rzSiVAJIDkAk=HlA.B--
