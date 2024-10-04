Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DE3CFA776
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FBA688F6F;
	Fri,  4 Oct 2024 14:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cknow.org header.i=@cknow.org header.b="sAgf/eUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A861788BAE; Fri,  4 Oct 2024 11:05:33 +0200 (CEST)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [95.215.58.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41038903E
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 11:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cknow.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=didi.debian@cknow.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
 t=1728032728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ww79gohvjcZRMu///+bt4nR22JaGq1T3kkk1duVLsvE=;
 b=sAgf/eUfIsZdMxVllXoHSMMCaT1883o9UjX2czECjm0fFsg9efyc6FctZGaVsZYIoEle2s
 XZRz9T/GXLguPVRuflSclfDPvFQKXndAw6UkI/CWMHwm+gge3cJuOVlWSFvTDeNTm5LhjG
 2Z777O81im6wZPcs8OorWjbgrfMRFshoRzg0fv/DRzQSpdaldCXRPJE/FtQV2sAedOclHW
 xDBfIkl9NDCO908uVKAxK2AvPPNkfOUQGiIyI5sxRpUEP1RQABteP+XJf/kVDushY9w9c4
 YLLLLJipyivKldRBOSY1wTu8pq7atcFo5di7ubiAoB3g+hgdN0VP+gohzyQxmQ==
Content-Type: multipart/signed;
 boundary=1133764c7c42b2f0d4bc1f94489267f35cb23b827293118c720348d19902;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 04 Oct 2024 11:05:11 +0200
Message-Id: <D4MWH0M95LGZ.2J0ZCBEC3YUJJ@cknow.org>
Subject: Re: [PATCH] Update the ARM trusted firmware git URL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Peter Robinson" <pbrobinson@gmail.com>, "Tom Rini"
 <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20241002180853.227389-1-pbrobinson@gmail.com>
In-Reply-To: <20241002180853.227389-1-pbrobinson@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 04 Oct 2024 14:47:11 +0200
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

--1133764c7c42b2f0d4bc1f94489267f35cb23b827293118c720348d19902
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Oct 2, 2024 at 8:08 PM CEST, Peter Robinson wrote:
> The primary upstream URL for tf-a has moved, in some cases
> things like tags are not always pushed to the old URL so
> update the URLs to the primary upstream project URL.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  board/rockchip/evb_rk3399/README       | 2 +-
>  board/sunxi/README.sunxi64             | 2 +-
>  common/spl/Kconfig                     | 2 +-
>  doc/README.rockchip                    | 2 +-
>  doc/README.uniphier                    | 2 +-
>  doc/board/armltd/juno.rst              | 2 +-
>  doc/board/bsh/imx8mn_bsh_smm_s2.rst    | 2 +-
>  doc/board/hisilicon/hikey.rst          | 4 ++--
>  doc/board/hisilicon/hikey960.rst       | 4 ++--
>  doc/board/kontron/pitx-imx8m.rst       | 2 +-
>  doc/board/rockchip/rockchip.rst        | 2 +-
>  doc/board/variscite/imx8mn_var_som.rst | 2 +-
>  include/atf_common.h                   | 2 +-
>  tools/binman/entries.rst               | 2 +-
>  tools/binman/etype/atf_bl31.py         | 2 +-
>  tools/binman/fip_util.py               | 4 ++--
>  16 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/board/rockchip/evb_rk3399/README b/board/rockchip/evb_rk3399=
/README
> index c6f58203ebe..c7caf1756d6 100644
> --- a/board/rockchip/evb_rk3399/README
> +++ b/board/rockchip/evb_rk3399/README
> @@ -31,7 +31,7 @@ Get the Source and prebuild binary
> =20
>    > mkdir ~/evb_rk3399
>    > cd ~/evb_rk3399
> -  > git clone https://github.com/ARM-software/arm-trusted-firmware.git
> +  > git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.gi=
t
>    > git clone https://github.com/rockchip-linux/rkbin.git
>    > git clone https://github.com/rockchip-linux/rkdeveloptool.git
> =20

I already mentioned this on IRC, but figured that this may be a better
way to communicate it.

This patch seems incomplete as the git repo's name has changed, but not
all the instructions which reference it.

So for example in this patch, this is the code that follows:

> Compile ATF
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   > cd arm-trusted-firmware
>   > make realclean

That ``cd`` command doesn't work as it should be ``cd trusted-firmware-a``.

This is just an example as this issue is present in more files (which
were modified by this patch).

Optionally you could consider if in f.e. ``tools/binman/fip_util.py``=20
``srcdir (str): 'arm-trusted-firmware' source directory``

should be updated to trusted-firmware-a. Not an error and probably
everyone understands what is meant, but for consistency it could be
beneficial if they're all updated.

> diff --git a/doc/README.rockchip b/doc/README.rockchip
> index 84caff8a24d..5fcbbd1d990 100644
> --- a/doc/README.rockchip
> +++ b/doc/README.rockchip
> @@ -73,7 +73,7 @@ Building
> =20
>     - Compile ATF
> =20
> -     =3D> git clone https://github.com/ARM-software/arm-trusted-firmware=
.git
> +     =3D> git clone https://github.com/TrustedFirmware-A/trusted-firmwar=
e-a.git
>       =3D> cd arm-trusted-firmware
> =20
>       (export cross compiler path for Cortex-M0 MCU likely arm-none-eabi-=
)

This is one of those others that should be updated (and is directly
visible on
https://source.denx.de/u-boot/u-boot/-/commit/0ec0207fe07356bddb10db717e21c=
261bebfb989

Cheers,
  Diederik

--1133764c7c42b2f0d4bc1f94489267f35cb23b827293118c720348d19902
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZv+v0AAKCRDXblvOeH7b
bkG9AQC7RwztVUvmgLT9buxIv+BVpOxpf78wTLOpqXoQjRb1hwEAluyiZ9+eQkJk
cBTdT2TTsY6cCANG1p0kJ5P1A71klwY=
=o/C1
-----END PGP SIGNATURE-----

--1133764c7c42b2f0d4bc1f94489267f35cb23b827293118c720348d19902--
