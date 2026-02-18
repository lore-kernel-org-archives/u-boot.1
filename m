Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6D8E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 14:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03C583AA9;
	Wed, 18 Feb 2026 15:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F1s2rDlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CF783AC5; Wed, 18 Feb 2026 15:12:31 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2676983A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 15:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-463a0e14b4dso1150879b6e.0
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771423948; x=1772028748; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yqPvCbE3wSXFpZYZX9usY9d/uT7SNVz8RJEuxyXqiXM=;
 b=F1s2rDlCAsHllTocpMI+O6PZ3q19038qC/9k/JqRBpdJefi+ZOmUpO+KqrrQSIt84M
 lT+O2ImwUSOLn+TEkuIaOWKWGuYsjNLz22RXGzp6FUut5V9pTWUYobqTy4o/zRaqLFwe
 FZpiyfNjCO8eX2yX8hC2O+sTuelvkEUQHTqhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771423948; x=1772028748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqPvCbE3wSXFpZYZX9usY9d/uT7SNVz8RJEuxyXqiXM=;
 b=tde9GWZfjp3cQXPR2W3xlagdNoeUo7SDbAe4HAOSU9FN3r21OBj8JbGodYUBNogixn
 88KQoQjpgPZN2wsmMdkhmvVJ2H9V6JYyJ12MGunl60wndsXteu8VBCKCzi1c830LGDb6
 1DLL9ftZJZnca8KkMcODCkbw2oaCuo8gItBE44csOo4vR2ivoCvhztw/pdLoL/bExVzv
 rdy6gL1JxZXw9eD4QSXoGqxAka89d8MzO9GDJ7EFgn5zWmk9QSk7WAtCfQW02grIJNAo
 SCJm+rYJpHxtHsDAZm+PhriFE6q/XiCiNeYBTbj4O7yWUeqrQFQI8K7ZRme9svu07k13
 a9/g==
X-Gm-Message-State: AOJu0Yzr5fHrXmdC4iHpt30oV97sClzQ/ifjSdBqWSQwmZUajhz9lQdm
 kitfmqJp1Ng5y9wkIQEvc2k6R9q7ZDyoneodE+GCbCruYBKQ9qvFjyrd7d5EzJuLLUk=
X-Gm-Gg: AZuq6aJny26slbj8WsXr1pST2fB4DjVtZb+B1EMloskK241o7P1csDnxc0Uu2kCEjtc
 rq2Ert11j7Spj8fU4ulK33p7bR5Av6bS0iAwRT+poObKVHVnTP9f8CKFv3WiNOvLHYC55XbASRd
 QYR4R23kcVVWOMuyDeryOrdkAkun9gAPMbGxu/n5X+m/cjzBfb241xORqpzIhzaU7zG1fML+MfC
 J48W3E8LgbVhgXidzC7n5OP1AvUonMOTPkKkukkwiMjUQM1O/DZz2lHfO7hCh8qChdC7dmA8uLt
 qXwKtANqTtmDKsWQo1adQec8EOYFVgU+s10TD5OYppdK8JcYyGIlRIbQHvWNQBLZiz537Dtg+4S
 62+VnWotDkAB2bkhQuS0A7t3BLIFk456o5mInLeKEl20zVQrgUilHpgXKsLwPmZnyrrMgk5pELk
 RJsSSnpkDG1ZorpxzaAMs2Dp0p7zMSQXUrkJmWvwUBK6b7M5cSGZDanvi83JeAzc1b5nCubCjrZ
 U8t4kYFB5EnrqBH6J1Fp7liOcOG4U6zAJj5OsQRNSq3LHs6XTM=
X-Received: by 2002:a05:6808:6604:b0:45e:801c:a0ea with SMTP id
 5614622812f47-4639f1bc93cmr9593744b6e.32.1771423947803; 
 Wed, 18 Feb 2026 06:12:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-463b83bb884sm9609910b6e.11.2026.02.18.06.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 06:12:26 -0800 (PST)
Date: Wed, 18 Feb 2026 08:12:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH] xilinx: mbv: Update stack, heap, and OpenSBI memory
Message-ID: <20260218141224.GA3233182@bill-the-cat>
References: <20260218063329.396968-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mBcHdf8gClueDDQF"
Content-Disposition: inline
In-Reply-To: <20260218063329.396968-1-padmarao.begari@amd.com>
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


--mBcHdf8gClueDDQF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 12:03:15PM +0530, Padmarao Begari wrote:

> A 2=E2=80=AFMB region of DDR memory is allocated for U=E2=80=91Boot SPL, =
with the
> heap starting at address 0x80000000 and the stack at 0x80200000.
> However, U=E2=80=91Boot fails when using OpenSBI v1.8 because OpenSBI beg=
ins
> execution at 0x80100000, causing an overlap between the SPL stack
> and the malloc region.
> To resolve this conflict, the SPL heap and stack are moved to
> higher memory addresses, and OpenSBI is relocated to 0x80000000.
> The SPL heap now starts at 0x8C000000, and the stack is placed
> at 0x8F000000. The MB-V requires at least 256MB of DDR to run U-Boot.
>=20
> 	_________________
> 	|		|0x8FFFFFFF
> 	|_______________|
> 	|  SPL- Stack	|0x8F000000
> 	|		|
>     	|		|
> 	|  SPL - Heap	|
> 	|_______________|0x8C000000
> 	|		|
> 	|		|
> 	| Full U-Boot	|
> 	|_______________|0x81200000
> 	|Load FIT Image |
> 	|_______________|0x80200000
> 	|   OpenSBI     |
> 	|_______________|0x80000000
>=20
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  configs/xilinx_mbv32_defconfig       | 4 ++--
>  configs/xilinx_mbv32_smode_defconfig | 2 +-
>  configs/xilinx_mbv64_smode_defconfig | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

As general feedback, this is something that ought to be in doc/board/
somewhere too. One such existing example is doc/board/ti/am62x_sk.rst
and follow-up patches are fine.

--=20
Tom

--mBcHdf8gClueDDQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZXIxQAKCRAr4qD1Cr/k
CoebAPjBBTpuA2CH7JXTd4WnlueXrtir+mMTBI7hL/rJQZphAP9sexGeol7pFMiu
DuOXitfqwDRk1ozanfbSLkA2pcbiAg==
=4K8L
-----END PGP SIGNATURE-----

--mBcHdf8gClueDDQF--
