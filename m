Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C62EF531CC
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF58D841CD;
	Mon, 13 Apr 2026 22:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EiGcopI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF2D841D5; Mon, 13 Apr 2026 22:23:22 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC87839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso4402453a34.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776111799; x=1776716599; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L0QEkKel+blg6CV7eek9A0BmTsNHWrG0+6acwlBtTN4=;
 b=EiGcopI1LrFvNrqw0F2OvtPtFzJJfFe9i5wikanpWTMn99G+JvrNSiKqNj7UYqsAl3
 rjo2t+f33TUHmdb8H17zdRVxUWkzFUCPmhPor2gdtl9tOUKv2DhjNZ5O0HVAmU521wVM
 yAkFHjQfnIfv6NbJ2MzqQyKu9kYOjkNAdkBs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776111799; x=1776716599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0QEkKel+blg6CV7eek9A0BmTsNHWrG0+6acwlBtTN4=;
 b=JrnCPHSRO/BjhECr1eMw/7gmru5oCNIo8DBRL1bwoJFu9KVrv7178pRZ1AgycrAFJn
 gkoPAcja2hVSX8aaBF6r5US5mr9polJZHPC4RLmyK8YL/CJ+ESJmTmv8m6gqbZ9+VAv1
 BprVYg2FnBWZGnKI1C7AExXoxcybOpVMb8brQoVL0XCbSrxTrkzY1YQuwpOicYdyI0z4
 5iDdP3ZrMjaTFJMikcO96I0KXdsPdQh6LQxNRgt2nmU4SL4+/z1I+aOI1L9TAIvWRuD2
 s+evv/hy+MxKPV1s/o0exbzQui/uOSyixC0tUIbyXUoQJSAsQI0PgCB27JEe+MfJx1ib
 XuvQ==
X-Gm-Message-State: AOJu0Yz3xb5XAaJ7+OnEVJP0Ct10q1H6We1gJGieXsd13mwjK48bzenV
 kZ0I1jdTYA3qPf0BnfDi0royKHxW8kvMRMwEeeJdeyAXFCt37KXqt21fVjPVMu+KK/0=
X-Gm-Gg: AeBDieuvHv/WSt05OW6DKI1jSdC82Gxs8bx0wKDDZARQJgIdWIHIsz0lNFPicIHDZKN
 lFpPHeVuUIMmi+3+BCPtuElLNaxL7o5g1PVNN/joyjcL1xHYUsBHubj+iCZgY6jTTdibDTcvpL8
 9VKi2TtFTOkFMf89SjLpXyRMLa3YmTS55BnidbPICkDlo5u+WOywm8zKlw2r/tcr7989g1ROPlm
 eHewoY/wIIF/diCjNBY9gN76kPjknOZr4f5cN1P3zyY8Oqe7sUIKS/T34ZuQQBg/MlepjAWaQBg
 OQpHdi3QPCWU6Vna5ndCIVJcmADHsLRXSScjb5kAmJfCbEUrxUYB/qcmcqQwVdBPl9EDgRjeSFw
 ftuAU9arSNIF1Jcy3dAFv4I/Nafsoi0hi/Z5PDaxjWPr8Hx88t9E9inFB6dFNds/dX1H4fgwKKi
 5Wjk3Gcvg21KPVZoVvUqCHp7PrYfUlUAc0Doazt1XLO+3Yr2hMCkGNTJHodsIoqobP8UWOrDtm+
 7yJim1WWT+tXy3SbBh5S+VGceG+nYsgMWVAb0wscoKsGIIcSXA=
X-Received: by 2002:a05:6820:6184:b0:67e:16b4:aa0d with SMTP id
 006d021491bc7-68be7ee6b04mr4587127eaf.30.1776111798868; 
 Mon, 13 Apr 2026 13:23:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc88c7493sm6397971eaf.7.2026.04.13.13.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 13:23:17 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:23:14 -0600
From: Tom Rini <trini@konsulko.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 "LOK, CHEN HUEI" <chen.huei.lok@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule
 tool build
Message-ID: <20260413202314.GH41863@bill-the-cat>
References: <20260319112717.7805-1-boon.khai.ng@altera.com>
 <20260319134809.GR502704@bill-the-cat>
 <SA3PR03MB7187764E2EBF3FACEF2619DDB44FA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20260319161609.GU502704@bill-the-cat>
 <SA3PR03MB71873A4FC785BA33DA3FA714B45AA@SA3PR03MB7187.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6aQ7XP0id/YYseYM"
Content-Disposition: inline
In-Reply-To: <SA3PR03MB71873A4FC785BA33DA3FA714B45AA@SA3PR03MB7187.namprd03.prod.outlook.com>
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


--6aQ7XP0id/YYseYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 12:46:32AM +0000, NG, BOON KHAI wrote:

> Hi Tom,
>=20
> >=20
> > That's a documented host dependency. We generally don't want to disable
> > general tools even if, sigh, I see a few other boards are also doing
> > this now.
> >=20
> > --
> > Tom
>=20
> Can share the link to the documentation? I tried to search tool the U-Boot
> docs.u-boot.org but cant find any document related to the host dependency
> this is only what i found https://docs.u-boot.org/en/latest/build/tools.h=
tml
> but didn't mention about mkeficapsule.

So in https://docs.u-boot.org/en/latest/build/gcc.html we list tls.
That's not to say our docs could not be improved and expanded on, but it
is there. But with that, you have a stronger point below.

> At the same time, i would like to clarify why this is more than just a mi=
ssing
> host dependancy.
>=20
> Since SoCFPGA does not support EFI capsule updates, the automatic
> enable of CONFIG_TOOLS_MKEFICAPSULE actually not reflecting the=20
> actual capability of the platform.
>=20
> Disabling the tool explicitly in the defconfing is an accurate representa=
tion
> of this board's feature set, and this is not merely a build workaround,=
=20
>=20
> and, according to https://adaptivesupport.amd.com/s/question/
> 0D54U000086ca7RSAQ/toolsmkeficapsulec2110-fatal-error-
> gnutlsgnutlsh-no-such-file-or-directory?language=3Den_US
> installing libgnutls-dev would suppress the error,
>=20
> but this will leave a misleading configuration in place.
>=20
> I'm curious, if the intent is that the TOOLS_MKEFICAPSULE should always
> be build, perhaps the correct fix upstream would be to make the gnutls=20
> dependency a hard Kconfig requirement?

I've added the EFI Loader custodians to the thread as well. While I
think tools-only_defconfig needs to enable TOOLS_MKEFICAPSULE (as this
is what generic distributions should be using when building the
userspace tools for a generic case, in order to have maximally useful
tooling), I'm open to saying that it should be "default y if ..." some
other symbol that means that a given platform has in fact configured the
rest of the system to support capsule updates as, you're right. If a
board hasn't done the rest of the work to use it, the tool is not
useful.

--=20
Tom

--6aQ7XP0id/YYseYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad1QsgAKCRAr4qD1Cr/k
Cir0AQDFtsSDMFXp33ymZWf5vI0oEsAV2tXvhLzstaYP1fSJqgD/UIQA34XgC7Gy
qBO9rzaRYWkqfB7R/1Fguilrl8JDMwQ=
=d4jx
-----END PGP SIGNATURE-----

--6aQ7XP0id/YYseYM--
