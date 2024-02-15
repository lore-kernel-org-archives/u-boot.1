Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5226C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 17:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62E387E2C;
	Thu, 15 Feb 2024 18:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GVbA8pHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5460B87BBA; Thu, 15 Feb 2024 18:17:56 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C9B87E23
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 18:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc74435c428so991352276.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 09:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708017464; x=1708622264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QbN02XbowR+6nbgUCfL8w/1iyTeWDxkirEMW8mSbiL8=;
 b=GVbA8pHhfhUAaI1PihA73yubXdo7LynlLRZd6e/LLc7csc7FBhUTCoj6F9PDLku9Mt
 hc76oPRsNosuwD0O54NEtEWUAyHyTMk2H5YnizzAqnWUwH3fYO8OK7L7NkTRCUl7eGfn
 q9Z/gRr2yMU9DynV7z1tOFO0f7Uregb2210xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708017464; x=1708622264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbN02XbowR+6nbgUCfL8w/1iyTeWDxkirEMW8mSbiL8=;
 b=YkQg9MnS7Pln5NjeoiLKXr/MtxwfmFwjI4aBH2WtBi9y0TW8ZHUfC+zbceTRMtKtyP
 XSI+rgoJ0pA2A7G6r4qW269qU8DbnxBMfQ2CyU+AdPVdxFd41cVUodJGOe+ar74N4/1m
 TqoLAnPh4Cm6KGNR1omgsoJHJm6qew/SlVF63jyv7iDFY/EC06qTHFOqBYat8Uwn07nX
 g6KJexwIUAkKYs2dquhgLvAaxSvjx8frldPq6MQVyckWijhHtk2HUV+mBwPIqaimczxL
 PPUW7hGtgy1F+tW3i11/wNAHtu552QppTxrO1ysS9NtZVzlmltUtHp+bq5ZLUhtwQkTv
 rGug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhU5A+sVbJYa4pM+xQNFPOXnRIjvWdW6fIjXFC0WQxlruw0/kB4NRhgvU6fjsP/KsbWjWD7QWZW8GAU21mvwiCCvlhqA==
X-Gm-Message-State: AOJu0YyMwa6DM1D+GoQwlBuYxMqv2y2w7ZviTsXKIB8Y2FYlyrR6vYtU
 ZFJJL+RkzytA1hxdVOzAlWI3DrO+co2Y1jW7CFwmT85m8D12WcRFP+6Anv6kwDnE6k3JOEl+Axu
 S
X-Google-Smtp-Source: AGHT+IEaaA7NJWX7Nt8TtrYrby4ist/FSv9r1T0Kjat9BzEE73MoIysHaILv7wTOyOv4VzqwTRCZkg==
X-Received: by 2002:a25:a064:0:b0:dcc:a446:553 with SMTP id
 x91-20020a25a064000000b00dcca4460553mr2322775ybh.57.1708017464065; 
 Thu, 15 Feb 2024 09:17:44 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 j68-20020a0dc747000000b006049c16b843sm321560ywd.145.2024.02.15.09.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:17:43 -0800 (PST)
Date: Thu, 15 Feb 2024 12:17:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240215
Message-ID: <20240215171741.GE3040305@bill-the-cat>
References: <87v86pyen2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9jRntMNMtgC/6anc"
Content-Disposition: inline
In-Reply-To: <87v86pyen2.fsf@baylibre.com>
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


--9jRntMNMtgC/6anc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 03:40:33PM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here are some developments for master including:
>=20
> - Fix avb_verify command with SD cards
> - Add u-boot-dfu maintainer tree for AB/AVB
> - Avb: report verified boot state based on lock state
> - Misc avb refactors improve code quality
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/19653
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 37345abb97ef0dd9c50a03b2a72617612dcae5=
85:
>=20
>   Prepare v2024.04-rc2 (2024-02-13 18:16:57 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240215
>=20
> for you to fetch changes up to e2f6270f2da844d598555702d3af4f2e3fae3f9f:
>=20
>   doc: android: avb: sync usage details (2024-02-15 10:38:34 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--9jRntMNMtgC/6anc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXORy8ACgkQFHw5/5Y0
tyxw7Qv/RLylIEGzMUfNgNAnRT4jIkHhI5nt4lomg1mPV+jF2/zOKhlvh9EzLzbi
mLx5SmhCKVDZJm1LO0F8KfoMDH8JWRYxaSijwTGdnSb0hUWGxLiZzaF06OCs5ToS
Pt5X5rft9Sh0+PSKMVQ4EjcwLEKYCBfPl1ChFQlWaXlejnRvcZre+3G6vTVrJy8i
bRqa7zdqmiIWZsXgaZ/uTyY1tDf+LVCAAEZhKIl8trXVGhi5u5yTtcPk20mhrHlL
ES/FIFqb9RTUPLpon9gZwktuxQfBFWHxKYYp/dpFuQ3ZxXJckGP6KmIDPbS/4lO5
24ggnnkQvaDREJCEmfm5EHHwyGEWxEoTllczlJNq0Pny7RzcBDBfrsqMUzG1Fffc
MJ2X/x/36iq8DH2Ce8KRKEGiqqAtAWVTy/C0pMh7EJZRknnXeEXGIgtiXxkawDqc
v08LebpzFvvfOFMbUdO5bw8IoByF/lxlzuFIeWS6WeYNtjb3+efngQ2lUcd/eZIH
y7bfkyAR
=v6v2
-----END PGP SIGNATURE-----

--9jRntMNMtgC/6anc--
