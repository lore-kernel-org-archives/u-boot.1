Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A2BD2E9EC
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 13:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B7F8917A;
	Mon, 11 Nov 2024 14:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uIIwflK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253168917A; Mon, 11 Nov 2024 14:24:59 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE4F88EBB
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 14:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b13bf566c0so277413385a.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 05:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731331495; x=1731936295; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=13RF9jGa1IfLJCFg7WqZ2Yn30yIkjWqpwtqGVTJVExY=;
 b=uIIwflK0EyzuIlHeZhG5e+ayYH64HSYCgGdSCiAmY0f84LX7VaUUsXsbUgFA+Y9/+X
 3gADx3NvIh40kgDGrAlW715tBKlTQLWXkt/juaEfXolRxLg0EICck43uFO31yARgr6zG
 cqnB4sMvxx4o8E8w9tN8rUFSM+A5NpD1Q/jP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731331495; x=1731936295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13RF9jGa1IfLJCFg7WqZ2Yn30yIkjWqpwtqGVTJVExY=;
 b=N2fpUQw5zFUfZzLFU3vwTmBWIQNbiM58UxHM1vToZnnz2+11As/+bnAxKzUx63egqT
 fNiK8wK1ddmXfCxQJ4lOw2CqR2cnucducLqDTbW+SW2PAMhGBUb44B1T1KGk28rVhIIm
 zKhVlj3TPKAHRFpzkKPfz41J/gAfwYMI1YXjhth5F2UXXNjJi1do0ego3oJEWnmlpeun
 YcosPCREtyHLUlHzn6YZIe8FllqI8UWIQlsZeeTWI3QcIbmDi8r4UTCvHUAOiw5rlRfA
 ihZRAYcj/EQzttNTBmzOufyBF0FDco3cHOvbC6p1YA9SV7KEMWyIiXO0DIt+8h7yKurN
 C4mQ==
X-Gm-Message-State: AOJu0YxxDXQSdFZ/xGRsUPDYlcuL38sW4b6viaHtIh+NMUhvGb5h0OKA
 TdY8pf39/QSzNXUwrmSAp1CCPvnsZbsJEaFDuQP18UWuRjOHwJu3x/htTkUgSadatIEbNWXX+f3
 mUHk=
X-Google-Smtp-Source: AGHT+IEz3teUTkV/pXBdeCGYSeLRrF/hfC/R4zbFyPIV04HKNUa/4oIku4XS8K+vcntb18azV2kGyA==
X-Received: by 2002:a05:620a:4108:b0:7b1:52a0:48eb with SMTP id
 af79cd13be357-7b331de2857mr1724093385a.22.1731331495571; 
 Mon, 11 Nov 2024 05:24:55 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32acae433sm493799285a.71.2024.11.11.05.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 05:24:54 -0800 (PST)
Date: Mon, 11 Nov 2024 07:24:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20241111132452.GR3600562@bill-the-cat>
References: <ZytdFmEgu6DgeRRf@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iFrbLVYWmjzN1SOM"
Content-Disposition: inline
In-Reply-To: <ZytdFmEgu6DgeRRf@swlinux02>
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


--iFrbLVYWmjzN1SOM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 08:12:06PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd2=
71:
>=20
>   bios_emulator: fix first argument of pci_{read,write}_config_* function=
 calls (2024-11-04 18:01:58 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to d5f5e778183d5908caa2954b9438614252b806dd:
>=20
>   riscv: Introduce configuration for 64bit version Microblaze V (2024-11-=
06 19:42:54 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/23239

Applied to u-boot/master, thanks!

--=20
Tom

--iFrbLVYWmjzN1SOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcyBaAACgkQFHw5/5Y0
tyxtSwwAg52ndI71AkkT7Uuh47JWwrMOAEqh5c1XuKjohiDIfVJt1Q28a/65W0Us
eiCUC+OvZh2nvnZG9Ngm7UbgTts6kYCPLW4t+d1D/lzHagCGbJ0h3ENH7+3ovOL7
kz7TOR+Nz/HCVZyWIN4tInmuiYjq2W+n5hMVuof9kr/jg1wSD3zwEORy7MktwFrh
7bnEI/SXz7QtARbl4w9jZWBLaV/H0Pf0sD55y0kghtKZaIBbhdkEugv/e+ze2oPh
JFe9VMgkInbLAgFWGoCOJ/rgFyvctiG/dNTVTuF7l6E5hGburIkUCvYPYm6DMeWg
dw1jjp8DUT3z0bVBTxF4U+awayFYiG7XxzKV5YmGzFXunkU5hZb8ZeJSDT+vKFnd
Vd6r2/Te5TrjwH0YCq/EaIftxFBsx9vQnIoesUUhKhxEhE/bMcLwvgWdUMfNV1rq
7lYtqsoYMC9m9yLglQwgpSuDeUF+Q74wXrlD619bGMkqMB1R9a7TjLzfHaS/zosY
VGScDINe
=91MH
-----END PGP SIGNATURE-----

--iFrbLVYWmjzN1SOM--
