Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD48DEC112B
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 20:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE2483C39;
	Mon, 23 Feb 2026 21:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mFG2jcLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E727383C6E; Mon, 23 Feb 2026 21:37:15 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC78083935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 21:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45f171cb842so3474700b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 12:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771879032; x=1772483832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ni7jFQDXmGyqpz55Sm9VdweEsVoSLDQPblU0vIpYp0=;
 b=mFG2jcLTBwXsdwpUV/AUIpokg8ZmKr06XdZ+CwBRVCsncWa0LbAZTcBAPK9Pr2pPSx
 BV2GcFsJcnVGxcrURx2GmYZPLf6yzLIOP/3MyxqrdEFQ8KfKDgn7TAPUlPlFy7w1Gvj7
 l/ybo4qljDra8aIWNUl22nud05v3I3DpfXRcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771879032; x=1772483832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Ni7jFQDXmGyqpz55Sm9VdweEsVoSLDQPblU0vIpYp0=;
 b=S691Kd6AUUQ9vf9HacZJikEe1TkHR8eu9TEmIgrTmjwJO3dKrisJfMhkQt6gcOgLP4
 wAPWc52sCCxdeOHlzOZAScAaxUgIsehvgSHQvUVVEnarComku6k0q+4Db/pD1/MKVXXy
 g5yQvWgee4sm/d6YVFlxeAySQrDYGcQKz/CcCT4tAWMKOgwccWY1L+Dz0UxYJ/SITatN
 w/Y/G1K0BbLDJ2+Os00zDU3Mpev0sXrUY4Gt5oHV+dZ/Fg0FwIc0KywSXgHVkyyjAgnB
 Eq5q8Bi1tWfgGFmxbSpY8NTk4e3gK0S1uYVvoVI5mVPaXh7QOeIG7xSERfiFB5o3xktG
 sfZA==
X-Gm-Message-State: AOJu0YzUlbohousSg62vETUNTLTJpiq6bGPVnGO4fD0ZHfTP96+1NxwQ
 68c7/C+cCYr77YQxc3lZyw5YkPXzLMPT3iTwt15KaQ74Xrg741IwDH8TlJK0xH/Ibu0=
X-Gm-Gg: AZuq6aId2JJQbYLrkNwQ/EcdJZY2nt7PiN4m8gIzT7cSOZMBh0Mm8U6NTdaUAi2a3nw
 N5PNzddg1gu7rDzqGKp4EeNPBqbUcj/0zaFFs0WvBavFguc3RF0YL4n8b6wXTS48k+LhP6wTblU
 kS1fw6b3eWJmIrqbam07TzpPTCona2WgyQSL+0X22TYtOSAqtKt5ORH5+4GUVzaj4fA/g+bdnTQ
 G9WJp/I6eWbCcrLtgSL/2ta/BYwfp2/GhsTKa462QGDcA9+LZAA9Ik7WnwqpuQfMNcH/Wpvc4iZ
 qy7YNYeIyPjYcp4tR1lCUJJ3d6p/CJmhf0GNduem5b7HLDed+LYvsU9+NhxoZwZ8oPJ+UEKjL18
 3e+hJGY06hr8ePnKzz8MrJjKNAZQZeJ4jTmcfV0nwOj6MEiKUYsS6/q8gpu8QTeExn9wLGlZKh+
 c56CM16iqjkpzhZxTtq2qxW7x02+8PfnnYKDtOsJez85EwBmAvk6FUunDq+HkHpRfMhPv/+xNAG
 vwnaEqs9gu72wn2zx/YD+jLu0Y6LLAzQxCh4UP4DsGw8cclb8o=
X-Received: by 2002:a05:6808:308b:b0:45f:318:adb8 with SMTP id
 5614622812f47-464276261d6mr7987527b6e.28.1771879032249; 
 Mon, 23 Feb 2026 12:37:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm7976419a34.22.2026.02.23.12.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:37:11 -0800 (PST)
Date: Mon, 23 Feb 2026 14:37:09 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 4/6] fw_env: unify calculation of "blockstart" in
 flash_write_buf()
Message-ID: <20260223203709.GH3233182@bill-the-cat>
References: <20260221100011.29049-1-zajec5@gmail.com>
 <20260221100011.29049-5-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RKLcNXH65aLxZX/b"
Content-Disposition: inline
In-Reply-To: <20260221100011.29049-5-zajec5@gmail.com>
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


--RKLcNXH65aLxZX/b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 11:00:09AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> In both code paths "blockstart" is calculated the same way. Unify it.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--RKLcNXH65aLxZX/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZy6cgAKCRAr4qD1Cr/k
CocNAP9SJSefYsg8RNSjgIlxIli/1QUQtXzBlrrpEzoy3jsh/gD+OH6wH13i3vRI
Hdm4Ts8dpuzorUd1sB/jA40/evKB4Q8=
=KKv0
-----END PGP SIGNATURE-----

--RKLcNXH65aLxZX/b--
