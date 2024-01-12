Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A78C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3244A87AE7;
	Fri, 12 Jan 2024 14:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tSPC1gXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773988794F; Fri, 12 Jan 2024 14:46:49 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEB487AE2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5f588ce1b6dso52974497b3.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067206; x=1705672006; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rrbvcnRxvEiWzrjRGQTAYC7WGaG8BBv6djiUL9M2yn8=;
 b=tSPC1gXffQBSKUfoopEugWDjAijU2D6imL6fbcLWePjNr8wxFo3sd9kMnaSjsQEzCq
 FaY0jdcQ/i6w17gevAwisBeisk+6624NvYiAU51SJ5tqVG22/dQQmH571JDrRqaPkLr5
 ZXQvFrPXm8SlHZK0hfeXhD682S5ppAluXBF28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067206; x=1705672006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrbvcnRxvEiWzrjRGQTAYC7WGaG8BBv6djiUL9M2yn8=;
 b=CGcsKNrCvjKxIrK7tGx1GLIqa2fd3crmNiSCYYmZGliTXhuV9MfZwxamwLfXTVHjNr
 Vx4PpxiPe5OrWQDy/ZEzKxUcUlUYaCN32iSP1T+rTPqQGpZwa0BLOC4YDqsw7A78A6T1
 hnnYLyIBXc7y22USoywpj/4rdHJPc1qYW2VtQc6UZT9Q/isgXUJuHpVjncBhNjt6Ni/M
 aDOVVxiIuoS5Ux8A1nTAY0w20jTfQPIAkCu+HU6M43hgBGWXBSZuy2l7tLve2xlYjp0W
 uIr22WL2bUiBba3vMN+mT1nt9vpG4RFxnWJukzTooN154hjOk0PBiHlFDvHsksCYyNuL
 8m7w==
X-Gm-Message-State: AOJu0YzUTG3WDDAarJoYexs1fnUR8FKdk/2eQfMqbO/GhCQW+S3ksH5R
 NShvuNBY00Gk0G4uE4b9nWdOW8AAWTo29SH7SX8nPM2f4Zw=
X-Google-Smtp-Source: AGHT+IG6zfGbWpBug+aPKWW2NZRwOtliqS+cV626B3LtpgaKwFp8MwYgB5jYMgoaWzqHeNtygIxX+A==
X-Received: by 2002:a0d:d889:0:b0:5fc:3623:e90c with SMTP id
 a131-20020a0dd889000000b005fc3623e90cmr195428ywe.4.1705067206240; 
 Fri, 12 Jan 2024 05:46:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 ci24-20020a05690c0a9800b005f93cc31ff0sm1321415ywb.72.2024.01.12.05.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:45 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:44 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] arm: spl: Use separate fault handlers instead of a
 single common one
Message-ID: <20240112134644.GZ1610741@bill-the-cat>
References: <20231219133317.11101-1-csokas.bence@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sBpP8goehbTU2pVk"
Content-Disposition: inline
In-Reply-To: <20231219133317.11101-1-csokas.bence@prolan.hu>
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


--sBpP8goehbTU2pVk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 02:33:18PM +0100, Cs=F3k=E1s Bence wrote:

> It may be necessary to set breakpoints etc. on a specific fault handler i=
n SPL.
> Add a Kconfig option to separate the different handlers into their own in=
dividual infinite loops.
>=20
> Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>

Applied to u-boot/master, thanks!

--=20
Tom

--sBpP8goehbTU2pVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQsQACgkQFHw5/5Y0
tyxjOQv9EPk4tGqr/u8/pWi/tT+KZQo2/rHbo4iApjPqDmY6ADS1bnhwybHu5XHh
NaZIqgdZh5rYeMNpxjKKJWXpT0CMSyVpWpQaYt+P5+d8uTvTabqc16EjKmHIiDAK
wVI1xXyfvOSVdaT8cgOYolfsTT63RskYTYYRoryYUrDMyZWIEfKRjjAkYKKcog2e
rNBDrk6JNqzZ3b1Qo+mttlzivEbRsmSiiAvc8EiXoEgoBEHW7I7BtKBM4EMaIb1Y
7HItSTnCWpbmTnQdivb8KBYmmN80LGF++5uyw+PN7i3mlZhgWCcUzWVdTM4Tia4e
3yf8NERKhK4OpWjGCRWUsNo8beEW8p5BIsy2YymMoVhsdkdfiIlkqhhQ9IuWB3BM
66+O/3dZLq69xuEPOgAkyBlP7189+GR4P6V2m87+bd2RiZq0pgPx31hyDpuzhvfV
Tp9EM5oo6Iuyg/bpvO/JkQNRAbs/beH8BrDON5ROwBLmO3yGB1P9M+xnBmXfK7uU
asMN+G8T
=l8FN
-----END PGP SIGNATURE-----

--sBpP8goehbTU2pVk--
