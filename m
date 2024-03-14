Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C53C54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F12587F8E;
	Thu, 14 Mar 2024 01:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DrmTLElN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC8187F8E; Thu, 14 Mar 2024 01:40:01 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF8787FAD
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-690c5d7851dso2386356d6.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376798; x=1710981598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8avN0UGgDWzChHn7Tw4petGtvdB1C2rZMC8Ihwd+rS4=;
 b=DrmTLElNt/peZcgnu+F9mRQlQneKlHhLUBxejV7WJ6IsRthDaZ6wKfc8GFx7zw9kg/
 seHlt5x8jlqhoB1cfaKZTTlvLuM/+cHz6JE6yddubdPM7emxti+8rehztd5DtO2cWNWB
 MII6rTJ+RvYhmf/wDHFn/PVGJn7vBXC7rSYHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376798; x=1710981598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8avN0UGgDWzChHn7Tw4petGtvdB1C2rZMC8Ihwd+rS4=;
 b=Zu9xTM75dwqECoNAZYUd58LEt62XjTRgw3a+nmzPCvYjcSiEhERjrqZNiM+5uS8Yg1
 D7j6GeTKqUgSvr9l9TYr8ohqduxD6py8PPdihhSNZjued3u2rBpPrk97WUmxRN2yuk0a
 YrXnRUOTZtUeDjbN4Qp+VbSrb7bhMDtxt41rvV0bnyBuN1fw1Q888xO6ob6/LfpHI1Bd
 JTT1jtUCmja7jksAYrPNJdICr4Z6R4Jv3kezQEmaxaUqb+9A/RYJuvtf8VFVuxkcNnDf
 i+YQo3i8oGx6UIThbKyHCSD0ojDKBHrpEvM0VuhT40whoOTKWcWYrBf7i8rvg0TmPFD1
 qwBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe+y4RH5n/c5hMfbiEJSElbHOyoheNKeOtpmbfG7HH1y5NvaX7sfO/KSFrHmHHt4bhMw4JNI7SVyIYTwu+pzAIbzaWBg==
X-Gm-Message-State: AOJu0Yyaa2TbEMGKyby6Ja/IT0Yie0F59yULopTQFO0zkWXhUUePhocj
 4TQEWcSVGV7/c4xirK6ZQy/gQv6sjR+R1xMo5lJPwwyHEvfV9UDUV2gLDYQYcWo=
X-Google-Smtp-Source: AGHT+IGmmVOSYmr7V5reFBXc1vhGshWtZkzpR3MdK0HUpnaCULOh0YWUkk1nPSGveOfCdGJl2f15xw==
X-Received: by 2002:a0c:eb8f:0:b0:690:ac1d:697f with SMTP id
 x15-20020a0ceb8f000000b00690ac1d697fmr293237qvo.42.1710376798164; 
 Wed, 13 Mar 2024 17:39:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 o14-20020a0562140e4e00b00690fed3da61sm211784qvc.109.2024.03.13.17.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:39:57 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:39:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] arm: dts: k3-am64: Move to OF_UPSTREAM
Message-ID: <20240314003955.GL3442575@bill-the-cat>
References: <20240305161937.52923-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BATGR0/lFnZssOWT"
Content-Disposition: inline
In-Reply-To: <20240305161937.52923-1-afd@ti.com>
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


--BATGR0/lFnZssOWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 10:19:37AM -0600, Andrew Davis wrote:

> Enable OF_UPSTREAM for AM64-EVM and SK-AM64 boards. Remove DT files that
> are now available in dts/upstream. Update the appended files based on
> version of latest OF_UPSTREAM sync point (v6.7-rc7).
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--BATGR0/lFnZssOWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR1sACgkQFHw5/5Y0
tyxrQQv/RmfSBjpLHRjv718Kx+ypNuo5ETUNTApo3CIsZHEuQ0IJh1JjoD6MRtWU
0H+zwCqqfTr0PW6zjcdOahh4LMkPMEsVADJPrFwNqie6xWLde3jtbDh6lE6dGHId
vtnfZMyMbUVcIJ+9fjmvZQsH5h824F34v79AJMi585+KfDdQg29Uu1V1ZiciTFJ2
1etTXqNQx7swjyr3JodhsGQR4N65Uejk7c9rfDBjxz9bvV/N3HhP4VbD6VHGmVbt
WQ214SNK03dJeSQ4mg8fxHqE0/4bP6ZseLfCRJR1VppZfWgM6qAinISCw+Uzqgjy
wtnKsm5DB8aZf1k6c06NM97Sb7uvoQ7qqJe3twrfrCrChzZ4TlqEhDVCxN+meJxL
lkaqMmlGOobh4rOn4aEwQB5+ZLJOolt/SB90RtPPiWtASl5keu+dIfE48jS6bPJ9
nfZpazcJ8lzgW2rej72t2jFf2QLGtbCRQu73OxaENyLbINNHw2k8CvL6BBVtSJvH
6Vv/MVUn
=A33T
-----END PGP SIGNATURE-----

--BATGR0/lFnZssOWT--
