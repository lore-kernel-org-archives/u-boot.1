Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D3FC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 16:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6355082B26;
	Thu, 17 Apr 2025 18:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aUpX35fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B783482A96; Thu, 17 Apr 2025 18:04:30 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A7E82A27
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 18:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6049acb776bso420170eaf.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744905866; x=1745510666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ifs5F6aERp6a/tFB/ScDGraybezvIEvrChcxexT+32E=;
 b=aUpX35fMVJzE0hZRuhUzj3pXeZkq7OmRxJ0bxs+TgYeb1I/d7b6olX8tsO0It2Ge4m
 VgM/IeC2AxB5k0hBAbqRluOr4Qsc9Ybg+2Au2F4sRfAVd4JZcf6jFeBNjOPZ2+jL1G9A
 r/OgFeSZKOxhXJfHXyZAcOtbWP9V0m4rrlGCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744905866; x=1745510666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ifs5F6aERp6a/tFB/ScDGraybezvIEvrChcxexT+32E=;
 b=DHUWmODycJvTzaXAPa6GNkBut1MbmCLRd+/ipeOoJI+BR9OTLybgdjTBg4I3uhQobj
 YP30VfFTZtzoCm1abDh3wxUSmOvfocZGaoKHxtNv4yMUwhW19u1iCYVR489PxCcVnOQw
 P/7DvCVf7u9MXhcfqyEYhgBnz1YwTNVs230uhPvgOPgrHBufsHGauREMymZVxFA5WsE1
 zpNs8CF7N0mP5SP3e3NJp/gORyFc2lGAoC1mWc7Fcu32jhQ1CSXThBUmJe5iBP7MJdps
 ++mBYdRHonaTVqZ9tv00ggi+nQ7Jp+DvkX8wjxeS8sZsCtR/EnmY2Kczv0DN9atM+Ams
 iLwA==
X-Gm-Message-State: AOJu0YyEp+y4Oi8rE3YCjcCbkB7eIJywJ6G1JN9+eohsWzW763ypC8cH
 Gnf75VV/0+kPiNc8YOkLdAW6soK418TyzGJI7mUC+3wwPR2zqiXZo3eV4G9nDB4=
X-Gm-Gg: ASbGncuVfIluLyJkLrrgQOj6lxC3y+gYiybniHi8/tobhmqwi/N3+hdZmxbWcIt0P4W
 19v/NZEZfnSQRP5KUur4Zo3AhbWPNd32Ep7QGY80/tfH0RG6GZKWy3ETzhDF/QHAMQydTU4SdJm
 B7cDn0ZvIAYGbc+FmQnFIBGR76oY4LKROrDYdoSRBQgvN0wytCSunl0JFDdbN8RlqzOl5q6W4Lm
 TNWR2w6vpfER+J/4ITKKnGI8Pthq0hSJ6CpHgQ5JvWpq7FVmJxkvEs1S4iE9ykEW8DiY7B3UX3e
 pLI13bfXBYUts2nY6+s4NAtgbmQbjK4FB+WWaYW80Ad0hPG3UHsEmbfB3Qp2T09EKy86TOl6O9l
 bTly/uVcA0mDZ
X-Google-Smtp-Source: AGHT+IHzv1MBhHOov4svRBmcjGx6BK3FOZlP0mRH4ZricQbYYXhJK7WMaPxjgb3C95XaABEobaySfA==
X-Received: by 2002:a05:6871:a504:b0:2c2:4d76:f1a7 with SMTP id
 586e51a60fabf-2d4d2cdf5efmr3837454fac.25.1744905866616; 
 Thu, 17 Apr 2025 09:04:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d52135b8d6sm1686fac.18.2025.04.17.09.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 09:04:26 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:04:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] bloblist: Drop BSD license
Message-ID: <20250417160423.GX5495@bill-the-cat>
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAFLszTj_JvCRNQw716CGD=i+eJm1YMb=WjOqpF0VFFiac3GmCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eqP1vlGDf3ttz6xH"
Content-Disposition: inline
In-Reply-To: <CAFLszTj_JvCRNQw716CGD=i+eJm1YMb=WjOqpF0VFFiac3GmCg@mail.gmail.com>
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


--eqP1vlGDf3ttz6xH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 09:58:42AM -0600, Simon Glass wrote:
> On Wed, 1 Jan 2025 at 12:58, Simon Glass <sjg@chromium.org> wrote:
> >
> > Linaro has decided to write their own version of bloblist from scratch,
> > so there is no point in having a non-GPL license on this file. Change
> > it, to better fit with the U-Boot project.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22=
215
> >
> > ---
> >
> >  common/bloblist.c  | 2 +-
> >  include/bloblist.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> Applied to sjg/master, thanks!
>=20
> (Tom, this one seemed to get dropped but I'm not sure why)

Because AFAICT you legally cannot unilaterally change the license as
others have changed the code.

--=20
Tom

--eqP1vlGDf3ttz6xH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBJnsACgkQFHw5/5Y0
tyz5jQv/cGkKg345dkEiEJwY4ZCrq0qWQe2QosP/iKcmhL/9bRfHmPG5Byxf9Tbk
c/YvqbFFG0Mcl9jjuSSFUkRs0Cu1g5l05F33MNsqptJ3rWxt7xlceeUU7fP6c8tu
dRun1h2z7ri1KRnBYDkGFIjkNbb07bPcxRgpMgeYFhhTBGJFt41NSwoUThqYXA2T
zzNsJntKOpA7v0pwLd3nztXia6SlWfRH2jBSU5q98C+JjlpyBxNpjQwo0/l5ejoK
n18ooWpEIxcSRG0y16+VOA2v8EB5RyQ+ZpNNGRHatogCglDl4fxaHiviyICHN0KZ
HFkywMwcYtu3lHvbbDl/fEBLCIbfjeXywZRShn+9buQZnC7m9G4H9dsTGlEVFFg/
RigI2lIZd7HwSwNs7aOwp6/peGkakCJPtdNX3ZjPHBsA3sKq+B10Rq2m8jA9vdet
TSofDYOFBhaTzd0hpqcus2QWUPPfHJrxjHTYRSnuZzhTdjAp8kj9ydGmkjSp/g4K
7tn/IHh1
=VnaR
-----END PGP SIGNATURE-----

--eqP1vlGDf3ttz6xH--
