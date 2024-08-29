Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C558DC83F26
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55636888DD;
	Thu, 29 Aug 2024 16:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ywt7FOsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BAE788B94; Thu, 29 Aug 2024 16:13:47 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0334687F19
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-44ff7bdb5a6so3723291cf.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724940824; x=1725545624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=faV0GDawvd4CnsjpQJjosUJ3T6/tynOUH0e7Ed1TXjQ=;
 b=Ywt7FOsuP/HN8niRzqvUfrP7vbKjlDaflLOONaIIrB+m6aVae6Qna+CT4M32+HJVDj
 1gmE5cvBhJY5NlS8fbw1oLkUeurCTCxgfQ2EYOyftYpRHRoqCb6nFgUazZ3JziQWJoJA
 /6dGwWnrwFSa0sPqJ7PbLUMhYUr9TP8zkpv+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940824; x=1725545624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faV0GDawvd4CnsjpQJjosUJ3T6/tynOUH0e7Ed1TXjQ=;
 b=S+t1ZoFQz4jwy9akzTEotng9x3F5u9um5xWJ9HcTNl3lZ3qBhZ8U9rmTTNOFo7vjFd
 mGOZXWgsoJuTG9KjjYA4GR9+ILkyzY+uwHZwYguuYt+1MudVkr+8dt3QToj1olipaVRH
 07T2Uw8JSyreniBohEHcBUwure1FUsLlo0Vnm8x6YbYA1unDDFrxFbDyII8mADyx4PqQ
 XVrlasFA8y7hQ4LTNU1Mm8QuBg59UPye9X9z4lqZ6PJW7b4DO061hFJSFf4a9XRx2+GS
 30ihx/WiwXm/z2Blg71fxApG/2HVWFepFbccuLhrAjDzbu1H6wEhtBIQNP3mhxWhNu/W
 Akkg==
X-Gm-Message-State: AOJu0YyZqhtfK4lOFr4RSPukJt3cZgvxyQRhzfGgVTCL3AwcDT23JS4s
 3QhrTd5da1Kmei4EOpfBh+laCxNvhFnmMyRxuZcn128vwMZ9fphP8M7V0utuJzY=
X-Google-Smtp-Source: AGHT+IFwJz2WgQzWQ4/ZWYDc07NPO9vZdS6+F9/8ic/QOFMc6oBfwqXVlfnbuL3xgrAHCgY8fo6DRQ==
X-Received: by 2002:a05:622a:4812:b0:44f:f1ba:d9fd with SMTP id
 d75a77b69052e-4567f7212dfmr32958161cf.64.1724940823569; 
 Thu, 29 Aug 2024 07:13:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682ce07aasm5090901cf.50.2024.08.29.07.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:13:42 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:13:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 00/20] labgrid: Provide an integration with Labgrid
Message-ID: <20240829140921.GX2479150@bill-the-cat>
References: <20240828220846.1205813-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I5B6iuvrMd6u8wzd"
Content-Disposition: inline
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
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


--I5B6iuvrMd6u8wzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 04:08:26PM -0600, Simon Glass wrote:

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
>=20
> I hope you find this interesting and take a look!
>=20
> [1] https://github.com/sjg20/u-boot/tree/lab6a
> [2] https://github.com/labgrid-project/labgrid/pull/1411
> [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> [4] https://tbot.tools/index.html

Part of my concern here is still that this series contains:

- Generic test improvements and fixes:

>   test: Use a constant for the test timeout
>   test: Pass stderr to stdout
>   test: Avoid failing skipped tests
>   test: Move the receive code into a function
>   test: Separate out the exception handling
>   test: Detect dead connections
>   test: Tidy up remaining exceptions
>   test: Improve handling of sending commands
>   test: Fix mulptiplex_log typo
>   test: Avoid double echo when starting up

- Labgrid specific listed as generic changes:

>   test: Release board after tests complete
>   test: Try to shut down the lab console gracefully

- Your labgrid+builman implementation specific changes:

>   test: Allow signaling that U-Boot is ready
>   test: Allow connecting to a running board
>   test: Create a common function to get the config
>   test: Introduce the concept of a role
>   test: Introduce lab mode
>   test: Add a section for closing the connection
>   test: Support testing with two board-builds

Which makes this harder to review and clearly merge. For example, we
already have hooks for power on / power off, and we should just call
them as wow that would make everyones lab easier (I used to have a
pre-script to turn on everything).

--=20
Tom

--I5B6iuvrMd6u8wzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQghMACgkQFHw5/5Y0
tywzRgwAuhAdDeAPJTIY5zgldkbkkYd3kATG7oNPd6esVHXQN6XQ4M8xQTmj+ltC
cY+ds2qM8/zOwNgn6cSp1SWezgYgWkIU6PNsI6owK25AdvWyROAcJddkMPizuRmx
jvRgSKOfHxuZ6u3z3B95KwMzzb7HYs3QHfrVhp2na+3t+aHQ/VOcdspcmkkAiPOr
MmKGUaN+xCjwuM4pEKYUzivvRhcf+5Fc1sjGTGGci+cZ/h/5luq5vr2LQsp5oeg3
L1w/Lirhbj/jk6f5ObIp7jwd2jNz/w0RAuZ02GV5Gd+Yv7kugTgsN4mDe1SU+b9U
pd55LTAUasBSSbBcz6V4IPW7qBWvz5gGgVXZGg1w89V3nL5zPKtVINmNvcnyM78u
5VEbVwyfbo5/UdSO43+1r5BFPZvmri74oOTaJn3K/1XiwaEMOjY9AmR02MmJ1JS6
Q008sehjhrcL2RqiT+8wcUEoDI1wo8THiKfm97mAiSontEg3fuA1H2fg3x7JTphS
9UuzJQRT
=z2TL
-----END PGP SIGNATURE-----

--I5B6iuvrMd6u8wzd--
