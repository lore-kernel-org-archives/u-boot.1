Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3914C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE8386525;
	Tue, 29 Aug 2023 16:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NgCHK3L9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1425086521; Tue, 29 Aug 2023 16:09:43 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BCD86527
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59288c68eb8so50428597b3.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318178; x=1693922978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sN19gB8vio1CTIbTpVmHMAuZIm+IANJCDSx+a3xRmvs=;
 b=NgCHK3L9A2TPf4sut9s5M7Rv4XuHlFL/+zhq/9Xcm4sRVlNyMk8O7p3/3fSPxCjpwG
 MzegFQCXXi8gu4cEYdWXUxC+Q/lQ06f931ywRUqvFlwHZ5bcMeEakoVDvGVI2rury5br
 FL3XlUTkpfSX3uOrOEdCr0vYZDLX28usJagEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318178; x=1693922978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sN19gB8vio1CTIbTpVmHMAuZIm+IANJCDSx+a3xRmvs=;
 b=Zxt8x8mMmm33R+wUyO2/Vf8lgmC0nBZHM2olCvqIKIXm/X3lV5a0L0LOBuB30LByaj
 VMFnQs3I3hHghG6iyuiP7vIJYhPRAckyDxAv2UvbV84uL59Z+vMUsN5v4HQ67mwXMlfd
 vqaOTTzZ24qxka+NQk6PkHt+p5jsaQIQoazEovAJ/4AYYyPC4zHnqiU2i3+xOGcESTy6
 T7alf1LAc9nAZf0kKIqgvKBwjk53iqJMU87XHx7YRSU4ttAhpe3RiUGF4/fCn2/GfURu
 gVKOd+SOTrHLg5NIyce28E+s8BIQ355dxhe7SP92qyBqMdfx03Mi3SK3Hhuj6HlDZT1A
 D5bw==
X-Gm-Message-State: AOJu0YwZejvVY/BNAqVktXhxenWfcu/THyHYV7DgEpux8h4HxgfqfhUn
 HYDaB5AcaSsNucd7WyknisiV2Yzaou8K+aFkZ4HLKw==
X-Google-Smtp-Source: AGHT+IEmeyB6T61ETrtTNddrkPecW9EjBsFqw/82TOVWxCioB/0nWiQRRWliWH2XgSazXbhcT1pteQ==
X-Received: by 2002:a81:bb4f:0:b0:592:ffc:c787 with SMTP id
 a15-20020a81bb4f000000b005920ffcc787mr27422984ywl.30.1693318178156; 
 Tue, 29 Aug 2023 07:09:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 y130-20020a0dd688000000b005704c4d3579sm2766410ywd.40.2023.08.29.07.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:37 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] boot: Fix reference to bootmenu doc
Message-ID: <20230829140936.GY3953269@bill-the-cat>
References: <20230818145413.280037-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uJioejRX82U1nAX5"
Content-Disposition: inline
In-Reply-To: <20230818145413.280037-1-pbrobinson@gmail.com>
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


--uJioejRX82U1nAX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 03:54:10PM +0100, Peter Robinson wrote:

> The Kconfig references a readme file that's moved and
> converted to rst so update the reference.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--uJioejRX82U1nAX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/CAACgkQFHw5/5Y0
tywY6Qv/Tj3mSYDuE/2BCN+ZkkmQyjutSNd5Q1Q8Mp4xf2HfzffoemVIXMGV5IE0
KepBWEr7aor36gHqbu76hSo0pgn6o48O4P9sy62ThI/wzwDeKfG3uc8Yoh17eFbq
ua6nuuPcEXP1ygxneBnpy664C7Eq3WtnbpEiJp8kDpk3xdzOmLYIAhZrXcm6ZtZk
hxD7BKpMrIxOmPrckG3oUFJ6BNyaP0XciPE1D455917px58fhosn2TejC02+rYjM
pZYUjkf+ejrWUfj5jB6wC+cYB9BZHkYnH7ODnB6bWZfGuTkujYuP+dmHyd+Bt1Ub
jZzgC5cHDNfYxK1nURxGzmaJGDsWXMoLqGX0hhhJ5br5YDA9p8+thhccry/PvnXw
o2lXOeW8hFcZtqmRmtm0QAs9tD4gojZAZCz2xuiMmnZaLnOQyzhq3idp9kFVBGBE
b7Go4L9ArV4CkskrZJ01En8db2ybvfjOWlzlTKF5NGxyKmPFvCUaTONXD001IS/t
H/luj5/a
=lXlO
-----END PGP SIGNATURE-----

--uJioejRX82U1nAX5--
