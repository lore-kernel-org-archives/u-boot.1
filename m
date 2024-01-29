Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55050C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB9787DB9;
	Mon, 29 Jan 2024 18:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I4jXI8Ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1A8A87DC1; Mon, 29 Jan 2024 18:55:43 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC5E87DB9
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6002317a427so24680557b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550940; x=1707155740; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EazdJiCXqmjUpid2y8fHUChpeYt/eeU8OR9nqJlvQQM=;
 b=I4jXI8RasLz/13rU4xdB2xKS9Lo4ZKfNYdCV5h5j3MPNM1P6hM1dAI2NFf1Q0oPH0d
 cMxjUO2KudsixHFPCuGfeaaQh+Dr8ouN/xqEEKKUVoiZn0rItsHAoT2l564Xi/C/Iqbr
 QPrYK3Hw53UNR8RCDCtg7UWzeoC20PeUh/6IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550940; x=1707155740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EazdJiCXqmjUpid2y8fHUChpeYt/eeU8OR9nqJlvQQM=;
 b=NSs2+W2QknHVUYeC4a97qSPuqmUILCeV17e/AEW/KEdKe3NZOfKDQmjQ15ROS0JecF
 lf7CJyHiCECkDWnbZzhfVM5mT7IWx7wJdcWWgx6BOyd8kwIMGkGhGgA0vsEDF5fXd9Kn
 F0uXtRkp/YEAXaBQHlhinn3Y00H5JvLQsKn1Y2IgluuUoQpW6GWDQ3BOcOiofLc7Vj1c
 W/gOj4rhvNonYgCdTb8vpKXPS4dqsniw3aLRqwcOl+6Q4q14R96tYrePphV/FxFISmrZ
 +CcrhqKS+u4+qOhJzkkl7pUniYVGTSlOKAvgFg3WTRPyaoIXWnxFSJIIOyaxIINRI3ga
 c9MQ==
X-Gm-Message-State: AOJu0Ywf7MUlVdPcBoW1Ts4ANEFMe8dWmPwxaIjT8hUkJDccJ3qqE4Wg
 Sfi8gZ4888p//PIU6GSnF0sEKgeZM3Rsv/JcALrdZil4IPOpD1Iw4lsl29LyYkh/G+J1yjV9e3B
 f
X-Google-Smtp-Source: AGHT+IF6vuFMd+DEcIF1FMfUehF83TDYFM1kvjERpZd8ICN9icpmmTbqIhSVbzOVL6F9AWFc5PXOyA==
X-Received: by 2002:a0d:f4c3:0:b0:5ff:55f6:7537 with SMTP id
 d186-20020a0df4c3000000b005ff55f67537mr4444736ywf.5.1706550940623; 
 Mon, 29 Jan 2024 09:55:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 q131-20020a819989000000b00600392410ffsm2631389ywg.73.2024.01.29.09.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:55:39 -0800 (PST)
Date: Mon, 29 Jan 2024 12:55:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: usb: Add tests for USB device
Message-ID: <20240129175537.GK1152441@bill-the-cat>
References: <5b52177849019cb9a9847c987032343c0dc280d7.1705665742.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aOqGkF6G/nYUzWcI"
Content-Disposition: inline
In-Reply-To: <5b52177849019cb9a9847c987032343c0dc280d7.1705665742.git.love.kumar@amd.com>
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


--aOqGkF6G/nYUzWcI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 07:56:02PM +0530, Love Kumar wrote:

> Add the test cases for usb commands to test its various functionality
> such as start, stop, reset, info, tree, storage, dev, part, ls, load,
> and save. It also adds different file systems cases such as fat32, ext2
> and ext4.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--aOqGkF6G/nYUzWcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35pkACgkQFHw5/5Y0
tyy+Zgv9EJb/lzfse9nSDqWRYuprMtrBk2uedjeX718o+PAJb+bEVb9f97MoI3jE
eGMf+EfqzHQe7uA0yedorV0GnkmgvptzLRsPwGR9xPsbNqw3vzJwPGFNWhU8sF3I
T+bO9OBfnQ3ZuEpv7sir2uPnsOsQAflFPDnf2hTboCn+bhNBpIA7NSpVT1zwz9AE
zZjTLt9t2acs7ANrThk4S3v7vi4B4rL90O0gvYaDda5BgoPVm/LkkOTmHzhmthYW
de5uT63Mb3vDwACZEfbGpC9XKnlJn4SJ28lTqVYZ18Ju9xhvSCo66tzOw0FndddC
sRKiEPYEoY0Z0r3I8PcFnwRu5AJw8S9rkMPIjgjQ7hEwH+iA2zl6xg9XUdYok7Sd
cUMUoEFKUTSqT8HecUR+SrQIw4pt58+YKJOdIiwfHLwaXb6Nw9Uu+HOqIK7BZAto
hQQJyaX9vJBzpVWt37yFJw2EaWsRB2DAJ1vbHqt35wKLZYExyFId09KcOvcp6ugE
xGbG38tf
=A6D2
-----END PGP SIGNATURE-----

--aOqGkF6G/nYUzWcI--
