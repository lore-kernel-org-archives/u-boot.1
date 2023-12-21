Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9969AC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31FA5877E2;
	Thu, 21 Dec 2023 22:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nO68Dubn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB8E2877D5; Thu, 21 Dec 2023 22:07:26 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB0E877C4
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7812750f665so34975485a.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192843; x=1703797643; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wz9AIXWzrCXOZV69pVnIde+zUvKpVhzaHx7AjBwofR4=;
 b=nO68Dubnv0lZqgzAl34YOSzfA9UplcIjpmI1c+NbA4f0k9SrGKoiW/768or48TSi/B
 fEblOFOIc/l6FtaJLVZ+h+d6re4dje22cjjB1e2ZGFsgYPZ6MRxXLKW9mjLYquj9sPR8
 QcIZvAXrJyrpI3B32gtCgThUwCLU2VLsdLwTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192843; x=1703797643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wz9AIXWzrCXOZV69pVnIde+zUvKpVhzaHx7AjBwofR4=;
 b=gUdY8k4ivHsqq/ZlzJHqMGiLPT6tNx5p5nTAI7DXjYYnrEP7/qrBQY4JfEfyIhnBvU
 0uiDJx7ZLwZmaMVg64t1WJrF6ANra/nBcEVMVjEJu+cyzWNMZipDE9ZyWFObIqZ2c681
 cJBykG9T60MtKFhoqkywnXV8Qcc/+rXXBlUeblhvfETRvFbd1PBSoShcI6bnIAnsl5B0
 eWgvPqMss97XfefqqY0hg7oV5R1+ouGYlvvEoojYSwce08WTuQgyOFOxTYvGjN+gOjyo
 Vl+CDZwxvdSBySHL/G9xhnXC+fNiyh/l1EpWKYRyY8R3wM6YA6/m0b19/BzFhkBySYgv
 w+aw==
X-Gm-Message-State: AOJu0YzIhZwc8IidmZfNvvd9EnEjGsaKG5HLIz1ZaYot4pqoOZLyoFhu
 2FbNYFpEBmudQb+54X8K5lhGziGyskUEmA==
X-Google-Smtp-Source: AGHT+IGgrkQMW5vGpbxFEdclBYoaNx7vHkZSdaoSwcqkKK/W+t/MFJrq/a9e32bdJBCYj4dKUK6giQ==
X-Received: by 2002:a05:6214:413:b0:67f:49e5:9711 with SMTP id
 z19-20020a056214041300b0067f49e59711mr1875963qvx.53.1703192843649; 
 Thu, 21 Dec 2023 13:07:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 dh5-20020ad458c5000000b0067f24bd0afasm870547qvb.101.2023.12.21.13.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:07:23 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] iommu: add qcom-hyp-smmu
Message-ID: <20231221210721.GT2513409@bill-the-cat>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
 <20231211-b4-dwc3-qcom-v1-3-46275113b4f2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mFKkOg8PaR8/YqhH"
Content-Disposition: inline
In-Reply-To: <20231211-b4-dwc3-qcom-v1-3-46275113b4f2@linaro.org>
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


--mFKkOg8PaR8/YqhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 06:41:42PM +0000, Caleb Connolly wrote:

> Add a basic implementation of the ARM SMMU. This driver is intended for
> use on Qualcomm platforms where the SMMU has been configured by a previous
> bootloader, cannot be turned off, and doesn't support BYPASS streams.
> It keeps all existing stream mappings and only creates new ones for stream
> ids that aren't already configured.
>=20
> This driver is necessary to support peripherals that perform DMA which
> weren't configured by the previous stage bootloader (for example USB).
> It works by allocating a context bank using identity mapping (as U-Boot
> doesn't use virtual addresses).
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--mFKkOg8PaR8/YqhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqQkACgkQFHw5/5Y0
tyy+9Qv7BkxwLw/xZcmyQwRPl2qWbJrYOnxQSMmC55Wte/MEvvBd1nOn1xvUPyvW
xKiTIJvlJUT+d/uxKyqaKenG02NiI9ejK+8HugsfY1f7YoSdyq/pHWh/R178efej
fkJRVon7AOHqLHcJl/w/udBDcyVHMHcH8eRwZ08Rk9jpOpT+RxIvg5HPbsLesB1t
OXvhEXrSKw0oRmBLtuNKLmiOXNUWFc37NN3Jxx0rR9ZYcwRi3GmVhd2eq0dM6voO
hhw/Bl5TW3aCgNzy71fYVFKRgs3Tj7LYDEkp3cXUDw2zKNEvkvT2t5vH2hBNwvcd
49EJ1Im6jiiPkr/LHyxWszKgXeq0bf4tz+vg7tq188WUHr4hz45WQqsqddvGhiKc
hPjAF880OYwudXivbSnZpPC58nWQugOBSXTvIYIG1FJWM7vReXyvbXf9E2BL0NHR
08FWZh6E6CyEtIgANRSNM6DTSYFcTuzLyK6LIo1Pj5zXdov7eBczNaNgI5GTuIKC
BmPqNit0
=x+1I
-----END PGP SIGNATURE-----

--mFKkOg8PaR8/YqhH--
