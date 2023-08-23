Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBDEEE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4426D864C1;
	Wed, 23 Aug 2023 16:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IsUeRRNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06E7864C3; Wed, 23 Aug 2023 16:42:02 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E896C86403
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59231a1ca9eso29401127b3.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801719; x=1693406519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yz0Ca59e/ePWZdJYp7ubjhTpzv2o3kHBOicDy1R6/xU=;
 b=IsUeRRNkaF8WpfyLVMw7c8RiJPm2mSuWRKQyiO6q9uceUZ+Q3DXvaFufHHpXyvc+Gv
 CoBGuUVNGOX5Z+AgkErGw9p2bu/Jazcl/XVD1seYu4SpiAgfg+wuX+yLP5iyjwYHKduV
 WVl0B+JQqBNjAvnNa2zvr5OpLismOBmgXOdlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801719; x=1693406519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yz0Ca59e/ePWZdJYp7ubjhTpzv2o3kHBOicDy1R6/xU=;
 b=cncItQQm1f7JMOJXawQNWgdtwfwiAG4e20JI6GN3KQBcLZ66w2NrBmJmJYMmSj/v2U
 M0Bqh/qMpr1KJasdQr6xY2XlIfGjiQRbsPfSzAIXzeVJIb7Nt3LINYeQ7i4trVY2/WSu
 COhUgE52vSzTLqmdvuWUjaOJW9Mg5ZS9vJ/iNbt5oWceeLLPK0HvN3GuRAcCrqT/NCNV
 LpNmKPDb1Q3UFkdXx9Z380hS1zT8AqFDdDKYZgYu18NouRqLNNrhm4wkWNSCdGuIv/o1
 IUf2EAy2cpS8ZkHi0+RvzKyDSje4eSjbky1TvPSlq4c6VNxS4HlHUBQgE/id4RSDEz0O
 WAog==
X-Gm-Message-State: AOJu0Yzet9vVWPSnhkuw2eeClUKjI//pFfFjQamCpXpnJxod8Yl/MfZp
 ItMlUxxWVvUeF4F4eChN4TP1NdtyyuNIJ+gGGSUsGA==
X-Google-Smtp-Source: AGHT+IEvMd8EA1hLipHQf3H/RRpNFxsAcYbc32bQSZmo1f+LfsxaIyt09xZO8AWBPV3kxqeihnWrdg==
X-Received: by 2002:a81:c211:0:b0:576:6b83:2466 with SMTP id
 z17-20020a81c211000000b005766b832466mr12589408ywc.25.1692801719702; 
 Wed, 23 Aug 2023 07:41:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 p188-20020a815bc5000000b0057a6e41aad1sm3336737ywb.67.2023.08.23.07.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:41:59 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:41:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test: acpi: Handle both 32bit and 64bit ACPI tables
Message-ID: <20230823144157.GR3953269@bill-the-cat>
References: <20230813012559.361067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Er/astJpDXEP8F9q"
Content-Disposition: inline
In-Reply-To: <20230813012559.361067-1-marek.vasut+renesas@mailbox.org>
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


--Er/astJpDXEP8F9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2023 at 03:25:59AM +0200, Marek Vasut wrote:

> Handle both 32bit and 64bit systems, i.e. sandbox and sandbox64
> the same way drivers/cpu/cpu_sandbox.c sets those ACPI tables up.
> This fixes "$ ./u-boot -Tc 'ut dm dm_test_acpi_write_tables'"
> test failure on sandbox64.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--Er/astJpDXEP8F9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGrUACgkQFHw5/5Y0
tyz4rAwApHKYJllI8fl2G3x6v4yuoXm3wlQi1tf27K5jBH+4eh8M3NOdRtY46HmM
JeQ33y0mATdEIL8t8E16HVfXtNNaXmpHUsYNz0QFoRg+/M8SgG5GOkJiDdldgzWs
cq3AWDsLaA3NjCyX485JoZ8eKGn7leWKJLngy9wPhDg4NORQEtT8KGeBCayxLV4f
3zCYafzt8mpnvWl1jmNuLpfEALIs95VqSKMjiPEMlBZnKU3JChFNRanSJtcNmSo3
wZHF0bW4jMEFvX+4SqMr78fFapuoaATn1EAvpHPE2CeW0X4c6Jef+QYoFrjMT7P3
iO8d9kDk9hfhMkO6IY8U2ewiEhsn7p1Xwvjc4ITi5PI4mmGSuHMdyksNHk+YpXmB
qhLKGiNqnOiyRPQnUnjf3A+3CJuLOzopmLML9lUreuvyeppycoHYSpHJD4I3paHs
h4gJFkoodoUwgM/Xe9dDzZ8fajZqlV2Ga4CIT5G+ZM+PUy8J0vELnNaErriExfni
ReShyvM3
=JunT
-----END PGP SIGNATURE-----

--Er/astJpDXEP8F9q--
