Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC6BC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D23587100;
	Wed, 25 Oct 2023 01:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G9CvF2IV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C9286FB9; Wed, 25 Oct 2023 01:16:10 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCACD87100
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7d9d357faso50766647b3.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189359; x=1698794159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bJs9LdnKoJkUkxfA71IB6JB+Ecz99JY+F6jMcYwKYPY=;
 b=G9CvF2IVHfvXlm6rqdfxOQXaktjS1vSU89nta7H1IeB+LV77K5gcxLCFIeYVgEg6Ds
 epi0hLoL06fNMzPgbazzfYgNE9lVqD+/dPPNXdK71ztoqdw7V2+a0NWX0GfjyP/pmHaS
 NlDRXieijEfR9GdRZkIuzTu6E4nECF3jmX/ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189359; x=1698794159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJs9LdnKoJkUkxfA71IB6JB+Ecz99JY+F6jMcYwKYPY=;
 b=p2q8lWEQRtqOIwETTlobzjXv+ij9IsI6AMHBj5o6Vqdr5wAWib94VCe7fnULUQYvto
 fPJoDSZien1TPoez/GJ3DnBlkEPiFqAB5A5bpPvQTsJHOESksazFcSrMzrTUjI9zuT7T
 H8TbX/bCVxJrkK+wu4Gul4FAh2FSq6kcHDg5eeVj8YTUsZt5+KeQfhQoYCpse/XMobH+
 kbz3cvXXkdlGAH3qy5+dwU1bvagIFkcDO8eUJ7pHQ33znro3uKWd/YGV00/V7BG2QaMG
 P/mk1pVSX8coFf/z0fX7zP3cbdCZDZsfkANYgmdvrMEsFkBEi9nqjUsV6p1fIGfZ3ZCk
 JkgA==
X-Gm-Message-State: AOJu0YzC+jNI8qtDSFYxSVRYddbxHoLtcZ/iX+lj/VQ9D9ng4lWe2VmG
 hihNAWD2rvN8I1+H268+Woz7Go/8oYhCug3zJU1z6g==
X-Google-Smtp-Source: AGHT+IHD1Qk1HSQjwXOvyppygzB6uPfUpoFDMTGpWE+u7IVTnZHubIzYoNoj6JvjqNbaDMCUMAUJnQ==
X-Received: by 2002:a81:6055:0:b0:5a1:d63f:5371 with SMTP id
 u82-20020a816055000000b005a1d63f5371mr14810999ywb.20.1698189359296; 
 Tue, 24 Oct 2023 16:15:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 m124-20020a0dfc82000000b005463e45458bsm4511489ywf.123.2023.10.24.16.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:15:58 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:15:57 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uboot-snps-arc@synopsys.com
Subject: Re: [PATCH 3/7] arc: Remove common.h usage
Message-ID: <20231024231557.GQ496310@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-3-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qf905hvLZwt8Tc/z"
Content-Disposition: inline
In-Reply-To: <20231012230359.2005249-3-trini@konsulko.com>
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


--Qf905hvLZwt8Tc/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 07:03:55PM -0400, Tom Rini wrote:

> We can remove common.h from most cases of the code here, and only a few
> places need an additional header instead.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Acked-by: Alexey Brodkin <abrodkin@synopsys.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Qf905hvLZwt8Tc/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UCwACgkQFHw5/5Y0
tyyGnAv+ItObPVu4+vhoW5XOxx87uIZLOx1gLTocHbdjmV2ENmuuIihI7rBfxol5
TwzCUKIego5kGnwrm5j4h5rhQJ0ZFCR6WaE9v+FFLuPCddyqiDvm9VZhUeROHFTR
h+hg/PM3ZR6aTtETb4JU6YuyX6x/5G+FPDuAtktR0Tni9cV0tR9lyK1o34ujzav/
Ku5vyO0oFbuhYn8MP/zm2BrcgM+04fu9vBA9994zicIAVUQ0n5lTXX1S9eDiUKEt
PDiDlH3GR+Gzs/Gr9Bq5YgOy219hNNeTVlnmAsocfUEjLmWZsm9zX8TMcElcaqUZ
m0FMmhUMNJTjgM4ia+GOodt9pf+laGgPpN5xoqolYcq8qyxJ8RRxqrc4mbDJl5A4
9lHTL1xMugcbxHz2Yao25gRXhVTcOiSvnXVlR4WxWbACUVG3lwrMzIjoUjQlXgnp
o1Fgkasb5PZqx5jYwjfbv3TTlpygQGKDVRTil6m1XpkZQxMzV2JqWJnGBaN7l6og
IJh8q0Df
=wrwB
-----END PGP SIGNATURE-----

--Qf905hvLZwt8Tc/z--
