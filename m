Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF95C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDFD81D8C;
	Wed, 12 Mar 2025 19:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UF5kmBvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07822807D7; Wed, 12 Mar 2025 19:23:48 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE6E81B52
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6e8ec399427so1539956d6.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741803824; x=1742408624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tx1phm12DKqC444/oH7a3WmPpXqENrXany7OV9ZzhuI=;
 b=UF5kmBvUbVmF94vyIpg4Y0LCexDxLsW60kpmSTr/PKI5/z57yrmKS/J2DN/NaVKNwb
 /R60nk9anMndkWl1Aep/HUbDk57573RBQEF33+NLD9MWO1Tg67YLIfCzm+g5T9KlO6tW
 LcNuGL9fS1eJv/m1X3G2TybgJZpIH6XnFFL2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803824; x=1742408624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tx1phm12DKqC444/oH7a3WmPpXqENrXany7OV9ZzhuI=;
 b=sclPrcCZH/zRF7nAwZBi/1BfZ5fLJE3kwAOPMTCO6gsGmZKMjUyW6yCZR1nn9bZqK+
 LVZgjz7+odCtoYtiXMrbOHcX5Hj0H7CVWP6sJizryqIrYUkRyk/3fp/QIkVOcIqY77Lg
 qREUy7hYx+3sLwukw5i685oetPN3lyR7JiM/qaNcTo66ydqvnzYGbu0a04/LxSIUwuR/
 mwSNrkRQGykI9QU8EywXbDr8H+/0ASWSxTnOcCqedMzqvqsRe7K1aYjnSHAo2QpH4wa6
 ZzInAqEMUVnExsW09Wz3TiOjTVDvc5nOqz1DGeItIHZULxDxgpuS1iTaQLB79QOmz4V7
 vc3w==
X-Gm-Message-State: AOJu0YwNwpTYzMctZxIrGar2o3mlFOk7N/WRsN+YT/ks8Ks7dCx7Owq+
 jCqfuC6srcngiwywV00BNUOWQlWrHm8uHxexTVUKJY2OCrvZbUSh9paZkbsX0Ok=
X-Gm-Gg: ASbGncsbOzmgwM/gniQAzkaV7yHWxgx6sgYKQIMO9pkPVjwYY3g/+ARvOrTnX4jDGoe
 Y6B/uxhQm60unN5rts1cwaBf78NB/cbC2rueAetxrZt782j9q4r58+nY/aZBDg8cPuc18xbvT3b
 VWCGMcJyusfgpQadHmI95nk/sotRZ+vmHjJPEEChM/ww/6AwDXbbWp3B8IT0WEHIxbV3FSC4G0u
 IeBQ32AmzVP4tVmUQF+302SBAiNzhr5DiA0p1BrpnsK2qA48FEWU40xflU/fK3YuQjxDA8Im7Km
 jrf6AmCv4epoPXWDJD1WaRtHjVoZ3pRFf4WM2DB09R046Q==
X-Google-Smtp-Source: AGHT+IHNWAK6zOQ9dSgWKLpa2/51O96hBhd9Cvt2BfH4X+EUXMZAPj9J32FclorpZnwxRUopqxZlYg==
X-Received: by 2002:ad4:5f85:0:b0:6e8:f8ef:d659 with SMTP id
 6a1803df08f44-6e9005d80eemr317223436d6.10.1741803824437; 
 Wed, 12 Mar 2025 11:23:44 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b6ebsm87558566d6.87.2025.03.12.11.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:23:43 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:23:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-tegra staging
Message-ID: <20250312182341.GY2640854@bill-the-cat>
References: <20250312125452.53671-1-clamor95@gmail.com>
 <20250312181620.GW2640854@bill-the-cat>
 <CAPVz0n0jGtmV7tN5VhxiMNQYRauNV9pCTL9WLE=Jnv8+D8c6jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dM6qrM3/XTrSMArq"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0jGtmV7tN5VhxiMNQYRauNV9pCTL9WLE=Jnv8+D8c6jw@mail.gmail.com>
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


--dM6qrM3/XTrSMArq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 08:22:26PM +0200, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 12 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 20:16 To=
m Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Mar 12, 2025 at 02:54:50PM +0200, Svyatoslav Ryhel wrote:
> > > Dear Tom,
> > >
> > > The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ff=
df71ca:
> > >
> > >   Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> > >
> > > for you to fetch changes up to b156a1171e356f16aac88322b3bdcec071543c=
6c:
> > >
> > >   configs: qc750: add 3 second delay before power off (2025-03-11 19:=
47:07 +0200)
> > >
> > > ----------------------------------------------------------------
> > > Jonas Schw=C3=B6bel (2):
> > >       common: edid: update timing selection logic
> >
> > One thing I would like to see as a future clean-up is if we can go back
> > to the old method as a compile time option, if that's reasonable? It's
> > adding about 10KiB worth of table the way it is today. Thanks.
> >
>=20
> It should be possible to add a config option to guard standard timings
> and enable them only for devices which need them. Will this be an
> acceptable solution?

Yes, thanks.

--=20
Tom

--dM6qrM3/XTrSMArq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfR0S0ACgkQFHw5/5Y0
tywvIgv+I3lAm2QhYY0SRSjFaI1okTI9/vLTI5SajWzNNUyY33ifRoJGTdO1ftBG
d6vyFyRQtu2iMKf993BMG1NKtSYcu4hlBfauCAmuLc83ttuyDsDuWmSdHFFQZiUx
flBwju+p/v7E4ah5VMbC+cxQnzQ27mIewX0FNL5eQh0rWrhV3xmxBNS+72K7NXH0
2ilV6oWggub9oald/ERyywDSltWM3VtxFFXnXtDtMzRQ3lqC+hIMjMLG+PDrG/Ry
fI9vFzxXnuQ1/3IP8b89jGu7PFTpICvYna4Tii+bM0gVlIMgS+2RHs9ccWQ7YzK8
CWXPkxOew1omIzSddmYqO3s35HTZTUpv9pDm54qjjY2xB1FLj1v56iO/7EW00C4e
2XauysayDznmPqti1flLafbWK+UrCaXGTFk94mpOg+2CChuKHLgAzmc6ssxky4Qp
c50RJGgCP39Saig9suMtZONe25DonNS5Tb9xnIRYLxs1naDCtgEkaPvvftwx8SkP
mE1rPget
=xjvf
-----END PGP SIGNATURE-----

--dM6qrM3/XTrSMArq--
