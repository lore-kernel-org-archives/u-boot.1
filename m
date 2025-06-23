Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9337DC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 16:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6DD582D83;
	Mon, 23 Jun 2025 18:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BEDnbKBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6239E82E05; Mon, 23 Jun 2025 18:53:15 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 043F782D34
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 18:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-606668f8d51so2614837eaf.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750697592; x=1751302392; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G0Rpo+TIspL9NZd30WTjdU24Dc+ZFtAKlEWU62fxL9g=;
 b=BEDnbKBLHLhQsCl5vz3PX3NJrvY7jCAGtjMFSiYUw2S58tnSIryWSNmUWLUExvDD7Z
 qrd6Tb2JJzD+FwDvzJTYkJwn2jEE94ETOXygugrZbroVK+k14vmB7a+TS/M0SWIL5U0G
 yxsAwLzuuixqJxLkU5LysYzGnefimNzfDVLYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750697592; x=1751302392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0Rpo+TIspL9NZd30WTjdU24Dc+ZFtAKlEWU62fxL9g=;
 b=W8uX2DRgXzS3oJ7D1O2ny2d6CVgFyACkUgGMHC+0fPrhYUePdW6/2o/jQRTFI6o5p1
 Ilk30y/LpXGBRl5ivY6FzOYmPbXnF4QU+SYLfgCiTpFPtFXzWCJsfgEtpf+FRX7+UOHn
 8u7lPb/lQKuMqYp+RfGjW552Iryz9ksR5RPggpq11Oj+cY451iB9gMykKjKoPIaCVgPI
 e7Iunc7Zpg02WLJ8ATNuZiTQgbz+WQfS64eh/iFL0NIIro18OAXIfYFkE3So6or553wJ
 SH9J06En60O9Ed/OnUkmQq60FZzFXfpw7HIOl6/3HXH8y2De9tqKBiqqOdZbMSjOVF9x
 deIw==
X-Gm-Message-State: AOJu0Yy9MpNb/Z7LqtTyaDNfpLy34iK6A2uRBhxRBtVSGYdwM5wE0Bav
 GegmGA58IscU5mlAP8K9CRhxcfZ1pAZYHB9qmE1rVT64LMERW+uckPRMWBXgdrf3quv+m+jGsIJ
 4n8+v0Do=
X-Gm-Gg: ASbGnctxvfxlqki+5L5sw6ANRjAe9x3AASGWEd7CPWfc5er2R+ybrNCt6zUs0Vbw89h
 5K1kYIDqASjzaLcIJYqcb47YnCu+SYE+yy212JGZC6W/9/nZiTJG+y4K0X0PxFESdb7h+T1U86O
 eh6tCBLEBzRSREP/b2Xw60z8FkJWuKaOvM9SW1N2/poXgriWB5GOwvBVZy/pFP/X1049rpuc6/M
 CBdcpcIXaSQp6TXb5rZ60GhAvHD/oEAz4m1LxYkgS/+pVH8g92By4HIHemOFdOX3a1Cdx9vhkBq
 i87XrTvUMzFenR5Vh7zaP9ix7lWOVd3zVFAX3MhI+UHn9kR8422eTZTKvSmyBZbw7fWZm1StqaT
 IJw5QhdKXn/4BDicDC3NBoYU=
X-Google-Smtp-Source: AGHT+IHPpyjgkC1+1gcjevrRpKONGVvAmAfUme0TPDSgHQkp14elEU6Z78Ux6PVp6xuDzDN4dLoUcg==
X-Received: by 2002:a05:6820:2008:b0:611:86c1:7656 with SMTP id
 006d021491bc7-6118f652de0mr180570eaf.4.1750697591618; 
 Mon, 23 Jun 2025 09:53:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b7f73f2sm1022504eaf.38.2025.06.23.09.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 09:53:10 -0700 (PDT)
Date: Mon, 23 Jun 2025 10:53:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Osaka Osaka <00601wayne@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Fwd: [BUG] bootm.c: Incorrect use of ft_len as end address in
 check_overlap()
Message-ID: <20250623165309.GE4003484@bill-the-cat>
References: <CAOZ77-G2V5Dq0rC-X9_6qHBA6Q30TjTPU-pKqDBgpp4b55GKog@mail.gmail.com>
 <CAOZ77-HkGL4dp2tYLNv32UPdhh3odNkv10v6vrpSYx+K3PBEuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6QYtxnDFfiNDtPSV"
Content-Disposition: inline
In-Reply-To: <CAOZ77-HkGL4dp2tYLNv32UPdhh3odNkv10v6vrpSYx+K3PBEuA@mail.gmail.com>
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


--6QYtxnDFfiNDtPSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 02:38:36PM +0800, Osaka Osaka wrote:

> Hi U-Boot maintainers,
>=20
> I would like to report a potential issue in bootm.c regarding FDT/OS image
> overlap checking.
>=20
> In current mainline code:
>=20
> https://github.com/u-boot/u-boot/blob/master/boot/bootm.c#L448
>=20
> We have the following logic:
>=20
>     if (check_overlap("FDT", map_to_sysmem(images->ft_addr),
>                       images->ft_len, start, size))
>         return 1;
>=20
> However, `check_overlap()` expects the second and third parameters to be a
> memory **range**: [start, end). Here, `images->ft_len` is being passed
> directly as the `end` address, but in reality it is the **length**, not t=
he
> end.
>=20
> This is misleading and could potentially cause overlap checks to pass
> incorrectly, especially if `map_to_sysmem(images->ft_addr)` is non-zero.
>=20
> To fix it, we should properly compute the end address:
>=20
> ```c
> ulong fdt_start =3D map_to_sysmem(images->ft_addr);
> ulong fdt_end =3D fdt_start + images->ft_len;
>=20
> if (check_overlap("FDT", fdt_start, fdt_end, start, start + size))
>     return 1;
>=20
>=20
> if (check_overlap("FDT",
>         map_to_sysmem(images->ft_addr),
>         map_to_sysmem(images->ft_addr) + images->ft_len,
>         start, start + size))
>     return 1;
>=20
>=20
>=20
> Let me know if I should send a proper patch for this.

Thanks for the report, yes, please do.

--=20
Tom

--6QYtxnDFfiNDtPSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhZhm0ACgkQFHw5/5Y0
tyzs6gwAjq8VanrJrys/4k8tH/IDK1NkhvTDu4JYq/gpNyeNwiNfZ+/aA0rsW6gE
rN6hW7z4OzLmmX2NYSLww8I5I4F/tlMlqjOxeRLyYeuTHgjHHeE1buzW/vlurJgd
U3pKk70ClJyPN0YMLwPhM/N+3yJdQI4DQSAvJb/xaNPIOvJj07ICBlsy3N9ZpOQP
ms1tXBIz7vs7t4ygnzsy7Zc+P4UcgMdIOtd3wKIgUnZfxghiwtUG1p0KXbVRhD/j
4aa/M/D4EdBl/IInICPvmliCkHixOTHhtgQzdIiQGs7C0NcxZLn7FEEbY0j6l38g
RbsiF5W/jjlmHcff0QPy5g3ULlknaHbqxn5Z3+qXhOJQp1yJhAZoeyqu9YqOjS9k
JF27KW7GYEWbAwKkdZwV65wbg68jfyPG4+lxCsWVEzcZ57B3FLqW1MtRMzIjjbSP
cPHAp3jXF6qc0Z6tcQGsT/nZ6ydFDt9SdNYiMWObnYu5QV/3z/g/6G+Gcxwm7X0J
LlfcHjuk
=Kwl6
-----END PGP SIGNATURE-----

--6QYtxnDFfiNDtPSV--
