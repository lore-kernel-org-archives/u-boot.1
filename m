Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CB4E9273E
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 16:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBAF83EC9;
	Mon, 29 Dec 2025 17:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="coiGVPCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7117183EAC; Mon, 29 Dec 2025 17:35:51 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3F783EAE
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 17:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cac8243bcdso5773720a34.3
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767026145; x=1767630945; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9lmRpyvDWC+cHx5REoiUaRP4gnZtDqqsMhRTGhQ08Ho=;
 b=coiGVPCGaI09PnPruKhxcGWfpvTjrYsL5Rfe2DcFUAfcy+26uAM+68z6zZYivpH6Ej
 fbLsYKIuDrLFIj7eZYueq1YwmgG7x0yyzmAm9bCoW4C0DdNLCPkN8M5IpEqb6rO1Gkdv
 pIOEHSLlbQfmypZphRi4yN/kQyJr7rX4ZIbO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767026145; x=1767630945;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9lmRpyvDWC+cHx5REoiUaRP4gnZtDqqsMhRTGhQ08Ho=;
 b=I6+pkVjqBFmThvj2DuLX//wjUR+qT5o5NUZKSsZP36lgRogibGsuU7JsX5fT58CKN7
 A00xRRFezW5u9nhcqMgMZm0LXzMmC4pOZSTb/j6Fww+RO+tlDG4Xe/sgF4xjjQrAZqJU
 R5y6MqvdtAUsE2MF/BM+ScmrOCSPXrFPdkyVaO8EU3rdhIwQmuQzA0/tptUMvzbeHlA2
 Nn0WgBIW/PBJLwrJWMN1KNG5ClyD99Mtt2JyX4oN7f3lGxkIirFUvhwABeF8N+RPkvPa
 3eafEbbY+NtT5FQUkKeG73SSwLnFxpEYictZdEmJvXVUGS4hQtYXXjs+TyycOviBLxsD
 aMKA==
X-Gm-Message-State: AOJu0YwQbVfRLueKfikVDYs//4dlPGZPHV7izHG+LYzzqfNM5n7wu22h
 AhNWjyt76WaK1q9FGAN2m1TqXzDWqbs5P19KVuvDrKkNg3RAmJgjjDbgs8mMNAdAsxuC6WnGzz+
 3/uy6NAA=
X-Gm-Gg: AY/fxX5ZOxXBfBPDcQg3hPsEL0Ic0noD2hfiU+b3NFEygO/bWgm3OQzfp0bqKOJzR9W
 VvoOlkUJRevbmOXtzOB1ewu3RHLjJu2zgHCe5qXeMWE1AoCcNWbbbr+WGJzr8EreZw86e5rPtSA
 GA/uh2pKKc1GTQAeliokdIYXFjapveCOkbjh7U0pDUnIyxU1Ec0EV/gAlDbSczW/xCHm81+vkDE
 ywK4nV0icVfIh2v9pkcDZT0Byl8y5RhiWCVNZF7enRgeE2UVoDlB1+lkUJmFlrzwxF15lcJ+I6s
 fg9yIotSQDKPmz6ltYb9zcOakXk9IQAu4QLkqFbNLHl+9B0QHezZsPhwI+eIjLVLgXTlrCvhPYb
 f3qCre5j3olYXpyPcryAXcbWlVxAD/lGRFK9HGi9heH5LxHvhzzxXzFxvF0HJa79XMlh5ZE1qgw
 BuZSomEh2C8Dtr6rjdS/laHSv0cWPk1AmZwaBjpbgFMT8vQJdubcrSTRmyEq45TDZRSa81JGCyx
 7NAteBwsrDP6LWlCMZER1UuhaCCjW5e2viGS9o=
X-Google-Smtp-Source: AGHT+IFsf21YHNjF+NVN2+l4lSrvd2c4RQECstk/yqt9YTDfUM+UQo96YFiqVymT0n9ffx1hUFFy2Q==
X-Received: by 2002:a05:6830:2549:b0:7cd:b383:ce37 with SMTP id
 46e09a7af769-7cdb383d01cmr12462711a34.36.1767026145493; 
 Mon, 29 Dec 2025 08:35:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673b9fcsm21252737a34.7.2025.12.29.08.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 08:35:45 -0800 (PST)
Date: Mon, 29 Dec 2025 10:35:42 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot joins Software Freedom Conservancy
Message-ID: <20251229163542.GQ710860@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r6pQeMKCJvUrYhtL"
Content-Disposition: inline
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


--r6pQeMKCJvUrYhtL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

The full text is here:
https://sfconservancy.org/news/2025/dec/29/u-boot-has-joined-sfc/ but in
short, we can now announce that U-Boot has joined with Software Freedom
Conservancy. Moving forward this will help us deal with a number of
problems we have and ensure a long and healthy future for the project
itself.

--=20
Tom

--r6pQeMKCJvUrYhtL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVKt2wAKCRAr4qD1Cr/k
CuDlAQDZDog7XnpHAJ1ZhfAdo0gwDYS6hrXYgxzleG3MDLvcHgD/Y/QXjYVpd4QY
snkZNomgwORcWrELfQmUadkTKTUewQQ=
=ZNv8
-----END PGP SIGNATURE-----

--r6pQeMKCJvUrYhtL--
