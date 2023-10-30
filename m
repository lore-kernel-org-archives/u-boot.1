Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8FFC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 21:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA06E87ACC;
	Mon, 30 Oct 2023 22:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KnyX6cap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C67879FD; Mon, 30 Oct 2023 22:36:16 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD1087ACC
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cc56255e3so30091371cf.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698701773; x=1699306573; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=86LwqRvFYgbU1k+Yt+goNeBEfXjSijchLfDUi+Lueh0=;
 b=KnyX6capxd4ixHfgN0D7zgTCFJRsfzs+QZxqE9TYlmi//RKdn7A7wYjAksYd9ANOx7
 lmJ6JI8PmlHzIkDig1feeChrqJllOX+Yg9ojV9IDaCMKC9YLXD/BPvEL8Rg4rgLnUQQx
 ICh/xmuUt/etT3/Yb9qf7/H2egnBg9KptbpJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698701773; x=1699306573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86LwqRvFYgbU1k+Yt+goNeBEfXjSijchLfDUi+Lueh0=;
 b=CFdLDYCTRvZAWE0wC0fpVoVLHyBLPY/Hq1O61rkAAhS4CQxCVBRHAHS4G9qa7XHmY5
 HjFc6gCYRlXx+RcR5qfVb9RE4+R8aP8tURVPw5ioicphRxBCVbvI6HbEKpMBilft16hD
 cZJy4ZzuFc05M7DmOJGfCz9ldcyo/CV4WgCmkQ5IJJtRZnHLAhTuxYI1r4BZCWmihwle
 C6JkPB1/DxHLXf8WgF6PKVGXIn5uyp6WiWBylSp2f4+iDBRiNY5LV6U9oTT+8eA4TScz
 pKCx2GeMXLaqy46a3Lvp6Pc5ooRDUqm+cde9mJM4iHmtXzfQrCWVprQxJ3eutR9UtBVx
 4Etg==
X-Gm-Message-State: AOJu0YzcWZJTq1v+FPWYGXE2LoiFc43+vAc3T+KK5RXUOXmo514OixjB
 ppr+uz9tFy5cwGTKiAU9aY8CbxBknBfT8z4MdFwCqw==
X-Google-Smtp-Source: AGHT+IHArxG9Pur2JSblbcqmQa8eJTnwvG9kX9EH3ouWcU+15MLnqlj8dryN2C1sWiiBejzI6JFOqg==
X-Received: by 2002:ac8:7f83:0:b0:419:573c:59a3 with SMTP id
 z3-20020ac87f83000000b00419573c59a3mr14974589qtj.19.1698701772783; 
 Mon, 30 Oct 2023 14:36:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 19-20020ac85653000000b0041b12d5fd91sm3766753qtt.55.2023.10.30.14.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:36:12 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:36:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] addrmap: Fix off by one in addrmap_set_entry()
Message-ID: <20231030213610.GF496310@bill-the-cat>
References: <b2dd17c4-2da7-4785-aae6-6a9568f82fc9@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tiKxsWQgMN7j5bHQ"
Content-Disposition: inline
In-Reply-To: <b2dd17c4-2da7-4785-aae6-6a9568f82fc9@moroto.mountain>
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


--tiKxsWQgMN7j5bHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 09:50:40AM +0300, Dan Carpenter wrote:

> The > comparison needs to be changed to >=3D to prevent an out of bounds
> write on th next line.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

While Simon had comments of a more general nature that would be good to
handle, start by taking this fix. Applied to u-boot/master, thanks!

--=20
Tom

--tiKxsWQgMN7j5bHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVAIcoACgkQFHw5/5Y0
tyyvXwv/bdr1fUTNEOGaT3AA4x6z87YJLbxr6iabxWnxsTpNhYeqE22sqJNjoHQ6
jX5IZUC0FnXKj8UFy0SMg03HBzzhraviFh7nBg1+s9L7XYyTBkFyMFBgnh2l5i35
09KlNJJkYFlGSAAvXBVEHefN+SxvuVV01fuSRDrBzWwejE3XwSvNOJoCJP8RQgRC
C2yIb5GYRFILFkOE0zcUKFar6XsrDO3+SoKAk9kap79da3V+GOvvFN6SBIw2HDHv
gUQ0EcEjSXpqc2CKqgCcE9ElJaTKvMe81KSikgG0XTKm5RrvSJb2yxRA6Fiyi1zP
np98Eaq3QvXf1Jo5jyUxmEx21SURs91fK/Nk+gJMhwfWDJe00ZfbLgbc5FZ3GIeV
I9fI6ZtpCFP+zg+J81l9XLq+1Lh+s72LL+V0JV9SzmaEontVbHNcyfZqLLmIIN6L
GHZY4dDRMDzyDmP7H9gvqEovM9w9CpebmK9D1/2J/HSgqJbXtagEYRHqRycDh8kX
owuAjo8f
=K1QG
-----END PGP SIGNATURE-----

--tiKxsWQgMN7j5bHQ--
