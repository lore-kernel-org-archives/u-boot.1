Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F293CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 15:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75008323A;
	Wed,  3 Sep 2025 17:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T2KSUv/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E779683280; Wed,  3 Sep 2025 17:17:14 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFC8831EA
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 17:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-31d6e39817fso15765fac.3
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756912630; x=1757517430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dokRrz3USD/bVEsfx18fjpY6tEkEqwKf/l4TxU83j58=;
 b=T2KSUv/sJB+RJNgUOP7U2ppn7LdQ1lva1lIRcvjdi+5qQJPehXV0tGwdmyiBDGz2Se
 D/xiIGc/zsyr1BrcM/5P5a+T6sm0M0Gpp6ZxYez20rL4O+2qopt+mE743eCe0qTUXW9e
 ttpWjlzjdor8/6NBkAGqzmRMx0FzookjUndzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756912630; x=1757517430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dokRrz3USD/bVEsfx18fjpY6tEkEqwKf/l4TxU83j58=;
 b=MrctfRGHwOaEaI+jnZLimDrLH4B7VSs6NPIDcnSjgY0vcM4cMS5EwwYauheMUApFwM
 VyyVd52okPx0dd/FsM+p91jXm8ijBD+cuVEPcs+aJ4puo+8/tWwEuTD6XsEhj+Sz7M6c
 Ozjb2zXN2BwU4YnR5yrf8Pc6eR2taGIcbto+q8KMWu1ajwgWaUGWd5CCko4vPz2w7ddW
 RioYTelwtfHGx1/wX5t9VsKcQDQRF4PCyc890jC+z/+gTqIEOzQZDHdUbMP7ufPLHr0V
 R0xxK3t4qYQ6t0GTs3gKSSwRImH+r02dAYX2p8KGiQ5wN3VNjQkg+LTkFREd4ktjgbLh
 0sFw==
X-Gm-Message-State: AOJu0YxXQY0TK934HTVTlPi3AoR2D9b8ZX/Mp9HtO/AH/beQMOyxz7Xk
 /CkpFOCPsH3wTDShloddn7zZPtWcOkZWwt8QkjSi57Ti3tuurEApe3N/JEbTJK3SPbY=
X-Gm-Gg: ASbGncs51Z7zMlqKd6Ng0WVjVfcxrRD/Y1Bnv/im1QRCMAp4GL5kYcSjcDfu1rjsARo
 9dz7l9oJ/CPCIU6AM2bzUtLezqtK/QuL69u0M/GWOPcoJzOSx+tkijnqVA/Fc2ngy6o+bc+IXIF
 yKla3JyJhhocqeh20PUPZMH/jWjOAECNH7N8VM5qMNN04sOEiPtrodOliNEjaZwmU/2LPUCBkrE
 wlO1rPGNanzcK30/huBuhBpV6IglRZyQomEf1/Mg0h3V+YuYX074r3uoTcXqVPzoAo+AdLZyE8m
 zINGA7kHcDKlg6uehpDBRfItqihkkTIuqcXy+LHQRTBVyEABZ5L1ShGw9Wouu5rdQt2qLydCnFz
 5y5rkTb302Iy36g9k1SfenMpqctj+VRd4xA4e6dUioEfyiEmwyszElSO0
X-Google-Smtp-Source: AGHT+IHFtcDHFwgmS9SfCaFvvGsaMfJCS1JUUuS7yJN0l4idBheuQ3oS2Y3BIjMC1XQJFs+GCYv6TA==
X-Received: by 2002:a05:6870:82a3:b0:30b:bb5b:8d8b with SMTP id
 586e51a60fabf-3196306aademr9879958fac.4.1756912630034; 
 Wed, 03 Sep 2025 08:17:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-31d6b4c05ecsm317368fac.17.2025.09.03.08.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 08:17:09 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:17:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2] env: Remove usb_ignorelist and env_fdt_path from
 ifdef CONFIG_ENV_VARS_UBOOT_CONFIG
Message-ID: <20250903151707.GG124814@bill-the-cat>
References: <20250903142101.90350-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8XCidOvr9EtnMS1Q"
Content-Disposition: inline
In-Reply-To: <20250903142101.90350-1-marek.vasut+renesas@mailbox.org>
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


--8XCidOvr9EtnMS1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025 at 04:20:52PM +0200, Marek Vasut wrote:

> The CONFIG_ENV_VARS_UBOOT_CONFIG should protect only U-Boot
> configuration variables in environment, those are arch, cpu,
> board, board_name, vendor, soc. It should certainly not hide
> usb_ignorelist or env_fdt_path from the environment. Fix it.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8XCidOvr9EtnMS1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLhb7wAKCRAr4qD1Cr/k
CjjBAQD1eOK9scbXtS7PYZpefj+oxafrZEslTaHdBG066Nf2xAD+K+mB7Kg2QXyN
DoUGG45a+14D7PIB4rF7fD713L0NhwA=
=58Dy
-----END PGP SIGNATURE-----

--8XCidOvr9EtnMS1Q--
