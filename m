Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB794C5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 21:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 856756077F;
	Mon, 10 Aug 2026 21:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YcPiKMBlD54M; Mon, 10 Aug 2026 21:32:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A05860774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786397553;
	bh=Sgf2raxhuz2PGFm/5TEXVpgQRlJtEB4Tk7tOJMm72DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cHYKzioMADW4KeW6AdoHyV2q6DCbDDmtCg/2rpcuYBLAyostJxOht6fjd/Wb9ODRV
	 Ci63zJ5f3QWKCZs4ZSC/KNfrv66yOVs3vGwhOT/nNaB5KsQT2lDDcaTj0lIbTh+B/8
	 i5ufOlAyzGSF259/nzP+HD36dno8gwuWmRh6tzUFJQPZvL+Wr5snPfdIQUeS16JzLW
	 1WgsxR4O7SrA8Fmdv7RWWOC7uMSxrj714YB3rcuLvpbdTH6hyPAMPMPyEyV76DebSv
	 TKy2UaROwz7cNqlqwjRWdTMIcUWBroiy3DLWDCLjSJMSCXVG0naGUKi/DhHqhH4s5Q
	 k/nVhLA2wA0WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A05860774;
	Mon, 10 Aug 2026 21:32:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D9625218
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B59B4406DB
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-RyC2vL8woJ for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 21:32:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D59F3406D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D59F3406D2
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D59F3406D2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:32:30 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-45133d2974fso1332379fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786397549; x=1787002349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sgf2raxhuz2PGFm/5TEXVpgQRlJtEB4Tk7tOJMm72DY=;
 b=NGBq4iLRtOo0u+RhmvpBJaV5/qW6YQEfQdlIJvY8nCMXJYbKM2LwkWhE78nFopBDBc
 Rdl4LeZGpQaF6MY6OQB+g41poKNtHt4h4+G4TnLwUO10vOb7XWqMN0uag5Br0rHRldA1
 AOI8yagvSJjasxijbwFbgqwNR4HO4pyDdYE8z65ZkViMNfke2jQsoQ9ajrzhuoHb3BcZ
 Gsu1i3m7bzW08Tqugf0gp6951gLGR48/Sig7MLFVTmPtx3+PLMCxAyQt1Xis5VQc4Y0G
 ZKRl3hs4ynzDngT7zISkWDvQ4zZZITADxoep+B8jmMCNcOdhpYngwSgOQ+g0X07G3WRi
 JVjw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+irk5gygSfirFSHACgvEncMxBESthMXd6DW5LdeXvHEu7foGs98kQYAEs3BM0RemvAvdeEtI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw0E08CylH44eNa+ItqAQgGBfpGvU7g2ppdGrHNu6++KGSsBDwz
 Cr5Rk0RYl5UJIxSLETaqgFhH3E1vZuO21/f78imxSuAqoqgEP1Q+qqcPcZ28NQhnLxc=
X-Gm-Gg: AR+sD13ijhJSg+iFqkqGieOojZ9LWjpHmK0UvoOGefcJBoS/zx8WTl/hX/7S8A/nGy4
 lzUyB9p4urE3nQiy4MKa6NTzTUJyK0wkg+2ughNh5Hf3Bi1CqoM+0ZOcVmd4h2KjEAndVxA80z/
 BsA5eyf5dt+eO0uxJGScUmimdMHPkISFGosM7NZZC4KWmC4D/NXvlXIY/VvY4N2nAJwUk4z8YnJ
 LtJYbpB7c8wDgYyxQM1RHkGheR/ism4ok5FVM+ahqlvJMeumXaEKpWqW17dHA2c5CZDB76qe0tc
 1WOdYyt8nqZE6oQX/wvuNZuEBMIE8VMosXO5PXvf+vNh5GfBtCbbmyr04F+fwV5K+PQaJCt1QQB
 Cz1kzPEOYZBj+w7gpU+RkI2d8NtxBQmmqqK72SzXoSB6fsSJExIk8S8NybBIVem3GZwQHYKwk53
 qg0TzMnX8UwdtSvlwj2l7Ogy41B/fwli1FeW2lDR+5xS5BTZagVuY4bt5pWvIIcVbG7sLYYq5Xf
 FCbvwKPbqyn1RcYUQZcVh9v2aKyIM55fjMvO6OmzfPDaie9U/WUX3Pi5R1oQ1uxNs5iyriUeH7G
 vAp9T48hiA==
X-Received: by 2002:a05:6870:959e:b0:456:6097:168e with SMTP id
 586e51a60fabf-45e05a17f75mr2681225fac.19.1786397549572; 
 Mon, 10 Aug 2026 14:32:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f19fd31csm9526969fac.1.2026.08.10.14.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 14:32:28 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:32:25 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Romain Naour <romain.naour@smile.fr>,
 Shiva Tripathi <s-tripathi1@ti.com>, Randolph Sapp <rs@ti.com>,
 Anton Ivanov <anton@binarly.io>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] tools: fit: sign all config image references
Message-ID: <20260810213225.GE1160436@bill-the-cat>
References: <20260728161904.96004-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e9v4vhtOcDuxPyi9"
Content-Disposition: inline
In-Reply-To: <20260728161904.96004-1-james.hilliard1@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786397549; x=1787002349;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sgf2raxhuz2PGFm/5TEXVpgQRlJtEB4Tk7tOJMm72DY=;
 b=qX5XsW+BgoQzwLtE+Gm0mJ2YcHTyvjwhrWK+ABuRDTg0wvQPXdh9mtspAyiyHj17H0
 zsMJAyWi5YM2988E7C6Pyxs6z2ODHk65N5ofug61uPouiUYorX+6UNljQpDtnGGDqYnc
 P9qOiqNFGpfi9W6KH7eVXuvnyHvJxBSXnwLL0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qX5XsW+B
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--e9v4vhtOcDuxPyi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:18:39AM -0600, James Hilliard wrote:

> Target-side configuration verification builds the signed-region list from
> every image-reference property in the selected configuration. Host-side
> signing still uses either the signature node sign-images property or the
> legacy kernel/fdt/script default list.
>=20
> This lets mkimage generate configuration signatures which U-Boot cannot
> verify when the configuration references other image types, such as
> firmware, loadables or ramdisk entries. It also lets the host and target
> disagree when sign-images names only a subset of the configuration images.
>=20
> Build the host-side signing list from the configuration properties in the
> same way as target-side verification. Use one shared property classifier =
so
> the host and target cannot drift apart again. This makes signed
> configurations cover the root node, the configuration node, every
> referenced image node, and its hash/cipher subnodes, regardless of image
> type.
>=20
> Warn when a legacy sign-images property is present, since it no longer
> limits the signed image list. Require every referenced image to have at
> least one hash subnode. Add sandbox coverage proving that a firmware
> reference omitted from sign-images is still recorded in hashed-nodes and
> verified.
>=20
> Update the signed-configuration documentation to describe the same rule a=
nd
> the hash-subnode requirement.
>=20
> Fixes: 2092322b31cc ("boot: Add fit_config_get_hash_list() to build signe=
d node list")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - Add vboot coverage for an extra firmware reference omitted from
>     sign-images  (suggested by Simon Glass)
>   - Warn when mkimage ignores sign-images  (suggested by Simon Glass)
>   - Share configuration-property classification between host and target
>     code and remove the stale load-only comment  (suggested by Simon Glas=
s)
>   - Document that every referenced image needs a hash subnode
>     (suggested by Simon Glass)
> ---
>  boot/image-fit-sig.c                          |  9 +-
>  boot/image-fit.c                              | 17 ++++
>  doc/board/ti/k3.rst                           | 10 +--
>  doc/usage/fit/beaglebone_vboot.rst            |  5 +-
>  doc/usage/fit/sign-configs.rst                | 13 ++-
>  doc/usage/fit/signature.rst                   | 26 +++---
>  doc/usage/fit/uefi.rst                        |  2 -
>  include/image.h                               |  9 ++
>  test/py/tests/test_vboot.py                   | 11 ++-
>  test/py/tests/vboot/sign-configs-algo-arg.its |  1 -
>  test/py/tests/vboot/sign-configs-sha1-pss.its |  1 -
>  test/py/tests/vboot/sign-configs-sha1.its     | 11 +++
>  .../vboot/sign-configs-sha256-pss-prod.its    |  1 -
>  .../tests/vboot/sign-configs-sha256-pss.its   |  1 -
>  test/py/tests/vboot/sign-configs-sha256.its   |  1 -
>  test/py/tests/vboot/sign-configs-sha384.its   |  1 -
>  tools/fit_image.c                             | 12 ++-
>  tools/image-host.c                            | 84 ++++++++-----------
>  18 files changed, 121 insertions(+), 94 deletions(-)

After some other changes, this no longer applies correctly, can you
please rebase? Sorry, thanks!

--=20
Tom

--e9v4vhtOcDuxPyi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanpDZgAKCRAr4qD1Cr/k
Ci5qAQCxaszvRa+xvxS4/ZBHNf7TqyhNBZrku38GmV1Iijhu3gEA8C3zJlxakxzt
2a4urS7qcb/tCZtYw2ddKo1hLhaGsQA=
=FYu0
-----END PGP SIGNATURE-----

--e9v4vhtOcDuxPyi9--
