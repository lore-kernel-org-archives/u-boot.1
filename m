Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B78C7EE39
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 20:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD97F82977;
	Thu, 26 Jun 2025 22:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FAMY/+5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2E882B34; Thu, 26 Jun 2025 22:03:20 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0F380C83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 22:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-404e580bf09so358059b6e.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750968194; x=1751572994; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SyNbj0Y95VcD8Woy3ray10v6YKt27mH41O2iJrQAy+o=;
 b=FAMY/+5GgfbiOb74OjJ9qBMBc/u9GVisQV4tMGw697/XbL+Kd2wB7+eHIy1z2OO4sR
 rQh5RlpNzPiWlfDFQPtRq1kTaK0tag6VTvEnUq5OQn6EnEkne7PvUQIVOIPRQ3BD3YKZ
 Cmb/MbMQqOCaMWKyyj2XckVGIeKH1uZab8Ik8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750968194; x=1751572994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyNbj0Y95VcD8Woy3ray10v6YKt27mH41O2iJrQAy+o=;
 b=H39uw4RQ0scbTZVxsNn0FysBjhsOp36qS/DhLy4IJVRqee2hCDQszyATBY+AOxQiKz
 i4X7CWMeM86VpYOvX5zgDRG08MzQrNjtOu436ENHdsKdYlQwwODq+z/CP3dex8WBWTVc
 5J1qJKABvmzTqr4fzV5vhPtK4Avh3rMv8OiKVjjB1GH+fFKA6J8c3GkOdYNgecvQdhj9
 /pC+vuj3s+80r+Fnvdr0/6ReHjJ3IhPkKK6f/l2pH3CjmeMYCiL6Pqr29Pl80xwG1rsB
 IVtLq49GDET+WruXz5vUhuZ6qa2H02dUK0QQhl137uasLYakuKGt/bhE3IZ/McU7K8CZ
 PGyw==
X-Gm-Message-State: AOJu0YwA0FdWlpJxMElHpNlFyOznBt2I3beTbZKXbUF9HuGlp4Vx4f/i
 5wjT36HfvqVBLpS9Upw4ajaqXntAsQqByqeUGuby143MrWEBnDIn9zxZsOS4X4jgq9E=
X-Gm-Gg: ASbGncu748l7x/MuXrGERWJDz9CO/4+lhdzGfKkKMQXEiZ9E2qFUsO/MjSLeRNL6qbJ
 dp1deOT32GElYCBx9kNL0EZz7EASrNZF06E4Rt0kyyH7qdXzcJ9iLd5/2dOTxr0Zj6BqyCmeH/Y
 gYmO2zAbmhBaICfgSsOtfyZ8GIMGU+zPto9R7RjmgdW2bPBQNMZ76DJqO2vLTowB51C/CX/Wms4
 Qsr8wT2jU1YuUVTl2cFbmFdvfG7AFJIfnTVIfWrI0DR3xNU9Xjtwfy+6K5gDJjIaVfq+YTMwopY
 sI5qXkt8AFr+LIGVBKtgduHSoMmL2pNaF+jCZgunpnjc/NWxmvBqr25tAkAr2KUnbDCRZgSQgzg
 kmJ5u7ARFb1dtP4eM1z+9LlM=
X-Google-Smtp-Source: AGHT+IG3SRQSl36lsRIt3k12UEccEwkRA+I0d5Sch/RqgpzGOfh3P0WYHzBbgT6pA1aktfK2Ecs71Q==
X-Received: by 2002:a05:6808:1918:b0:406:6fd3:ff18 with SMTP id
 5614622812f47-40b33e5f09amr439480b6e.34.1750968193738; 
 Thu, 26 Jun 2025 13:03:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32406a58sm87223b6e.29.2025.06.26.13.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 13:03:13 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:03:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] mailmap: Update =?utf-8?Q?emai?=
 =?utf-8?Q?l_for_Duje_Mihanovi=C4=87?=
Message-ID: <20250626200311.GX4003484@bill-the-cat>
References: <20250626-mailmap-v1-1-765760da24ba@dujemihanovic.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DOzJLWnAHfbGpr3F"
Content-Disposition: inline
In-Reply-To: <20250626-mailmap-v1-1-765760da24ba@dujemihanovic.xyz>
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


--DOzJLWnAHfbGpr3F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:00:23PM +0200, Duje Mihanovi=C4=87 wrote:

> I'm moving to a new address, so map my old one to it.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Please update the two MAINTAINERS entries as well, thanks.

--=20
Tom

--DOzJLWnAHfbGpr3F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhdp3sACgkQFHw5/5Y0
tyzVJQv/fkO1o6ZscrxvaXESBddCVDSqUYYzkFZ251zOltozEPhsxfvj/RoOcHZv
Mwzg/ioqfOyXZvP0TWuqdSF6WlGyXGQL/w8VXT9c0WD1EhmmOyUv0M7tCl9zLEgL
DFBu2i3zzNjijeVmD1a/WEVSYBa6xaZ3lWTk2xX2ub3wPag3Dxrka0HQOZOmypOC
fkoCwO+Zj26HI06tfRC1K5rXDG0QcIGfyj4TLc1MORkTKbw/l2F4Ow9dUWfh66dW
AGuLET9h7rorHzjeG/Ixh8J5b3XqbL1lQNkUuQR5LGCs/2rkzsEilpHgFrmjFtGi
fEdnLWRMv0dWM5B9PadfmdTu9WHKGP/wqK95YWliDjJ1FBdd7gqKjoje15T6nDEs
u3H1lvJk+9InOQk0gtWJ+le8OzTDJeGXht2E9J3pYcqzSoxgtvwcqgRW58QobEXu
UtudrIWTeDCYVJ4lH44WuUbjMHyphpgFqhaAQ9iyua3FLd/e888LMyDpF0aH4onn
/pSY1j1w
=Dm9X
-----END PGP SIGNATURE-----

--DOzJLWnAHfbGpr3F--
