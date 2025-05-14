Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0605CC3ABDD
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A82FC82A76;
	Wed, 14 May 2025 18:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cl4Rbpe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D49C82A65; Wed, 14 May 2025 18:50:15 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B2882A76
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c0b4a038fso4446520a34.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747241412; x=1747846212; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FG4q8K4mF9H3/98za57PUk7ajRKFuQZj0UDcZtuMHYA=;
 b=cl4Rbpe4sv+nMlMlLqMPQWqHyg48+OYRBaq2b6VV7IWarXpHMPdaGu75l8mnmAhU9Z
 V7tlNuutSferdjeBviTberoFHeB7PqMXtQFuVsss8I7j0qtVvAv7Qo979qysEGe1ZFgZ
 gepRs7wycoHxsrrJbxOkqd9j+RbxzOVXwW99U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241412; x=1747846212;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FG4q8K4mF9H3/98za57PUk7ajRKFuQZj0UDcZtuMHYA=;
 b=nWj4hkl9+rmQYMkzcXX4E6L35H/Ron0A2+BZC7WItQhuWFvZE/qCEYg7fuOLNJLRoV
 KEmL3wkyU5wdRiIaTbYEOV6lhRYWBj9GFvY4ufkq/+WqJlEKAVhMElvtcTy3ZfEJe6Td
 j5ArDUmIrrrovENM6bcFT4fX+SfDB7debY8TocXUkcWHfU5+nw5dhgfXXHz4RowAQJHa
 QdWCmGlzm7LmQm4H5+bTlThoUZY3FIaOr06V7yN+eMVGe8etpu9MDf05tMdbU9m7pKEN
 glZgQprV0jJiAQGusaJagpv7BgZ3dqDYqaO5EhCPRMf3UoYt4cy2mfjfBrFgTRG2vP0q
 dWLw==
X-Gm-Message-State: AOJu0YxuyFZex86FcuDS8iB0DirDhkT65bN0lm2I7UR6cp/ZIPrOo6vw
 D/Pb6jrDFdBorsCI37+xCFaBWjm+thOLa0Xo4NmzptBPuWuk24CbDs8FFpniLy0=
X-Gm-Gg: ASbGncvX4qQaGHhckaYWOwadIQUfBBJi3F5z3dSfLgHsdqfRkz5n4YRJdVwLDAm8Mru
 sCvK5NwC8NCeBkB/zFDchTwyLIGPXhdn2BJ5Rd1DHi42N2ilwGC46mfVI2uP5Ui0IHj9vLlLhYD
 CiFeL1MXaJ4mY83Dd++qI+HvH1mBCVMjnhaNn81fyuIj4I7bG53pB1WD7LlXA5jvrXpsggIp7NI
 Aqs56SqY6k3TzIZfm/n1c0aHH0IHalw0f9KzBjZ9ibWEePAXlNJizBbDKpp+5h+aPizMQrXA5lJ
 zR2MgqCVLIMOh7WkpiXnAuzRcRy0J3jZUMsk5j3X8Mbg9WGurxZQOCOPRvao20UYiH0oTum3Hho
 R6OutUJIe5uKbQKCcdMlR2ng=
X-Google-Smtp-Source: AGHT+IFQeFG5i1xcfn0I1W4zVBrGcsUTXVZOqOIWyNQB9n+AZ8RSXm0uxtU24o0ZVcUD7wx+BqF8Mg==
X-Received: by 2002:a05:6830:2a87:b0:727:24ab:3e4 with SMTP id
 46e09a7af769-734e13e227amr2736306a34.9.1747241411933; 
 Wed, 14 May 2025 09:50:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264d8ffcsm2396408a34.39.2025.05.14.09.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 09:50:11 -0700 (PDT)
Date: Wed, 14 May 2025 10:50:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH v3 2/2] cmd/Kconfig: select CMD_WGET if ARCH_QEMU
Message-ID: <20250514165009.GA603748@bill-the-cat>
References: <20250514161841.3591411-1-adriano.cordova@canonical.com>
 <20250514161841.3591411-3-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HU7t/UDpceEcZ03v"
Content-Disposition: inline
In-Reply-To: <20250514161841.3591411-3-adriano.cordova@canonical.com>
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


--HU7t/UDpceEcZ03v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 12:18:41PM -0400, Adriano Cordova wrote:

> select CMD_WGET for ARCH_QEMU. This way HTTP can be tested
> on the qemu platforms in CI.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--HU7t/UDpceEcZ03v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgkycEACgkQFHw5/5Y0
tyyWfQv+K7GIfejCahjTwiSqJRTe4PZFlPCFqvDaqae7IV2qIerAMyxaNxN2rl7T
nH2lAgHkDLZjqgWCJilbYeD1+CcJeqhwA8CTWzvoT6CLn8cTNkm7gpTFqMYAHsXM
8Hh/X38KyJTvInhLibJ6p184gFP1moWcfG3WX0IHQJCRwxXSyn7LSelpOf/gCH8A
3aDrPKaffipR0V4ZIyS1d/IMMNQSJoLw4GUW9Jwi9/Lm0zZdqE06h2x1U4xdnXla
oOae9qsZEF6wGT3u3ud9RocZVKbLppsG4a9zpfVdcNm0nvGjfnI14NJR+xlzzC/A
pT+BsWoMuClDpe7oaPScE8sRk9nDgd4JeE9Ibz8LDUyf2munS3x0SuRjjZ1iJaHQ
kdBN5OVDe4JH6dXYgz2NdNGDgTUawnkSH3A9jKNDvE6oUDkuykDNZf/OcNfQbpcW
b0IG2pQknXaaDj+DXrocadUzSIRzJks4ndhaOAKVk6CR2ZReDbRDfQn6mAoxR2b+
E/x4Vzv8
=UWkj
-----END PGP SIGNATURE-----

--HU7t/UDpceEcZ03v--
