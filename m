Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBA8EEB579
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 17:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580CE83C2B;
	Thu,  1 Jan 2026 18:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M41v36Jr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C0A83BB1; Thu,  1 Jan 2026 18:15:55 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1AE83C62
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 18:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c78d30649aso7877000a34.2
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767287752; x=1767892552; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T4hGiHc6RWbR42luT9OTFDBNEl1UkuF4Uk1GToStzcM=;
 b=M41v36JrmTEp5RxGJ9ncl2cBwRojYx2KTAZl8YNCuR2dTE7w1p2RS66u344BrrxqUE
 Rzku71I9BiezaeWchAqKHlOtS58j5EdOSewQkqdPzKULZG3xEPieJ1Pp9VGtgEDvfyJ2
 g/5VwrskfHVXSldQ2q+BLM32bFFfCglkAj9qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767287752; x=1767892552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4hGiHc6RWbR42luT9OTFDBNEl1UkuF4Uk1GToStzcM=;
 b=M1ij8R2RVelfRMp31AxZ2j+KbZY8/nngzC1LSwIfekBpvSjx76CnMJlg68JIWbhfXg
 XiGSUig87VpD1ZDU8EO5X5DTcPVe9HTYJNLsLI0AxiTK9b4pn8b6gnSrWp0vOImCXNAU
 Y9oBSZpEWeR+FFsEQt9ZByCeYYaWBCgettXS8etoOYuEK2PMx69ydrMgmJc/Fm34TeF8
 5H2dqPTGpGBb14ACArNuMU+k5GGOKC0c0knprU6vCcjKbKIb3Y2vYjZixoyTm0kIPOy2
 r4Thp6ASpo1x3IR4xIKmhYqwAX9u/wnictW53HmPQk579UvRLCkqDiJYn6OduOQLDMTl
 aPQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5A9r5LNZB/f0i6lltkaoq3RuYI60/dcssSZggdCR3eCOsWKQx3veT/iyIHRuh2UspdyNUO04=@lists.denx.de
X-Gm-Message-State: AOJu0YwEg0JfF9j9es3vG9ovEG5hHpE41MFX5bU/wOGvQITbGi9cG1TZ
 BvZ5DKI6mObTQwVnd6bMdQfQWP5TvufyTsCsQGry1LNMGWYdTbLdbmf3oMtsmuV+J44=
X-Gm-Gg: AY/fxX6B4lJQAMdaQW7RhiEPmf2pKJc9sIM5Ex1MCtxc3F+rGC6WVuJYtF2gh6s/xeD
 UK9DNpNN7jCN9SRf1RGWyDiPe49nJDapzr8rmK12L+W3RUKcfH4BNmbBZsBb/TPv6MXLCcqzd9Y
 /Mq86b2xFtXfzdtcJFzkCRUzZE+a/ikFWOyuWg9mztfDC8yDN+q/hMEwekwFMEwhPUB9Yl0ZQ7R
 qTafH8AQNUz8Oc0M6ykcwLXu4ioq3/AyDWBgA6ft5iB2rQbiBpL21sow03biAsm//ubwBQj1Ezq
 HytiXn2lRt3OJqOkzbSrtFqzlCfCpbtT+RUmL8hLCnEWCES1XCC40+kTaO65fwFP9R43YxRDC9J
 JxsI8/TbWi7y54J5xTwD48E3m6OSFG7CU6gnp7OPIm8u1mJol62LPgsjjMJ0E5xDMN9SLmlyjM+
 JQi5FZXy4yCAWrQ8p92ilJaI/Qz/WW6lEcR2BIkixR5RrKVaMBm6QPfHGfXnQ+tAuMzWGpAn73m
 eesebAJ99R78q+5gF11u2durrliYlYT+V/z4ZU=
X-Google-Smtp-Source: AGHT+IECzCrrzGTqdFnbij4s/cH8deu3zXBsTbrzyNA5G60FEdNu0+ZH8Mc7qCWZ0WuUnxGHEd9sVg==
X-Received: by 2002:a05:6830:25d4:b0:7c7:591a:7e91 with SMTP id
 46e09a7af769-7cc668a4bd5mr27861591a34.7.1767287751658; 
 Thu, 01 Jan 2026 09:15:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc66727e37sm27123814a34.1.2026.01.01.09.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 09:15:50 -0800 (PST)
Date: Thu, 1 Jan 2026 11:15:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support
Message-ID: <20260101171548.GF710860@bill-the-cat>
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
 <20251231191054.247270-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5T9r7msn38jdLty5"
Content-Disposition: inline
In-Reply-To: <20251231191054.247270-2-heinrich.schuchardt@canonical.com>
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


--5T9r7msn38jdLty5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 08:10:51PM +0100, Heinrich Schuchardt wrote:

> Since commit 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> CONFIG_CC_OPTIMIZE_FOR_DEBUG has no effect on the non-host code.
>=20
> This patch reestablishes the prior logic to add
>=20
>     -Og -Wno-maybe-uninitialized
>=20
> to KBUILD_CFLAGS.
>=20
> Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5T9r7msn38jdLty5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVarxAAKCRAr4qD1Cr/k
CmrzAQD7fZy9rmbB36r2Hw1EjNluCns1IQXeSuupsiR6InwIkAD+L084a0YkzAbt
nyHYKgRxshetLGhy38V7Qbe29lT43ww=
=OXs5
-----END PGP SIGNATURE-----

--5T9r7msn38jdLty5--
