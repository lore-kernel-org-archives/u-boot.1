Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC47C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 895BB88167;
	Thu, 28 Mar 2024 16:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="taJms2E8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6094688010; Thu, 28 Mar 2024 16:08:52 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DDC8818B
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6963c0c507eso10509646d6.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638529; x=1712243329; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QS+hg62/qIViyirO/q82NoS7jAIJO2wecoD0pdm6drw=;
 b=taJms2E8lveGgYAKhP1/ZBfg30LJUJymqSyh3rd8V21r8Bw+iJRvdWB6RLmKyp/q+E
 H3XvhQ1d9TxuxcwtpQsJKk05GJq2eyTiAb0c5LfGGiZwPBi5vV/C/WNyyKJn3ny39w3U
 KGY3j5uGQe+Zc44nf4KOZmVltDWOJSok8Wa5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638529; x=1712243329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QS+hg62/qIViyirO/q82NoS7jAIJO2wecoD0pdm6drw=;
 b=bwj18VCI0RVKhyaYzXcCbYtSR1UUdrRVWPWmc9MRM0ogULCHUAAVKNEe6vgQlgV0yH
 jcKE6nC6K5a77ZlYoX0WV++x9nQ8vkdCoGyPuJsfufWzDAJYscgSci/Jw1VuHONWQluc
 +xfrT0Pa76E3OzF3Qm+RbMxb03TCmTRTUyeWvGRimEKEA72aq1lEwu9XV7O7djYYxzOw
 TeZApqJTpsBfWEXxORNcCAXp2Fb9J+dpsIJyGroyV12mdSl/5M7sgfLU1f3oFtWtCH0Q
 0AafX19xeUf/EWRTJ0z9XgeljcViDzKvTz81JsDvZhNBumjCU3Nm3laVVbyKQtVBsTPZ
 DT1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK3Vmr9ySaWoUpeyTrShyneOMK9PhcYFTd5fvlhiqBC8zoyZTlBEixere5pslgZ/xsKRVgTjJeAx/ntJ+4OW4EFgaRYA==
X-Gm-Message-State: AOJu0YzCk8ckqC3KdtWBfCxJTPNZCDulVOQ8xA6jYWHqoMLKBBBYM9GA
 AYzjYDS0C+SkoLPhOBHFGMcX0K2Dhpu9vrxYSTp2yFe7C5PjNHaNcx84h7xSwd5lHNisem6BdfI
 Y
X-Google-Smtp-Source: AGHT+IERg/ENtx0jeMD305bXSOZpJ8IcMIb3Wc6dkznP7T5mBkAcASOIaUQqGkOlD1mXKrqlt6/51w==
X-Received: by 2002:ad4:4e26:0:b0:696:3e05:9c21 with SMTP id
 dm6-20020ad44e26000000b006963e059c21mr3476636qvb.18.1711638528931; 
 Thu, 28 Mar 2024 08:08:48 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a056214062200b0068c8be959a0sm713001qvx.111.2024.03.28.08.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:08:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:08:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 u-boot@lists.denx.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH] net: phy: ncsi: fixed not nullify the pointers after free
Message-ID: <20240328150846.GS3442575@bill-the-cat>
References: <20231229014555.3781595-1-jacky_chou@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v0Fyjr3PnUCpkqZJ"
Content-Disposition: inline
In-Reply-To: <20231229014555.3781595-1-jacky_chou@aspeedtech.com>
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


--v0Fyjr3PnUCpkqZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 09:45:55AM +0800, Jacky Chou wrote:

> The issue occurs the UAF (use-after-free) to cause double free
> when do the realloc function for the pointers during the
> reinitialization NC-SI process, and it will cause the memory
> management occurs error.
> So, nullify these pointers after free.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Applied to u-boot/next, thanks!

--=20
Tom

--v0Fyjr3PnUCpkqZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFh/4ACgkQFHw5/5Y0
tyxY3Qv/WAOC7xnlhQM/nslS2s48SaluIDaK5coYJXtKYf23EzgBfXA4wRGB1d0T
AVv0nmJ4rbST6Fhe7SNL2a904xyOYKfgjAsMPyjIBxrmA/h99IQu597iLk59dPSN
uQufVXaBCHC+f3do5C3GDZBC+Q74ZOq6K/2ipUopnVS8e1eDfPQmWxAykEMmDy/G
8xZLJS5KlrIjYTswkIGh5EXEE7tOnYImDrsmTOEJe+xTnMvs6nWzg1EW4xo/hHPO
o/hVr6XOqhezsQ1sd3+YloX9BaMd6O6uSCYvhWZE9pBxTnM9OYkjzctWy7ok/SkF
mHbKsBWOT7lNBqhjUzIePS+zOMblubEyHu5UZLNY5yr6EQpBN6KTF1NCHipdDszB
rft/OXCdmP1Sh5rxmypKYnlNFOO/p9SH6PTz/9fp6SzVq31nzWPp34KOhP2L1NAx
RQq8Ust5G7jrL5cTrxgXJUbCSWB4koxI3B3hNAVr8l65UMJl9WwVitHmMBBtb2AS
dqAG4IS0
=Yoto
-----END PGP SIGNATURE-----

--v0Fyjr3PnUCpkqZJ--
