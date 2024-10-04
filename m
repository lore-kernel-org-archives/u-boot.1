Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B970BCF8840
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 18:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC4988B63;
	Fri,  4 Oct 2024 20:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p5zyk7rM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9171688C98; Fri,  4 Oct 2024 20:30:50 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9D087FA7
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 20:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4a3b97cfbf8so965326137.1
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728066647; x=1728671447; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ti0jX+lD/0fLp8xIyYOlcDoT/7zYieor+qitQ3VGN8s=;
 b=p5zyk7rMhP/MZwmXbpKgcNoRZDgSmT2qLf7vZrWqStCPdfbU04HDaqyS/JhHMVeT6A
 ceSbFb9IYFeASz4/KxG5ugaZQigBpLJkPkXsFfykrjPJSCUU2XSZfaGZj+vTSHEpWhNw
 aX+1aHljpvsCYSQtRpjBdO0oyMhwv0a3lFXBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728066647; x=1728671447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ti0jX+lD/0fLp8xIyYOlcDoT/7zYieor+qitQ3VGN8s=;
 b=AdtwwilPodm6Nd26iNDOu2FcLO84dQDvik72CgCoelJZjiOc0oyJzGvEtmFcP+g81z
 yd5bGz69KwdoeGzmyrkhfRK8SuBa/ZtRuRhIojBTP5+f0NvkileXfZBncTA4oMVlOLgG
 5j7bDAJOludhREHaNTITDyPBdBY8z53R1VnuCWHeePgD0oxjdNFhY4D0gU8WB6xX857o
 adkl5Urr8sTetnovl/LYwGMVyVL0h/HvFTl4Sj2BWnCE7ZY4O8dywkOyi1HJUUPONGIW
 Ii4F0TiGgzvhCn6ai1jOxVSCzgKRghPPEnJMhEPM5yfkAp1LLlmkyIV7ZU03if/joJHH
 TcEQ==
X-Gm-Message-State: AOJu0Yy4RX2l0QQZlji/5bDMg7T5dFbMHSAX3+kjY7rkRqlUNdwKZWbH
 GvXw4esPch/1+W1oL5LRPO1g49T+Da224jP0XRSpQjeajK+Gm8i1hGfooDDjZe4=
X-Google-Smtp-Source: AGHT+IGF8BWhINAOVAyLXBRBVkj+CLEb4CX/LYy4o6zIS9Yx7s8RP96gPNGGNLu3Q25NDtd/ENtH9g==
X-Received: by 2002:a05:6102:2acc:b0:4a3:db6a:dbbf with SMTP id
 ada2fe7eead31-4a40578372bmr2934652137.14.1728066646897; 
 Fri, 04 Oct 2024 11:30:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46dfe0dsm1506356d6.42.2024.10.04.11.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 11:30:46 -0700 (PDT)
Date: Fri, 4 Oct 2024 12:30:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v11 00/29] Introduce the lwIP network stack
Message-ID: <20241004183043.GI4737@bill-the-cat>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bpAsWwOVAJ8xS4kq"
Content-Disposition: inline
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
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


--bpAsWwOVAJ8xS4kq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 05:22:46PM +0200, Jerome Forissier wrote:

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
>  $ git subtree add --squash --prefix lib/lwip/lwip \
>    https://github.com/lwip-tcpip/lwip.git  STABLE-2_2_0_RELEASE=20

So, assuming the outstanding questions raised on v11 are easy enough to
resolve, I think v12 should be posted with being merged in mind (and so
no TESTING patches, etc, since I'll "b4 shazam -SM" it. Thanks for
working on this so hard!

--=20
Tom

--bpAsWwOVAJ8xS4kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcANFMACgkQFHw5/5Y0
tyynCQwAkBNtwHPJa4kApkWMBOvroExY6khJ1RROSm1MY3uKYQl23cOs/vvrv8Qm
VzUbfRjwtjnQOnvA6gFq2VV5BJORIorb2cfbphOvwucK/r5b+w6g+g0WEsqHDZ5e
ufsVLBPaDUtkQpXTgT778jNUdJf4N6ydVZ4CaVAPxRuPJgqpSR/F0m2xTHMMD6Ua
oRYvHEUwo+tePrNQAimfEY1RI8oYhj8gyRkifB+xMJMvghfmI0kxKsd8Wdbxm7Zc
/Ww6j7mrX4+EYuw5QDxk1VFy8bUyya1bZuGQbNCbwjKJ2LmP7ZMjVT20AcBtXkiD
jWULgQSjuIFeYo/LoPslqwwNYd5TtczEmXh3QnwkSMysTr8mVS1rKuZitQLCkIDa
XFAGw3NmUb73Os4mx3hipmxp9s3mjoZV71Pgmbn+y9EoQ8HO4hOzAn3UULBC+rNk
qdv91GX9IY+c3Crsy2qnjOe4udtXKci9Pc7mOGhQqOZ4Jqxl8BFCqr/3Y1QJNp5V
ds9gkClu
=1k6T
-----END PGP SIGNATURE-----

--bpAsWwOVAJ8xS4kq--
