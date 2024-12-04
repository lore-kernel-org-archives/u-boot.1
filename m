Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F376FE77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 20:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E11C891E1;
	Wed,  4 Dec 2024 21:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rb02P4Px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAFC89346; Wed,  4 Dec 2024 21:03:55 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A712288EEA
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 21:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46727cc31ecso1020381cf.1
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 12:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733342632; x=1733947432; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=76OFb1XjgpvTCsrV2p5nA90DCYujy1FywVYBun5UsYs=;
 b=Rb02P4Px1Ay4mQBsxqaxkk4hGbkulC0Aol/UTSSwacfozeKH8PFYAFTIaZGFwa2RRT
 ivJs6l8Gg2BUYzsFMmho0SJXSlRAr0x8DInhnTSIwizFxHz/yoaHnbKbrua7sWu6svHk
 BM0GGKqKooMNDEWYwn67JRtOveozn7KtNSXjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733342632; x=1733947432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76OFb1XjgpvTCsrV2p5nA90DCYujy1FywVYBun5UsYs=;
 b=hfHaQdTaHR2qfkHFQDuMsMi1wTWyntn2dxuOSCuLRmQtGrw9pL2GqQpoH3kyCAxEwa
 +7JmCPcxqwdQoit/dAwTIpgDhEQ6poGva8IYTqT4aLvORk7thPzRS3sg8Ez2ReQxdnN7
 W8+7gZaDPJhWISyoA+tDjgnYiWVzaetvN96CaUH1Mwh3FOwieIftYa6MLqorGXvYJHcI
 TtUZpIuBJl4HmJ8RmoiOjAGPL1xXAF0SdMRgwBSdNvof3UQhVnPAvRLkKQ3e3SZc5Waj
 HcIgz+faZfMXN4KLE8MXWI7LbPDOp4BLPeb8FNZredhOwa4Lh4yuxP8dgN3FaMtQoech
 Y31g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMVjHvwPviJhMiIzI/CqG5y2AuslgwXaNGRpOMGMok5/sz1dsF1lxnVN4AZYazw/I/FePA0U0=@lists.denx.de
X-Gm-Message-State: AOJu0YzLsN8gr0Pm3FfDeDJOllcEVH/Gli5f7NJ60NwmPNWpvykM1dPD
 5tkHBXxrdXH+HcgjhFbviwKBzae7YTxaXtNyifNTlHcgmdTAfgziFKrnEV1LzjE=
X-Gm-Gg: ASbGncs46dMbOxJgQRHSu9qK/L5MzAZT1Iscc5frYIDEQewPoK5+Vi6kirfH1GBCznc
 v7nz1Hc7hhMOJhmFiz1BzXaOJk5kJIxQqgMXfNu4PQ8GNTuFLU+iLbzpdCbn/Bt7oDifcs9fdCX
 jizi4gTO1jqBAHw7S054bK6TNhK4vGWZ4/qaSXXVb0pQnPHh4I4YTrMY0wDifjrDRIS8AeMv4sQ
 adT2iM4BWo3m+iM5pwKeAqGaqbopDWDFoLM/rYXuLa/d6WR2A==
X-Google-Smtp-Source: AGHT+IGnbtPr2Cfs6X6w21Yh6Eii3g6APteXL1KqQXfBi0D5k+5wUpOWDCMHfy5PvBDuCsQHxKwTiQ==
X-Received: by 2002:a05:622a:188b:b0:466:92ff:dc48 with SMTP id
 d75a77b69052e-46717ce5b2cmr92807381cf.53.1733342632370; 
 Wed, 04 Dec 2024 12:03:52 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c40646cesm77350741cf.19.2024.12.04.12.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:03:51 -0800 (PST)
Date: Wed, 4 Dec 2024 14:03:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] gpio: npcm: Add persist feature to sgpio module
Message-ID: <20241204200348.GA96450@bill-the-cat>
References: <20241112092157.1296548-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DZhepXr0eUeVgJoO"
Content-Disposition: inline
In-Reply-To: <20241112092157.1296548-1-JJLIU0@nuvoton.com>
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


--DZhepXr0eUeVgJoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 05:21:57PM +0800, Jim Liu wrote:

> Base on GPIO hog to support sgpio persist enable feature.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>  drivers/gpio/npcm_sgpio.c | 152 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 135 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpio/npcm_sgpio.c b/drivers/gpio/npcm_sgpio.c
> index 6d73287c0a..539bf3e133 100644
> --- a/drivers/gpio/npcm_sgpio.c
> +++ b/drivers/gpio/npcm_sgpio.c
> @@ -3,32 +3,49 @@
>   * Copyright (c) 2024 Nuvoton Technology Corp.
>   */
> =20
> +#include <common.h>

Please rebase this on current next and re-test, include/common.h has
been gone for a while now. Thanks

--=20
Tom

--DZhepXr0eUeVgJoO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdQtZ0ACgkQFHw5/5Y0
tyyafAv/cMryn707twmqylfhLveEc+LGgely5HUw4qhCDnJOs3BcXLF5sOv9lG2k
DnhPGCXZcaqtstT8F8bC4bYkLjYNQsfV10BB4y58/G+whZpySFLEqs4u+h9KIcso
M/HPTnpkwQWoC1GVGi3D1R/k1iMICa/K/SPrqqOheUAcz/7lTgM+1ctK2kZ22VOY
JzMir6SVTqnl85VNhOHCLuJ63/Xm8/lXkOgO/68ghi7nJn56Gg7OVYiM+D8ormY0
cP2I4ojjPAEPQpGUGUPtLJNAcm9tNSO1hRDiWbDwps1kv0AtVJXiKuvILUetxG9F
ETPMLtpTBUlB+Dad/E1IeA+quJ3YuoIcdu9DrDluxTwRbxwUDKBkV/0VD7e/fbJA
7DHEPXsa/p+orhSywVJ1bQqvk76Yv/Tq4XilOeKUli2SlCsW9csZn0+jqGWvgzJq
ZoOSi38RhnqpSCch57WKDuo+rusbZDtEjl635cJpfGlIzR6FIZ4MlPouutBwg3J9
MVXDKt5Y
=UJo5
-----END PGP SIGNATURE-----

--DZhepXr0eUeVgJoO--
