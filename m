Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F35D6E2CA
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A64180325;
	Thu, 18 Dec 2025 20:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bL4kmWp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB5F80050; Thu, 18 Dec 2025 20:01:12 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E8180325
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c75178c05fso323792a34.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766084463; x=1766689263; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4BZOEx/h11O07qTT0vuZRWjWXi5ReF4lxZYGOXJ5DOg=;
 b=bL4kmWp4Ov3KC0ywNhVz1MBz0Qv+tjflqHO6HDFd93xlNAW2TUELofZUy0boLXfWyO
 SRaOJWT2u23Kq9A99SJHZ8QwT2lFqYR2vP6b9+ZuGZjqDZYybFfLNnZfusSmKKw04wHI
 SUrjjkeyokAUEFiLMtbBzS6U7Vuk/4I6V55Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084463; x=1766689263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BZOEx/h11O07qTT0vuZRWjWXi5ReF4lxZYGOXJ5DOg=;
 b=Cz1HfoWPqZiPcO3A2wlDcvEix6Jcdzod/tLRhVdb3ZWVwcevEdn/obZIevnyvfNGxq
 zX0AbxbRPvWdCAMoVGtobFtBdMuzitUE/4xGHnAi74TdOOFNw3SQysPbJXnh4NlZaebI
 GWdB9pHQt0+0EKmNQhK67B4WN8SzyLH8mfZrRcXqAE8kfm9lhgwbLI8M/hrs9QoMM5Za
 N9S7DwJD5LegLQTjrE+8AqQckUhgYKF+BQLX5uVGr+6Z0aozp6ChmryQuiuzCcee/iOW
 9crVm1ulxwGvcz6IM2GrV5beiOf4lMxL3U2X/enUw3OGYQnlnTwfBlLcBvx41ulEuscR
 AwwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOQOiuK89QVxcKa1lMni1OYdSLWAa3lOoI/fJ+h3hZqi7ycHLDs/pbDAJLGfwBjaEwCIOFUwo=@lists.denx.de
X-Gm-Message-State: AOJu0YylefwX746ezRIUQwmIAD3FriR+/sAXqu1XsxjPNM97UtWebS1J
 WI4f6QnLyM/lk1ptwwr/9Ro3okCbdFWioCSrTJvXWaDGXepCmbp09AsKJikZnTCz5GePcedRnWg
 qW20gTwI=
X-Gm-Gg: AY/fxX4KyWt06RaHF4fXRpN3cDGQBFw2LP+6s8JMKlcVg1GiTzo3V/lay95DxkkF+VP
 JlIouSkFm/Wqz9d7soS/Z1I9/tRjBngLsWuWv3Uxb3h+OsdP5lvwul/IikAQrZn2bovbH8f9KyX
 kqgZdzeecwiLog7rbDdxneR0ON6pjjYRmsCqUVDzmYe9DxQIlF8rSwq1wV02iZ4M30M1RH5Yaoi
 DlGTICuEBIG3MkwW5xTMCc9UWB5MgFaAeWMehqMK70D0JgK+zYokVIBttXfM2EittjBV+qxoka/
 c8ZWIjjo5J+LW7liPQMsg2EDrWRn2Cr0L3abHoUS+mN4gfGqXE22fq1NI6fOxLk+ok0E5FV3PCH
 854mQIPmMmUcGFcXewoa49ZcrLl5rovQALKlCeyVNtHr7rtzE5WjTx9wnkxwl8qQtfKthTpyIjf
 3opIo2EhHGYT74Eyswj6DW8JbqjKP8/OyGMGEjlL83WvHuwghTqPHX4xStV7Cc
X-Google-Smtp-Source: AGHT+IHwAKxWCU1Nu3Bsy6jlSJbPhvEO8vXR1DirzcnF1Qm9nqXIwZAdg8pFmhFi2/XZBjmkDhFJnQ==
X-Received: by 2002:a05:6830:4123:b0:7b8:f2a2:46b8 with SMTP id
 46e09a7af769-7cc66a6efa8mr190376a34.17.1766084462128; 
 Thu, 18 Dec 2025 11:01:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bdabsm168019a34.10.2025.12.18.11.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:01:01 -0800 (PST)
Date: Thu, 18 Dec 2025 13:00:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] m68k: Add support for QEMU virt machine
Message-ID: <20251218190059.GM303283@bill-the-cat>
References: <20251218185252.957388-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vR6PlpbHHAAZjSiM"
Content-Disposition: inline
In-Reply-To: <20251218185252.957388-1-visitorckw@gmail.com>
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


--vR6PlpbHHAAZjSiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 06:52:49PM +0000, Kuan-Wei Chiu wrote:
> Add support for the QEMU 'virt' machine on the m68k architecture. The
> QEMU virt machine models a generic system based on the Motorola 68040
> CPU and utilizes Goldfish virtual peripherals.
>=20
> Currently, U-Boot's m68k architecture support focuses on ColdFire
> variants. Expand this to include the classic M680x0 architecture,
> implementing the necessary exception vectors, startup code, and a
> bootinfo parser compatible with the QEMU interface. A driver for the
> Goldfish TTY is also added to enable serial console output.
>=20
> The implementation has been verified on QEMU targeting the M68040 CPU,
> confirming successful hardware initialization and boot to the U-Boot
> command shell.
>=20
> Kuan-Wei Chiu (3):
>   serial: Add Goldfish TTY driver
>   m68k: Add support for M68040 CPU
>   board: Add QEMU m68k virt board support

Well this is neat. The next step for v2 is to update both .gitlab-ci.yml
and .azure-pipeslines.yml to run this target in the QEMU sections by
where we already test another m68k platform via QEMU.

--=20
Tom

--vR6PlpbHHAAZjSiM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaURPawAKCRAr4qD1Cr/k
CsgNAP9slPj8AvEvqn5F/utMjvI9xN7ktGKJXDETscSnL1ZHMwEA+98hSMx6NHE4
HPDxoLj20BaqDyCjQ/prC8cwpz00CQE=
=5HcB
-----END PGP SIGNATURE-----

--vR6PlpbHHAAZjSiM--
