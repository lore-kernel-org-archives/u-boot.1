Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F65CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0DFB86BB4;
	Tue, 17 Oct 2023 16:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FPiua3iq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E3EE803AC; Tue, 17 Oct 2023 16:02:23 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A65786E64
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7eef0b931so70262247b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697551339; x=1698156139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fRwFKiWyNWcFmchNMwoj8QNJVOkM/6VnLmon0rzbdJU=;
 b=FPiua3iqCHR+kxZu7RCZoRW5EGW+BGbzUvjUORRpC6ETPKWHyKgK6NenPpxXmXBOIS
 Rf3h+Kd3DmhKteWVFoH7C8B4Edj/X7B0Z4PY+Kvqnc9q50W/rXvo6pXIciaX+t9Cf8kc
 f9G4Ccd5dfHi1D7rM4yAdFfUsRBZ98k5Eeoxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551339; x=1698156139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRwFKiWyNWcFmchNMwoj8QNJVOkM/6VnLmon0rzbdJU=;
 b=pQFVk1QPWO4vZUbNBnBRbYmHkLo5Orua6CoE3rVlagukg5aEbBfc9rK/MJnBFl9abK
 pyB6OsZP0Xeoj0obXn2upD7ACUorWetqNK8c7xLu6cptvJqVKdz0hB4Qx08JwHsNLoNk
 G4v5Zr9OvLiJM/RTSu6dI+srV2r/rEypyoe3V9sfuf/A5DGBOpTxeHVA6Jra/qazron2
 hDrtTUkzt7v72Jtqzz8Ae98aawlPQe8TKZRFYUT7dHUXILTMcfV/MoeZyVFy8PExFkW+
 fUNdiRqzT6r3OPa0EdKFP8++9qYmTXpFYdb4/J3IxceVEKsOUXHDpU5ohsE2CBC4MgO3
 +Xtw==
X-Gm-Message-State: AOJu0YxK4w040osYtocqH9vugnxHF/4CSUe9E2utJFHh4QS/YvPCYOcG
 L2/N0fZ9SbJKvIJH71XSdzACIn8n8jY76TmA6EG+Xw==
X-Google-Smtp-Source: AGHT+IHfPAxOWj1kIh6+eD/WdbhifcB+GJNQduCXgwoseNM4afe7mgv67uvFOVUpzEhIvibNiMTwbg==
X-Received: by 2002:a25:ab2d:0:b0:d81:754a:7cb8 with SMTP id
 u42-20020a25ab2d000000b00d81754a7cb8mr2242036ybi.65.1697551339133; 
 Tue, 17 Oct 2023 07:02:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 p137-20020a25d88f000000b00d748501d9b4sm536957ybg.21.2023.10.17.07.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:02:18 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:02:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 14/32] bootm: Allow building when cleanup functions
 are missing
Message-ID: <20231017140216.GW3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-15-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IV3icPI2uFiDhSE5"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-15-sjg@chromium.org>
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


--IV3icPI2uFiDhSE5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:05PM -0600, Simon Glass wrote:

> There are two cleanup functions needed during boot which depend on
> CMD_BOOTM: bootm_disable_interrupts() and board_quiesce_devices()
>=20
> Provide static inline versions of these for when commands are not
> enabled.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

NAK, these functions need to be available to boot the OS, regardless of
command line existing or not.  Unwind things in the other direction
please.

--=20
Tom

--IV3icPI2uFiDhSE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUuk+UACgkQFHw5/5Y0
tyyNfwwAn9c2n80eULQ4pr1+Je+VcWv1X9cUBiuCFQbRUOdxuiuO2Jz1eegwR8vE
EgFtJjjaH4caaS5fhbGboAPeioeALQE+DfyRCfHc8eUY+6CNnyicmAQnnmX4qKy/
Tco0XIkPyDqw0ShIxupgHbspiDVf/YBWLpB1d1KQOVd4hnKepgbsxXduaMyB/84J
P0TMH/YnidamnC1sRi6H/JGXrNt9463yD228kK/joKdCjrJWk5QoAvjmCjQM3ZFS
WnV4z1LZy0UKRRWi5bCbBTHw1R6L/ITz9WW59EXr87v6TWdhHRBMNZ0kDHEJH+6V
qoyvyNc3xd3TvyceAJvWiJ0QTdqSjMoWUWCnxBR5tf7WzVkwyvKWEYA6VMvDis8Z
oZeDV503RELTsRL0i97aY8v3VzPsAYtysi9eG0enBvqeuA6+mPAJF6BxgSbPe8I1
emldKKI1CF/Kj0xANHk2kh9pvwzdC+Wj4RXnmGxchj+HyMQ/KUY0MyqQT+NDYqzu
Sa6SLgY8
=cDQV
-----END PGP SIGNATURE-----

--IV3icPI2uFiDhSE5--
