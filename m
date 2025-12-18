Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1866AD6E2DC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCED80050;
	Thu, 18 Dec 2025 20:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cfsdxthZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A38801CF; Thu, 18 Dec 2025 20:46:26 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 747F58003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-657044fea68so1079054eaf.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766087182; x=1766691982; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BmucGfUHSpTS1fLmyIWowd+GMZ8dLs371TLwxhZy+3M=;
 b=cfsdxthZJOpuctN9JYKKg5k+Dciowq/QC08x/AyQSow+N0n1i+docxq8M1WlKTa0nC
 LhG5ArP/LBXo2+BvEJn5M9BHv6tmFAGg4pEuATPAZqOIleD2IcCIkNK/2+IxPo89vpWT
 I8S5FbIQJFaDpjSX1UiWVNSTtxLBMaxgUnz14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766087182; x=1766691982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmucGfUHSpTS1fLmyIWowd+GMZ8dLs371TLwxhZy+3M=;
 b=FkKvFzru6bozVUwUUwV9Z4vPloPHgmeMcmgHP7ruZXJNn9LNxdeP51jD+nX6/gdHXk
 kE2GpYafDytTtTo6+pTLShPtVY+wx64RDctsagul/lcLqB4FqAhYAt1F4g5Lp698+c6K
 ILgEvovl/sYs3w9KHGb27taKKxKY8lWrHThMrcpPePxRE1t/2Kx8so2MiWrjhwUMN2IC
 Vlv+O8erSU6g0FK3gHFAT3rq0E9op8C//xXQcL+00j72n/LTd3gRLQ2YdbLhqGnzX2Ur
 bjVe7PDZ0EZXnKEmmRGTuOCvmkHq6pcm8Zn7VmFTGtzxCIEIR3oN40qoc5JsXwi1bjsE
 Wuzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS+wKfLcox4j5iVkFh5kPZJmoWiiueIF58olcnEkj0rRbbGhRfeLx/5wkrJTGcZfZ3WiMcU6M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5y2rZiqF2trfBwUFc0WSQNC9kFjo6axjGXvqAGsYmBOkT4Toj
 uJxVN73Bdv6QkMWBdAsk5muM7fBEmtlJ+MtBMC4UoYKvnQhciCNTOEUL4gkL+5LWVLk=
X-Gm-Gg: AY/fxX46nDndkwv0Pw9zRyIKH7lTJpVu/PUz4rgqxuoMvBVnPmJidA3LId0hPVqapvo
 Q58iENgx73GOwo4/ZiEV+tMQSX6RI1jPO5Cf4TbanA5RhRGCDRUh+qNdVuEvY3gvKjMXsozcJ6/
 4+pFyXkRkXivfl//jIyC990GsQO2BJdKt/w2dmTKQMLzQ5NaskoqyuVavRp7DDMuiA27+A8LBWG
 4BQ/6ZuFKxQe19hsmQjpUOpZ3yJ+gYtzWQRUDh7sQbBqhcSqy5yQ8bm6rFmxXlPfFWAUaipzizH
 bOWsLRFnamj+UGQb8seqdnHFSbekTGKLsUFR30smxSrXY/xGzqcjRNNo9OPqBZsGRGbFXy/4Tbn
 PdGXW3ERbPzoywWy1UcZEKeMycEtD7jc73GvbD2JhQnd6y2ZKh2S6qiruK017ObHoqqdY58qfbe
 rr65J0kPMsJAZ24BbjIbRqZLK72vHABxqpSzMHHlXteU5l7pl4Qw==
X-Google-Smtp-Source: AGHT+IEFRclXlOiORCYv9bKiPoKjmP8B4mwUQApOZL5nWuS7RKexzfyJ6OrhK0Q1Po9BIXMNSmy3Qw==
X-Received: by 2002:a05:6820:f004:b0:659:9a49:8eea with SMTP id
 006d021491bc7-65d0e3a9cb9mr396761eaf.30.1766087182251; 
 Thu, 18 Dec 2025 11:46:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f6f0e78sm159436eaf.15.2025.12.18.11.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:46:21 -0800 (PST)
Date: Thu, 18 Dec 2025 13:46:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: stefan.roese@mailbox.org, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] arm: mvebu: Add Allied Telesis x220
Message-ID: <20251218194619.GO303283@bill-the-cat>
References: <20251218194218.1972757-1-judge.packham@gmail.com>
 <20251218194218.1972757-4-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GpypdwGAwt25Qblo"
Content-Disposition: inline
In-Reply-To: <20251218194218.1972757-4-judge.packham@gmail.com>
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


--GpypdwGAwt25Qblo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 08:42:18AM +1300, Chris Packham wrote:
> Add the Allied Telesis x220 board. There are a number of other variants
> with the same CPU block that are sold under some different brand names
> but the x220 was first.
>=20
> The x220 uses the AlleyCat3 switch chip with integrated ARMv7 CPU.
> Because of this it is reliant on a binary blob for the DDR training. In
> upstream u-boot this is replaced by an empty file.
>=20
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
>=20
> Notes:
>     Changes in v2:
>     - None
>=20
>  arch/arm/dts/Makefile                    |   1 +
>  arch/arm/dts/armada-xp-atl-x220.dts      | 162 +++++++++++++++++++++++
>  arch/arm/mach-mvebu/Kconfig              |   7 +
>  board/alliedtelesis/x220/.gitattributes  |   1 +
>  board/alliedtelesis/x220/.gitignore      |   1 +
>  board/alliedtelesis/x220/MAINTAINERS     |   7 +
>  board/alliedtelesis/x220/Makefile        |  14 ++
>  board/alliedtelesis/x220/README          |   4 +

We shouldn't have board README files anymore, it should all be rST and
under doc/board/... and so we should get this platform started in the
right direction there please.

--=20
Tom

--GpypdwGAwt25Qblo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaURaCAAKCRAr4qD1Cr/k
CpmkAQCTmFqZ3KLOLvqAAemmA04PtBtjNhmTlMXVlFNZ3MrpsgD/Szs6VuV4BB6s
BAY5h9rGnADYxF9MzuNfdyOGA2OCFQ8=
=GYdh
-----END PGP SIGNATURE-----

--GpypdwGAwt25Qblo--
