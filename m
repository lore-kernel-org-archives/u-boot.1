Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D30C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 17:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E2987AAE;
	Mon, 30 Oct 2023 18:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BluP5aYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3F8870F3; Mon, 30 Oct 2023 18:25:58 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C4F187ABC
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 18:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ac376d311aso44702267b3.1
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698686755; x=1699291555; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K/Nnup4JL14kXr1eg86iqo2nyb3Xj/MBIdt+iCqql8A=;
 b=BluP5aYp/A8Dj5Jx0XecDI1M8WHrITRAYxM9amYRDufcNGL9Bgcj29VX2toZj6AYVR
 hrpzsOlPH6oEpndQZmTO+6thhv0hoUuSzGjA+xglYxGKzntU213cxQEQyhgG/+D2UyZz
 f3raehp4X+Rco5nl5OtspdnnlpJFaBAc6gNG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698686755; x=1699291555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/Nnup4JL14kXr1eg86iqo2nyb3Xj/MBIdt+iCqql8A=;
 b=Mjy8LJqHWMZq6TksOomhoV6p7+l3x15j6AACwwxfJCpvdG3o0hv4LM1HnAX+mVavC8
 JyfioLGWE/6FfeC3H1cLwxEjN9HyTQ7RND9G7wUnCxCb8rrE4fBMii+FKiViFzcA2rqo
 9dD37wXbQZ5sRqK2QmsViimAuaSaC9IxSnJL1wnhkKq4KUfq4FNsYd7YTL0Oofvh5QEv
 +m0+CjkPSH4okhX5nTuxVQMtwQ8PmwsrqHAFO/h/4pfw7lDQD5ULeGlAPzUfLwbFtYhA
 MZMvSCttzUlTZaOJn1s68ZMMWESIzTfWcCFXVRhqIADOD/Po0LZgum2G6HfXvOgFtQcC
 oq4w==
X-Gm-Message-State: AOJu0Yy7jf5vxM1UBWtltD47dKQwE0HbBMEFsn0Sbzx4Ssb0JiVRfCfw
 wLzFdXrNMXDyOO8+Llf+PlgQ9g==
X-Google-Smtp-Source: AGHT+IFeQtY7CW4lLjzY9Oj0+LzPLiadiKCqDTJ6/EpqxJuHtLx6OXi3ppVKeElB4Rd0WJFwHM2YMA==
X-Received: by 2002:a25:42c9:0:b0:da0:447a:e9d8 with SMTP id
 p192-20020a2542c9000000b00da0447ae9d8mr8810091yba.10.1698686753224; 
 Mon, 30 Oct 2023 10:25:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 mi8-20020a056214558800b0066d05ed3778sm3592672qvb.56.2023.10.30.10.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 10:25:52 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:25:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] exynos: Avoid duplicate reset_cpu with SYSRESET enabled
Message-ID: <20231030172550.GV496310@bill-the-cat>
References: <20231030165502.27813-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2lDAqLrPzOgk8d52"
Content-Disposition: inline
In-Reply-To: <20231030165502.27813-1-semen.protsenko@linaro.org>
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


--2lDAqLrPzOgk8d52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:55:02AM -0500, Sam Protsenko wrote:

> The sysreset uclass unconditionally provides a definition of the
> reset_cpu() function. So does the exynos soc code. Fix the build with
> SYSRESET enabled by omitting the function from the soc code in that
> case. The code still needs to be kept around for use in SPL.
>=20
> This commit was inspired by commit 6e19dc84c14b ("sunxi: Avoid duplicate
> reset_cpu with SYSRESET enabled").
>=20
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2lDAqLrPzOgk8d52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU/5xgACgkQFHw5/5Y0
tywpMQv+NA499cNdPMkJcQieOVDWRPhyLT0HNEQ8nHCsXJOo6u5R5evD7248P2QX
cyIzhSYEaxQQu7K4n6aEpXgWUoE0mlH9ShYewFwOrNDbQSC/VwmegP3b5vzE4RJ2
jV0WuEsgRi47ZpVCQ1yMcf7yU/aPtzl9/9RW2HTugxcqH3A+kJ08eYyEp6pSceBw
VNMuJnhbTBL4n41hdmNhU46bdE8MQM3l9Zvd1ZNoNCUQQBBpF78wcqqpuWBn51qK
MF3ijTeX2VwhaPqUooxlgICQWY9g/EyFzuNYxLE40FvkZq+5Ktvq/Yn9PzdogWXy
QalBuAYSDCzYlc228FfI5G4ksdejQp0wAjNuKk/5iePOJWZ6L9ZVA/rBVttAPYrE
7UkVJdZzRFz7b6wDGtMp3Fn5rSLPZjfrKRW8lI3kq8FB+luD3ubRk1sI3StEso8t
QMbN1qytE2o0ai+is6g5muzDWPOGTqfbWXETZRMtksl0Rg+KyoXbCdjeLZv6ixNH
v7LG9WCc
=hLpp
-----END PGP SIGNATURE-----

--2lDAqLrPzOgk8d52--
