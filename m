Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B71BC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 16:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0CFE82054;
	Thu,  3 Apr 2025 18:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kYDrlZjr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C33582075; Thu,  3 Apr 2025 18:10:49 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC27382006
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 18:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c7336ed99so379253a34.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743696645; x=1744301445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J7vkZ2+62h7/gKbQcNBccxHvpPOk7QXj+nlW43dUgmQ=;
 b=kYDrlZjr/jzoq39iD8ZovM3NiUJMdTSf9znl1tv+UpW/bpGd1QPmZcT7AR52zhF5Ll
 heu6vvtlCO82GzJEpzzluxnEFWJUSlQprJ7OKLmjefc7cGaAVfX8UKiQBe2RwrfxR+Qh
 xdia6/t9pxK3CmNxx4v6jpzZ4nQc3Qzb2/fMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743696645; x=1744301445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7vkZ2+62h7/gKbQcNBccxHvpPOk7QXj+nlW43dUgmQ=;
 b=bVOHO3ZX9SGkFPCGDbcBWCKpTXIQNgu9GivJpBz7azJUbVMBLIpgyZbejmDgyzK2NZ
 vc71VOSKSkhQ4fca8GabtpzWzv6uthBFSUIS91nMjAPea+F2Bo7i+2F2u0vzLT9qHTG8
 xbdWbjjevZ6ERJa1TfJpjIrvKcNaTX6vDzdMfoxDXiOVdHhAMIpv9SUWkWPrCOt63Qft
 sxLzUaAr7Ko4krOuAbih3DlNdNvIopS8SZDQDGQsWgLRZe6Y1HE+cyGkLw2JlRMo2nfK
 hKhvOGrQJLMBfJQ4ENlb3KMXuf3epdldy6pNntdh4j+/pF8jEWSv61E+6UnrdUZBhf11
 p8NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYoWxD/AvhuNj4f2PsuhfowCo8HkrfkRnlk/VtrY3M36LXQ37Ozwitt3wfzp40SaPU6fHFZyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6nVNZ/hDDsQOHk1A5NtrcdjIvWyH4EM6OIa3Bsky04MDSTBC3
 yPcZvC7U+m61tevL58nO9Pmfzptf19s1ZlMiYLwoSsYpoRzYxaLHr7WkcTlbBy4=
X-Gm-Gg: ASbGncuU0S9v9vFFDUNWH8h8pyE/f+ktePdw4dO8cz7WFUQ2EdvXC1YDJUeUeX6bDYL
 I8tNkif/z6e7kCM7d+bCEXGJdC3IZ15+h/lPlax3tfO6lm3jRMAc8TtvV8OT8UnHBdlf8pV6TY/
 lQf3a3tRZ0GjbVpmdwLqvCZ3KERppIQKcbkLDRBkQGTYY1uAB+hGFzZ0yffRodjiYlcFa3OFyUF
 DYlljGVTmW8TRKYTLw8gHj7endARGxxz98SgzEFLGHdpkujkDq15WfiWTCoUJDuzgoCkFpQekfx
 pBJH9SEORLE+7Wtc8YYVdrVpKoAj7Ev2HvxrNvZAeC12D0Hs8qUlhoMAVQ+B37uRSXWdNoO5Iy/
 zN2woVzUmT/Ctv4ok
X-Google-Smtp-Source: AGHT+IGTge+n04M2oKvjQat1qe7x7zAjWviJA1KIHPl0Je2ojk3OuLZJROkY86KlLjwvEm3ZiagOUQ==
X-Received: by 2002:a05:6830:6418:b0:72b:89ca:5120 with SMTP id
 46e09a7af769-72e366cfb40mr122313a34.8.1743696645365; 
 Thu, 03 Apr 2025 09:10:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4ccf84sm316679eaf.13.2025.04.03.09.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 09:10:44 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:10:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, u-boot@lists.denx.de
Subject: Re: Pull request efi-2025-04-rc6
Message-ID: <20250403161042.GK5495@bill-the-cat>
References: <983e05cd-e172-4658-b6f8-54a9b55330e5@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VMVg7ynvUaNdmecK"
Content-Disposition: inline
In-Reply-To: <983e05cd-e172-4658-b6f8-54a9b55330e5@gmx.de>
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


--VMVg7ynvUaNdmecK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 10:32:38AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> These are all documentation fixes except for an obvious bug when passing
> ACPI tables from QEMU to the operating system as EFI configuration table
> where the table end was not correctly determined.
>=20
> The following changes since commit c17f03a7e93dfbbe5d32f5738274187065d949=
3f:
>=20
>   Merge tag 'net-20250314' of
> https://source.denx.de/u-boot/custodians/u-boot-net (2025-03-31 07:39:36
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-04-rc6
>=20
> for you to fetch changes up to 7871285a0a8fb6726ea7537c4f592e117f93768b:
>=20
>   doc: Fix typo bootfloe to bootflow (2025-04-03 09:06:51 +0200)
>=20
> Gitlab CI showed no issue:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/25491
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--VMVg7ynvUaNdmecK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfusv4ACgkQFHw5/5Y0
tyxAAwv8DT52IxYljnawF5YaouXQRXPBGgKYAji/Ch7wgro9ov0fm+ckZwnC0O06
owYg7jEB+RuFL6zXbbnAlAzf7XsnvcKX0Ssg8gS+W+5K/H8i+Irlod2scclA6WDR
/uFkUUVybDm1BQAEkYmb1pq0ZRXUEBOHORzzXu9h7ZKmxr0+v4xvul1RjCHNP/uL
tbOzeFdxj+nLFp0FRGVatVYyPnnMUUPlsGEUZB6OhWaa6XyjeZe0Eb2J/t6+0wBp
8opLwfY71uqvWMmQT2JD8Qw6AmQmXOKNS4h0eukjZNwuXf8xreTEDT1F9pqNJbth
lyAhEhzGeJc4YUHSTdEy1kLRjEdjC4kSdRJi610aI/wjpweyoBgo+c5bCSCslZHV
BC2p8dcvBkc/80VTGjQ9RN1RKj021ySwZkWitfFGbBXKHHjJmeUpLuTeuhRv2s9v
CBQW7m+cAj3lKd0w7BqQ6QEKabkwfWEMG/rXvSH04TYemA0WnYUV2cHagHYF7YS/
MYhQoAnG
=IfFX
-----END PGP SIGNATURE-----

--VMVg7ynvUaNdmecK--
