Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61DEC38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 16:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E9B8899C;
	Fri,  5 Jul 2024 18:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PKS6Yhf/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781BF8899F; Fri,  5 Jul 2024 18:57:24 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6CA889C0
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 18:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5c47ad9967cso947965eaf.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720198640; x=1720803440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4fxjDCTJoBsJcGPwT9vCIK+suw8JJW6I9W6xeFIxpmU=;
 b=PKS6Yhf/ToMExB7ZauI0NhEO2q68qH0+UyCDxvjJnkJ7BwLvqWG7xMmd0sR6clvAEp
 flyS6n0cte2Xt04OxofTMfSAKWA7m8GBpq8i7KnJJNDxO3UAl9q3orwSYITJOZnqixvb
 zamoguwA7cb4MtqunddnwKV6myUs+yxsHtn7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720198640; x=1720803440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fxjDCTJoBsJcGPwT9vCIK+suw8JJW6I9W6xeFIxpmU=;
 b=O0790KjgPW3o4Rwey3Xe7fA1ltiAVflScJPlNVfbp0EKUp5coC0/v7tI9aC+t7xej9
 B9mHLBL/8dzx+Ak0Rb6yCCo/HQpX/qwUSWmh11OUMPEYZyovwpQOaFwtD8vsbMkUKQ8T
 SEKnKKA2Doj1/R++sHnpFhxg0EWhRVpgpmkSuIvVKUkcTsfLPoUE42wIBp8BWTQ0qSH/
 1ENsvZwzr5+MWQu8yYxiuj7HToXv1fdpWY0Rki35hm7Z1WhwS65NxcBmoOqiOKM2a4+o
 Fd13SEZtqHEEpFQcsREOg5zr/vrziHIDzEKSZw8SwcEUXBUcN2+hFpgGm7xQPpqPIWUD
 BGWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbmeIOkni4ZpldnCfJiUyysi26P+B9gpmXL2Qn+zIphGyF3Mx+HWhrpT3MCWVanRwdwQj/p2InabSwyzF3phMkpC9gWw==
X-Gm-Message-State: AOJu0Yxv/888lOtdhGqZAnLjhXax0n46sh3RnQ+MCOCprMWNUk/c0olw
 mJmQKJy3+rniOmiNbEEAU9x+/DKbmllE43MgxlnW0V7XmDqo2MHo3j+GogVELJo=
X-Google-Smtp-Source: AGHT+IF/krpk51/+HoraVL3CY12BCKt78THOvF5AMYwmtNzqR/2R6HXpHIsL+4RM4TMqJ+TIMnCNyw==
X-Received: by 2002:a05:6870:a68a:b0:25e:2a65:59c6 with SMTP id
 586e51a60fabf-25e2ba221dfmr4313930fac.20.1720198640227; 
 Fri, 05 Jul 2024 09:57:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e235febsm3758511fac.33.2024.07.05.09.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 09:57:19 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:57:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PULL] Early Qualcomm changes for v2024.10
Message-ID: <20240705165717.GM38804@bill-the-cat>
References: <20240705112414.655154-2-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nBpGTX+vs3Cpiuo9"
Content-Disposition: inline
In-Reply-To: <20240705112414.655154-2-caleb.connolly@linaro.org>
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


--nBpGTX+vs3Cpiuo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 01:22:46PM +0200, Caleb Connolly wrote:

> Hi Tom,
>=20
> Various minor fixes and improvements:
>=20
> * Fix Qualcomm SPMI v5 support
> * Move default environment to a file
> * Add support for special pins (e.g ufs/mmc reset/data pins)
> * IPQ moves to OF_UPSTREAM and receives some cleanup and MAINTAINERS chan=
ges
> * Add a reset driver for devices without PSCI
> * msm8916 USB clock improvements for mobile devices
>=20
> The following changes since commit 7c9c5c0562347dccb8ac89148784a34de402ea=
9e:
>=20
>   Merge patch series "xtensa: Enable qemu-xtensa board" (2024-07-04 16:11=
:08 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-main
>=20
> for you to fetch changes up to 69b37f1625ac0c9d0c867d591564af91c0b52d18:
>=20
>   spmi: msm: correct max_channels for v5 controllers (2024-07-05 12:07:37=
 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--nBpGTX+vs3Cpiuo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIJe0ACgkQFHw5/5Y0
tyxUGwwAsZczxs67aokDQvxhiSSE2OlLl0rq6wa+AwkyZAB+flBabXoJ3VTH+S8L
xRAfnVcv43XDDCNGh+GYy2zjWnbuikmYKtOfxqfqP/eaGGRvEyjmBGVbmQgS+fkf
UFySpWI+IRbl3rKW1M8LQR3IfZ6sFffY3T/Dbxkbn3d3+nGFaj+s7U83G2zVqeF0
4mf6lyDTq0zOqL4IqBVjAtjWAaIt8F/O43FIFZP8SCanwExh2AnkrmVzvVxZRzVS
A3fbUn5dWoNNioaa4vEFu1BVLGdovJEmNSebrHSELAP68Spy/kC0sRnku8LeoVBC
aEMJaQacEX6uU/M+nxCMtD2PU5ly58R9WAItil3/o1m410WCZ+oYl/pro/PYk8Kp
2VbZTsNe7dLaXTTn9IMrG/s/S2FsPlEoB3LsPD1XTA6ujAD0hds8nOdJoQQDKnd+
YSstYDacLQplA+pASgEpNRFfLJW5k1jEBRHryDcFZ6+FSKoD7uaF6p3cUiQoMPoG
AQa3Y2UZ
=wRBB
-----END PGP SIGNATURE-----

--nBpGTX+vs3Cpiuo9--
