Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2741C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 17:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F24D87719;
	Sat, 16 Dec 2023 18:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SV+cdVS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E00887719; Sat, 16 Dec 2023 18:13:13 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6ED86DD1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 18:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-67aa9a99915so13459166d6.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702746790; x=1703351590; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pUBOnXv/EmjIULDZmbURW2IM8TZEpFQiIhzwHMQbaXs=;
 b=SV+cdVS35/VrFU467Xw5FVSvayNXONkngI/7uc8CaMOtD7/a5nJPUlf5UQ+y+KEY1m
 +a67hVSwMNUa/M8gWYi+9CN7kMcqAbae1zLf3HsItmih7qQ0r1VrDPFB6tWSuVqAh3l7
 C9RctPFn0FRymeoxvgG0XBc0kM4iN8Ftgw/yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702746790; x=1703351590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUBOnXv/EmjIULDZmbURW2IM8TZEpFQiIhzwHMQbaXs=;
 b=MeqAFa/fN45dkwBgrg1NO1UYRh3aNkVDh3nr6+JriDJNTIVEoNOHcq3OxaIgC/dI02
 z/C5jqHLkxuA1O7k070Bti5YyhK6IQyo0k+w7MAy9bNQEVHCitnNrwU1ZOQYLuA/pXpy
 0EhJIRCP0VqsXMdKPw6ndkdn6aCMubVuCPCM7bQWk+9h2vywNDpyZOJkh/A/7JqbzlVJ
 eb/mpIWEQ4qNs8eFPclMG1+3n/Rl6tDXLy1hO0+6DuJefW7SV1H11+TJiXUx8Xb9O9sf
 O23Ah1BKpQ2MRKfo3N66CJTkBOoux3PLnCznfPZdHbStaesY/8o3HXjJaVW3aVCvACcm
 4cPA==
X-Gm-Message-State: AOJu0YyMhnyq3sAsYx5B2VrJrtctypsWVi5jNMGTjQGNub5AsHbBARXx
 Cjn9SHppD0gxgPv8w2vXEgvtIg==
X-Google-Smtp-Source: AGHT+IE5bigD5b4hbwJY2fZuCbSw/nyOAk5nwQdU8OpnBkDlksG5gGdLguR65Trn5OIbQrcvptY0AQ==
X-Received: by 2002:a05:6214:202f:b0:67f:27b6:9bb7 with SMTP id
 15-20020a056214202f00b0067f27b69bb7mr2491210qvf.45.1702746789832; 
 Sat, 16 Dec 2023 09:13:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a0cec8d000000b0067f319b1b21sm168906qvo.24.2023.12.16.09.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 09:13:08 -0800 (PST)
Date: Sat, 16 Dec 2023 12:13:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v3 19/22] bootm: Create a function to run through the
 bootz states
Message-ID: <20231216171307.GU2513409@bill-the-cat>
References: <20231216031446.2222362-1-sjg@chromium.org>
 <20231216031446.2222362-15-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Txw9QeI2cGJwMwvw"
Content-Disposition: inline
In-Reply-To: <20231216031446.2222362-15-sjg@chromium.org>
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


--Txw9QeI2cGJwMwvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:14:23PM -0700, Simon Glass wrote:

> In a few places, the bootz command is used to handle a boot. We want
> these to be done without needing CONFIG_CMDLINE, so add a new
> bootz_run() function to handle this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Txw9QeI2cGJwMwvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV92qMACgkQFHw5/5Y0
tywdRgv/TEJ88H8tdvVUtUPiHEGqkLh3TWuHph7hsa3TcIU5MrI+iBdSqSP/Td3I
wGmiZ/bVQODmm4zjt7QO6bzGC6wwIVkWSUePPKfISnctgHyF9qQQ0zIBAiUssL4A
ouDf2gV0iisbDVb3rrhskNaC0xvt0CmItY2leJXDaAhuq5QXBvuXOnTiZ3p9UHsS
kAi9xPhcyS9GuA2OeupJwdNUIsNbBTDwjxybbjf3vPEdyJ/rAkOpay4mUTzkZ1ui
uOg5gDZs/NH/gEkHPDhjlHVT4bEGq4PsSAG6u3TvebaUqTgChoDqfDqhPzM26KyI
J04zkEHFtmqlTF4xKLiXkdH5Ym8V6WEPa07whAaXr6gGK2c69scYql1BpmDyGgei
BscILgMkyfknw2bCHvJscwCphi+InfvzQVOgxsc/g/37xfj9jErxxvQoc5zfKFYk
5UIbo6kkKcLk7xQsEiR0Au27sbGXCC7aar6Yumd9HJ7rQnK80kCwHSXQfdfVZhzu
+t+MaqVt
=Oy9h
-----END PGP SIGNATURE-----

--Txw9QeI2cGJwMwvw--
