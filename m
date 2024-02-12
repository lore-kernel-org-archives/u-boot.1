Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE66C4829C
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4113687EE8;
	Mon, 12 Feb 2024 17:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fevpS8t9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FCF87EDF; Mon, 12 Feb 2024 17:58:38 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926E587EDC
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-db3a09e96daso2871446276.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707757109; x=1708361909; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3uryNI8p3apJu6T7jZPqUrmZuXxu6DKhNel+dZTCuSc=;
 b=fevpS8t9xMrvJLa5oOte3UBQnNcjH0Dpc1V2Shvxr+Acg/Y7HhUMiMPuS8Pb6UEO17
 1q3q6U4sAo9ybrmu/6kaEExF4d7OpAtEk8OcXhbhh3xJxS7y9X4V4Q6jCALKJdr6g7+f
 LBTfHhFRvSg6jBQ2uedPQHYHWKxw9FYX/HAvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707757109; x=1708361909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uryNI8p3apJu6T7jZPqUrmZuXxu6DKhNel+dZTCuSc=;
 b=gX/I+f6VhFFJqnNWu57wx5pxtqtPcs1bPr8JJ5pOaSHU4/pzscWLCdaOXPGZEwgZCm
 LrCqEWd7GyBkjkX6mOJuY9RTqD337ZpqWuTkHPwZu4fD7Ui0X5emNWkfVIhLMKyDHTm0
 95d26bv/PUF331CWdiXlvcr1dYgZ9kup2xzu4j0V5UlTyKgT7dvEZEAGj5r4nJkKKvrX
 hPRxVqtPAqX5eRfL5EXiZmU05ZWM/YrKooXWv/Xj8QsZMQoYQHyUcoTzq7BAch6HBhlt
 SNzEz6zhJJXuGGjGBcMZo4GkiPw83VzoddMtyOXZYtz4j2RFvLbhZn8xR+yIDYnEtKld
 nlKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSqPLWYmVjfNx/CdXx4D5MOZGgmQSgrZqDB1dIggk/WjKtCAT7S+HFllINFaA6y5dAnZsXEJdF0MoX67BgK3cyNwu1BQ==
X-Gm-Message-State: AOJu0Yyt3leRTxv/2bffqLOpBvO3XTbtDLwJ9e9DEVBoHWkmFNZtY6Qz
 3ymWKNMRnHWY9q0JAtsJY4affTl0s7NlPisX2f5LIaVkNnf7vANu4r3CJ/YD81Y=
X-Google-Smtp-Source: AGHT+IHtpORTeXaXzWGDvJI3SgIn/s8ZMROMKW6TXki0aElNQAAGELD0CKolsFKxpfbmDY19oIkiOw==
X-Received: by 2002:a05:6902:2606:b0:dc6:9399:849e with SMTP id
 dw6-20020a056902260600b00dc69399849emr6299923ybb.11.1707757109354; 
 Mon, 12 Feb 2024 08:58:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUbarfeJIz9JCtVOXwu4peiCVaYx8AAyMUJzXAsKL7kBOaWhuTbbJ2WZJTQWNm8fydjX1rBxwNX4WX9iFpsKegExHpIcl/fLGgUV8P1OGnTWJniEDhjkfN+3vtpXinOlA==
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 x28-20020a25acdc000000b00dc74363dc0csm1303227ybd.21.2024.02.12.08.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 08:58:28 -0800 (PST)
Date: Mon, 12 Feb 2024 11:58:27 -0500
From: Tom Rini <trini@konsulko.com>
To: forbidden405@outlook.com
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC] pinctrl: add support for HiSilicon HiSTB SoCs
Message-ID: <20240212165827.GJ3040305@bill-the-cat>
References: <20240213-pinctrl-v1-1-e71c8ead72f2@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7KGTMFYdI4FM6DyC"
Content-Disposition: inline
In-Reply-To: <20240213-pinctrl-v1-1-e71c8ead72f2@outlook.com>
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


--7KGTMFYdI4FM6DyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:30:15AM +0800, Yang Xiwen via B4 Relay wrote:

> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> The first supported SoC is Hi3798MV200.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> This patchset adds support for HiSTB ioconfig module. The module is used
> to set pins config(e.g. pull-up, pull-down, drive-strength etc..) and
> pinmux.
>=20
> The first supported chip is Hi3798MV200. Adding support for Hi3798CV200
> should be also easy.
>=20
> Below is an example of the dts node:
[snip]

Has this binding already been accepted to the kernel? Thanks.

--=20
Tom

--7KGTMFYdI4FM6DyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKTjMACgkQFHw5/5Y0
tywl2QwAtzOv6v51W3G3/D6xviVHpj+Mq/o9s55XXLuEWyLDlXWudCDQw5v7WM87
CSll/8kB6f678BeUVkGVzsrcGkNb597SOSA1tlDiVvLfu+8TdpxBarRr+E9FVucB
HipSgVTTEujC4KyTmC/4ixIyuXvB0tCh37ZwFvpJeniJ/WkCyO06j187QVVnP+TL
fHI6Jd56yJkiqUrGDrhF8n14fEqGRfBs+SdXirtoSvkmlEueuWRsruH/+SRntQDn
7Rn9gL0A/Hcx49jQRllDnxMw3/UJ++AhTP8ETPefi5xDUVmKhCse5J2BsNoXWdxf
oGTJmi0dc8ZJANg1XiXvrnkonshX4CI7c11K2M9nLoPHDt6w63lBne7enfWll02O
JD1xQqLuDJFPC5+7bDtYnhUHFfM75eVToRuY6vdbZyGPjjfeqr9Riy79MQpxVGOd
HgJH/IRu32B23j+lscTTlKLAwrcbNCuMVig911J29dXTC0DALrJ0LqKlpfnAlFWm
Ppgii6To
=83H3
-----END PGP SIGNATURE-----

--7KGTMFYdI4FM6DyC--
