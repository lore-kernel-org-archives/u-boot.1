Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2112C3DA4A
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 00:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 600B288980;
	Tue,  6 Aug 2024 02:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KYIzTsCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FEFC88001; Tue,  6 Aug 2024 02:16:07 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146148827D
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 02:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7092ea69218so3184732a34.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 17:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722903360; x=1723508160; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JDW1k+aTRmmMocD9t+ADxD1APqYLfw44cGIHtLW9Rlw=;
 b=KYIzTsCNN4CbUsqj9oO6P4txbrlcN0BzW4tpwzHHZd8z1Mik7TdR3Ms6+1kpJEGxDI
 D0dP3p7uq46jT0oOHl+q8YmvTWXE0mF2oZSCUENYIf1GUQQ7um1DtbaBU+Pn8Wb1XStc
 ZXcqnC0v+yY/ru5Z30EtjmseiHzyUWv3+AlXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722903360; x=1723508160;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JDW1k+aTRmmMocD9t+ADxD1APqYLfw44cGIHtLW9Rlw=;
 b=jw5Ku/aixM1EQuOSaQK/G4x3XoIe7zStShVwWBwUNV2LCUGsSPOfYlvNDYx7LUC6Nw
 4lSSCG1oRUL2fk4/YOqIu7C3SzuSnUdHfc5/9kG1uklh+M+yZ1kG19hNrbaVI4eCd1pn
 2RG2So60tp/2LIx4IGiMdjA+UOy7xZTuwNY361kW2N/1ErtFuw7+IX3ycXPhjn+TkPgn
 6eJ5Ap9FSMd2wVAkTg/S09ZIP3wlHxTVdrxNn8vCyTe6O1y4aMbVPLSbvyYi27Uwh9uY
 WQqUJBkQ3Am0PfL4YR3VxRDuzq8hmyJlUikz1q3u4taymAIJIfhzHmLcyTm0seTuHtxR
 7kjQ==
X-Gm-Message-State: AOJu0Ywfqvsj6he50E55H5MJdxXRU85miOXsiazj/NKnk1cU7ynjMtLd
 IM4dml0R+Ys9C1lYykpb3m/ASfyW9KhltfDeIGh1vX5Y8cwYfaOkqouxRVUyzhCDMon27tTJPbS
 fNno=
X-Google-Smtp-Source: AGHT+IEau4RW6xPRkSHgqtUvfO2eE3KyJkuEqt9Wf1RR1ig/Rej45Bjwc+kmRED4ev3GPyytIzt1KA==
X-Received: by 2002:a9d:631a:0:b0:700:cd0f:6cc5 with SMTP id
 46e09a7af769-7096fecc9ffmr6776260a34.7.1722903359615; 
 Mon, 05 Aug 2024 17:15:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a3a75085csm3385237a34.51.2024.08.05.17.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 17:15:58 -0700 (PDT)
Date: Mon, 5 Aug 2024 18:15:11 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.10-rc2 released
Message-ID: <20240806001511.GE267004@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vPcYMfopJsBxA686"
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


--vPcYMfopJsBxA686
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc2. I think I still have a few things
that I'll see if look OK to sneak in to master rather than waiting, at
this point. But mostly things for next. Which will be re-synced with
current top of tree shortly.

In terms of a changelog,=20
git log --merges v2024.10-rc1..v2024.10-rc2
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Monday,  October 7th, 2024.
Thanks all!

--=20
Tom

--vPcYMfopJsBxA686
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaxaw8ACgkQFHw5/5Y0
tyxW7Av8DoGTdFjIbsOBJRgM5FYQx/eByu6L52/BYF76gkltcndDl249Ra0mYvhX
7lXhTR/ROAIfVCXD0bNswhepUwFNCXi6K1bVBDpJJwbUAeTAdteedrbo3cF+xDm/
OkXEksfkuRJD5MF0u+x2KRwsglCYbl3Q6jCHRYCT6VggLqXZyn4cCqOdjoJu5aOF
RCfNQMVHbP9BcdkX78AId6ScCKeVfZAfk3g87eKqsG3vF69OaMLsNVAfs0gTrYPM
m8wwErMKSHBkVkD8FJcJks5o25YP0gdORJK68JArwKM26N0hjNTVSN0t0ZV33VCf
GLnUAM6H1Giz+PLIQdvxAaiQevwuAC+smDGDgipFTjLpAi4Tg/YeBUzyM+3iWOH7
2KEuYb9l1TR1Xp3eOOE6hrg8K180OgP+EE1wJ8nODqXY25dyIGWWTuj1EmDF2Cv8
BhU7kBpOB5nDUS2TLwYeLErA3gvWGb7APyKlK/Rw0F9uuC/mog2mvOrTVIP51rLh
TAGtfCh1
=5dH/
-----END PGP SIGNATURE-----

--vPcYMfopJsBxA686--
