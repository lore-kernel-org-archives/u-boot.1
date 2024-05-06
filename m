Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE0C25B10
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 19:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B715F882C0;
	Mon,  6 May 2024 21:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h8fpXTUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA7F87F07; Mon,  6 May 2024 21:55:26 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9075E882C0
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 21:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6a0ff97a9c7so37255906d6.0
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715025321; x=1715630121; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F+Z17L9DmD9mottuYn29R+SwxvlZKrkRv7clG0qhOKc=;
 b=h8fpXTUP2kbF4UVWjqL5HqvOw8i/bhg/2KTNtuvSeAseRpvC7nFqkcbbucKxp8imUI
 ImBtvWVllIwi+grdH+RLwqxXkDQ1SJ5X/EmVMP5QIReMMcpldUmPDwbJ8t4k1kKXnG8d
 /b0sfuATnByL6+NqtHGmRjPNbOVFGlJqdYbZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715025321; x=1715630121;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+Z17L9DmD9mottuYn29R+SwxvlZKrkRv7clG0qhOKc=;
 b=OdTlWhuNyrXMEXqgsvvHRimwgD0Evho8djsDLxJ8QNP9Tz0IbbZPYNY/PeCpRLUPsq
 1vTvNyb7uo9aqKfoydix/Z0lT8s/l1/5rv6POJ86BhNAp90IKmiOKIf8ScgHRD9MDobp
 FZQ1SWSDPeo1C+5x0/DhKzMV9ir+9NXF0B9HYMJ2yPmu/lRop+UpbMBXiTKIHfvNGSDh
 wzwpRAB/9aBSzGhM/vRja+3mjUNZ1XqVyCMiGHo1TDjsDis3ZrPgmRu9MrbB4rAPZERH
 T+u2R/CED7dK9x0D2rIeGGddDvILnod7I1WEAPzRvIiMxHkH/iku2KQi2qqjxnXCE9ZV
 a2sw==
X-Gm-Message-State: AOJu0YweoO3RwzMNvEVCW0RjANFjdRuNHhuIdvwRQGjFJHAXG/rUpLGT
 jnRgoXUv9zxgb5Rxzl/RYMAh92OZ6ItgShbnDdpFZYs/5tJ6pHCdYbBFRQI4QKvc/NeKogy2cE4
 4oLU=
X-Google-Smtp-Source: AGHT+IHQiIzmtzJL9KL282TGZNM4lVgE+Tb8Pp9Xy2K1LXWb49mMgwCwq+g5zoGVGSHC2GHLr/aQfg==
X-Received: by 2002:a05:6214:5ec6:b0:6a0:f2e0:5070 with SMTP id
 6a1803df08f44-6a14607335fmr12193366d6.21.1715025321267; 
 Mon, 06 May 2024 12:55:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a05621405cf00b006a0d19c3139sm3997968qvz.118.2024.05.06.12.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 12:55:20 -0700 (PDT)
Date: Mon, 6 May 2024 13:55:18 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.07-rc2 released
Message-ID: <20240506195518.GP2568172@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5d2AJ2pAy1udA/4g"
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


--5d2AJ2pAy1udA/4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc2. Looking at my own queue, I think
I've got everything from there I intend to go in this release. That
said, there's still a few PRs I would like to see from others before it
gets too much later and if people know of bug fixes that are outstanding
still please let me know so I can take a look.

In terms of a changelog,=20
git log --merges v2024.07-rc1..v2024.07-rc2
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

As this is -rc2 I'm opening the -next branch and have synced that to
master. I will be pulling in the large series I posted recently to
remove include/common.h very soon, and then start grabbing other
changes. I expect this to have minimal impact on others and should be
easily manually resolved as needed.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Monday, July 1st, 2024. Thanks
all!

--=20
Tom

--5d2AJ2pAy1udA/4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY5NaYACgkQFHw5/5Y0
tyxIRgwAiKFr3tXQFe9WlHSxgC/Y0BYij3g9ym+q0KWAaYfFoMJJcC8bZdRa+M5n
pva2RotzMdMp2fnOFuBeMEb+1yQfVgXX8QIPalIZGJgfJFXBJJ4KHDQL/gchEx3P
xWTKHTYRENeDt9NCeQBYb2s9ySQNyIO+gLUXZE54XmUcYuPn02Uikh43J5Um/uoE
lcKKJNNadCtLf3eOtCTxQMtwvr3cHYKsa8d7+pYTPaYG2lEfQTc/xvHgrIixABFI
LVRnutfw45NVaxbaPHTXE9LM2/93i4XS+sjQB3pKo+8l2fgP8NOJ6koSv4PtxMSr
Ghxddi2JThcYzIe/o20JNASMkEpdLgW9UTC11/tgBh44eHd8Z8zblQJgWv2+FdTY
qg4jp/BFbxs2MWLxfvBnWRT7C3Wb+YIkRPgK69zZRs+g17aVtgbX/HY9myA8nEFJ
xdlF3H1UGgimPv4WBwc24gf7HX+EVX6SzFAOxxuqr73CWD+EKwptNIQtGghFM6Fm
05Pqtoky
=kJwg
-----END PGP SIGNATURE-----

--5d2AJ2pAy1udA/4g--
