Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B14CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41080880F1;
	Tue,  2 Apr 2024 13:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uCMp/5/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C21880F1; Tue,  2 Apr 2024 13:03:26 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3B6D880DB
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6147942ae18so27666887b3.2
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712055803; x=1712660603; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UaFQ8E4vdm0kTulfiGu8n23afLfbjNO/v7syx96SXek=;
 b=uCMp/5/N3rFeExzly2zpr61cHIVB3u3/+/wI5XhhNLzdv2SvsoWhICEjATpBYYjq4d
 yxvqrI7cjqFM9wkbLP90rg9d11x7lb18sh/qDzZh7gkEh0VTSFtXZvAJU9zpkULzTUcj
 gZ/zXpwMCKgv2u77JteMWXiyBfUyWxumQgJi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712055803; x=1712660603;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UaFQ8E4vdm0kTulfiGu8n23afLfbjNO/v7syx96SXek=;
 b=fu6vDfefi/hQBb2Rvster51MZ5R63Y+RrHh/wkjbsqjYkYTeIx9S9+uIVP6pNtaWUy
 GV0KegDuJlojrdNyPCVcyliHluOxUcTWs0EzLHJgnDodPhWKpayZM8EqrXfXg10vAUO1
 vlx01CUckzfeB+BEVhJMlagIJxuccC3THU8o719O7jsTu9upgoASWHFReB7koiJvE1Eq
 8Ah1zVmxQp1E6z3jFDsv8gpTSQ7EXoCncdesUJHS5nvQMzM54yF0PkpkyIfZsHGZMBAJ
 dkr7QTRo94gu9W7JAIM9QKubd5TkNrxIQyPSomqVkpNFjpXvEqcvhAzGbV13NjMwZ7dv
 wq4g==
X-Gm-Message-State: AOJu0YxhFHsav0Fhx9gB15sQ+LVNShDw1emWkDZWYX678kcjeKl2J51y
 HNLutYTLMMi99quBjuImbRwCq8MWorb1mAKmkBiT7CYHxlsnaLw+ShtZUlmEQ5xyGPedDYWYoYt
 T
X-Google-Smtp-Source: AGHT+IETYvxj18e1d8C1NH4lSETstq5BPejvepXs8ZWeCUzYx0mzNOYpOqjInWTtFKWZj5JC/UxArg==
X-Received: by 2002:a81:89c7:0:b0:613:fdf2:77cf with SMTP id
 z190-20020a8189c7000000b00613fdf277cfmr10968520ywf.34.1712055803303; 
 Tue, 02 Apr 2024 04:03:23 -0700 (PDT)
Received: from oliver.lan ([23.155.80.164]) by smtp.gmail.com with ESMTPSA id
 q82-20020a815c55000000b006143de9a59esm2273884ywb.11.2024.04.02.04.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 04:03:22 -0700 (PDT)
Date: Tue, 2 Apr 2024 07:03:20 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.04 released
Message-ID: <20240402110320.GA2384051@oliver.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DM8ZW3rPsjCVo7gh"
Content-Disposition: inline
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


--DM8ZW3rPsjCVo7gh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's Tuesday, and for once I'm not late and it's release day and so here
is v2024.04. Once again I want to thank everyone that's contributed to
this release, not just in terms of code, but documentation, testing and
otherwise ensuring things go as smoothly as they can.

In terms of a changelog,=20
git log --merges v2024.04-rc5..v2024.04
contains what I've pulled since the last RC or:
git log --merges v2024.01..v2024.04
for changes since the last full release. As always, more details in
pull requests (or the tags referenced by them) will result in more
details here.

The merge window is formally open again, and I'll be merging in next
shortly. v2024.07 is scheduled for Monday, July 1st, 2024 and the merge
window will close and -rc1 will be released on the 22nd of April, and
then the next window will open with -rc2, two weeks later.

Thanks all!

--=20
Tom

--DM8ZW3rPsjCVo7gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYL5fgACgkQFHw5/5Y0
tywBewv+JMajal9n+j2LjrDDWpF+CaP3AjyUK+gdChbDjKnHJtemtoHTQcYOq9cQ
BobjEFL255XALEQq9p7SzmVRBXpSBAOqxlRJm6aG6hbmCMHnAPNulRYUuMIVVD2n
a2zJH4b+DBP2gdf490lF9JzKcvYy14Mi/KpaJkQmYdAPflA5REuhN185YFGTdyXC
gl/dvQc/1aWfhtxweaLVWxeQFtHlBCYcKOyXirSjgpKoRY0GsgEkKiDLAMxx0LNZ
YHYrNJ2zdZdI3LMXFCi3iUaiZHKpc9Ops75yi4bG/qWpV3fc+1/cIzRWy+A8IzOY
8wz/s+d13g3tHnPG6PKHGvV/0R1oQd8ZZ1YV5rrg27vet67/XQN+LETbw66dgXzM
6Iasc3MBOsW7LkKTIdCCXZzGkjZdvav4HlU2KXVzPe903ZXxE5FQ0LbaU/Skt71Q
cTrBFbeP7SCY1cYrabOW4onp7xnhiJ/d+LuwkrfLhS0TWuRvLjo2wWkGCUYcL96J
E4/nxrub
=jwfA
-----END PGP SIGNATURE-----

--DM8ZW3rPsjCVo7gh--
