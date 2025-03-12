Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D48AC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C7778141D;
	Wed, 12 Mar 2025 19:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qprkz7+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A312A8056A; Wed, 12 Mar 2025 19:16:28 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D23F8141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6e8fc176825so1832546d6.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741803385; x=1742408185; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=78mmLTetGX7XrvtH2oH/cyC9+49TR1ikX6P8X2In3AY=;
 b=Qprkz7+DFoj/mVkhUBXsoZgdcmD6/CCByLCGDcb2KkQOfCoQHuYQSXWramfPFwpDrY
 ZjiBf34pJHYIqe0cSyAoFfq1uBXabuFDKZEkR3vi+jsG0n2X4fpvAVVAZDORfysvKLIp
 4XLjmF2/ZQEUZu3nj/eVEWbAhsvqq9XkE6h8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803385; x=1742408185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78mmLTetGX7XrvtH2oH/cyC9+49TR1ikX6P8X2In3AY=;
 b=IBdlhRGv9THB/wXjWsyz0EyPjiO4Kc7bI5iUJSikamdd3dZgkV7ZVaNKFcrpzb2zxE
 r8bZUHSFYCPHcMqDpURbZ0/IJyKbGcLAaMip6K3Y3BrGhtQozvjPtN/XCR+cLt7yaAv7
 lJE07J+GOSJVJLZ5lDN+2tEJ6Sa7WPZbLZpnxvtDMG+tngLmB2yHCfAdrmMXnNoRrycW
 DhEsgEPOj1uznYrTc6OwaISerN0gCVQck85266vNa/t0ryiZ7SHL6v4iz7frP2jfy8Ge
 diEadbWjsa2CkZNBsxWJPqylm5IVGRbcFGMcHBZ7A+uqxfUwfC4GwAQT0HZh3rn15F08
 sEhw==
X-Gm-Message-State: AOJu0Yxh1ynZEZVNv2qBcKAjs3eHIzYC2eBd1ckp2kso5vtp4YxnpHpV
 XDkNjf6RdLOAtz1HxuiaNsx24+bSkdbUu23sUgxOx7AQ+qvW9Kh7jqzv2FhDMVFHoOEb5G1JNFn
 y
X-Gm-Gg: ASbGncskk8B+QR4qZGLRNcFnGVNTN5MVD8kqjZXxzX61JhkndyiPJkWxZbRyIRgPwdF
 9tzW9GSFGt61o5nsUSpdyyO3cMH0HGcFb2gFKrBkS1Zn8WbWpEY92q5nw77iIFI119FAtQJXSwm
 6u8MywWyo6LX9sxK9GCROiTjkXq+2lewWwyuE0qfUQQ6ouHFZPFbCODG0JY0YK+6fXNzkxE6ZIH
 vJcUu01PMy/DmApehmRxKA3o92hWtc0yEEAucrlfX8DFnvHPopSXnVVRnf/qJj1JflDkOGSgqya
 T0iDWI0/4irRqisyAiEwkcs4iVrYQ/HYBWfCNd6XwSWbSw==
X-Google-Smtp-Source: AGHT+IFdoccepp9HkyIJEbSl1x6AjtTSYCETFC7s8GCsFFhqLBLxH796acIZDiIFj1o1RyoIW0ZLzg==
X-Received: by 2002:a05:6214:410f:b0:6e6:6b5b:e559 with SMTP id
 6a1803df08f44-6ea3a698657mr143498776d6.34.1741803384012; 
 Wed, 12 Mar 2025 11:16:24 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f707c514sm88168096d6.24.2025.03.12.11.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:16:23 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:16:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-tegra staging
Message-ID: <20250312181620.GW2640854@bill-the-cat>
References: <20250312125452.53671-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cDo9CZNHGoQxJnwv"
Content-Disposition: inline
In-Reply-To: <20250312125452.53671-1-clamor95@gmail.com>
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


--cDo9CZNHGoQxJnwv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 02:54:50PM +0200, Svyatoslav Ryhel wrote:
> Dear Tom,
>=20
> The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71=
ca:
>=20
>   Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
>=20
> for you to fetch changes up to b156a1171e356f16aac88322b3bdcec071543c6c:
>=20
>   configs: qc750: add 3 second delay before power off (2025-03-11 19:47:0=
7 +0200)
>=20
> ----------------------------------------------------------------
> Jonas Schw=F6bel (2):
>       common: edid: update timing selection logic

One thing I would like to see as a future clean-up is if we can go back
to the old method as a compile time option, if that's reasonable? It's
adding about 10KiB worth of table the way it is today. Thanks.

--=20
Tom

--cDo9CZNHGoQxJnwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfRz3EACgkQFHw5/5Y0
tyzWUQwAngBpjfUxSscf+rVofmflHbwTS3obfoh4Q6NitHOBq6NUNNHBfVjP+8Ph
bsamQweIkIoUMzIsnzMmE2RML5eNnDEEuWLLvJ+f0BfZx00vOrPwlGKtX0sRNMt0
6q2zBEZBPqxjMKZ1cGikxPPSiq0RMhjj2jla8BZPqLw2R8ckceqTcD18Wx2rGhst
nyGc0HchEce0Z3WcYaeyihstBtesBA13pCae99pIc6LNo0/Ctk/HurgXL+k2p8K/
POFnTGhOgGKm32K5AyzPamlc5W7lcp6JThJQ/tLowbwrMzd4VhdQ2P9pUR/6VjhB
zrELzqpts7eaSJfm0HJUDLaLK9ZcfiRN6TtWT5AyH2TzuHpwJl3ykU0+Jtf0Vx86
i2ucrVcYs02P6D9bbgsoT/g9yCPHk32qvOyisn3jH0zwxpwkACpqnt7Pyz+7SeAB
iC8OcV6La3Uz6EyvCe6JrpeT906lYE8CxhbJ2uzvvTkyrKx83eIlXI9bua+qprRz
HifLrRjE
=vAJ7
-----END PGP SIGNATURE-----

--cDo9CZNHGoQxJnwv--
