Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8596C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB58877D7;
	Fri, 10 Nov 2023 17:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kxTBznEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D368777F; Fri, 10 Nov 2023 17:21:17 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC17386EDF
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-77bc5d8490dso68475785a.2
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633273; x=1700238073; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C0XGCvtd6NkFoxt/kLmOTTQM573Z5idIv11psOLqqXY=;
 b=kxTBznEdK5klJCoGumdp8bvLs0jfE3uXr/3FJo+R5eOpMdV/JGRxo6rxbiJ3K1nAn8
 sDO/BGx+WFmTjx/5jVuhRWVih40kHbca/cqfQj0rFhKlaD3inhYJtPn+yVs3D5GHdFyG
 TOteURED9Kiejdr0iLhMkVTHYctdSPyHXr1ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633273; x=1700238073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0XGCvtd6NkFoxt/kLmOTTQM573Z5idIv11psOLqqXY=;
 b=AMc1a2ay3ViCcO9o8+0r+d5+QGeHZALisMrPImeqUr0Lzf5PpdJC46pc/Ju262qkXH
 aUW/j/PYjjYOP2jZ+3FZmr1cNfkOoJeL/3GF2QDIpgM/tkLBWT8uB9iKgl4TFuVk0JqV
 XsoOOO1dLCTR2RHl3H7lMsIfQegJprG5PBauuv24EPIH4NfJuwQVe9W3Ldkp2qbRmxA9
 PUJdlL3+x6PfFttK2v5BQeSUV4+6pXPhJ5LcYbdhNw4Fqr0WhBpTziVD7x19dlL7bBMd
 6CKFynq+wOgkwOp0YpnllFtzq+4Zf+ttEfj4H4gPrLi5+tnbtVxDOZtYVNTt+abePWCM
 xJpw==
X-Gm-Message-State: AOJu0YzsJRawaAce9oTk24s7n+cVAtcMYXVFE67PsgYbTn02JDiNHRR3
 qu/+f2J8UYyissRgqGV8zzRh1d38ZIX2L++88ol6gQ==
X-Google-Smtp-Source: AGHT+IGtQuFYH4oVPRCZ/ayMDuvajjqqDjz6s3XGZSAGNznnm88jApna6+vj71YaK4gq2Z807NThZg==
X-Received: by 2002:a05:620a:1d81:b0:77a:a2c:679a with SMTP id
 pj1-20020a05620a1d8100b0077a0a2c679amr6862740qkn.42.1699633272971; 
 Fri, 10 Nov 2023 08:21:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a05620a134900b0077a029b7bf1sm791563qkl.28.2023.11.10.08.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:12 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20231110
Message-ID: <20231110162110.GS6601@bill-the-cat>
References: <20231110090914.116712-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wYaRHcHQ8Jx9azDV"
Content-Disposition: inline
In-Reply-To: <20231110090914.116712-1-kever.yang@rock-chips.com>
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


--wYaRHcHQ8Jx9azDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 05:09:14PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the fixex for rockchip platform:
> - Add Board: rk3588 Pine64 QuartzPro64;
> - fix rk3066 enter download mode;
> - fix for ringneck-px30 board;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18047
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit e17d174773e9ba9447596708e702b7382e47a6=
cf:
>=20
>   Merge tag 'xilinx-for-v2024.01-rc3' of https://source.denx.de/u-boot/cu=
stodians/u-boot-microblaze (2023-11-07 10:36:23 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20231110
>=20
> for you to fetch changes up to 4df4aea88fb99f413a0e3a2a96e176c6108939e3:
>=20
>   rockchip: include: asm: fix entering download mode rk3066 (2023-11-09 1=
8:07:21 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--wYaRHcHQ8Jx9azDV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWHMACgkQFHw5/5Y0
tyxzTQv/b3S7sIGaGcI5+CaNI0U1vpj0ZgE1QG4oltMLIZCxr/kDH2caEK3XYAuk
rlPW5s5kX7nGs1agq/qaQQB1OuZyjde03+w8AeVU2E9Y44qiSEXJxFEgZWYW1xFD
i/WjjUE5cDzpnDlkoBOpI/yZyAWc/gWBWAok9M1RHHhNz8/mejnm4/4+2OdzerSx
01xIZNs2gG5uaPtvC5LIFIt8/6PoiZEvfj3zlnPumfmmb8Mcr7/st9nBG/sjvC0G
G+0aH1Q6EE6bVIg6DqSkJz9ybBeIxrjJqK4JYnnD8oJnoK+vzsvs9beWBXg9l6vb
Qie3l3p57RgLZuW/N+x17AeEtuZr1+Wqh+Z1n8ACkrYP/MXu6UcpoJtDTnqZ9MYu
w/RwAiTGlcxWzMzTK3v1wuog6I4kZriOHxqpriKufJkjII/5OTxGbnB53fjahoLg
Jv2c51mjIqciXEpw7okamfunobeGcIZ+D9tAb/AUNHcvqeN0IMOPZhAslZMz9J10
AgxMVA4U
=lSTZ
-----END PGP SIGNATURE-----

--wYaRHcHQ8Jx9azDV--
