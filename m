Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1DCEE14C3
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 23:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9404586A4B;
	Sun, 10 Sep 2023 01:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HAnK7jVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97D786A4B; Sun, 10 Sep 2023 01:20:18 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C904846B8
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 01:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5922b96c5fcso30236727b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694301614; x=1694906414; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zNsDYm6pqF2YLbOACOhQdEMMh/n274xub404tg6WaHY=;
 b=HAnK7jVIHPcQFM79JRUZqZhS8U6kAitcNWIEvZ7gl62g36+KT11lI6OoJmPf9hOnPP
 NRwrjneZySzD0u/vRw+JkS2FxhR/uCDE0y4MWpNVidVOhOcklZjedCPga2HnLJQ0SFyl
 87S+fzGJEwVtyF5Bkl+Z7nLcYjdVqzH29y6zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694301614; x=1694906414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNsDYm6pqF2YLbOACOhQdEMMh/n274xub404tg6WaHY=;
 b=rmDi0lUOsA8MA5KFe+/zX88zcyU3G+ar1mZGwBIRQKJApYcpfM0ju7V5q1f3VKjPNw
 xpBoRLl/xWR8o2JWz21R6jkEiTItWwG5AD9IDz+YbJUbLWdQOPLpDFx3AmC09WTJao19
 lzwvwfj+gqXIrCf5RQ6Mzkp34+J7l3AJRXs3VP1yfRE9iMsX0hcnV2N0R6TbnFzwE4zn
 1lfAD3Zkh52ogcQ1ROxChkl4RCdxBI8k2QB0FiOHKmKDIg+W8v9tvVGoEDCfOzf6KkwX
 SqGj4woXuuWOB8efBNZySbOXTuLSE6fpZZGrOzfxnZ9UHyageH5ocJnH8MEVKA7zvsta
 4x7g==
X-Gm-Message-State: AOJu0YyYxuuYXrw5rpkPybnoih9sFGK5srOEylG0QOloS3HS4R/nSraH
 Qw5BN0y1cxfVJr60/Njm+aTOFQ==
X-Google-Smtp-Source: AGHT+IF09vn58vPANe4e8TUocVKljRA+l31hWpiBTSK84IVgOi5nSRYxwXdGkNp5e6Aerc2wL+ZalQ==
X-Received: by 2002:a0d:cc81:0:b0:586:9f6c:4215 with SMTP id
 o123-20020a0dcc81000000b005869f6c4215mr5927019ywd.33.1694301614239; 
 Sat, 09 Sep 2023 16:20:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1687-83fa-3eda-ba26.res6.spectrum.com.
 [2603:6081:7b00:6400:1687:83fa:3eda:ba26])
 by smtp.gmail.com with ESMTPSA id
 m83-20020a0dca56000000b00589e84acafasm1156729ywd.48.2023.09.09.16.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 16:20:13 -0700 (PDT)
Date: Sat, 9 Sep 2023 19:20:11 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>
Subject: Re: Pull request doc-2023-10-rc5
Message-ID: <20230909232011.GS305624@bill-the-cat>
References: <a29e29a3-10f0-4ff2-9e27-3bb771ab2b8c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xkcC9DcboO/O/TxY"
Content-Disposition: inline
In-Reply-To: <a29e29a3-10f0-4ff2-9e27-3bb771ab2b8c@gmx.de>
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


--xkcC9DcboO/O/TxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2023 at 08:49:29AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit c0c08be5468cb26db597932bc69c4eda112984=
1d:
>=20
>   Merge branch 'master' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-usb (2023-09-05 14:44:10
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2023-10-rc5
>=20
> for you to fetch changes up to 7314ba2bf8452df68d07f251aa59440de58067b0:
>=20
>   doc: board: ti: Move documentation from README to .rst (2023-09-09
> 06:12:47 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17697
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--xkcC9DcboO/O/TxY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8/agACgkQFHw5/5Y0
tyy8wgwAtWzz5Q36Wu77Z9gKt9bJDJ2zLl1vBMQR2XXoV47Z6HxImKjJFob6t7rA
4BFVlbe6An0M/hncQ27W95X6t8R11rBu/ASV6OPrDB9vlTZfNCg5p3YeXysWCqcN
VbuXybbSanc/whHmlyKU7DjqyVYcEhyt3SQ2j/izadSZV4iPuU0JLhMYr8HAvK/5
mf4yO53ga0fS8dJ4mCy6FFS6S46dAa0UN6YDc8jlKpStA9bdIEJs9gRU7CBN03r7
WH0D/AbwltCTPMZauM8b3uTGQ+Iq6wm/nRpKREIEVvHvy4Y9HtQOues37l6Xd8kb
ZMmRBVwS2a0CpyDUdn7sriItpMT73vnXQbSOWp/HFPRebZCbS4CzucHCTZ+A77Uz
6/l7CMZWmhyxvgUd8QOtyi8h+rXNlbWQ9UCarwWiiK4wi9tijfb/zRR2YcGXnbYB
QXsrZ6iGtmjNLuVGxAG+1h/OwNMP1KBJpdcjQnV0SVpoebzTFNiHFL0tH/+JgfzF
gnOU6iSa
=RwR9
-----END PGP SIGNATURE-----

--xkcC9DcboO/O/TxY--
