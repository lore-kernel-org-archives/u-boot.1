Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A82AC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82678651C;
	Tue, 29 Aug 2023 16:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NKR2pAsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA1286500; Tue, 29 Aug 2023 16:09:41 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0868651C
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7766072ba4so7306442276.1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318177; x=1693922977; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z154exX8YfqTsVlqgxYQHTDiUClkNfJseplekg0wXXA=;
 b=NKR2pAsVZB/muikep8hM/O736Vt/6mIROXuT15S7egsaVz+UEPMala6EHAXOFMOeUS
 RtIXxRKIGUuoGX6Eqn8ifQLpApQ0OMdkkKR3s2mSswbWBoICzdw1OqLx6TG+uuDutvD4
 0Nu86gqR57ciGIxhRlPwi9oVuAMcxsgk9UVqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318177; x=1693922977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z154exX8YfqTsVlqgxYQHTDiUClkNfJseplekg0wXXA=;
 b=P1v7Zo40WyHASbcUXImdwLXWlrfAbqGcpLpe9p7O1IjLsdu8uaEp6OLUE/+wmVVam+
 3pMNiJHZIVvDr/r6ijuC9Xu1ULvBVNqBqPh8eflArXRo1GYb5bVD9SUimlHq3PiTIQlh
 ehmkk4xXr2geJ9i/jR4owYHTEMUe6p84lg3EehueFrL6v+f2tBuUVcIdCB3vZ2qI0imO
 Rbg7OCNuUvDeoZ8whbVosnEaeMwwiSBPzWPkCN2qBxRbgq2cdB4eQ8UPsrl05PwNFOPx
 LPHuEFQcLoahmT0r+ZYsEyqCNhpw7imkEBBJDkMY+dkZ31ZsSmeU8u0bRHfOHEWbrl/l
 XuiA==
X-Gm-Message-State: AOJu0YwFzGFwC++nLH8okRIdKZg1LWIR2i6wF+IqExZP46EMBdvyJ3u/
 4pjGlS+8MofvSCxI7rzExX7Edg==
X-Google-Smtp-Source: AGHT+IE0ReZfqhAA5qWlkllrCWT8EIfk1bZKvmvqQZPnQdRvvhtLYrSSKPLtcfKNV+M4xvwjYzm1qQ==
X-Received: by 2002:a25:f81b:0:b0:d61:44f9:5d1e with SMTP id
 u27-20020a25f81b000000b00d6144f95d1emr2853765ybd.12.1693318169775; 
 Tue, 29 Aug 2023 07:09:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 j191-20020a2523c8000000b00d4fc4132653sm2206439ybj.11.2023.08.29.07.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:29 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 2/2] Revert "binman: Add a temporary hack for duplicate
 phandles"
Message-ID: <20230829140927.GW3953269@bill-the-cat>
References: <20230824011804.1501058-1-sjg@chromium.org>
 <20230824011804.1501058-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i/CjxuLU+bItJ+U/"
Content-Disposition: inline
In-Reply-To: <20230824011804.1501058-2-sjg@chromium.org>
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


--i/CjxuLU+bItJ+U/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 07:18:02PM -0600, Simon Glass wrote:

> The affected boards have been fixed, so drop this hack.
>=20
> This reverts commit 288ae53cb73605500b7fc01e5919753c878466be.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Acked-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot/master, thanks!

--=20
Tom

--i/CjxuLU+bItJ+U/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/BcACgkQFHw5/5Y0
tyxAtgv/Qxau+OxMJ0hnEoyetXZOXQOEFdWxQZmg2hAVW0GidZK4NMMPKQNO9H3h
mFw34c5ZmLlu2pFCCeBsKidGkPs9aZivRTb7W96OeCxyS/hstBkg8vE/4eEmpOYn
qTit+AUJICOzA4xiahZNYiFolbfRpDoU/hPDU3sWxAeP8UQbrMzavdRZGVWYNZ3V
t/K7xLA9S9vnU6d7nRRM2Ov4cVbJMhpft90jXKwfDwqr5fS/dq+1MhlA/lATwGpk
6Kq8mqs/LtJlUfGKlaL8bTDdd0EAPDIZ/uEMk1p7nV5md2mnucg1NZnLnshQgpK9
ZHFFSgRb6SbwtVa0QBkKeBp92uUCiKrvNsNTP7atNfVGcmeY7m6Snel9PVp+bAFs
pvioM/KoF5Il0CqhW0CbeE4m+KeGK3wBzZ+CGxGMhbcFzYHP+4wXFN1Ju25ppKzq
UeoWqzvEkLC0y6riDVwXD5bGa1M68e7Z8gOSuH7I4fXIBG+IRBqLXWroJAEulOyO
YUAH5Mpv
=Dcp7
-----END PGP SIGNATURE-----

--i/CjxuLU+bItJ+U/--
