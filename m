Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49462FD8FD6
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2DE83F1F;
	Thu, 26 Feb 2026 17:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y/f09iBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BABE83642; Thu, 26 Feb 2026 17:22:30 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59DF83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d513bc15c7so1217726a34.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772122946; x=1772727746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dur79IPJa2/SBPHl8gOY3FGPNBpZDwpejHRClEtQmy8=;
 b=Y/f09iBY4UN6hbn8v8P+GlkVYRvFdvlVOvKBKiLb40AcuirQ/MwXasL8Sfj9Iv7gxE
 7zs1fh7S3vvB5ugwDNle2PUxR9K5dIgEu0l38i0nuDAY2nDyEdlQY1oqy8YGmgeImimb
 o0B8kwq7NHuGXF7zfFTfsnTz7yWOu4O5XTHD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772122946; x=1772727746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dur79IPJa2/SBPHl8gOY3FGPNBpZDwpejHRClEtQmy8=;
 b=NmDytd9A9HA3iSzwjeSURq6ZDXPpfJKUs3wXcQYKVyRLow9J6LjRMF2+/XSc+20BKN
 kIKkB//OZ8iEaRNcP8eKxLkgMxoWOMUm7xCnTHVHruNYd9EhZF48Ax40vlHZ25hNiFj6
 A7StiVSCZ6L6wtOxg7TKHg+ULYtmaMAg6y42I4ILbnnh2pWRtwAjVWtkqDJ6DxBDBsG5
 eVUjny76qIHZbmyP27LBXkijZEtL9exenQ+VE4J5H3MMcT8UJodFPitos+Max+QRsLX9
 +yrggZ7ruMYa6r9OKRJ9VH4mzEGkIuSQCke40+fMAg5S087ESNfyDidZK/P9034v6iZb
 2FUw==
X-Gm-Message-State: AOJu0YxBBGbHO1Ky4nspNwWqkIX/Ntj0EXdVcj3ssZCAIsxMLOoBHkEC
 35mdueh6wneRETygLtUxJix6l3ikEGEceXDMFeADsYL0MYSK+UGCIc+T6VncbcJeyW4=
X-Gm-Gg: ATEYQzyfk1oG0GZHYflt+q8MJEazvUPStx+ihgr6+U49l6rBSVRQpXNOti4CJ+wwQVQ
 Zmf0PTEUPwDWHcFEheJWzvNudma/1ZuXG1fcXC+9dQnWFQiyP16VkTH1OpVlH36aCyjYGfpMMSH
 lK/fDoVA4iwwEDu7vwmDu6EgrJJpVWw0TZH5FHWQcQ2qNf5J9wBuKWSuMgss6xRpt7KCG2H3/MZ
 kX3FideVftTQ8y9ZDWk3TUBs2unOC8uChv4kGz0b6mW5d/U3GUOYN9/g3y30qc9hBYonXf0e3Pg
 XdtD2I1MuVFLq0Onf5Wbk2gFGSAuAGYyxvvw6qdwqvCCh2gPcIaXQZxgSNjpIDd/4b00gQNdoCO
 W98Kx7LB2MmYICr5swJdOSdbTAOXz/c1KKc71FPKZ7Xzya3WiJDdxQ9gWX4idpGPirV7sR5JL4F
 KXBZEH8pwwzWY6EXpBpsv+X4NkDHtplQsfX1LHalmKqiC+7WTQVUX2/S/AUlb+hytvKoJuuQJbJ
 zuYnpoyYsGVnOTgEskqMtgXyMNMnyQI5p7/ACQtFlGYBtWNlM4=
X-Received: by 2002:a05:6830:61c4:b0:7d1:93e7:cd6f with SMTP id
 46e09a7af769-7d586e9bea3mr1491717a34.13.1772122946372; 
 Thu, 26 Feb 2026 08:22:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5866541fcsm2053487a34.21.2026.02.26.08.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 08:22:25 -0800 (PST)
Date: Thu, 26 Feb 2026 10:22:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull fsl-qoriq-next-2026-02-25
Message-ID: <20260226162224.GH1593142@bill-the-cat>
References: <aZ_BtG4flBy7oN-N@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m1r32Dtf/aqHP910"
Content-Disposition: inline
In-Reply-To: <aZ_BtG4flBy7oN-N@nxa18884-linux.ap.freescale.net>
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


--m1r32Dtf/aqHP910
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 11:44:52AM +0800, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull fsl-qoriq-next-2026-02-25
>=20
> --------------------------------------------
> For SCMI, Power Domain and IOMMU,
> validate device tree node before continuing,
> to avoid boot failure.
> --------------------------------------------
>=20
> CI: https://github.com/u-boot/u-boot/pull/874

I rebased this, carefully, to master because we need these fixes for the
April release. Thanks!

--=20
Tom

--m1r32Dtf/aqHP910
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaBzOwAKCRAr4qD1Cr/k
ClpBAQCn5bqwkwsBcGtjj1LCZvwYeXnHkkB77vwHkTu8zUmWkAD/c3CtP9eyMkLK
Nti5OjJz1PpCI3x/iWpu9ZRk3B13CgI=
=dPjF
-----END PGP SIGNATURE-----

--m1r32Dtf/aqHP910--
