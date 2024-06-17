Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BC8C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 19:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BCC7883A8;
	Mon, 17 Jun 2024 21:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qq+8PD0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06BC882D4; Mon, 17 Jun 2024 21:08:04 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9682B882E5
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 21:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f977acff19so2158699a34.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718651281; x=1719256081; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GI8OWcD3+VRZNRrKfVZj33MXjZY68TytO3Z8IMueJow=;
 b=qq+8PD0a5SF2uJ/cHGX6AmpTJkmiNtYB3wjAIpreSrwN68l4JQ86dvsndZInZGH8iA
 x8/xi9OJ3ZQ+Qm3nXYpUTRmU2ulDwDNdyhYqDCR/ELdw3HhYG6yRe9pgdQGVhkcZFgAo
 YWporkV16qExKs0xZ+VAGjG8nrFz/+jKCyyV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718651281; x=1719256081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GI8OWcD3+VRZNRrKfVZj33MXjZY68TytO3Z8IMueJow=;
 b=aNqHquDM6Xhs3dbpV/Y7GgCkD/zsmxbwJAur1vw5epkSjnhfyO5BnSQY+DnZmtEe6d
 uRUIoRNqP96A5qufospWfIxzR6qBGiVeNJcX0hxEbVwESCh53uuCZ4BReIWNIrYqIz2j
 VVhHHegIOPoJVq4vkRu9g0XXTO5+Ljm/CNHAQeRkS/O1rMPnMLs8OTB9tQt1cvv8EFmc
 TFZHyui7Vhlw45RnOHBVi9kMnarPKyVzNj+Rcd8Zigcztr+lgpFR8YWTsRvspqs8pImy
 itNC+6O32zrx54Z7NEfMNGMHI4FBAGce10JOE0bXtCzuvMlRBHVNQc2SARitYkULpbsP
 SW+Q==
X-Gm-Message-State: AOJu0YybKaeXJI6ekp+1dAPXG9l04kjYuGKjUiqznAL3jdnmESglvHjJ
 VQHvZ0fT7XZChhIFXP9u9cqGD2ABwWqSZBLDQgS/tPtceIqTunzrRLy20M/OjsA=
X-Google-Smtp-Source: AGHT+IGJ7Nzo3G6n2ZSaUyCfg5EJrx/txQBWD/cDjojf/OIccABqgirWhrDf6jU0fmbNWpKvCAliSw==
X-Received: by 2002:a05:6870:a11d:b0:22b:5bc1:66f5 with SMTP id
 586e51a60fabf-258429357f7mr11688775fac.16.1718651281241; 
 Mon, 17 Jun 2024 12:08:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa14d44sm2730939fac.25.2024.06.17.12.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 12:08:00 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:07:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2024.10-rc1
Message-ID: <20240617190758.GI68077@bill-the-cat>
References: <8a2e058d-5424-46de-bcf7-87ff574d25b2@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zN2KImm6eiWgorNA"
Content-Disposition: inline
In-Reply-To: <8a2e058d-5424-46de-bcf7-87ff574d25b2@amd.com>
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


--zN2KImm6eiWgorNA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 06:12:06PM +0200, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your tree. Gitlab CI is not showing any issu=
e.
> There are some alignments and improvements but overall nothing significan=
t.
> The biggest patchset is add support for new AMD Versal Gen 2 SoC.
>=20
> Thanks,
> Michal
>=20
>=20
> The following changes since commit 0786dd573d0793417852e009dee3148ebdd163=
f3:
>=20
>   test/py: net_boot: Add test cases for net boot (2024-06-13 16:31:24 -06=
00)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.10-rc1
>=20
> for you to fetch changes up to e4a11e984d11cf4bbe55385cbae03c08f27ecd02:
>=20
>   xilinx: Enable FF-A for all our arm64 SoCs (2024-06-17 16:02:30 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--zN2KImm6eiWgorNA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwiY4ACgkQFHw5/5Y0
tywX6Qv/aRFAQWUiOqFtNiVqVNLP+XRvMqHChqXlrTZCnnP6002KxK9Jtc1zVCs9
lNrLfarDeqh4LWxcsOYgFFlAtamJbos1P/4RGjj7jxCkeYC6SMaW2MLZeiathcP4
FOdSLc6VDotTAyqCf4KyZVhThQY9xUFgcjrjJVeJsXtknRUbz/EA70G5RKJnatiC
bYVDNodJu1y+OgO0nGNCaOkLvOkCA1MRfFWM+/TwJJ2eXq3U1KR3ULD2ap3yzo6S
j4iIXfqV0oNpbqYf5KsQIdnIkgXnjsaWH1lRlsqc1O3C8i9JZat7rPE8wwhi/RMW
t61VJGkvdx5pIgCgs5P9v5wz098ADCzHRpLHNvek7GDwZb3i/ENu7rFUhWXJBP72
yrjPsEVcl3zU9lrBHKUKekjOl91MTiYd43cZeMfIFyMi8RlVuA3wRjfKtRcTTTEm
bz9SHjMWX1zGhjooV0LWw5U7hd1DJ/en0fo4sN4VqfG9qpeHfxNJtZKHh/toqPI6
OLmjMk3T
=Ovtm
-----END PGP SIGNATURE-----

--zN2KImm6eiWgorNA--
