Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865B3CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EA0835D0;
	Wed, 15 Oct 2025 17:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nSwgrlny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762C8835FE; Wed, 15 Oct 2025 17:57:53 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6674B835C6
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-38627e78203so3449559fac.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760543870; x=1761148670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OHgsXg+LHkOzi333jY7YK0h6B+5XQg1axeaQIAoSyFc=;
 b=nSwgrlnyerIxheEB8NIgRBWA7Twc/CKwlmSA+Xi6cVshl+h1v+yN0RtUv0V/7+AZeK
 QJjRkTGiB+KMdWaaz0dgDe7xmXBdGVWX8hYQlXxffa4RCTHvfgxpVMqMtM1FGV/Op014
 E2RxOPf8jMCyC8lxbdoieGrWs1IEb1kUjnYeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543870; x=1761148670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHgsXg+LHkOzi333jY7YK0h6B+5XQg1axeaQIAoSyFc=;
 b=diE/moMZTd59NWsFBgd0EQKw2hxCCZa7rpOvxorvRWeWhnQTRtqavIIDCTKkSiI/y7
 HaRbqTXeLDQ/A8+1rEiIgm6kN8gF3vDP9mwlB9a76jS205rJXFO+Tr0fcjDrUxlYS8Np
 e6GuvXnCtuJLbsMmCupTZMRvD7RydDdtBmKYT7sMEzc2jOCpxTzVV/Ns6Y1zB46rvSkh
 gdFPFm9O93EUkM2szBB5SLHTiQvbiovuVNl/v1nw5j2hRyBbEC5IuyTp4KZzQrQhsm8I
 MqE38U1JzljbiAJj/oKDZbNwOmKBv9jB48XJu1h5aPygWncI/RIu/+WMQnCEbsesjfZg
 zkNg==
X-Gm-Message-State: AOJu0Yydc6nXgmye7HD0pGV8K0cytfgavwTHeypO7uyE+QgHz+lIY8GJ
 TvEj/ZY3VCNtIGQ9ep2e7Cqg8penpZZB5dfFpaK5I1hvIsLEzaZ746YCDCGS4ggTPpyPVGjlD1D
 8Xdaq5xE=
X-Gm-Gg: ASbGncv6B1M08+PEBkbUFyctDi8giLeX7mo5m1PgYVwZyAT/12sYquQ/GHh5VqY4dHz
 LZ85uKIIsV6TN2/NbzL+y3zDqtZCPin3ny/fvdJVFQD9guWo9kv+8Y91JtQZXGJ+7o+sIaPyWUk
 wHMGAr0VTfdG+sXso+3zIb7+h/w/5vYBcYMCu1z6l827wYcm8YH7fsIkdyQ4mp0QktrogYWi0pU
 FKPXXWfEfLUrENGG6XBDotqR34KCedL3NWJ7g4+byJ/M+Rv7cjbN4dmOZCLP0HWxkSKZW+FtGsW
 MrJhdkBD7xIgFXl48pZkI6ZUcFjtD5bxdAPkJiNa32XqF41E5KjzSSCaPu3rL/CFwGR80uWcxdt
 83wTL1bMMddK/KumGo/V/7Wr7mk2fY9bbtARghll9zpMeHtE3J52TwgeyIiTDSNsFLofSa7WgR3
 GZNDK2
X-Google-Smtp-Source: AGHT+IEMxzs6V6IcoOthqN4SRRZUaCs/U6VgEzNYJ9I7aZn/0YBsLA9kWDw2ejBKUvUfv32qmrygDg==
X-Received: by 2002:a05:6870:26b:b0:367:17f3:c208 with SMTP id
 586e51a60fabf-3c0fac5586fmr14480105fac.37.1760543870095; 
 Wed, 15 Oct 2025 08:57:50 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8eecb2bsm5564204fac.20.2025.10.15.08.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:57:49 -0700 (PDT)
Date: Wed, 15 Oct 2025 09:57:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tien.fong.chee@altera.com
Subject: Re: [PATCH v2] gpio: dwapb: Enable SPL support for DWAPB GPIO driver
Message-ID: <20251015155747.GQ6113@bill-the-cat>
References: <20251015154445.30336-1-tanmay.kathpalia@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W/smQlTgpknrsoJ+"
Content-Disposition: inline
In-Reply-To: <20251015154445.30336-1-tanmay.kathpalia@altera.com>
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


--W/smQlTgpknrsoJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 08:44:45AM -0700, Tanmay Kathpalia wrote:

> Add SPL_DWAPB_GPIO configuration option to enable the Designware APB
> GPIO driver in SPL builds.
>=20
> Changes:
> - Add SPL_DWAPB_GPIO Kconfig option with SPL_DM_GPIO dependency
> - Update Makefile to use CONFIG_$(PHASE_)DWAPB_GPIO pattern for
>   conditional compilation in both SPL and main U-Boot builds
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--W/smQlTgpknrsoJ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO/EewAKCRAr4qD1Cr/k
CueJAQDU/vRVSzmfUirSsP6o/j/YB+mBWjOoItJEs70qA+gCgQD/e4UEX6hOpudX
utIq63yAAfupr0i4VfCntK5h1xXrIQA=
=NWEJ
-----END PGP SIGNATURE-----

--W/smQlTgpknrsoJ+--
