Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50EAC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A4882B17;
	Mon, 28 Apr 2025 16:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dCnLT2Ee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D9482A33; Mon, 28 Apr 2025 16:49:52 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E60E82B4A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3f8d2f8d890so3288733b6e.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745851786; x=1746456586; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OLhfbEKREiahHA8UVoLNoanJM2fYSsVHuUKRsAFwf3o=;
 b=dCnLT2EeBIjsyA8lwwKCGN82M5JYPsA2kdobhAzM8gZAYNwe5f+Dq60MFcv+t4eXA9
 ad4c8TQjxhwzFG2nl97UnhXbx4ha1cMc7Np3CZm4pS62WZbEvQQE+UbPX8q77qCBkrCX
 H0j9MAmKUW9zNr7x5BZ2FP/TbKet2UgF85QgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745851786; x=1746456586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLhfbEKREiahHA8UVoLNoanJM2fYSsVHuUKRsAFwf3o=;
 b=rVIw98uTqmzIpx9LJ4Vidz5MjkBxF31hTsjJpKsm6zw27S4aBCf1YFO1KPPIVB5vTi
 OJLOd9RI8JH+tjbFbwADZCAGFtYHj1r8ukIKy0PyvwhklQx7SABUwFSiw7jPHc81IDLg
 X2sJ/Ow8zsylBwq3omgpR1p9XXeFWJNHmNipkU5qHlm4RNga00/RFuKMCZALMfuKgq+v
 bHGKNNf2r1MOfn6dCj16pv7Be7Rwmh6+Ur3R10zQQCNmrlL4Dv7iYiBAOE/y432yEX7q
 IPlhHhieUnPuhzIoBHeh+WMMqM8iB1EWDx95wKQb27M0zbJYjQtxvOIZ93kNlsh7Glde
 A0rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdXf1L89yUY4Mu/6pk8TlH1KpZ+vU2Brywskjhngu0IKDvdFSkySS6wSCeXy/f6ZqOCQXJ+uU=@lists.denx.de
X-Gm-Message-State: AOJu0YwSEcdQ0rvyZpOeqKKd9cMjJD78E6+znpjO6ZpVS1C+6j+SevfD
 VECPvFi7YHjNCYfSSKRmsVLxPzz7Cfy3kxychWO+U+cUAVX7psYW9kUNaVm3bpM=
X-Gm-Gg: ASbGncuZutkv47wH2+8/M8I+pKB01czhIPuYzvNXPxtGgAv2eXa83TupPSKWdF1wOtM
 OB/00YUIcm8e+ChJ+acwNvjqb1iBBUaXUfqE0DeA8vMbY2OPl2mtGfLnzKyV5J+Ci4T0nb7W4nE
 KenDyYNlzcLNgKDhHmjKPq+u80n8lSQ2hj3y53WGvI+JTau0nXPZXdeZFgoHR/8MMU9XzTwxKwM
 i3GwOvStsbitJmqp1zGThS0SJc6IWH/7p5HynBTZPOM2uAF9dAJxZ/guRxjeTgDXYaTC9AwURcn
 lNloSVP6HYfd3KdCc+TdX4lWWGOO9ziEd9gWiv8KQb1MUmgOJJ+6doBCXLH79q0cR6SwvOyaI6N
 DMQ==
X-Google-Smtp-Source: AGHT+IE8csZ5RJmRbe2ao/vmCaAPvs4d5syB1FByNcdd2W21onDvU27zsNKo0/isX79McZjw8o7BRQ==
X-Received: by 2002:a05:6808:3943:b0:401:e61b:fe9c with SMTP id
 5614622812f47-401fd74d9c2mr4384050b6e.20.1745851786502; 
 Mon, 28 Apr 2025 07:49:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401ec8e4c3fsm2113584b6e.30.2025.04.28.07.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 07:49:45 -0700 (PDT)
Date: Mon, 28 Apr 2025 08:49:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Nathaniel Hourt <I@nathaniel.land>
Subject: Re: [PATCH 1/2] Makefile: Strip leading spaces when preprocessing
 generated_defconfig
Message-ID: <20250428144943.GA5495@bill-the-cat>
References: <20250427145011.17331-1-ziyao@disroot.org>
 <20250427145011.17331-2-ziyao@disroot.org>
 <1526A781-5592-43DE-94F2-221DAA484192@gmx.de>
 <aA5RcIbI7uhsGmu8@pie.lan> <20250427161627.GZ5495@bill-the-cat>
 <aA78p0FgCZYmoeBM@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AFQ5oPJV1es+x1LI"
Content-Disposition: inline
In-Reply-To: <aA78p0FgCZYmoeBM@pie>
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


--AFQ5oPJV1es+x1LI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 03:57:27AM +0000, Yao Zi wrote:
> On Sun, Apr 27, 2025 at 10:16:27AM -0600, Tom Rini wrote:
> > On Sun, Apr 27, 2025 at 03:46:56PM +0000, Yao Zi wrote:
> > > On Sun, Apr 27, 2025 at 05:19:04PM +0200, Heinrich Schuchardt wrote:
> > > > Am 27. April 2025 16:50:10 MESZ schrieb Yao Zi <ziyao@disroot.org>:
> > > > >Clang's preprocessor may emit extra spaces for lines starting with=
 '#'.
> > > > >Lines with these extra characters cannot be handled by Kconfig and=
 will
> > > > >be ignored with warnings like,
> > > > >
> > > >=20
> > > >=20
> > > > Do you have an example for reprocing the issue?
> > >=20
> > > Sure,
> > >=20
> > > 	clang-19 -E -nostdinc -P -I . -undef -x assembler-with-cpp \
> > > 		configs/starfive_visionfive2_defconfig
> > >=20
> > > or a smaller example for demonstrating the behaviour,
> > >=20
> > > 	cat << EOF | clang -E -P -x assembler-with-cpp -
> > > 	# comment line
> > > 	normal line
> > > 	EOF
> > >=20
> > > and you could see the strange indentation. For reproducing the exact
> > > Kconfig warnings,
> > >=20
> > > 	make ARCH=3Driscv \
> > > 		CC=3D'clang-19 --target=3Driscv64-unknown-linux-musl' \
> > > 		starfive_visionfive2_defconfig
> > >=20
> > > (Clang is called clang-19 on my machine)
> > >=20
> > > > Is there an understanding why Clang behaves in this way?
> > >=20
> > > Sadly I have no idea. I guess it may serve for improving
> > > human-readability of the preprocessed output.
> >=20
> > This is https://github.com/llvm/llvm-project/issues/78778
>=20
> Thanks for the reference! I did a quick search among LLVM's issues
> before sending the patch but didn't find anything useful.
>=20
> Do you think such workaround is acceptable? It seems the link should be
> included in commit message as well.

I'd like to see if we can get llvm to fix this moving forward first. Can
you please comment on the issue as you're hitting this now too?

--=20
Tom

--AFQ5oPJV1es+x1LI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgPlXsACgkQFHw5/5Y0
tyxGMwv/Yrn+BJwo8VuzUmqZ+4YMxamwAmBR0HoEYfTaBQFoRn60qtGIHoflSbS7
oNVI2kt/pDVw2INdrZvQiuh+UJ5KavyB93Y3mcdq+UwhUPEQWUmavQ6F/2QUD6VU
2F7bHpCgtxy4xosEX7ZvAX7Ml/JZog9GN2UuP0UY6pe2n9f0GxtaI6kYXy+HntG9
SYBlKOLIhXZ4bLF3fEVm+Itqe9NgUu81JFKhI44SbNZYUS9SBGfZUH6+IZHyKhZ5
xq8JYu3r39LfAQhjVgd5XvTfFrVt8PTJQFIJVaELaNRJeOjpe8o6mSZvDCsN9Xv9
qtQsd4XJVRqzFoWFFbHRBbRcRM4OXQa9V1xIRgfz2SILypM72OXRKisKCzLh772g
Rn3Ysfv/TwxdZWbT5aWOC0uTbSMzWC9Fja7M+fkZDQH6j1P2YfiWbrTMClZmIVtm
w6VJLjDcMSMx+ny+Ac3TbnGZ3X96hp/F6PYfxs5D/Sqg+MPMOs2TJCScY2H1T9z+
jqStarub
=1lRx
-----END PGP SIGNATURE-----

--AFQ5oPJV1es+x1LI--
