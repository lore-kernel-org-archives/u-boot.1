Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96384C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569A487F91;
	Tue, 20 Feb 2024 12:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9344A87D9A; Tue, 20 Feb 2024 12:01:41 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id ABE3287F9E
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,172,1705330800"; 
 d="asc'?scan'208";a="194580744"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2024 20:00:26 +0900
Received: from [10.226.92.69] (unknown [10.226.92.69])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 30CB742FA46C;
 Tue, 20 Feb 2024 20:00:22 +0900 (JST)
Message-ID: <05c8a770-99e1-4e0b-bd5c-c145e21e4d60@bp.renesas.com>
Date: Tue, 20 Feb 2024 11:00:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mmc: renesas-sdhi: Do not access SCC during tuning in
 send_cmd callback
Content-Language: en-GB
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
 <20240220083755.34449-3-marek.vasut+renesas@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240220083755.34449-3-marek.vasut+renesas@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Z4ABb4yWK6HV2oofxDxD5r0w"
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
--------------Z4ABb4yWK6HV2oofxDxD5r0w
Content-Type: multipart/mixed; boundary="------------QUp4Vq9abBAV4AUYxiAH9orh";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Message-ID: <05c8a770-99e1-4e0b-bd5c-c145e21e4d60@bp.renesas.com>
Subject: Re: [PATCH 3/3] mmc: renesas-sdhi: Do not access SCC during tuning in
 send_cmd callback
References: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
 <20240220083755.34449-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240220083755.34449-3-marek.vasut+renesas@mailbox.org>

--------------QUp4Vq9abBAV4AUYxiAH9orh
Content-Type: multipart/mixed; boundary="------------RZ0khgQUteEIiicixF6WQGE2"

--------------RZ0khgQUteEIiicixF6WQGE2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20/02/2024 08:37, Marek Vasut wrote:
> Do not access SCC when sending commands during tuning operation as that=

> will disrupt the tuning operation. The tuning operation is adjusting th=
e
> SCC settings itself in execute_tuning callback.
>=20
> When renesas_sdhi_execute_tuning() is called by the MMC core code, a lo=
op
> which consists of renesas_sdhi_prepare_tuning(), mmc_send_tuning() and
> renesas_sdhi_compare_scc_data() iterates over each SCC tuning tap.
>=20
> The renesas_sdhi_prepare_tuning() configures the SCC tuning tap number =
into
> hardware, mmc_send_tuning() triggers transfer of tuning block which dep=
ends
> on the bus mode for which the bus is currently being tuned, this inform=
ation
> is supplied by the MMC core code, and finally renesas_sdhi_compare_scc_=
data()
> tests the received tuning block for validity.
>=20
> Because renesas_sdhi_prepare_tuning() configures the SCC tuning tap int=
o
> the hardware to fit the tuning operation, mmc_send_tuning() which trigg=
ers
> command transfer using renesas_sdhi_send_cmd() must not manipulate with=

> the SCC in any way. Currently renesas_sdhi_send_cmd() does unconditiona=
lly
> call renesas_sdhi_check_scc_error(), which may adjust the SCC tuning ta=
p
> position by writing RENESAS_SDHI_SCC_TAPSET, which would overwrite the
> required tuning configuration set by renesas_sdhi_prepare_tuning() and
> disrupt the tuning operation.
>=20
> Fix this by skipping the renesas_sdhi_check_scc_error() call in case th=
e
> MMC subsystem is in tuning state. This way, the SCC settings are left
> unmodified by command transfer during tuning operation.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/mmc/renesas-sdhi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 9770b6bb5e1..316b75b35fe 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -798,9 +798,12 @@ static int renesas_sdhi_send_cmd(struct udevice *d=
ev, struct mmc_cmd *cmd,
>  #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
>      CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
>      CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
> +	struct mmc_uclass_priv *upriv =3D dev_get_uclass_priv(dev);
>  	struct tmio_sd_priv *priv =3D dev_get_priv(dev);
> +	struct mmc *mmc =3D upriv->mmc;
> =20
> -	renesas_sdhi_check_scc_error(dev);
> +	if (!mmc->tuning)
> +		renesas_sdhi_check_scc_error(dev);
> =20
>  	if (cmd->cmdidx =3D=3D MMC_CMD_SEND_STATUS)
>  		renesas_sdhi_adjust_hs400_mode_enable(priv);

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
  (tested on RZ/G2L with commit ad50a8151387 from
  https://source.denx.de/u-boot/custodians/u-boot-sh)

--=20
Paul Barker

--------------RZ0khgQUteEIiicixF6WQGE2
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------RZ0khgQUteEIiicixF6WQGE2--

--------------QUp4Vq9abBAV4AUYxiAH9orh--

--------------Z4ABb4yWK6HV2oofxDxD5r0w
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZdSGRQUDAAAAAAAKCRDbaV4Vf/JGvYrH
AP0V8maj1pX5eGieBGOcBQdemItxk7OjjDwQMV3LtpW2WQEAxp766x2UCX/MR7ztkF0SIGI2Ung4
cA+h73J/vK7g7A4=
=5mdV
-----END PGP SIGNATURE-----

--------------Z4ABb4yWK6HV2oofxDxD5r0w--
