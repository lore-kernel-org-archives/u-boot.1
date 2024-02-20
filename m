Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4A6C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFBA187D65;
	Tue, 20 Feb 2024 11:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A9C879FE; Tue, 20 Feb 2024 11:51:36 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 3392B87F83
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,172,1705330800"; 
 d="asc'?scan'208";a="194579968"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2024 19:50:55 +0900
Received: from [10.226.92.69] (unknown [10.226.92.69])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0514A4001942;
 Tue, 20 Feb 2024 19:50:52 +0900 (JST)
Message-ID: <69c9c403-2ac2-45b7-9e11-05db7b490a42@bp.renesas.com>
Date: Tue, 20 Feb 2024 10:50:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: Drop unused mmc_send_tuning() cmd_error parameter
Content-Language: en-GB
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20240220083642.34389-1-marek.vasut+renesas@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240220083642.34389-1-marek.vasut+renesas@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mVZf2t7aljx2KTm34cjQDdlH"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mVZf2t7aljx2KTm34cjQDdlH
Content-Type: multipart/mixed; boundary="------------2VMS6jfBgkvN2NmCgOE4loLp";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Message-ID: <69c9c403-2ac2-45b7-9e11-05db7b490a42@bp.renesas.com>
Subject: Re: [PATCH] mmc: Drop unused mmc_send_tuning() cmd_error parameter
References: <20240220083642.34389-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240220083642.34389-1-marek.vasut+renesas@mailbox.org>

--------------2VMS6jfBgkvN2NmCgOE4loLp
Content-Type: multipart/mixed; boundary="------------i2t20BtvCxiMIjQfqY9qXKUB"

--------------i2t20BtvCxiMIjQfqY9qXKUB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20/02/2024 08:36, Marek Vasut wrote:
> The cmd_error parameter is not used, remove it.
>  [snip]
>=20
> diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
> index 5a0c61daed5..296aaee7331 100644
> --- a/drivers/mmc/mtk-sd.c
> +++ b/drivers/mmc/mtk-sd.c
> @@ -1131,7 +1131,7 @@ static int hs400_tune_response(struct udevice *de=
v, u32 opcode)
>  				i << PAD_CMD_TUNE_RX_DLY3_S);
> =20
>  		for (j =3D 0; j < 3; j++) {
> -			mmc_send_tuning(mmc, opcode, &cmd_err);
> +			cmd_err =3D mmc_send_tuning(mmc, opcode);
>  			if (!cmd_err) {
>  				cmd_delay |=3D (1 << i);
>  			} else {
> @@ -1181,7 +1181,7 @@ static int msdc_tune_response(struct udevice *dev=
, u32 opcode)
>  				i << MSDC_PAD_TUNE_CMDRDLY_S);
> =20
>  		for (j =3D 0; j < 3; j++) {
> -			mmc_send_tuning(mmc, opcode, &cmd_err);
> +			cmd_err =3D mmc_send_tuning(mmc, opcode);
>  			if (!cmd_err) {
>  				rise_delay |=3D (1 << i);
>  			} else {
> @@ -1203,7 +1203,7 @@ static int msdc_tune_response(struct udevice *dev=
, u32 opcode)
>  				i << MSDC_PAD_TUNE_CMDRDLY_S);
> =20
>  		for (j =3D 0; j < 3; j++) {
> -			mmc_send_tuning(mmc, opcode, &cmd_err);
> +			cmd_err =3D mmc_send_tuning(mmc, opcode);
>  			if (!cmd_err) {
>  				fall_delay |=3D (1 << i);
>  			} else {
> @@ -1238,7 +1238,7 @@ skip_fall:
>  		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY_M,
>  				i << MSDC_PAD_TUNE_CMDRRDLY_S);
> =20
> -		mmc_send_tuning(mmc, opcode, &cmd_err);
> +		cmd_err =3D mmc_send_tuning(mmc, opcode);
>  		if (!cmd_err)
>  			internal_delay |=3D (1 << i);
>  	}
> @@ -1264,7 +1264,6 @@ static int msdc_tune_data(struct udevice *dev, u3=
2 opcode)
>  	struct msdc_delay_phase final_rise_delay, final_fall_delay =3D { 0, }=
;
>  	u8 final_delay, final_maxlen;
>  	void __iomem *tune_reg =3D &host->base->pad_tune;
> -	int cmd_err;
>  	int i, ret;
> =20
>  	if (host->dev_comp->pad_tune0)
> @@ -1277,10 +1276,10 @@ static int msdc_tune_data(struct udevice *dev, =
u32 opcode)
>  		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
>  				i << MSDC_PAD_TUNE_DATRRDLY_S);
> =20
> -		ret =3D mmc_send_tuning(mmc, opcode, &cmd_err);
> +		ret =3D mmc_send_tuning(mmc, opcode);
>  		if (!ret) {
>  			rise_delay |=3D (1 << i);
> -		} else if (cmd_err) {
> +		} else {
>  			/* in this case, retune response is needed */
>  			ret =3D msdc_tune_response(dev, opcode);
>  			if (ret)
> @@ -1300,10 +1299,10 @@ static int msdc_tune_data(struct udevice *dev, =
u32 opcode)
>  		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
>  				i << MSDC_PAD_TUNE_DATRRDLY_S);
> =20
> -		ret =3D mmc_send_tuning(mmc, opcode, &cmd_err);
> +		ret =3D mmc_send_tuning(mmc, opcode);
>  		if (!ret) {
>  			fall_delay |=3D (1 << i);
> -		} else if (cmd_err) {
> +		} else {
>  			/* in this case, retune response is needed */
>  			ret =3D msdc_tune_response(dev, opcode);
>  			if (ret)

This driver (mtk-sd.c) seems to be the only one that really uses the
`cmd_error` parameter.

Looking at the implementation of mmc_send_tuning() in Linux, this
parameter is used so that a caller can differentiate between a command
error and a data error. I don't know enough details about MMC to
understand the distinction, but I assume there is some reason for this.
So I wonder if the mtk-sd driver will still work if those error paths
are taken for data errors and not just command errors. Has this change
been tested on some board which uses this driver?

Thanks,

--=20
Paul Barker
--------------i2t20BtvCxiMIjQfqY9qXKUB
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------i2t20BtvCxiMIjQfqY9qXKUB--

--------------2VMS6jfBgkvN2NmCgOE4loLp--

--------------mVZf2t7aljx2KTm34cjQDdlH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZdSECwUDAAAAAAAKCRDbaV4Vf/JGvc11
AQDlI5nzXEOYzW3QAn/ttMOuaNvqShq8PqnHDN5K6f3swAEAk2ZR7wDrf4X9fsPONduSDC3C1Rq1
Njw68S61mFIV3gk=
=jERV
-----END PGP SIGNATURE-----

--------------mVZf2t7aljx2KTm34cjQDdlH--
