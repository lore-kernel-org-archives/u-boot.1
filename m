Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09E1C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D8888385;
	Thu, 20 Jun 2024 16:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZqBm/R6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 360CF8846F; Thu, 20 Jun 2024 16:39:56 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B54D88276
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-25cb3f1765bso538394fac.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718894393; x=1719499193; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aI50R7j4lvNxVfKVcnoIZkZjBuBR7L6gW2yE064bVi4=;
 b=ZqBm/R6wNqsmeD9UnCimEUIi2gO+0Cf8xLR4LLG2K0JUt1x54cDnmw5da+I6GrDl5g
 C7PqO1t+EFNdjVs32utsqU24c9Ylg6D0+QdfoIV/3+TQm9R1O6tHekVnq1E4DscMI3VF
 PZpqLN8UsIeFIPpdc6F/AJko8mdiyvhoXZnP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718894393; x=1719499193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI50R7j4lvNxVfKVcnoIZkZjBuBR7L6gW2yE064bVi4=;
 b=HwJdGmEw4ce9aXxbKJjZ2ZwhMxDq1sbwWkaYM/94saHkocKpZXS1uhQk9GXELHyicq
 fLUeo6swDUEyRNeSy1ka+e3Lx1rprTMpfALMfk5L+yIT72h0dAUROP3QGTH5LxYdLLdN
 Y2EXjSjJkQpFLHkIbj3CZNNSuYLOwNJ2El2BPR4hE4GK9GPEKmR5E5XkvImqhuHrJZ/8
 mX/f1lnhbPemIWD9i9FMe/sl0/bmN5yFhflLZiLLOOSMJjuwj8/Ho/lSQtUlPq47R6X8
 SpPew9GsNJKAPQZxCutBQ8oD/cx+RxWZwDxt+D9UDZ+zy+JP7y6onLyw5b5bN/G5gB0C
 P+dA==
X-Gm-Message-State: AOJu0YyWY9Sh9/6tVR07gaF7PRE8Mg6bN2IvMdZp+4tRC3oUHMs173uV
 vjmzOupFukoMSQynEPwv961qjLvRHRh2BmUWWtGyDWpTICsEEXSNMrvPzfJo+9M=
X-Google-Smtp-Source: AGHT+IEKM3+JDmoRc1GxJCkz/uLa1UtvcizlXeaMcz4SSpfTkvnryJ4Nq9QCviwxNlfnLoCChH4xDw==
X-Received: by 2002:a05:6870:b69e:b0:254:fb0c:cd6a with SMTP id
 586e51a60fabf-25c94d70a31mr6159853fac.48.1718894392780; 
 Thu, 20 Jun 2024 07:39:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa1140asm4269758fac.23.2024.06.20.07.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:39:52 -0700 (PDT)
Date: Thu, 20 Jun 2024 08:39:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] RFC: Add a tag for the world builds
Message-ID: <20240620143950.GO68077@bill-the-cat>
References: <20240620133346.1135479-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8b+DnrDHoY6Dd8Y6"
Content-Disposition: inline
In-Reply-To: <20240620133346.1135479-1-sjg@chromium.org>
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


--8b+DnrDHoY6Dd8Y6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 07:33:46AM -0600, Simon Glass wrote:

> Currently the world builds run on all runners, including faster and
> slower ones.
>=20
> The difference can be quite dramatic, with some builders 4x as fast as
> others, resulting in just one world build taking between 20 minutes and
> an hour and 20 minutes.
>=20
> Add a tag so that we can select which builders run these CPU-intensive
> jobs.
>=20
> With this tag we can also increase CPU utilisation by running multiple
> QEMU tests in parallel. Currently these tests leave most machines fairly
> idle, since we cannot run more than one world build on a machine.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This conflicts I think with Jiaxun's desire to make our GitLab job
runnable on the public runners too, and where we'll end up with 10 world
build jobs ala Azure.

--=20
Tom

--8b+DnrDHoY6Dd8Y6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0PzYACgkQFHw5/5Y0
tyxoeQwAlxc/oFwonXqb//FF9cBdlt+YcSgeWbT4WT2YcbNA3vq8h+QkoBdi3hET
a2QB5dHw1L+Vm4PmnxXFi4io4+lJIFSrAzsk4mm7ZFNT09XnLuyReSyhBm6X9BFm
pECkhw6fAJYGXMIaSOucjjyKpWFFTFsSfJxwOzfRJH9VzpQ2RMdu6hB9SIM3BajM
MU5RmvG8rO5U3Y9+sbw5AWnGkV5ccJuntSvYJmSxu1H8QzU81twuOj7Dd99gF48D
EYW0PIuufISkvT+nWHBp3wI+In+WsGhvYkPAHgulOcamVbywNnleyTBpRCefIfzg
EzAxRhR3hO9h2Am7SxF94hvCQux0jzrjmQ4WO8CZ6i1szGuTqHwB97ULCnY7s/y2
MJ1W6yz0XarUekmNtrZW7tgM31Qym7P2JXuq9RezRT8ksCMztDfLNZEToF7jM29U
xvVIo0vwHQos4jJr+noKRnkWqMkCHc6jaAh8uxVAyX2L+JSTJVaVS7yiQ4ZBwTc1
vZO1Jvc6
=8+V7
-----END PGP SIGNATURE-----

--8b+DnrDHoY6Dd8Y6--
