Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DBBE77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 21:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B0F880584;
	Mon, 30 Dec 2024 22:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XiYXjKpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC83A805C1; Mon, 30 Dec 2024 22:53:03 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F113880383
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 22:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d89a727a19so92705756d6.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735595580; x=1736200380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zZ0/ziGHPAY3JV3FSNbwu7BQKJn2T/omuyvLHK9i3l4=;
 b=XiYXjKpguXZeAd4H+rUA9fnucHQw/K2+hH1cA8C3Youw0w6f0+Dtr+7DoF4QBDOGIq
 +5rWHrNxPW3LJFKFGtxMqj1pYKhs4z7LgdhIJ+rg0PbFiZkGSQJJZMNYkbmtm6iXZ/TR
 wMc8zAg799zjUXvYakTqjnBxyq4s6mVWNX00E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735595580; x=1736200380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZ0/ziGHPAY3JV3FSNbwu7BQKJn2T/omuyvLHK9i3l4=;
 b=vV64Riz2HBHH+2KWKv6Hjrl7uOKVUwboP3NxXzHMy/iKtDAA7SeV1QwHujYPXqN3VM
 DKq5+TxTBWblF8GyIJ66qWYoqrdgmYH9NgJ7dj3XsbQ6S5ZtWzI0yHdUmuNHFn8bW4Ad
 1n9WJ7Sf8Y24nYoAifjaUdVwhSWOu8hW4fYNFecBF218QNnXtHadW5+IzXiUrz+nNSDL
 xL0j67m3ZtmwfyOTEzG2G8UaDCEc0tUin0AxAnKwKIjvN26n10P1+F58k7DG7b3Z9jRy
 +JuHRvF0DnHueYuWcTQXzw6LGv8+2fjsqBC1XG82FCfM8xoWNtFTaPsr15R6FqXhj+8S
 Lgvg==
X-Gm-Message-State: AOJu0YwYmnUKADv3PlwnlEvKw9RrKItOHkN5HazIoN+wB+lhoHp+jDH6
 iT/WZQ4ulBTR0kyh/S1nMejnv0IAnrbYLJjgy/eFlhmYxR9iXSwuZCoRoI3KzxDzH1w7i0yLc3g
 4
X-Gm-Gg: ASbGncuulWxyUFsvaT2WrXo8DYHkUe7TFb1LjCv5ZEVeiAJr/bixRJWIdsajibzmzw/
 GbRYBPtQuKUDg0hj6zZXLfSCk+sQu1RDS7hd71lPtYiPCeyG13eivBiV1xPXURshq5+QDgt/dJQ
 UgXdXibQcIJo+818maHfoXPfHc1qwNOFFea8mP7T8EwayVfbFZEOAo1ipd7/JMaeq+2SQXRlQAU
 P5QjnWhuQgzRtSbDgb2KJtoQce+xEsmE/Z4GbtTc/IrBc6Sq0YHXrycBQ==
X-Google-Smtp-Source: AGHT+IE0HFUb8kSo1/JfP1DM7sLMk4NZOhwcGX18pygm6MCPQnB1LbKkyIbLRUzIauwp4ylDYaiOjA==
X-Received: by 2002:a05:6214:482:b0:6d8:e7c9:ffa0 with SMTP id
 6a1803df08f44-6dd155cde22mr791013866d6.19.1735595579880; 
 Mon, 30 Dec 2024 13:52:59 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d52c2sm105768156d6.113.2024.12.30.13.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 13:52:59 -0800 (PST)
Date: Mon, 30 Dec 2024 15:52:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/next
Message-ID: <20241230215256.GE3476@bill-the-cat>
References: <20241229173626.44743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YrDBj/8Lxhby8yPo"
Content-Disposition: inline
In-Reply-To: <20241229173626.44743-1-marek.vasut+renesas@mailbox.org>
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


--YrDBj/8Lxhby8yPo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 29, 2024 at 06:35:50PM +0100, Marek Vasut wrote:

> The following changes since commit d580a013cca67a8115fb88d260498bde181709=
a1:
>=20
>   Merge patch series "vbe: Series part E" (2024-12-27 15:16:39 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next
>=20
> for you to fetch changes up to 678f7c8f560775e0ac33300f54281dfcaa2e525a:
>=20
>   net: rswitch: Implement C22 to C45 access (2024-12-29 16:55:32 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--YrDBj/8Lxhby8yPo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdzFjEACgkQFHw5/5Y0
tyyYUgv9ECxOVQ86UNvCWPenCb4eEjxnvaxKsIQLZmTL/sPw6surk/KNo9WU3UCG
Vpajp1ytAAc8Zb2zm0vlrMU0aLpQoBxUGAsnOfn3Qt8L+PPs3hvJx2P4mL+W81nS
AubqenVmSozO0bJAn1GNdnOD77uaEsuhNdJK3hlxZP2TmNdsME6+a/FyU81JRlJM
y3Vr5T4qfwvkIMyq/u0xIXrX94CKFTl+ukkS4UAA5n/PGVR0nNj7qN+Uu16TxrA9
MsmhWvuncudkLCvnBLbDGLBYSd9tB1uu/X8L2EtrNZIFOhM2lXytrBMtsJuh+OoF
CP1nw//bzW5btcbc0FgLkz1rNu4nw21lFQABakY1yu+l9pJYRgcTpS6wlU/xcHqv
9DI/fPbE434vOBr7aPp8xim3QgIYqYql78d7YieLR7eqNSILzLQ8dELfH3Lu5C5n
nOwHdX8OXkjR5dgOR0P/XgV0F6VhLmlWthnMSiixoGEjncQixdJEFsU1XgOnbofH
EWJKxT0e
=riii
-----END PGP SIGNATURE-----

--YrDBj/8Lxhby8yPo--
