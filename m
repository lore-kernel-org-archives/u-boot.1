Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2305FCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED69386E0E;
	Wed, 11 Oct 2023 21:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hA6pSVAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D27186D9C; Wed, 11 Oct 2023 20:41:14 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C7286E15
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a505762c9dso1823257b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049507; x=1697654307; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5W9Gq4tOl0JaSl/I8f1KqUW5vCk5T8kXk8JmVXGcMN0=;
 b=hA6pSVAA/OSSR2Y93+gBOVl/rO1jOS6MGag27+h1gscAXcuBcJA9tcmeltPERpCTe1
 yYsM616GqBpmy14OxBuru3zRXaWVrnl4lb9i2cLVZynMegTeDc0tarr5EiiUpYBHAlUs
 hnhSC5UKDVXSMb8VuyaJNWqykXv8WF/DQU0ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049507; x=1697654307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5W9Gq4tOl0JaSl/I8f1KqUW5vCk5T8kXk8JmVXGcMN0=;
 b=soR4QZTIOc4OwmZPjEV44eGk13eSiZiHcsCY2WBeKubMBg17UNgQ2GclYFbcBma4eN
 9sK+6B0jM8QFGQ4aFz6wE6UB/yZbA0EztwfsML2T0TFvdB2En+2w7CE1IlBcC8rteBYj
 q/fsNfUWEGjbb0ENNYpN1HgEZclB3Ilv0MA7Nf50GX8WZv5IIRckSLpYWATsSlPiVjP0
 djfs1lkTpDpoTPQOlQTuaYexzhuHofyCTy5Vwo7TeWhFt443v14ncu7kj1Vm0Yg9YXCi
 A/T6Zq9CknBrwKKCejbYRj7X8XFbLqsfawszqMOP5/kr5AEnhmFGAoJMCoyKfih2BQPV
 uw0A==
X-Gm-Message-State: AOJu0YxEL97j8WJqob0jKRr7iCk1P13KtLZWhfng5+hLGj9fLTpA9fGk
 LLsCjDgGt1j4CsVq+IA0nPgWKg==
X-Google-Smtp-Source: AGHT+IGYX6eYIg/oyW2uNEiTn91YAaHZ5lMnaYbN8eAmCe6ktji25E7rzoQDKfY1AAeK8V08wVb4Tg==
X-Received: by 2002:a81:9283:0:b0:59a:ef7f:5c67 with SMTP id
 j125-20020a819283000000b0059aef7f5c67mr20532209ywg.31.1697049507478; 
 Wed, 11 Oct 2023 11:38:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 ex5-20020a05690c2fc500b005a7a4e3816esm1888205ywb.89.2023.10.11.11.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:27 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] malloc: Enable assertions if UNIT_TEST is enabled
Message-ID: <20231011183825.GG3119521@bill-the-cat>
References: <20231008020156.1990125-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C8VqK/xJTRBjwiio"
Content-Disposition: inline
In-Reply-To: <20231008020156.1990125-1-seanga2@gmail.com>
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


--C8VqK/xJTRBjwiio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 10:01:56PM -0400, Sean Anderson wrote:

> dlmalloc has some sanity checks it performs on free() which can help dete=
ct
> memory corruption. However, they are only enabled if DEBUG is defined bef=
ore
> including common.h. Define DEBUG earlier if UNIT_TEST is enabled so that
> assertions are enabled in sandbox.
>=20
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--C8VqK/xJTRBjwiio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm66EACgkQFHw5/5Y0
tyzdbwv+Nw2VcRJlZ7baiI6EncV8zPqAOzCggPer32FfmTPAY18+mmf4ZAyg1iGn
z1NCq+9feqJZ+DpyQAmRyKFVxouPVlw7wchizGtagKIv8ZkzRdkFBi8Sl9qIaqzP
nzCn1dLKDDK60t3bJ6Hu5uiSN79M53WG6FcjUo5kALvx2FQ8V2avtiMUraMd53Yq
kwg9slipByRMs7UDN/B4NBgdwnI60oZ2dbBSTkRqBdgvuF8jsOgSXxg5peOgOe8V
3X9cSnTNbJADFUAGmI5sX76ho5qwEwEghpr3o36sfAFcFiE7LQm3E6zGpDEWVMgZ
7rVCptwGb9M1kGLDS2h5XP6BLdoH0P/zpmS76+8AfuaqwAX+kchd0m1BC+i/uC24
dbdbLcHBs7MfhmoiP42a3me1hq8sI+epHVPF03kSm27l5uGiTuFSCfZkx+42GBA5
jnS06cBsGgu0DcM9oonSDsj+qoyYj3t2nXtil7P29yrw94eIrBf3qrJz3m7Vq65r
ZxVYY7qJ
=cYFk
-----END PGP SIGNATURE-----

--C8VqK/xJTRBjwiio--
