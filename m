Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379E3CD80CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2EA86BF7;
	Tue, 10 Oct 2023 14:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uczaPcHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385B786BF7; Tue, 10 Oct 2023 14:58:06 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E300786BF2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7be61fe74so8382347b3.2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942682; x=1697547482; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7HCzqq/SeEofAuaAiazZETUKXz/r9G9mTN2fRzHbCcs=;
 b=uczaPcHBm06U7oGXIvRDM67LCjisRd92LnTNvDUJ7p+eBEUQr6ltRNp2KmIY6Av976
 V1ag8E2DpWCDox8c1VDSQm1D2oekCVuwyK51mRVlfn9wuhVyhJWeIpGckGLmMg40HlBT
 /qJC8BsmZhKiQv210OaAHmqOojTVuA5R6P+cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942682; x=1697547482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HCzqq/SeEofAuaAiazZETUKXz/r9G9mTN2fRzHbCcs=;
 b=m5h7/N/He6fEdumB0FiBfOXDZiL4CNAwRGPAh7+E8xRGgDgV4qJHuv389kr8rG5jGr
 fI+MHj/19OY7Czn2ekQ5L5kokTT55vduEV2fJXkziQF0JwjCWred+RZEAmAPjqRgaXdA
 2O9kxo27FjgK1S3Xo6XRxaXlBEAlHswh+C2hxS1O/XnBsSRmD4+H9QBX6rnyOXVAWD2C
 qMTpEcUyNpcPMc6s+Ot2Bmp+LyJIKDpnHIzawO/S1yibE5oeY4rh6uOLu5psAJ8l+na3
 cEGgyJmqX+WQgq5CuBDGhvDp++hMymaITfE9jYNfv6bhTfWtcCdVVwb+PBOUpQxb0KLb
 dSXQ==
X-Gm-Message-State: AOJu0YxJ92bKhoZjHP936yWcz8vTBBzWVwz3KBmsEvYu9F5p/Ja1/2FU
 KLN9tciI0Nfb9EAf5tyD7mqtvCkYONcMODx+c8cYvQ==
X-Google-Smtp-Source: AGHT+IFFvmurlPWMCL4gTo9ofjc8f1kUKIi+lCrZecjhNDHS2flhXbe9XkPtE04NlFCI4PKxpE8+4g==
X-Received: by 2002:a81:7c8b:0:b0:592:5475:6c0f with SMTP id
 x133-20020a817c8b000000b0059254756c0fmr18729708ywc.27.1696942682461; 
 Tue, 10 Oct 2023 05:58:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a819108000000b0059f802fad40sm4375804ywg.22.2023.10.10.05.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:01 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:57:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] tools: iot2050-sign-fw.sh: Make localization of tools
 dir more robust
Message-ID: <20231010125759.GV2227687@bill-the-cat>
References: <98ba4f3f-eea4-4154-9ddb-2ed616651204@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mgZrjnG8mfZ0qzil"
Content-Disposition: inline
In-Reply-To: <98ba4f3f-eea4-4154-9ddb-2ed616651204@siemens.com>
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


--mgZrjnG8mfZ0qzil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 05:41:09PM +0200, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> When building in-tree, there is no source link.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to u-boot/master, thanks!

--=20
Tom

--mgZrjnG8mfZ0qzil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSlcACgkQFHw5/5Y0
tyzNsgwAlTOaGUEZwboj31Sl1H7iw7ET91izxgVWo92KtsZrBNloqAYPrYK/T+WU
k3P8JqsTkU3G0XzwCpLnkARGh7Dr3dILHQfBEUwLkjzaots9PjCcpAWsQ0S4P5eV
K2qoR/81v5LZPT9n4Gky/1fdSGOs+T6u5mEYgGYtAT8GIrBsmDdmR2jWqif5JHtQ
cn4X+qKf8uCJp4+wKiJAh1o4azZJUTaEKyYRndjMAm96dCN7CsYtxle09RPFC9tb
Ms/wtA3uALGdrRTMuyr6ykHUlJf1qWjwluAB41QpOqKlEg72lynCSFtq33DqVxRI
0U5hgF5giljtBSsnIMwPjMiIVgAJLCXt4qtgNHV/6tdfYUdo9Pq51KLMOLtjGkhI
kQDZmwPcRajufTr9fEcrc9NEOzvYRFCrrJIjGLD8BFY9yjL59hw1FY6Sj5If+eqn
2S2KIA+9jjTYSxuiU7YCEJWQz44Smq0hghwzUFUdDk99wl47WyOlNmVoPSLMP7Wg
uWzRZAVg
=wh9G
-----END PGP SIGNATURE-----

--mgZrjnG8mfZ0qzil--
