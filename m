Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF369C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 11:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123D387FE7;
	Wed, 21 Feb 2024 12:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jZ9s0ZoQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D7D87BBA; Wed, 21 Feb 2024 09:34:41 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7B587B1D
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 09:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-luthra@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41L8YVcC049950;
 Wed, 21 Feb 2024 02:34:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708504471;
 bh=6JE8lmFCGK11Ey8cKDBHCuPoOYH4pPJ7dXpeEgB72sE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jZ9s0ZoQ6xPNgZnWGhUKZ5dXZC88ifM/1srGUISR9JpAg+TKh0wyF/n1zVaIW1nSY
 CvRllYhtmciEQ19CCX4o59mYJUjfPxfAiFlDrbImh7MfSf1IqBhhgRlYpztCQP3RjM
 8SSCeN2eCSK3CfFQWYR47dris6yP3G7eo36jYr+g=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41L8YVUT025125
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Feb 2024 02:34:31 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Feb 2024 02:34:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Feb 2024 02:34:30 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41L8YTxU127012;
 Wed, 21 Feb 2024 02:34:30 -0600
Date: Wed, 21 Feb 2024 14:04:29 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <danishanwar@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <matthias.schiffer@ew.tq-group.com>,
 <r-gunasekaran@ti.com>, <u-boot@lists.denx.de>, <j-humphreys@ti.com>
Subject: Re: [PATCH] dma: ti: k3-udma: Fix ring_idx to pair k3 nav rings"
Message-ID: <im2622kh25pjh4r4socejvhsvjyjumbeloo5ncfmjsygtmscfb@wq7d6bpsa5s2>
References: <20240221072825.3645303-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rsbny4s32rt4dpho"
Content-Disposition: inline
In-Reply-To: <20240221072825.3645303-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 21 Feb 2024 12:29:44 +0100
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

--rsbny4s32rt4dpho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Udit,

Subject: Re: [PATCH] dma: ti: k3-udma: Fix ring_idx to pair k3 nav=20
rings"

Trailing quote in the subject

On Feb 21, 2024 at 12:58:25 +0530, Udit Kumar wrote:
> ring_idx was not correctly assigned in case of tflow_id is zero.
> Which leads to wrong pairing of DMA for drivers like OSPI.
>=20
> Fixes: 4312a1dfca26 ("dma: ti: k3-udma: Use ring_idx to pair k3 nav rings=
")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

With the subject change,

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>  drivers/dma/ti/k3-udma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index eea9ec9659..39866ffff8 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -884,10 +884,10 @@ static int udma_alloc_tx_resources(struct udma_chan=
 *uc)
>  		return ret;
> =20
>  	tchan =3D uc->tchan;
> -	if (tchan->tflow_id >=3D 0)
> +	if (tchan->tflow_id > 0)
>  		ring_idx =3D tchan->tflow_id;
>  	else
> -		ring_idx =3D ud->bchan_cnt + tchan->id;
> +		ring_idx =3D tchan->id;
> =20
>  	ret =3D k3_nav_ringacc_request_rings_pair(ud->ringacc, ring_idx, -1,
>  						&uc->tchan->t_ring,
> --=20
> 2.34.1
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--rsbny4s32rt4dpho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXVtZQACgkQQ96R+SSa
cUWtMBAAmtleKaqFDkynLx4gRqCdooQ7v9h2FwNwps+2MywT2muTjvyuM5GcQxg3
0kyU7uBetChZdAQofN5xcE12ytcRroFkxP/FsvB/iVXYb/796hYzmzm4H+/BBobX
6A5LNDVqvoziLGt3ex3U7DQmcnuvONGmBMVHdIII0VQ0xs0ISE8yWVHzRRXhXU/Y
z+pham3elQ0kIadgAt8lpnA3GIfVC/We68NWgyynyITW4uJAim/BwMTRC7dKQl9M
h0BEJHf5Ei89Vap7pIY8jViXgGYh0CvM/NQCsTcscvs5niFEv7DfjS1U03Gshum+
4xRRyYf3+9UMnhC2JlrPvfOv0K9NRV16u3DdQLJS9lh8r5Wd+RMMpuF33WaM6FsJ
hlkcl7p6v4YHUkJbn51pj9d0tmQ0A0NvM8RUR/SL0LsdC8vNK7x+SlCI0BtGqODB
1W8Mzr3EGBdWZ67HqdBemAewAvOYhlEEwuRQ/0NmL9Oa3yQGF3HwJjWLBtMgaNuB
GcmKknrSAwBus0MqdLnG7CAZ3NxX4/vCm8Ok8A3bPZXGc0f/L6Vb3KuW1YP3akdv
nmBTEVLtpx5HQ/9rq1Rbhj0DQOINsGd3WU1YUT1GdXtQF15Lbk1DBHQGjYScHbfA
YEAYasnXFo9w2gflh1C86j+JgdX5tht4VIBWqa5Dz5PG8TajAlM=
=a+mS
-----END PGP SIGNATURE-----

--rsbny4s32rt4dpho--
