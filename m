Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E11C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5A187128;
	Mon, 27 Nov 2023 20:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jbe1zYtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998D586C89; Mon, 27 Nov 2023 19:59:59 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BA987463
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cece20f006so24533077b3.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701111596; x=1701716396; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yVeFwWOk5Wd1SIW3qPilQxccef+dNOunyLRFZU8vsv4=;
 b=jbe1zYtn3lm1E3OmKGXJ+SVrHAe8em71Qq3tPiqUl+Dqz6Wm8rfFMS0x7kCMaCFNMC
 qa5f5BxwsdQP00vPtWLg3Rc2UDlfPGJD0XZAsfuty3IHgfD02NjddvWw4rTiXI5UdXYt
 P7+z82J0P/btGaTfe10oHvhsKyTAEYQNcqtuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701111596; x=1701716396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVeFwWOk5Wd1SIW3qPilQxccef+dNOunyLRFZU8vsv4=;
 b=aH6PMLCMN4nX9mVxYRA/kLyoDYTX/bzJYPkcqEnYLf2UT5OZb113XH+6azvKoIf+7n
 /mG0Ls6NSiPBvhvDvMmzxoQqZosVJgpWfK3TOV+sN9LuN1PjXOew71bL4OkRWASIwdXQ
 JdAZf0bg8/R0hg4WHxU5eDac84H2lH3mRbvMAHkj5T3OzKX490yfi1Hc9VPlO1vAVZvP
 7yoTVgFyz8ZP3Bwy5YAFBNfhL4fzGjcC4/pxZ323q8NvXexQfha5jAazvSxZX+ybk0Rx
 j92XiV9PaY916qspZQtJ4MhXqUTSoa2wT+mLvy+zu1LQP2c3NoJ4qkeQGTyZtZ166Hrl
 4IXQ==
X-Gm-Message-State: AOJu0Yz73AWxACodJpiZ6sBG8YxMVELAXoUnkbgB62FUZUHkr8WDGoVx
 ObiCLf22oOIsJ/5AZObN/Ilh/g==
X-Google-Smtp-Source: AGHT+IHl+bRNUdcT9vVjDNkuuG2reTeRPoXE9WAnOj/btO2brHhWvAPlpD7JpnN6rTG3cn27v6tdNQ==
X-Received: by 2002:a0d:fe84:0:b0:589:e7c1:96f2 with SMTP id
 o126-20020a0dfe84000000b00589e7c196f2mr10986904ywf.46.1701111596039; 
 Mon, 27 Nov 2023 10:59:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 n62-20020a817241000000b005ca9e337e2bsm3475429ywc.112.2023.11.27.10.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:59:55 -0800 (PST)
Date: Mon, 27 Nov 2023 13:59:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
Message-ID: <20231127185953.GW2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FszK+Mxl38a/SQyU"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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


--FszK+Mxl38a/SQyU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:56:43PM +0600, Maxim Uvarov wrote:

> Hello,
>=20
> Please find updated version of lwip patches. Changes are in the
> changelog bellow.
>=20
> Thank you,
> Maxim.=20
>=20
> changelog:
> 	v11: - v11 is mosly respin of v10 patches with CI error fixes.

On a RPi 3:
U-Boot> dhcp
Waiting for Ethernet connection... done.
eth0: smsc95xx_eth b8:27:eb:fc:64:a6 active
dhcp_tmo 20/20
=2E..
dhcp_tmo 0/20
DHCP client timeout
U-Boot>

And aside that those prints should be debug(), any ideas? This is
rpi_arm64_defconfig.

--=20
Tom

--FszK+Mxl38a/SQyU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk5yUACgkQFHw5/5Y0
tyxwUQv9G6c+IIk6tZcOM9szRQGL3MYoX9ddobRGKkcSRAbbSyaElcdt0F4vebB1
o04yR0/N0GLtXv6DSwCdZIywEP1v3dSWUN7jPD1o88vrEF8o+s3Z4T/hrNA6eXD4
3xS1/aKSpBrctAWfZLOiJTJM3+KydLDvlno2UDWm3s6XMIvRcHlN2nBUbL6GCdDf
/CVGlr+5ofBANapV9l+S69yWqL8HuAX5clbithnxRsKw4fezlkuBm/Yu8HqRjMQ2
vZ2DT5iIO1cbrv6XjaZ6Du+J1e/9DVov4mCaMRmG+JJxCC88Nl188kMAzzPoqGkt
UcXGI69xSyCe+hmwumFT0V6ihkFe8ILBDEdIi+T4JJ7truwoKh6k9DNjCHCDUp3v
7kktCJZsLT5xNPUlQes6esvNpQXnYLMuqge1GSSLp1J96Gs5hoHhTDormRkwReIi
Jnw/DofWKtNvqvfECt0kvKkah5di7z/q8Dv2ylgHB7Yi37aBJkn3Z/GotxFrX3vY
tdIB20c7
=bf77
-----END PGP SIGNATURE-----

--FszK+Mxl38a/SQyU--
