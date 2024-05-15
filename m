Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9BBC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 19:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 389DA88261;
	Wed, 15 May 2024 21:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JRn6Dol9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09DE688261; Wed, 15 May 2024 21:05:43 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0701E87F52
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 21:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5708d8beec6so2301120a12.0
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715799940; x=1716404740; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3SBdz0ppReNPn6yIkuDzTFw8J6Z9AzgwQ1EsAX8G0I=;
 b=JRn6Dol9w/0j1j8J93tPC2tvM6aGNHxbReABAS9OiMibSuWfv7uWu8gKhCVM9mfbAk
 Zd/H/QbzhHzGzd7mWaXnJuqOn/838unY8mBBknDJYHXRzms2BNkowfVdvGCvjkNZnlYV
 6i1c0/k5FakAdUvIxZ5dC0PQswrFqMYUrSuuwCLmABube0KrSHtOzdUirtw9oEQBVn3+
 kY/kRGxiu71lZ5KzjjM0P88bcnXBcJM+fFR+2kEtdDWSNIXScP/2hGFZLfnguEaVrTjY
 mTgK2ugzo6yXDbW7JP/cE36LyqjQun4ZgK5yjyH4UgsTMSdJCPz9+3XPBmAszHQUVTKt
 nDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715799940; x=1716404740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3SBdz0ppReNPn6yIkuDzTFw8J6Z9AzgwQ1EsAX8G0I=;
 b=vH0p6/QIp9vcnRZH5QlNJY2KgrxDs/xV93fMGvNLg1GHRoh1jEWslq01deVOTaLO+T
 Ojzk1R6xxg5Vdv62dwdZT7K47fl8+sgM9VeE2rGYPtRRNrytNPkrsRQwt0vhCtzmu5Uw
 OUPvWNEp7getmyXC8sL8qxvEqWKvudImQa9q4eVVmQVxfUUVWJWGbzcvupijDqFqf9E2
 d3mqdKPMjeeFcu+9BBsEfDL1Yu+FgWcHKpk1HUaJNfkyuTnGPw71D6K4JEdZridTpSZ5
 I50m18JgjOulcC0P/FhPPHQ8JqunbbVNpXuvkgUbvGJE5fpkV1vcT81yDO7+166V/JWr
 Pa6A==
X-Gm-Message-State: AOJu0YwIj2YShwIiC2lRQYtjtff061KglwRsDphGV+p5yD0Wfx5ug4C0
 PQUa+7c+WaD0B36+lMa6cAu8Wi9bRH7Vn/xTGKiD56q0AtqK9Sx33oadKxOCsTW20zPE3h2cYQ5
 0qzMfukDl5yIy3QIZ7kR/A5L+adU=
X-Google-Smtp-Source: AGHT+IHAd2t37DOSkEFh9dEuaicMxHgLZsbc1sR2A7r5vk04qRzclLD5GcYkqf7XtI5SadELxiJYUmL+gzqaC4CSK3s=
X-Received: by 2002:a50:c010:0:b0:572:a6dc:45aa with SMTP id
 4fb4d7f45d1cf-5734d5c1796mr16195164a12.4.1715799940311; Wed, 15 May 2024
 12:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240514202041.386027-1-fiona.klute@gmx.de>
In-Reply-To: <20240514202041.386027-1-fiona.klute@gmx.de>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 15 May 2024 12:05:28 -0700
Message-ID: <CAJaLiFxwTCCiXjrRP4eHZ+Enjw+X5H-Yzd6wFJemQnLR6Ws0Rw@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: Detailed example for netconsole setup
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Fiona,

On Tue, May 14, 2024 at 5:28=E2=80=AFPM Fiona Klute <fiona.klute@gmx.de> wr=
ote:
>
> This adds details that I would have liked to have readily available,
> in particular how to activate the network interface before enabling
> netconsole, and how to integrate netconsole so you can use the U-Boot
> prompt.
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>  doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
> index 2aa3b9ccc5..0c983e6970 100644
> --- a/doc/usage/netconsole.rst
> +++ b/doc/usage/netconsole.rst
> @@ -18,7 +18,9 @@ broadcast address and port 6666 are used. If it is set =
to an IP
>  address of 0 (or 0.0.0.0) then no messages are sent to the network.
>  The source / listening port can be configured separately by setting
>  the 'ncinport' environment variable and the destination port can be
> -configured by setting the 'ncoutport' environment variable.
> +configured by setting the 'ncoutport' environment variable. Note that
> +you need to set up the network interface (e.g. using DHCP) before it
> +can be used for network console.
>
>  For example, if your server IP is 192.168.1.1, you could use::
>
> @@ -107,3 +109,32 @@ as follows:
>
>  Note that unlike the U-Boot implementation the Linux netconsole is
>  unidirectional, i. e. you have console output only in Linux.
> +
> +Setup via environment
> +---------------------
> +
> +If persistent environment is enabled in your U-Boot configuration, you
> +can configure the network console using the environment. For example::
> +
> +       =3D> env set autoload no
> +       =3D> env set hostname "u-boot"
> +       =3D> env set bootdelay 5
> +       =3D> env set nc 'dhcp; env set stdout nc; env set stdin nc'

We would need "env set stderr nc" here, too.

All the best,
Tony

> +       =3D> env set ncip 192.168.1.1
> +       =3D> env set preboot "${preboot}; run nc;"
> +       =3D> env save
> +       =3D> reset
> +
> +``autoload no`` tells the ``dhcp`` command to configure the network
> +interface without trying to load an image. ``hostname "u-boot"`` sets
> +the hostname to be sent in DHCP requests, so they are easy to
> +recognize in the DHCP server log. The command in ``nc`` calls ``dhcp``
> +to make sure the network interface is set up before enabling
> +netconsole.
> +
> +Adding ``nc`` to ``preboot`` tells U-Boot to activate netconsole
> +before trying to find any boot options, so you can interact with it if
> +desired.
> +
> +``env save`` stores the settings persistently, and ``reset`` then
> +triggers a fresh start that will use the changed settings.
> --
> 2.43.0
>
