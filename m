Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07242FD45F6
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E5708366F;
	Wed, 25 Feb 2026 23:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cE7d2tTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1AC383D8A; Wed, 25 Feb 2026 23:24:23 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1C082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4c543472fso1072042a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772058260; x=1772663060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mWOs2uI+9d4pYL3K801jmnbx1ZNLqvtEg6YqU+HFNgE=;
 b=cE7d2tTzo1PHkYx5J3sx/Z27y7jEQdzHayZStspJtCegyh/TZBTQ0WKYGvUUGJaM52
 cuKarzewvkKrGJpxBkvbbvOtw67tpySXqHevzYWeid0mXiXEUypzPXuTXtZaaYQZw1jK
 qz8X8HsBCpl4+GFTc9A4sOmUzsnswtwIOH3FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772058260; x=1772663060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWOs2uI+9d4pYL3K801jmnbx1ZNLqvtEg6YqU+HFNgE=;
 b=WXqKLxiowdxD7vk/UVCr75blyquu8Tx5epLB/datq0/Pk2sNSLN5BTVUTnVCXyfhvU
 9MI9AzspbshJanPLSKkEtDZ6gPi3zyI0Q8p+HZFMNC99a6nQymgc+tIyHQP8oHfFz8Lh
 tdxoiahzYNcv8heb9chqGcuGo/QkqyMQ74HFL/JhuZ9aFb7qt0whjL/QmNg7rfLPhA+M
 xVOC9Z5kMD4Rxb8XGApCFiqC3SCUssI/E+sCk17RT/rAVKT80l+ecqmm3HOpUoTsGAZB
 W9GSoc3SwV2ZOXpbPj+Ru9lVaO9BDfZo5joTrJ/iwoD6sNZgLXgVw0CWVx+joJEN47Rj
 Iw+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6qGO7yD6zxHoM/0/ae7PkhpTmiBcgiWQPMKmCQogeN/dL4azplF14k5X7nIcZ66bEh6QXqeM=@lists.denx.de
X-Gm-Message-State: AOJu0YyyaFGQR23K2dSQbcUWhSv9djWRKYmE/2s9WbQu3vdnSRvr7Nyf
 D/XpFhyoC1f96XpFfaxG9+VDLjmF4RdIp+HsNTmEOaSe1FvWdaNqckdnaiaVwyzYPm979C3+l6/
 XEfcg
X-Gm-Gg: ATEYQzz+u8YgAMzVpIJN+R+lwVzGw4rt6/TRa1ipcOj/1Q8a+VQaMKSp7Tp7adX6ve5
 ksWbUC0bWAtIcPeEunPn+TRocvyZ9L6kny95O1ymrApHwRmyCHQlHy6ctfz+RtP6QoWuDQU2YZw
 cl2mL/br5oidn2z5voTl7oLowJFna8woO2nrOdRGqiyIu7YSQMhbXc8Vo8JtBUW7DsxAYYMEj86
 GvFkr1Ua7VmEEYZN3VJ55kQ3oygoyla4IuzHbYU7P4Qqno3IQAVTEsClFopTRWGfXtDCvWnRMy8
 djwNkVtE/ExSEKFXWsx84qeEV1ju02EUcfaKoEG/C340UASyem7u3hyubq5X9mlOk3EQdbhQEaa
 FQbL4vnLvccjXOUdsyrthB51w5/ZtsY2L/LNJcvDVeLGMLl0+J23kXUgr4hr8P/RnhVe39DPDxW
 4EOwRTt8f4pq62gTUsbaTTifyKPGhjlf3grp+b4r3QWPu3iLtg9wAb+SV0Oo1DOhYqBIjjN4U5v
 j7uElhkIz4yipnFnmKP2Q/tyb6L0Y7PVyxTfdSKrM0LKC2u1xo=
X-Received: by 2002:a05:6870:b2cd:b0:409:57ff:431 with SMTP id
 586e51a60fabf-41609e27161mr449252fac.19.1772058260152; 
 Wed, 25 Feb 2026 14:24:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160d211b82sm150822fac.13.2026.02.25.14.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:24:19 -0800 (PST)
Date: Wed, 25 Feb 2026 16:24:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Re: Re: Re: [PATCH] arm: Backward compatibility to U-Boot v2020.04
Message-ID: <20260225222417.GY1593142@bill-the-cat>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
 <20260203170002.GO2603314@bill-the-cat>
 <f8f1197e979b4998afb5dc952f7a8a63@rohde-schwarz.com>
 <20260206015447.GP2603314@bill-the-cat>
 <989f3c4aa5a04fd3b1c2efda1aedd459@rohde-schwarz.com>
 <20260206150345.GT2603314@bill-the-cat>
 <1000751cb4604e768e2f789c3dfda18e@rohde-schwarz.com>
 <f991777100194a22b350660b5977cf27@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wU20GSbu8jeVFB72"
Content-Disposition: inline
In-Reply-To: <f991777100194a22b350660b5977cf27@rohde-schwarz.com>
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


--wU20GSbu8jeVFB72
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:30:13AM +0000, Dorde Stojicevic wrote:

> Hi all,
>=20
> sorry that it took a while to get the response from Lynx but it couldn=C2=
=B4t be helped unfortunately.
>=20
> I got the response from Lynx:
>=20
> " Hello Dorde.
>=20
> I=E2=80=99ve got a replay from our engineering team. We do not support u-=
boot, so we don=E2=80=99t have any plans to make SRP =E2=80=9CARM64 kernel=
=E2=80=9C compatible.
>=20
> We work with board with default u-boot (for now it is U-Boot SPL 2020.04).
>=20
> So, you are free to make any changes in u-boot to make SRP run in newest =
version of u-boot.
> "
>=20
> I am a bit surprised by the response that they don=C2=B4t seem really int=
erested in it, but it is how it is. So we are free to apply the patch to ou=
r liking.
>=20
> Let me know how we proceed from here

Well, if they aren't going to do the work, someone needs to do the work
to support the OS. What's happened since 2020.04 is that we now
correctly detect and fail something that claims to be a Linux ARM64
Image, but is not. We aren't going to go back and re-allow that, it was
a bug.

The proposal I outlined for how I think it should look, for proper
support, is something that I hope someone interested / motivated can
look in to doing.

--=20
Tom

--wU20GSbu8jeVFB72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ92kQAKCRAr4qD1Cr/k
CpNLAQD04jom6Z0qbhStDHl7C0KvQRyuzlaGJhQMUUYf3iRmTQD+OYQVG6yqqSLv
UlQAIgoJgUEfYX+qJ254iYv1CgTm7AA=
=IXnd
-----END PGP SIGNATURE-----

--wU20GSbu8jeVFB72--
