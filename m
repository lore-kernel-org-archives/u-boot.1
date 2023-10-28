Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9F2C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C9A287BF9;
	Sat, 28 Oct 2023 15:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cFsYJ1ye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6385D87BCE; Sat, 28 Oct 2023 15:27:37 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A2887790
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-418201cb9e9so22550541cf.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499651; x=1699104451; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q70dSmczU7ecrQr8t4QdPR2p0CGVb1RapF6OqNzp4Qk=;
 b=cFsYJ1yegpAlIhsPkAkt5HIvM3PtoTNcZXqf4ZggZMU1yDGwU2snEV/MAfuKSMRvBi
 zG/+vVt62GJn6IkKARBZgP8dI87GwxW3EIbDUmwK6rSa3FnKoP3QRY18judlB/+cp0xB
 mHE8gdfnwRCiEHw/sdD62JGS5GRxXrCceTDtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499651; x=1699104451;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q70dSmczU7ecrQr8t4QdPR2p0CGVb1RapF6OqNzp4Qk=;
 b=VJxWIsdaWgsTpzFNu/6d/9QJG0slZdwulaGyK3X6mtLIY/vRhomIVjtcIMfaOUiXeV
 DL6S+X3pBqpbjgD7Fz1xnbmOBK5uo0+DxiQJiAOVbhHOIwpS4hm6c9/Xy3wMx4gm/Cke
 gCV/f3pW+2+cfuer+j3Tj5im3o/HrQ//C/SpD9yzTnZR0La9WmnvX1DZliz3AU0LFlGZ
 T+Kd3kCUu5F/Bu1wabtG5zMAJbBTKZMkN8r0YbHHvHVWv92wxTw6pKrS7i/ar30WGhiT
 103j5be6kMukXDstajqAD8ZtYVxCCo3wz0rrruk991ijlLSpKXWy4/MZgDa9oBsRN9wH
 P91Q==
X-Gm-Message-State: AOJu0Yx3o6jiyN9GyR9rFp6I8hQOeEnzxSeSAjWohwsuOn9mHjyopzS4
 WASvLN6mlmFaysCFIvgf7sh/qw==
X-Google-Smtp-Source: AGHT+IGDzL/52F3A1x0cPOwmZ44OWCV8vVsFim2bkeLUHMvf9x2UKO251NFjvzlLu7xg4mtfJpGktQ==
X-Received: by 2002:a05:622a:3:b0:41c:cd2a:f066 with SMTP id
 x3-20020a05622a000300b0041ccd2af066mr6916365qtw.34.1698499651674; 
 Sat, 28 Oct 2023 06:27:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 o24-20020ac872d8000000b004180fb5c6adsm1593222qtp.25.2023.10.28.06.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:27:31 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:27:29 -0400
From: Tom Rini <trini@konsulko.com>
To: Qi Feng <qi.feng@arm.com>
Cc: u-boot@lists.denx.de, liviu.dudau@foss.arm.com, fenghua@phytium.com.cn,
 linus.walleij@linaro.org, Peter.Hoyes@arm.com, wei.chen@arm.com,
 Robbie.Cao@arm.com
Subject: Re: [PATCH 2/2] vexpress64: Add MMC card to the BOOT_TARGET_DEVICES
 of FVP
Message-ID: <20231028132729.GO496310@bill-the-cat>
References: <20231018062745.3153436-1-qi.feng@arm.com>
 <20231018062745.3153436-3-qi.feng@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="diRDsgWThKamD1kI"
Content-Disposition: inline
In-Reply-To: <20231018062745.3153436-3-qi.feng@arm.com>
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


--diRDsgWThKamD1kI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 02:27:45PM +0800, Qi Feng wrote:

> From: Wei Chen <wei.chen@arm.com>
>=20
> Add MMC disk to FVP's BOOT_TARGET_DEVICES. This allows the user to boot
> from MMC devices.
>=20
> Signed-off-by: Wei Chen <wei.chen@arm.com>
> Signed-off-by: Qi Feng <qi.feng@arm.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--diRDsgWThKamD1kI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DEEACgkQFHw5/5Y0
tyxD1gwAiAxVTtXliCmIe/X2NtxOYREDsTVqyyDwoi87QXAQD2Oe8VbtFhP3VyRv
+gdb3PMSrdbJvKY9yHfqsy2vVdFaa0BskQlliCElTZARz2bCyOTpXOIsDhhV8hMr
+NRcI3T0rnaKWjXmYlXoL27Zs7bERJYa/6cdYEYMc2r3lI6O0qk6S4O0QUZ5lraC
+R/nef4CvSnRiBW3GvXAFd4dsTCugAkERK68Ud/GJfX3eqJR6TP7SBh4CJ9cU247
eo8hZHm5MvrEVnqckLEH3lWW8GPFmWZhgawaTdZq0hCcJL3RcxUcx0dc+/1zkkwn
YdOsNIbWFVGpAb9y2EFkEGNavAbDyBuRN3RRpxAgnLjfhC3H8BOUXi/QB8HmEl5L
yqZS70/Jyci+TwZL4XoJyQPneKq2A8mVXafcv2k/OeGmFyZXotm+PcrH7u8Oiz82
AWBkRsvwnyBC3Y4nDLeIxV4/BYwNuoniQa63ctDtoS0CI0jLG0HnntiPzfmfHlJh
L6HfuLxq
=kFqv
-----END PGP SIGNATURE-----

--diRDsgWThKamD1kI--
