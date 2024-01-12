Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E685C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E75787B0C;
	Fri, 12 Jan 2024 14:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lnpyaX16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4C787AD3; Fri, 12 Jan 2024 14:46:41 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2747B87AE2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dbd721384c0so5167084276.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067197; x=1705671997; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ob9AcL/qSyBirknSrByS/T/aUgWVYni2c9yOkyZu/Lo=;
 b=lnpyaX16ql7skqkdHmZGyUw6JOrb/b3jwHSjXnmGXsOoFOtY8bv07jhFqrdE6onh0i
 F/Jc5jizCPVAIi3rk/UR/P3zVdp9ZjnaQlONtz50R+pWssu1PWeJMwXEBBaPGG/l8NOO
 6kUlNOoKNTIBuhHbNEg5Llw6rtGXYKVIInMpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067197; x=1705671997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ob9AcL/qSyBirknSrByS/T/aUgWVYni2c9yOkyZu/Lo=;
 b=raoZK6Xxe5AWGeuhlMu1H+F8IZTQtSfOYrYGHho4OwAIZcwntl9ZnoXLku6OafNVEO
 rsCafIJ8FwoUcSKsbA5yC5Q85FB1pjYKB1AmbV4Fy63peh7iR+uewUOjMihLmQg5LSOA
 fNVecBR9mzMQ3bjhzhduWnPJWKXhqWEJ077eQXAJ4T/pQPS4CuCxhDXsfy9Xf6mKxeP4
 zKl2rvgiPKgBD0pc6hLdAt/uRBCDfaP1OTA2lFdROjk7TTcK9tJvt53IU0hs9mp3lpeE
 YNx6n7PcYR55MkNriYAFkxr0wzyGxpUEnYtK2getK2Q3zTKy+EdpZJmTYXyiQLiH0Y8S
 eN6g==
X-Gm-Message-State: AOJu0YzcyokJvtNmcq1sSE+KUddtTWO9c1JayjJT0FzMDyO6+p5SE9H9
 LPhdOciQdpfl0eQGTHlxzM9ioHHZdnI8NRoNMrqP8eM1hCk=
X-Google-Smtp-Source: AGHT+IE6ATu6yj8bJ7jkjeMF+3f+Erc6X/3P/mhhK3GB1nrHe4EFGmPVT37xXe3tpKw8ro5vxCrQQQ==
X-Received: by 2002:a25:d2d1:0:b0:dbd:5baa:366d with SMTP id
 j200-20020a25d2d1000000b00dbd5baa366dmr705287ybg.54.1705067196835; 
 Fri, 12 Jan 2024 05:46:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 n17-20020a259f11000000b00d677aec54ffsm1174428ybq.60.2024.01.12.05.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:36 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Terry Lv <terry.lv@nxp.com>
Subject: Re: [PATCH v3 2/2] tools: fix build without LIBCRYPTO support
Message-ID: <20240112134634.GX1610741@bill-the-cat>
References: <20231221072611.11479-1-ada@thorsis.com>
 <20231221072611.11479-3-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VWH3EwN+vZ+4Yv2c"
Content-Disposition: inline
In-Reply-To: <20231221072611.11479-3-ada@thorsis.com>
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


--VWH3EwN+vZ+4Yv2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 08:26:11AM +0100, Alexander Dahl wrote:

> From: Paul-Erwan Rio <paulerwan.rio@gmail.com>
>=20
> Commit cb9faa6f98ae ("tools: Use a single target-independent config to
> enable OpenSSL") introduced a target-independent configuration to build
> crypto features in host tools.
>=20
> But since commit 2c21256b27d7 ("hash: Use Kconfig to enable hashing in
> host tools and SPL") the build without OpenSSL is broken, due to FIT
> signature/encryption features. Add missing conditional compilation
> tokens to fix this.
>=20
> Signed-off-by: Paul-Erwan Rio <paulerwan.rio@gmail.com>
> Tested-by: Alexander Dahl <ada@thorsis.com>
> Cc: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--VWH3EwN+vZ+4Yv2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQroACgkQFHw5/5Y0
tyx6mQv9GxWclx//58rZj70QuZHEBnG4N6IwYiUSKyKRWXhLXHpyfXQqbmm34pFM
qo0dfODE8Gi8CmOy1PzJ6jqPbli63rxhuvres38tAik3fjO6cb7ya+dRhl7VgoQn
QK1vUMBe4R4OQodkxzVRRB9mDfxPHp7P/Cdo0xTeEJ20DzLQnpYoEbq0bLtsPQ38
XpgJ52OmHCkPVh/eFXtip+yC7vK3zCC3QO6/5vkAjHhPLgHpHuk5krvayiCp7sEW
+CSlxiFCvm1SXJXa09tE5r+YVSx06jjMwA67V7MjgyvibbO8BSfnXd55fdo7ryFM
FpdwDd9uMLgnis7bfesn8dN44GUmN+YAQ+jSNLA/0bHzOSOwbA1SCXCNPvwjOryg
Ljy4VnweFPHMMfccfPBqxHL6BQJrqCcdswBsjTkJ/kKHhokCsYvSxzARMTeEPQ5D
zXkA3Ak8+7SCp3UoF0P0JbtwhRsbJY1u/jG14+numddKQbppvRs/t3jTk4nJk0OR
77cD4r7k
=k9M+
-----END PGP SIGNATURE-----

--VWH3EwN+vZ+4Yv2c--
