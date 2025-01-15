Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106C4C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9305180657;
	Wed, 15 Jan 2025 15:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RyRoF36x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28548060C; Wed, 15 Jan 2025 15:47:40 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85BDA80657
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6f53c12adso539843385a.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736952457; x=1737557257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l/+6u9pH/e97TllxAAAWsF364ivpgNlZTMKrR8IOdmU=;
 b=RyRoF36x/oo3y05aO0Me5oqH2GqSsX2gLxbNcRYPvbGjijVRZzeHnDqaTEo11Iijla
 Iyffb6xpZvq9rcTie2j1NbAeunS4FqqCdGRMgYpZouGazsYl2QlMSo9+1B23zUby0PiQ
 vxYouzi0GynahywMIerBvtizPvC9jvJ1D410I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736952457; x=1737557257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/+6u9pH/e97TllxAAAWsF364ivpgNlZTMKrR8IOdmU=;
 b=v6bks9Lo0Z0IWxR/MNd9mPWvJI9tanogMLNHWaIjpcg6yO88m6+UR0/MPbfhXRz2Cg
 7m2sQJ5wtzi97EN3/7NqNw+PcbhvGD/Vg/52RTWpDqoId78Y5BzpY7j+bW+nEu9rLBTG
 SvZ/XPMKmLXsmj14OOruip1RKcSqpC4cPda8hh1YJOg2ws7VPZL13DJ/l0LmDee+PVQ0
 GMDh0q/WpOjzkyZ40xAqXWpQtzlODkVXQKwycBYdZtdIzFycA4oPyGD5hMBZ9r86J3VF
 UZDAGqdIF20PmH92ou5vTj1co3qZ6sYljuTHM1N6lNAVvsBmuW5iN258EWisBIJM6fcc
 jD5Q==
X-Gm-Message-State: AOJu0YzyvV3ly5wSq45OpPojqCGA+QMgsgpvmd44PjqwDDPBZhJY1XOw
 6pplHK0Cq1e4vg3Vzgcq5kI2l0QvqnhQuhwokA2tcg3hcl5emRsgz1zFzY9dUTYI+7lMBJhkewX
 T
X-Gm-Gg: ASbGncv8iKi5aCxEKNvnBjqvqiDeVmtuL23PKJg6GXoHpXhHsagjIRblgHZQnpwJGiz
 j1ijIzLvMGhsiWsmQW5Z4jjF95UolETGY9jj1FAfGHTq6kIPY159e76gSj+zph49UfiQD2me54A
 PbdPpzNjgNFpXeiWNr/RbmfR85MhI60nRyLTVmM4CRIan3ll8u6h5Y48odH3GOTkQxkZYA3kRZi
 3talhsnb+PJAQaFnV6ujfH+Tq2kwomKXo4tEZVNMK1rrBi3rZusHA==
X-Google-Smtp-Source: AGHT+IGi3iTzN6+Z0HwSoxrwUem5P3i2R+itDMHY/OHjbIKisUoVoR/Cx3pHehVVI+szlhNhnYx1mQ==
X-Received: by 2002:a05:620a:2805:b0:7b6:f595:7550 with SMTP id
 af79cd13be357-7bcd9783e00mr5398730585a.36.1736952457384; 
 Wed, 15 Jan 2025 06:47:37 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3503196sm721857785a.92.2025.01.15.06.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:47:36 -0800 (PST)
Date: Wed, 15 Jan 2025 08:47:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Marek Vasut <marex@denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v4 17/30] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
Message-ID: <20250115144733.GA3476@bill-the-cat>
References: <20250115143700.851043-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cJI4d3doIhbjreE7"
Content-Disposition: inline
In-Reply-To: <20250115143700.851043-18-sjg@chromium.org>
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


--cJI4d3doIhbjreE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 07:36:47AM -0700, Simon Glass wrote:

> QEMU always gets its devicetree from the OF_BOARD mechanism so we should
> not depend on !BLOBLIST here.
>=20
> It's not clear why we need to have any relationship with BLOBLIST so
> let's remove the entire condition.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cJI4d3doIhbjreE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHyoUACgkQFHw5/5Y0
tyx2pwv/ULeHcK0uxl541fgwo1rJeQmXwvinOup7G56ASOUzB+jipMHVUzl4jYlv
9KZGLDbWVnVGFYXC9oCK8eo2GklUVHgs0ecuaRKAC2mBI9TkZY3U1NOznj3uiSdq
4HAr+/AAn0xWPi9xAhF3K2WZ1V3FpFss4H4e7+6wMXOLFOYwA8xz67Cj6OSIrOEV
uqZ6FFYZDnzU570RtKPjkn1DxF21VZy/8FQgOQtc1JGtWIvGYCvoNvKvn25aDpk6
1Y5rQJ0TKsFm6iHcp6qljJ/k+Sjv/dGw5u2cP7GAjYdZUUN5PUwz9+3aCWyuol6P
slQlsVv+snBDPIh3QqWE+OK7nFU0SUzrY/IWKA6sJJTl9QHmtawvSmB5mM0rAP7N
dbBTrCdmhgI/8176sDe9i0+VDeU6ysq1SiWNyYU2wtwWfDf/74orRo2pYzNkrFhd
7n+QXPbCTIIDJuZJDqWsrxByaDBcXLe0EmEmc3EiGoZXOeiyn3iEVbH5XFtqZGnl
rPo++bLs
=M8xc
-----END PGP SIGNATURE-----

--cJI4d3doIhbjreE7--
