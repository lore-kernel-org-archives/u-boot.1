Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA9CF459E0
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 14:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4772D8414B;
	Fri, 10 Apr 2026 16:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FGjRxLff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9356A8414B; Fri, 10 Apr 2026 16:45:05 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F3A84154
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 16:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45f053b7b90so1210840b6e.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775832300; x=1776437100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PXVYsMPy+7/2vlC/9evhJEzaeFlFB61pOWczpUjgibk=;
 b=FGjRxLffL4s5jrhVGSs6+lTm4zFAKpgAR3/6qT9TZlDK5e7P90urvCcZdugF9Uf2B6
 leFftQJzv5RwJutphPx2xCWKFTh2FnCtFZVla1Ky6U9OJ8f2OW4nBm4PkGNunL2fwP1A
 R5dp2KJlWlDS6azWRkgNIXKX8Ege2WTE4m63Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775832300; x=1776437100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXVYsMPy+7/2vlC/9evhJEzaeFlFB61pOWczpUjgibk=;
 b=eUH3cUaEfls7jj6wpgF3+Gl/C8TL9Cvh6cdJJfsbkkW2hjwRu/PvmXwfP9RWoCQbly
 q+u0RqvwSKrNx+KVeMl+GiS3+iV3zZGTkXA5+gi+pZs8wMEu3rsnlEue2Aeuqc37AbXX
 5zOm6K2QVyuhlWb5Jl8wbrYA5DWatwPljhxpDwALvjkPcsP34oHcD6xz4t0Qb15ICR7o
 oGqc1z00qIgSFbF4qZVPjjL/BFtrwsxyWnUueQ8pW8OLmqOX80nS+XCOxWz2ZnoMZTYU
 AEiXbFhJum16c7wHirZRPzyT52cMX9FCb9l81kJp7x8C3kF0/umxsx7Ccx6+qYggEJkt
 +aMQ==
X-Gm-Message-State: AOJu0YzvJXThMCMP760cJhk/EHRGgb4TIXgB4d5huzr+9bcrI6UzAX6+
 ShRKZvKV5BuetSW1aTGaEMOwn0znQAsGb/otdIVhMirkoCq53Ql0FwvHROhrUKwKm1s=
X-Gm-Gg: AeBDiesleNJKzLJBb1x7OaigMNZIN5b3saBpQc+9gVWDX+MoJU7KgLw1kFAb7X71H/b
 5se2guYv0SEmQ9HrR7agiqFR3L/EqIqBnRpnq+TmwvW8c5UhcpQGg5bougaOzYxEM6UWdID0wHl
 1cAtWHyYARV1c9hFMrTVICtWFiZqA+nQTDiSxVNEzFj5QRwsv/iVowG8Hm3k5O4DEq7GrJ2imw0
 iSe4WRuiNi9nTqEfYJoXjxZkMo4XGEYiyBSXLCjmzScGTN6o/CRIEVX7lDt5YdOX8LHS+xkfGoQ
 AW9std3pkQ9LbWkGY4DiH+Oio4lnv9eSdRk5z7EVORuak/7xluxmY3v9XQrR1X4FcdLLYT2W6cq
 tSuiMKXLlgM0bUb9Y6cnCUI5mVBX2vW0fwCWwZhxmxx39APO0pSGAYbcpLeYCnraxSsio61uktq
 fmAQ1svf/6Ho5oOT6B+/jeYPRCtlR2wDM1tga9f9pkcyCeJrdCGEie88aWcqR/3PPQOV6FXQG6G
 1HI0UtbFH1wBiZx69qw/pGFN+BFOH7rNwr7qdKcflLYOs/TB6U=
X-Received: by 2002:a05:6820:1749:b0:685:c62e:f8a8 with SMTP id
 006d021491bc7-68be6331a56mr1691962eaf.17.1775832300125; 
 Fri, 10 Apr 2026 07:45:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc88c80a7sm1456150eaf.8.2026.04.10.07.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 07:44:59 -0700 (PDT)
Date: Fri, 10 Apr 2026 08:44:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH] common: spl: spl_nand: make CONFIG_SYS_NAND_U_BOOT_OFFS
 optional in spl_nand_get_uboot_raw_page()
Message-ID: <20260410144457.GU41863@bill-the-cat>
References: <20260410084933.103186-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oqC9o2ZsQFYt9Af8"
Content-Disposition: inline
In-Reply-To: <20260410084933.103186-1-weijie.gao@mediatek.com>
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


--oqC9o2ZsQFYt9Af8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 04:49:33PM +0800, Weijie Gao wrote:

> As spl_nand_get_uboot_raw_page() is a weak function, when a board wants to
> override it, the CONFIG_SYS_NAND_U_BOOT_OFFS becomes meaningless within
> this function.
>=20
> This patch allows spl_nand_get_uboot_raw_page() being compiled without
> CONFIG_SYS_NAND_U_BOOT_OFFS being defined.
>=20
> Note: this is available only when both CONFIG_SPL_NAND_RAW_ONLY and
> CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND are not defined.
>=20
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  common/spl/spl_nand.c | 4 ++++
>  1 file changed, 4 insertions(+)

I think the bug here is that when SYS_NAND_U_BOOT_LOCATIONS isn't
defined, we should still be able to override spl_nand_get_uboot_raw_page
(with an implementation that does not use CONFIG_SYS_NAND_U_BOOT_OFFS).
Can you please re-examine the code with that in mind? Thanks!

--=20
Tom

--oqC9o2ZsQFYt9Af8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadkM5gAKCRAr4qD1Cr/k
Ch2MAQDgfvGl4qcbtNaotGaaNSfvxpLr8YbeN1qjPgdTzd/bfQD+KsSpleiyw1fK
4VYKOKLTatJqdKBGCCpDDz7PUAuHYAg=
=g11a
-----END PGP SIGNATURE-----

--oqC9o2ZsQFYt9Af8--
