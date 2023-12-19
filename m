Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AD4C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A8C877E5;
	Tue, 19 Dec 2023 18:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sONUKRlz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5CA876F6; Tue, 19 Dec 2023 18:46:52 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D95876F6
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5cece20f006so40153427b3.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703008009; x=1703612809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c5eIFEkv0M38gi01ThR4W0nLWTKEufqETfw8wWpOFwk=;
 b=sONUKRlzuyZH+1PIgVFknqSj3lxI3HasZs9F9d/nnu6YVN/MJqc66XvSeh3p+0I2ey
 sIteQUOQd7NILIzYd5n6R95ReJPVYytd7rPkRdTl4mviTryEtF5FiQDXibro8xvYKzR2
 YjJaXL/bOraWHBDjHLjRutyi0zaT94SphfFd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703008009; x=1703612809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5eIFEkv0M38gi01ThR4W0nLWTKEufqETfw8wWpOFwk=;
 b=MvBgO6RxLfyCc3O8NQCfNOOdpJDD1ucc8tCjJD6JoHHX3WuL9ZoIuhrK5T/fo+T/fF
 AW3sbTCchhZ0azzAL5Cw2fMVCx2q15aj1XDnOMxiFas2pwEW7XhpNoJZeepvNL5xKn1H
 Y9XX+SP4wlK8lWxcALQqJOgWfCCeMx75Lm09T0lOQv++6Sp5veSzlRTL6BGnaeYkwyjp
 isyd8i3ZQjEpmXKptTvKjtCIcYLwke07AHaNKAFBp/oseZZXVIcbL3H7/kndOUcLKb2I
 5hmIe/MpN8RGAaH5yRG1H8XzQiJ0WxGMqLx1zsJ9LWIYpY8J75G4tzMdAhIe2LfxyoUT
 xK4A==
X-Gm-Message-State: AOJu0Yy+PlgrU/vCVV7N+jiP073FiGXXVKnEOcZjfzxlaiz+/QZghhOo
 f6P7ZH1TH/l2g/9PyE2DgZ340Ru3S2EctbSJszs=
X-Google-Smtp-Source: AGHT+IGAQKQSojAcBgKotaJxju8BSFRHbkWvICfHn7SKDRQ4aNCku3p27ETNrp0pwqo061NbNPsr7w==
X-Received: by 2002:a0d:e7c7:0:b0:5d7:1940:f400 with SMTP id
 q190-20020a0de7c7000000b005d71940f400mr14019588ywe.104.1703008009721; 
 Tue, 19 Dec 2023 09:46:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 s64-20020a817743000000b005869fd2b5bcsm9909783ywc.127.2023.12.19.09.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:49 -0800 (PST)
Date: Tue, 19 Dec 2023 12:46:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Julien Masson <jmasson@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH] mmc: mediatek: set b_max according
 CONFIG_SYS_MMC_MAX_BLK_COUNT
Message-ID: <20231219174647.GG2513409@bill-the-cat>
References: <87edg23x0m.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MGH9Fq3J1UIoYiSr"
Content-Disposition: inline
In-Reply-To: <87edg23x0m.fsf@baylibre.com>
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


--MGH9Fq3J1UIoYiSr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 02:41:45PM +0100, Julien Masson wrote:

> The block count limit on MMC based devices should be set according to
> CONFIG_SYS_MMC_MAX_BLK_COUNT instead of hardcoding value.
>=20
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Applied to u-boot/next, thanks!

--=20
Tom

--MGH9Fq3J1UIoYiSr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1wcACgkQFHw5/5Y0
tyx5TwwAqNkbeExO8q+jvtkyUoAzuZ2az8axq46Ax4P7Kj2XtQiIyLviIhne8xWm
Zkh8wNDEOqJgCCh1S6AJI2DaISbPAc+U75ekE3YcXHq8XTZvIOjgP7ChjnUV+rL/
2krXUQGQzgKN9Tjncf6BfJbXnBUNoxS3OzY/yBODPAYR7ZfEvkIZfze7ZBzopGVC
M1HpzoLYGoyzcofFJRS6VyBfDVg92EyG+oU9md/uIQyr2gc3618663sV0paBun9i
OqUlXT9bygKNEfvVzTbbje+0ZzDHEu88bfJJTgRyC+dYdBDS/YqbMccV/UWK623t
dS9JRBF6ZSazgGNn/f24QHjmBvh5NWSifmImgauLaSnSRyMWd3R1Rs3FFpvUxrDL
8H6lCKfxjy3xC4oKR/9qzbd04p1E2fTaC9NNipZxld9KWi7tiNQO3OHFvBlgAr+U
iCsa7pwMkM/9VO/09KWJdhrrEgzmGnoIrdm5uRHzvQHXjA5vQPa959Baowzmm0F+
CdgUFDL6
=GJbS
-----END PGP SIGNATURE-----

--MGH9Fq3J1UIoYiSr--
