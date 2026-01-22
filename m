Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B01D3EE6B
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 15:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0F88397D;
	Thu, 22 Jan 2026 16:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YoZ/O/HA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47A2839DF; Thu, 22 Jan 2026 16:01:42 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A94980077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 16:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7cfcebf1725so625600a34.1
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 07:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769094099; x=1769698899; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zkf0/DsExzVnpIJWbOQAlOzZCiGCNQEjC/tL3ZyGUxA=;
 b=YoZ/O/HA+80QFK9ez7eTZdCzhCxvGwQu3ivwoLLaC5lJzTKIIa0Ib3aJyUnjWCRKov
 zdQdBAY/JizsM7K8lP7/YaHoD/HwdWjKrIobvQ08tO3WleOeTIOPWijtbNiUVjmuX4ZI
 EA//MZjc6aZb8tbkWSVoShEsSUDmN42Ogbtp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769094099; x=1769698899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkf0/DsExzVnpIJWbOQAlOzZCiGCNQEjC/tL3ZyGUxA=;
 b=ghGm533vdAIEKs3o0whE/sFIEO/bdttYrQewT85boaPQLZurnSu7Yk6U5zQnTQerrY
 OTQG2zL71iFVp2CW1gkyRXIlAnArGREMLGnQ30VtBKeDesuODdUZ5q0yJYjcv+mWsSuG
 kyar3R+zMaBL/lrgEawpJ1Qqf0A5tyyWkg75gynXkAj1AX2GyLrg/Cob0h8jmNz+xuua
 gSmd/jb0HJbRED74TbCgL21JY8VRfeewVY+O8g0o1LThITa+ncCkJRd1JtVOIfzSRLIP
 8VGpMHzXiD1DyrHeSuuL/t7cu4YiB5/MsPmLSUPWb0NPGQLFmeN1YUCcP1gyFDzqmMQX
 zCnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsm5hKSeFcUmfP+LonZ6rtlxEvDNwnmsv8gNm5EL9St3WAem+iAauI7MRp/WLzw0jXPnyfxAQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzxWTHOlmPqRmUwPiuwMb3weGEC05IGwyxhuL+cHc4lFZu5qNat
 TXY6PZBF5oVTb6Lw6M7Mcl49kPIKmbGj3CKdWy5gfoj0iNtNoJCkSdu5qHTNejN06cM=
X-Gm-Gg: AZuq6aIzLtjU3HC5UKQvHlAywSW6tdliSzcOR1O19gnHn+OoabSWqsffjoq40SzTYG6
 aYwJq1cEL9RkEd3JMK4uprPD9N7gi7HPlPklLRywYCjbgOuGsKjBbM/pWDyN2/W4d8qcUdqHe+W
 p8ZwEHiKi9/541xf4VMGUdjm0SsBPA78llFS/YFZUYH5zg5L8CURCZ7XuWIUbOVb++5k391ZiBk
 jxeIIDPRXKonudysH7aDoeXOlclkjtVSw3swvWiE6IPJsXnCbl2WamBAt7AceRruHoJj9RcVY/A
 2EodPoVKbh5Hee8CWdk+fvGjGwbTNBTEOkFAtByt+oSbbVfMoJpuwyj2lv5yOtXOepfx0v0UWZX
 14FJgYN6ykcsv57uagY2OZ3Rhp6ZAwJZeyCbNcJ25DwHRYGvBaiVGIgeSg6zP5b/26lA5CSdJ0r
 C8rSoOLlTJxfkeL/nY5b9pkcBo9Tri/uW8AE1Qm2BmlYC45HOLT2NAUrMuRh1Aft9tahTUoEGWa
 FUq76nhegJH+gCH8HbSWIJwYbulDqc2N6uAZTk=
X-Received: by 2002:a05:6830:6586:b0:7cf:d2f3:af8a with SMTP id
 46e09a7af769-7d140ac1cfcmr4265849a34.28.1769094098645; 
 Thu, 22 Jan 2026 07:01:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm12688052a34.6.2026.01.22.07.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 07:01:38 -0800 (PST)
Date: Thu, 22 Jan 2026 09:01:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: varadarajan.narayanan@oss.qualcomm.com, gabriel.dalimonte@gmail.com,
 u-boot@lists.denx.de, caleb.connolly@linaro.org
Subject: Re: [PATCH v3] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <20260122150135.GZ3416603@bill-the-cat>
References: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yhZl+UcNKJftXPL5"
Content-Disposition: inline
In-Reply-To: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
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


--yhZl+UcNKJftXPL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 12:04:42PM +0530, Balaji Selvanathan wrote:

> From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>=20
> Do FAT read and write based on the device sector size
> instead of the size recorded in the FAT meta data.
>=20
> FAT code issues i/o in terms of the sector size. Convert that to
> device sector size before doing the actual i/o. Additionally,
> handle leading/trailing blocks when the meta data based block
> no and i/o size is not an exact multiple of the device sector
> size or vice versa.
>=20
> Tested on UFS device with sector size 4096 and meta data recorded
> sector size 512.
>=20
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
> Changes in v3:
> - Respin, no changes
> - Link to v2: https://lore.kernel.org/u-boot/20241125085213.460723-1-quic=
_varada@quicinc.com/
>=20
> Changes in v2:
> - fat_sect_size is declared as static
> - The else block in disk_write() function has been removed
> - The commit message has additional details about testing
> - Link to v1: https://lore.kernel.org/u-boot/20241119073048.3469260-1-qui=
c_varada@quicinc.com/

Have you put this through CI
https://docs.u-boot.org/en/latest/develop/ci_testing.html or manually
run the filesystem tests locally? It would also be good to know that CI
does pass since I saw some divides and modulos in there and knowing we
don't run in to the cases where that needs to be a shift or use a helper
macro now would be good. Thanks.

--=20
Tom

--yhZl+UcNKJftXPL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXI7ywAKCRAr4qD1Cr/k
CrhnAQDdg5FhB2qC09f4Pv1jkjUX5l9ePbwbvRO3zugEV+ECqQD+K9oeD26FVxUk
lXzbq26zAi4rqUzH6/2sW0A5h7QyxQU=
=s8mW
-----END PGP SIGNATURE-----

--yhZl+UcNKJftXPL5--
