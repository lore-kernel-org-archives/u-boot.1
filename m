Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F817EDA694
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 15:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C06839DF;
	Tue,  3 Mar 2026 16:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cjoAf29B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9295083F59; Tue,  3 Mar 2026 16:51:22 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6096E839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 16:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40974bf7781so655256fac.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772553079; x=1773157879; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RTaWJzZArH2YQ/5+Qor3LXRozbu40hX8KG25NtNYvIk=;
 b=cjoAf29BJBFtq8Tl2CwBiP1rozUwMZH9K6n03mfqfQMhW5HsABHFzADreXHddtlySt
 jkGlPScSA0BjU+ZnXLPRxjIeiVTtCwSuE7f9Wv+WgribMb26LhgLrPj3csO41LQAcsvT
 6wIA5FVjFAD0rBvQdT5Bkx/S5wlNsuEXFiniU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772553079; x=1773157879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTaWJzZArH2YQ/5+Qor3LXRozbu40hX8KG25NtNYvIk=;
 b=ph2U1pvCORN6MpDO2lab6jfhClREpxL3aIUEBCtqokYq0fkvLsLBSA+IrjUyguN0EP
 00oxoJYjFMMT0gMBu/D6biYYjElktWSQmZ1PYgYMg1cNtdnL46b6vbD8dMgkvXIJIkqO
 cAQTMfzYWjgxV0qCmYF9nEDiVvBJ7dO6ppR88xlacPet2sL56wLfWFh7dr02ZbO9ZdWG
 jS8nFTaoVfqkDIGBZYwVzBzDAwnUqxAsMM1Xa2s4xi/mF4i8G4Qx3mmKFHJbaWpy6zsQ
 dYR4JqZIuyM7XOKu3LHruSApJ8o5+dLGnmG2VkwVurDjDPJT922bvbVTMpchY8CEZy6M
 9d7A==
X-Gm-Message-State: AOJu0YwMfVWEpXx8dqw/iF9XU8b4HlIo2u6c6gHp0mlJgipwsH7ngnxa
 H9j+9fOhmN/Dyez04uCsm1B6QMZBTWMy9rDfnYKDQLhtAd0dinC/Ygpgonrsxwqw7S8=
X-Gm-Gg: ATEYQzwY7Il1rZLYA88wkxOnL/mlTmxJgTKkW7o/yVRuzRs3lFcsUE8Qk7BqQPQ/Ptg
 JqIhygoS2O7sZ8mmB++ZttPwvZShUoo3gQMSz6YyI2yhV9z0zhj8Tvogv2Oz3SjJv78cGn1TcDq
 L0vjquHYt+KFH5+7HeA5TfVyI88Wr5r22FSFhnegnu10n6q204dmGU1jwJ2mYsFFLbmhqyElWHg
 R5gPd4+JN6ApKHfD98oDqQN5RPmic5cBN7XMcgvJBW9D8EbcY0CkKIV0JSwDcDmRig8Prnn3oPd
 DCko8DSh8I2A4YlD6lLOn5qP5imfvk4dBq48wBKec5sqA1wRdjh5GFvYMSJQALiZNh9nNWh5M4X
 5woG+abHi0UnXK4mCOarUZeqVRkj88GNiyJOTpmi8O6vB0gGlScaZ60YR5SZov3xMpIJiQSb5NM
 wKLbeHpcuL3Whqeb/mX9vENQTXFlCKmLUwA2GpEJ6PMRd4oc8KKniU8piy4Ar3cFSCV50IOvP+U
 wXiUM4QzbW5VZ1bl80paSzrtonpKhsI9wqsMhveQFAXw0tB3Kg=
X-Received: by 2002:a05:6871:a31b:b0:415:f34b:e574 with SMTP id
 586e51a60fabf-4169178aee1mr1256502fac.0.1772553078843; 
 Tue, 03 Mar 2026 07:51:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160d26d9absm15738655fac.16.2026.03.03.07.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:51:18 -0800 (PST)
Date: Tue, 3 Mar 2026 09:51:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: Binman and blobs
Message-ID: <20260303155116.GN1388590@bill-the-cat>
References: <CAFLszTgrGjthPK8uxD0fErNfgaGYawiv6ojF42sakLj7oVejQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yDi6K8nX64+3W+Wj"
Content-Disposition: inline
In-Reply-To: <CAFLszTgrGjthPK8uxD0fErNfgaGYawiv6ojF42sakLj7oVejQg@mail.gmail.com>
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


--yDi6K8nX64+3W+Wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 08:14:59AM -0700, Simon Glass wrote:

> Hi,
>=20
> At present binman handles finding/building tools needed to build images.
>=20
> There is no equivalent mechanism for the firmware blobs themselves.
> Users must manually obtain these and point binman at them.
>=20
> This is quite painful at present. Each board requires some splunking,
> reading vendor documentation, etc.
>=20
> I believe we could create a similar setup for blobs, where they are
> described in the image description (compatible string) and there is a
> way to build them, download them, etc.
>=20
> What do people think?

Sounds like something that other tools and systems handle, but another
option would have wider adoption in the overall community if it wasn't
bundled inside of U-Boot.

--=20
Tom

--yDi6K8nX64+3W+Wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaacDcAAKCRAr4qD1Cr/k
Ci5aAQCjsqBlhyW34ORaI2a3KJ4r/R4b3nRwO94rcGAhqBkFfQEAqdA8UxYzk3d8
K4oRz+4lkJHFvFl83/aMp7BBLa5XSws=
=Fwmb
-----END PGP SIGNATURE-----

--yDi6K8nX64+3W+Wj--
