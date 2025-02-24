Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012C4C021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 16:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA4D80079;
	Mon, 24 Feb 2025 17:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i9MXs6H/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62ABA805C3; Mon, 24 Feb 2025 17:31:55 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDAC80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 17:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2211cd4463cso92484165ad.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740414711; x=1741019511; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CcPvOiKUQx+9L+Ip6oHu0xBg2rLpzB4KKOYSYxA6odk=;
 b=i9MXs6H/m8bzV6oxcEEi/zlcjAG9ejrdfbwMlzHjd9zZYClS2amkgcBG3U2SEiVcfj
 ZA2fOnuKgDgxuWM+2lZtKZIx20alcIxvb5pmgCcNAh/Hp2DaqX8CW3AfEg1ydJv0B6JY
 0ObRJaEKyAQ5m/r9gZQI+sD9dS10SpO34mVMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740414711; x=1741019511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcPvOiKUQx+9L+Ip6oHu0xBg2rLpzB4KKOYSYxA6odk=;
 b=DqDkn3+1mtUQV6pOztGdporgHy1Iyvefd0KBtF4SL2EiuJXrHvfKU0zkpjya3y4Jzm
 LAJyWrYOgL8fML2WDaohVD2b3DFk16QdlueNn+6E+8qmXw90Gx0tIv442sYyXCznWd/I
 eGY5H/kdt1kkY4UGa4MrMEI76aqrVjudnqXhNjg9mTxKEvCLkQbxpdxYVxfjwO9Ieccj
 4u3YVWa6kxtJ5S5bwXCDHvY+wz1vVRGKxIo5ReM5GF9aRqPRmcofo7pZHIeI/x360Ko1
 Gh7jJoZVRh7Zs8+DGWkHqHNkgrbhOQ1iH2KfcKEGjLT+pUlnXKgYxN86JDB6AMC8IeKO
 3BbQ==
X-Gm-Message-State: AOJu0YwVkWFRi0VyrEEa2lN4MFSIR+cB6+/YYcXsuTQKDQPwMwfeXrTe
 a8aFC8hWFtPjTzeK28ke+luv6MO44iWLewCTHt+2M2R49crEdBlw9lSRXGfWqWoMdxZJHHGMLdp
 P
X-Gm-Gg: ASbGncu6uoIBZflMB6nHMlL12NfSmOWo0Nql+qbDH9O1napHM7SdwurlPBrxZltj3D/
 wrpExDAvLW3SFIOgXGyac6j22Fec4uZOjk2rFm5XywZcLynbOJlIIqUSIyJAVM1hyxxwLHndStF
 +uuty/4dTDj/SdyHwho2Quks1X/MFtg/J/qvGL0aQw0LEfB2autg4foL8Vo9PNFIUY7J+DBW19k
 pkA7CB0hk2zzTXNrjfTa540pFCtPfAZkUeYovRa5ivN+sy7DYzalo5Yp7sm/XwippJx4lzOwHJT
 XVeoGs+v5Vg9+uL03vzREj2/
X-Google-Smtp-Source: AGHT+IFUB45QQaZDK4gD/97ozWugdg7ussffPTfPSKhYut+KGcZubNobPqYlyiOy48L8R18NNsp98A==
X-Received: by 2002:a17:903:8c5:b0:216:794f:6d7d with SMTP id
 d9443c01a7336-2219fffaba2mr252532985ad.48.1740414711286; 
 Mon, 24 Feb 2025 08:31:51 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d000sm183028975ad.111.2025.02.24.08.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 08:31:50 -0800 (PST)
Date: Mon, 24 Feb 2025 10:31:47 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org
Subject: Re: [PATCH 0/6] Add preload_check_sign tool
Message-ID: <20250224163147.GA2318847@bill-the-cat>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
 <174015949809.3526942.13114735137909191703.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jJDPtgBkPfE0tDdy"
Content-Disposition: inline
In-Reply-To: <174015949809.3526942.13114735137909191703.b4-ty@konsulko.com>
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


--jJDPtgBkPfE0tDdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:38:18AM -0600, Tom Rini wrote:

> On Wed, 12 Feb 2025 10:31:20 +0100, Paul HENRYS wrote:
>=20
> > This serie of patches adds a new tool to authenticate files signed
> > with a preload header.
> > This tool is also used in the tests to actually verify the
> > authenticity of the file signed with such a preload header.
> >=20
> > Paul HENRYS (6):
> >   rsa: Add rsa_verify_openssl() to use openssl for host builds
> >   image: Add an inline declaration of unmap_sysmem()
> >   boot: Add support of the pre-load signature for host tools
> >   tools: Add preload_check_sign to authenticate images with a pre-load
> >   configs: Enable the pre-load signature in tools-only_defconfig
> >   binman: Authenticate the image when testing the preload signature
> >=20
> > [...]
>=20
> Applied to u-boot/next, thanks!

Unfortunately this breaks macOS building:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10614&view=3Dl=
ogs&j=3D35eccd4a-c7e0-5052-1111-1aa0b6b36326&t=3De725091b-e4d8-5b5a-ef22-f5=
1d8214ad12

And so I need to revert this from -next, sorry.

--=20
Tom

--jJDPtgBkPfE0tDdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme8nvAACgkQFHw5/5Y0
tyx5+wv/c1e2GRj+4Ot+Bq6jXd/4+/71iae7S3lGRkNQ2eWEFqV9p6qhP7c1/VwB
htpOjKXYe+wVXiYPHvpK3xXliZUQr3zAr5g4s70PIkPz0uRfUqQdcC5eKUyvlMJq
OkIqfS/ohyyiiRwu4Q6p+xZDYHacACcL4BEcRp5t3rAu2RG4u/fGI5nnzK+UefZA
m+usacHjvQk2HuVBadZIccQJ7a+CuSuczN0kdbUOib9W6LomDm9Zg98/DlKkjuI3
sgfEQAEy9cyS96gMI60LbsNzRw+D0iOb0CqAPCfGRjnLQ43VMnFNC75PyChNsLww
J7QF9hPCG9UgHnw2QCs3LCbzZdWxkgZW8zISfIbapdoo2s0DKjIhjvd5rS7SfqIo
cZUSc65D4m8wRIcXmnxk5x4yFg2skt3pqE5qDPaVhMtmikR+MQvG59dxOG5LPGJI
QQkAZKWBuwg15MOe3DuaaJntjUI7582dzsIivmFlsEWgD5BJ60znHRjut1GYrYU5
lJPJqv2Z
=QZRn
-----END PGP SIGNATURE-----

--jJDPtgBkPfE0tDdy--
