Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84206C5ACB3
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8290874D9;
	Fri, 17 Nov 2023 20:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rUP6T2wn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D731874D9; Fri, 17 Nov 2023 20:42:48 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5BBF874D5
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d2f3bb312so12827286d6.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250152; x=1700854952; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I7pAu6dsQzGCS6VpsXtWi+/RTlaiGDySCLzrfemaOJM=;
 b=rUP6T2wnmolerifYqNUMh2dfzo3pd317M7GjcaD98rBttQe+YvtKt+k5VE+f9zsu2R
 DAZua6F7J1wEoJYWRIF6cIJifyKTpgNbAXwlc+UCladm00qwTYkrCYesVtPUDJJt4WcG
 0VoFGATGpYSSCvyUDzPZrD/ODLk5ooMFTik1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250152; x=1700854952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7pAu6dsQzGCS6VpsXtWi+/RTlaiGDySCLzrfemaOJM=;
 b=vvtGx9v/odNJolU4OZm0LigeElScBU5QFUDQ7lbYI/DMQvSez4vSKF3+SSyA7i57Rj
 EP8mtb4FD4oqpxM+wTU7DRMb2jBFCDqbFOK0l9CEsRgvvTRTkBCp4p/B4QYYv/rt/yyT
 nBcO95zAFf2sT2YwZBeiqbHLy/toYQf7fW33m1vHK3FslOrB4aerdWcrwHdZSzyL6lPh
 xNqWtqJYNzqN8UznV1IIe0ipz2z2ztJEUpT5nBWo857npSJirYeQytBUOs2m0QGJ2jM/
 RVjOkQt5otmjCw559rgcf0zdM37+yMLFwQNEPtYjOi2Wwn2iw4RxjUu8/EfU48Q2o3mm
 1o5w==
X-Gm-Message-State: AOJu0YwkvOvhLyyZXA+wHKe1AUZ+XD8N2xmeKZfV/6by0XMLnmbaO2zh
 DO1XKMxMyhFUKqeaHxS6JcxZfw==
X-Google-Smtp-Source: AGHT+IFBCMkOHMShrdnocyW/EwildZfN5hqDQUkbAl3JJB6CU1gnbSpMneSm1m3swTs6ZZuzzQkk6A==
X-Received: by 2002:a05:6214:488:b0:670:9883:b163 with SMTP id
 pt8-20020a056214048800b006709883b163mr87702qvb.29.1700250152398; 
 Fri, 17 Nov 2023 11:42:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 e2-20020ad45362000000b006779f7e68c9sm859979qvv.134.2023.11.17.11.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:42:32 -0800 (PST)
Date: Fri, 17 Nov 2023 14:42:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>
Subject: Re: [PATCH] bootstd: Avoid freeing a non-allocated buffer
Message-ID: <20231117194230.GZ170968@bill-the-cat>
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c/QnYq4SPWjmvl6G"
Content-Disposition: inline
In-Reply-To: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
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


--c/QnYq4SPWjmvl6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 06:35:23PM -0700, Simon Glass wrote:

> EFI applications can be very large and thus used to cause boot failures
> when malloc() space was exhausted.
>=20
> A recent changed fixed this by using the kernel_addr_r environment var
> as the address of the buffer. However, it still frees the buffer when
> the bootflow is discarded.
>=20
> Fix this by introducing a flag to indicate whether the buffer was
> allocated, or not.
>=20
> Note that kernel_addr_r is not the last word here. It might be better
> to use lmb to place images. But there is a lot of refactoring to do
> before we can remove the environment variables. The distro scripts rely
> on them so it is safe for bootstd to do so too.
>=20
> Fixes: 6a8c2f9781c bootstd: Avoid allocating memory for the EFI file
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported by: Simon Glass <sjg@chromium.org>
> Reported by: Shantur Rathore <i@shantur.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Tested-by: Shantur Rathore <i@shantur.com>

Applied to u-boot/master, thanks!

--=20
Tom

--c/QnYq4SPWjmvl6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwiYACgkQFHw5/5Y0
tyyccAwAsjHZ6+JiVoQZLTvhUpvuVQ9RMgCChTsa2iskOtEI8FGTTz9dM3sLc7D0
VPME2ZcvYYwSYOqZ//0Dr2Fp/5anUfoEJmaZB2C3KlrSC80uyD/KzTMlsFBgoCHJ
HgDuuwW8ZpY3N+1l2mp6oAinYVAnTNsGt9STTe74UvvgSHwj55NTmg8MD2w1muKu
JOE5w26FXnAFyDR2g0RVp8fn+Yut0w+6V6Xyk+V6JXEW8DsVOgmQG2X4ovITlvez
0EwRGaGgQIBcHPtwBfr4WZ30KAvZzTj3Pj5RlnkC+ZP/8Yjx5lhqYKR699BCm9+N
CwJsQhSqr+9ZVtSvSUvihhdHGPhIjzUsO20X7s0f0JJIQy/T2Sir9xwc8RQxUii7
ye8MZtOYQ11f6xFlUgndkuKhvoSQE74C4ABd2mneQcPBz2wHCuZSyNR69B9Wfk1X
oLsto63dsnbaFouRIwqtilgnjINuDleWrT37Gi7tzTkSEqfimSR0Xe26xIduvRu1
Wp6VYFmk
=zc9j
-----END PGP SIGNATURE-----

--c/QnYq4SPWjmvl6G--
