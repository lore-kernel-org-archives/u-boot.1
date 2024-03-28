Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC40DC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2233A8813C;
	Thu, 28 Mar 2024 13:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EksJ6dSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E07C8813C; Thu, 28 Mar 2024 13:18:38 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E1A8808D
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-781753f52afso45877485a.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711628315; x=1712233115; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GE00+6cx0WC5b8dl49XnHx8ANHbQOTmo0niuJkNscbw=;
 b=EksJ6dScqRAH2k0PyBYHwG0tP2GYa5km3CnAieEhiYGD25uXOMmXz+Ysnri/9xnBeh
 a3oZlO3Z+n6hh2hA1Bz94L5HT5bBZvCYyTeab44B4Wu4InVUvMyQBknXHHLyy3E054kd
 3uRP0vrCMJv7k0AEVwOn+UiFvEv3VK/djTo2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711628315; x=1712233115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GE00+6cx0WC5b8dl49XnHx8ANHbQOTmo0niuJkNscbw=;
 b=HGyxDbuW1U+EOIkpQxfFPGlyBGEyhUG2WEMk/bi0ecKQQXhDwhvtalGvy/A69/XTdH
 aKEmrpWYpacOTt85yWpioAgAUAVtjcvXpusbtiGRoNqIg5aSdxV6RvgmXJdlQoRK69kx
 nKHedRHDYzRYh4jrpWhaGzRGnafn7GKKsEbagy3pRNmMCZq3PLJADn70kpbyWsTg2vIg
 kbUQ01dfC+VB636hBZhU7kntK4/etOGScTYZr4JzAIIzkpD2HVfjgQ48MshAj1dhqEQY
 XTtHQNzBtWPptKWxWHmHPL8hsst+76gCYfzUMHOJm8F/7G77nIO0SUgdwWsYdN3AywZB
 gFhg==
X-Gm-Message-State: AOJu0YwhXCKkbs+rin1KZ/urhTbjbo8Y+ssSAwKJuTWgUweTW/SPNZje
 oPxBfu5nk7Mp9/eONjxsr5xhxhfBtO7aXYlDJ1vWm/4cMlQADza+TBP1I100sH4=
X-Google-Smtp-Source: AGHT+IFMda8xk7psuaxREhlnCtPpJV/E0RMozkpBPbTGJJKjV0hVb6a/vLTa8IB+osX55HmzhTUSbA==
X-Received: by 2002:a05:620a:215d:b0:78b:beec:dcea with SMTP id
 m29-20020a05620a215d00b0078bbeecdceamr987929qkm.12.1711628315051; 
 Thu, 28 Mar 2024 05:18:35 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 wl25-20020a05620a57d900b00787930320b6sm478458qkn.70.2024.03.28.05.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 05:18:34 -0700 (PDT)
Date: Thu, 28 Mar 2024 08:18:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: Thoughts about U-boot binary size increase
Message-ID: <20240328121832.GL3442575@bill-the-cat>
References: <20240328102049.10108d5b@wsk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dOrArqPVp+ZPd8Kc"
Content-Disposition: inline
In-Reply-To: <20240328102049.10108d5b@wsk>
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


--dOrArqPVp+ZPd8Kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:20:49AM +0100, Lukasz Majewski wrote:
> Dear Community,
>=20
> I'd like to share with you some thoughts about growth of u-boot's
> binary size for SPL and u-boot proper.
>=20
> Board: XEA
> SoC  : imx287 (still in active production)
> Problem: SPL size constrained to ~55 KiB (This cannot be exceeded).=20
> 	 Board design constraints u-boot proper size to less than ~448
> 	 KiB
>=20
>=20
> When XEA was added (2019.07):
> 	- u-boot.sb (SPL): 37 KiB
> 	- u-boot.img 	 : 401 KiB
>=20
> Now (2024.04):
> 	- u-boot.sb (SPL): 40 KiB
> 	- u-boot.img 	 : 427 KiB
>=20
> (With a _lot_ of effort put to reduce the size)
>=20
> Hence, the question - would it be possible to take more concern about
> the binary size growth?
>=20
> Maybe CI could catch patches, which enable by default some features and
> the size is unintentionally increased?
>=20
> I'm open for any feedback and thoughts on "stopping" the binary size
> increase.

I think that's pretty amazingly small growth for nearly 5 years of bug
fixes and feature enhancements that it's likely minor to make granular.
If LTO is not enabled on this platform you should be able to use
buildman to give you a "bloat" list from v2019.07 to v2024.04 and see if
anything sticks out as being something that can be addressed. But that
little growth seems pretty good to me at first glance.

--=20
Tom

--dOrArqPVp+ZPd8Kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFYBEACgkQFHw5/5Y0
tyw8kQv+KIdb6anSuZ/JWY/ep0TQJ/pkywNh+INc8GSfxeCRJbSTMGNn3DiVemmk
dAh9QHoRhR1BWPAxJvd2p2gPVuqJR0M7FI8+xoVV0gGu/nHYWLmykqdMQS5b9c2U
pW2ENlCsw5c2b432IXjmilBveO2NJ2Q0yghkIFTY9Ju+yFCxBQ/28jn7sEPf916r
rGUNKd0RFJbpi91PqEvvNnEnmXiiOYggmAO7QHznz2jM2WkgEfDEkx7t/zkazJAK
Ec4irWJA+iOwEJi03BqVL73iR0vrjp39y1yY7ZLqPZ1wWQsFQpC+LMtlD1Ohx4ks
6cDjlsrPZQ0RtYfAIW4FKB+CpQNMXRcKmUors/v61Ii66wjFcbkOKtjUjOPHB1Sh
OSe83KdVuakNMpIMv119QWpwwcLhr1TTUBE+wTRJSLFgkohx9KupbbzTmdNJl53g
Bx3Nx5Tks6LU/jmTxWyzKr/6Tc2iz3M5LrqGX5uCSGm/iMsnILk3g4s9XSeUY/Xj
BfecCYEZ
=OSl1
-----END PGP SIGNATURE-----

--dOrArqPVp+ZPd8Kc--
