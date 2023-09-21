Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E04E7D0A6
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 19:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A73865D0;
	Thu, 21 Sep 2023 21:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aMukERUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1195C865D0; Thu, 21 Sep 2023 21:56:25 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63BD686405
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 21:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59c0281d72dso16969267b3.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695326181; x=1695930981; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YuUeWQTTR5J3GauFYh2loW0Y2W0l0s48DnNw8QVPlPQ=;
 b=aMukERUfriPoOPv8AB3AdYGxOfAEM9sSL/AkakQUfpqMWK02q5qV1O1lwA9pjD/C80
 BN87oo8FfqwhUgGim33gydDm8D3lr+EmWw2aq7v91UrWRUsqLGPsR7Vmu+i3NrcVdvLB
 7zOxCjVR43wxKfQTqt2NNXelulPMEKxp5ZBdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695326181; x=1695930981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuUeWQTTR5J3GauFYh2loW0Y2W0l0s48DnNw8QVPlPQ=;
 b=W5PxyW6jcaSW7YEXIxfPRZNSHBHD1gS9T/8Nog/TrVc7lD7kb3J5lpr7wivDnYgguD
 YLNawATHdbKqKwAv8MjIliXLxvNtWIVHHQ6YRIdXGXEpEXVi3LTpI5Zs1m7hyPzroDfE
 ht+yoVBeAu0KJ0n3UtXxh/K4/0ERUCx8swI60SN2DJ3aVzxv1rsbJtMC7T2TP4UWOHAp
 oKUm85udUl6C/5uG3fGLphfvLVWYcNiN5WhDgJpxPQfwdYLCx4/qZpjdnua50EpTb4Ue
 OJ/k2cDNtWTen/0bCiitOvWQAHmsYh0xnXGWvQla4ArERnXfppe1+bQQWfHS7G5VP7c2
 3zYw==
X-Gm-Message-State: AOJu0Yy/EfKYlF+rwAikuP/wP+sjyg+pA2Dv9M9lmER/6m26QMRYCAaT
 qb3saHbBZlwkDbmnruNiMcRZWQ==
X-Google-Smtp-Source: AGHT+IEEj44J7+LrSVhiU0KiqBS1aCe+gTH53pU2IbrtbljOirqTZgHXma+sgU1dd8iQFm8Glfuayg==
X-Received: by 2002:a0d:d655:0:b0:56d:d58:82b7 with SMTP id
 y82-20020a0dd655000000b0056d0d5882b7mr6955038ywd.23.1695326181108; 
 Thu, 21 Sep 2023 12:56:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 o136-20020a0dcc8e000000b0058390181d16sm502150ywd.30.2023.09.21.12.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 12:56:20 -0700 (PDT)
Date: Thu, 21 Sep 2023 15:56:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [GIT PULL] xilinx patches for v2024.01-rc1 v2
Message-ID: <20230921195619.GX305624@bill-the-cat>
References: <836f196c-e6db-41fd-9bfd-8d48d14c5800@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JhmAyL5wBieh6UDH"
Content-Disposition: inline
In-Reply-To: <836f196c-e6db-41fd-9bfd-8d48d14c5800@monstr.eu>
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


--JhmAyL5wBieh6UDH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 02:56:59PM +0200, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your next branch.
> I am sending it as v2 in spite of v1 didn't really went through. I created
> tag but CI failed because of sandbox CI trace failure. After fixing it and
> reviewing by Simon I am adding it to be able to extend ofnode functions f=
or
> getting functionality for our SOCs. All non Xilinx patches are reviewed
> mostly by Simon.
>=20
> There are other pending changes which are still under review which should=
 go
> to v2024.01 but I wanted to get this part done because amount of patches =
is
> bigger than I would like have.
>=20
> I was thinking about sending cmd/flash_is_unloacked fix to 2023.07 but it
> looks like none is actually using spi locking that's why it shouldn't be a
> problem to fix in 2024.01. But feel free to pick it up to master if you
> like.
>=20
> Thanks,
> Michal
>=20
>=20
> The following changes since commit c58ee1c9946a1550b1f6fee2b25da9ecc89baf=
71:
>=20
>   Merge branch '2023-09-19-tidy-up-some-kconfig-options' into next
> (2023-09-19 17:44:18 -0400)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.01-rc1-v2
>=20
> for you to fetch changes up to a3ade3dae4d93f9b5282ddb4885d69161729ec6d:
>=20
>   spi: zynqmp_qspi: Workaround for small data cache issue (2023-09-21
> 13:20:12 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--JhmAyL5wBieh6UDH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMn+IACgkQFHw5/5Y0
tyxCXgv+NFgWZC2NtdvzSUCWZpBstPZO5P7+NDTaIBT9k67pkXRBHukZOtda1wWI
O4ygwn7YPxTQKMvlZ8HzUcJ40jmrtzObUIvFpg+rs8StZB/I4itqNdy+FxeTp0fI
CI+sShfWJKYtTjP9q4jKk6VIlbq3U8wwlH+WuxFCeqGyhGjj5HtcWvTBQb8OhUqL
fjqlsGwGkn8BIBmZdjxbDw2h5v0nlp2FbkSm6/wK4K+MbWyU4HIM9dbzkyizOPFQ
ED04dvXTXAA/ntiuZAjtJQcsBdWyQIUX8o4EVq9a8BtIs2gRRHHY9gRrGnsx03bN
uaRyVLRQNikUcVHBzvyN/FtiU+IhDbMqh7Qf7cvR8wG5MrxSx7pbcOGlPf0OkLKA
v+R4w8Q1/TMnE7zode3JKOgUBTn+e9Oa/g/qdfplpgh05lPrxKX/9gQNAq7PU41Y
N1N5eo8Wdku3coFwAIobN9PkMi1/PUBPwZisYLCmMbMwafM3eVtcvv/2YWFreG4d
acRXkONZ
=SqIY
-----END PGP SIGNATURE-----

--JhmAyL5wBieh6UDH--
