Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382BC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 15:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB7C80F53;
	Thu, 13 Feb 2025 16:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DCnUdJug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B450F80EBD; Thu, 13 Feb 2025 16:59:27 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914B880F58
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 16:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6fb0e9e6f6bso8345887b3.2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 07:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739462362; x=1740067162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OS7MJ33bijIMcMaHD1qMePNyyLrXSvBvWzA67t/oHgo=;
 b=DCnUdJugEt/mOWS7asvWRRGwd14b7EgyvJRe6YBpP5o1osKTmR0pQRb+q2f+Em2Rg8
 dt4gXyr+d8kprPNTXy0Zo4e9+O27/KDZ7ZmLkuvc9pBD48pXBJJPz3XrBWNChgZIPOwo
 2to+XmX2FXeN+sRtZUwbNXOW6KSwD0ue/hLKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462362; x=1740067162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OS7MJ33bijIMcMaHD1qMePNyyLrXSvBvWzA67t/oHgo=;
 b=qmyghsepZ8PpM+ZTPmWFQDoIvy8vOd3L6K8iofs18QZtSgE6xwuj733B07AhTU+UqN
 PPHotvsYPGynKZ+zh7/TVI7L/Peus8u1yO8K+elwbXAZBwMpwWoWKCIcvPDq34u7GTAH
 P3jxum8G3WpZTYUeIfWMYEDeBudop+YLr6RXsuS/Ck4U1+e/eTYgjZAinXGpzM2X/wTp
 LGzo99vJ7lE/eifd/Da/ueKJJwL4Srj+trDKJAqlgp4Q3V/I7JGPjiqfYUqBZJxgzL3V
 4tDCjiHFAR8euwOIzd2RXnVh+JXJB/7O+b2YYW8e8ineuV7MC708uIE7wGiRNAJoWKAs
 Q9wA==
X-Gm-Message-State: AOJu0Yy3y38kie4BGKCQvQCKQOBFNSfA+cBZ1m2SviHHlE9tL/fvqsjn
 zgOfG6XImatwPkdrMxTztiZ6TTPUTmb7DFxiqcAgbfAwstc/XC+Uo/Ra52Qz2VY=
X-Gm-Gg: ASbGnctRg/Aw8xg9Q9vRtj/XyHqZiiLZT1S85c+y8VI/B3LLKfmn3sU04PRMTKtSEC8
 mEP5JROJsi6lU0/428X1cDAiLETvYuXEy00cNCH66aAbvEs8OPx4EYKueoVADPe6s1l613kOt3/
 D7JECYgaKOyMwoDH3hIQd8wwQa1ZtZiJjwhug8H8uGh3zcj4GaTg+YxYmEDY64YIbCAtTkDkMgW
 5+IFt5SW93+ObllKo3w+8Es9Ykg4omzBPiEUPFF1Ii89v2GnVw/hqtJ5UwuJHFHS5y+r1T8mgkO
 VpXdL3M6vksqsqU=
X-Google-Smtp-Source: AGHT+IGkOZxUbMW9s4ygI4d05rPimcYSoyIvnXcZpSk94/nv2I1MfLyyyhohJ0tUGAMrGGkHMJpLkQ==
X-Received: by 2002:a05:690c:c01:b0:6f9:b0a6:6a22 with SMTP id
 00721157ae682-6fb32d46b1bmr33123517b3.25.1739462362422; 
 Thu, 13 Feb 2025 07:59:22 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb361d06e7sm3444787b3.119.2025.02.13.07.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 07:59:21 -0800 (PST)
Date: Thu, 13 Feb 2025 09:59:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH] arm: mediatek: compile dts files only for matched target
Message-ID: <20250213155919.GV1233568@bill-the-cat>
References: <20250213090054.83932-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="exxj8cTWpuM93C2i"
Content-Disposition: inline
In-Reply-To: <20250213090054.83932-1-weijie.gao@mediatek.com>
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


--exxj8cTWpuM93C2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 05:00:54PM +0800, Weijie Gao wrote:

> Currently nearly all dts files for MediaTek targets will be
> compiled at once. Split them for each target.
>=20
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  arch/arm/dts/Makefile | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)

I'd like to defer this and just migrate to OF_UPSTREAM instead.

--=20
Tom

--exxj8cTWpuM93C2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeuFtcACgkQFHw5/5Y0
tyzsQQwAisX8BJuKvjkA5NPPtXpukmFWSyx86mdZMWZq7Ozn/jZUjNjk5fFfQdr+
ReryWKV3gDUiaDANiggKQ75qjMrjmnA+DANHtzMBmgpYgFWgaBAmyvk08OqLrSyl
rIfyMQw/MUuvHrn1O7KQ2F0GYScT3AFYxRXzT7Qc/atJhWbd3xRiT66cToSTbRwe
d7QLThqhg1RzwUWEL36V3ZwCuxmoiffkQMOWlD6wrcTr8qflvrnB+lJv2TIsQP+Y
MF2x17rC8lNLqI6a00tvkv8MzVQBartPa/wZt6zESB0XMLhaWbjIHZ8hD2K1zc13
BTvNePvOXVT9iLEVCvhTTfGh2yNhzcriWuFKTNyJtuXTxHVTo4VRqPcz8K5eMCcC
RQbb3Th/JwfHjnMKQ/YiVqm0CjD0JVq1+c8XzkXtf1RvOg36CVD6Wg/pc+2rKXkp
VUi1PALmDbc5PvwNGP8sDlk1PwdhSbkWpVuZB713jGI7fxrDck3Lzvn9rrGOWgRT
zxnwTpwL
=k6bf
-----END PGP SIGNATURE-----

--exxj8cTWpuM93C2i--
