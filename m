Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B91BC47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 18:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7097F87988;
	Sun, 14 Jan 2024 19:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EMVrtSjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 970E58798B; Sun, 14 Jan 2024 19:10:07 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151F68796B
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 19:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-783310bd2d3so613958385a.0
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705255801; x=1705860601; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d/gatJ+0wzkeYs7un4jsQFQFYcPmJaLfm2TJtlpF8E8=;
 b=EMVrtSjEqVyQOsu33hQKua/wHhWV7945wMVMh6n35zI6gU12VS/RkBL7/RCu5QQInj
 fDkgueFojecEGyfmBAXIoMSFB0vMvk+GUP15gmtVsa5P94S/y81LVVtJ6SA5x3y6HBmd
 hxfMCy7enBEOzsJNvfQyDlGir/v5kHplMu6+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705255801; x=1705860601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/gatJ+0wzkeYs7un4jsQFQFYcPmJaLfm2TJtlpF8E8=;
 b=sxSJQvOgiPGJ+5Mjhu119g3OODhS3QokDW3fxtbTdDPFRkQumczo5QmG7MDs8l9DBU
 jCqKnFIsu8IkPMGajHyHawEioKfQOMzuxdjFljSJVXT2zKB/PqM/Ry3OvIOp8U8m2BrQ
 so23nnezwDTUh7xnz+dvWIJADT/oCZzzYch8AtaHHKR/cgKkJ9au94XJ41ClaLXdXz5C
 a5/l+/F/2xapBZIVTS50acL3k10PEKpBJUYOUL1nZ3fJ+cN4yXntoJYajMYsTjSGTbrH
 oHVaFg3hgWhrSDCOtUgJOJi8VYbnnp+20QyAI5xwJKNQif16Mr91znePab/1cfUMeB+W
 ssIg==
X-Gm-Message-State: AOJu0YzWHC2iuDVHMvMTtVgF+ZtMVefVgAdQAYnvEUn8lMpwH7+W89io
 l/Fr5HW2vbcborMO6LUs3iNSnF+jNZF/MA==
X-Google-Smtp-Source: AGHT+IGYbdg6BMJHH10IVQw5WRr5rKW0Mp6gkgaD13LTC9VU0C773/LS0UwPwAgzM2mA7SeurqBgqA==
X-Received: by 2002:a05:620a:b8e:b0:783:4976:7f8 with SMTP id
 k14-20020a05620a0b8e00b00783497607f8mr4808796qkh.103.1705255801232; 
 Sun, 14 Jan 2024 10:10:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 vy3-20020a05620a490300b00781eb1e7779sm2426832qkn.94.2024.01.14.10.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 10:10:00 -0800 (PST)
Date: Sun, 14 Jan 2024 13:09:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Simon Glass <sjg@chromium.org>, Grzegorz Szymaszek <gszymaszek@short.pl>
Subject: Re: Pull request efi-2024-04-rc1
Message-ID: <20240114180958.GL1610741@bill-the-cat>
References: <61fbd4b8-8a06-4ade-882e-323a6d916adc@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OkglodNcuRBkvSO9"
Content-Disposition: inline
In-Reply-To: <61fbd4b8-8a06-4ade-882e-323a6d916adc@gmx.de>
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


--OkglodNcuRBkvSO9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 03:14:12PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 547d3dd28a46a18d59e00a153c8becca8d4e8c=
f9:
>=20
>   Merge branch '2024-01-12-assorted-fixes' (2024-01-12 08:34:50 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-04-rc1
>=20
> for you to fetch changes up to 55125bbfb48cb1330a692059bc972810f77b984a:
>=20
>   cmd: efidebug: check pointer after memory allocation (2024-01-13
> 18:17:47 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19306
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--OkglodNcuRBkvSO9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWkI3MACgkQFHw5/5Y0
tyyrsgwAiBstmYjFJ9QZji464GV0piuadz5bVMOT+4Fkq4tbWos5bwSUAyNMZMG2
joCUi/CF4C22DJPfT4faQQuAM+LJ3yi1KJA4cXwPMDcfGwiUcJpMtlS/M/qSyONy
BRPUd+A6ERh81605BOprR6fd31Celc2j/zrwExku1pZuqaXLVGZg2b1qE9r/xc2m
FZvKDDsPDxCY5A+Yk1vAhmVGgwYKmG0SyZo104itZvyTe7lpUSkfK6Im1cORSo3G
x5mwp+1luqVXg9jiGwApet91aGfhqHcGs1wqd5qwJjAYfLIrvISXBLYnpe6vJGAg
zUJyr8+Wb/M6EwaEORdcCAuXO7N7j4K50c15zJY8Gc9TXDzOTHQbQk0KVi5gxn82
HmQPsBjA0cCwxnLdXkvZb7r3pnNLbpVL5UGt4zs4s+k4dSDz7WAHeVLc2tMTjcHO
tjoRqkVAcTSkJi2MFYN5FSNzRDyCV19Zd0XJug83fXteb2b8SBoN33/2AApEGy0L
W02Vyw+c
=iL+X
-----END PGP SIGNATURE-----

--OkglodNcuRBkvSO9--
