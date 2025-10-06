Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DCBCCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB2983E0E;
	Mon,  6 Oct 2025 17:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oY4yHvZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B9B883E0F; Mon,  6 Oct 2025 17:55:53 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B29483DEA
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-42f74b8edd8so4285425ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759766150; x=1760370950; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AonxGZ8G8DYpJ5UeN6qHRkdZG4wzq2LNLAC3rW/zva4=;
 b=oY4yHvZnYjClhtMt8FhJTDsPCgoOGqbBwpufmhtV8Ma8vVBGjzbmfXo7HY19cV9q+1
 Ic8yU5fHZHuiNgI+ENYep+yNAs0ebE4MzsQ6BD4vdpnLyy58tZm40a+6R6VP2hfq4CTx
 FJcn9HDIxoo/FwbeMO0e1D/6I5AOtQerX02yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759766150; x=1760370950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AonxGZ8G8DYpJ5UeN6qHRkdZG4wzq2LNLAC3rW/zva4=;
 b=iXIabjThQJN3UAUkZvxhPDA0zuDxW+eSdrvIUK0sKWwD0ybTvRyvfqgyDp4aIvalPY
 6Uy5IerQurU91AdKqvWfrQz4/Op3S+Ut8n5Kns/M6bgMdQxVVZVsFu80Y7WmsbOiCd7u
 0e1i1eNaLgEwsM9sK9yNWErEg58izzkLlX0myW5OvHo21bR4+99tFu6MO3fE/xyodPeE
 w6S8lmf0qLxwVgv/Qw444zeysxumqitiOLb3HE3q1TeWEPagXiGBDq0R0FwszkiGK9pJ
 qPE0GTnjW3zYMLlGZuEdm4kWvNf6Gt/lVCQdmUBSmj1DVudspDfDhRoaNTs5eCE6QXHm
 gH4g==
X-Gm-Message-State: AOJu0Yw/tcLbmnG0XHWmgB+AhhwxM1yhZHs3dhrV7UZVAtA70rtcNI10
 mrCmiT5LwsXvThYgNw4PMS+kTlDiitklzQGfW004ubEO5DFEEG3Y0zOB7syqYGDeRVrUstMiinU
 3Rg9/N1c=
X-Gm-Gg: ASbGncvNgey6qn9gNF1LCr/Q3HqUr2MWuxGwNelOxi39QlzH9vPv4ifsEgCgocLCXCZ
 f8lUGXGDnQZai/ru/ncY+Tx/8zuN5AjKaZGe4mAjEmBdmEXa7bpkG8MspQe0Sesj9HSuLRoX7a+
 /XhJ88VkEa0RP0Yqd1Bz6x1pmcdOvfRDU+Z+XZ23Vpsi4sqOeNJRv4EniSkwrqWYbNX4SySra5L
 sjPe/LQ2VEKJjTy/ib7+yebdgZRhezf1hmDhK3lbvu/QIhN7GJ5HHwDTrykcJP9cW7Ox2DGzYp1
 fSimXyMVk7kOD5cYZ+z//na/tghYXYpvkQJR0fQMlQSxbLYUnh0nY8W7Wts0JeKabtpIC1Qzmv1
 /fmIWHtiuBHEbvg5qcCU/MowaqU3HjwGVyqjgsRYPlnJzmdDxYB5DGMINxetLj1ZpgB5sLqCNvX
 DgZocVJvcl5mjXUSPqlP58
X-Google-Smtp-Source: AGHT+IFqfdA62+1ywT/Z9yQEmQniPzP3jZZtq41C0StevB3jDglR108+Mwri7TJXX75Y1MjxjuSjug==
X-Received: by 2002:a05:6e02:18c7:b0:427:1841:666d with SMTP id
 e9e14a558f8ab-42e7adb2f02mr173181455ab.30.1759766149736; 
 Mon, 06 Oct 2025 08:55:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b281610sm53442405ab.27.2025.10.06.08.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:55:48 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:55:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Alison Chaiken <alison@she-devel.com>
Subject: Re: [PATCH] test: Update logic for video test
Message-ID: <20251006155546.GF6303@bill-the-cat>
References: <20250818165406.3194425-1-trini@konsulko.com>
 <20251006171335.7b40302c@kmaincent-XPS-13-7390>
 <20251006172224.0a8d1919@kmaincent-XPS-13-7390>
 <20251006153328.GA6303@bill-the-cat>
 <20251006175408.27ba321d@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4ZOYCRA4c0vmANxD"
Content-Disposition: inline
In-Reply-To: <20251006175408.27ba321d@kmaincent-XPS-13-7390>
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


--4ZOYCRA4c0vmANxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 05:54:08PM +0200, Kory Maincent wrote:
> On Mon, 6 Oct 2025 09:33:28 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Oct 06, 2025 at 05:22:24PM +0200, Kory Maincent wrote:
> > > On Mon, 6 Oct 2025 17:13:35 +0200
> > > Kory Maincent <kory.maincent@bootlin.com> wrote:
> > >  =20
> > > > On Mon, 18 Aug 2025 10:54:06 -0600
> > > > Tom Rini <trini@konsulko.com> wrote:
> > > >  =20
> >  [...] =20
> > > >=20
> > > > This broke the build of sandbox_defconfig: =20
> > >=20
> > > It seems CONFIG_SANDBOX_SDL=3Dy is missing in every sandbox defconfig=
, and it
> > > is required to have CONFIG_VIDEO_SANDBOX_SDL enabled. =20
> >=20
> > How we detect SDL is kind of odd and could be improved. I suspect that
> > VIDEO_SANDBOX_SDL needs to 'depends on SANDBOX_SDL' as part of the
> > solution too.
>=20
> Oh indeed didn't know it was a dynamic check.=20
>=20
> So the issue is not SANDBOX_SDL missing but rather not compile expo and c=
edit
> boot tests if SDL is not available:
>=20
> diff --git a/test/boot/Makefile b/test/boot/Makefile
> index 00223b44fe0..89538d4f0a6 100644
> --- a/test/boot/Makefile
> +++ b/test/boot/Makefile
> @@ -6,9 +6,11 @@ ifdef CONFIG_UT_BOOTSTD
>  obj-$(CONFIG_BOOTSTD) +=3D bootdev.o bootstd_common.o bootflow.o bootmet=
h.o
>  obj-$(CONFIG_FIT) +=3D image.o
> =20
> +ifdef CONFIG_VIDEO_SANDBOX_SDL
>  obj-$(CONFIG_EXPO) +=3D expo.o
>  obj-$(CONFIG_CEDIT) +=3D cedit.o
>  endif
> +endif

Looks good, please make a proper patch, thanks!

--=20
Tom

--4ZOYCRA4c0vmANxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOPmgQAKCRAr4qD1Cr/k
CoxDAQCfVZ0icX9lthydJYMQ8MMRja23l2IHNJ13NQE5ib9F5wD/b+8JFWfapAbs
ihdkcERal7RZy2S4dekUISaMuybkcwM=
=hwrJ
-----END PGP SIGNATURE-----

--4ZOYCRA4c0vmANxD--
