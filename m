Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B557C52CDA
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85E386BD8;
	Thu, 17 Aug 2023 21:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EnY4bmAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E074F86BD2; Thu, 17 Aug 2023 21:02:20 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34EE786BC5
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-589e4179fc7so1522237b3.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692298937; x=1692903737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KtwU2hY8uoBiiZBjtngBxyQazIMyQ+2ZRNt9FiCzd3U=;
 b=EnY4bmAk+gZBqyZG44h5J9OokY5lsVeFywNyFNKk2No+/5S3iZl+TvuyUg1fefWt9y
 irNp0lbRm+XZKvLYWXEG+V3ibUwbX/JyIiryXQIPH1ypUFoIoZdLXj4ZJPmLXHF6V/m/
 wpATcZWCLQK8a7sWVjIcKXIYfjV0AcsQ3qHSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298937; x=1692903737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtwU2hY8uoBiiZBjtngBxyQazIMyQ+2ZRNt9FiCzd3U=;
 b=lFvgCy6hxGhVEAiGGpGFlRUoXcJgz9+M9L1v65AsWve6wAJn0A8fjmR8M+JWZ5RruG
 sj0ot7qz/Q4CfXLJv3p+qKo1PN1uZUUV3kaXZ9yhi2CKJIy5KIpKiKjF1nyR6KTrI7D0
 mKcmacY4SJU3446VsgvUkvS/v8uPgCB4gWTePFx/weNhDSL5kTtmQ7CcYRrsTxX2G152
 LDH8ZFDBDDa5SJgVHlb1uSplfWvMfd705jWnyTmMCj9e0Hhc+DyAqJKFof0KTpnZo9RI
 czjskOI0mz9gmowC11qk+gg7mFf+fZJ2Y2RzwumxsPUUi86vU1Y85qUOhEUSYtf7Uz2q
 uP8A==
X-Gm-Message-State: AOJu0Yy3dIkwQMn/LOuysBhh1sb7xKtPkGrKLocJY3KBWakuQMNkVFWc
 44uGOM7rRM4RIJlnislSU/c0Tw==
X-Google-Smtp-Source: AGHT+IGLnjtVrNo0zucaLxpZWdIedL2eSORk+u51JkX/hqVYUd6LUySaqJuxLCFwLlef+Pu3voXs5g==
X-Received: by 2002:a81:9283:0:b0:573:9751:ad15 with SMTP id
 j125-20020a819283000000b005739751ad15mr253416ywg.17.1692298936915; 
 Thu, 17 Aug 2023 12:02:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 i124-20020a0ddf82000000b00583f9bcd531sm42533ywe.97.2023.08.17.12.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:02:16 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:02:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Joseph Chen <chenjh@rock-chips.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] board: rockchip: rk35xx: Add device tree files to
 MAINTAINERS
Message-ID: <20230817190214.GO1515023@bill-the-cat>
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-3-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tyaLkmXfEGx6LmF1"
Content-Disposition: inline
In-Reply-To: <20230817060422.477759-3-jonas@kwiboo.se>
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


--tyaLkmXfEGx6LmF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 06:04:36AM +0000, Jonas Karlman wrote:

> Update MAINTAINERS files for RK3566/RK3568/RK3588 boards to include
> related device tree files. Also replace space with tabs.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Acked-by: Eugen Hristev <eugen.hristev@collabora.com>

Applied to u-boot/master, thanks!

--=20
Tom

--tyaLkmXfEGx6LmF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTebrYACgkQFHw5/5Y0
tyxv0gwAkj7lSlB+yWtuCZO3F3N+8QLXNKSfjKEqoVSJAJTvw9VwOYNbiXyEk7GF
vih4oVnjhWJCSlZqoHmeUohuM0z0hD86AwSBlhogZ99xp4Anjh8lhFQ4K1gI6wwY
9uncQLbFjjZYaDUuLmlIsNa2AyCdXqspbpk3hSQUpjo4FDDCip5c+pHSXsCZEto8
DD1kvg2DtURoDeYvWPNiQLbgj4cw4M99sbovhxAg+CAIFxJ8YVGgSGBwh+ItKvxe
BUfMOOkFbARA6o1v2DojpBepdC7OmlTmigIxiLMrjppnnE4Aib3tQrCesrHtONkx
2mlGkyKfzfx2O98lTMJo/DeR+3ovpPQnfggNkYyTQ8jsYVs/e6K+eTtMirtn4VaR
lw88GXE491+xXLWhRjpTJE1czdQNDHw3zAVJfdiyhyLzDGlbgADAQgOJ10fdo3Ii
SGJPa9oW2jSH064XjzFgIct+HS1ng3dpMuc0QpUZqodK5RJllc04eroYasv+kV5/
g80bLlPw
=+CoU
-----END PGP SIGNATURE-----

--tyaLkmXfEGx6LmF1--
