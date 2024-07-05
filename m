Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E00C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 18:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9300C88626;
	Fri,  5 Jul 2024 20:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oE2sNiJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900D1889A4; Fri,  5 Jul 2024 20:36:58 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 283C288626
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 20:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7035d9edcd9so158141a34.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720204615; x=1720809415; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uTFmfzH+yL7f1tj29uVPo0XlAkpuZxuH9L3edWO1P8c=;
 b=oE2sNiJotm3B5LzvIVcPuzmoMFLPaeQ/WTACHlHsBpr+S2GSsfvSy9eKbXMBgeCzCe
 Tq3AldWuQpZBqUIXGym6hGPGOmeSYoobM4Qk/O4bt/qWEKxW6Mzz7fpuO/rZMmQNYipU
 u1EgBWgoHbQVXA8u97CGLzqtvsxOXI0GiKcJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720204615; x=1720809415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTFmfzH+yL7f1tj29uVPo0XlAkpuZxuH9L3edWO1P8c=;
 b=P+dsZzJ+cME2etvb0SvOp2KCYBu4AjTouaFfluaAeLIcaQUvE6qAywD584agHgyKsu
 VddusuG2GG17j3TeIXPHVyvdh56EA4Wi/J4c8c9m26c6CgE65sYgmM8Hcqjvl2AklL2h
 n1+nWiDfk7icYRyoL3YI+o0AWeQ1ffGhoTxv5qJ+Imq4x/q3KQwd6uytGPrTQ+CzqX/z
 o2dHeWeOl4Vs650Tqz/pNo2wk459NH6HVEyD3o9Px94HYxJQvLSNZrf1UlO/Zmo8dtR9
 lCxYlwrpWdWVjwV7A0LLvU4wt7AJzcB5tS5hhZveH777ZmtfaM7fsiSQyXUY+haBVIaq
 LntQ==
X-Gm-Message-State: AOJu0YyrzZwbiAl43Dl9zBLpNFGNPxoboJdAT9xMuv4iMQUeBBjzX+Q5
 gtZXbQLKDmfI1kCHccBDk9XiPoq33Z3oCe+dybnCnDABhDUS4WLZ7Kvu8G8Y6gA=
X-Google-Smtp-Source: AGHT+IGyxN1ZUaBAtqTHH5avII3U6Fa8osvCY0flbuEZEtGs2ULJErbv00GIVKBBiUXTS7VLlRm5mQ==
X-Received: by 2002:a05:6871:5214:b0:25e:1a0f:522d with SMTP id
 586e51a60fabf-25e2bb80086mr4504820fac.35.1720204614683; 
 Fri, 05 Jul 2024 11:36:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e3536c117sm725111fac.51.2024.07.05.11.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 11:36:54 -0700 (PDT)
Date: Fri, 5 Jul 2024 12:36:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 48/48] temp: mx6sabresd: bump up the size limit of
 the board
Message-ID: <20240705183651.GN38804@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-49-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5MA1Snk3IYGytIIT"
Content-Disposition: inline
In-Reply-To: <20240704073544.670249-49-sughosh.ganu@linaro.org>
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


--5MA1Snk3IYGytIIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 01:05:44PM +0530, Sughosh Ganu wrote:
o
> With the changes to add notifications for any changes to the LMB map,
> the size of the image exceeds the limit set. Bump up the image size
> limit for now to get the platform to build.
>=20
> This is not for committing.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Please replace this with:

diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index 868f6b15513e..80f7cd60b5b8 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -27,6 +27,7 @@ CONFIG_BOARD_SIZE_LIMIT=3D715766
 CONFIG_FIT=3Dy
 CONFIG_SPL_FIT_PRINT=3Dy
 CONFIG_SPL_LOAD_FIT=3Dy
+# CONFIG_BOOTMETH_VBE is not set
 CONFIG_SUPPORT_RAW_INITRD=3Dy
 CONFIG_USE_BOOTCOMMAND=3Dy
 CONFIG_BOOTCOMMAND=3D"run findfdt;mmc dev ${mmcdev};if mmc rescan; then if=
 run loadbootscript; then run bootscript; else if run loadimage; then run m=
mcboot; else run netboot; fi; fi; else run netboot; fi"

--=20
Tom

--5MA1Snk3IYGytIIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIPUAACgkQFHw5/5Y0
tyxNvQv8DiH9tqSP1DuHUQFQKSj0EwBiJyHBRYgUdDVjoXhy3GQCn4+WirzKITH9
6CaIMnqV6tdnrmhA2VkClIGPZmGv7TcXsJU1JEz4P2+A7pcCyVEXfwvcEez0kXGB
m0K6j5Y2XK4vPRjqjrqVc+y2bfqb1IBMy2nbloiNX+774BiWOJSjvxngmpvvqjNa
ng5zu3EbHMQNqgBhTEZ5e7nm8q9XdDO1mw+6b7KzV11BBYvwNgp8tnMYPyeti4+I
lPYpfGGQKfr1gG8rPiIbiPqrvpp67xN7oeyf80MfHr5tXZ29e/M2xO1qUkfQ9CoE
Pp9SGT+ErSxNBkiWTj/c3X523pQOAfLxyqeTUoD/GBH3VBh0+rkuyXu58FH1Uf2Q
0NVkdWOdYv/tl5ikZFilSTKmpUJ3nDvi+lqYWAUsIjznStYv4cQG6wOog+c9tTvg
YEK7cWHsojo72iZDU1TPOyzelMBwKtxIzFQJUJPO1zckgB6Aeye0olvstfC7BR4I
+NL/vvR9
=PXof
-----END PGP SIGNATURE-----

--5MA1Snk3IYGytIIT--
