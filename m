Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1297C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C1D587A18;
	Sat,  6 Jan 2024 18:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iqhr3yDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE064879E5; Sat,  6 Jan 2024 18:41:36 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7189487A09
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4280e3ab14fso6020751cf.2
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704562892; x=1705167692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P00p3YwIzvDKZE9hOxMwiU9kVhEVuN915mtSadDkN8Y=;
 b=iqhr3yDAPHZV1uz3mu0NILcKcoU+X/enppjGZ7jeocwAWI+qix8HWnAJ43D2CCzZTD
 YJqGji30dl/L3BxCWpQKCYPjgO35f0o+/vPvxqO/OUNTXI52nAvDntXc0MRdesqZRiq3
 OyhHMRaotO3RltRkiu+2ZOY/fbnjzXbhwyY9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704562892; x=1705167692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P00p3YwIzvDKZE9hOxMwiU9kVhEVuN915mtSadDkN8Y=;
 b=Y2pQeowjmNyAj26CruIliMtp+FwJOAKnI4KRVgMLowkEkjZZqglI1f9LkVylTDteRC
 movfqGqQJi3nFk6COW6+5r6N4wbv5UMLqMSAItwIOwoWYJ9lp1XL3oraWKhkmmtGoFfA
 w/B9Xj3ZsSrqqAl9tG8DbhlD4ci6hpgoiR0IHyqb+6ujjF+aRWx94cNcv+FAaow6QgGR
 dMAflOVzJYDOQ+PS1J/iUbya4YNZOm2YhfXmcIFVqz00wyRBXotCajkcqmN79W0K/TO0
 uaeRioW9H0Hh1HH3Fhmzs2C+3KWEOX3LpdL9Nb398XFnUGB52DUlx9guGUY7moGbGctc
 Wvcw==
X-Gm-Message-State: AOJu0Ywc9MTj9IQFIOTXYB/zHxrAgOzOXozE09CD3Sip9k9BLPI9dRyb
 d3Uelx/GMdpMDsuq6746ieAEbaVuzeDDq5CGrk2tqaMfnnM=
X-Google-Smtp-Source: AGHT+IERtYMKRtFwPulWaJnX7FjQ3/Uj35ajioZCFWW2tB8qJA5bN+mU2La6ntow4pRexzqVEfneVg==
X-Received: by 2002:a05:620a:2949:b0:782:b6a1:cc97 with SMTP id
 n9-20020a05620a294900b00782b6a1cc97mr1651294qkp.19.1704562892000; 
 Sat, 06 Jan 2024 09:41:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 bs44-20020a05620a472c00b007815d11eab5sm1446039qkb.26.2024.01.06.09.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 09:41:31 -0800 (PST)
Date: Sat, 6 Jan 2024 12:41:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Anthony Loiseau <anthony@loiseau.fr>
Cc: u-boot@lists.denx.de, Anthony Loiseau <anthony.loiseau@allcircuits.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Stefan Agner <stefan@agner.ch>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 1/1] fw_env: autodetect NAND erase size and env sectors
Message-ID: <20240106174129.GC1610741@bill-the-cat>
References: <20231221224438.21247-1-anthony@loiseau.fr>
 <20231221224438.21247-2-anthony@loiseau.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T1ws8jTRMLMYrCeV"
Content-Disposition: inline
In-Reply-To: <20231221224438.21247-2-anthony@loiseau.fr>
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


--T1ws8jTRMLMYrCeV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:44:38PM +0100, Anthony Loiseau wrote:

> From: Anthony Loiseau <anthony.loiseau@allcircuits.com>
>=20
> As already done for NOR chips, if device ESIZE and ENVSECTORS static
> configurations are both zero, then autodetect them at runtime.
>=20
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> cc: Stefan Agner <stefan@agner.ch>
> cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Signed-off-by: Anthony Loiseau <anthony.loiseau@allcircuits.com>

Applied to u-boot/next, thanks!

--=20
Tom

--T1ws8jTRMLMYrCeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWZkMkACgkQFHw5/5Y0
tyxBuAv/dHeeTUZyPdZgbel8sTYGh32h1wvcmMMPD16M5lywrr97UPGCPmEHJiHW
IeClGELg4/iMfx05q90FEWXlA59mOZtNVP1RQ93JqmUOprwNuWuLeO7mQkUX7hsZ
lShSipj4Zpz9NFRnDGKffSK7e8SQHBT6tNpkynYLPh2jHWOROZPupnzfUt4qCu6h
6xhdkaHGf5K6Ve/JfxTGHtYCQUDBYznHwZSepRquf4trU+u8bXwgAY19G/eUuTjQ
EYJKVKLaJdLpdF8UQcH6X7NO9fvc2AJbUSVS4K1ZrKD4rlZU4QdbxTa5zxoebZ4s
YyBbtIzhF2g/6mjGLUZyGMnuizqrX7S1/i/GDoVkWsy8XbW09IFBKuFl/Oxq4BUR
15SSI0DzaSUT6Qn8cHIdYUZd/PWyBEuGCdCsOSRFBg8JF6mAAPyMGdemK6azCb73
ezgMg3adBfuGueqY1sNTZ9QceXw3y5c/QP7BpFLgEKlTpY5Vszmpt//eFYOfMzp6
2ZRiCpAV
=3N8+
-----END PGP SIGNATURE-----

--T1ws8jTRMLMYrCeV--
