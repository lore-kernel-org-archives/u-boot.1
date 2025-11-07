Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F193CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 20:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B2A83DF3;
	Fri,  7 Nov 2025 21:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X2zo7a9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B60683E0F; Fri,  7 Nov 2025 21:19:33 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D62B83CB1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 21:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3e3dac349easo709324fac.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 12:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762546770; x=1763151570; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zgSbWlZAOo2Fk58KzpJAJaQKJQCbKTKfK/XJidl6MVs=;
 b=X2zo7a9fLokLJTfNhStrulWqu40bXZ8F56IQQZMq9wjoSNk/6q9SmY4qjLL5eA2w2h
 nyBsm3hA+Knmb5Pe7mgUFkEH3x1p931DV0xVIahnq2LwcvxS4AxQE6jFbUBBVdyVVfo5
 dJxX0exyhN/DggbqPVTATYz4jROV7PqOjJFcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762546770; x=1763151570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgSbWlZAOo2Fk58KzpJAJaQKJQCbKTKfK/XJidl6MVs=;
 b=GjbF61wGup8k6nBYXS/4rgBsMIU4hc6W4w8OfK7+nHvySfucrcyec8wyG6uWlnRJUo
 oSVSH3LyDZgUebF+mnfmGRdgelBUAL0T9q8jDyUHbOnlnrTz8qrF/SJy0UguHr4ZLwEb
 pB8tMOvJ448LqHw9s2ltlLfudb2FFEPEy/Zzz5oeSslZvrPJtjJMZlzsJO3K068nLViy
 b1yR1E/c9H0SR6a/s7HPzRF94i3gwBQcMyqJuW9TJUzr9gb8mqG9II+uh2L2tTXJxXK0
 PPc4kHt3IiNKEOoUD0/NN+mBTL0UzBxeQFt1wmZRu1eQGR/F66Jb1VQc5OwO6DxZKOPa
 eEzA==
X-Gm-Message-State: AOJu0YzajUnWuoKapQTn9Drhn0lqdvxhXadogdxMsoAAdZMSe321527s
 clduFfxxQQa0Jwkrv0wBn9rBhWdYacvcEEPX+8O0qNMfu93FHc/uprBq34OYjwhVJYA=
X-Gm-Gg: ASbGncsELfhQ7EX3CExL6PI+j7ddxbTP+D4k+lYczAhVbhlCb2bQSI3UX88JM4o0Hcv
 ZtCYLpscUVCQNFdHaG2PYGe4Z6tdqmjCCWMNQdnASSWetyXQPD3UCwRvDmkggHgFdi6Fkxz9xS0
 c4vuCUMAT0uvFXxooSKRPTu+9oxS49RpEmBWCPTR+tuN6pQSvhQwsFI+F/daFur+cLz2d3NrwV2
 wPym+zzpdeqRTD8xdzWzhp9jmL3lxaYGHrqzj5/UO8AawAZr3Fx4QGWpADs8G1i/s0swui+E/ck
 eKwjylao7iGieoILUVKPUHMjOm9hZI6e4vnkLzmpWEKH19aKppeCvj7r8jaHjNI8q7o8iWXcEoS
 qLKy3t3AIrEKTBBGjo3l5arkj+VSqD0/Y1SWvPGW2C4REAwrgXJC1K6jp1Of7/rueSgl+gfrf4H
 jv/U+dLbGzNbxoBnTN4qm+8S+DMuYHf0cdH11D0JRYc/1LCplCeg==
X-Google-Smtp-Source: AGHT+IHR/+zWGamSbezOqZs2OvmrJf4kW6AHwKRRAJPAY/681+Y05uhJzeECfdRAWGqr8kEgSsQxeg==
X-Received: by 2002:a05:6871:589a:b0:36e:74ab:54bc with SMTP id
 586e51a60fabf-3e7c2958798mr544707fac.26.1762546769976; 
 Fri, 07 Nov 2025 12:19:29 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f583a9sm2008384a34.9.2025.11.07.12.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 12:19:29 -0800 (PST)
Date: Fri, 7 Nov 2025 14:19:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 0/2] 'part name' subcommand and some robustification
Message-ID: <20251107201927.GA2243313@bill-the-cat>
References: <20251020121100.1742812-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ex/NkanTA+g36omr"
Content-Disposition: inline
In-Reply-To: <20251020121100.1742812-1-ravi@prevas.dk>
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


--Ex/NkanTA+g36omr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 02:10:58PM +0200, Rasmus Villemoes wrote:

> Implement a "part name" subcommand, mirroring the existing "part
> number" subcommand.
>=20
> In the discussion for v1 of that, it came up that there's a bit of
> inconsistency in how much and what one can assume to be initialized in
> 'struct disk_partition' after a successful call of one of the
> get_info* family of functions. The new patch 1/2 tries to consolidate
> that by making sure all ->get_info invocations go through a common
> helper that at least always initializes the string members.
>=20
> Rasmus Villemoes (2):
>   disk/part.c: ensure strings in struct disk_partition are valid after
>     successful get_info
>   cmd/part.c: implement "part name" subcommand
>=20
>  cmd/gpt.c              |  4 +--
>  cmd/part.c             | 16 ++++++++++-
>  disk/part.c            | 62 ++++++++++++++++++++++++------------------
>  doc/usage/cmd/part.rst | 13 +++++++++
>  include/part.h         | 16 +++++++++++
>  5 files changed, 81 insertions(+), 30 deletions(-)

This leads to some of the bootstd tests failing in CI, unfortunately.

--=20
Tom

--Ex/NkanTA+g36omr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ5USwAKCRAr4qD1Cr/k
CloxAQCCk6Pe10M7f9OTAgKr9mzSnMgFgOoj0MrjgBY141NDzwEA+OnQ5a2y6667
HUSBBsssrxHTl/GaqC61D66LKt8tXAk=
=n3wI
-----END PGP SIGNATURE-----

--Ex/NkanTA+g36omr--
