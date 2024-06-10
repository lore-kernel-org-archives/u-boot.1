Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA33C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 17:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4195288622;
	Mon, 10 Jun 2024 19:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yt6cBqau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1225888674; Mon, 10 Jun 2024 19:44:59 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF5BC88622
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 19:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2549c883c43so741070fac.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718041495; x=1718646295; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ok4R85OrVLn37jyeu2ZifU4QM7Krv1OgAFSr/GHK9Ws=;
 b=Yt6cBqaukns07m4ak3DArIFxwam3Rhg/qf+TTjTJVIMw7kr44TabvEVfu44pDN3tn4
 wJtbD3NYfNXWo/eTNCg21BtoyTL+s+CinAtPXipCIC7A1FDnl0QvjClP5jKuNSxGnnh1
 5btEPOn9FDk0SmJfVMLHnLaOMvkLxQTnoHUIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718041495; x=1718646295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ok4R85OrVLn37jyeu2ZifU4QM7Krv1OgAFSr/GHK9Ws=;
 b=Hz32c+cok8RaYVi9EzF/X/ZqzJT6adO94jgc3Mx/C5kOv6YqRyO/grGrWQso+65deL
 3VXdz//1D0R5mUSPHI2CAdWi1kieMakvSqynEoui2cIL3hhHjlYxJZ7fuwLXcJyQNW+J
 ldaUWlC/31iUh5+P9epOk4sbcDLVCQMSpUFm6VFGH8PVO4816U0UhIsjBAdDT2eyc/Px
 iOE6KfvFJi1ErTuh9+bYGWWOx5BJembefBoFl3qJdhgRWaemtHCBeZ/nHp/ZbJMsQ/ni
 BbeJKm85NIDkyeJMqY8YuT/r2bHlULzD5lJRpx5EZ8ZSIWtJ0uMJWwq8ynlYVA4A01Q9
 Gt5w==
X-Gm-Message-State: AOJu0YyJ1/IVdBnBNbH/KETQSx7UiKsNDSh6lO/1EgZqqFDRe7fk53J6
 fLkCojN/nrTa5+ulp9dMVyJOVuU+7q/QFrRP99kCno45JxwIxai/VrhyDc3dbHY=
X-Google-Smtp-Source: AGHT+IGI+ux7GdyO44yJxhXilCi/eVce36QD83mM0ywrevVhlVfV4REZjcBPzwNUXckH6EF/g/cVXQ==
X-Received: by 2002:a05:6870:a706:b0:254:6f6c:5262 with SMTP id
 586e51a60fabf-254ecd34bbamr166460fac.14.1718041494189; 
 Mon, 10 Jun 2024 10:44:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25447e29786sm2375690fac.21.2024.06.10.10.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 10:44:53 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:44:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 22/31] test: lmb: run the LMB tests only on sandbox
Message-ID: <20240610174450.GX68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-23-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ejGEfesYJYLiYL01"
Content-Disposition: inline
In-Reply-To: <20240607185240.1892031-23-sughosh.ganu@linaro.org>
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


--ejGEfesYJYLiYL01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 12:22:31AM +0530, Sughosh Ganu wrote:

> The LMB memory map is now persistent and global. Running the tests for
> the LMB module will result in the memory map getting reset, and this
> will have side-effects on the rest of the working of the platform. Run
> the LMB tests only on the sandbox platform, which is meant for running
> such kinds of tests.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

I'm not sure about this. We can reset real hardware as often as we need,
too. Did you run in to problems with this test on non-sandbox?

--=20
Tom

--ejGEfesYJYLiYL01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnO48ACgkQFHw5/5Y0
tyxjiQv+OG+8bIqRswh4Oyu7bD6Bv3e2kFzpheJ4IWgfEr/bDaMBGu5HokvcqNfV
mvtCb8L66NicHjcCkIN3p24Lft5Wgtk2fGlEV0XlkkB3u9wPJ40bKt5h6hwgySJZ
Z1LguPnZdUuvN4ELY8qhZxvreuAU+9w+QXYYNgEQOfpE/bUlJadPLT3zmfcRYdSM
0pGWR1vao5UttpcF42SPHff6qqCLDRM+FPxdo9rRtbU0DAXhiKu9v9j12L5Os4uN
5Gw4spmLrump9sGbdipYa99RpbkDikJLo4rGG+C4RmMRdgtyDnFGY1rF2q/AL6AC
X/VSobBIYol8rmU2EN/YL9NUnYu+ul0PZv6VuepUKv1BP6XJ3jTtJGwUeSiANpT3
zOgLo5ZgHHuAcRLEFuldPtX8X/y6snE5oet0qAYfYZoiyGYGA2ei5ux4jDu4jzMI
hKr6ptrsD5T8YdBUPoI3vvxezFf49rB+WaEkhEP4Iy7yZb2brXHIJWSJd2Bb/JT0
lkGh51xH
=fkgP
-----END PGP SIGNATURE-----

--ejGEfesYJYLiYL01--
