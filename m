Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285A1C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A005D809A4;
	Wed, 29 Jan 2025 17:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o8v+uKor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C86F809A4; Wed, 29 Jan 2025 17:03:30 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60AD9807D7
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46b1d40ac6bso7935071cf.0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738166607; x=1738771407; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sm490Tq7d/GsGLLCWoYhQP+trNccjQbEJbcXdvda9uo=;
 b=o8v+uKorvnyE/NyJsJMY/dAECOvbT2WqeovkAT5UZqQxdnqUGgf3XNn3WE0y6PVZDG
 X/gTIT+xxDhz4ajo2m/BBkjVfv4+mcqB81KjWJroj7N8nmz79Y6Z2HHqERVr3Q8aoA/u
 Khr0hSLHiWJ/xpJgkKbgZ/8ubrXsNMMDd30v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738166607; x=1738771407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sm490Tq7d/GsGLLCWoYhQP+trNccjQbEJbcXdvda9uo=;
 b=HExwxebWo5YZoiMBaxwt1VehevNL8uNLrSqxKtux4Rh3pKhBm1ryBmKh6a7zuKduPO
 tX5F/lelKW4NAFe1EDme5dIlEV4S5IWlAe8zV0OJd+YPN5q2vvlZ50sUVAT7yFIO9ylh
 7L/IRBvNjb3jM04ogCr8KanwmynBR1KEO0heIeWrnOZ0v5dHOw8l8QjJL3m4ijnE4Yg8
 Z+b1fmw1Q3sHjK0SCbYmEhrIhkqR5Y1mymkAWekqHUksnaZ3VvWa/eYqTf3v2yNHVNl6
 DxJzso1uGK4Ua5SqWT8kl9t7YeY6Xn6QSGsmdHvNfXPM2RzccgtCa6+9Lbm5vkG/Py63
 3/gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVwpyTW99gO3FbxIzA7xxItaQi8956FBz1DK8lIakVf86J0DoXfUU6FQs3C0Bgxmn73vMu3b0=@lists.denx.de
X-Gm-Message-State: AOJu0YztegtdKavmc4OskdXkUaoxXW1EVMrISsiuAoOC2ErFYn7sft5k
 Ijk9eBBmdfMHyVTzWOiG4oA1tq+LUXHbuilWBlilF4/Dhg4lrwhfOAayKClvrp1MykhRPmgg3Kj
 n
X-Gm-Gg: ASbGnctzgLpWZqcJE9YzOvu5I/kvQuw+ufPbHmNOOzgoF63F5eS0fpi4SrQfojTClEH
 kYCAnvPrB35uknfZ3IShsskqn7x4lKCbMYmr9I/vUZZZH7H3OpzBvhMZoANq1hkF4k4WqEZBvWZ
 J+TtfijsPMYFyz2/rfiEcB+cnLwif9t7t5ECgS3OkdXqGQUNnpY6UyQkolNoRi3h+K6WwNnKl0h
 k1iG7SKgPH+GdCKfFEesyMpEh880K2k1cq73JivOlzhFM/e5xorm/5WX9KXY898Vw1FGx8g/mno
 z5hP7DyY1Hr7pFu++FcxaDMwLA==
X-Google-Smtp-Source: AGHT+IF3FlUVoX4TD9wU3x43tlg1Ffes6i92Cy17UT2wx5M7/UUVxziep4basLhOdVDZVlMgRBJk9g==
X-Received: by 2002:a05:622a:588f:b0:460:dc96:27bd with SMTP id
 d75a77b69052e-46fc49a7684mr125011191cf.14.1738166607163; 
 Wed, 29 Jan 2025 08:03:27 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6687e9desm64203901cf.29.2025.01.29.08.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 08:03:26 -0800 (PST)
Date: Wed, 29 Jan 2025 10:03:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <m.schwan@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Message-ID: <20250129160323.GV1233568@bill-the-cat>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DqnUjYT3SxkTaQiS"
Content-Disposition: inline
In-Reply-To: <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
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


--DqnUjYT3SxkTaQiS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 03:25:25PM +0100, Martin Schwan wrote:
> Add a bootmeth driver which supports booting A/B system with RAUC as
> their update client.
>=20
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> ---
>  boot/Kconfig         |  11 ++
>  boot/Makefile        |   1 +
>  boot/bootmeth_rauc.c | 408 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 420 insertions(+)

I'm curious, what would be required to have this work for any block
device, rather than just "mmc" ? Just a lack of time / testing / this is
v1 and that's a future idea? Or is there something more fundamental
required within bootstd/bootmeths ? Thanks!

--=20
Tom

--DqnUjYT3SxkTaQiS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeaUUgACgkQFHw5/5Y0
tyw+Gwv+NrNxPC8FNoYi98uOecfdw5tYJ/wmm9jyM07AiO5WpMlYJ70akh6yNWe7
DMe9M5+cFrX2NY/2mConUcbtMBjIvgiFJ4hQTboh5T2OCGE6dg3ehKUbTbEj9HBw
xytgwEq4sKdpOmq/lcOHh6W0BT9ZksTz7sKYgorKW2x+nCwj6WlLEhRLjPRiZPfs
XHLrsFxx1vpAevFBjH/KjcwBm0dvoV4vJcLCLyEkNJmFAmuo+hdA8L31PyMoEkwn
RTyAJetwYnFFnGwkmY2XEwVRbCM+3c3JgCS6Wu1k1dBJ1bT7WcEAe9XM88Ac7XJI
omts//Ml3StaOLIFuH25rn8wMmdaHtyHwsmnrOOK2faSmZMW7y3CD2KNCXYLmB+0
FIpFY8Ymp0ej8rJDpsy4Z09Oj695DpIJbbYNOJ/LbqNS3rCdFzqgsNUmFs5arnnn
fbLGblVUrXwLlC9//btc4s0mMAljbXHX/BWAxeZJdd2UKzCzMljaFCFka04hoWZH
bMFLkqDz
=N/Ez
-----END PGP SIGNATURE-----

--DqnUjYT3SxkTaQiS--
