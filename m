Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1969C4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 18:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25700877D3;
	Mon, 12 Feb 2024 19:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ozZ5lFcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31CA980E9A; Mon, 12 Feb 2024 19:43:09 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D7D87E78
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 19:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dc745927098so2948727276.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707763386; x=1708368186; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qawWVNOcffDU80iU4gYC9nvdt3Ksg0zM2miBpxlJpWk=;
 b=ozZ5lFcfvrRwWbxjuwKHR0fCOxex54DpIP7Ade33Nh1/wf6z7XBD6XVMiq4tem9WMJ
 6dRO49DvT5lrY7dHS18WkQVYUEUXDY9gBjn/19mS/ygFBzXpufC/YflcLKW5jQ3B0Qfg
 ccpIpJScvmIN5xsPCTo5Edn04/HEa6eYtEPiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707763386; x=1708368186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qawWVNOcffDU80iU4gYC9nvdt3Ksg0zM2miBpxlJpWk=;
 b=szF18IUWGHl7moTODcZM4Bv9nIO95gx9ijsk2cD/w8d96NyUm0MGDKGIcQYB0DDTTv
 OKV9hLtMBCnpiqQehceSaO2yCUns0YZCAAhWyVTWGmM5kJcM98PTICTTwn3vThKpJn5Y
 6FsgvcyGRnMHFioGVMbo4AVO/own052s+NBa0fZ/KVw0fYfQjKfDFW3Qzww+2h4UVy/l
 f0RCCSKYgfmCalVkJ4Rbib9kr53L0H3q9H6gIX6ViBD5+LpHcINm9AcA5R7x8dX46yIV
 hnjvv8po2hmqT9S56hEvBLabNxge1i1bpxBUJAfmTEm/Qv0HWxXg2DeQyRW2ZXm1d+cK
 4LqQ==
X-Gm-Message-State: AOJu0YwxPJC91YIopMPIXItBsxMA7GRn3IKWqho+ZFhCQ5xF5FbUpyXp
 N48YwS/QwbqQT7Fed9MSazO+aszUIsP8sVScdOP1rK6o958K6pV+fXetufchEEnDwBxD/jKCb3G
 0
X-Google-Smtp-Source: AGHT+IEM1efFNBidOh+3oWPCqaBPJPE9R6EEfELPHJNinJbwN2dDPsyvfJPSexd6XFo2D8SWnYTNiQ==
X-Received: by 2002:a25:6814:0:b0:dc6:bde1:3e33 with SMTP id
 d20-20020a256814000000b00dc6bde13e33mr5607385ybc.33.1707763385663; 
 Mon, 12 Feb 2024 10:43:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUa1ZENiWH43zOsPdx5mJTyEvOzm8uEHR7z82RsYaorYP76P0t0b5gfULVbXn7P9tBYmreI/AecQieuf0Lykc/Emcy929eno40nUI1ZoA==
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 h10-20020a25b18a000000b00dc6c58ae000sm1300283ybj.16.2024.02.12.10.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 10:43:05 -0800 (PST)
Date: Mon, 12 Feb 2024 13:43:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: u-boot@lists.denx.de, Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH] cmd: add FDT setup for bootelf by flag
Message-ID: <20240212184303.GM3040305@bill-the-cat>
References: <20240212184117.25641-1-Maxim.Moskalets@kaspersky.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fzNZNPe2RY+jFMnq"
Content-Disposition: inline
In-Reply-To: <20240212184117.25641-1-Maxim.Moskalets@kaspersky.com>
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


--fzNZNPe2RY+jFMnq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 09:41:17PM +0300, Maxim Moskalets wrote:

> Added the ability to use FDT for ELF applications, required to run some O=
S. To make FDT setup, you need to set the elf_needed_fdt environment variab=
le to a value like y or yes.
>=20
> Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
>=20
> Cc: Tom Rini <trini@konsulko.com>
> ---
>=20
>  cmd/elf.c     | 14 ++++++++++++++
>  env/common.c  |  5 +++++
>  include/env.h |  7 +++++++
>  3 files changed, 26 insertions(+)

Is there some change compared with the last version of this patch? And,
I was thinking of how to reply to the previous one and I think my
question is why don't we just use a flag being passed to bootelf instead
of this? Doing bootelf addr -d fdt_addr seems clearer than bootelf addr1
addr2 and checking the environment.

--=20
Tom

--fzNZNPe2RY+jFMnq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKZrcACgkQFHw5/5Y0
tyw8Tgv/YCiM27xUvj4CSUym3CaI40y1uNhzTuUNFWFBAQu0G328r602L+PtVOsh
TaPxGumxa5pva0NitZJyYRi6Cds2iSOasBDvlPggxO5c4DXS3xS/0Q2UcJwr2oIn
KMy4L/ccpJgWBUML+2/f470rOzSZ6Nw9rcSvnkVgUoTeZVrR9dVgXXJKd2MjBX7S
O2PMjGa7Qhz3uHULD/wb/WXiuQm/u/w0gt7JDuP/wynbwtIkOMeAVU+i/0b42/91
5dzHh5dhn142sxE7Iui6mCWInzRbq1Y/HkJykQKUfK2BdnaGiyO+GcJ/f8DLeA1E
ZbQgZfHkawPunhSIhKHT5mLFCjPUe+4HnMTk0IVvMxF4QnYgtXlRchTp6gSpJyDH
xgRml609wpvlRlSIwiLm0p1HyZZF4BmctqR7jK7uv53BNGTP5zX5wIiGCPmqFGMb
gcf4IO0uE78HkYlbZGT3RwdEqZqXdy1hTMMiA8D+FECQpk0dQz79iUh+5uRYbpnk
Vq/5Fq7O
=mR+b
-----END PGP SIGNATURE-----

--fzNZNPe2RY+jFMnq--
