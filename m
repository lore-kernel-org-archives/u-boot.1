Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9036FC369A2
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 23:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B02E88385B;
	Thu, 10 Apr 2025 01:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R4vV4bC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0AE838A5; Thu, 10 Apr 2025 01:40:13 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEBE8384E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 01:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so156675fac.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 16:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744242009; x=1744846809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5qZaK6U1nQVRqlrvoG77DVtkZVTGtkizp0cDiMkzbCQ=;
 b=R4vV4bC6qiBKBLdEl2w2GssBF9qvSIreQMlEajabzKg3JTvMqUwhklsMETllfHpO/4
 nwfsEIJUpfD4DVzcMyHG+8+e/l4Hqu+HjdsLkuXX0HwL5vhaCyNTX5vFIos8Ivtnxuyl
 vAkQtD8E5f/uxdDSY/28Av0IguP3xKo9N/Q7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744242009; x=1744846809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qZaK6U1nQVRqlrvoG77DVtkZVTGtkizp0cDiMkzbCQ=;
 b=Rz1IES1EnqEOH09XGHZjGI7Gcl2+J3r4EzNw69qps+xFCelNXgRDO+hk+YQ65dEPw0
 4AVEdCRKIqzIPm4E2NW13J0EVaxgHi/wnxb3gnKgILUtdEsWhzwyidcQF8rxOZZDoKPd
 h4tstWwg2Ox7nkn40c3QwXHdVBto3tTJ2pZePfZSdthi8mVgVrLHtI+H/Uh75nY7f0xu
 PzNlqoEKn7/PK0CJQ9pRGjNVDttA85C8GDDw4mioI25OArg+IfZ3qR9bWLszpY6ac8NZ
 MqjPoAn7rfpWGDVjCNRnicTn2TLmfPYzmwqfdAHPksiRG1LuSb7+2U7l1X8cWjY1w5jI
 7lFA==
X-Gm-Message-State: AOJu0YyktAp+D8eOeXdbKCVS7bxKZpY3AVRn/nykSfrjIv1ozoP/AiAs
 5jox4+d9rvv+DJCo+oFOHRbTwwYk3cjUTJ0dYFncs1GBeuI87HqJNReIMi0arOQ=
X-Gm-Gg: ASbGncvcxMqlJZtOKFlEqQ3mj/sjl6F4tgL0rMje4o4viCsmszNWmD0WW9mRWA4Ny+J
 q18ciq+/CqvR+fpM4icPAAurRSraR1taWU4VrjH4osl6VRA6OXZ6ThBVDxnBu4UB+NzA5nHSwPq
 Lg5k8uBt5bf/msLhq3QS9f7WoXTdgGpWzu1jtCiQGpZgsaQBYHomaKh3ZR0+q/j9vr6QrwCt7nZ
 VmhdTzKtawHCqjiHASZ0oE5iJETOF8kMauUI+rfhOaY4LCoDCQrMWsQGYa0w/Fx2S9VXNGsXnUc
 W3Lb/3r3/YJ+K6pv07vSlel8o+QN/GTnguPlavcFiIZj02/lrm4PfSkP1wBzztZB2aRmqX39gTM
 FTQ==
X-Google-Smtp-Source: AGHT+IH7VMTmo/jtKBgJw/oyE1QFSlMnx+PUmmhKcnxvSoZI0+rtzdL2tKRTt4YY5XR+ol5t4Xdt/g==
X-Received: by 2002:a05:6870:9598:b0:2c1:7165:7dab with SMTP id
 586e51a60fabf-2d0b5bdbd43mr206931fac.20.1744242009493; 
 Wed, 09 Apr 2025 16:40:09 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096d4a8e2sm431349fac.47.2025.04.09.16.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 16:40:08 -0700 (PDT)
Date: Wed, 9 Apr 2025 17:40:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>,
 Jixiong Hu <Jixiong.Hu@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Uma Shankar <uma.shankar@samsung.com>,
 =?utf-8?Q?=C5=81ukasz?= Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] RFC: ext4: Add a few overflow checks in the writing code
Message-ID: <20250409234006.GG5495@bill-the-cat>
References: <20250409210245.540952-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kZmb1tVqSE/wh229"
Content-Disposition: inline
In-Reply-To: <20250409210245.540952-1-sjg@chromium.org>
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


--kZmb1tVqSE/wh229
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 03:02:37PM -0600, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Some memory allocations make use of data from the disk, so add some
> overflow checks.
>=20
> Adjust LOG2_BLOCK_SIZE() so it is easier to read.
>=20
> Note: This is a trial to help figure out the best way to deal with these
> sorts of things. Feedback welcome.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
>  fs/ext4/ext4_write.c | 24 ++++++++++++++++++++----
>  include/ext_common.h |  3 +--
>  2 files changed, 21 insertions(+), 6 deletions(-)

I'd like to see us grab the current include/linux/overflow.h from the
Linux kernel and make use of that rather than further call the built-ins
directly. But yes, we should do something here in general.

--=20
Tom

--kZmb1tVqSE/wh229
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf3BU8ACgkQFHw5/5Y0
tyy1NQv7BgGDSZPD7YmneSgQueu4RXy3jyg2L7jQ7Ge/EmBwZ3JvbLi3kIscXsBt
rFLa8lnJ+dmBnVS+p9yzB/HUWsHwboQLIKj+AMivmY87/DmNiaa68nhobgg8XICc
qUxaDDrIStUpGWMwOYOO8m9z7AbfD3VxABE7lkOeKiq4+lM/K6qpT1W12Twm6Uky
/L4rEvpkDmmHLdzNCxME7iCgsQBiiWIw2sYwwEM2UU3hhK9KyfRmBdbvUEQWojh4
X13axmTGmyVDQBheRBw3uZgTT84hCgZEECRGH58MZtf8wXA20+VCPL6igrLUT86z
HXQ1pCYkuuAqpKADBxrx4GcJXbWp+fsu4Z0dB3vKsrYnUPetfj6YuQqtZlotlBdk
OtEXUPvvxHNfp8Qe1AFlnTs1u9WcuK8TUYrDauPhFNeLa/pCPwPBAaP7eLoT/Ffl
HZwd5b6o9XeMupr0KyqRjf7BYL11jNwShdQHwiPb/dbvRgnnTaTkHWlDFoRLfsGw
QbVcMGxt
=2r7I
-----END PGP SIGNATURE-----

--kZmb1tVqSE/wh229--
