Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B81D3DEA9
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1C888DF3;
	Fri, 18 Oct 2024 20:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VUquIIpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BCC688A0A; Fri, 18 Oct 2024 20:33:09 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D4B88E51
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3e5c9295f3aso941274b6e.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729276384; x=1729881184; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fHZQ2K67/kkjvQQbRO+qHTDt+0oyd4Qrsgbqhz8Ln0U=;
 b=VUquIIpV2Gb7zgJRNL8CNMspW22zPyZxDaPXbhcKtXzz+gDvRcBG9XNtnZGv7d80Tx
 An/NEgRfdp0t5qoFl6WwQ2pXQgEA7DIKkmeimTc7NfXqh+ER4nLSwDYAVj+TYP3dt21L
 IZSHhJxCV547C836NoS7MopcJZ1UYBEZc7TRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729276384; x=1729881184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHZQ2K67/kkjvQQbRO+qHTDt+0oyd4Qrsgbqhz8Ln0U=;
 b=eDodp6eZxeakCawwBQ+W/kEXuaw3RwS2YXmA/DgIl4pnRogCJFgBTxBQJXGtcHd2IP
 n1rvsbafQaD/UGH7vgoidYE08uG2PBO1eHG4ivsb4ZmYhy/+luqEJQpAfeiYrJeursgL
 sLy6db8ou5bw5Ek9AB0fRYH4wFUZXqIh1loTW7mSzT0XjTwh2i21wVDnShh3xg/5hec1
 3OA1yxZPnBeO73XD7z5TcU42EQkI7C1Oib3L4xP6Wjxk4tCODL7Uun5qmv1J3h+SFoI3
 z3yQJaOrkPWHDy0QdIRQyCETbkGXumKfTNNF2Jg5IvWG6SDe6MuwFLSph2UWzL7JLU1Z
 Ff9Q==
X-Gm-Message-State: AOJu0YzgXBjUoF9M4LyxBWmDpVAqshLIoGa8GfF9gM2YMOfcUaNV6v64
 K5p6krsUX2jQwfVQPgWs3rpRwJuUnFbDZjD9UcwDfNK0eqk78isrbDcJefMHoXbvyNCNcEwSGIu
 l+k0=
X-Google-Smtp-Source: AGHT+IFbsiKpVq9gndhlfKXFeJaZEHmmzuVdIyn/4JMTxiXRq2KRzEIjsjqW/zpq4m8/9GNPPvDeeQ==
X-Received: by 2002:a05:6808:191c:b0:3e5:fd5a:c39b with SMTP id
 5614622812f47-3e602c64e79mr3207464b6e.4.1729276383991; 
 Fri, 18 Oct 2024 11:33:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460ae9485b9sm9562691cf.18.2024.10.18.11.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:33:03 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:33:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL v2] Please pull u-boot-imx-master-20241018a
Message-ID: <20241018183300.GH4959@bill-the-cat>
References: <20241018130006.257215-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oraaq9KLxUyEDwd+"
Content-Disposition: inline
In-Reply-To: <20241018130006.257215-1-festevam@gmail.com>
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


--Oraaq9KLxUyEDwd+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 10:00:06AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 608a31bdec6284ad6f821226e4c62c9cd30528=
74:
>=20
>   Merge patch series "Introduce the lwIP network stack" (2024-10-16 11:11=
:57 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241018a
>=20
> for you to fetch changes up to 9b1cecdd9b6eaf22c4fa268430669ceff0c48786:
>=20
>   cpu: imx8_cpu: Avoid revision to corrupt device tree (2024-10-18 09:41:=
09 -0300)
>=20
> u-boot-imx-master-20241018a

Applied to u-boot/master, thanks!

--=20
Tom

--Oraaq9KLxUyEDwd+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSqdwACgkQFHw5/5Y0
tyy1Bgv2J/cVfN1v2yxcstDtv/6GcQh3PU89iwX/LprJ8AXi8M4/Ie4+FGAGUgAQ
R2lIppbQUnQMPU8JCW/FqM7duqCfm5+uT6mnlmQ/4mbPzTK+hlVQll+NfSPAh4qk
jzvlGaaLkf/AwT2gU7JRrch3PgDUEkVntp5O6u01LjFhfYAsPOMoJyO74MKgUE9/
LbdI34yqweZv68I5cwuJ//cFex+WPrewrvPU6MvCMk4s/U/VeCpfuLCmpwC2qMk7
IEDz9hox14KkmaV5HEqFdW2+RuG1hc8Z/NtbCMtWe/k7+IwxO+NydY++f41BbyCa
2mdgBazj/ZN6SLPwnrzGzm+AeRKMnwSnZnDIIE89I4qhJkBdVrIhGn+y+OVAVrdF
liXphrkRyLrMzC6jFS8zcf+Ju9YjxokggxFWgK8oulT1a5o1IrWlBznXT0YhiIoH
CMuNar3kJFdmPcSxrNrVcRWm/tKY3BaiQCdEo+PAHpLiiV1b46TNr178tT9FjR74
zIVkJRw=
=sIBP
-----END PGP SIGNATURE-----

--Oraaq9KLxUyEDwd+--
