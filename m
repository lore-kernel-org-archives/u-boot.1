Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ECECF9C71
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 20:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C793088A4C;
	Mon, 23 Sep 2024 22:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rr00pKxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4131F88A0D; Mon, 23 Sep 2024 22:36:19 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23870889C9
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 22:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4582fb3822eso34174581cf.1
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727123776; x=1727728576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=68pRHloMJPAuatqGzkoupwbA1P00InkHfNFXJVlW1jI=;
 b=rr00pKxrZLpZo3tBckgqkxG7Z4vTw/WKHBEu+ax6S3KKCzuMr+eh/73xDmyidbTGfT
 RZzTBdgx9kBuHFf2EhtRGundJyNxMqfVXoYdHL70pdr+JRVqvxt+T8emq+9HPx0hKLZt
 vPgUABtyQmhw2jGrX8DEQF82ee7TnY+h7l1qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727123776; x=1727728576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68pRHloMJPAuatqGzkoupwbA1P00InkHfNFXJVlW1jI=;
 b=a1SYUeH9NxGLfIhXmRgrMOZiiA7gdcw5lhdkXKjnbcoheUO3+cVxWf22353RQZj0oh
 wLHgLTOq8N1YxM4zhk3B7rNBpH9Rsd0TWyAf1Nst+Hy3i6RnF4cSNH1ykZw1JdAHAl0b
 Isoz6ReVhYCOqojTgkjgUnEMTV9xhbiUl+NRC94AZZHxwLhorZDj/zpl17c7SJLzgMRw
 WOXOKRpXywwSygYEx82PwuG1dYCif6aOEDymHFS92Z6ksFhT8kanhRa5etewSKzpZ5HW
 Xb3+nWy3e2IkzPBKcUXdQKQpIiod8mtfYEk0T0Ec9MFCOKusIlDYVBcZP44zq/cW5x09
 xuBg==
X-Gm-Message-State: AOJu0Yz6oc09aJJRgjJd9/YWezdq8EEAnG93pu8uanl4XAox7WfkYJvY
 D2HxEYha+drUhvt2/Tk55v4293AcI3PGeJgZG3J7y1gXH1jlQQytGVOglb3q1S/IgpXbxtfPkQv
 n
X-Google-Smtp-Source: AGHT+IGsc0Mb/7V59X9MD7qhFzneh7TwBJ/I6WigwIbG/PWn+26klH6eBjSdC/ZkkhLBaY1br6ovRA==
X-Received: by 2002:a05:622a:4b15:b0:45b:506a:b41a with SMTP id
 d75a77b69052e-45b506ab60fmr8716461cf.26.1727123775912; 
 Mon, 23 Sep 2024 13:36:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b5253b05fsm105771cf.10.2024.09.23.13.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 13:36:15 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:36:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 00/19] labgrid: Provide an integration with Labgrid
Message-ID: <20240923203612.GT4252@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jG/G/ndf380+YbwS"
Content-Disposition: inline
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
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


--jG/G/ndf380+YbwS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 08:01:35AM +0200, Simon Glass wrote:

> Labgrid provides access to a hardware lab in an automated way. It is
> possible to boot U-Boot on boards in the lab without physically touching
> them. It relies on relays, USB UARTs and SD muxes, among other things.
>=20
> By way of background, about 4 years ago I wrong a thing called Labman[1]
> which allowed my lab of about 30 devices to be operated remotely, using
> tbot for the console and build integration. While it worked OK and I
> used it for many bisects, I didn't take it any further.
>=20
> It turns out that there was already an existing program, called Labgrid,
> which I did not know about at time (thank you Tom for telling me). It is
> more rounded than Labman and has a number of advantages:
>=20
> - does not need udev rules, mostly
> - has several existing users who rely on it
> - supports multiple machines exporting their devices
>=20
> It lacks a 'lab check' feature and a few other things, but these can be
> remedied.
>=20
> On and off over the past several weeks I have been experimenting with
> Labgrid. I have managed to create an initial U-Boot integration (this
> series) by adding various features to Labgrid[2] and the U-Boot test
> hooks.
>=20
> I hope that this might inspire others to set up boards and run tests
> automatically, rather than relying on infrequent, manual test. Perhaps
> it may even be possible to have a number of labs available.
>=20
> Included in the integration are a number of simple scripts which make it
> easy to connect to boards and run tests:
>=20
> ub-int <target>
>     Build and boot on a target, starting an interactive session
>=20
> ub-cli <target>
>     Build and boot on a target, ensure U-Boot starts and provide an inter=
active
>     session from there
>=20
> ub-smoke <target>
>     Smoke test U-Boot to check that it boots to a prompt on a target
>=20
> ub-bisect <target>
>     Bisect a git tree to locate a failure on a particular target
>=20
> ub-pyt <target> <testspec>
>     Run U-Boot pytests on a target
>=20
> Some of these help to provide the same tbot[4] workflow which I have
> relied on for several years, albeit much simpler versions.
>=20
> The goal here is to create some sort of script which can collect
> patches from the mailing list, apply them and test them on a selection
> of boards. I suspect that script already exists, so please let me know
> what you suggest.

I still really wish you would split the labgrid parts of this series out
=66rom the pytest fixes and improvement parts. Things are largely fine
outside of the labgrid part for example, which I'll probably just take
after confirming it doesn't break using labgrid other ways.

--=20
Tom

--jG/G/ndf380+YbwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbx0TwACgkQFHw5/5Y0
tyztoAwAjvj3aJUqsJFwvRuX6baEBNnrgsJ1jqSTl9iXP3aArM7+Cs1ybSlBtJaH
LXv088KGEnLMvE2sJCE43Qj+7jzXpHgBhRGlQgaFivZoutvO9VpApDUSzem9zvM7
1P7br0VRkCdVkbTi+3rD4gikl2EUFIJYfdSWXfRh4wz7mXY/ykXNJp/vQRWnDobg
K0QXrWFiFnUYUlocY+aLbA7Qm/tuu8T7m04yjzI0c1b1JWcmukOBjVfCEkx6fhbu
8H56CI4k1MqoBvh4ZCfG05blA6OJ/DN+YGsVDx7K7r/lOlPkxuv3pSRioXpZIggF
GUvRvB+DH2hrOCFE10Ju4pZAnZi3FiRh4j/3f2ssFnPnMcNzfPWSs905JtoQYY54
3qyZPzrv72L1KK1KhFd3FCDbk1Y+3UivtnBIKNI7u9rqCKfFkkatuenRcSvYcaa8
J/k8TN3LChpIu3a9fNpb03hklEHpUdR9PnvZPq0pDwiaNXgwPXGp0aDh8oCA5P8m
JzOtH73V
=7kcm
-----END PGP SIGNATURE-----

--jG/G/ndf380+YbwS--
