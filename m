Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD6CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 14:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6880C80422;
	Mon, 20 Oct 2025 16:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sxS54CHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF10807B1; Mon, 20 Oct 2025 16:23:14 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09BF80107
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c2823c3475so2221344a34.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760970190; x=1761574990; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PRx4EL5BmzcCi1CzcVBtVTsIwII0oYq3yZye7l9HinI=;
 b=sxS54CHXJQaA69SQQOPfRZB5i514G6gqG8VRU12MOICH7yRP72Ic+sHqXDOB47KuZz
 4QUaecZxY86W4q6YIeOGO783308fu4CuJ4qO03mUgya4EiRMC2YffBdysW+Zmqk85Iwy
 IV6ZcJ0UvWoK5GHJu1oslTB9xxodyd0O8WGpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760970190; x=1761574990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRx4EL5BmzcCi1CzcVBtVTsIwII0oYq3yZye7l9HinI=;
 b=o9ej4Clf8VeMrhGqnhU38JIfJDsOIb1WnxEmqTjdYBKE5qpo0RRMm145ofnNrZqozE
 Y7ogbFe3YfjP48IF2ZkN4uevBxGSyPytYQUBc7UiGXEsF+NNzqm8YqnfTPyRpvliHMUa
 bhkfmjNxztqbFiaN5T4HVzzSi8lMH6dNFvEM9L3YfLqTUbqOcrH/C5JUK0sT7/eU/18k
 5tShGgIk0C1mhBT9n1fgeV8qsPsHUC5LOqglLwl4H2oVOPIOSz/QgMtzkB+4uVVPgxmP
 5UElfIWNfhJIVzKnBGj/HPUqMj1fJuWAJZy/o0Xj63/AopBmprw9LhLSSkeDNVt2NDwi
 Eryw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs6jBPJWU8HgMP1nOKSdRo1LUIIbw0ZoH4R2EToIF6j7pE7hymRZCumli7LHeGFTMFjAshB7U=@lists.denx.de
X-Gm-Message-State: AOJu0YwIXm5VVjcgC0WSimu6PjhsvcC7qM4z1UsSOv7bYdhxvQyiRzUm
 QjrNWzd3Snhqq2JD0p4nd69Qbtp23LJ+186S5doXeyhTqR4DgmkyiIWmkPuOg6VfG/6XBm4kgxV
 xbqnScnw=
X-Gm-Gg: ASbGncscnkysSGZXo5JFGEmFbXTQaJfEIg7JUkEFfMjTkgafrq72XIqVH2U+pkIKniY
 FD5EtstPoVUZZjkRDWHLnhNzCQMv+46da11HJHUOMKaSZw9Pp7EvAxKIjWP6RaWFCJLOiDKJIUZ
 7ABwiufW4SR/+V4ns3sQCOYWG062ZIZuNLopVuhULKCX8SfT0FA4IMKVmrtLuhWtjyguawwA0Lk
 5/AhmECrp+piWng6P0XVHV3ZLi+d1ivF2blN2R2Wj72yuIROSY4XuKUfEXAMWUbtkYX4Q7we5a7
 mpuXtMMRnHaJqwKzxXrNxt1d/bti8uU2Hao93+1PuGogXERpyZEyZP9OvDsIr6mj93fcMcw6KhS
 QgEFyDzcA6x4eUjHKw81wDwKkc+/LIvq4hR9gdDydxzTpYKoPMkRZPBCET137cHrWWcvgQrCydD
 x8mvRJfXNfKf2vBkvyZxEXZatTHNfuTtJKBH48749oxgdXlXCgC51ExKPatU5w
X-Google-Smtp-Source: AGHT+IE6DphhVplPRVVye6gHT9h+Z23fSeI8ghAH/mxWi0CjA+s3l7cWkEQLFaHNC/2A1/C8PrmHjg==
X-Received: by 2002:a05:6808:1795:b0:437:eb1d:cdde with SMTP id
 5614622812f47-443a2ff45e4mr5150937b6e.33.1760970190592; 
 Mon, 20 Oct 2025 07:23:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d3edaf1csm2016042eaf.11.2025.10.20.07.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 07:23:09 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:23:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 08/24] clk: rockchip: Remove negative error returns from
 clk_get_rate
Message-ID: <20251020142307.GU6688@bill-the-cat>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-8-5f80f827407e@linaro.org>
 <aa7d67c4-5abe-4a71-89b1-866fb677d232@kwiboo.se>
 <4f84711c-8d08-419f-bef6-ff97858751f8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4u7ABQejZ/+u28e6"
Content-Disposition: inline
In-Reply-To: <4f84711c-8d08-419f-bef6-ff97858751f8@linaro.org>
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


--4u7ABQejZ/+u28e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 01:03:15PM +0100, Andrew Goodbody wrote:
> On 19/10/2025 21:28, Jonas Karlman wrote:
> > Hi Andrew,
> >=20
> > On 10/15/2025 4:32 PM, Andrew Goodbody wrote:
> > > clk_get_rate() returns a ulong so do not attempt to pass negative err=
or
> > > codes through it.
> >=20
> > On Rockchip the clk drivers only implement support for a subset of all
> > clocks supported by the hardware, mostly to save space for TPL/SPL and
> > not having to implement logic for clocks not really needed by U-Boot.
> >=20
> > Because support for all clocks is not implemented the existing working
> > error handling actually help us catch clock issues on the Rockchip
> > platform. E.g. when a clk is referenced by assigned-clock-rates in DT we
> > get an error and can fix the issue, or decide if we can safely ignore
> > setting the clk rate.
> >=20
> > I do not understand why you need to change the way the clk ops work,
> > just check with IS_ERR_VALUE() inside the clk-uclass or similar if you
> > really must remove working error handling from the callers.
>=20
> OK, so here we have a question and it is one that I wish had come up in t=
he
> original discussion. IS_ERR_VALUE() and other related macros are from
> include/linux/err.h and are introduced with this comment
>=20
> /*
>  * Kernel pointers have redundant information, so we can use a
>  * scheme where we can return either an error code or a dentry
>  * pointer with the same return value.
>  *
>  * This should be a per-architecture thing, to allow different
>  * error and pointer decisions.
>  */
>=20
> So they are clearly intended to be unambiguous and used to add information
> about errors into kernel pointers. It also suggests that there may be oth=
er
> implementations of these macros for other architectures.
>=20
> Much of the error checking of the return value from clk_get_rate() is done
> with IS_ERR_VALUE() despite the return value not being a kernel pointer a=
nd
> with this default implementation it does happen to work just as long as y=
our
> clock rate does not collide with an error. OK collisions are very unlikely
> but it does still feel like an abuse of the macro to me.
>=20
> Is there any official guidance on this use of IS_ERR_VALUE()?

We don't have any, really. So my question is, given the use case Jonas
outlined (thanks!), what do you see as a good way to handle this?

--=20
Tom

--4u7ABQejZ/+u28e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZFywAKCRAr4qD1Cr/k
Cu4jAP9bRj1cBEE2nlpYD4H5ft9ZHoVWGoRLxk99vePQFmIcUQEA3vWdiFIzzDu/
mI9Ud+qnBO2C8oIvUb0VgRY/EGAHbwY=
=ZAUB
-----END PGP SIGNATURE-----

--4u7ABQejZ/+u28e6--
