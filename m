Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF7EE49A0
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 20:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26112871CD;
	Mon, 21 Aug 2023 22:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sFdReMvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8588D870BF; Mon, 21 Aug 2023 22:21:07 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8826871AE
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 22:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5922380064bso13187527b3.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692649262; x=1693254062;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bn29RAI/eq6o6b0yx7fbZIWB9CKg0MezS05ac3e6vno=;
 b=sFdReMvArIsJ0/BhHFDoJXSptKao93IHFqARaHBdp0UPpjiGOMu7B+dDY8jtLnfzGW
 glrGgpMNi5b92hRInabslWXXS3+xx2/ArlTh5/jGVaewcEJt/kugX4HcvHAe1lUTtcRt
 M1CXnEX8vAx6uPOGeFEzNCpxOZUqP/ZBDt4wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692649262; x=1693254062;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bn29RAI/eq6o6b0yx7fbZIWB9CKg0MezS05ac3e6vno=;
 b=Hy4dYRq+3LV2R8m7veiFZNLOzxkb+3W8A1Hkx5KkzM3gOWJy50vZDurEdou1oQ8Qx2
 MYiUKBhwkbg7g6Tfektvn66zHgkQX3BzPYdjModaOEC0c6JE4WYND0b8jlP+cQBUqR2p
 P3k/EWjkdzT9H43PasAjhlM9nCPqkQCcneqKFjdn0tW1jdwp9PyEUbSJUHkC8d/3cCXM
 ao7Xw5dwmu6kPlKLJ50hQMog40OdghrtUVWCRTvwvRwOA299+zVX4ha+q3Gnd98JILho
 g9MptNWsFXh/k/dKLa6QWcz1AoTNOQik9JfcnqMmyWDibHKhXEKzzL/pvgiL8CVpNpfS
 CigQ==
X-Gm-Message-State: AOJu0YxE484IzOkrdplKcU1Hv/J3x8RvQlWqYaZEPTwqvWgB+gfwIzly
 bTdA3nF5tWe3COZW9c8sKoR2/ei4B0HZWE3vQLWTlw==
X-Google-Smtp-Source: AGHT+IEZNKB5bZLsghxjOxPWhj7jOn2j7jBUR/iYj978KOoaPBNypze5RM8oAk1BlkpzmgO8R4nWgQ==
X-Received: by 2002:a0d:d882:0:b0:586:9c7a:d9ec with SMTP id
 a124-20020a0dd882000000b005869c7ad9ecmr8986366ywe.9.1692649262279; 
 Mon, 21 Aug 2023 13:21:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-49e5-7fcb-0da2-d03f.res6.spectrum.com.
 [2603:6081:7b00:6400:49e5:7fcb:da2:d03f])
 by smtp.gmail.com with ESMTPSA id
 h185-20020a0dc5c2000000b0058427045833sm2446035ywd.133.2023.08.21.13.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 13:21:01 -0700 (PDT)
Date: Mon, 21 Aug 2023 16:21:00 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2023.10-rc3 released
Message-ID: <20230821202100.GJ3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6IeOxos59mbmqVgh"
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


--6IeOxos59mbmqVgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and I've tagged and pushed -rc3, and will merge that to
next as well shortly. Things should really stay stable now until
release, so I'd really like to start seeing PRs for -next at this point.

In terms of a changelog,=20
git log --merges v2023.10-rc2..v2023.10-rc3
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I'm going to try and stay on schedule now and that means the rest of the
rcs every other Monday, and with final release on October 2nd, 2023.
Thanks all!

--=20
Tom

--6IeOxos59mbmqVgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTjxywACgkQFHw5/5Y0
tyzD0Qv/aiXYBaUTbfpAOLSBG9EzIpjY6lBl2d9yCP783shAOIx1S5EVuxjSZ5JY
+AlQ1j08xt4IsFwu1j+Qc11WkqHLeMnmthsTZQbtxIF7e3EJGWW690fVRTy9GYrF
jiCvRvBWyNbZ51lrXO31821vxZGiv8xEEtm5Ks759h8XfljVyOY4wkAfQkP2Newr
I3zpcvNjCKikCqpRrZPgvTu6j/DCbVxcRnHrUx5NUxCxS7/opXG4U0SdZof4tXEU
vIuUcIEjLv9WcghpbImWvgTpDHvS2h2/2ZyBrptrEvLN8qq0XimqecICJMqp0pLg
J/jUyC7rWoLz0rQWaBCIk2MBWCAV1r/Gj9hNIms+J/IfnWdjGg09k6tvzBk3VsGb
4I2L6gcFYK4xayy4pjBtdoSSBkFujow7OGyoq5kWKMpETDQ9SDRX9/QWYmBO6WKD
zc0wnZmTg04CyDepTLJBR68IKMopEZPcZpmbbjEv0y2kU63gZF9vURXjuJVSu/VG
dvRjaBoa
=T2BT
-----END PGP SIGNATURE-----

--6IeOxos59mbmqVgh--
