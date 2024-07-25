Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D70C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BF588005;
	Thu, 25 Jul 2024 19:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q4aa5MAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38130880A7; Thu, 25 Jul 2024 19:22:27 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE60287FFB
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 19:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3daf0e73a59so28936b6e.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721928143; x=1722532943; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XycwNiD4Fg5wK6HvHaXCVPKUSgBWCaFo+lGJ5mVe0Fc=;
 b=Q4aa5MAfcTE/RY5dX+P7PKPE61qJKxaIQQ0Jid9MY8mnI3smz8ExivPLY2h4+bSExF
 mAilX940Chi/9znUm76hrSjV4rP/AYpNRWqVfNdCS0XX48xlYxPr8QSIEUHHkFokst39
 l8RIQFNetPfg/noP8sPIkxQXEFyaqiSbESLL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721928143; x=1722532943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XycwNiD4Fg5wK6HvHaXCVPKUSgBWCaFo+lGJ5mVe0Fc=;
 b=bZ2jAL5Izl+TyYlti47tHOs/hzOpTglzBT1cq0a6HFuCa+QUmYLb7WCMztZh0U+NNO
 CZg7aJKJNkTy3oYm7Y/hGmZqLQqI2oWB1RFw20U1NiLsP+bkLbB6eOiMi5LIV4oHbHQv
 GqRfyoBfBKqx8bIxLdPqcLzvCB6081WpfPNcyc0YU444OKu1vS7ujxcwqJQBi2uSkDcy
 BA8jt7/dnwGpUXA0CyXzo5KSJnd+X8W9oA8ChGv6wgIL4NV5WtSFGh0Maz10lVAyP90S
 CWG2Wdl7IpLTDO5jOsLSEDeFbAwZKSF60WabZc4IWKx7mX9hfDFH2RRDf6P4wHyNeU7I
 gCZw==
X-Gm-Message-State: AOJu0YyLFtWVbJeDMESkaxebXHq++VfoiABWwwKwi8Y+Wje1wY5PMfGM
 rbORTHM3JU3nCly8R0SgZ8uQ3HugUO/lFwzMm3lOVtWCkCFI5v8w6i4UdICqbM4=
X-Google-Smtp-Source: AGHT+IFOfDW06jxwfdwFN/Pv+BA2gLuz41Vcy4PHeAmSygtpKYsnGN2kcEl5BnGHBuaBdlYzwUzx9w==
X-Received: by 2002:a05:6808:309e:b0:3d9:dabc:7b7d with SMTP id
 5614622812f47-3db10ca418emr1933501b6e.15.1721928143394; 
 Thu, 25 Jul 2024 10:22:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db132b2788sm372770b6e.0.2024.07.25.10.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 10:22:23 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:22:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
Message-ID: <20240725172220.GA989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jxg1ZR++V3+UEIka"
Content-Disposition: inline
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
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


--jxg1ZR++V3+UEIka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
>=20
> Prior to applying this series, the lwIP stack needs to be added as a
> Git subtree with the following command:
>=20
>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.=
gnu.org/git/lwip.git STABLE-2_2_0_RELEASE

This is better than v4, and on the hardware platforms I could build and
boot on (which was most of mine except the am62x_beagleplay), the tests
ran and completed, including the tftp+boot a Linux kernel.

The bad news is CI blows up, a lot:
https://source.denx.de/u-boot/u-boot/-/pipelines/21764
And:
https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis/bui=
ld/builds/9014/logs/106
which is another Kconfig dependency problem. I don't _think_ I
introduced that, but since this wasn't against top of tree, I had to
apply the cmd/Kconfig patch manually.

I have my world build running still and may have more comments based on
that.

--=20
Tom

--jxg1ZR++V3+UEIka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaiicwACgkQFHw5/5Y0
tyzoCAwAt8glx5HbaCjBlfCpMp9Sm78Jb1Sjzoxbfu6I1VObi2VLFvNxNRkV+1o2
jTz6ZFBDIBa1GbJb/9vjevsaoUOyvzPDaUL/knDAe3zyXoNJlRwfUWWQpakgXga9
3NWxGZyO+4KyZH69mF+nqDtJazV/dkYSNeKA5TnEw6CurosugJog9Nf470DYc0BG
aBUFqTeJO8qRFD7JhwYucTWLCTCeDcQ+Lw4DtC/N0IwYdVxgpALxs+lDshqfgVsK
AiogLFdqdBKsoWo5xAQQDNb6X6MvD8xAUyjX/PS8nVahQQX9HWFB1SiBaXuz0DRK
RA7QisjEu0dTBXgu8fBY89Q202nAJvrxhMhRPcftKxi6b3TK13QHoHv5soWHZKDw
sHVrg9F2edyzLnmHtxXSoYkRuOWRyZW7Qx9v1i/HqCYzZ6BGV18AYt7lt+OyLdGF
7ZZLb5ICtxrT0f6gDiJyRpdpbki3OZp2iuG4aDIQKFCRJtPGX4hCWCsU8mZcru85
x9mYljpY
=y0zh
-----END PGP SIGNATURE-----

--jxg1ZR++V3+UEIka--
