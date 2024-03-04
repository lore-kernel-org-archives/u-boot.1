Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E70C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C0988044;
	Mon,  4 Mar 2024 16:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jqo32aH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D67868803B; Mon,  4 Mar 2024 16:28:13 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97208805D
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6901a6dca63so30506176d6.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566090; x=1710170890; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mo+rfBQTzhxCfuOc0p7IU6pswfykHX5g96E7SIVoDbg=;
 b=jqo32aH046uBlnKoFkHhmGhsVgLMRtY8iYH4lqjBPPtb/nR+hepm2S4kTm8pSZvRr/
 O0ypoA6rDaGOmf9HNnghq62RV1byGiDjFL5axBBBp+4JyJC7T3hUMjZRDRJD8OykUxqP
 V9whPJtT/lwcbL3jJ+iI2n0dsS5qVd8DnQrk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566090; x=1710170890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mo+rfBQTzhxCfuOc0p7IU6pswfykHX5g96E7SIVoDbg=;
 b=AMGax8ym6+eS62ERVgZIZZqco94slMgZvSFmmzKh0G0/RerOwdyQWAPo9fE8QpVcou
 p0d+TKQpXEIagMneFYmyBy317OkLVjpriO6T4S8Wi/ZFLpuFcMnBtE8nHC2LDSthZEmN
 WYZunWdrjegDrkNZzFki4jh3eC4uocWUvzlUsLHYMNLqGh0FfrvMCzlm/CfwQD3WidQU
 T8Mibd72dUKbbLqQnec81FmcIk7V4h4WgDTMg4Tm7lOlU8ZTE6DiaGLJc8h5HbpNlW3b
 YFwBKLaofHff1rBJBhySxOkCY1sUwvOioJyAVcwqH56IYjZ7Bmo9P35gPlb9iZnHDJdg
 7ddA==
X-Gm-Message-State: AOJu0YyNNr7PRdcNccHFEiOguXvOvbRpgpY0h6FORqNG1vb0EFlODmvq
 ZZ8l8kF1RPCoD/yVuTabC4FTaBbJey2Lwp65R1f6tBRnhdhMtLRr+DoVDqFjBoEFFWcViWwSugT
 N
X-Google-Smtp-Source: AGHT+IEMXeCoC0smuOoUh2KmhdmPk4D0wWfk/ERezH9qf/u6wGAKrEjSVc2GLiUCrSxhTCpGe+Mi7Q==
X-Received: by 2002:ad4:550f:0:b0:690:638a:9d11 with SMTP id
 pz15-20020ad4550f000000b00690638a9d11mr5339903qvb.48.1709566090612; 
 Mon, 04 Mar 2024 07:28:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 p18-20020a0ccb92000000b0068fda83f293sm5195705qvk.121.2024.03.04.07.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:10 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, egnite GmbH <info@egnite.de>
Subject: Re: [PATCH 1/2] configs: ethernut5: Drop reiserfs
Message-ID: <20240304152808.GZ1523872@bill-the-cat>
References: <20240218235940.987876-1-pbrobinson@gmail.com>
 <20240218235940.987876-2-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lxmJNUFI8m7rtGxe"
Content-Disposition: inline
In-Reply-To: <20240218235940.987876-2-pbrobinson@gmail.com>
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


--lxmJNUFI8m7rtGxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 11:59:34PM +0000, Peter Robinson wrote:

> This is the only board that enables it, and looking generally I don't
> believe it's used. All use cases I could fine for the board rub by
> default off jffs on the nand and it doesn't enable USB storage.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: egnite GmbH <info@egnite.de>

Applied to u-boot/next, thanks!

--=20
Tom

--lxmJNUFI8m7rtGxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6IgACgkQFHw5/5Y0
tyw2CAwAphTn1qmVITJad9yxlPSpPu+fb+i2DRtYMAshtB0/PYvGuKMhVGxcGIwF
279s3xy+HSyzenYUv33m2c/BnFNEFxuYp7NuSCDirFRLPHRx1O1mAO7PtV+ppSUD
5qX2xoBd4r4ix7SJ933zmZjmeFfJyuTpmhqDeWGBH/X3cCP7+WFwL/hpG2jN9gqj
8ENvMD0Sf5iadCjquu39H3X7ZZcA10CH2YZcIYT7y2ovziaV9YYk22RILe/Gs9Ym
6pUPPOG8bJ9mDDpHzMVVU3E3P5tP9pUPv3/kw5ZrRSTO/5McGTzk2TNKyiQsErva
uVtSWC2f/uVTLuqrWLKI3jPd7G2X8WLEA78DUAwnV/JAZDBLQGyRspESIfrdDVFQ
qoXGAKEUKkMZ81c2Nq8H8s19s//IwL1s6rEoj1BfJYAbrxtl6Y4hEArn7AekBpka
skRJ05xqWN0sSOsqJxGpYMY9hv06iwfiIcnMC9pR9qTZy2dMdQ3WLJz37m1gLxkL
uN9M1vPa
=cfON
-----END PGP SIGNATURE-----

--lxmJNUFI8m7rtGxe--
