Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0DA10A88E6
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 16:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9ED81E18;
	Thu, 26 Mar 2026 17:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SGumPU1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AC083E76; Thu, 26 Mar 2026 17:49:51 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C288880517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 17:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-67ba5921b84so732082eaf.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774543787; x=1775148587; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6g98s6cGn3ozjfcLZJ5nRA34MsxTvXRfaIFLLFci4BI=;
 b=SGumPU1/hCkcxqgv50tO5jtE+MqlFhRyXoY6jPvhcBP+Q9bqx9GZ2tJs1rXJM865Z6
 ODoma10wA3OLvaUh9OQahwLT9Fy/LGu+tpCJrLA4X73DvSqTkBU5srdJvMAW+IDI0Jiv
 0Gp7QENim2PruftwryZeNYR3x07HA0sTSS590=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774543787; x=1775148587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6g98s6cGn3ozjfcLZJ5nRA34MsxTvXRfaIFLLFci4BI=;
 b=F3WPVaSZiYPhO4iyLWqWUw51NVsu69GpQRWnwmrV9IgiqrNRGpBhowgh9I06XsYU2s
 iry6LnfL2saBVH5Gxo/Wyxv3SYFTW6YX3GAKmJrH/pPxd4fLeGvS9zUP46rbWdrXFCP9
 RPM9NW67sS/Vrex3A18qrPCxqUOtelZ+yFWDGNidT2GmW56lILWzRd/B9VVweWEuw7e8
 A+/pi6bIQIfTxqPwwj/slIFlML3JW0zx+HlH+SK4yztESuy5Zv3C1O4Nd0ZE/zFvtGN/
 GC6SqjqmE4/ssi1T0b8Tan11dDCyo9OjGXxJkzeA07kPHUGfwmDqirX38+dAdOTTIHUf
 dxKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNSZJXD3ONFO6RVmHFTDob1xPkT4NbQgtEf9Sq4VPwfwqGTr08hy9fdJp3lk/38hlXQVKgu9g=@lists.denx.de
X-Gm-Message-State: AOJu0Yzfu+Gw88GkXphuI8sQvr625mWngkdTQa/CQ1s8JlLkegJ4xhAf
 /ey+9r8egOT6f8cf8KQZjaQdzAvj628aw6YBZ4W91Lk267LC/ZHSuybNFYBeUbMJDXg=
X-Gm-Gg: ATEYQzxfA+ovgCYgkyydkF101jmoVLtSp6zJDGjJzRNmxGlAzPPy+i8O/0ePUI3b8XP
 tE+W3/gJKEguvNoEHDof5iMZAxZYSvSw2skTK4TaWdgpBHZeD8kV1kG437EiTaYVp7ulCKL7LEe
 L/YPtRGopFwgUsUOk3UzC9h/ljy495NNXepNjXK4N4tDUgeiLIxLHhoYdAHeU8mMRI+UEFLErD7
 bTMlX1PhkIEMB34Awkeax0VSjy8PzNS/Rg9Vq3KwCvOhmnudXnV9IqRLjIMmBptvq0QufsaWyh6
 xLRMUcMhvXJZRq1ODORd+XJn593p5VRzAEedCg375R877+y+kKxyTsdyTkTYQWYTVzaKzLu5hVN
 9ynoIVAwheFKGOKrYx3Bb0QfCZlgW/fdmkGBDApmctBIfKe0LGZ7YX12YVD0/Mya/KwkHgQZsqB
 a/1gmDcALuQcu4rF3NYsKF2OBijz8HiKLb/JWNGQSijSiu4ovcYTDiA7NcIM4ahtZWCbWhW/9Ff
 cp76Y4UwVzDKdZcE95r0lD9dp0GkmCaxDreUBq8DT842QJdKz+I30qvM0E=
X-Received: by 2002:a05:6820:1c8a:b0:67b:bd65:da85 with SMTP id
 006d021491bc7-67dff3d0891mr4113485eaf.13.1774543787390; 
 Thu, 26 Mar 2026 09:49:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67e0a9095c9sm2051694eaf.0.2026.03.26.09.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 09:49:46 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
Subject: Re: Pull request: rpi-2026.04 rc5
Message-ID: <20260326164944.GB502704@bill-the-cat>
References: <CALeDE9P4wDZ+yRSTnA5fWZgw8YOmEbr9gvc=snNVJ38TX9aTZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9fyeaV2WOtmatcFD"
Content-Disposition: inline
In-Reply-To: <CALeDE9P4wDZ+yRSTnA5fWZgw8YOmEbr9gvc=snNVJ38TX9aTZw@mail.gmail.com>
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


--9fyeaV2WOtmatcFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 08:38:59AM +0000, Peter Robinson wrote:

> Hi Tom,
>=20
> Please pull the updates for the Raspberry Pi.
>=20
> Updates for RPi for 2026.04-rc5:
>=20
> - rpi: Update the naming for bcm2712 SoC RevD naming
> - arm: bcm: Include missing errno.h
>=20
> The following changes since commit
> eb95914b9f5886b7ca0eaa2dbcd8a66bb8e5f81a
>=20
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> tags/rpi-2026.04-rc5

Applied to u-boot/master, thanks!

--=20
Tom

--9fyeaV2WOtmatcFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacVjpQAKCRAr4qD1Cr/k
CpTSAQDgKBXjYNPAbQ843tia4wJtU/o7uQyiNsFkoABorcs9oAD/cLGrqp01g+68
Owzvq/lmbEHbaH8nwKLuYWk8PJXJ1wU=
=HXZG
-----END PGP SIGNATURE-----

--9fyeaV2WOtmatcFD--
