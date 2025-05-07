Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA68C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A0A8211F;
	Wed,  7 May 2025 17:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YYa3gjig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1615982162; Wed,  7 May 2025 17:51:27 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E098D81F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-401e77e5443so31461b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746633083; x=1747237883; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=26Tnw0IVOKuJc8RFNnmaSq4lG1dqA9wIFV1yjzlJEz4=;
 b=YYa3gjigKa09RyKcqNnFeUPI6atyiSpUIh0hXvNimxiUxJ+2vz2FjdMAwynk2yh+Ty
 wpEpxj7p6EcgH0piR4C9VhoGD5eH9PTAPN1S4gAEyImoNBUsWE7M45mhrMnKmPDhVC1V
 ZrFPV1CATyW3rzHu+EI9w112TIjAc2tuZSpSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746633083; x=1747237883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26Tnw0IVOKuJc8RFNnmaSq4lG1dqA9wIFV1yjzlJEz4=;
 b=b/0T0KRGhJ6GS7xfsX/f1B9IB0XJUcQmUrp93jMHP2eQRVNxx7sLCHen66AZrtwS+N
 H7zC2mI9yBJxTJJKiCfe1KaBfQshkKkiERyJd5U9VSohwqHTX4jS4hO4nMeTRLcwQkhH
 wvI2xkH6yTEegZCPRcAOTvqXf8xdbgTABPHngEcIVygKXnXlZg7QzVOVRlkJTFWe66aq
 MP08XphPvejFitRPN84hLTIvIN6zhXxlfUjkwDyUBWkwj3TsneturHM3ew+vjm/lYlCf
 D+lZC/9omAmqSnXuPgOXZQwsJKdsAHyuLP2DCEZ2R3SGdXP+jJQpYaLndaW79SuZVMHr
 NdpA==
X-Gm-Message-State: AOJu0YzWnT+WyP0/emE6aRnfOTyIVSbrBwdJzdaL7eN7R3wKF4VPYL4I
 WWvh5vgMdi2vONClOgIvCbUIUN10jLlAETSnJKYE9bCtT8CXrfvmwy7SlI/AxDO2FtmAcTZrFqn
 g
X-Gm-Gg: ASbGnctkyQHUeGu8Rfd7R9AfOgYAqnuujECjPAPe5054C8zvJ9ReJ39sj6mIiTzcAiH
 LitU4smEIY/kVLehlm0xAU/M2//ZWtoGHqd9mm1K56uIcK4yTf8BgNUYjt/JlQHooBdbKTwoWBE
 TilJHNMk3psjXl1VxCeWzVMrrcUD0IcyZUjVklAsLHFbxeFFR0Of/Elbe+4GUmuc5+EbFUlahnX
 SyA1UjsCtzUQsQr4Pvbr7jF65mQtt3QaGzAvpiehpjw1FV2gz2uKlTj3pugcW3xLd8DhqjCH4Lp
 U5onQ8MCckvmpujW9S7ytJZm+TR+aPaqTmY34HW+YF/wf5fwxZRSbRVzA7HjJTfxHb1cLCWLE0j
 fRA==
X-Google-Smtp-Source: AGHT+IFjvtYj+ZRTRC2FoaVb437GD3MNEkRceuZLpW3q8E8xt17EB2/xDvqyf2RcvaYYoLh7ULv4ow==
X-Received: by 2002:a05:6808:2121:b0:401:e8a2:76f1 with SMTP id
 5614622812f47-4036f06d095mr2578782b6e.8.1746633083664; 
 Wed, 07 May 2025 08:51:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7d10fa7sm2834119eaf.9.2025.05.07.08.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 08:51:22 -0700 (PDT)
Date: Wed, 7 May 2025 09:51:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: u-boot@lists.denx.de, nazar.kazakov@codethink.co.uk,
 javier.jardon@codethink.co.uk
Subject: Re: [PATCH] common: add config for board_init() call
Message-ID: <20250507155120.GM5430@bill-the-cat>
References: <20250507122342.495127-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I0UVltUfZ59VxXD9"
Content-Disposition: inline
In-Reply-To: <20250507122342.495127-1-ben.dooks@codethink.co.uk>
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


--I0UVltUfZ59VxXD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 01:23:42PM +0100, Ben Dooks wrote:

> Add CONFIG_BOARD_INIT to specifu if the board_init() needs calling
> during initcall phase, and default it to 'y' for the relevant
> architectures which probably need it.
>=20
> This allows anyone with a board that doesn't need it to just remove
> it from the initcall list w/o an empty code block in the board init
> file.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--I0UVltUfZ59VxXD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbgXgACgkQFHw5/5Y0
tywJEgv7BlRNDaKoAntD/bETnzG/vvQkUa1Wps1Etvw/CO1z2jOF/lHi1UMJR80/
ADEU8lakKAlWpf6jaqJOG4IXp67sBlZiYzglJWQWItCo6dj5t+rTynd6xfeXX1Qw
pjQDJUxZKG+EIJ2LOt4dxF1ounP4mQ88vjx4k5JITazfCjwfQ+heTc9Bc3SPIFjU
ds01QLnd2Em8nwPmrxntaq2INaNWCU0A+dCxHiE29L0mH0BSaZ2dzmmi4ZiH+jBh
8x7NUjWV3DYecWEh61FOQA7MMGLxxqe4hxL+S6LzsON2Ia5NWA+OkMpKtJdmexC+
lc2fDlTxv20UMwYHnHI4ZLjSfZiH4HYC86KZLIfXNJJIM+r+zeL24/cl+HQIuGLh
pM5vurrxc7k07EgQIX5FQF8w372sHzpdAn0zyw9fFrabQPAX6fLcuMjdG0K02nep
s2LfwHs85h8Mrvk6P9ml676ow2F6RMr0zUK+0mBQJ5HhJtTCzcTIdq9IPI8mnmkM
o7SNFBUo
=SOZx
-----END PGP SIGNATURE-----

--I0UVltUfZ59VxXD9--
