Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E764E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE12680241;
	Wed, 18 Dec 2024 16:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TI1PTtH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14CE80269; Wed, 18 Dec 2024 16:30:51 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1AC68022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so57552976d6.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734535848; x=1735140648; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8Pc00aUWaWGxKGH2dRnT81Djgx36lV1euuDHfpRJBfs=;
 b=TI1PTtH6o+5mbvOYuzyw9ikvgbAizfE0vVvpdqrSoiLoDuVBZlsltmzw68ktT1c577
 smKIc5+WW3pz1aEh4AjcV6zXBxRRu4JmsPKPevctL8XCmXUWIKOPj+nr0+G2afv3mf5V
 N4wwwb2+vJqjVg3bUbd1azWJRFJ+MDVKktUBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734535848; x=1735140648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Pc00aUWaWGxKGH2dRnT81Djgx36lV1euuDHfpRJBfs=;
 b=iAuGlDigDJwz0kfZYd8lLcp7tJ0CAbZtpc3TeFoBLiGp6H15H4EExmENrFiCFDQ7dY
 +BrYjdaQEIhr4oBKf32eshod+vbErzJCdfOTkzvTW07xCSAoiILcOy4s0xg1PE1e92n+
 SBjMXBGv7radomWid/Jmu63o5g2egsY0gd3+2SqSkLTtgNb2xiEDvcLPavAxIInly5bW
 LS+EgU61eGYt/zIh9FMva39svGz/rG4epvYlme955y7s0o22SJoKOblSnoQQT7wlDiZF
 Wk78AG67TnlLwD1ZunKNfd7gkYZKPOgM/eVKAsIMCtIsZULh6ztQsQ8pujhPLX0lMxra
 G3Bg==
X-Gm-Message-State: AOJu0YzUfMuCaloF/VfIwIbro1KIhdeJrw9eiqcIVwSF294Qj5V7SeVJ
 YbqGDA/a6eQfugZD7CTfOmS14T7vP4WCmySfVsCge03zzCljdk/4D1amA1o0kmc=
X-Gm-Gg: ASbGncuwVsIUsitb3Tfkp6qGN/qIUzjqKuxWOhYmbSmwmVaE0ykXc//3nB7fGsv5CK8
 79iVkTmHnr01zd6CFE3yqj4+1Sn8UBjb23yswkio5ryAi/1tynt7rd+9FJKLM7ZdCzd7pnlocv0
 sgMsfha5FQOLefCwOtWR0MFzJhYGKz+wpA2UQySFdmzpQc5GEfFjYlzL4iKAn8ykNISqDe0PrIU
 NEpHICze0Suh2ddG7BMgOPYPXq/y8bxZ5Vy/IwJiAwAoOVooIc1Pc+4
X-Google-Smtp-Source: AGHT+IEdhNoCFP0ZWt6oOCq3uzZfRKUggzwHWd6NhOPY6TXk3GAuw9+IsUxMypvziaVaQarZ2SeloA==
X-Received: by 2002:a05:6214:aca:b0:6d8:a2c1:2bf4 with SMTP id
 6a1803df08f44-6dd091891d0mr58453396d6.6.1734535848389; 
 Wed, 18 Dec 2024 07:30:48 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd366305sm50936126d6.84.2024.12.18.07.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:30:47 -0800 (PST)
Date: Wed, 18 Dec 2024 09:30:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/2] gitlab: Add samus_tpl to the sjg lab
Message-ID: <20241218153045.GC1505244@bill-the-cat>
References: <20241218150802.4064561-1-sjg@chromium.org>
 <20241218150802.4064561-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MSImmhHud/7XtKQm"
Content-Disposition: inline
In-Reply-To: <20241218150802.4064561-2-sjg@chromium.org>
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


--MSImmhHud/7XtKQm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 08:08:02AM -0700, Simon Glass wrote:
> This board has two variants, one of which boots with tpl. Labgrid gets
> upset when they both try to claim the same hardware, so we might need to
> see if we can handle that cleanly, e.g. by making the job wait.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  .gitlab-ci.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c620cfd1e34..72959427951 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -593,6 +593,12 @@ samus:
>      ROLE: samus
>    <<: *lab_dfn
> =20
> +# chromebook_samus_tpl
> +samus_tpl:

I think you can just add:
needs: [ "samus" ]
here and gitlab should get the ordering right, but I didn't pass it
through the validator.

--=20
Tom

--MSImmhHud/7XtKQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi6qUACgkQFHw5/5Y0
tyyy7wv+OhnmPSiuoaztvCA+v6PBM5JRwY6rQfFMgY6f/v0OCeoU004/2kBCu/rn
rZzj2sQl3gqV6e5HX6ROsmhKaZ1NbrBTNAZGXrWmVsMEdlQoapF4FQTq8ROUtcnl
8daD8aBa5LcXxrpVpa7VHL8V/iUhf2ZoXoPEL7/fvEolMARM6uxMhKAHENlkAJ//
XCPSJZDiV6GFzrwDTmDAB88eq2Tk/FzOXvpxcKiGZeFwhsY8PpLSULAfHtQ/5l2/
lsR/qEbrZTE9UU/L+uE1kTf3Hxgk/hkIP1OAApeMOjgLOQWOYEp0B0Tz1Wsufriz
8QEseZHF+e9RhS2k22+lx7qFgK9Xq+VwL4o//ULaiTMlgqi9s6fEAgDZ1ItvFqL3
V0kCRA6ErnCw1fMTO9/r3sm+G2nhDabUQB1UBH+GEo9iMEJkmxlzyFAVTonjsRjL
bcctPK2fYlw3y1YkylLTKwBJTM/Axjxjc3zhcyCoROXOLN+H/x7KOfCPi6uxQ6be
oArkvPok
=S1vV
-----END PGP SIGNATURE-----

--MSImmhHud/7XtKQm--
