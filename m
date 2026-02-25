Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3159AFD376A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D6B384062;
	Wed, 25 Feb 2026 16:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qrGaZ1X1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9822B84065; Wed, 25 Feb 2026 16:11:37 +0100 (CET)
Received: from mail-ot1-x335.google.com (unknown [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4603484064
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso7152338a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772032251; x=1772637051; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zD1QGddwmfeh6Ju0wv1bxMncOVtCHWu0FgMos/5F+GA=;
 b=qrGaZ1X1bOg+ZNVygfUmkirDZHCjkNiQgdFqg0jXIepH6IM+dMS3YKZu8aatWOHRNb
 qrBNuKJKpIzDU6fWMW1P4DrCdYj33PzFKd7yiqEcqUlYmAIAEFI0qPZC8DKFIPLkb/MP
 Bi3tYSO3JOBCGRYoGPIiGQvduf0NrC6b6vjPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772032251; x=1772637051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zD1QGddwmfeh6Ju0wv1bxMncOVtCHWu0FgMos/5F+GA=;
 b=XfuOz1cbN+IsGzG16hn7fDac3b2B0A/XJ5b7BCldasiO2IdcKyXybfjWVEueufr+VL
 612GXnc2+aHUm+ZjYfU59JdTWUAiAB6/LwvCo9EtPQ7UJCl21tlKh6m0IOD5am++sW4b
 nWB5+88FLYnDfsse0iWrUl0HjoT7NA15Vt0tnioLPFzWxDoIcLgZcaT0waBFxdmYblr6
 l6GcoQuPgYE6hS8NWlKA9hb/WJKHhbIe1h+zW2Gl4FU7oGGrhGqrZj8CB/2eU+jAwqOR
 mRid9POpc6d2SxFMV3L6XIHD7QzDGTYcUeXOkuRKfxwc+M3gMr6GN9LThJFFmhW0sPla
 cQ6w==
X-Gm-Message-State: AOJu0Yw6UO5v/V4/X7CbPJmmJKGBAzVlRu0TvMS/gmFbIFVtN5oqY6od
 xYVwvsiZxGz73HfFMfLySd8qjunIuSirlfBWH4T+I5RXbg1+q6oEElgCiR/zH3Ehb54=
X-Gm-Gg: ATEYQzwlAk7SuIkydUQzP88BzpWvDfaK5EfNQER0766ikPlA5Kcq8zUQ0Su6eZvaOXV
 qwFcsFhz7aNcIRCNvM3zScQVRs1AXd+BiEcbICQ3+l3qYPRRD/nTrKgH4Sz17HGt2bBI5Y4QdD8
 doFKUx+FR9OFDryb6Ww5HI+vzC3iko71a1PzKtn0donOJVi330mitrSBM7Bhu78GNrb3KbLEfEJ
 QF5JKmLxrp7x2vsOj6s+J+gGguf5cJ2vZG6MMgfQLeBDDixWq9XmzD4gCYpZxAJNeLiSK/X7slO
 UuOSnq32c690yCT0l9lBuFSY7zWnumYoIsK6aMuCcJC+OBHxhCcJCHQQvwp3/yMOsrNnbzqiCFY
 m5UnDSDNpNtI/hriDHcLwuA8u8/c47LGY59iXVimUrvWrzLq6KvrJ3ekVBoB0g43blAp+Y5P2QY
 weeT3TP/UWIeYXWq0yCSrA10yrDxxQ/DvhJg/c8ilWbME8httXy/MalC9SfVPktWc9alEjiQwT3
 gTwv8lup4KbPyq0m4yq0J9izkMpNdvzO2G3zt9ZGIQ/TQy4tqQ=
X-Received: by 2002:a05:6870:249c:b0:414:64f2:398c with SMTP id
 586e51a60fabf-4157ac74d6dmr8401805fac.13.1772032250573; 
 Wed, 25 Feb 2026 07:10:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfa6624sm15160973fac.8.2026.02.25.07.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:10:49 -0800 (PST)
Date: Wed, 25 Feb 2026 09:10:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Sparsh Kumar <sparsh-kumar@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, praneeth@ti.com, bb@ti.com,
 afd@ti.com, n-francis@ti.com, vishalm@ti.com, sebin.francis@ti.com,
 d-gole@ti.com, a-kaur@ti.com
Subject: Re: [PATCH V2 0/9] board: k3: Sync rm-cfg with TIFS v11.02.09 firmware
Message-ID: <20260225151047.GJ1593142@bill-the-cat>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fjMc5HGU1SHyX/zh"
Content-Disposition: inline
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
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


--fjMc5HGU1SHyX/zh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 06:54:16PM +0530, Sparsh Kumar wrote:

> This series updates the Resource Management (RM) configuration files
> for AM62 family devices to align with the TIFS v11.02.09 firmware.
>=20
> Background
> ----------
> With the latest TIFS firmware (v11.02.09), an additional virtual
> interrupt and event is reserved for MCU cores to DM usage on am62x,
> am62ax, and am62px devices. This series brings the rm-cfg and
> tifs-rm-cfg files in sync with these firmware changes across both
> TI reference boards and vendor boards.
>=20
> These changes are backward compatible with older TIFS firmware versions.
>=20
> Additionally, the am62x platform was originally introduced without a
> tifs-rm-cfg.yaml file, unlike other platforms in the AM62 family.
> This series addresses that gap and enables tifs-rm-cfg in binman for
> am625-sk and am62p-sk platforms.
>=20
> Changes
> -------
> TI reference boards (patches 1-4):
>   - Update rm-cfg.yaml for am62x, am62ax, am62px
>   - Sync am62px tifs-rm-cfg.yaml with TIFS firmware template
>   - Add missing tifs-rm-cfg.yaml for am62x
>   - Enable tifs-rm-cfg in binman for am625-sk and am62p-sk
>=20
> Vendor boards (patches 5-9):
>   - beagleplay (am62x-based)
>   - phytec phycore_am62x
>   - toradex verdin-am62
>   - phytec phycore_am62ax
>   - toradex verdin-am62p
>=20
> Note: For vendor boards, this series only updates the rm-cfg.yaml files
> with the required interrupt reservation. The tifs-rm-cfg.yaml files
> cannot be updated without access to the corresponding SysConfig files,
> as both rm-cfg.yaml and tifs-rm-cfg.yaml must remain in sync.

Do I read this right, and the vendor boards will now be broken?

--=20
Tom

--fjMc5HGU1SHyX/zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8Q9wAKCRAr4qD1Cr/k
CsuoAP0cV/HGLk8tB6sSHWKsaqcll6nk3RtP1U9Hc3QD0dZkIQEAvyAfAzgh8F/M
e5QpYdvuJvQdJfRCYYDPi822aBXdZwg=
=HktU
-----END PGP SIGNATURE-----

--fjMc5HGU1SHyX/zh--
