Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957FDC47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 17:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FEC876C4;
	Thu, 11 Jan 2024 18:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DOlFKux4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA15587885; Thu, 11 Jan 2024 18:18:19 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CAF587620
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 18:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7833b6bb41bso119911385a.3
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704993496; x=1705598296; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LEO73EOi9OiNBoalw4y9eQA6U0uCQ1hgUmoTmFKW+4k=;
 b=DOlFKux4qrnyz1+z9G8XQf04GU4SFrSdgCNB5uyr4Qe9QQ7wnoumalWC1JPH1YbnxN
 N8yG8JYcC696oiipZm+LAu6NyvBF3+NxLvVwjsL3kc/lYl8mAL7rlmON776L6yd/hSGE
 1vkP8rbQusgyyCx+rqK5oa33xVliWDHGx1gGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704993496; x=1705598296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEO73EOi9OiNBoalw4y9eQA6U0uCQ1hgUmoTmFKW+4k=;
 b=pcos1szZOZgB9mS5ThzEhe/5i5DQhl9Ccf4GPDMO82OfKiPofej38mGL7x2s040rkS
 K7o54zv1a4/PRU4AHkmEee7VfnxRowEMNXIMuLPBcrQKfHxVtWihfMS1cE7bRPKhCKhK
 Vz2oK13bTKg+TR3JcHCOg6B87rjhAOC8DUEhNsZCIqr6/sEacALurBSUa79S4nAdIB3y
 IILQ4zR1P3435C9uHayfIo7x8CJScO/zXBdJlW392B7ufiYyfwra3ErPFkaILI5/qDXx
 vXqumFvG3BHF8ZAcMXAjORIBQuHkxsaUT7NgsQs86F6DPm0NXOb7vGx0MRD7Q+ZY+kF0
 F31g==
X-Gm-Message-State: AOJu0YyQL6AYpBH36MGpIRTx7apHjziUb6doOqsRaumKrs53We1EBGAC
 2FePO49pyBKLzDjn/u5To+RWfEJjb2KxSln4zIofYMixO3c=
X-Google-Smtp-Source: AGHT+IEcCwwkJap3QnH0bCbVCWdNS3wcoiA38TohNZenXNNCm4xOYwBGSCtE0NfP9zRp+h9eAuwkZA==
X-Received: by 2002:a05:620a:2404:b0:783:1a11:5efc with SMTP id
 d4-20020a05620a240400b007831a115efcmr147212qkn.42.1704993496146; 
 Thu, 11 Jan 2024 09:18:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05620a122a00b0078321b70b05sm462167qkj.101.2024.01.11.09.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 09:18:15 -0800 (PST)
Date: Thu, 11 Jan 2024 12:18:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Anthony Loiseau <anthony@loiseau.fr>
Cc: u-boot@lists.denx.de, Anthony Loiseau <anthony.loiseau@allcircuits.com>
Subject: Re: [PATCH 1/1] get_maintainer.pl: slightly modify penguin_chief
Message-ID: <20240111171813.GJ1610741@bill-the-cat>
References: <20240111165127.12882-1-anthony@loiseau.fr>
 <20240111165127.12882-2-anthony@loiseau.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dH+nNIm1RpzCF7IG"
Content-Disposition: inline
In-Reply-To: <20240111165127.12882-2-anthony@loiseau.fr>
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


--dH+nNIm1RpzCF7IG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 05:51:27PM +0100, Anthony Loiseau wrote:

> From: Anthony Loiseau <anthony.loiseau@allcircuits.com>
>=20
> Penguin chiefs are actually stripped out from get_maintainer results unle=
ss
> --git-chief-penguins is provided, which appends them to all results inste=
ad.
>=20
> This is a issue for U-Boot since Tom Rini (penguin chief) is also maintai=
ner
> of some sub-trees ("ARM", "ARM TI" and "THE REST").
>=20
> Hopefully, this match is performed case-senditive over name and email,
> therefore upper-casing Tom Rini last name workarounds the issue.
>=20
> Important note: This also fixes "THE REST" catch all section resulting
> in Tom Rini listed as (maintainer:THE REST) for all files. Hope there is =
not
> too much developers scripting their patch email header from get_maintaine=
r.pl
> output, otherwise Tom Rini may be flooded.
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Anthony Loiseau <anthony.loiseau@allcircuits.com>

Given the explanation and links in the cover letter, this seems like the
most reasonable path to me, thanks.

Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--dH+nNIm1RpzCF7IG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWgItIACgkQFHw5/5Y0
tyy56Av6AsBlTGkoPanurRGqjD2yNYcQfvN8DsuuNlximQ1OJXr3MgunstU4Wpql
B2zIm0lmA4KgOnKzB8YcCnt8SPjbAvLNxdkSdL+LIbCUvwhV5iqFiCFUSiFaG9Li
zcLUw2tdSdN2SW+ONw86v62Av+WnqXvhHYoCXPi8292jgbw460aj5ZdmRg3DxcFF
Cpfd1eCscxVlawZzn3IYvVjWH178EivPnP8wyhoR8Ilho+zlS1P3t8EgCS0Kz3Y7
MZtapJWxwtflj/wIpHm8Xt1j1ut1NXDdaTS0ctTB2PObB4hgrksrBVOvWA9z3LLJ
hLKsbVDfqRreUuYLFC0tEL/4Lyp/CrWoxpPVP6Aen/uZW+2xCTFBvlFOfTz9pfBP
B7RxVrvyxl2+2fUnXRqyBWoqEwUgnGN7nUWbGKc//W2VX6rMpphV2iXwAcZa2Urm
vmRz95mqhSDo2hTMvDdqhzuet0Uj8vsJ+g+IcLk56gcdDi/12sFOaKZ0v86UAcVG
ettY8nc+
=UMSB
-----END PGP SIGNATURE-----

--dH+nNIm1RpzCF7IG--
