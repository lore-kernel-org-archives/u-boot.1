Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C96C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 16:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566C5816AB;
	Mon, 10 Mar 2025 17:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="awsSK9Mf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E16E8169D; Mon, 10 Mar 2025 17:11:24 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF6881703
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 17:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22401f4d35aso79052125ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741623080; x=1742227880; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qlPvWOmXyj3f4R1jQsQHgiImxj3aINKxR6PMDN6S9WE=;
 b=awsSK9MfV1Bo32QIP5NAzMjGFWaudFMJ3kINA5AC+zNbNf9rZzASywJp0llKPS2c+H
 5KOqpwSsGzC88HRfLzMbisFSa8yI05qTy9vOipxxU2YLdv78R2a3xcyojY/f+9ZX51tN
 gYZ7xl8Up+Hf+yMuWZPotbPG93p0lzXkOSYhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741623080; x=1742227880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlPvWOmXyj3f4R1jQsQHgiImxj3aINKxR6PMDN6S9WE=;
 b=VZS/5YFcT4oHAN7a0SeBZBXl8adui4IWTF+O4fVfYKHFtsmOdLywnwZ6Cy2dWiiBdM
 D7wuTJ0bfeJXcvBSh3j/DplzS5nRQyyUb24/NKXMYaxrqSf952A5q+Zjoe5F7yDVLTKt
 65w30YKEWuQluHX/HEbnCzUHGBVMDDYIrAjEJ9dqBubleXHpfP5O1BxSgpTtd1VYWtkl
 4fIbX5vZUSZGQr0bUuWYmuh3YjNz/jgGte4Cg3IIGx36NHWd43anYCI8rdqPvQKcqnfx
 cAyIeKZsE2TS3iBwLxRQWDZ4v21tD7A3UXtKIwtgbSLNE7c+ivJC7wdzQVnNz/qSVw98
 He3Q==
X-Gm-Message-State: AOJu0YwZofwHs6odQ/hgmEu0H6CZR5GnSR7OqBrOeRwFgU7VuQ8FevKF
 OVbDLwWr0FevFrl192bgPbPkqpxddLDW2Li3vuZU7pWMQ6gw0upUi89+aO8GyjQ=
X-Gm-Gg: ASbGncvbAWdsiQDeulYpVX5loc6ta8v/lWKL9KgBUnjtb09yuBRHPJctj8R2m23r/pj
 q+LLikwqvIiHSvKINtNevWadFImbV/6orARDm8zyW8ahar+oFOR6UxQSmTnODfYiWsJDgJUwib7
 zGQH9OxA26Eg0N2l2KgrFIg4ZWeB1aAOVcxw3W44bdhzVB6aq9TRI5oEItZXIwgL/9TjDpfvKXm
 Wxrd87QB+e48q51by01lF6suhgCu7X56B3ZHISG7YMhcfsB4NoIZVuFTyDO/AKPsQk8pq5k5eo/
 UWZpaVgQF2hAVJjRkdIFGwJrl8akmebv3nMrxMuterjDPQ==
X-Google-Smtp-Source: AGHT+IHpnJSg5m7BOMVdY2criy5I8ZYVDMHlEwVisYOIDQ3QMzoJVs3nwz3dcxsgATeS8R/3ixBgYA==
X-Received: by 2002:a05:6a00:4b14:b0:736:34ff:be7 with SMTP id
 d2e1a72fcca58-736eb87c863mr564057b3a.15.1741623080266; 
 Mon, 10 Mar 2025 09:11:20 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736c46410e9sm4326766b3a.20.2025.03.10.09.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 09:11:19 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:11:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] Pull request for u-boot master / v2025.04 =
 u-boot-stm32-20250310
Message-ID: <20250310161117.GL2640854@bill-the-cat>
References: <d526bd4d-efa6-423f-81b5-1da9a5c9af98@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K/bOwRu14aJVnPNh"
Content-Disposition: inline
In-Reply-To: <d526bd4d-efa6-423f-81b5-1da9a5c9af98@foss.st.com>
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


--K/bOwRu14aJVnPNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 01:21:27PM +0100, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related patches for u-boot/master, v2025.04 =3D u-b=
oot-stm32-20250310
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/25054
>=20
> Thanks
> Patrice
>=20
>=20
> The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71=
ca:
>=20
>   Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git u-boot-stm32-20=
250310
>=20
> for you to fetch changes up to f5ee0f2bf7b008dc92315c10239e8d537877c0de:
>=20
>   ARM: stm32mp: Fix dram_bank_mmu_setup() for ram_top=3D0 (2025-03-10 09:=
39:30 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--K/bOwRu14aJVnPNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPDxoACgkQFHw5/5Y0
tyzOzAv/X+m9j9UDc59nfnsPCW12nFvTQsOuuZ21GEjhyndaRBArC6bC6uABTp+m
ayviSCH/tcquAGd6xTY6GZbFIzeMoycQFEocR2Va+QbKZocZwHRJTRZAe0UZhqhX
VJn46chf+ugjL76t9E/Pix9n+EPRaI8Gl5n5aA0/ub6ss0Ybh6fWxz0/rBpksaCZ
PQ2ujAT5XKqc4sE0IfW8o6HWmxso/5oH+XjrUgDxCNcprFYe9E6QPva3FS+InUv+
7ME4IuIX53lvYTBRCtyR+IgGsaNkmhJn3JmMPPPmqziDFd6AwbFw+wJPmIpg0Pr6
i0IXe8fBy0ATJcnrQIDCeaEKtJCLtvCJAUdCJVFVGaH3loPU9lmMqCdgJs63QNQt
BMFFmOale3fFvlv5Ax8wUmgcfgqkah9pMzFE2Lu2pkRdoOTFAG/fwTVu6hJA9udH
DWqrLvT81/Ex2ozvOi9zWRdV1cWvFCeSBIl+a9ZGoVQRlu5zxUDV6RWMRhA6/4EB
fFPsiQul
=ZTRh
-----END PGP SIGNATURE-----

--K/bOwRu14aJVnPNh--
