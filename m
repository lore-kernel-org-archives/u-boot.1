Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EF3CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 15:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F292F848F0;
	Tue, 16 Jun 2026 17:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K4Fu0oj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B88848EB; Tue, 16 Jun 2026 17:00:54 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09646848D1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-43d3a0dabb0so2957352fac.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781622051; x=1782226851; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UUln/IgiQj/UrMlTLKkXMvBBESo4owoAUmnuZBYIDak=;
 b=K4Fu0oj03G/KmtNrY3ZSldlXTj+nWRxEufxMwvJGKWvurvuKVyRP6xmfln1kNVLema
 zHVS4z9qQ6YGq4Y4aluIdeCchS0v+vq7yHmsIw5igY37xaiGkUZfnvi46tCUhV8YHbDG
 EaV8LruFiHGCPCoZbfMuEjxs5qC+i7wyMv4dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781622051; x=1782226851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUln/IgiQj/UrMlTLKkXMvBBESo4owoAUmnuZBYIDak=;
 b=D0kCb6OsPGgMC5X7tMpEeSUpvT+n8L9e8P+OHfoVf7jn/eMwG5EICifjHN7370qbyE
 uBJEostpajko5qGekdxRBFGyfhFiaumFM/7+nE5/6IFRbRH0YP4DyBMiGOeIZkwaEgkj
 F/+aJ9fdMCACXpM0r3LXk5mBJLygHnBX2p8bXGrYSyFuXparl9x2l+wWccKbYcJ5f1gS
 7ZaAnsj2pGPBOkvepro6jCuHRGH0YvTtRI+wqWO4LEoTP7MhdWn8iDrryc9exwQJnPT9
 9+3uj+AGwzLnfAK80YW7cmOeO7Kfb1CGojOp+M8qp0Cb+y4nyx7xpW3q5twPP9oUOso1
 7eLg==
X-Gm-Message-State: AOJu0YwdR3LA/KdlAEQyZKQ/oIvtArpZv+0rkZl5HNb8yk9IeqoOuK9g
 P3tXnmnCQkTttvc205OCHEhR8sXExUVlUnhwh5xcfgFXAy+hmMxDXbqTyOVgfRp64Og=
X-Gm-Gg: Acq92OHLaTjuRDVnn19Xqu82Muozt2fVf4WChQmb16JbVQ+niCG5n3NlPdlFHWQe2Wc
 /i+e1i47qzj/whyZb9lhB4C1OBA+m4/Hx9BjQWONg150AUeiY3ALVlh2Jy8tNgXWr1O79n9Un+X
 g2D+H1ir09k+mY22MnJgD8mfiKyL3Wn5hDgyERTjT0QqGlg4lGxvAjiqfV/WqaAfPO/BmdgWauN
 3DH8G6NCP4dR/g3iatgwrXiu05kxA0R2dJZmcRzQS+9KJiMJwiYvI9qnbsNRoiJWcwcx+WvSTql
 iDAG+J3hXgohjff6uOnM8qngmceMvZh71QIyfjeuvVeCMPNTzdkmnLcvTrsbKfbAUW7EY02Ogea
 BAvlXBVCR4AC7cdAq4TDw3kw1LOg9LK7JJNDamD9vKE3NjTrKHDnTQV7U03ozCVVUgxATuZRaKW
 ne4KzHj2/nca1ttW10hTDPNm5gsn7zNS8jn4H6VEJxwEVK8/0vQeZ7JIlxZSylYb/1G6lczaFrH
 cuL8uxlJtoNomYdtjAoF37qLpRKlkpMZz4u4eJAvZ1Klx2oUoiTAOVRTw7jrA==
X-Received: by 2002:a05:6871:54f:b0:43b:9922:9ddd with SMTP id
 586e51a60fabf-4430b69457bmr3008747fac.27.1781622050598; 
 Tue, 16 Jun 2026 08:00:50 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44308f190c9sm2162191fac.11.2026.06.16.08.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 08:00:50 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:00:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/9] u_boot_pylib: Require setuptools for building pylibfdt
Message-ID: <20260616150047.GK382693@bill-the-cat>
References: <20260616142859.54136-1-sjg@chromium.org>
 <20260616142859.54136-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W7NCADcuL5cTbXsU"
Content-Disposition: inline
In-Reply-To: <20260616142859.54136-5-sjg@chromium.org>
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


--W7NCADcuL5cTbXsU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 08:28:44AM -0600, Simon Glass wrote:

> Building the pylibfdt bindings (scripts/dtc/pylibfdt/setup.py) needs
> setuptools. In the tree this comes only from patman's requirements.txt,
> which a later patch removes.
>=20
> Add setuptools to u_boot_pylib's requirements instead, where it is
> available to every tool that builds pylibfdt.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  tools/u_boot_pylib/requirements.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/u_boot_pylib/requirements.txt b/tools/u_boot_pylib/req=
uirements.txt
> index 1087e6f2857..0f6a230d522 100644
> --- a/tools/u_boot_pylib/requirements.txt
> +++ b/tools/u_boot_pylib/requirements.txt
> @@ -1 +1,3 @@
>  concurrencytest=3D=3D0.1.2
> +# Needed to build the pylibfdt bindings (scripts/dtc/pylibfdt/setup.py)
> +setuptools=3D=3D78.1.1

This is covered by scripts/dtc/pylibfdt/requirements.txt already and is
what should be used when pylibfdt bindings are needed. This does likely
mean the CI jobs have been omitting this as patman was pulling it in.

--=20
Tom

--W7NCADcuL5cTbXsU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajFlHwAKCRAr4qD1Cr/k
CqpCAQCZxoTwuo6QYiQOnDfb8gAIhXIP1q7DaiD7r1NZwk5oRgD6AtjluXkPNjH3
5zHc/LD9VR+ii4FG9te7HL+TcLiyVQo=
=17qs
-----END PGP SIGNATURE-----

--W7NCADcuL5cTbXsU--
