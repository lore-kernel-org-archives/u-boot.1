Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F017ECD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 15:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D39D86983;
	Mon, 18 Sep 2023 17:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NFlWa4g3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2E88693D; Mon, 18 Sep 2023 17:04:32 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880B7869AC
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 17:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59bc956b029so44286137b3.2
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695049469; x=1695654269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IQaKDE0H4Pkr1WM530vJP6rVRnW9dRQNykQ+B27soeE=;
 b=NFlWa4g3sIJO5wC9t8CtsSxv/DBSofmDGJRciKRJcjZ9MVGp3afHR8/SEN/q1nlsEb
 FOxjGbZH4LN1BSzvfYW32++QTcEzRuvYc0Fa+/u5z4GJ/Mq2VI8/kms9SKGAq6J44+Rm
 BjjYWhFGNjnmJa8kR/xZiXihkB+X2VwpgZrJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695049469; x=1695654269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQaKDE0H4Pkr1WM530vJP6rVRnW9dRQNykQ+B27soeE=;
 b=glSDFmNESz0AG45ejbmKyAKRZLgxlwpU1LvDBsqJZ3GEs1TkJljvVFqFeC9rCs8usp
 SnUfSRopOXBrJgzT556W6ocdJ7xS+JPFgyUKw7bEFVkJHJO8yu+DvAKucqzoRIiA04GD
 q/JYuBpwIO9ntD4YEAtMLuZPdl8Z9rnOVbYR5kDIE7W2hhKcUq1U7N/kCqe8vTev2zpg
 GbICKJeJ2O7G6qqLtoTOzgwcWizexbgKbBVvcdKlBeKCFRE7p9CJU/I3YNoOs1VWzCXW
 ZzMJbs0qwrU86dnHEF7GGFzJ5ezjU6NYm/7Xknl9fquc/0YBT45ncqGYaoi4721Xq9n7
 +jYQ==
X-Gm-Message-State: AOJu0Yw+TFE/b/Dscqa53nNzZlD1d0+YieMS6imYXg+O6uQdiITXpQrL
 JywNGJc38y6q+YT8szs4FLxv9bs9jPv1/lNKz3xP4A==
X-Google-Smtp-Source: AGHT+IGg9kwiYKjOtF1Ypk1OUXn5jpT5ZH2eK6KiVNB2Ju+FEfyMnlYWrd56dpcOLIsa1/IBg8NxTA==
X-Received: by 2002:a81:92c3:0:b0:59b:bed9:9a3a with SMTP id
 j186-20020a8192c3000000b0059bbed99a3amr9877403ywg.41.1695049469067; 
 Mon, 18 Sep 2023 08:04:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 r190-20020a0de8c7000000b0059812d9719fsm2624283ywe.8.2023.09.18.08.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 08:04:28 -0700 (PDT)
Date: Mon, 18 Sep 2023 11:04:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Randolph <randolph@andestech.com>
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com,
 tim609@andestech.com
Subject: Re: [PATCH V2 3/3] dts: andes: add SPL config option for itb layout
Message-ID: <20230918150426.GU305624@bill-the-cat>
References: <20230918121136.2295900-1-randolph@andestech.com>
 <20230918121136.2295900-4-randolph@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hGdxYLGct13TY1MB"
Content-Disposition: inline
In-Reply-To: <20230918121136.2295900-4-randolph@andestech.com>
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


--hGdxYLGct13TY1MB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 08:11:36PM +0800, Randolph wrote:

> Add SPL_LOAD_FIT_CONFIG for binman itb layout selection
>=20
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/dts/ae350-u-boot.dtsi     | 1 +
>  arch/riscv/dts/ae350_32.dts          | 1 -
>  arch/riscv/dts/ae350_64.dts          | 1 -
>  board/AndesTech/ae350/Kconfig        | 6 ++++++
>  configs/ae350_rv32_defconfig         | 1 +
>  configs/ae350_rv32_spl_defconfig     | 1 +
>  configs/ae350_rv32_spl_xip_defconfig | 1 +
>  configs/ae350_rv32_xip_defconfig     | 1 +
>  configs/ae350_rv64_defconfig         | 1 +
>  configs/ae350_rv64_spl_defconfig     | 1 +
>  configs/ae350_rv64_spl_xip_defconfig | 1 +
>  configs/ae350_rv64_xip_defconfig     | 1 +
>  12 files changed, 15 insertions(+), 2 deletions(-)

So this is where I have a problem.  It's not clear why you need to
change anything here, as there's no example given for doing something
other than what you do today, and there's no documentation about it
either.  From other contexts, it seems like you're trying to re-implement
CONFIG_SPL_OS_BOOT but not explaining why you can't use the existing
framework.

--=20
Tom

--hGdxYLGct13TY1MB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIZvcACgkQFHw5/5Y0
tyz4JQv+JsDnbHkKqSg+KEp+NNKB9o/sSncMi37gc94TY3Rid1+4lmoWSPGaC6DM
mia8J1OeEottI7QB7cBW5YsSH+e9ytjxCmty1e6Sqkv0dF8hlrsabdGGd19dg93P
oaLTdaMmUfjUwe1w30KOOcnjoaw+d/sTufzomCmJZJ7XSBiH8r/OZQ274XgwTA0F
L0csrOQQXFhApY6Teeft/PAzo6O4BeUeRK1uZWmSucFGZWk54HReNWl9LhqSsego
bR9MX7mDljNYDbYtFgGjLjDA+RbMEm9EAFhCMQgkwW3liuOauoKnf7ECRH8ztXBs
WPq6M4S8aw4Y6HvGa7VWQHJYz3V0zypXnQZAMcbnJesLAsPNaBstGhf2575hXT/m
nM3OOWqURGp2pgSsk2gJ+u897ye67p+kq+KvqwBtb648jWqCEfsU8khOAehvqimB
pS27wGFEBkE57o1kDolMcGsyFIDyPtJkNzqW2OsJ/lTQskXfoi6WxqNEeg6aaOfA
BJIkV1j/
=x5in
-----END PGP SIGNATURE-----

--hGdxYLGct13TY1MB--
