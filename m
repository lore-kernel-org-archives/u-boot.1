Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF46C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 13:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5441A87EE3;
	Mon, 25 Mar 2024 14:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FlbfGH1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F6F8718A; Mon, 25 Mar 2024 14:51:47 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB28487EF6
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 14:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-690b8788b12so30833906d6.2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711374702; x=1711979502; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pdqewitPjkQnwUMvABUV58bfo0FHWqi/mm/IVHh+ZjQ=;
 b=FlbfGH1kPkI9XKZlwkDzOJNPJ6YcAHWQ6Gwq1rk7JzmeGE8w6j2vAAGDHLcEcGEQsJ
 mvmjsQFdGvxSx1qjqGmqYYViOprusxvI6bG6z/j6ZD2sU34QEyGCBEjwlOy4ZUX8Xed+
 HgAreyqfyXNyuK9WtJbjm0EGTsTDyC0z1a7WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711374702; x=1711979502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdqewitPjkQnwUMvABUV58bfo0FHWqi/mm/IVHh+ZjQ=;
 b=vJDeQCb7tdruwrct8TS6bNVDclpmYIq2LutYjggkHrEgvHtXBIPtZau31D5IhgzXq5
 PYWl//IhtQHZEPA0KfWty+z63ndpsJpBB/Jif8toLnekDlkcjaT/A+DdtkQ0lmgUuNI/
 85JtoPt+kN67qoyKX4ts3SSCt7rTBBPD8opkwnub9WMJlo1CVZEMkpuKIlsy73Be4nZX
 ZtEJQ27XLnhLfqE9Tdb5VRsqsna+3h0UC2lR6AYDvxhXKX9Fg9ewr0kkRo2ZH1n3YP/s
 3uRvRUu0Rbn6Ml5mcrIsyMBdd/RQ41PfcOTOwjpcfhX3RnuLaGP9+aGBFszVKBIL7NZr
 bLhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLiQvmAPbLURdH4f7nCNbs7rQ4rbpHEyG4T54gO4ySVerWkHi44SkK+CUfk7LPnQ+W5YJgoEpoIf0bAp+WkqIRwsRrZQ==
X-Gm-Message-State: AOJu0YzBFblUjboWJamfVHSnrHrI1a4CvTbSFJsvz8j67sg16m8Mxf84
 p9CVM1t8C0FyJhqKGeQgQpIUZhiNfAWlzo5Axr5YDKvvEvOIn+qzv8r9BQfwCvA=
X-Google-Smtp-Source: AGHT+IFYoQhE/hr3z/iQPdAOG5TahMIqBQK/oYP8eyQqMD7lmOAyAMhWsMUiWOX2ZXD5m0Qa1mIKsg==
X-Received: by 2002:a05:6214:1308:b0:691:e21:736c with SMTP id
 pn8-20020a056214130800b006910e21736cmr9252973qvb.30.1711374702646; 
 Mon, 25 Mar 2024 06:51:42 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 15-20020ad45b8f000000b00690b21ff926sm4103245qvp.137.2024.03.25.06.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 06:51:42 -0700 (PDT)
Date: Mon, 25 Mar 2024 09:51:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-fixes-20240325
Message-ID: <20240325135140.GD3442575@bill-the-cat>
References: <b3c9af94-9b6e-4dd8-b5f7-7a59a3520e24@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uX84QOHXoFWwOYT6"
Content-Disposition: inline
In-Reply-To: <b3c9af94-9b6e-4dd8-b5f7-7a59a3520e24@linaro.org>
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


--uX84QOHXoFWwOYT6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:45:43AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Please pull this set of last minute fixes
>=20
> Thanks,
> Neil
>=20
> The following changes since commit bd0aedde3ea3691616c17c720e2d25351308c0=
a1:
>=20
>   board: toradex: verdin-am62_r5: Increase SPL_STACK_R_MALLOC_SIMPLE_LEN =
(2024-03-22 11:10:51 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-fixes-20240325
>=20
> for you to fetch changes up to d54f87f09a36ac20154955297b7c999b368b0443:
>=20
>   board: amlogic: fix buffler overflow in seria, mac & usid read (2024-03=
-25 09:16:19 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--uX84QOHXoFWwOYT6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYBgWwACgkQFHw5/5Y0
tyzRMgwAqXs1Lo9/UyO+AZHbXT3trxezE7nZq60Fbvm+cFKHct0St32AA/Rbve70
14MMgfPp/7MCOr9Dtz+M989XyhTRcwOprAg26BhKKiF7ob+Zjm2001Xh/QlVagJ9
ilsjFXOQvZCogQ4UNomv61Vw3DaKgtCLHUybW1sX9/PAgKslukA1PsLnaUhyeAgW
beEDygF+pyRqxebWSYseh+YiV/ffZHSfnyicXQH2sPrZnlbdWChs/C95Tj+OeC91
JBQgeUcP9kiIzJ84tl2gWf27UE20t6S1wGPuWkLOOmAALAr5dUy0Fd7rt9mUNxnF
Xk3IxLnBIct9XES5tCC7LgRkVxXKDOTi/Pa1zKwPqp6DOTPmTWLU7IlKRAoU0Jm6
axqQpBQVNVyGfkfz/VSm2l43wpg7i/XHeGCraiV1ahtFR85LpZuqd3kGsCVhHZBB
SqMGQe5bcX34IXSazUXs3AJS8unpoN7SrpB8fdhUoJC1P/v4g7Ef/qhi/msYI8vW
vg7LGKiv
=wRQh
-----END PGP SIGNATURE-----

--uX84QOHXoFWwOYT6--
