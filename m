Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F72AC54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0467687FC1;
	Thu, 14 Mar 2024 01:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dTgEOvky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F1E787FC0; Thu, 14 Mar 2024 01:40:42 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB0087FC9
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-690d75c73f4so2981706d6.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376836; x=1710981636; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U3LlrVT6BYyN0JNd1FmAaTTU2lsvA53YOO/yK+dUi4w=;
 b=dTgEOvkyYQKIF4WBpAXkjMMBDSgMD6cxLT+aAEnqNak7tS4Oui6Aa4+FYLxEVukBFr
 TRiWUgeHIp2nHlK910M3quOwhsiEZhUtoR6Mv1Vmhj6X0JXQRWoIRIW4eQKYbIkSqoHQ
 2rUYkrQF+wB6Ce60qayLWekaml9pGkwHU1L1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376836; x=1710981636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3LlrVT6BYyN0JNd1FmAaTTU2lsvA53YOO/yK+dUi4w=;
 b=NSecfx4Nk6PDdCDoj+vNQI9ZBV3okwZnUlz3AEx/uFTQ8UefH6iYcfhNThIe9o+91d
 z0B7eqMOdIpeFlllDitDoFubQmhfG6zY91bVqvxNbDlGtgu6xzTLD7eJL9ghJRKelrr+
 UOlxpRv+rjPP6ECj8yNtxjCWsSPjGaFvTQJDpbdQkhkQyB+pkP1PLlzxNj+YwS3T7ke6
 6A1py6og+LnTMWR4sUvdyUJuJJZRzPFZ4CZ12e/a+93ruUig6g+2LDjLlZWugqrYtnWe
 thoDCYNjqcpHgM3VMBmsBG2lA2+t872LpTN846PG5PMT+AFaSThU59BaIo1ZjsyBQ1Hl
 NlJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG4TGYyUI6y1ZmLzoB9WNMHMz0FYs5wqSHbZMXjCVYDmkVUNVbvBJkCp0vHgekVv1pHe4WEUvODQg72grUdQvYtYqGYw==
X-Gm-Message-State: AOJu0YyKSEN+S1QOc73Zd0VmlgtyBwNk7dUZbaB5td1o2BfTe72OFriU
 q7Rj/CLO75ZHuXCFT7T7ggORo8LEDm3ZFHvdDi1Egk11SEvvMDTa6xdfQwV26qc=
X-Google-Smtp-Source: AGHT+IFTXYbkLPDFrKx9KJRqKEU1CVinL8WYI8wxiZE7mjpT+07EmmRbSXSIXhogFRgbvDrsbpcTVA==
X-Received: by 2002:a0c:e28e:0:b0:691:49d5:d8f7 with SMTP id
 r14-20020a0ce28e000000b0069149d5d8f7mr213612qvl.21.1710376835797; 
 Wed, 13 Mar 2024 17:40:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 m11-20020a0562141bcb00b006907904691dsm231653qvc.17.2024.03.13.17.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:40:35 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:40:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] test: dm: add button_cmd test
Message-ID: <20240314004033.GQ3442575@bill-the-cat>
References: <20240305145111.1391645-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3UBL/57NCt64UqRD"
Content-Disposition: inline
In-Reply-To: <20240305145111.1391645-1-caleb.connolly@linaro.org>
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


--3UBL/57NCt64UqRD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 02:51:03PM +0000, Caleb Connolly wrote:

> Add a test for the button_cmd feature. This validates that commands can
> be mapped to two buttons, that the correct command runs based on which
> button is pressed, that only 1 command is run, and that no command runs
> if button_cmd_0_name is wrong or unset.
>=20
> Additionally, fix a potential uninitialised variable use caught by these
> tests, the btn variable in get_button_cmd() is assumed to be null if
> button_get_by_label() fails, but it's actually used uninitialised in
> that case.
>=20
> CONFIG_BUTTON is now enabled automatically and was removed when running
> save_defconfig.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Fixes: e761035b6423 ("boot: add support for button commands")

This still leads to CI failures:
https://source.denx.de/u-boot/u-boot/-/jobs/798332

--=20
Tom

--3UBL/57NCt64UqRD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR4EACgkQFHw5/5Y0
tywI8gv+JBaL1/pCsxCxfFnDh+i9ljMKZRA7IhbSA4s1O2wHEwBYMaDNEzBbm2/0
r2bSXp89A1zQYWsc54J5bFlf/NmMa+7ATSS6vlbjraT99pozCSw/aLoqgYECgbpJ
NewAX9Vpm+OzmQszZ0i2vGDYaBD3DisdkS4/htXwVyodrggJ5g/tK0PtgI253H2v
y9ZmSkeh9G6wpfbFDUt0f3e1UhSWjqz8X0Ih17EbFmh+8USuTWuTxeGIT0JKiD8t
gSiDEJI13QBwu3UiTBVacEgVV+BYAQOnreckRtHK2qqqEqXve4RjuI+OtPVdtdL/
JKUxsvG+bFlxm/Xujq8BvqqK4DckoJwHYLbWiRbKQda8VIO8u4GNIgSiJVV+Ahjf
fEicDLO4A9K49mBxooFwCl8NPNQgB1q/B85NFXbss0fGoWbj9g/CYoL8b05CALw0
t4eF6a3ckWmQf39dpMprm8MhlnPQHQ9ulVZvY4Z9BzUhTLwO438ojT8noz3g0Sz4
emE3al4N
=tmq3
-----END PGP SIGNATURE-----

--3UBL/57NCt64UqRD--
