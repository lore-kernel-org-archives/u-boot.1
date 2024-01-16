Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577A3C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 13:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16204879E4;
	Tue, 16 Jan 2024 14:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="U0YOvSSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4390C879E4; Tue, 16 Jan 2024 14:49:03 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 966C7876E5
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 14:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1705412939; x=1736948939;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RSyZYyMQgfxS+4Xftv2tNishUTbcnGzSLCyR8pSJIpA=;
 b=U0YOvSSF2/geTcx2706TS4UbSrvRaNb3JQ74xK4Q9qwMClE9CNjZLOc7
 8DdmlQUazYqauyJkvqritK3DvQz/7+YgU5+J/nFJs15nXl2kV0ha3IKGo
 WQgDv7nitiJMOjUH3dHjT6EHt2lNuU9qLPkJD9uKmITWRauRoMFird96T
 AxnBkFXyWyNUK38lf93U5/rm0eJntd9dwLCdY9RD1rJHCxj3yXvlFdRDg
 ywDo/Ap8JHWQfVij/+KMsv0G5BOmCSDlGiTTwXUVFvXABWc0DtdUMO8gZ
 Mj6H8vGZQqShNlmGasIV0O12bJVga0ZioJOAbU5o0u/BEtlwHmwNyFU1Y A==;
X-CSE-ConnectionGUID: i7wzn+J5QWyhyxLEdLriNQ==
X-CSE-MsgGUID: 6Txx3qCERZ+pykVmzPzt2g==
X-IronPort-AV: E=Sophos;i="6.05,199,1701154800"; 
 d="asc'?scan'208";a="16000830"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Jan 2024 06:48:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 06:48:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jan 2024 06:48:42 -0700
Date: Tue, 16 Jan 2024 13:48:06 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Raymond Mao
 <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andre
 Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>, Johan
 Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, Samuel
 Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20240116-snowbound-symptom-aa07c4dcf736@wendy>
References: <20240104014919.413568-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x10peqGISNg11rrX"
Content-Disposition: inline
In-Reply-To: <20240104014919.413568-1-sjg@chromium.org>
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

--x10peqGISNg11rrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Jan 03, 2024 at 06:49:19PM -0700, Simon Glass wrote:
> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>=20
> Tests for this will be added as part of the Universal Payload work.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Since this was merged into master, U-Boot is no longer booting on my
icicle kit (At least that's what my bisection tells me). This is a
RISC-V board and U-Boot for it is built from
microchip_mpfs_icicle_defconfig.

There's zero output on the console from U-Boot at all, the last thing
that I see is OpenSBI before things grind to a halt.

Thanks,
Conor.


> ---
> The discussion on this was not resolved and is now important due to the
> bloblist series from Raymond. So I am sending it again since I believe
> this is a better starting point than building on OF_BOARD
>=20
> Changes in v7:
> - Drop use of OF_BLOBLIST
>=20
> Changes in v6:
> - Don't allow bloblist with OF_EMBED
>=20
> Changes in v5:
> - Make OF_BLOBLIST default y
> - Make OF_BLOBLIST optional at runtime
>=20
> Changes in v4:
> - Rebase to -next
>=20
>  doc/develop/devicetree/control.rst |  3 ++
>  include/fdtdec.h                   |  6 ++--
>  lib/fdtdec.c                       | 44 +++++++++++++++++++++++-------
>  3 files changed, 41 insertions(+), 12 deletions(-)
>=20
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/=
control.rst
> index cbb65c9b177..11c92d440f4 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routi=
ne will provide the
>  devicetree at runtime, for example if an earlier bootloader stage creates
>  it and passes it to U-Boot.
> =20
> +If CONFIG_BLOBLIST is defined, the devicetree may come from a bloblist p=
assed
> +from a previous stage, if present.
> +
>  If CONFIG_SANDBOX is defined, then it will be read from a file on
>  startup. Use the -d flag to U-Boot to specify the file to read, -D for t=
he
>  default and -T for the test devicetree, used to run sandbox unit tests.
> diff --git a/include/fdtdec.h b/include/fdtdec.h
> index bd1149f46d0..e80de24076c 100644
> --- a/include/fdtdec.h
> +++ b/include/fdtdec.h
> @@ -72,7 +72,7 @@ struct bd_info;
>   *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
>   * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. Thi=
s should
>   *	be used for debugging/development only
> - * @FDTSRC_NONE: No devicetree at all
> + * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
>   */
>  enum fdt_source_t {
>  	FDTSRC_SEPARATE,
> @@ -80,6 +80,7 @@ enum fdt_source_t {
>  	FDTSRC_BOARD,
>  	FDTSRC_EMBED,
>  	FDTSRC_ENV,
> +	FDTSRC_BLOBLIST,
>  };
> =20
>  /*
> @@ -1190,7 +1191,8 @@ int fdtdec_resetup(int *rescan);
>   *
>   * The existing devicetree is available at gd->fdt_blob
>   *
> - * @err internal error code if we fail to setup a DTB
> + * @err: 0 on success, -EEXIST if the devicetree is already correct, or =
other
> + * internal error code if we fail to setup a DTB
>   * @returns new devicetree blob pointer
>   */
>  void *board_fdt_blob_setup(int *err);
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index 4016bf3c113..b2c59ab3818 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -7,6 +7,10 @@
>   */
> =20
>  #ifndef USE_HOSTCC
> +
> +#define LOG_CATEGORY	LOGC_DT
> +
> +#include <bloblist.h>
>  #include <boot_fit.h>
>  #include <display_options.h>
>  #include <dm.h>
> @@ -86,6 +90,7 @@ static const char *const fdt_src_name[] =3D {
>  	[FDTSRC_BOARD] =3D "board",
>  	[FDTSRC_EMBED] =3D "embed",
>  	[FDTSRC_ENV] =3D "env",
> +	[FDTSRC_BLOBLIST] =3D "bloblist",
>  };
> =20
>  const char *fdtdec_get_srcname(void)
> @@ -1662,23 +1667,42 @@ static void setup_multi_dtb_fit(void)
> =20
>  int fdtdec_setup(void)
>  {
> -	int ret;
> +	int ret =3D -ENOENT;
> +
> +	/* If allowing a bloblist, check that first */
> +	if (CONFIG_IS_ENABLED(BLOBLIST)) {
> +		ret =3D bloblist_maybe_init();
> +		if (!ret) {
> +			gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +			if (gd->fdt_blob) {
> +				gd->fdt_src =3D FDTSRC_BLOBLIST;
> +				log_debug("Devicetree is in bloblist at %p\n",
> +					  gd->fdt_blob);
> +			} else {
> +				log_debug("No FDT found in bloblist\n");
> +				ret =3D -ENOENT;
> +			}
> +		}
> +	}
> =20
> -	/* The devicetree is typically appended to U-Boot */
> -	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> -		gd->fdt_blob =3D fdt_find_separate();
> -		gd->fdt_src =3D FDTSRC_SEPARATE;
> -	} else { /* embed dtb in ELF file for testing / development */
> -		gd->fdt_blob =3D dtb_dt_embedded();
> -		gd->fdt_src =3D FDTSRC_EMBED;
> +	/* Otherwise, the devicetree is typically appended to U-Boot */
> +	if (ret) {
> +		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> +			gd->fdt_blob =3D fdt_find_separate();
> +			gd->fdt_src =3D FDTSRC_SEPARATE;
> +		} else { /* embed dtb in ELF file for testing / development */
> +			gd->fdt_blob =3D dtb_dt_embedded();
> +			gd->fdt_src =3D FDTSRC_EMBED;
> +		}
>  	}
> =20
>  	/* Allow the board to override the fdt address. */
>  	if (IS_ENABLED(CONFIG_OF_BOARD)) {
>  		gd->fdt_blob =3D board_fdt_blob_setup(&ret);
> -		if (ret)
> +		if (!ret)
> +			gd->fdt_src =3D FDTSRC_BOARD;
> +		else if (ret !=3D -EEXIST)
>  			return ret;
> -		gd->fdt_src =3D FDTSRC_BOARD;
>  	}
> =20
>  	/* Allow the early environment to override the fdt address */
> --=20
> 2.34.1
>=20

--x10peqGISNg11rrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaaJBQAKCRB4tDGHoIJi
0stZAQDbKg/2zIOMc0jWhPZQJUSf2UL/gQ5MiLnr758QNuq++gD/Qux37yPpw7S/
w3/UEdqiVl9oA1wDYakE6QbgzmxYrAg=
=KJ/Y
-----END PGP SIGNATURE-----

--x10peqGISNg11rrX--
