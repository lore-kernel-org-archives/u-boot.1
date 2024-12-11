Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D916E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA768801E7;
	Wed, 11 Dec 2024 23:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XCCAV02w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AC6801E7; Wed, 11 Dec 2024 23:42:31 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA358801FD
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b6f1be1daeso3034685a.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733956948; x=1734561748; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WA35sLv139tJgLz8U/y4jIad87J+AkglUTagH9ZnyCI=;
 b=XCCAV02wkAiIele3ZGbKlKSVLAX4f5yKVec9xWgRJEISk15x7aaq8+7bIXkDt6NDZD
 d5RqfyTjSH6cBTwntTjFzkZ2NWpBJb5wvZq0voCGJdt0x69FLkirfJ9wbpCEfxZLPWqN
 ZUeHtkroxJZaGN2wEiNpXHhfFfJbZo6I+Rqtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956948; x=1734561748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WA35sLv139tJgLz8U/y4jIad87J+AkglUTagH9ZnyCI=;
 b=WglzqadF/lW1tldCnaJN3g5mc5EhzLqQegr1wHBfltdX0upAft5XuuKZzbCQe36w/n
 IzOht7wEZinhJ3iWm2LaqpjejeM0+Uu4IUwnKlYIaDB/YhenmdKbkAfG58u48GPpm/Va
 WVrefQYzF3rIbRNL2tFYKw+hEvykeUQUlG6gYoTRcdk0gNx3/NGYc6Tw1hOwGOD9xZCE
 kC+mwfb/ZR2oF0TCPSDWixLlzCTYaS1BNJBEdZ2YevB+FthlNrEwAEY3HgJNMaUdrXnM
 Aq3GABccLq3wq6NVScxkDTJXMUCyc04diguaU745UJVA4dTYQznGqm/ifIsQTBGdkeKB
 +0AQ==
X-Gm-Message-State: AOJu0YxRGZDrVSrRpbY99nnulcHJ1IOgMPgu9JYvuEi9HtRen6RdOtDS
 sXPIv4TdoVauXEaStqbz89kyirUKL657X+zVw96kIbZ61Geg/cVlad0lfXm8UwC4lsMO7Xc6iLd
 hI3Q=
X-Gm-Gg: ASbGnct/UPV1ZLki5FlY0Nd/DvzDaRnLyufWWOy2LPOB6no3MBL81G6GB+lobhW344i
 OL7Y4p986da2uu1Hv/pIWNCHh6m2DacEDwl6TGW9sRs9R5bXvLuCkMu0KBS0UYVkaxv9bD29mMT
 cwlUO48bCDvE2hG6b89bls/3bmUBkMar8TLMfD//b7rSH0z0zGcRV1jx4E8GD1mUMnKBMHwXtQf
 d8nue50hFMJEGx+WjXM32L+3vbPJkPlfF06emPiyquV9cl3sKPGBQ==
X-Google-Smtp-Source: AGHT+IHq52oWVi7GJ4LmXQNGRVTrwrP8vlpIWIpd1TKpHQ7JNLRRGe0s8QgthvVWSicuXnXd4pmWCg==
X-Received: by 2002:a05:620a:4091:b0:7a9:abee:992 with SMTP id
 af79cd13be357-7b6f25a06a5mr173044285a.50.1733956947666; 
 Wed, 11 Dec 2024 14:42:27 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e5ffsm677605085a.111.2024.12.11.14.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:42:26 -0800 (PST)
Date: Wed, 11 Dec 2024 16:42:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20241211224223.GI2457179@bill-the-cat>
References: <20241211124604.21799-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CvvGDnYO4U5YDrI2"
Content-Disposition: inline
In-Reply-To: <20241211124604.21799-1-marek.vasut+renesas@mailbox.org>
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


--CvvGDnYO4U5YDrI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 01:45:39PM +0100, Marek Vasut wrote:

> The following changes since commit b841e559cd26ffcb20f22e8ee75debed9616c0=
02:
>=20
>   Prepare v2025.01-rc4 (2024-12-09 16:09:28 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 802b08805c1775c576c7f09b52169e462a728592:
>=20
>   usb: renesas: Fix R-Car spelling (2024-12-11 08:36:24 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--CvvGDnYO4U5YDrI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdaFU8ACgkQFHw5/5Y0
tywKZwwAmMEtj8rDI7ucoGPbFLk41mOwELUklk8kVCOEUcJGdEA3pWT7Q4cDXZpa
vBq6OJTtAlbGDqQF5Og7v7k5XZmrbErLl3YT4kBr7lUzt1dZq79qwtf0K+cpjzaM
EQ8XYEGSwLhwmmLrQE8NUhLcCXNcPNrdrG1mPuLA5pSlvZEUTyS7wzkNHOteENsn
Wvw/uM+Rzu1fWOgSJhomwDA4iScWCQzRNLRgiT576NvENzQ1BJi2zgQhnqXFddM8
tdkRZStOOAtGxXjAx8WIHxQD0yM1MBTxYsEc/CUlTjZlZ7JYHDoqn04voWA0mZgy
mv1Mz/75vustNPOG4Ek3fs2x7/1DDXxv11KxU4pRIXnvp7zf+vuwJKYdruhxWaHJ
2Dzlc0ywAa67eLfNGMmUw59MKb9uXa/nrabVMNZc2RHwVY5rW6Ut5EJLwGKq+zWC
r/MxmON31FPecf8RlEgpPCVael2p6MgY0urtT0Me4OtAimmKVyxKgINzANmABaOq
GfUSz448
=X25D
-----END PGP SIGNATURE-----

--CvvGDnYO4U5YDrI2--
