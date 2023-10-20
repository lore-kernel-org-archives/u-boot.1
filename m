Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E877DCDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 16:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A230874F8;
	Fri, 20 Oct 2023 18:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OvzTPlUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0B287288; Fri, 20 Oct 2023 18:55:20 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8170186D3C
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 18:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a82c2eb50cso11650397b3.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697820917; x=1698425717; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fQRPXdJsSML49263URQvWcR5oFgTBMmGd6J+loVs1F8=;
 b=OvzTPlUAzRaIQY7VTmk6kkcjX6VAlKUa6XbKxOi1I25nGV62y7/xuwQuNpU7RACdcF
 dcn4LNpMrUYMA+rELatY4LzFU+1rg/O2qbyOpk2vUjXRoLz6ZTA3sT7kz+q7uztxrM+4
 JQd85euDygmP7DIdFNDMCfhruHq7xzS4rlEOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697820917; x=1698425717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQRPXdJsSML49263URQvWcR5oFgTBMmGd6J+loVs1F8=;
 b=OCOllNZf74YgGZc60jL1nILqc7AZXN24zbL54E9xHijVIuJkmi1QcQuz0FsvO/pSw5
 dCSF9liMDm8GQ59up50hyq6bjPk/2CbS6hg0iUe5jDGX75Tsi6TynwYzdwl9+J6xAUY3
 3E26WWHFw2bKZ7z3sXW2/MibHPoJ888GtLMSwxuvnvgDH4fui4IDVYxfxmEkgO12uR2O
 QFS8s+6VOcN5Qa2hUL1QBML3lbeYkXfC6mVoJysjRez0yh7mL0Eu8OfNel6+reAKZHdZ
 W3w+AbZZTSSXC7pEqze+8QyvTFHXkqMshe8GATo8gQQCYunkDkBra9JRqpreEhcPe522
 WHgw==
X-Gm-Message-State: AOJu0Yyz9Ew60A8Z/ekeo9yJhNAMGAVKPB5qBLA5oV0TWH16+FfpTS2C
 7lFeeL0CEjX3diM7hvqGr50MNQGAO81n6qiJd41gDg==
X-Google-Smtp-Source: AGHT+IF7D0oyKQ6XlLyq0JNVAxaAxCWPHtrp0V8U6itRwn32dDbQV16A2IGkLgQVrMkOjEXzofNBMQ==
X-Received: by 2002:a05:690c:d91:b0:5a7:aa7f:17d5 with SMTP id
 da17-20020a05690c0d9100b005a7aa7f17d5mr3533498ywb.11.1697820917291; 
 Fri, 20 Oct 2023 09:55:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 o188-20020a8173c5000000b005a7dd6b7eefsm803815ywc.66.2023.10.20.09.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 09:55:16 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:55:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PULL] u-boot-sh/master_uart_test
Message-ID: <20231020165514.GN3119521@bill-the-cat>
References: <20231019172145.14222-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pG4ThZhU2wCUu1vl"
Content-Disposition: inline
In-Reply-To: <20231019172145.14222-1-marek.vasut+renesas@mailbox.org>
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


--pG4ThZhU2wCUu1vl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 07:21:42PM +0200, Marek Vasut wrote:

> The following changes since commit e463222cce0df86f05a117f06e1737f539841f=
e6:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-riscv (2023-10-19 09:40:04 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master_uart_test
>=20
> for you to fetch changes up to 966caedfa89acaeceb6968f051b7ae26c4c6673f:
>=20
>   serial: sh: Add RZ/G2L SCIF support (2023-10-19 17:03:20 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--pG4ThZhU2wCUu1vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUysPIACgkQFHw5/5Y0
tywhUwwAqeVI+nOVX9fCMblcQAyZbIy/p8Kn3MVOSKYhWCV+k3srj5I4mxDjZqzL
10ORfOTiPFaJUDR1tfOK3lekfhBHPtzqk/lb1AHx3JTVP8StsUGkAGCzBCFTcGkI
WYyRCRiMdjPvUK/XDZdD/4NRtjfUgkGTNxz1Zhg3VlasBe9PpCW9Wp/CfCwPDDwX
PEnzIQ+7qj0NEjDREfKUdPMDFG/PU4Z7j7HnWrokwHwgSt2UPgtS3suS4NESs7HX
SHTDtqjd5JPllmjH4N3feMzNCM45PXV2MhD4SvuwEZ/g6aBknL73KnAPZCitzwuF
69VQHAKXTdWDUStjkDms4QGvpKWq4ml00FFxLh1HmjRVR168Yb3ocE8JxQFGco9F
ZN67bk0Znx5uO+iwTO2/jmqbUkEz7PaWy/HnRTgS8lf5tSPA6Dt83O+j7r2aaTlV
+RW7quQedRmiR7B6ts3NRupJEQ3vJbNN7QIl84HaBhyiT69tk/AxJ+aNyoOYL+bh
n5sy5tRv
=I+Jo
-----END PGP SIGNATURE-----

--pG4ThZhU2wCUu1vl--
