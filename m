Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B381E8FDBE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 14:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E783583DCA;
	Mon, 29 Dec 2025 15:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d6aHtPkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115F983DDF; Mon, 29 Dec 2025 15:42:14 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9185A83B82
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 15:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45392215f74so3299710b6e.3
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 06:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767019325; x=1767624125; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2I9FRC0rHi2cK5/Ow+1s+6dM0+lF5LZLNBdI07iuJwE=;
 b=d6aHtPkf+QMWjE7XVFqY0RNTcnPyWaM4T+l1q/Pe2wJOGvhH8bmFXrAkiR4vJYpkRR
 1ykAmLWuXuOQSpOWnbZesqyvYKJGZ8wMDzCP267pBJfZj2QHOVcVPrDdd+yswjHUYFj8
 5qVwVXK72HRdufy6cYk7masNZWr9OyF+55SL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767019325; x=1767624125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2I9FRC0rHi2cK5/Ow+1s+6dM0+lF5LZLNBdI07iuJwE=;
 b=VK8IsPV0PEfj0hpjxsLLXXfvihGkphKhfMyYJ4wAfaVkm8tNrAvjxw2O00WFEvRFjE
 cSa+VjAhfo0gTq6f5kHr1vzNWO+5/MkK8w8wmjoJOzgwhHMmPHQ+BUDlTPXQE3eblqI6
 OW/uHqaPDUuCQjfK+UldFp/c0yi13iiFV+udqf4AFGtrZuiM9rVta17WJC93HwUeFK7q
 Rv6HzmB8xwe48CWDUqgvZoU4zjZd6uqA4kwL0otysFVvOwmH2IAH7A4Y6Uzbh4GgfLb2
 r02FqFxkEzVFZqBLQuPxHm2crWvEtPx70pz2cR3ohDzjAnwDdrn7BrK+SNUbZ3x3kAAV
 DUeA==
X-Gm-Message-State: AOJu0YzwwYHcOgc9Byd3m2jXLd1JV44yKWueQqrz3xBSSsYm3Z+2nTUY
 xbdGUimmsN230ODLV6KLTeu2wWqqV/iRwletUTOvNlNVLZon5mM4u8GZ+0vOkNfJ50c=
X-Gm-Gg: AY/fxX5LS7fbNRKyAq8xkdg1Rc01AJD7w9rR880Pft8LahNcimPi8W3O1GHLkefLjPp
 yfbe8Po4K9/0OgsSVRIp2kLtLKCk4jnp4o7muAe+ka3NDHRKI9Fbfsfi75634xHGzIKuclJL8b8
 2ijqFeE2yMD9Tf2fukJ3qbxvyNhtBP2wQehe24iNCDqcGRERj2vQL9K0ZcfYYny1hmUQRb8NUc+
 6MORTow3BSlQj+wvf13nv1f6+tDRoitXLOxILYIzSBZbAagJe0t4/Nwdnrgsfz6Mcdzh7nu+Qv+
 2Eto352nSLa5AuOUGHVO/xslogaW86FPTU6CY+1pYQiU+/shM09j3iH285RXZzXXTynpf/KnrZ1
 Ppp9VlfqlwrVM1qJsYyyiHGPK1TXeMX1Xm/zxvwgcIIXmUFnbeLQXHPCI9zUKJiuI9x0bw+6PIb
 fWAxROseIboqxuH/lTStJjOhaBCxjTy8UXK5nyu/v6o2V1mS3HePr9RAAjz509aR4yOVuvb4Dx1
 B/eGjK5/Sy2VcXmxfMk1jHYbRD8Md6v83k8JSw=
X-Google-Smtp-Source: AGHT+IHaDegCBupMJzvYBinRVlFePu508vjIf+QlhG3BxsTZ1o7oyx4lD11UiPIwbaislrxKSBLGWw==
X-Received: by 2002:a05:6820:f013:b0:65d:a79:5687 with SMTP id
 006d021491bc7-65d0ea9684cmr13810262eaf.54.1767019325164; 
 Mon, 29 Dec 2025 06:42:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69ae7esm18830864eaf.9.2025.12.29.06.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 06:42:04 -0800 (PST)
Date: Mon, 29 Dec 2025 08:42:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH v1 1/3] Add CoreCourse socfpga Board
Message-ID: <20251229144202.GN710860@bill-the-cat>
References: <20251228223821.22260-1-briansune@gmail.com>
 <20251228223821.22260-2-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FHJgWqHu+Xbn1y2I"
Content-Disposition: inline
In-Reply-To: <20251228223821.22260-2-briansune@gmail.com>
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


--FHJgWqHu+Xbn1y2I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 06:38:19AM +0800, Brian Sune wrote:

> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC501 C5 to mainstream u-boot
> This is a UBGA-484 based board with basic
> feature. More info on [1]
>=20
> [1] https://corecourse.cn/forum.php?mod=3Dviewthread&tid=3D27704&highligh=
t=3DAC501
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>

This, and 2/3, seem fine to me, but you need a unique subject for each,
and saying AC501/AC550 is enough of an addition.

--=20
Tom

--FHJgWqHu+Xbn1y2I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVKTNgAKCRAr4qD1Cr/k
CpRNAQCiLEbdVs9Z0/dnHi/j2Xdc8buXErD4BeWju9V7EXaJ2AEAlzR9F6BE2qSl
mjcwFIshbDyLHK2cdXjL8PdjaGyxMwI=
=ALd8
-----END PGP SIGNATURE-----

--FHJgWqHu+Xbn1y2I--
