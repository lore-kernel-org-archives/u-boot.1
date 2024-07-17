Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103E9C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 07:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66FD888599;
	Wed, 17 Jul 2024 09:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="afg/KKR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEFC885AE; Wed, 17 Jul 2024 09:39:06 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C1B88297
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 09:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4880560007;
 Wed, 17 Jul 2024 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1721201943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVqGcJi/0C6Tdo7xoyHEoJQK0JHfWWJy7S9yivedLjM=;
 b=afg/KKR3i8ZgHCt5RVfUbimbKM4L0mV8titTU6TKtljZNQNIINPWQ9RWyP6JMv+2weTh6/
 rbbFNGEVfk7n588DDy+pAdy789Q9HiHSMHbqXFXcqbXPJWKH5Bs3Kved/SsljOS844LsVg
 r9iL/Wb+4pDqvoF9vSbQj6jA5jJq7JYNxdMh4tYMtfUSZFQ8p1loufpN1rldWAZ9yOrfWq
 5C/K9bqi1PVAhoHar76+hqjugeF70odblMsBUMLdEP62u6iJVVF08EEnzYFsKusjRWjcVy
 Z0XKEZz7fFRKjDU9bfoo6dou56c/iSLXfGuNUVXebRqJeDRkdPfaL76jC5EiTA==
Date: Wed, 17 Jul 2024 09:39:01 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Tim Harvey
 <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
Message-ID: <20240717093901.3d5ee2ed@xps-13>
In-Reply-To: <20240715112302.652527-2-lukas.funke-oss@weidmueller.com>
References: <20240715112302.652527-1-lukas.funke-oss@weidmueller.com>
 <20240715112302.652527-2-lukas.funke-oss@weidmueller.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Lukas,

lukas.funke-oss@weidmueller.com wrote on Mon, 15 Jul 2024 13:23:01
+0200:

> From: Lukas Funke <lukas.funke@weidmueller.com>
>=20
> tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
> initialized in tpm_tis_init(). However, the init-function is called
> *after* tpm_tis_wait_init() introducing an uninitalized field access.
>=20
> This commit switches both routines.
>=20
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>=20
>  drivers/tpm/tpm2_tis_spi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> index b0fe97ab1d0..5a4dbfd3ccb 100644
> --- a/drivers/tpm/tpm2_tis_spi.c
> +++ b/drivers/tpm/tpm2_tis_spi.c
> @@ -256,17 +256,17 @@ static int tpm_tis_spi_probe(struct udevice *dev)
>  	/* Ensure a minimum amount of time elapsed since reset of the TPM */
>  	mdelay(drv_data->time_before_first_cmd_ms);
> =20
> +	tpm_tis_ops_register(dev, &phy_ops);
> +	ret =3D tpm_tis_init(dev);
> +	if (ret)
> +		goto err;
> +

Strange, I don't remember wait the init was done after the wait_init,
but at a first glance the fix looks fine.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

>  	ret =3D tpm_tis_wait_init(dev, chip->locality);
>  	if (ret) {
>  		log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
>  		return ret;
>  	}
> =20
> -	tpm_tis_ops_register(dev, &phy_ops);
> -	ret =3D tpm_tis_init(dev);
> -	if (ret)
> -		goto err;
> -
>  	priv->pcr_count =3D drv_data->pcr_count;
>  	priv->pcr_select_min =3D drv_data->pcr_select_min;
>  	priv->version =3D TPM_V2;


Thanks,
Miqu=C3=A8l
