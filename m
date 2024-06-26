Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D829C30658
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B394487FCD;
	Wed, 26 Jun 2024 18:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QEJX24QP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFA187FED; Wed, 26 Jun 2024 18:34:50 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727DD87F33
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d564919cd6so297618b6e.2
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719419687; x=1720024487; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9hZyMQfy1YQCzhFNQdEiZUjobF2yQ9LNAGhpWxdeUVc=;
 b=QEJX24QPSCzA2/xSa4zPECWqpV2YV/AVRRRkrol83iFy9+2ZpDJbA5VG3xAmySz/wz
 +6T1R3zp3nFUbuJIlj8uqjgNay0czAKKYj3mCBLPg7WZPrCuj3qgsbJfJ7Am9dRbsnj8
 3XNJY/HkipWksByCVK+3AO7KQBFoYf0fnA/kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719419687; x=1720024487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hZyMQfy1YQCzhFNQdEiZUjobF2yQ9LNAGhpWxdeUVc=;
 b=EkQpNhb8YrJcrw4umSoymE5sPFLaAvtg3Sc1CF7TcGWW0T0osv2nJhPGXkJxEwp+eC
 8bf9M1VIxJ6982J6T7G67/AYqj2Fs16f8oh4TJKOEBQ2mOKLTkvEllRU2F5EsBiqIaIZ
 7V4xTzPH7ivuPR4vkGqaK4UXEgeUlNXJ9pNc1MYWOfh/kuUTwkBVEq1p4IAZc2xnCo5c
 R8hfVFJiNtJRTW6mdNFYJEbBW0yzlKisKjXBwFZdf4bk3fds5x5CDx0CBUznQhhiffk9
 7PG6zyhtR10zFQ+H8ucSVNLrNcm4YgNz453MffYzxA9Pabe6ToWRTbeVgWt2Og39O5TU
 dDdA==
X-Gm-Message-State: AOJu0Yx7aML7UPNmXLrXmS3mFINGdyQ5p0dxfZb4bY5Bvez05xIBm5UH
 H9V3xKZJbI3YGwQEYtPffxi9j+rCI5KR01DTB4slAgk+RWaev1GChSQ447dAvCk=
X-Google-Smtp-Source: AGHT+IGKo4P9MChtJ9hgHQYh6nbj09H5tA1MB8rGzRlTFPD1+X3sQVvxsKMa27dVG2V3Q6d04CFn0A==
X-Received: by 2002:a05:6808:238e:b0:3d2:4684:e50 with SMTP id
 5614622812f47-3d545963782mr12488122b6e.7.1719419686543; 
 Wed, 26 Jun 2024 09:34:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d565b7dcfasm24118b6e.40.2024.06.26.09.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:34:46 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:34:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 huang lin <hl@rock-chips.com>
Subject: Re: [PATCH v5 00/16] Bug-fixes for a few boards
Message-ID: <20240626163443.GY38804@bill-the-cat>
References: <20240626155945.278640-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TO63xuYqxN/Z3+JQ"
Content-Disposition: inline
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
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


--TO63xuYqxN/Z3+JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 04:59:29PM +0100, Simon Glass wrote:

> This series includes fixes to get some rockchip and nvidia boards
> working again. It also drops the broken Beaglebone Black config and
> provides a devicetree fix for coral (x86).
>=20
> Note that since this series fixes bugs, it is targeted at -master
[snip]
> Simon Glass (16):
>   mkeficapsule: Add a --version argument
>   binman: Collect the version number for mkeficapsule
>   binman: Deal with mkeficapsule being missing
>   binman: Return failure when a usage() message is generated
>   binman: Keep the efi_capsule input file

Can you please split these out from this series? At this point in the
cycle I just want obvious regression fixes.

>   nvidia: nyan-big: Disable debug UART

This is fine.

>   tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
>   x86: Set a board-size limit for chromebook_link

These two combined are fine.

>   rockchip: veyron: Add logging for power init
>   power: regulator: Handle autoset in regulators_enable_boot_on()

These have acks and are fine.

>   fdt: Correct condition for bloblist existing

I'm waiting for review tags on this one.

>   spl: Allow ATF to work when dcache is disabled

This is fine.

>   rockchip: Ensure memory size is available in RK3399 SPL
>   rockchip: Avoid #ifdefs in RK3399 SPL
>   rockchip: bob: kevin: Disable dcache in SPL

These keep being iterated on?

>   Drop the special am335x_boneblack_vboot target

This is fine.

It might be best for right now to split out the patches that I've listed
as fine above, to one series that I'll pick up today after my current
queue of next testing is done, another of the binman/mkeficapsule
changes, and another of the remaining fixes. Thanks.

--=20
Tom

--TO63xuYqxN/Z3+JQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ8Qx8ACgkQFHw5/5Y0
tyxjoAv/VIipHmJ4796JASXh+8XQDSFU0E3XNCmsbRxTM1T+hipHymjgjRPOQ8Fh
S/lRd53AbsemEwx7g0MITgIDMwBN6mv0uCV+VbuQ82LYke8X3Ik2/iv8LhFeLXOI
6Rmtf25oOp/Eco1g5tpzT+bfcdBbQ2Ijl9Qd3tdZmt2sDLLJ8veJHVN3LmL7bPZI
3/nr0j24oR7gnyJIl4kphmK8rHsatSZtC6rjwKcIJCUD1w7Vj4QCA5viVNsqqGze
PYN82913tHqNHgC7BYROJGiUZQrLOAY7WIbmrDtXkOaaYxD57dPkX4weQe0H/N67
y+b1eDGBdPILmKApgBYVjOpWG3f2jE9+bdr/4LDDPmZ+ng0Mz3pN6YL9fjasUElj
CScLWzvHziPSy+g2ya3XphwoPhP+w/ZGBg3jSQLFPTvtup4q6oAmmdXR1dspX06M
jQqDBGG4C+UMrRPeKRGNTxD2JZoQQUT/sW0iLC1pb80AxHviwirFC/oHe/krgfaX
xDs0hwWP
=zBcN
-----END PGP SIGNATURE-----

--TO63xuYqxN/Z3+JQ--
