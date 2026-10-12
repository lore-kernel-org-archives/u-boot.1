Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716DCCA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 208AF40435;
	Mon, 12 Oct 2026 20:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDOj1OxxLgnT; Mon, 12 Oct 2026 20:23:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A1B740445
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791836617;
	b=MHebIXImMf/RRkCTVfGqoYWpUXYO+Zw0EiLYk1ccXzX2PjITAxSMqqYHJ3dNcTebROho
	 lI+ICzyzn2msJiAtKQu7JTcBLFWBqOIx/4unht3gH91n7mjeXRj66dwO0EdNnVPx+8YoU
	 +p1asZbbvxzpf3HrVRIkSvRQ2bRX3q/Wd3XNWgRfJB3ozGg7c8qLK18YLuXdKrYba30qy
	 MvF+94ovsxmmMmCI/+c5gOdmW3oJeKQCsC7qq2DhaRZVhn65Tx1Z+VeUN1H/2n22EbIJo
	 yCsAHF3mKX8WMGDYh88N1yHICeBrf0DcQAltUd+/CWJf7Qvl4ATtoGB6lpE0Vgz7yqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791836617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Rd0pe2AJjlf9C/VbvF1R/58AKIALe3ZjIarH0r7/DrY=;
	b=E86p6oVlWYB8wwgMAlSuAcIcZsdAQBWsZO4TgazwXOj3s0Blzd4d3Q5iViw9y/BHanRx
	 6HzjYLhyEsbZpqga1R1je9f4t9OuHnLcMOxc3cuyd6uri8sZ/VeVoIeTOC+gzhaDsinw3
	 xSWl6RsC8L1WLDhTd8igA+FWvdhYeymatjKNOYpOasO0Qvw+iexUtM0ZbRm0EaClxZ5R6
	 DxNdag7vjyoKeJg2Y8dB/W8KaV2+X/KmNjhH80KA5PsrKA20AIjt3AbJLrrjDm0rYiogR
	 4/mbLtMqOGbPw1qQDKe7EtnCcfaU5TWrXNFxFaX9sdx8JdaGFXrb7Caj5Mkadpeqbxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791836617;
	bh=Rd0pe2AJjlf9C/VbvF1R/58AKIALe3ZjIarH0r7/DrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mhdocx2SOtJLo+dfxyfNHotQKenv8ZrfwEJQppoOyVFSiHamFIEbHWE1jH2NP5aDH
	 7tAUxb+JEK6u4ZBmrEYdJ5lXSvzIXGKw6fRHkoet8om5BlIw9SM/ilUSVVqMsD+7Sl
	 UO57+ZPRecxQl4jrcTdp76z5EK9xP/HE1mrkeNWBG676cg/6TvgiDdwXC7hwH5EALj
	 8QccndIpC/OfxQLzmaMeNrqx4ZiL1cUlsGsccKWzK+YR5tZ12oDyawlBLVcMqIF6cx
	 SEapFJ7VqYbR7w4KMnoKYDr+xWaIE3dyiA91lh1KaHDYXRmKCRuN74trBMD7fm0oZh
	 jNI7R78jSbCzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A1B740445;
	Mon, 12 Oct 2026 20:23:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3048731
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4C93400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:23:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mPKdlqIcMA-j for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:23:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0B94E4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791836615;
 b=qljORNKWrOBCoY99dhA3JVsE1WlbiRd7gwilwo9azCyy8yAEXKQroS1nrQ0loL5TE5R6
 VOVcbr3OCdjX/QQOFu2WF87MwJrRGvhCqSdikGNfgqgJDYfj2+E+eHSzdY0gs00PA+yVL
 Ti4xL6wRBzKVZQ8j/5rY7AD4RStE3iWgtLo3Aa1puEXD/JfIRfCEx3DnxcD2MACeAl6kh
 6V5XVFgZ6AySSSrfmePibg8+l7pEpysm+VWrLbl47Aarn0mJYStV1566kuojxl4/m2FVd
 UVGtSFhJ3ddmZHAclWGjxjvcCTDq/cByFGk6iCpnW4BVbvZOOwpJ1ko0te7UKfinuRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791836615;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Rd0pe2AJjlf9C/VbvF1R/58AKIALe3ZjIarH0r7/DrY=;
 b=lIRpyZfbjQd9lvnMb9sHVmqVbCPTiU+Ct9GOK35iJMtW23drfYybWvzX/G2vE0Inhwy5
 0jNhRO/QcU38tN1SHQ2T8R3Xfybkqs+mZ+eOOTBW2vwWYUwHoKcj/VbNVEYoeFIR7H2LH
 kDxnYdFwSgvxj+w3rtBKqDxYYR0Tn/6wHrnk6fZwzyTt1zo2dSa+wK2Cfhaa2ZZzn2LYO
 oooOoBfpNf6Lcw0OfG+sh6rCKGzS/4+y4jZRBj9TFK7zRCBudXCgsFQtfq0xVTKF0EtS2
 C/EyyviIEVc0SiJIyZgL1x7bhb4Cr9FvEfKZCvED5ZtiAZiKfAG2K73gM9Xkiy1He3g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=J4yVao1e; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=J4yVao1e
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B94E4002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:23:34 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6de08b2e447so897015eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791836613; x=1792441413;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rd0pe2AJjlf9C/VbvF1R/58AKIALe3ZjIarH0r7/DrY=;
 b=J4yVao1esWCSEy78yJPuVPoBX+sUXTqoWw+wF3D0fryJg+9OdW/VlVE/5mk/9zGzfi
 Qo5fFngjF5gRtDdH0seBZz7yh7nEYf2mhqUpUhRyzmCFOJPBz+JLykREzrSjuGt21Xt5
 vIw7sGiMuYAGpldvz4kQH2m0sur+zUn809Fv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836613; x=1792441413;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rd0pe2AJjlf9C/VbvF1R/58AKIALe3ZjIarH0r7/DrY=;
 b=f5pae8yb+N4T/t7AZtLiwwLnjZD6RbMCI4qXdazRoig1ULEMELCUyTOKkRGNNuTaNA
 Y4eTvw7P0etKIqPkDxXTkBhFaM1jmvI6YFAbCSXinNNjr620aSWI6SjDZUrQBbvcWIRe
 92dJOByvavH1UbafsyfUP2jD/PUvWgFb3EjCqCOVxWviH1dL3bCFGJHO9ggI0a2Y8/wi
 +QI/tGxvpeMK3UFPKmGx2L6gt96zKTb7a9X9DV62Lz361TFYvoHWGLZVSg2xGjnwtdYN
 CS6CjXCqhx1SizRFyEcIJ10WyKLbXZrw98SQ9fpxLSieO5c6ThAoz3orYbiuYmUFNsGy
 zFOw==
X-Gm-Message-State: AFq9FYIS86mLODKnSd1vZxjbJak7ekJK310h/YqkJh2FhmcvpD0IXSXu
 e7JabuYcxgcnC6+WjxrXCaEc9noNpBExt13gbO/Sv4BoeZ6pooAhcaVNzAW/HwGy/tk=
X-Gm-Gg: AYBFou0in0rT4Pii3Do9eNTJUJd6aS+jtMGfRLXnJbs2tX/LD82YMOhXROMI40hWYow
 1NsxpVeljjiL76UaIZRYyCTWEyp8FS9UVeBX21WHImU1vG9jw5S9y0o8DCshVHJGxq4jeuAg6xd
 uOcSVUwoIMYFESDW6i/xoifvBgW4COJBw0R+W83w+NgL0tsZ9zwwtEqsQUx1ndXD9dIKWZP4B9L
 OeC4AMw6shksZ2xajdNhWvnnly48RqZi1gUj6ovWCxZ00SqT9wGChqkDuKzfGRxcB3lnbblO6B8
 J5KGUMXHl87m6cLD5ywezQEM7nwz8qnDVQlkwQ4SMV0iD8Ye4FxMYloyOzt/S/4f8Va2/dk48CF
 5YHF7I7ranC90rB9m2vFmNDKVMU2NEEvlOPHvtk13qBaBJ5V6q/EVWGHMWmA2Kixmr9rx9lJuN9
 64eyD5gwM7gajMroJM6L7uiQ+Pl3Kr2Q3WRoZ2pOBAilJIbfsm+epIw60eusKD9LkLSUdxvkQeC
 CcQH6TOdSllzc/FXfBCjYgSAjbuK6ydgHcptG+arhxsTLH+VjLD46+78LRJXDQLoXyIJ2Stv/QN
 CPxkZ0QORL1hGzz+Mxk=
X-Received: by 2002:a05:6820:221c:b0:6f7:384:a09c with SMTP id
 006d021491bc7-6f70384ab43mr2197896eaf.59.1791836613525; 
 Mon, 12 Oct 2026 13:23:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a858aa3esm10605994fac.12.2026.10.12.13.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:23:32 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:23:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, michal.simek@amd.com
Subject: Re: [PATCH 1/2] spl: atf: Check the return of the entry/load lookup
Message-ID: <20261012202330.GI3722450@bill-the-cat>
References: <20261012015542.1156811-1-sebasjosue84@gmail.com>
 <20261012015542.1156811-2-sebasjosue84@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DIgOQlmxOmrQ9tu+"
Content-Disposition: inline
In-Reply-To: <20261012015542.1156811-2-sebasjosue84@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--DIgOQlmxOmrQ9tu+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 07:55:41PM -0600, Sebastian Alba Vives wrote:

> spl_fit_images_get_entry() reads the entry point of a /fit-images node
> with fit_image_get_entry(), falling back to fit_image_get_load(). Both
> report failure through their return value and leave the caller's ulong
> untouched: fit_image_get_address() returns -1 before it reaches the
> *load assignment, both when the property is absent and when the value
> does not fit in a target ulong.
>=20
> The result was stored in ret but never tested, so a node carrying
> neither an entry nor a load property made the function return an
> uninitialised stack value, after first reading it in the debug() call.
> spl_invoke_atf() hands that value to bl31_entry() as the BL33 entry
> point, overwriting the CONFIG_TEXT_BASE default the caller set up for
> exactly this case.
>=20
> Before commit caa7fc2c5775 ("spl: Use standard FIT entries") the lookup
> used fdt_getprop_u32(), which returns the value itself and yields
> FDT_ERROR on failure, so the variable was always assigned. Switching to
> the fit_image_get_*() accessors moved the failure signal into the
> return value, where it was left unchecked.
>=20
> Return the entry through an out parameter and report failure, so both
> call sites keep the default they initialised.
>=20
> Fixes: caa7fc2c5775 ("spl: Use standard FIT entries")
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  common/spl/spl_atf.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> index cb0604ce03..c058774eba 100644
> --- a/common/spl/spl_atf.c
> +++ b/common/spl/spl_atf.c
> @@ -252,17 +252,21 @@ static int spl_fit_images_find(void *blob, int os)
>  	return found;
>  }
> =20
> -ulong spl_fit_images_get_entry(void *blob, int node)
> +int spl_fit_images_get_entry(void *blob, int node, ulong *entry)
>  {
> -	ulong  val;
>  	int ret;
> =20
> -	ret =3D fit_image_get_entry(blob, node, &val);
> +	ret =3D fit_image_get_entry(blob, node, entry);
>  	if (ret)
> -		ret =3D fit_image_get_load(blob, node, &val);
> +		ret =3D fit_image_get_load(blob, node, entry);
> +	if (ret) {
> +		debug("%s: no entry or load address\n", __func__);
> +		return ret;
> +	}
> =20
> -	debug("%s: entry point 0x%lx\n", __func__, val);
> -	return val;
> +	debug("%s: entry point 0x%lx\n", __func__, *entry);
> +
> +	return 0;
>  }
> =20
>  void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
> @@ -280,7 +284,7 @@ void __noreturn spl_invoke_atf(struct spl_image_info =
*spl_image)
>  	 */
>  	node =3D spl_fit_images_find(blob, IH_OS_TEE);
>  	if (node >=3D 0)
> -		bl32_entry =3D spl_fit_images_get_entry(blob, node);
> +		spl_fit_images_get_entry(blob, node, &bl32_entry);
> =20
>  	/*
>  	 * Find the U-Boot binary (in /fit-images) load addreess or
> @@ -291,7 +295,7 @@ void __noreturn spl_invoke_atf(struct spl_image_info =
*spl_image)
> =20
>  	node =3D spl_fit_images_find(blob, IH_OS_U_BOOT);
>  	if (node >=3D 0)
> -		bl33_entry =3D spl_fit_images_get_entry(blob, node);
> +		spl_fit_images_get_entry(blob, node, &bl33_entry);
> =20
>  	/*
>  	 * If ATF_NO_PLATFORM_PARAM is set, we override the platform

We change the return type of spl_fit_images_get_entry and now don't
check what it returns. We do add a new and useful debug statement.

--=20
Tom

--DIgOQlmxOmrQ9tu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas1BvgAKCRAr4qD1Cr/k
CrXwAQD+lRSLHeJwUNkjUE9b5jYiUehtmW2w0Ui3a3U58e3DwQEAzi+O0DfnEbOR
dOX86a4HXOxtognb0XUPDCVvXvWqigU=
=Jfvk
-----END PGP SIGNATURE-----

--DIgOQlmxOmrQ9tu+--
