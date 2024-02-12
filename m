Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CDAC4829D
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 20:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743AC879DF;
	Mon, 12 Feb 2024 21:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cJRo5Rd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9ED86D9E; Mon, 12 Feb 2024 21:48:15 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9559787D4E
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 21:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-604aaf2d047so37054137b3.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707770886; x=1708375686; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgcZLqFPsRbbNVkIXXvpMDFjroj7j/mPC9K6h/LrFV8=;
 b=cJRo5Rd7ARyXbASXWdz4j8qVMfgsUREbukKBkzIjY3qxaDsiZcfpuft3xjCG3M0p21
 bjvWb9sIqtcCHWu2zZhiQ8kWOkvIQY4jUHnYpHDax6L/mIU+YYG0WPjo+cjgeu/+thNh
 DHM0RDzuh2+7dkQPz9X3WLEqKOwKiTqd3U2fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707770886; x=1708375686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgcZLqFPsRbbNVkIXXvpMDFjroj7j/mPC9K6h/LrFV8=;
 b=wtHKXfi1oMIqJVaOmaMdYTMAvENDehVDvPGXldWku0GQ+dNKqErje10zAoF9LPZINj
 z+DgbVPrQ9xzCsknugXZCdKr8wEDx7vKEsTLF838QN015cjwLHG3YN2mS45B1/ZozD3b
 7zRSLSBnGrnjlxqV13vUS5XRhcjEUlTiTUE4IPzsHOb9I/cxGpXmDpdpJKhri3cCmPNB
 KW2gAR2ms+lxD7tX7CXca0FEuhJKQDR+8ZMxHBQ7GGT9IUAgG/eR1WQZckNN+CMiQajz
 KmqKEH8E3L49UbjaWdRgk8WmBrGcm516g3Y/l6EALyTllK4VxujkH8ZYri/XzK+eebGt
 tBMw==
X-Gm-Message-State: AOJu0YxdmX5q/5KkJI6ThiW4ypjG/Qe8O9vufP5sjcMq8aeW307Ot7jx
 LuuvPMkxN796AYebtsnmA1STAFYTUnYm7iQPGDhN0a1OfjG042SNGxFEIcnf23U=
X-Google-Smtp-Source: AGHT+IGk+bCAr8wUty8pME0x/bPYD791s0c3k1Nd3uyqWDDfdoaj0Q1EaehASalRjiAdUmt0LvrzbQ==
X-Received: by 2002:a81:488f:0:b0:604:4b89:bf4 with SMTP id
 v137-20020a81488f000000b006044b890bf4mr6012294ywa.20.1707770886289; 
 Mon, 12 Feb 2024 12:48:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXINxwcqqCO9nCgyOhopnDDHk2kPuPIC6Ilqm2o3vGMUZmZ0nTHw0XQwRfoDsRnvW2Nn6B9H4XBKHcLCIIfmN4Qk5JQUK/X7Sr6GnD5VRysbAnBKQst
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 a4-20020a0dd804000000b006048395c0f9sm1334132ywe.77.2024.02.12.12.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 12:48:04 -0800 (PST)
Date: Mon, 12 Feb 2024 15:48:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Janne Grunau <j@jannau.net>,
 Jesse Taube <Mr.Bossman075@gmail.com>
Subject: Re: Pull request doc-2024-04-rc2
Message-ID: <20240212204802.GP3040305@bill-the-cat>
References: <feceb682-cb14-42de-b833-4198e1a71c0c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JPbYAo5T4qNuXs8X"
Content-Disposition: inline
In-Reply-To: <feceb682-cb14-42de-b833-4198e1a71c0c@gmx.de>
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


--JPbYAo5T4qNuXs8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 09:18:09PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 91c37c4a20db24a4fc1d565c70035072d355cc=
e0:
>=20
>   Merge tag 'u-boot-imx-master-20240212' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-02-12 09:26:20
> -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2024-04-rc2
>=20
> for you to fetch changes up to 2eb39c9adafb4210c6bcf0aed75a34493c098c8e:
>=20
>   doc/develop/codingstyle.rst: Clarify include section (2024-02-12
> 17:35:34 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--JPbYAo5T4qNuXs8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKg/wACgkQFHw5/5Y0
tyzruwv+OiiXyiGI9tO5pLW9sllPaZgdmO6KlDTavHIvuDZVtOIzGKjghgUemFEP
Mw8QkS2BkteuBsKJClW4okugzVOmzmcslMAja0knxHmEzOuEx+6M2Z+39Gjn2bwb
ZxUxdhSAZaLW4h1sW6O3UArH6CmGIrugbWSKw8smIKQoSdZl+AZUtAguHvaabUpU
yhs/+veOEtSXLS2q892yzywqf/hsEQHMywrllFKFZQA0eF66d6d72uSSfw1gpsol
j0DstFaD7p3b63lno5zVMEUW6I+0M5H9S8aBcF4zwAR+xhXy6zM4urCRtoyqfl/O
IDnSkouPmdDxj5g520f4ChB4fqz0eGoggCCNiXDqrF1H0nCPygoQ2HRInv+ynVqy
We929vjCKBeWAPNknGskGAWOo3WVi9uFVPrTozkwRY5W/kBlIvGzXzKvpjPGWrQ6
GhHHAjflPrOH8oNT4BoSTRiHT/BqWSbdzyLbr6sYn3//n8C2wbILu3qOsLcHOIxr
RDGwGaGH
=vOc2
-----END PGP SIGNATURE-----

--JPbYAo5T4qNuXs8X--
