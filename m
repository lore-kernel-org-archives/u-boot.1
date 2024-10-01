Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D049BCF3188
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 21:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF1488E0A;
	Tue,  1 Oct 2024 23:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K9vsX6e2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB4188E36; Tue,  1 Oct 2024 23:54:54 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 648A788DFB
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 23:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb82317809so2212426d6.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727819691; x=1728424491; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DEykwpGW32EhTwCB7+1SahMYFboNSPbt+TBHkJDnTi4=;
 b=K9vsX6e2qMkNEUwv4mJnKkYNbRcHGXectX2wxbFqwPGk7/vEiq3Y417abbYht6OaUQ
 09s/q2yMkg/D1JNVAbYN5VEpcaXIZWtmHKiQdBJbWDvgJlpAl+Nt1WWLRnlVk9sXWCN9
 MtRGcakspZjBq6D4zTfT2/k748bS2pVvzTGjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727819691; x=1728424491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEykwpGW32EhTwCB7+1SahMYFboNSPbt+TBHkJDnTi4=;
 b=reOv3StcvjcntkTfhMfVVmjl44St+XTyAf8ooQtLbih8rex+gk3x8EXBUb7wIhssPX
 gJwv4DfzDJYZIaJIglXarTfao80wmZDPkg74DGKEJRMDciONxe9FBJh0BGv7GNXby6kC
 CzFTNjSbgtkuqBT5x3zt3i+ac5Rgw50C00UzPhg3fJzzavYaspBhqSxHINf+you1gKaP
 PeNh8il7IW7pu7QbjE/A5eAJwicr/QJtThvll1uQxLxD6MoPq9y4G3vxdoOK83nsdtNk
 ptKRr0nOaTLyqTLekrdVrIghtbR/vC+/KvxBp3OiYOwH6St+yGilyh68j7O7OJSLQv9o
 fEgw==
X-Gm-Message-State: AOJu0Yye7ooE5HE4yztv0LMUuMpYqhYPhc5qIrK95Xdqr/7GUL/+6B07
 vfuZk2XTZ3ySpqJItfIHdlN5YCQWDgiNm22W+B+iXO4SF4Ug+m3kqsSjOVkPlgU=
X-Google-Smtp-Source: AGHT+IHCynW7DMHlAWUnL4fxPZyBQCntz9/lyk1No58sdBenlkjqrxESMUHvrm37TunecLkgOz45Og==
X-Received: by 2002:a05:6214:5a01:b0:6cb:3da9:b8ac with SMTP id
 6a1803df08f44-6cb819ec473mr11750136d6.3.1727819691219; 
 Tue, 01 Oct 2024 14:54:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b6802fcsm53772396d6.117.2024.10.01.14.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 14:54:50 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:54:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v3 02/33] boot: Drop unnecessary ifdef for LOAD_FIT
Message-ID: <20241001215448.GL4737@bill-the-cat>
References: <20240930014956.1434060-1-sjg@chromium.org>
 <20240930014956.1434060-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d3T18plZGt+kNuGn"
Content-Disposition: inline
In-Reply-To: <20240930014956.1434060-3-sjg@chromium.org>
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


--d3T18plZGt+kNuGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 07:49:25PM -0600, Simon Glass wrote:

> Use the normal SPL_TPL_ approach for this option.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This works as there is no TPL_LOAD_FIT symbol nor case of using
SPL_BUILD being set by TPL_BUILD and so doubling the meaning of
SPL_LOAD_FIT.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--d3T18plZGt+kNuGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8b6gACgkQFHw5/5Y0
tyxxAwwAkBMYdZo+ZAImXLEe4j+aU0h0mbP53wMVFHmFybKfHYuoVvxaTQPx1sQc
Axd9hHP6IEU8U7AZ/hdpiRzVTpPEzGXFJ2qI45pjzS8pMgTSvP8miiwYTYOm38bI
CNAgu4Y73Tbx5SzIe/XswscYk5NiHDnBy9E2QRoveWM1zLUL9AKjAPInpF0wNF13
hsY5RAEl2094a9OgQSmGzOdISZQlP9vd7a0NeLTKynfmQ7vTgf9v82noGOqIbSbi
mgvvDV3oJ3Wk+mg0CAMi4NXVn7C0te9UsdTJZzZQHP9Ing1uZYGVWkSGZmkrImL+
LLG6fryNjuUi173tBa1CL6QDgJowge557u+jr5Jikt52MJfUePtlFVI67tv9+Dhq
pYzlRmLiI91HsiUkGKyVpvj7QQ76AOLh7UWxj30zqhSVf3Ebqh5vJ+oduzmfTfU5
yDmAUrRwc0yJ+VGsVm19NH42mjFYmg2J3Kv7fprG7bucizc1NEjtD6qBGV6iaVhp
CB5WBLN4
=PuhJ
-----END PGP SIGNATURE-----

--d3T18plZGt+kNuGn--
