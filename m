Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6045CE95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB22486C67;
	Mon,  9 Oct 2023 16:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gQJg66YS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A932586BCD; Mon,  9 Oct 2023 16:36:05 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D88F86B1B
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7ac4c3666so3458407b3.3
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696862159; x=1697466959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e6Y/tLKHZuiUa7OttQigcSJFnKXHWqJuwsU2v5siEmY=;
 b=gQJg66YSsv+9dR47j7txz2MY9WECyKVdhF1SF5xPQl3fFxE42Bs9QBqxs0pE3iinhV
 /kBoJuQPkG0bBZFWLIbMpY7UwoMEbu84hthdQcs01uEemRhEbZI0g43YrbAPt3NpM7Qm
 l6KHZEKkBnWMCyt2QkWIh9Ye+o941VoafiDog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862159; x=1697466959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6Y/tLKHZuiUa7OttQigcSJFnKXHWqJuwsU2v5siEmY=;
 b=eTxBAWQBhKhho6N94wmPjrG5oAodPDqwNUO3IfAW4nPDYBApo+D6RmTiVVoaEY560H
 fcDVjWAg12EN1Rclf4jAPNj0NA+NYJZ9XlhTc6VR8UOj9+VdSlabOqRvbqLZHC6tzN3j
 IxlpguMQWyVZVbz5/bWbCzIABl4Fco5n1KUplyKQzcd1pVy8tlY6VAkDGIKA0imPB5Y0
 b8BPRh3T/du7DMOsbbFwcb/PP0oz6nkUl+jX42jMT19gSzTnTFm4MnW+r6KF7joEnDR6
 bkxK7PAhmR9WQhPz9EYHRB3LQ9oZjyfoKyRaGsgzEsVlmR2/XmWAcPQfuWcZGLk5uFP3
 N2Ew==
X-Gm-Message-State: AOJu0YyMzcdAhr/tX1Uvp9omWDzuX6c9/p1wDd6Ilra6afX4bw6OInJk
 EC8jUjqyiYXPBVwpHI0mMxf0/A==
X-Google-Smtp-Source: AGHT+IFY7c6S/+ZpLg9/rysE5iJQiqEl23bKxMQpoHRKMew/nvvo/1huvbQqFrhENygk4efjO7bwUA==
X-Received: by 2002:a0d:d4c1:0:b0:59b:c4a5:f2ba with SMTP id
 w184-20020a0dd4c1000000b0059bc4a5f2bamr16805121ywd.9.1696862159196; 
 Mon, 09 Oct 2023 07:35:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fae2-bb7a-3833-e7d0.res6.spectrum.com.
 [2603:6081:7b00:6400:fae2:bb7a:3833:e7d0])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a0dee04000000b0059ae483b89dsm3733375ywe.50.2023.10.09.07.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:35:58 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:35:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 05/27] autoboot: Correct dependencies on CMDLINE
Message-ID: <20231009143556.GK2227687@bill-the-cat>
References: <20231007231255.277623-1-sjg@chromium.org>
 <20231007231255.277623-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sidAq+Uwyh6mAoC/"
Content-Disposition: inline
In-Reply-To: <20231007231255.277623-6-sjg@chromium.org>
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


--sidAq+Uwyh6mAoC/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 05:12:24PM -0600, Simon Glass wrote:

> Make AUTOBOOT depend on CMDLINE since it is mostly meaningless without it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--sidAq+Uwyh6mAoC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUkD8wACgkQFHw5/5Y0
tyzq+QwApvoV/h0TZyDl6451mCo7Tocu0Z1xiT5OZeOTOXiLcxUbMdQuXt6P87Rr
E6XyPTdtAK99k+bcHIIlJ+WS4ytyX9R6vlGgncYd+uHZNYik2JHaUR6lahOyssIG
T96KhyQ/pW2ILvMFv1PAD22vYsCCUOoSjlmUk09lMYKUarRQr+U08dcsR5zvRw4u
MChrCCXrZG74QlY99P06gEQypesKBRKPb0xRoSLFexhN+2+I+8z1FzMpVsPYTnjo
5tHqC5R03IxMNKcl5eL+RRzWmvYb+xfBWoscQiPzocJ2PrScDLKIKIibAyhoyp4F
OiNg2g5p+JHr3Qd4gXxLVNEGjqYzKQdWLqvMUtVYBoRQVZO6LT8AO1Aoo0UQLhy2
riPH04pBXFKLF6lLo+pXsSV2UTRZO44hM8WRQkItThrR5+AlG1EFupp8C2QRAtrr
Kzf2Bp0B/ACBknM5EZImFVOJGU+ArzjOyrjOaE733F6zcHQ0+9P6nxuwPwO4OEf4
3OB1VMaE
=4HJw
-----END PGP SIGNATURE-----

--sidAq+Uwyh6mAoC/--
