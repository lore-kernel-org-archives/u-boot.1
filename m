Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0644EE6F07D
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 18:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0C989048;
	Fri,  1 Nov 2024 19:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PvaHdHua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E473889048; Fri,  1 Nov 2024 19:10:17 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BDF8903B
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 19:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730484611; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fc6U9jaP/FieqgjxA0mLTG3D9fKbiAHgcy+RQZqO05EneEsuK+26VZWsVUl7l2TeBdkAQqTXTExcQVl6os/Poyatal/r6ZnJc91gryFjEun5wxyvrTTQ+xZCTtCA8XlLoNiBG8P4Tn5AdtLGd8n60nHPuat7UFdpocQEK8fygxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730484611;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fvQ7dvbNGudXYQiWTseCvd8IIbXaK+srl09sM7zXUTo=; 
 b=GJ3VHzuB4pjaiUFLmIyfgxi5tFiqkS7QZ0AuFPA5gFC1kdLIE4XmksWrxHUaZ+Q+hb2LnprQDi24hmPfjC1T5pAec14MY21yqS60f+YU1Kr/7k0CPfNM2iNvVzLgyhiGZ5NC4cNcMdf6Tme+kLRHLS3xOfIPVfp8g9YH+xZoyp4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730484611; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=fvQ7dvbNGudXYQiWTseCvd8IIbXaK+srl09sM7zXUTo=;
 b=PvaHdHuaz98cYPPa9AfSVHtT/cyHtoBnFW/Mv60SSE8ubd1MDWDNhM/XZfvrGXMI
 TsdxazMGa6Wbjud5ez/mU8lAy+MehuyyGyx6Hkpx06hwGFTkeWlAsCQX69v5SGyxFaU
 VUxJ/r9QIfdqiiOyTzgz4pJKWz7SqXtdKUET+cTM=
Received: by mx.zohomail.com with SMTPS id 1730484609201135.4156588059667;
 Fri, 1 Nov 2024 11:10:09 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
 id AFE5C10604B0; Fri, 01 Nov 2024 19:10:05 +0100 (CET)
Date: Fri, 1 Nov 2024 19:10:05 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: bigunclemax@gmail.com
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Wang Jie <dave.wang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] usb: tcpm: fusb302: add missing newline character
 to debug output
Message-ID: <hw4nw77qclytkbpxlofjzx2hjyvncw4xcsf2mwcjkob2u5iwan@ln2m622kmn45>
References: <20241101103501.21432-1-bigunclemax@gmail.com>
 <20241101103501.21432-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cecc25ghj2a7rqoc"
Content-Disposition: inline
In-Reply-To: <20241101103501.21432-2-bigunclemax@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/230.373.91
X-ZohoMailClient: External
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


--cecc25ghj2a7rqoc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/3] usb: tcpm: fusb302: add missing newline character
 to debug output
MIME-Version: 1.0

Hi,

On Fri, Nov 01, 2024 at 01:34:50PM +0300, bigunclemax@gmail.com wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
>=20
> Add newline character in dev_dbg end.
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/usb/tcpm/fusb302.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/tcpm/fusb302.c b/drivers/usb/tcpm/fusb302.c
> index fe93ff3d339..ee283782792 100644
> --- a/drivers/usb/tcpm/fusb302.c
> +++ b/drivers/usb/tcpm/fusb302.c
> @@ -940,7 +940,7 @@ static int fusb302_get_src_cc_status(struct udevice *=
dev,
>  		return ret;
> =20
>  	fusb302_i2c_read(dev, FUSB_REG_SWITCHES0, &status0);
> -	dev_dbg(dev, "get_src_cc_status switches: 0x%0x", status0);
> +	dev_dbg(dev, "get_src_cc_status switches: 0x%0x\n", status0);
> =20
>  	/* Step 2: Set compararator volt to differentiate between Open and Rd */
>  	ret =3D fusb302_i2c_write(dev, FUSB_REG_MEASURE, rd_mda);
> @@ -952,7 +952,7 @@ static int fusb302_get_src_cc_status(struct udevice *=
dev,
>  	if (ret)
>  		return ret;
> =20
> -	dev_dbg(dev, "get_src_cc_status rd_mda status0: 0x%0x", status0);
> +	dev_dbg(dev, "get_src_cc_status rd_mda status0: 0x%0x\n", status0);
>  	if (status0 & FUSB_REG_STATUS0_COMP) {
>  		*cc =3D TYPEC_CC_OPEN;
>  		return 0;
> @@ -968,7 +968,7 @@ static int fusb302_get_src_cc_status(struct udevice *=
dev,
>  	if (ret)
>  		return ret;
> =20
> -	dev_dbg(dev, "get_src_cc_status ra_mda status0: 0x%0x", status0);
> +	dev_dbg(dev, "get_src_cc_status ra_mda status0: 0x%0x\n", status0);
>  	if (status0 & FUSB_REG_STATUS0_COMP)
>  		*cc =3D TYPEC_CC_RD;
>  	else
> --=20
> 2.45.2
>=20

--cecc25ghj2a7rqoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmclGXYACgkQ2O7X88g7
+pofkw/9HPGOvkWQNJDWN7hefu7MkS1xoMzy7EnVy6AKrF4Fw3uz+xtnYhH69F1J
UDTDafWYugVwLgLcPNX1xYcfz4gdkb3B+u4isjl2W6XiQgeXWyqu00o+3pIsr5iQ
EZCPKDKZVye90U5vevAvexHsnSHeqS71TO271A7BAWyfoQdBvrEcpmLspi6fAVeK
HLlSZAtVYcrlt35IWBHCTOyJSszbkJlJwTZieGUDNeA+ZUw5LmvHmUmsSvBoIWXJ
RJFsJRZVeCjaMXlzYoJIiEsVMBWMz5GcNDpwi+tAOmRKj2RAhOMgYvZqLfuYg7sp
022yke++Bnb4R5nmHx/reRmAUeQzTfAmyo1MTtMZ/259x3kwLy1S31RS5mbRLa0F
caRZpnHeDaov25uVIDyVgEs4Ty05LsTHrcsm6QhGVLm6+XkdtorHeKf1vPCaPKz8
VWAoT1asUfsXE+NaLU/8e7o22GlQadigSq3DuVVpuYTAVPmhZgHGLM31TQtJq9wW
nEpmX0XeeZxwf1fECCq+PabDBbEuYTYF1cn3KgL3fMOSRvLF5th/QdNNcPTzDJjj
2Tcif0mGEX7KzsRjWe+dxgn/sSd++cARsVdsagaLLyM64HAvqpuPTkCr/UVFnnu5
wiL5/bgNOiu8vPuQQQZF/Q/V3euD6dvGpM7NoYiEWHUDAr8r2rs=
=a9jd
-----END PGP SIGNATURE-----

--cecc25ghj2a7rqoc--
