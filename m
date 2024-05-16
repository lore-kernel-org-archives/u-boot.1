Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F32DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 22:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B025B88458;
	Fri, 17 May 2024 00:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A5B1wBuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C35E88480; Fri, 17 May 2024 00:19:48 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B26B88458
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c996526c69so438580b6e.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715897983; x=1716502783; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dFPvWSx/a1wGsnZ9DsNfjvZkDaktq9KWPhK9P2o4q28=;
 b=A5B1wBuPhB4zKAqLoi4NDf6RLxLdxR5Ng8bDE8cOE/zdHmdDmfps5q+AbigbOt3uV0
 idX/x2THKVT/e8SzLzia170yKEmlaGxObEdsv6i/OLdIcifSPVh2ENWcWea0PIqpDxs0
 H76euaPNituzAR54Bf5pYtfKC3ldjyTlweHGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715897983; x=1716502783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFPvWSx/a1wGsnZ9DsNfjvZkDaktq9KWPhK9P2o4q28=;
 b=leGcZHf9bv8TQ6tMAo3xGDExS9Qvoq/FfjqZOwnMHbtMQ9py+xgC3hJb05cuhO33BB
 h5QgaoIBsOqNS1ow7DHZC1TUTgZGZsqSCRhQC/XYugNXWo08pVirfQZZwzAUGQXRjxJw
 CkOERhWD2+U+Z/26L9W7MT42u9ZEbIzcUnK0vDlCbX9+GmYibK/WcUAWmMKNtxd5iqB3
 11ssjc+glfaRHZBIDNnjuBFeDwfEvyKALony4rMNN4Cs33Ivn0KluXAN+xNPTo5DgbnL
 k5Go6AU8A+MLW3zetuaItuKNIgQ9yQW1/HiCs85HlWSgJHne+swA8i2De6wST4zFUi+W
 N95A==
X-Gm-Message-State: AOJu0YwPkUrsv8NowbVXNdfueZDtFngn1IgkA3lbHk2t0swRE50BZ7og
 tVsvlR7tKB7WuVL9uS7VzF2qQw2g93S0le4LH5V/MYVVGJsDwCKMVDDkVEU28R8=
X-Google-Smtp-Source: AGHT+IFGIOmKFSOxRGrYmaC2L42/aVkdq4YxGxNLwn6XaSeA3x76NbZl/EInNyWctGXqR6vbqwEfRw==
X-Received: by 2002:a54:4818:0:b0:3c9:63d1:6fde with SMTP id
 5614622812f47-3c9970cc5c2mr21524958b6e.37.1715897983360; 
 Thu, 16 May 2024 15:19:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a3cadsm840538385a.67.2024.05.16.15.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 15:19:42 -0700 (PDT)
Date: Thu, 16 May 2024 16:19:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/6] video: Move generated bmp headers to include/generated
Message-ID: <20240516221938.GG2568172@bill-the-cat>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
 <20240516-rework-video-format-v1-1-f69822b742a3@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="An21jf3zRvEfcpoi"
Content-Disposition: inline
In-Reply-To: <20240516-rework-video-format-v1-1-f69822b742a3@flygoat.com>
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


--An21jf3zRvEfcpoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:16:41PM +0100, Jiaxun Yang wrote:

> Emphasis that those headers are generated.
> Also naturally gitignore them.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--An21jf3zRvEfcpoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZGhncACgkQFHw5/5Y0
tyzdLwwAlhBtlnGiBU7XcPh9W+nLAdQQerI9SuCuETqFJr3ogl23eVBei5nz1ib6
HlvkNNAnQSTZDID6Df19wyw3a/AQZKX5IXbhmAZfhltIZVOIHHF8O+wOeAOMosGT
D1SOzgyk6JdUYLXAPH9QRh7kUh6IvAB3EpHL5ogGrhOLKWywN+KDt2l7jmUdkeZv
g0mIGj/Yjgmr6MSovFkQM+kL98umXtppsKdWOegg52bH+JRgx+2apR1se/ptoZBg
Z7jswU70sUN1UecEY9ngDyUplBkcUi8HH1tyh9XG6xwq92t2RjYUOpkD0mvvJCdK
n3LR8qIflQzU3TZNgML++b5Yj1/ATR98BMLWndH427C3VF8ZAPTa04/uBb2nuKA1
6VK59RF+/Og4+WUexz7fMkT9Dp+2EcsGhD5I1XTt+Zm7Y4Yx9opoHGo/Ex3V4P0F
wNw1muA3fNXr76zazdU+FPGA4wVIpZghc5NBQ+LcXWho3l4F6D3/PKrWnpSQVpfx
wTu0BaVg
=vHpY
-----END PGP SIGNATURE-----

--An21jf3zRvEfcpoi--
