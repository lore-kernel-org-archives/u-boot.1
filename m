Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70512C05023
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 415398843B;
	Tue, 16 Apr 2024 21:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BSFHD6QU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8424D88414; Tue, 16 Apr 2024 21:19:54 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0972F882C4
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78ef9ce897bso40464085a.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713295191; x=1713899991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SAxSVwymt2bNlqaHtgbb6cTD9c6mjf7Pmkjy0gZIf9U=;
 b=BSFHD6QU51qDmRgYKO2XUO19fvdmBvn/q0WfraGkPCQVkNeMmdzn1JaPq007RcR2vO
 J2KgFYZ4YlK1Hs4BB+xpoxao5apaG/xAo8b1rgH4ssz5S6x6dlgouvkFH7wA7EuoGIGc
 /SjYPgUz6YEeFjtFuCfiGJQN8wXVcvluyEZgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713295191; x=1713899991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAxSVwymt2bNlqaHtgbb6cTD9c6mjf7Pmkjy0gZIf9U=;
 b=UWvZDSzBk6Nhn7o8yTzqcKlurVvheag9TwXjFH8C58tSKT3Up2WMor3hKiPRji/I02
 Dsy3P/sdCZxicFkXDWOwYBkSOMKlSBah3EeficYWEIz9NE3atXjMaCx1zkaLFIsu35TQ
 XAp8kAFl0hd5PF5rhdJcTyEsU1M0m/BxJFaciszOPYW1NYOgPaP83iwKyEDQ8vyNLV3V
 janY6mbfeeI3VTRPCW8xygou9Skd7+z/YIUCtY8/ApxJqRjRo1xL93/CNOH9RHY7Y8nF
 9yN8fh5syCalljiYnWKYBMaV0fRmBSBOXNFK9rDCWLzhFn+wvlQUYHe2AgjvoUegtz1X
 GqCA==
X-Gm-Message-State: AOJu0YyISEZlpGgeuJU9PXL6FcRsCHisJgVmDlZ0/8Qtn0ItO1L+hAwE
 nkM6/FVrcOgEIxLBPRFiPAMm7ZU0v4l9R81OcqYZWvcM7KyQmSwEecML8HPDZ0g=
X-Google-Smtp-Source: AGHT+IEkOUz23iWOGa+IFx20SWGjpu9g1OfE8VPBi2S9koliE0WsA7QKm4lp1R5Dm0Zqoqfm81ODeg==
X-Received: by 2002:ae9:ee10:0:b0:78e:df50:9eb0 with SMTP id
 i16-20020ae9ee10000000b0078edf509eb0mr8012315qkg.42.1713295190867; 
 Tue, 16 Apr 2024 12:19:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 c2-20020ae9e202000000b0078eccebcea1sm6151672qkc.17.2024.04.16.12.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:19:50 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:19:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 06/23] image: remove redundant hash includes
Message-ID: <20240416191947.GV1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416190019.81016-7-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tEmfFCyTzB1aELRE"
Content-Disposition: inline
In-Reply-To: <20240416190019.81016-7-raymond.mao@linaro.org>
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


--tEmfFCyTzB1aELRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:00:02PM -0700, Raymond Mao wrote:

> Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> u-boot/sha256.h and u-boot/sha512.h
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  boot/image-fit.c | 4 ----
>  boot/image.c     | 2 --
>  2 files changed, 6 deletions(-)

Can you please explain how these are redundant? It's not clear, thanks.

--=20
Tom

--tEmfFCyTzB1aELRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYez1MACgkQFHw5/5Y0
tyx1hAv/Q5uxQYIumTUwv2PyEZ5GKror3gIRdcVUDXy3jpMkg6QHP6cG0x1ML46N
Lm5qHTpPWI/6zBWxCp63hkyMzZlYjqWh/4S+hpGVlFvRpfMmpOcjlhHxDkucS8jV
H3YjUEyMVfphSil5n7p+WObAvrNTrOhYiEn8HCpWbIVYxLETdAiT02F3oY5PbZqw
7q3k4NeuNgbBGNUNWenlGxA2l3ykFgca5QQG1NOu3JaaJGcgux92+kTFHyxy8h+t
8IM5jPoP7uVA9sdIgrTrqvEv1HadK2iy3ZmfkoiPwXgFBgJjSD+VeofmSNwMKCqX
k/iICIp6hrqLm9ZFE6qX/uIDWTcoy3qYSveqbDdFwzLXD46zJPIqfXhgOveEeaa0
zQZIOcrC0NbPgGGGeKgcR7seDobrzST2PbypL6Ol3Xdwkos77qowu2xJ3Kxv797Y
P3CnTnzKBqs/dB863Fon39HRWIajsinX2Wt0cLZrNLLbUCYOlyS7v7a1iytkbKjL
9AEMbgSe
=Rev1
-----END PGP SIGNATURE-----

--tEmfFCyTzB1aELRE--
