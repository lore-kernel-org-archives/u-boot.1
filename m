Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C56DD7494D
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A667891A3;
	Wed, 30 Oct 2024 00:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wy4XJAMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9ED9891D6; Wed, 30 Oct 2024 00:53:30 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4128891D2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46101120e70so37968231cf.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730246007; x=1730850807; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m3HKy0bX4jjq037SqfzG6VI6XCrGp4YJ6WMv1BclNnk=;
 b=Wy4XJAMVjF0OS90CDaxw9sp9ycAnc1/vI0n1vQ8RGYBUVh/6JNTI+kdP5qxh91TnJk
 gqY4/0YD4Wb3y6eZPaqQt8tow2ZSsD1p63bE4hC7i9GPTAyZOVht8X5fBPUZY7rQ4BjQ
 fcoLH006OE+g8xpuMfjaHlXCismGJaQSMmmQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730246007; x=1730850807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3HKy0bX4jjq037SqfzG6VI6XCrGp4YJ6WMv1BclNnk=;
 b=olosZDUaNfQSjmHYdDlJWBComLjhnaZs8yIW73WLn9dQyDUeyZyTrUGOYxIC/Ori+7
 vmkyLHrPPloU2/6sdpFhyYOcWRcmbXNDLrIkJjmMcoB7iEqMOVJxQzvzsb/+oIX2upeB
 zAk4s5iXEmAuiilV+/SGbBLrSYce0nnhH99SXLdl9N6wuVuOnFQCvu44CWFw0lr7vUwE
 iHMWdIkJFUqU7cCCn/y3deEybXn7xDfDxyUx1/Ax13O4TGnsShpcvqz3II0fBcHrvfAy
 TPvC5/btbQGXD6K1mF5CjDlBLCm4XV+wsfHSEd9/6RWBiAHBMFRbhqJnETzTW3imI/uz
 Xs6A==
X-Gm-Message-State: AOJu0YyyDlioMIfKd0QgG8Jr0AkWTm1ZlGg3u4RjPopJaeDcIiccFDWW
 k42UvNuMPPXEiAzothpgKDYCvpcmrWnM0QeqgO0zQSc9fJ6UpH3+dN+YC6moL2U=
X-Google-Smtp-Source: AGHT+IHiGvMy7qIoR6SQ8hWz9S94pIWaWFWLlzxJSvJVStF8qqhe3ntjrrOIco9V7fks1M2Yrq0iGA==
X-Received: by 2002:a05:622a:1304:b0:461:ff:2120 with SMTP id
 d75a77b69052e-461716cf846mr23107471cf.13.1730246007485; 
 Tue, 29 Oct 2024 16:53:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613211a8b6sm49065371cf.16.2024.10.29.16.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:53:26 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:53:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 06/11] test: Improve handling of sending commands
Message-ID: <20241029235324.GG2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1s4ahWi3f7FyUaOV"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-7-sjg@chromium.org>
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


--1s4ahWi3f7FyUaOV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:40PM -0600, Simon Glass wrote:

> We expect commands to be echoed and this should happen quite quickly,
> since U-Boot is sitting at the prompt waiting for a command.
>=20
> Reduce the timeout for this situation. Try to produce a more useful
> error message when something goes wrong. Also handle the case where the
> connection has gone away since the last command was issued.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  test/py/u_boot_console_base.py | 35 ++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

This looks good and I wish you had refactored the series to include this
(as well as patch #7) in the generic test/py improvements series.

--=20
Tom

--1s4ahWi3f7FyUaOV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdXQACgkQFHw5/5Y0
tyzfKAv8DNoCIqD/qg0oAuKDSUMmtL/EBlv4PT+vsOQeHaaIs9X9T3Xhs38mFnqe
G2Fs1gB0qcAYwwtVFqXNdLqy8YpWvS1ldTMaymDIw2ly6+RRnYnbrsW25ujyLFiq
ZZZ9c+0lg/eQTu+dDB/lmEg3NWD9Mqe5YZWMHQg3LchVZc3u072CMW+PSDIERcH4
kBaFly0uvqgPVpvnk77giTfaCUMlvbULk6In6jDmJyZmT6HaaBgKw4otoEOF953B
c+gwu+ZnjODiliZFtrHy390K0g4KjPolp7rGu7nLs9AUk0XdOnCpHxY4LEM0oXvw
NK4enCX32zsyEmAPx+u71+imR+9M5/Xh1xVS8YqVNS8I6KE/y+ImG5opMRw/yXAn
z9xmzHwXjtdq9LKLiszDexY2UJBaQK+nZuAlgDNmNh5INO/zf/BAbKN9D2h5RVGG
BUJndMXk5QhApOXMgF7efAg9siPWNLLeqvwHJ50psZZ7nJFoS6VdOIqHF2jFpcI4
1UW1iWaZ
=i7VW
-----END PGP SIGNATURE-----

--1s4ahWi3f7FyUaOV--
