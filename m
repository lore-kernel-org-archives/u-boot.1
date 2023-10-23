Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AECC25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010DA87941;
	Mon, 23 Oct 2023 18:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gk+WYho2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D91B87940; Mon, 23 Oct 2023 18:58:55 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA6A8793C
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso33536117b3.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698080331; x=1698685131; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DaZYCzJGvcqLv+NZAtzgcG9Boon++DHOa9/YxNvNRvQ=;
 b=gk+WYho225DVNGhz5qeYXlRd+abH6H7g9panxztVsEHUDcfKC+MDT3cbwfWAyiYnyY
 XEw9TKiE76e/X6ZPEPTU7CL2dOkn2HbxnQORz4f+WSn8bErvomTD+QMnD9YfKOqZJuzO
 XUauYXULglpVGVvJmrfp7BcgEpgvA6HjMjWnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080331; x=1698685131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaZYCzJGvcqLv+NZAtzgcG9Boon++DHOa9/YxNvNRvQ=;
 b=Q0mSmUlmLp7ToHvIa6XOfPoqgFXz21DTyGCcA5oUz+byzLPIAJeCJQYE52ZHdmcFlt
 ZSS8sYU5cBOgoh6XSwzC7QCQY499InoXcQnekxBD4WcQIzWWDERTgaXJgbwE1XZNJ7v5
 80IbVEcNColoQiijDIsqVjriGSzrSYeIPNqNCse/k+Ae2jCYf9va80qmONherj7EnXrW
 kudXWRr963+4qve+JPWnams0+FPrKo6AeJIOVcATLxPQw1WOImUgyCYpTC039sixa3Gu
 GKFUimNCiJW5WZVPZSE8DMoFTzAn3V4letmUeaGCikb9nMNQXdKSzIt6cNnnsdwMN0CL
 puFA==
X-Gm-Message-State: AOJu0Yx+Y5snYq4ch6RATyrIqH+mJeW2DmhpdoYx1zeckgJ4rlqGlz1I
 NmK/kG1CT1YkZxI4Ean0LW6nT8mvO+stNt/0AQ4+hQ==
X-Google-Smtp-Source: AGHT+IHwqVCjyRB08icxLlH8Ft1YOb/1kY4gTsonF1mTX+OqXSumQE9yN1QZnraxMo9YPk3BiDz4YA==
X-Received: by 2002:a81:6d8d:0:b0:5a7:b8e6:6441 with SMTP id
 i135-20020a816d8d000000b005a7b8e66441mr8700486ywc.16.1698080331607; 
 Mon, 23 Oct 2023 09:58:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 m128-20020a817186000000b0059adc0c4392sm3282541ywc.140.2023.10.23.09.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:58:51 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:58:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-video
Message-ID: <20231023165849.GO496310@bill-the-cat>
References: <20231023121753.4b2cb806@crub>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oLjxW1262YL4xgBD"
Content-Disposition: inline
In-Reply-To: <20231023121753.4b2cb806@crub>
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


--oLjxW1262YL4xgBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:17:53PM +0200, Anatolij Gustschin wrote:

> Hi Tom,
>=20
> please pull video driver updates for v2024.01-rc1.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/182=
57
>=20
> Thanks!
>=20
> The following changes since commit 9a3a58396b78b1f9d0c14580dc03f81d29207d=
d2:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2023-10-=
20 12:54:33 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-20=
231022
>=20
> for you to fetch changes up to 846dcae7337e25d1608c891fb68ce4227bc6b710:
>=20
>   video: tegra20: dsi: use regulator_set_enable_if_allowed (2023-10-22 19=
:28:31 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--oLjxW1262YL4xgBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2pkkACgkQFHw5/5Y0
tyzOiAwAopD32+hqlkQ++zEmv09degu41uvx6lEnzqj8Av8mftPQo/qnLBly/t4I
73O+z87CR/fcrh/NfsjRfcncVY3S2pR/ded+FjXKlhO9ZHyO9xzy51jAbaTc5VD7
uw7DSnD8e9F9LKjvqL3merISHjt6ZhscdN1pCULJJauKIE00POftUkL6ZH1nr+ex
eAiOWHFMbZ+WfFg0mkyYgNABco14NrWw3gwDnzMLglmzue1fGjdaaE4oWPU0dnOh
ISZTt8iK2NG1lP5d4vj+7NZe6ajytPWQKEl3twDtHoPXVc4HNq0DMd1rNU998ms2
Hdplmh69NrDYFlIrp+kYr27Jl2GT43FwbdLfBWJRHkmk84jP0P/dAdPZ2lKgypZI
5u97IEHUwNPHLpI9n3n4mDtLFUkAbZ2XOxbMeV5sUAZo/V6KseRaKWQWfSN711F+
BoBj4DpoiBmH2d+nl3Y4YXr20aB56mIaKHTdafWa79MFzELg2HFQo6JaYbrOXWb2
bzB2Q7bf
=rVqa
-----END PGP SIGNATURE-----

--oLjxW1262YL4xgBD--
