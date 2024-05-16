Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888CBC25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 19:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8687883F4;
	Thu, 16 May 2024 21:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CGsDLRp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85DC88415; Thu, 16 May 2024 21:28:50 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9963883E0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 21:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e564cad1f6so13623881fa.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715887728; x=1716492528; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHk2fXhpC4W6o1oEsl3mSH1xwpxMeeoyMx113rhkiCs=;
 b=CGsDLRp7hr3AE4NEfWmW5KmNN8qQmOdBV8Szmiqk7cUjDnKr7zjZknZBy6kVrs/kqk
 ikTXsgm5kbVS4yqGi5zBr8R4V+Z0DD605oHiEqavL+ISc0E4e5g6KunltUPGvvzYI3/E
 3U6FU1DNgZ/FVhcEkH2bpJbuGDOM75ATQfwI1aQi/B6QUykFguISkN/Xh3xh57mMXkwS
 EwIzsYEvSOHJcG4csOf7CgHWBICIFFzK/GgEJiy16fm2DdpVuvms7zwZd3CyayZ0PIwG
 OFfZ5mnYx0Tdr6speJO+2p1jabkVK2mq4zgfV3N+opoE3RadYMpxEf5+nRk9SlCz5vqB
 zvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715887728; x=1716492528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHk2fXhpC4W6o1oEsl3mSH1xwpxMeeoyMx113rhkiCs=;
 b=LJYRXQvtkyF9aEOO8feiZafcUlt1QNscr4Hm0C+UBXPq7ppq+Zuy/SPE1US1ovrMGX
 r8Uh6bNb6WXQPFikTHvxBSO7PjU86ChZA0DIhu3+NFlYMrOzFowe6VvRbIusmRtBcAXh
 6o8aYXoleM3a+cBwcNME0nXv30wE+17la0RoXGjf2D+crW0sIBSLa2nXX5wK7ltfMNx8
 e2rYOHGE0SGwA3ofu5eTjfVwUbIeqZdyBKpdvORrLa7bwR1PCDtmayQlu1hE0gpn0kMq
 p0qiP2tSK8oKptbaNARdOyNCFs/MbvPKu69aMZe8C9thhG6Nl1MFNlwcwfT18HgS+XuH
 bwjg==
X-Gm-Message-State: AOJu0YyYPmIMNhLA+N54HTqi8PUDs+dQh8UogYC00KQOvXuxI4fN4liZ
 IycnB+ImbDUY3EaBgcRT0bwA7WFYxVi/zO89H5+FHte9PNze4O89QWmcXeilNmaguL1WTejXyvD
 V1VM8CjdizVfaNm7J2s8iBF4TbJQ=
X-Google-Smtp-Source: AGHT+IGgNKB8A8q2TabwilXytELxC55JZRw8T74G/4XzAmUNPZs2eveCpkRWpnCPs92CoyURY1M6r83271ZwbAJzZ+4=
X-Received: by 2002:a2e:9e48:0:b0:2e5:67bc:6f2 with SMTP id
 38308e7fff4ca-2e567bc07c3mr94917411fa.44.1715887727576; Thu, 16 May 2024
 12:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240516104245.2075748-1-fiona.klute@gmx.de>
In-Reply-To: <20240516104245.2075748-1-fiona.klute@gmx.de>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 16 May 2024 12:28:36 -0700
Message-ID: <CAJaLiFw1BD6rtMd8E3eejM62YY9W+YA9fmP9FGkiN1KE0fwgZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc: Detailed example for netconsole setup
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

On Thu, May 16, 2024 at 3:43=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de> wr=
ote:
>
> This adds details that I would have liked to have readily available,
> in particular how to activate the network interface before enabling
> netconsole, and how to integrate netconsole so you can use the U-Boot
> prompt.
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
> Changes in v2:
> * Include stderr redirection
> * Use 4 spaces instead of tabs for code block to avoid overflowing
>   lines
>
>  doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
> index 2aa3b9ccc5..647f0c220b 100644
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
> +    =3D> env set autoload no
> +    =3D> env set hostname "u-boot"
> +    =3D> env set bootdelay 5
> +    =3D> env set nc 'dhcp; env set stdout nc; env set stderr nc; env set=
 stdin nc'
> +    =3D> env set ncip 192.168.1.1
> +    =3D> env set preboot "${preboot}; run nc;"
> +    =3D> env save
> +    =3D> reset
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

Just for information, if the board uses static IP then the example
would be slightly different. I usually use static IP and ping the
netconsole server to make sure it is up. However, I think this DHCP
example is good enough to show how to prepare and activate netconsole.

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony
