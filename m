Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35858C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 20:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DB58210A;
	Mon,  5 May 2025 22:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lpPloENO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6234B82163; Mon,  5 May 2025 22:11:12 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3594820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 22:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7311a8bb581so3761748a34.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746475868; x=1747080668; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fNQQ9sCVpu+9x6epp1aO92RdDrLYP77Mh8A9hEDfyZA=;
 b=lpPloENOJ/3axfKYl3y9f+Ewql/EhU+D4gHEfV6AcBr+0T3+g5JUjOWhVFr/h2Q0U7
 cpermSk0g6PDg2u71cei6Rjc17g4J/phBFL63RiX+6tob/txkCdZKosYrDsgb+9/q2xZ
 0AxeFzUkh+ZwfjtTLgR3U8TbfJGbBHxDlNqdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746475868; x=1747080668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNQQ9sCVpu+9x6epp1aO92RdDrLYP77Mh8A9hEDfyZA=;
 b=Y6vF+LJSw3R+eEDnTWV5IPWuOs1IalblPheeT0qELeogyJYe19iVwf7Wyo7+MKVM4V
 EUfO+tUMEYJUewL5wXcE0CupDaDHnd3j8xt1dOIbi91WRaiadGJqpvnnNAsq/wp2nxuX
 V82IhG85h9PIjUGI/LwopM7UpEBfM9YizExC4sPzqXmxCtCsfbYPT5KKsE/Dn3VAM3hK
 9t4Tu3ldpWit2/1xt11qKUBiRFjEEwiPZ289GadXaoUy3w5z2sNB5ekhf+ylvq2FVM87
 PdP8zgRdeWR9vu7ExZ2rnrzD37HN59gVnQVMuhLV0UDpcJqxjsMDIrg9n96FgBWNulgF
 oQjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhveEjmAhQ51RpXcwe/3jFDt62yo3ANIj5bJlgPwPyhsQGsrmEIdVZNgM+MK9vxaEj46bVwvY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxzs8oTlO8YYfBQLqBDCNnNS2llLxDjPqJe5mF68VdE+QZzjKtZ
 nRJDOoo6r6aJvBCP1z1bJ+BJYDiDAf56artNufq9Vtedqjl7x9Qk/rnWr9m79fkLPgQ4+A4ZbOk
 mhRo=
X-Gm-Gg: ASbGnctbVUEKv7VVOBGxWh6EGJrGTep4rz6artKjtDvHqUP816OpSr49bTeAeYK0Ho/
 CIMFBVLQpYL0dLP4OmpQkBurb5dtISG+dM7rZuv5wPQxrkhPj0w3kM7K4MV/TLlSZWD//zP52ws
 bK8bXHAx7VOE3xUiKbYjOQzYk9ZEbEemhz5zoNmk8vlBP189VydRLPLrJgvfA9nLIzwDinQPJmA
 rww4yacglFNVuE/rCVz5+bBcgbEzGsiivuRCJeMX/qtp/vmZ77NJYNnLnleyxFFAv2TG2dkgP+j
 a9YnIKcPe5bpQzSc7yY+oRsVqb938neTzV7zViqGEtBdXt8QqeeVkWT5P/12HkiGtrrzHY0gCbG
 8ndgLMuVJd5iT
X-Google-Smtp-Source: AGHT+IE6kUxhNKQbXw1XIuB6t6DQzRIWKBpZ/pfBB7awHngnvKSfnwZxDaH2SMl22EdyHDBEJPC+gQ==
X-Received: by 2002:a05:6830:6115:b0:72c:10db:f210 with SMTP id
 46e09a7af769-731eadc5cdfmr6204635a34.13.1746475868583; 
 Mon, 05 May 2025 13:11:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31a282dsm1702102a34.12.2025.05.05.13.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:11:07 -0700 (PDT)
Date: Mon, 5 May 2025 14:11:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] Dockerfile: use QEMU 10.0.0
Message-ID: <20250505201106.GA50062@bill-the-cat>
References: <20250428054036.17234-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XgfT3WHJAgs8PC4c"
Content-Disposition: inline
In-Reply-To: <20250428054036.17234-1-heinrich.schuchardt@canonical.com>
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


--XgfT3WHJAgs8PC4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 07:40:36AM +0200, Heinrich Schuchardt wrote:

> The RISC-V emulation has develop quite a bit since 8.2.0.
> Let's update the QEMU version.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

But please note that it's blocked on:
https://gitlab.com/qemu-project/qemu/-/issues/2944
https://gitlab.com/qemu-project/qemu/-/issues/2945

--=20
Tom

--XgfT3WHJAgs8PC4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZG1oACgkQFHw5/5Y0
tyzR3wwAhK/5rr/i+8zmQ+sTq3yv+tfu5JL4csDhLQFflxPed9ejBqxdphjFfy9J
jaVz4qb/pjFLP8k3rn6TFt7P3ssnmyKCFq++tHsTAdaDUV8aBC9t2O0bKZJVLRf5
nhz1SMkU5RtN1Y2yVX7ANX3FLxUOaQCE6pIaAv+D75mDNzGjPQt1dvKAcS4/ODIq
ztnN4NZA7VQsnq0sCPxKEgaJY72zjd/GsWKGAOx7cazwvfG4hx1Z7KvGYQTbW/Uk
GO3TKW6qq0IcbAxLsfTqjEvTiL9ap5v3cLL/KYJkxlxMRA8X3ahN/Rf+gxhqDRwc
MlAoH0EAHbSvtihXaL6areB5X9Npegg596k8wAx9tqp41+jQk31viZlGSqV3PtE/
+DW3jPap8eiNbHkXlsue6Iy+uIqpwvpR3vEYtCpLIa/zviMijvpWdoWOi+NYJJeY
Zvw6P2DZ7/4kb1O/95XIkRw28cQZzpe/v1dl2wStsr7+pHWmo05PmhYdgAk/dr3Q
l/GGtj8f
=C2Ti
-----END PGP SIGNATURE-----

--XgfT3WHJAgs8PC4c--
