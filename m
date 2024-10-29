Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B361D7494E
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56933891CC;
	Wed, 30 Oct 2024 00:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pst6Vlo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B32891B8; Wed, 30 Oct 2024 00:53:03 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCF8891A3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cc250bbc9eso44077616d6.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730245981; x=1730850781; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XJhTh++08oFBrqTf5hO7tOEC5KkjgWH3JJO6HMupKC8=;
 b=pst6Vlo9dSsnXObyTMBva1G5bWP8sVgYNkEU92rom/pDd09I0Er0kW0IOnEk/xWAjH
 irejG8ks5i6hFgM4eeYXq/FaXKQqXmqjFKT9l1QQ2x+9yEXsUy3KiojDf17St3PaWBYd
 2i0BpMEwzo9Yi3pRoniu7Z4F7JYs8nzOOL3IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730245981; x=1730850781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJhTh++08oFBrqTf5hO7tOEC5KkjgWH3JJO6HMupKC8=;
 b=s7O6KoJ2frU2XS7leaEfOZJ6jfsE78KUFEqlREV+VpQtuas6GoBtEGMcCYed2aN8NP
 t9Ds6EyV7Mg8oQwKpDR98YX5GZ3uOzO54O9mTxrRnlEErVulnR2I9/ICjmlcSyVrE7A6
 o1tbe8ZC8OCZcDPQiIwn58e/AJ5qC8/CZj+pW03uYzRiRJBSzgNvArIdG0jMyTo1Mg/C
 +e37daB3/mqv7aM+LMgPlHCOFyoDHiSyFkSYSIokCd17Ld99jfybL/JBTskWzgOdPZrP
 a1MkZ/gQCKWrfqPcRZvsyYxLedbhphNc5uZ+agWh/JQltSKrPTqPHZN78a4jvjc4b3eB
 qAvQ==
X-Gm-Message-State: AOJu0YwKBK+rTEQ91QkeiqQIM9jLSFTWfLsQTxxymJpLb3Cu6ltv+hRL
 EvENU39Uy9qaE8mEIMLJksVVSP4IyiO0R6PuJL8ji6JXL3wG5FLagKTyv/Gax9k=
X-Google-Smtp-Source: AGHT+IGFyxot/fdGo+OAQoQyxhzKIZ91Kb+3fgfGh2ERMliR+viD21WXvz1ZCURDrTR5TZNEbrTh1w==
X-Received: by 2002:a05:6214:3910:b0:6ce:4f8d:356c with SMTP id
 6a1803df08f44-6d18583f48amr188481026d6.33.1730245980767; 
 Tue, 29 Oct 2024 16:53:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a09572sm46873226d6.77.2024.10.29.16.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:53:00 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:52:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 01/11] test: Allow signaling that U-Boot is ready
Message-ID: <20241029235257.GB2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M40gOW7gtiMgsjlC"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-2-sjg@chromium.org>
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


--M40gOW7gtiMgsjlC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:35PM -0600, Simon Glass wrote:

> When Labgrid is used, it can get U-Boot ready for running tests. It
> prints a message when it has done so.
>=20
> Add logic to detect this message and accept it.
>=20
> Note that this does not change pytest, which still (also) looks for the
> U-Boot banner. This change merely makes it possible for pytest to
> believe Labgrid when it says that the board is ready for use.
>=20
> In several cases, the board starts up and Labgrid receives some initial
> output, then pytest starts and misses some of that output, because it
> came in while Labgrid had the console open. Then pytest fails because
> it doesn't see the expected banners.
>=20
> With this change, Labgrid handles getting U-Boot to a prompt, in a
> fully reliable manner. Then pytest starts up and can simply start
> running its tests.
>=20
> But, again, this does not prevent pytest from handling a banner if one
> is provided (e.g. if not using the Labgrid integration).
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I _may_ see this myself sometimes, but I'm not sure. But I'm not sure
where the bug would be between us and labgrid. Looking at
test/py/u_boot_console_exec_attach.py we grab the console and then reset
the target. If the spawn hasn't completed, especially before the power
cycle has completed (which in labgrid defaults to 2 seconds) we perhaps
need our own delay. But as I'll point out further on, NOT counting the
banners means we aren't able to verify other functionality. Even if they
are tests that I think you don't like because they verify the
functionality of resetting the device.

--=20
Tom

--M40gOW7gtiMgsjlC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdVkACgkQFHw5/5Y0
tyyLwgv+J+q0Spszl0Cnxhd1/CDhpOmy+Bl+wS+7FpVMNAARE8z4gDF9yj5sPyVX
1d9qWBMUDi2Z8lzc5A1XrSE8jAPX6AY5TLa7o0TswV4awaGcvTvtA+CDR/mK949M
AlyNQhsLYwfAN3pyWJ44yE5fICVtRVxVVvwt+Q6rZlWq7LRUSfLIN06tYqCuIjMU
tyqXgEBDVq7vXXqw4gIenzjx42lDfJUhR60WN+75k3GgaLoBNVDGHj2Q9UBSuYfV
40SjhUDZPw81Z7u/urVzu3Zr5/f6g+AbgI8Fo7aGtUQXf4F7de8rECiDjoPUmljL
9Mb8eBULA+qwzA5UX+mbo/BeV5bAt9AlIIsg5GJ5j7X0Cn13SdHt/ExYbpazAN/i
Jh2UQ9gYVTGdQwmix89/yClSFffpUiQAGeCaSXm4yOtAKArmMz3JkLIsHsoewvM5
WmiRT/Y5am8s96MQCKz2mUfpjtw10an0IAizMBreXkxjDQWx/WDryp4NkYXckTzX
9XdLbK28
=WlcE
-----END PGP SIGNATURE-----

--M40gOW7gtiMgsjlC--
