Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7936EC3A59D
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 00:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CEC88163;
	Sat,  6 Apr 2024 02:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PVKnJZPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F1B87ED0; Sat,  6 Apr 2024 02:43:52 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD57882A8
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 02:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-617d411a696so11393027b3.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 17:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712364229; x=1712969029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8vBL4b0RJV08YyaiA3px4pJnJfKLmKkGgPlD2yQT6JQ=;
 b=PVKnJZPkYOJfMcNnuxAaDwHh65YAgbtFlnxq/5DFZLkAMUZP7YdnnwzBXiAe1L70zb
 myHLq1hAT+o9usEhToXCjZdtTzK0FX5a1iqYNP/oFsRgWgvlPng9U5ddTNHMXRrbFPP0
 Ut8h6fGUYVmqyQgfQ8Ms288aMm6OP1KbGUu9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712364229; x=1712969029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vBL4b0RJV08YyaiA3px4pJnJfKLmKkGgPlD2yQT6JQ=;
 b=lMUtOTmSPaYpEDTxeuvHvQXr7qax+dKuwW5Y8aLiA3g160va1MUb+MJJn3wjGrFNOr
 QNYh6EYlAw3UvMvUiTlcYBJMKR7++J1kuXmWIwJo0Vks9PgXd9FBEYgnsFuxFnrOTYF6
 AKIBIu+PNgZu6S96w1ycy4Jl0zvzrL1hrnYSta6ezyv6mnG46kU3adPEbndEAw/GBCmm
 vWpjNkqSO+bhZNge/YaYuuQ1DZYAVSNF76AOUZKIsH1eGiqoPQav3bpgep/AYHbfNCGD
 8on2h13CCEIzBF6+KiLXzr5PiB2aWdyOCb2YY94aEFz1qTAcMBCADLDtV/5pPdtavKa+
 j1cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXee0fXcl/MPnquKQTC/6+7w7IAiS7XtnEdfw07+cpCkrAOSN4rXDJ4IW0+YiOPOT/BVfN6PM5uipAGJg8uoC6nqY60kQ==
X-Gm-Message-State: AOJu0YyL1FZ5zXwtXT4FuXdEx3pl2dBMYQKKwJwIr5467wJe/rMWz/9V
 biRpdvR8s6zT/IdusY9f+6JNuzvgHbr4P4Zxr6ylWPcjWAVO9LwEMOsrFBHxjqM=
X-Google-Smtp-Source: AGHT+IGjOWjQkD+5XSKbNE1NQ3bOBPUfzJ/IV3qfqNRS2edwn4b1CCUxd2llOtOkS+DnaTqiL5t3aQ==
X-Received: by 2002:a81:c251:0:b0:60a:2c16:da3f with SMTP id
 t17-20020a81c251000000b0060a2c16da3fmr2964497ywg.28.1712364228933; 
 Fri, 05 Apr 2024 17:43:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 ew10-20020a05622a514a00b00432bcd630c8sm1243539qtb.93.2024.04.05.17.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 17:43:48 -0700 (PDT)
Date: Fri, 5 Apr 2024 20:43:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20240404
Message-ID: <20240406004315.GC114971@bill-the-cat>
References: <da4b216a-fc52-4a1c-8ebe-2509ab36d7be@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l+/0QHsDmZfbaR1g"
Content-Disposition: inline
In-Reply-To: <da4b216a-fc52-4a1c-8ebe-2509ab36d7be@linaro.org>
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


--l+/0QHsDmZfbaR1g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 06:52:53PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> Please pull this migration to OF_UPSTREAM for all Amlogic SoCs family
> except the newer A1 family.
> In Addition, there's a few fixes & updates for the jethubj100 board.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea=
1a:
>=20
>   Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/c=
ustodians/u-boot-dfu (2024-04-02 22:37:23 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20240404
>=20
> for you to fetch changes up to 114df8b5339e503b50b6ac1a61bf1daac57c2e11:
>=20
>   dts: meson: Drop redundant G12A, G12B & SM1 devicetree files (2024-04-0=
4 18:48:46 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--l+/0QHsDmZfbaR1g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYQmqMACgkQFHw5/5Y0
tyxu6wv9GcxGpcELDwU+mn70PrdDGHUQ/Z2uC42t80etcf8BzDrBELby47wVzJ+R
STJ1I9EINjyYKFBJPZlG17PZ/GOcOiWpaAkbEdsIj+skLzjVkQ559Azg6Nw1LTRW
46QvPAlraIAHJ/RkOI1qzJ0SzZUlMgRtIoMdsTGTtmdacp67oyLlLXwEShIfGQ93
64brsQEVyO9nCUa5GbWnd7vPVqglk2Y7TdIqfAQTdHk02wFOCD2/6zVRhuhsPS6E
wWR/oslI4msoBf5ySbCLH+LRU9/mYu5QIFA9sSh3sreME7AL4O5Ykof1FqRF1nA3
cP++5wuGWue+q+z+A80tOlIeeQ1P5tEg0KOvHnIgverxyR18w2Qgid7JiPtKX5un
db2wjDrQi63gHgmo5Q37wP6PHVE/UFo9XchL+awYdRFJU3QjKZfn1gtVTkha0xbI
uQstaVxPYII1T9fnEgLYqrfgKAm2PPBPqxxuSaxu2NU91fuccbaRLQArDw30tMl8
nJa394uW
=rA8r
-----END PGP SIGNATURE-----

--l+/0QHsDmZfbaR1g--
