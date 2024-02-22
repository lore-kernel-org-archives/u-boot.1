Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E56C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 17:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C95880AF;
	Thu, 22 Feb 2024 18:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P6lyAi2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70085880A9; Thu, 22 Feb 2024 18:18:05 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E679880A9
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 18:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6002317a427so68092597b3.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708622277; x=1709227077; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CLnf76Ab1zzZDkA1NV4ctn1xQ1aErJyyxfU45ojLWvs=;
 b=P6lyAi2G2L/MoZncEBy9DrtRMBOOQaaeqSGLxi98w+YVAQaOsrPqSfP7olFBHuYIXe
 hucUSO7OHUcnq3UargG8STCPaOBRNZvKB2p4X+eV/onPAYzdarheL9SH74PVH3V1s/52
 HUlktknnvbpbNH0QQyixPbMBr/BQE7wlsiz1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708622277; x=1709227077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLnf76Ab1zzZDkA1NV4ctn1xQ1aErJyyxfU45ojLWvs=;
 b=OriiKyWMGQrbejcG67uvRkyb/V6aUPidXBiD1HvpCDkTfBt+8HyaBjcFE5676Z8XSH
 gqDSNlHDHbW/UlasPtAAxqfEmtEfGnxA2OMuIbKZ1+KsnXVcuqlWy+0BmuTG3etN4vtS
 LRxaKdSV02QqiYltthAsNe9UE1lqL8H4KKVy5GGuyXeVbgOEun13pA24KLiTlhD80utC
 +kCFDVzh2a7LkhpEyMHoj7KI7ksYwETOuGXgcsIPu9lu/zE99ukokmJcxPjYdz5JVkmq
 S4wIfEwIBuQm3UUCZ3OoE8JnWp0gbMXaNoRqeZkPvme8qelT/XfutBkuLOfzWG+MWL0S
 lMMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfyUbQxXQHokto5CuwmwOd4RtGVXBaT6LigrIyvaL9UkSgIhIJaXPBAu1MC4MU4ctFsry2l3bqXD0zs12/zr3FTTJKag==
X-Gm-Message-State: AOJu0YygbqsIVMQtmb5cVLZltzLbPro3+yHTZteyDP3wkujdhhKzN1tI
 lCm7/kHkGnttTWTni1mg7i7czQklbJpS44Ze0cXwFD2MLw/2tDgSnz/nKUJlDmo=
X-Google-Smtp-Source: AGHT+IHL+Ij2wyooh7tuB+cH0afmU6rNzAhh5CF71MMQWUrPvnxwxB/vPTPoaHWHrhKQI0ZpquXeSw==
X-Received: by 2002:a81:ff17:0:b0:607:e6d4:4cf6 with SMTP id
 k23-20020a81ff17000000b00607e6d44cf6mr19904560ywn.51.1708622276825; 
 Thu, 22 Feb 2024 09:17:56 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 e203-20020a8169d4000000b0060487d30610sm3179976ywc.45.2024.02.22.09.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 09:17:56 -0800 (PST)
Date: Thu, 22 Feb 2024 12:17:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom/qcom-fixes-2024.04
Message-ID: <20240222171754.GW3040305@bill-the-cat>
References: <20240222160915.3196313-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ME8JfJhz3eheGrnv"
Content-Disposition: inline
In-Reply-To: <20240222160915.3196313-1-caleb.connolly@linaro.org>
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


--ME8JfJhz3eheGrnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 04:08:45PM +0000, Caleb Connolly wrote:

> Hi Tom,
>=20
> Just a few button fixes that I realise should probably make it in.
>=20
> The following changes since commit 37345abb97ef0dd9c50a03b2a72617612dcae5=
85:
>=20
>   Prepare v2024.04-rc2 (2024-02-13 18:16:57 -0500)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git qcom-fixes-=
2024.04
>=20
> for you to fetch changes up to 22f391e8be11986bae824509470cf11e7bac31b0:
>=20
>   button: qcom-pmic: demote "unknown button" message to debug (2024-02-14=
 17:21:50 +0000)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--ME8JfJhz3eheGrnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXXgbgACgkQFHw5/5Y0
tyw8dgv9FgCpD3hCzWE8Uk9NU9tI/xhxionn5pGdVf5MkEglCm3zmcEh2U5ABXyb
o6mR3sylkX27owM8fU87ZwP/B4pvv2MZE3Kw0OOASymwIow2mJ+ExJ9KMwUI4lw7
vVAzy4B6HHETaQmO8wxm9BM5awTIChzUxAEPJ1ja+9gcnLsGZDDmPPSjmx3ePalI
qkQ4XsIkK22bSpGTbs+Zgk/y84JX3QaqoYpmEz1G8Z/19NKEKu+fyEu2i71PQevM
YEbz2KXtUBFci3QCErtDIB8/yfB5hkAcXhl9YkwaNG2O8LEsuJsXwoqlKFaeqLIV
RvsTWcIK2yd2Qw1PdoiIV1AhLO58amPHmlGH2GYDBf/4J+F3UgMFEONdcHtxMX2Y
ASQNauBI7TcyvGSbxoKBY1oYL+YK1Ox3D5swIvKPGfZ8BRS2n/ZSYwJ9IMOecGjM
PxNnHj6mf/TX57w6bhGlTejuSCW2i9UMuUGxdXdSqIqhsxvOZHVTJzTCHTmA7oan
SksnxaS6
=5RpW
-----END PGP SIGNATURE-----

--ME8JfJhz3eheGrnv--
