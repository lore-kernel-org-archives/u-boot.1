Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582CCCFB44C
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 16:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEFC7888B2;
	Mon,  7 Oct 2024 18:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XwO9UJ1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBADA88B3F; Mon,  7 Oct 2024 18:55:40 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910AC8870D
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 18:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5e77c6ed928so2445674eaf.0
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728320137; x=1728924937; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P6D01uB5zqKD4BY5J5UWcikL/nGHGpn/Qd1GwwVhHnE=;
 b=XwO9UJ1YelMUmseXGJ4Ct5+ceSJkI85Db3Gw2bE5wpQwZ0LgUUXyND0D3RTLm7Ntlr
 mqwZfDUNpNOklYkG6IRbIntFGVKWwLWDu55XWZKsunNCIRshob1Mhmeetmk2ngecweUF
 wwAnjIasG/Szef8lO5flRGFOJvVY95M6VgH88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728320137; x=1728924937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6D01uB5zqKD4BY5J5UWcikL/nGHGpn/Qd1GwwVhHnE=;
 b=YbFoQ8pvLMnxAOqoP9XMKtkWo/3Wz7FgX9gaC1+94pN+cBpteh4iV99Vzi2usTm6l4
 Ti0Z1CvfjcfVuWVrmq8Ig7CscmQ3VQ6i31jjYBrBtjjf2oD3ZguC1k3gXI1ajM4BSuh1
 mapoBtLGtK7w+Tx5WWWbwe6klsaAc+Ot6SbBI+X6KiJAEtQ1ogNUKDWAxQanDA54MCLb
 mgaKVzAWosl/NeGevOrWPXlYl1fAJqTFYnBbV4vjT/Idzjn8ypPQ53GVFYtmspyRp/RB
 g62x5xsTEvOMW+h28sJJTlJ5Z+hFHW2FNtsImbJfkyOCcsFi6Ud4z32oOC4MkIqbPCC0
 DriA==
X-Gm-Message-State: AOJu0YwdiSkI+VoaVV6NNzhNZa6rJGJsBZz5orsYfvK5VoC1/3/9uXIC
 Z8115rNf6RZkCprXxKrBrBSQOldONifaWQadh6sBjtCT+zXO+S3NQUEB2Lq83Lg=
X-Google-Smtp-Source: AGHT+IHxNA7ErUXx9wtkGWEGFbNSddkfVVzrPHUwyXs+jvYMfQxjqefX8I0nTm22/qfKZeILTqZSAQ==
X-Received: by 2002:a05:6871:109:b0:270:27e6:6f1a with SMTP id
 586e51a60fabf-287c22b5ae2mr6506500fac.41.1728320137235; 
 Mon, 07 Oct 2024 09:55:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae75615905sm273311185a.11.2024.10.07.09.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:55:36 -0700 (PDT)
Date: Mon, 7 Oct 2024 10:55:33 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, akashi.tkhro@gmail.com,
 etienne.carriere@foss.st.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v1] firmware: scmi: dump error string
Message-ID: <20241007165533.GW4737@bill-the-cat>
References: <20241006071317.2792980-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8fo+AeldjyFmUwRl"
Content-Disposition: inline
In-Reply-To: <20241006071317.2792980-1-alice.guo@oss.nxp.com>
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


--8fo+AeldjyFmUwRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 03:13:17PM +0800, alice.guo@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> When error happends, dump string is more intuitive.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/firmware/scmi/scmi_agent-uclass.c | 26 +++++++++++++----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware=
/scmi/scmi_agent-uclass.c
> index 8c907c3b03..e2d42d2914 100644
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> @@ -18,23 +18,25 @@
>   * struct error_code - Helper structure for SCMI error code conversion
>   * @scmi:	SCMI error code
>   * @errno:	Related standard error number
> + * @string:	Name the scmi error code
>   */
>  struct error_code {
>  	int scmi;
>  	int errno;
> +	char *string;
>  };
> =20
>  static const struct error_code scmi_linux_errmap[] =3D {
> -	{ .scmi =3D SCMI_NOT_SUPPORTED, .errno =3D -EOPNOTSUPP, },
> -	{ .scmi =3D SCMI_INVALID_PARAMETERS, .errno =3D -EINVAL, },
> -	{ .scmi =3D SCMI_DENIED, .errno =3D -EACCES, },
> -	{ .scmi =3D SCMI_NOT_FOUND, .errno =3D -ENOENT, },
> -	{ .scmi =3D SCMI_OUT_OF_RANGE, .errno =3D -ERANGE, },
> -	{ .scmi =3D SCMI_BUSY, .errno =3D -EBUSY, },
> -	{ .scmi =3D SCMI_COMMS_ERROR, .errno =3D -ECOMM, },
> -	{ .scmi =3D SCMI_GENERIC_ERROR, .errno =3D -EIO, },
> -	{ .scmi =3D SCMI_HARDWARE_ERROR, .errno =3D -EREMOTEIO, },
> -	{ .scmi =3D SCMI_PROTOCOL_ERROR, .errno =3D -EPROTO, },
> +	{ .scmi =3D SCMI_NOT_SUPPORTED, .errno =3D -EOPNOTSUPP, .string =3D "SC=
MI_NOT_SUPPORTED" },
> +	{ .scmi =3D SCMI_INVALID_PARAMETERS, .errno =3D -EINVAL, .string =3D "S=
CMI_INVALID_PARAMETERS" },
> +	{ .scmi =3D SCMI_DENIED, .errno =3D -EACCES, .string =3D "SCMI_DENIED" =
},
> +	{ .scmi =3D SCMI_NOT_FOUND, .errno =3D -ENOENT, .string =3D "SCMI_NOT_S=
UPPORTED" },
> +	{ .scmi =3D SCMI_OUT_OF_RANGE, .errno =3D -ERANGE, .string =3D "SCMI_OU=
T_OF_RANGE" },
> +	{ .scmi =3D SCMI_BUSY, .errno =3D -EBUSY, .string =3D "SCMI_BUSY" },
> +	{ .scmi =3D SCMI_COMMS_ERROR, .errno =3D -ECOMM, .string =3D "SCMI_COMM=
S_ERROR" },
> +	{ .scmi =3D SCMI_GENERIC_ERROR, .errno =3D -EIO, .string =3D "SCMI_GENE=
RIC_ERROR" },
> +	{ .scmi =3D SCMI_HARDWARE_ERROR, .errno =3D -EREMOTEIO, .string =3D "SC=
MI_HARDWARE_ERROR" },
> +	{ .scmi =3D SCMI_PROTOCOL_ERROR, .errno =3D -EPROTO, .string =3D "SCMI_=
PROTOCOL_ERROR" },
>  };
> =20
>  /**
> @@ -163,8 +165,10 @@ int scmi_to_linux_errno(s32 scmi_code)
>  		return 0;
> =20
>  	for (n =3D 0; n < ARRAY_SIZE(scmi_linux_errmap); n++)
> -		if (scmi_code =3D=3D scmi_linux_errmap[n].scmi)
> +		if (scmi_code =3D=3D scmi_linux_errmap[n].scmi) {
> +			debug("errno: %s\n", scmi_linux_errmap[n].string);
>  			return scmi_linux_errmap[n].errno;
> +		}
> =20
>  	return -EPROTO;
>  }

This is going to increase the overall binary size with string when we
already have a valid errno value to print, please just debug print
errno value.

--=20
Tom

--8fo+AeldjyFmUwRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEEoIACgkQFHw5/5Y0
tyzLtAwAqDI+ox8mXYBKH+78+3r0wrgNv+/8nH6eYMj3kfevfVEMm7wSzYJ2dlu7
9otvfUnUIEibWHkPla4TdmaqnJ2EPNGfIyDEMN/IstBkDqku64Aabc9FGyqfPVdo
KFtOx7dkZnMjpR7pMH7gOnp9SFsUsUQxCnXzVSLQDhbE6E4XaYITv3X++Q498Tbu
8ISEQH1g/muypHQ7Ud8QhNpzyGgUMbGf5qC62f2JC1+8OaSMnsMi5leho1BfDu8h
NriETNBRP1AToXb+c+sTFWEeR51Q8pJf955wgCtP4ce6T7/ZHsF7Alfdxx1Y3R8C
jw+ap34oN2IlIlj8GNnS9C2n2H9XoHK2Yyd/bJ8lGU9VmMhRqlKiSteCoTY74XJH
wfrtqQ78jKdu9y/swG+mr3y1T9o1RHgR9k4jTp3o/NfmYBafe4grlOaJZnOCcLGR
aG8PUIZXSJFihQQfQb+BFHpAZ66DE83X0ZLSj4+W3Qtv5fngXvQg0Oxya/sJSzOy
tnbqN+uS
=EIzt
-----END PGP SIGNATURE-----

--8fo+AeldjyFmUwRl--
