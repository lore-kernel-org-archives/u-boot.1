Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E045ACFB44F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 17:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785478899C;
	Mon,  7 Oct 2024 19:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pl01JXae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFCC888D33; Mon,  7 Oct 2024 19:05:57 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB80888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 19:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5e7a6de541cso2403945eaf.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728320754; x=1728925554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lE3pIOXiagoIN94iWC3MmUIvdulhkwYi1OqBG2M4oSA=;
 b=pl01JXaeb9ui35LOyKnE4htoG85sbxtL/GVsOcJP0nhfZPk4FBJ8iemugbBYtVu4NP
 SfFrPaFOH4tYzPXcweTh46QhNE7BXZKs6uMf74/wSSuYwQbfxffeEfDFIT1sNM4V5DwB
 cjgAmK8Ry3kY+QSjby5bEw5kU85HvGK+Wx/QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728320754; x=1728925554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lE3pIOXiagoIN94iWC3MmUIvdulhkwYi1OqBG2M4oSA=;
 b=aexx+HHSawPS7S19vaqLWORZT0vwZ5LCmPS5itqefLNZOEKCoeZn2LQjc9v3JQGanp
 bTBUcd10sWxpSPqD+AMmODms0DWTDhjeW+huEUTu0w9eH9mpCI1hr3YjU+c/fFQjNGIa
 HAnTSwYIDPVmzQatZRaydUU1ceuyJC+V4NC6LIGS2IVOB35HQ8EsG2QCxR4pNHLALeeR
 x+KgF12vXnRtsFNZYo3s2OCDi5jExL04sV99j8NPimlhJqA0+oyR2wvhUB9hsUQffUaV
 ytSxTzTpVfTWa3ihCsxCHHZrTIte4Y9nUUjimdZQUhcxuoGOahWfP0JevsmE2/zixkh5
 qEsQ==
X-Gm-Message-State: AOJu0Ywu5dGn2YRPfQ3k1UAoGfO3uctkurns8px/hX4QNJdoXkZW69Gl
 WilvoIJyXLGtPbb/bjI2YEPavDvh/uZy0+CHts1x8ZGoUKU+gZiCkEubL1rRWEw=
X-Google-Smtp-Source: AGHT+IGnhNW1EOwdWc72jR6AG6QntzOUu/V24V5kiDpYFKiX1Q5dhUMdQIe95q6zeX1pcWAqD/QJdg==
X-Received: by 2002:a05:6358:2820:b0:1be:de52:97b9 with SMTP id
 e5c5f4694b2df-1c2b7f4f290mr230027855d.2.1728320754625; 
 Mon, 07 Oct 2024 10:05:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46dfd5fsm27325046d6.52.2024.10.07.10.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:05:54 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:05:51 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, judge.packham@gmail.com,
 alice.guo@nxp.com, xypron.glpk@gmx.de, ye.li@nxp.com,
 peng.fan@nxp.com, festevam@gmail.com, marex@denx.de
Subject: Re: [PATCH v1] arm: global_data: add scmi pointer
Message-ID: <20241007170551.GB4737@bill-the-cat>
References: <20241006095228.2800776-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qbEg1RQpGOddZPRy"
Content-Disposition: inline
In-Reply-To: <20241006095228.2800776-1-alice.guo@oss.nxp.com>
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


--qbEg1RQpGOddZPRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 05:52:28PM +0800, alice.guo@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add scmi device and channel pointer for i.MX9.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  arch/arm/include/asm/global_data.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/gl=
obal_data.h
> index 45401d5e3c..d04359f167 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -108,6 +108,9 @@ struct arch_global_data {
>  #ifdef CONFIG_SMBIOS
>  	ulong smbios_start;		/* Start address of SMBIOS table */
>  #endif
> +#if defined(CONFIG_SCMI_FIRMWARE) && defined(CONFIG_IMX9)
> +	struct udevice *scmi_dev;
> +#endif
>  };
> =20
>  #include <asm-generic/global_data.h>

But why is this only needed for i.MX9 families and not other users?

--=20
Tom

--qbEg1RQpGOddZPRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEFO8ACgkQFHw5/5Y0
tyyHbwv8CoWN3nUVypct4UCaS853JiKuIAOek8m85sKQOqHjfmDVARezTMXEq8EC
6QWtUGdsOR4mtmyr2c60hdtcUUt2w5DQ4NLcm0mbq1MoX61quMAElUCLj9AYKDUr
8RG9oHBskoHXwp+5NUQkbjjGy3L050gB0Kq9Vg+o0/qQsJei4uvmO25eYfquJTVP
yH13lXaNVmWNEzNSvBulgULOWUjMM+yWCMsMOqg7jsXy5ChOUU5XHJsvGa6iruso
WjpZwBWCpNdm5fOS6/5Xlgfki7i5rw9mCe1Bm6ms9E0iX6L6eQ82Ftx7wTpVqwZh
FRIaKghcefgCEkaP51cbv1Yne+z26ufd77RC3TtJI1aSTCviy1iP/9MtI+hSdTue
39gBhU8zUUrL7s6k26np6iT3g/p3RIq1G5kZlHOEWiulKlFXZe6xDS+XtRRdaX3x
bxmkDACjjQiWOGmlCZ/3+DzJxLAZFPQzEJUMtHgEyd9dfwVqjuwC3bVp+E6aY54R
7UqtBnUh
=Wfug
-----END PGP SIGNATURE-----

--qbEg1RQpGOddZPRy--
