Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF3AC4707B
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 21:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EFAF8783B;
	Tue,  9 Jan 2024 22:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IZrx8S50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F05B8786F; Tue,  9 Jan 2024 22:42:28 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C58C876F6
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 22:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4283cd9bd87so25831901cf.3
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 13:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704836543; x=1705441343; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7ydAiPR1ewsYNkz1FtOSGzAnPYBYaEebqJvOeyzl/6A=;
 b=IZrx8S50giE3xggFfWENQjmxJXE8VwRkAkYXSBEnVJbneGznelm0+1uuCsuvUXf+M9
 /zGEXRnCBiHBygQ4GzE2F7KMdoCR6QrYIXab3GV1Gq5y2esm58ACRWh4hVfAovKD2qc+
 s8/n4ke/ACq3gbIs/Nc++Ku7YiAifi+kcMnIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704836543; x=1705441343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ydAiPR1ewsYNkz1FtOSGzAnPYBYaEebqJvOeyzl/6A=;
 b=kY3qZS5qmankcuKgay5RfHppiSCqXuSWi7mhYIhylA+PeN6eDtDpWl6z4ajSOtZ+Pf
 TIZA75+3FDPajbWuw9pGGPF44r5QxmN+Dkceyy/7LCMCNy2xIvoY3VlNy2pbSDSeiQW1
 uo8fpvAqAouR+Lc7r9qbKw4N9X2hMR3dezxGp2zLJIAlHY+wWUSAywLh2Gsz1SfOJwoz
 Uw1ByjsPKX4liphirj3E63nT0x2YFIMyOZ1VzJ23nZZLJwZKg4xC7dD4GiKzLl56BBXI
 cfrXkmDL/rSnv0UTWClVGxfiJ8RDjrJxlBxOrnHvdead5XWnDIah/DrTDOsZ5tIgvRSE
 QX6Q==
X-Gm-Message-State: AOJu0YzCuV/Ob1FDwscYtBEco1PQK5I3sUgbq6C1sOB1E9wcJgpJt5P3
 A70oFzV0gNLVlbjAbKdPMpkGqL1BPg3PdA==
X-Google-Smtp-Source: AGHT+IFQi+9ndd2hBkZn1R7uB970PpAQwJaH53adeRTpR8hBEt2LeXKY8tJ0fLfr3hYWwbRuNqX6uA==
X-Received: by 2002:a05:6214:2681:b0:680:c838:5cd8 with SMTP id
 gm1-20020a056214268100b00680c8385cd8mr193486qvb.7.1704836543363; 
 Tue, 09 Jan 2024 13:42:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 r15-20020a0cf80f000000b00680d1d5a20dsm1215582qvn.18.2024.01.09.13.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 13:42:22 -0800 (PST)
Date: Tue, 9 Jan 2024 16:42:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: Pull request smbios-2024-04-rc1
Message-ID: <20240109214221.GA1610741@bill-the-cat>
References: <10da4396-501b-4ab4-bd88-3d6c5b152017@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wOco1PtRYfc4+S1T"
Content-Disposition: inline
In-Reply-To: <10da4396-501b-4ab4-bd88-3d6c5b152017@gmx.de>
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


--wOco1PtRYfc4+S1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 06:09:12PM +0100, Heinrich Schuchardt wrote:

> The following changes since commit c5e461fbf7cc72f0c1c8a79226b6a5170e56cb=
4d:
>=20
>   Merge tag 'u-boot-imx-master-20240108' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-01-08 13:39:43
> -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/smbios-2024-04-rc1
>=20
> for you to fetch changes up to 8aec7031112eba0dbfc8f23f9be11c081ea5cc56:
>=20
>   efi_loader: provide tool to dump SMBIOS table (2024-01-09 10:09:15 +010=
0)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--wOco1PtRYfc4+S1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdvbYACgkQFHw5/5Y0
tyy2eAv+LciqHOgJK8mpcXYfzR0a+uy7ouBhO/mlq6YcMFFM5mSvJ47cM/Rt0JlQ
JokZ742fvHLszuYacpCfye5Bh++8Wn1+JJeX+qdFswWGtd2qfJrTNBCB0+iI+j0y
Diq3eh2GZUo6+x4KMZiCbVCYUOuwmbZLleroeCXl8LBmB28lZgoBVj46Tmlp0Pdl
sn47aKq2W/JDOZjDle6M5+j904jj1lpm7Y/IGcSbZR3KI/tUG5iEixRUhQycINOr
nRwYTVVoFf4/OJXB6LNHXfiHmXcSaOVm74o6rGLQZMRfqHO1QS0h8y6YOh9Cwzq+
Rt6Bp5XE6RvbGBHypsYnqZVgrxNwbqrHnEcEXuqAPWrSHSkrKEIlkk7bxq0wq7s2
HDnWRtwB4tZMANaCa0N7Fklxe3Sqpm3u5mCl0k2SHtbC0K6SpfY1wEdZ0OjQM/rN
TptYQRsGmTvhDJZkZtGRqFbfRwJrbJ1QEhYGaA+IGy8tqR1jcpi6Xj4tnniQmNsl
UW8NB7Lt
=xlio
-----END PGP SIGNATURE-----

--wOco1PtRYfc4+S1T--
