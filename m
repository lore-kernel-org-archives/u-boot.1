Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FE2CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2EF83937;
	Fri,  3 Oct 2025 22:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WZFr5/tU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2771183936; Fri,  3 Oct 2025 22:39:37 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F6583931
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-91f6ccdbfc8so142624939f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523974; x=1760128774; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SjuVA+QkZTo0ZOGecQ6x6Mhwj4zqBp0VBPBDKePGnzo=;
 b=WZFr5/tUcWXK/LQr6GxadTyWajWEx+AqxSdXfaLw5oOdx2rUZpnAyu5k3RDnJjRXi+
 099gWxAcDsMQZtA+yQicV+mPuStrj/xBepP2UNMj0qvV78/FClY7/MIaJtT8yd1g4Eg+
 2MeD8CiAkOJxuY2nY01EVUa144wVrzkHH1UkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523974; x=1760128774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjuVA+QkZTo0ZOGecQ6x6Mhwj4zqBp0VBPBDKePGnzo=;
 b=uctmBvlVBH2n3HiIas9qc34Olkoh7gwBRDsXdAf9IXV6+0x+YNo+uoxTRJ8jQbc1LR
 FC1/h0dDZxdHE6T5wIJDAAosyOOUkwOQFDeYAdEpPZLNlKr+Lz0MF7ZVKuj6Qq6VADDA
 11l+ofHkYDik/yeYm8Dns6D8oYqrfszfetoVspCp+32SCEJ71rJvr93/kM7Vd0gOUfna
 91goPj+itr8byYiEm92DJdcPYcq7SLprA7d5SvYgtI1uJDCzAGIwBOdg2PTkzvb9gNLW
 p8Dlwz33mdZKdru5xJI3cMQ+DDI8qKlSvTPyRaetuzFJmBB/esvPKXRCSR2akh1J9PUv
 c2Jw==
X-Gm-Message-State: AOJu0YwtjO2MNThr/tK9eJX/YH6LUCIgtBQYi+0Y92cJ0VWHVllCOi+5
 e9lcTwR5fuP+Cij9noHZMfgR2KCL3Sm92G9hdVNZoCEr6NlY4bhmof497v4/UY42eHJjL1GJYD5
 BMfLuwig=
X-Gm-Gg: ASbGncubg6m6n7YWvfRgipBrm26buk86k1OBGFT7iS0J+0Yj+AUeWRCjIKfJQd2LzAY
 izl/G5dDIkiA01PYDg75FXaUtg/SUlEOZpyli5AYEw/mboyNiVWgcWcx81c+7ZdLmGRm7MluKp7
 Uo4lgRcz8PLEi015myOfhhO6IVbHF8NfOrH0pl7fGtZ2EOVhmkyJGklMqjX/4guB9CYa7x1964U
 IJZ459dq4Ikm05rryCM9IZG3dp9idyQtuSZxdG1Rjc8GMHw7iqPGL74UHk1YJnl1UVRsatWGMrZ
 q+BbRKc4iiPm8sl5uOyQUHLrS7dOGDDV9aLkpL0WA6kS1vB/Bc5kj35hHNnQXsUi7CUeAg+s4IE
 qXgcikYjbXtx99ueLk2vKpDqLO5hvXkKkXuVWEUnCGfzPrawYTNNgXTJow6FQ4Cl9WyR2x9RXGw
 rvbGolhGJ62AS/ImfSYruR
X-Google-Smtp-Source: AGHT+IFzTnXglK56qWz7pztWKlY+lpGsqsybarbBogZHcF/lE63s6lCAm46pHBMA4nB0mpD4F4SAPw==
X-Received: by 2002:a05:6e02:3c82:b0:42d:7dea:1e04 with SMTP id
 e9e14a558f8ab-42e7ad9ad29mr54497665ab.25.1759523973795; 
 Fri, 03 Oct 2025 13:39:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42e7b754202sm12602675ab.11.2025.10.03.13.39.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:33 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:39:31 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] video: Only build bridge code for the appropriate phase
Message-ID: <20251003203931.GZ6093@bill-the-cat>
References: <20251001203046.2828415-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iW+CKC07HBu8OMJK"
Content-Disposition: inline
In-Reply-To: <20251001203046.2828415-1-trini@konsulko.com>
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


--iW+CKC07HBu8OMJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 02:30:46PM -0600, Tom Rini wrote:

> At this time, we can't make use of the video bridge code in xPL, and
> there is no symbol to enable it. Start by only descending to this
> directory when support in the future is enabled.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/video/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Given that I've decided to go in the direction of not aiming for
"allyesconfig" to support SPL right now, I'm going to defer this patch.
It can be picked up later if needed.

--=20
Tom

--iW+CKC07HBu8OMJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOA0gwAKCRAr4qD1Cr/k
CtFUAP9HwYRRp/oYmbNWrJ5t9YQFPPHA9LUgv4TA4eN+wKZIhQEAgvj+nzHTWj6l
DjVecc4sSLpRzUoT90ff4KBLMsNq7QM=
=ciQQ
-----END PGP SIGNATURE-----

--iW+CKC07HBu8OMJK--
