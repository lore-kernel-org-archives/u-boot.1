Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02A1C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21576876D0;
	Mon, 27 Nov 2023 19:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OUubxw73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F196876D0; Mon, 27 Nov 2023 19:14:02 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACDBF8761B
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-daef74513e1so4017931276.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701108837; x=1701713637; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6eCjqqa57W1RS2VhndBv9EJyszrbVxfhTgeiEElovAA=;
 b=OUubxw73M0y60wMcBzIcdJ5aEdpevEAIIiaUY6+ZuY/XU5pveLLeDq7J8w0QPGPQ8p
 k2v3TsB23IY1itCD854b+FI0KIM3uftMPSDKFVToc6e6ehght+TjOgejEdLyLFa1cgIt
 aFa7Dpi29RIlzoHrdUwZpscUN8Uq7xkNREdxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701108837; x=1701713637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eCjqqa57W1RS2VhndBv9EJyszrbVxfhTgeiEElovAA=;
 b=VDx73FhJiKe7DlU4amD+1mt9QaSiN+AljYdeGgNUaF+NAjCnQ7f7mHMtB9kJ3dsAp3
 M9OZIYo5bhSnoeMDQEWOgys4ur5rqNIEG2TmGIWHIRPhy/yYUqTBxCA848608RaNGJYh
 DZsauz6rmI+4g+LX35bL3s0hoGtHcLT8SHDaj9D662y0NXODpy4qSxlgCZjrDx8TiUI9
 2PzVOGdd43TmJfykpsTAyu2xZ2OLTeUV6QZGismRAI9s4WjTN82SJG7xvFdAHVX12j5S
 UZwFBGAELG6JFXEMcHzlWEtn02rUUpfC/mwz6OU29hvu/2yqToyGadRlZWGCSL4Q6ZBs
 tYyQ==
X-Gm-Message-State: AOJu0YwdMFBD6DK8V5fVrs33QBH8uTnFPxIa8wAQk4jG4US0VlQuKNhL
 Tb46sJkxT/jLrlSKS+jKdsmdrw==
X-Google-Smtp-Source: AGHT+IH2xR9U5Z0hcaQmjyPqu9iZRPDG+SHe6UhvMzB4sH3pKWIRRhRz3mKVzJVga8GSIIMguay56Q==
X-Received: by 2002:a25:dcc2:0:b0:d9a:5aa0:7a30 with SMTP id
 y185-20020a25dcc2000000b00d9a5aa07a30mr12044092ybe.39.1701108837439; 
 Mon, 27 Nov 2023 10:13:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 l131-20020a252589000000b00d72176bdc5csm3200723ybl.40.2023.11.27.10.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:13:57 -0800 (PST)
Date: Mon, 27 Nov 2023 13:13:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: sean.anderson@seco.com, sjg@chromium.org, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
Message-ID: <20231127181355.GK2513409@bill-the-cat>
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NpcGNNWXpiHAGLxW"
Content-Disposition: inline
In-Reply-To: <20231127171058.165777-2-ilias.apalodimas@linaro.org>
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


--NpcGNNWXpiHAGLxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 07:10:57PM +0200, Ilias Apalodimas wrote:

> If a value is not valid during the DT or SYSINFO parsing,  we explicitly
> set that to "Unknown Product" and "Unknown" for the product and
> manufacturer respectively.  It's cleaner if we move the checks insisde
> smbios_add_string() and always report "Unknown" regardless of the missing
> field.
>=20
> pre-patch dmidecode
> <snip>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Unknown
>         Product Name: Unknown Product
>         Version: Not Specified
>         Serial Number: Not Specified
>         UUID: Not Settable
>         Wake-up Type: Reserved
>         SKU Number: Not Specified
>         Family: Not Specified
>=20
> [...]
>=20
> post-patch dmidecode:
>=20
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Unknown
>         Product Name: Unknown
>         Version: Unknown
>         Serial Number: Unknown
>         UUID: Not Settable
>         Wake-up Type: Reserved
>         SKU Number: Unknown
>         Family: Unknown
> [...]
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NpcGNNWXpiHAGLxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk3FkACgkQFHw5/5Y0
tyzOjgv/Q/CYDXo8shcTcTgTh07A0T2QuId8qwfax8CShws8kmvREiKaoxRJtRVw
180w9ZGo7GJShFGcl5CyydrP1E134DMTKhW7Y1qfcQWCCZFmfDCPMjjTemYuOURO
HrBSMWEul65LRP5cVAdRpZUFoQR/2XxCDCG/x5QbYH/7QFVAJprCpWZO/VjGaaDH
6c4hNNXlhTt2dZtYDm9KfmJdcEwMcmH7YNVNK04XSlQ2sAxpNQjRL6JCDi40WLlx
14M/Wo79Aco9kLHdwj4OsRJzR2orZzfWQEep2RLgAW9v5JMcxyE3C2qLzvpKC1Po
Yt+AFua5hzN9dOBOm7ofq/ANChh2VUj6/Y2yzWeu3hVuJkX5mlrq/CRekRhhur0J
NZgVsy/VqoRIBQpTWyjAMqCAUx/dVfJ2JbdsbbiEg/5Pt7VsEs+jayXOE4x3dZ34
Y/1OlV2sZHVuvgah+us7fADW/XraLfMd21oPVFAL3HLJ+Dsds30Mu1OqZoRlQ033
DEOe5VzN
=vTnF
-----END PGP SIGNATURE-----

--NpcGNNWXpiHAGLxW--
