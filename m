Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B742C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 14:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C85803DF;
	Thu,  5 Jun 2025 16:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HXRkA2wd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E968091A; Thu,  5 Jun 2025 16:48:10 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8112B80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 16:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-86d013c5e79so85767239f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749134887; x=1749739687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vgPATjooB6aJw7VoJu4+rOPOjzqxhUuHcM9p8NoTAfE=;
 b=HXRkA2wdfHhf4GWJYkQ5xxO+PE2hqw1Cycfl1v4AuCR4Fip7UXF1ybLaASXSknZHmh
 IsjFapwyxdzsPPukRf7tP8DGb56boKJYxT1koWYRoI40YHZzSVG6UwVP0AZjWwRbr7Gk
 6mancEq0PsXz2W8tBWPMRW11UCryDuoNYmVxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749134887; x=1749739687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgPATjooB6aJw7VoJu4+rOPOjzqxhUuHcM9p8NoTAfE=;
 b=HpxZlzj9Bu4lTr49wt7WOv+kSZ2kWn82+Zuw1YEsth19w+mMSgO+bDA8mMSs0+PFi9
 0YVfPnFmODTOIFdptzp8xMqHd/x0R0mT6dMfqOEUEDVk+QI+eNjpn4d+aC3gzef8ejgJ
 z3J23Wz0v+e/noN8Cm7DsWUxvOr1tkfn7Xoi805G0GzmZn8Dz4dllvxUCX0TjlsF+yp8
 y23Oxef3xQCUGLhi2agsZPpBrgJS7itQjPdFMyumLxlC35G3XjJLWDvfIIo2fn3IyizE
 PMHz+Iu5CG7tcK6KuLNurMSHbOHO3uTXA8IZG/0HUctdTUNd7SwcP9VndCZXxBoTs01s
 /dXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMD1R2ymezhxvskgVgB8RDKA5qql5wS4Ef2b7vYQ29/rUdbbozQ39i6m3vCkdQ3SYO7evbAuc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6wsd+OmScNWYtT6q9AREYvLwu+t/4u6VkrQLjjK4sbplAtbb7
 MUsbjoV/Iafckkx1rIlNp2L79Js2EiuZrhXB/uoywPvqVU/aAyNSJV6vsV/v1MugdCdSWLVQIsm
 s9x2ANUI=
X-Gm-Gg: ASbGncu4D9+X7SaNmaqEI8eGyCLRI7CXSGh3oo6FeKvMlQ+GVDy5KrXEAkbJrfYOTIo
 WJH6vMB9BKioHkcQ9hiUO8k7/orGred8O8bUvzgzuqI1VpVnEjwvoPMj42YGuyIHrCoZQPd9G3T
 jlyql3CinI2oRep2VId+r4R1YlPhgTdfDvCf91qJAhEmVJEilMHjqMaxa4fjkZdMBGCd8goapkS
 u1gCiK8+3yGto6yYiaH6nHHzsXiXorhDCUZCabLfhyAvhwYKWwYm21JVe0u6mYDd94hLzyFLtQF
 ll6bnNBAiem/cRg+GSlYuw4wLEQGTLXxsalNItpm15uRc82Gwhx1NCjsHLMwmJSHPu31RXf4F+p
 7CJlnn2nxFwUs
X-Google-Smtp-Source: AGHT+IGzerX0TePYvlPkLZpDu02PuVL87czto43XjwJzbgFj7J3ISJGw2AEPQm3wB58YQPnw5WG05A==
X-Received: by 2002:a05:6871:5b22:b0:2d4:ce45:6985 with SMTP id
 586e51a60fabf-2e9bf21adc6mr4939533fac.11.1749134876748; 
 Thu, 05 Jun 2025 07:47:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e9064615e0sm3103483fac.6.2025.06.05.07.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 07:47:56 -0700 (PDT)
Date: Thu, 5 Jun 2025 08:47:54 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?= =?utf-8?Q?H=5D_bootm?=
 =?utf-8?Q?=3A?= Pass SMP core ID and DTB address for ELF-formatted kernels
Message-ID: <20250605144754.GY1382132@bill-the-cat>
References: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
 <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
 <28BD711D-9449-46DA-AD38-8142B0CAF7AB@gmx.de>
 <20250523222926.GZ100073@bill-the-cat>
 <fbe649de-dc78-4ef3-8204-95020ff2cf45@gmx.de>
 <SY3PPF5E5ED63A94E67F10470722CA5B3529F66A@SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM>
 <20250529154923.GL100073@bill-the-cat>
 <ME0P300MB13099B02B4C316E4784D23529F6FA@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A4AoYS07TYGw7xwq"
Content-Disposition: inline
In-Reply-To: <ME0P300MB13099B02B4C316E4784D23529F6FA@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
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


--A4AoYS07TYGw7xwq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 08:04:28AM +0000, =E7=89=9B =E5=BF=97=E5=AE=8F wrot=
e:

> Yes, this is a new OS currently being developed with plans to support Lin=
ux compatibility.
> Registers a0 and a1 pass the boot core ID and DTB address respectively, f=
ollowing a de facto standard shared by both the SBI (RISC-V Supervisor Bina=
ry Interface) specification and the Linux implementation.
> My rationale is: if U-Boot supports the combination of kernel + ELF loadi=
ng, why shouldn't we implement this capability as well?

Thanks. I see this is spelled out in
https://www.kernel.org/doc/html/latest/arch/riscv/boot.html as well. Can
you please do a v2 with an expanded commit message and a Link: to that
URL as well so it's clearer that isn't just an ad-hoc decision?

--=20
Tom

--A4AoYS07TYGw7xwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhBrhUACgkQFHw5/5Y0
tyzukQv+O8G98AcrOd14/H7fWsanuhxXWdBG+9O+3HGyYu4qfN+yCWxC1SfojOcr
1wZj/utvpWF9OY44T+1gdl38sPOg5fO+/nzh+46cjqe42FM71I+JByBX9TDxl3V2
Ql7ym9dod6fSEFsc7gcRrHDPIPi89ySppCxKU+O0uGlfildKBDz9bESuaBGK4r6v
O+skOd+ucjiXK8cj1N9DYKiBONAjPvJFLXkvx9AW9zVS97s+0ybnUD1/+kvIWG1N
0MDjBd/yAvPuFuTpKAzCPiw9IfJ5V707t9WP2twMImKw40odbdsw6bTVbAX27K6L
WOTw4bow3RNhHM4oTqeRkF+1OEx2Mdk71DEadtpmUE48PvZ+9I5Wxozdu3cZzeXq
td09CiIu0cdHTmg2eRvbg/3glUGCSEY+SvHPTsz/XRSkkU4kMXCOHCxETl/2Xzpm
NutXSZ6jmm85gShhIGnbJDZi1btFFeXnKXNMJVKqUFdQAvrYO2LXmB6Nx31huTq9
NnH6eCnv
=NcJz
-----END PGP SIGNATURE-----

--A4AoYS07TYGw7xwq--
