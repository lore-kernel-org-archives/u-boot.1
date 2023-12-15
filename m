Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E99C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C9F87C79;
	Fri, 15 Dec 2023 23:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kz2oyB8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A3787BF1; Fri, 15 Dec 2023 23:48:40 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235EA87C79
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-425ff068d17so8139381cf.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680517; x=1703285317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bK0ol7nmV5Sl1U+sHYEiOnW/shIDj16ZtVTNkZh76ug=;
 b=kz2oyB8aaImsRBMPSm6IXqXrznBo7VYkKQ0wAwLmLHTz8E7WFHXvrQspsQXXw+S9cj
 2PLevmSPcWaOw/UGGvaHjoz3EF6+Vo1W1qo8frilnDyJfAPPNXcSBMC/9hv8XkAJhdpB
 mVVShBAz+Pgx965Kv4E5ZKSpkQW/mCrNRwGK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680517; x=1703285317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bK0ol7nmV5Sl1U+sHYEiOnW/shIDj16ZtVTNkZh76ug=;
 b=cYyjjRxhuvXYTPjhV4U+pgYY2+1hgShgvNc2I88q7f9G7pLXtepf4hzf2JcttWvMxT
 YzEth5mVtMsILJ5zDuZ6b5q23YCspdl5c3226F+qRpoozy3JNjHCSj6zFd3Cv6v+fuXo
 3o5Ifa0vBxSipGo3DxDXUSmj9LwWZuFdfM+MrbYodN9EkLVC0dmu6Wxr2bt8R0wmph/m
 izZIfzAODsCBIHi46IGz+oop+cQoeUt2jp2L0D/U1ZE3DM4VjHMx6i5MxOgzvi8J4nmT
 7vJlm++Ym8mz6BG7FlWwKQAxQoFHPvycGydFUypSX/NEaHl+KVmX8mIvdAwf9fslpDy3
 8haQ==
X-Gm-Message-State: AOJu0Yz21nW3EzWy5IIOU9Bn6lfVLfZWgo0RaLIvhGuRuATFyvwx+UhU
 dJI9DsOEr+JWBYpYaqHYNQqrCg==
X-Google-Smtp-Source: AGHT+IGC+qsVSpaWvuZoWF5c1h6PwpoOWzMScwQVU5vBqa+lYiJjZdMOQNa4i5cK7B5XEqrgPxr9uQ==
X-Received: by 2002:a05:622a:1b9e:b0:423:7f55:7495 with SMTP id
 bp30-20020a05622a1b9e00b004237f557495mr16861400qtb.27.1702680516999; 
 Fri, 15 Dec 2023 14:48:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 fk20-20020a05622a559400b004259cca3f9dsm6865830qtb.10.2023.12.15.14.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:48:36 -0800 (PST)
Date: Fri, 15 Dec 2023 17:48:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: u-boot@lists.denx.de, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH 4/4] board: ti: am62x/am62ax: Update virtual interrupt
 allocations in board config
Message-ID: <20231215224834.GK2513409@bill-the-cat>
References: <20231128194024.20809-1-vishalm@ti.com>
 <20231128194024.20809-5-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f0ttrDYUPd4F42lt"
Content-Disposition: inline
In-Reply-To: <20231128194024.20809-5-vishalm@ti.com>
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


--f0ttrDYUPd4F42lt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 01:40:24PM -0600, Vishal Mahaveer wrote:

> Updates as a result of TIFS core now reserving a virtual interrupt
> for enabling interrupts between DM to TIFS core. Because of this
> change other virtual interrupt counts decrease by one.
>=20
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--f0ttrDYUPd4F42lt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV818IACgkQFHw5/5Y0
tyzfOAwAhhH2kV0o7UFJC9hoaOQczBUiE+bQXMy8efcBHZIRYuMUKWfq9rGHwzgK
NATlTUjMPBs3AVH/w10YfNHmP9vmtxlDOmoK873C41LpWtsJKlkSHqv1fB5C4/Qr
Bqx6IhPbfCAk4PPRQydp7x8mwvgU2L1eQBu2lyFbfokNLovxHHiQUmiMFSC7Z3x9
pIYPC3PCP4t4xOGDadfgct2fv6fAnLTeBerOEDe8QipfKwEYAHuuadqqz590QUv4
zfllTnbGnQTQiVz94bfB+aZAnuCVtgdDFHMOYT8549at2CnvNCQ7nnIV73io0LR9
N7v/zwtcDz5t2ZHfyw5oGpZ84tIFpwukQs7WvCI2b2A2zUjkJs9G8xw72GBHP/jn
8FWODSAUUfY7L3ad4SkMMHk++OdGe/972ZTwifRbZfQOEuU2EnymgtTxFYavJn4e
vQPu6jfV4aGfIyiKO2KCWsX2XG95hUUinirDycK3+BMr/HrWMMhCHh3KfPD7zWP+
yX5Ka1zz
=2Qbn
-----END PGP SIGNATURE-----

--f0ttrDYUPd4F42lt--
