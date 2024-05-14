Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFF3C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D77488333;
	Tue, 14 May 2024 18:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qt1cZy7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 717D78832A; Tue, 14 May 2024 18:15:15 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7C088339
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3c99d0521cbso2177305b6e.1
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703311; x=1716308111; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bk29AHMVnvj6ZFCCh6UZrCTNzFTxPOuaSnZw3otIVcw=;
 b=Qt1cZy7f267kact7mSW3/FtPSQRqYXdQk67bMJf2ShjyLsGKnJAV9HCnCHDJ4ApK2q
 asqeXpR8Rwqt2buPu7D9p1/yr9+xpKwry05ZkRWitpBATWXZpAUHRhns5qHlERwCJlDZ
 Fw5jjzyVfJjaoPeWCLqN4i1riBU2GHk+5Aeho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703311; x=1716308111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bk29AHMVnvj6ZFCCh6UZrCTNzFTxPOuaSnZw3otIVcw=;
 b=jxbFjUDZX2u8i2Tu/IpVaP300JpgBMS1A3zJDnEMrvLZbIDlHKAkCBkhgokmFjhgeW
 LsWzyng6z4k2xCECiylugzSoBJrgQil1yRCTHidoRLD7lBGFUQ439wKe0J94C4mcX0Qk
 zSxC+tN7PY4zmluQsts0YFt2w138+NYM7UgEc/jQP2q65AztNXYe9qUbii+E9DARJLDr
 ruDoNGN2TVUpRZ/XwHPSzjpK5DV/PA4Oxhj+hfy3FQtDLkf5iDoeOJwFP79E0O+/vcVl
 nXiIGG6UP5qiOMdJv84JXZnafosXI/+PHUXIJaGjq6xZHZfbvS7bJt/ojV0pmIKxwokE
 9dUA==
X-Gm-Message-State: AOJu0Ywnu1qrIFHzWItg9WmMh2Y9vNzPM39AYbGHoVbe5W3gx+Lu284O
 cK8PrXSJhhMeWgKowy/gUoAP9O26OVgFSeSUBAgf2soZ39BedGxkphPaUK8BYiapCnfA9U7ThWF
 usJw=
X-Google-Smtp-Source: AGHT+IE3VnXD5osfGvyCEW7BFT8ULthIVcg3czcEW1ot2I+bjVgxw6PFivn5l4yHuwLu2BmYToFz7g==
X-Received: by 2002:a54:450c:0:b0:3c9:7a6b:5d30 with SMTP id
 5614622812f47-3c99703733amr13348191b6e.2.1715703310884; 
 Tue, 14 May 2024 09:15:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf34041dsm575688885a.132.2024.05.14.09.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:10 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:08 -0600
From: Tom Rini <trini@konsulko.com>
To: WHR <whr@rivoreo.one>
Cc: u-boot@lists.denx.de, mwleeds@mailtundra.com
Subject: Re: [PATCH] zfs: fix function 'zlib_decompress' pointlessly calling
 itself
Message-ID: <20240514161508.GL2568172@bill-the-cat>
References: <f1c277becf620ba6fd949758704076ce.squirrel@_>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1rgMyMUNBV4KUfLq"
Content-Disposition: inline
In-Reply-To: <f1c277becf620ba6fd949758704076ce.squirrel@_>
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


--1rgMyMUNBV4KUfLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 12:40:38AM +0800, WHR wrote:

> In order to prevent crashing due to infinite recursion and actually
> decompress the requested data, call the zlib function 'uncompress'
> instead.
>=20
> Signed-off-by: WHR <msl0000023508@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--1rgMyMUNBV4KUfLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjgwACgkQFHw5/5Y0
tyxI9wv8CnHJlM1RBNHVjKNE8vlxPK5DUnWQB3V/VBrYKoGMmLunjqSIdDvb6lda
j48Hgvyc5oVOa0cdQRkjwMMS+lZ2UeEheTHwS+DHQiy19b32YRMz2451pyV3KTFe
Sq8ftpwTFrR70SX02OUBMwMdGGiBV6FaVN9TKFavd5mHomw7ulZrRWKozeyrhaaf
ws4+xyGu7JaKthgbihaLZZDd8aaiUgG0l+mZeaBjqkwc/Ui8kJYIS7BFmYqRSjN7
knNKMB+448ktCLvEDQWCruliB4p/BXhbHyFyOeUM0ZFPHYAwTCwmBZc33Zw7ln1D
p+dEZWBOfvEAzCL2FxFPjBzMCKZvwYRku7N2FKUqu/l3pCsoGvVgUf9HVQzkLvhS
JTcIIsjeOW0nDlxEosBpj5555th34xXfR7ZVZJMgqD8x4RjshRCvk9P4fApISz85
desgdmSX57XpkX1F6S8kuyBKizOXW23Vx/lidLo+KOwdO2vNfYKuihFE0Mp20oo5
G3W9OxoG
=+UZE
-----END PGP SIGNATURE-----

--1rgMyMUNBV4KUfLq--
