Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F709C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F6887B1B;
	Thu, 28 Dec 2023 17:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ALOuRV0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C66F87B1C; Thu, 28 Dec 2023 17:55:43 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD4687A7B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so3138836276.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703782540; x=1704387340; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=On8kkbS5Tctf+t/lIytkiM4H8xVMYo9WzgGn56+N780=;
 b=ALOuRV0oZTXJkGKbn+DyoSOH9s2o8mApFw7BNFkKW1f9WlW6wVu1Xk9gifjcFaMTz0
 jAHmJRdl0A0xyMIEM/5a3q/2wAtpW95MmQvRoGo2gp/ots0xcOOspyEToBTKfe9yMsXT
 WUrtgHbHAy8qJG5tqZ7XsnNODC99mddHjzktU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703782540; x=1704387340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=On8kkbS5Tctf+t/lIytkiM4H8xVMYo9WzgGn56+N780=;
 b=oQj2Z/rpKMWEA9a3kKQHhKoFPbZIFIQTBgecuzAiFcm7OW2dX6jz80fDm8TH2eEKx0
 lgmITnKyHAy7eG5WHPogirbLccarUxmSMuIViLvLy0umPxg7uFd6jSSNakrQhjzpAfy2
 O0gJ7ILg8a4QJGK38bgW8vtlW4paeH0lmjAwYebBOnG0CkS/usnDJXLQ/B77d50Bm6YN
 4E0OsX6WsIYTkVq5sZV7jsW1tVSgDHQsUIKws+IuRulv1b0MdPHnwOlyipmS974yON/V
 mPzdZGrzqcN40fcD1+fuePhpx+R4i7GGoGdbnJTg88aALocMuEP8iuGP/KoLckH7iaiH
 4TvA==
X-Gm-Message-State: AOJu0YzAe1kGdjk4EvhiVBr8i5Qs6TK27D4AtPJ3+1/hcYnEqQs78Mv4
 o3Fn17n9HpLJWitIApr+c8AvHJH6Yj5mXuwPmoH4ruSGSc4=
X-Google-Smtp-Source: AGHT+IHJds3LVbDmwumQOwtXJLBQLJfbO2iErK7EnCN5qaq31GqCeO1m6GCiykRNpmq8mM9yiY3R0Q==
X-Received: by 2002:a25:b45:0:b0:dbd:8d6f:4acf with SMTP id
 66-20020a250b45000000b00dbd8d6f4acfmr3192738ybl.22.1703782539858; 
 Thu, 28 Dec 2023 08:55:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 w65-20020a25c744000000b00dbdd56c6ce0sm5564298ybe.33.2023.12.28.08.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 08:55:39 -0800 (PST)
Date: Thu, 28 Dec 2023 11:55:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-ID: <20231228165537.GK2652760@bill-the-cat>
References: <ZY0Jwxaqw6bGOvBI@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nu25L/f4C0bGXNsu"
Content-Disposition: inline
In-Reply-To: <ZY0Jwxaqw6bGOvBI@swlinux02>
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


--Nu25L/f4C0bGXNsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:38:11PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 4b151562bb8e54160adedbc6a1c0c749c00a2f=
84:
>=20
>   bootmeth: pass size to efi_binary_run() (2023-12-22 10:36:50 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>=20
> for you to fetch changes up to 9924d44dbcd47bd3664fa9f1f9f24044d83eaebf:
>=20
>   andes: ae350: Enable MISC_INIT_R for ae350 platform (2023-12-27 17:29:1=
1 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/19106

Applied to u-boot/next, thanks!

--=20
Tom

--Nu25L/f4C0bGXNsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNqIYACgkQFHw5/5Y0
tyxHjAwAgRdRphYDNMS8GfgnyhqeVNdjIibFvynYP7kQSK7kLjHn4TTRiKZfGd+6
cBOJFOZQLUer2RlrrBNWQOuTgVqVOGwGJ9CvJQfF0kac1hCF34kIdZI0NWV90e5Q
Cb6a4BG4MNE18ZbTGKp1hXbxOQ3W3hYSNJbkToJK/vpCQ+h0Jsv+Cfd5kaCl3FZJ
UbVVbTXi7Nc4VsUmuC4naqz25WoAqxKsQQJ2SV7g0UDX4UC4F5hrJdXDcJvbsMhx
bPZiMv9PJRaO2Tw/DQESF4eC0QMhCHn63DY9XQhZuELSSRoZoFpnp6UgzesyPAki
+1B8Ez39s2vHFy83pNE7Xy1QEvf/u466dUAb3TzjwHlTfKSUZknO1LWfkjp95Tjo
geeezXmxWMjhFBUi9AnqwFNCwQBZBQJzyFI4nUW2xM8V/ty/7nPyRnKT++N8vTbd
GJ+ZaX1ZjvmwbNa7WettQW+G+xrkEuaI19j5mRm7E5oR7RgDmO9WlWMKL8xWzxST
xo149Rwj
=yOkO
-----END PGP SIGNATURE-----

--Nu25L/f4C0bGXNsu--
