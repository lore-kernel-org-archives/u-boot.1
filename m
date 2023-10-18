Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53215CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D813F86E75;
	Wed, 18 Oct 2023 16:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lcxB/yRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22F486FA9; Wed, 18 Oct 2023 16:42:40 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6EE86D94
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59e88a28b98so60645907b3.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697640155; x=1698244955; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QZ3PAtvsWNpdZdFsmr09W04LVaYjigBfgA+b7LzB150=;
 b=lcxB/yRxzpQiQ8MUrPiSsWqcyyjjoM3VuxGkYQJmtJ/5jP7tS/CdfMMXe2/FLBIAuF
 y0Dhtzy/JxkYBMeqvLNdh7MdldC1uah7sNbtHkX1fzrNiYbkAC079oCNgMwy1q09cTY9
 deeAxPCgRQl9tFj8iF5xcy4ZvChK52vHmRzVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697640155; x=1698244955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZ3PAtvsWNpdZdFsmr09W04LVaYjigBfgA+b7LzB150=;
 b=AdJO/8y1NSb+F5DSepvB9biIPJhErodEGoWw7xp8XNOmPNR6bzkaRWfR2YTgE16aRn
 icHzFe13LwhUQJ/zJMMwxUfxjatkBJwfN1FZmes3kPjKVYJH7bHYDF1lKNy6f+5dGaNn
 UNBj04ssP7E8ZKMtEv+dEDFATs3zxyu7oXhk/Uf4LzxnRwdRYeTSzm0T83i5pZJHFlGe
 meVLJhJWIH3tqKhgNFMi0l1t4XXJGhK6AnenaXXMqUIJHpeI3a9pDKBnThWHgdl7bI79
 AlKi9WwH6I+O6+OFCuaZ5ygl20KIGhfhjjhiANM2y9j5E21daxfUGq1OSGHuK1uwpm6D
 im+Q==
X-Gm-Message-State: AOJu0YxRLa2Hs3y5MhGlnwM5bWJ5mQlCOik7jXS5nSOe/5j5J43zqEoe
 6GGWkwaPXR7gzz0e9sL7+El+6A==
X-Google-Smtp-Source: AGHT+IGU4n64lx1cWwkjpuQBY+NM0alVRsajgPDCF6HPUuyDj50rda1AMD4a0uXM0noZsbfQSOH7Ag==
X-Received: by 2002:a05:690c:ed1:b0:5a7:cb5f:ee0a with SMTP id
 cs17-20020a05690c0ed100b005a7cb5fee0amr4792207ywb.17.1697640155289; 
 Wed, 18 Oct 2023 07:42:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 w66-20020a0dd445000000b005a7cc149e3asm1554718ywd.2.2023.10.18.07.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:42:34 -0700 (PDT)
Date: Wed, 18 Oct 2023 10:42:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 02/32] bootstd: Correct dependencies on CMDLINE
Message-ID: <20231018144232.GA3785604@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3TjGDpEsHy53qX7v"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-3-sjg@chromium.org>
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


--3TjGDpEsHy53qX7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:27:53PM -0600, Simon Glass wrote:
> With recent changes over the last few years in boot/Kconfig it is
> no-longer possible to disable CMDLINE. It results in various link
> errors because some options which require CMDLINE are enabled
> regardless of whether it is available.
>=20
> Add the necessary conditions to fix this.
>=20
> Note that it would be better to have all commands depend on CMDLINE,
> but that is extremely difficult at present, since some functions use
> CMD_xxx to enable feature xxx. For example networking and environment
> have a number of problems to tease apart.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v3:
> - Reword commit message slightly
>=20
>  boot/Kconfig           | 19 ++++++++++++-------
>  lib/efi_loader/Kconfig |  1 +
>  2 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index a01e6cb8aafe..f74ac7e9cc72 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -342,6 +342,7 @@ endif # FIT
> =20
>  config PXE_UTILS
>  	bool
> +	depends on CMDLINE
>  	select MENU
>  	help
>  	  Utilities for parsing PXE file formats.

So, this part here is because of CONFIG_SYS_PBSIZE, which I think we can
/ should solve another way.

--=20
Tom

--3TjGDpEsHy53qX7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv7tYACgkQFHw5/5Y0
tyy1SQv+MafQHprKiCrQjwy2y2sHkL3rAhQ6KYkvx3OI8o6uBabdGL1hQhXV3lDq
w/UhO7PCtwz+TNMVBjygIJF3dCUeVCWRjXVES5q+A2Xl+g0VfnLJnFv4nXe6onYp
nH+tFR1lgIraIeIufylxC2sESRhYa7sUnjbePss2nnm4zSMt5filLb3XeCnxAeE4
A/Zo6Yyo+Yc8ZKDS+3qBWqwquant5COuedfo6Z9f1LbGMuFlHAzkj3Hn04jmleod
0tyjJ1G36+D8M9pdn1gGD2N+1yQv78XPECyzAHE91g6cR5Q2IDtKMNZKvaBfKFQj
W/S/zRp2FG+VLjRwCivpCh2bGZHa88dRG/joNm5CXpEbjP5WoNbdiQmc/uk9hMak
t+fQGO1bOx+BjowFOPIs6VzhSn6MmzMqsd0KQ4ODqjki6DxRil7ezKGCBRko2QXz
qe+F9gmmlFZ65HIJ2zkHdUMgmCIcmn3VInStLXGftW4MOgqTo7U3I1wmfu5rGAdO
Ra8lh1lR
=XOjA
-----END PGP SIGNATURE-----

--3TjGDpEsHy53qX7v--
