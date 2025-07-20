Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0F0C83F22
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 15:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F93B82063;
	Sun, 20 Jul 2025 17:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S0c3A9qr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A41C82063; Sun, 20 Jul 2025 17:10:07 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0969801DD
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 17:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-301704710a9so1031812fac.3
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753024204; x=1753629004; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H5957DaF2VHBIVFuZ4Kw4w/rUa2EWgtS72kW+NnZUa8=;
 b=S0c3A9qr3GcCrWuY9q5AgEHS6LRAEonZm02oghcoRLjQ12tKj1KriI/uB1ok7g04u7
 PnsSnQPGgwzRFkkAltYeepFnK7/hYHd4IjESPvTENGM1jRjGfWEj9i5Ig5scMMqVtZ7n
 TjYJiUEZ+V/Cf97tfkuN9eZDddxff8IyADRjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753024204; x=1753629004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5957DaF2VHBIVFuZ4Kw4w/rUa2EWgtS72kW+NnZUa8=;
 b=P1Vx4aG2jG+6e47dfvhDJEhbz3t8M5/DIUYQf6uYN6yYiRgUAcHJvA+HD8SmV5AHhh
 mRb04p9mqVob39ckT5TXCVKFWpCJBaChlR/4uy7bDydcQwLWA13OxSyF3e6wk7Wdyg81
 rf+8dQ6lzZ5Xi4PULBACODCdsTKWvtKcnrgEoyaeokibeBh+OObthdQUIJ8HVWS4XZym
 tXp73GiHNJBx0T+yyaUKfRnqwwfcEjvHYMbYvG0s++MEQAQZos0D418K/YzxJba61y0T
 kno3FAxJ49BF84SwIUxKQrdJeLltHjL27MzPHriQPuxgZtoaRZnzaHaUiL6Nio1WLY5o
 KzSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuVs6yrD8ZnqeoSYOgBl3CWPqqNZF2O2p7hYc9L4ePIwJu4JbJtHDZR8KUQ/KFPGD5OnWMgis=@lists.denx.de
X-Gm-Message-State: AOJu0YyhRxrtwKgLVafjiK0lWIqzdnD5ricZuTOv9I2J9DKRc/DzjHPV
 UFc6ufjkiD9JqwtGiQ7b/+TVevW+1CcWYhjCRFAF+h5016K3/RhZBPwKSHz6Li5JgyI=
X-Gm-Gg: ASbGnctFNMTyNissBu391tjwMcjPQIiSEzxGd1yT+zGiwSjwsQvWX/HAR2xZu5S+KRx
 HlMH1x6Yf6rN6VDnZiUCS0kvpNp+22RYwsHd0JicC4p8eW4y7L8Bc6f0DwFHLNKvFkUPKR8Qnko
 zs1VMyppGUGbKIYinXysVLQUadUilV5dO837eFb/x2p89o1asB8OxmHPdkLX0V0CULwaUw8FBf5
 q2DbrFZg1vp9L2tnmyW8xhnK/YRjWqINQdYFC/fv8gJqdzZC3ptnsWPZTB/0Q06O0TRxfVKuk/O
 MpLVhPMrPMX8adg9wkyLW/OOvZWZ9wxLtCfDWWVKR2tXjt9XD+EQhMV5Q6U9Iib3xt+NQjPFfT1
 WpdzFBuxCnMkbuIrPICJIflzgfxfARMcXUzr3LacM7AiFjEnfFeDEKmj2
X-Google-Smtp-Source: AGHT+IHN5n9LClBEVHZ+NiVHxgsfnJ9aYQfi6sVrQZ/wmQG1NGaIZwktXr8zA+jaRRJzz8l0fxqB5g==
X-Received: by 2002:a05:6870:538f:b0:2bd:455e:c22e with SMTP id
 586e51a60fabf-2ffb244d212mr11576564fac.19.1753024203606; 
 Sun, 20 Jul 2025 08:10:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b719cdsm2164619a34.54.2025.07.20.08.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Jul 2025 08:10:02 -0700 (PDT)
Date: Sun, 20 Jul 2025 09:10:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/7] airoha/an7581: add CONFIG_TARGET_AN7581=y to the
 defconfig
Message-ID: <20250720151000.GA193579@bill-the-cat>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
 <20250719005717.113842-3-mikhail.kshevetskiy@iopsys.eu>
 <20250719145818.GZ193579@bill-the-cat>
 <942692e8-8d45-47d1-ba63-411ff2e7866b@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YlgdkitLb/XZosMJ"
Content-Disposition: inline
In-Reply-To: <942692e8-8d45-47d1-ba63-411ff2e7866b@iopsys.eu>
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


--YlgdkitLb/XZosMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 02:50:00AM +0300, Mikhail Kshevetskiy wrote:
>=20
> On 19.07.2025 17:58, Tom Rini wrote:
> > On Sat, Jul 19, 2025 at 03:57:12AM +0300, Mikhail Kshevetskiy wrote:
> >
> >> This is required because airoha/en7523 will be added with the following
> >> patches. Without this line config for en7523 will be created instead of
> >> an7581.
> >>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  configs/an7581_evb_defconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconf=
ig
> >> index baa3fc3f5de..73af30cd693 100644
> >> --- a/configs/an7581_evb_defconfig
> >> +++ b/configs/an7581_evb_defconfig
> >> @@ -1,5 +1,6 @@
> >>  CONFIG_ARM=3Dy
> >>  CONFIG_ARCH_AIROHA=3Dy
> >> +CONFIG_TARGET_AN7581=3Dy
> >>  CONFIG_TEXT_BASE=3D0x81E00000
> >>  CONFIG_SYS_MALLOC_F_LEN=3D0x4000
> >>  CONFIG_NR_DRAM_BANKS=3D1
> > This needs to be in the patch that adds the symbol.
> Could you explain?
> Up to now we have a single airoha 64-bit board. This patch series adds
> support of 32-bit SoC.
> Previously CONFIG_ARCH_AIROHA=3Dy was enough to properly select SoC &
> board, but now we have two. Thus if CONFIG_TARGET_AN7581=3Dyis missed,
> than an7581_evb_defconfig will select 32-bit SoC instead of 64-bit

Ah, I misunderstood the commit message.

--=20
Tom

--YlgdkitLb/XZosMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh9BsUACgkQFHw5/5Y0
tyw7/Av/UHi1YbwOudJwVKwH8dQjR1FMAryYSnOgK5+nz09oHT9jgAXCBNvrv9Rc
XYm8xe6kQ2zCrjCOdhVgRk+AGOaIup6amCpMfhYZm4fxff51SxS6e+VVBvlNH0lp
tfVc3xZADbvxDZhRsdK5bBAEo/X6hXyj4/CjZW+j/T/RM/87VYVNgSmivnHujyV9
3hzqzkagZQ20p0eoPu3LN5TG++LegcNjtOhld/414Qk5AXWmZ8JanG5wU/hkS8jw
8VFQo0Ob8bSWd7StuUGV22tgP4zzrFf3cmFsdHtuERFoXIHRu8nAeBibhJNFa67I
mT1ZJ25mMu4lm8hVSZHeIyj3dU+k4FZfs3E3yJmGUF5EvjUuHdcjiAoguGTf6uKl
3qWJ4uXdp/AZ5RCri9Jn1zIO7JW7hebrjeMzyNmJ+vAOFPjb+LhcGy6NHWbMpbw0
/2awnAnhRno2/pw+b2BalY91zHEJHNjrDhp4/50Xw1o9U6S7vFMAH0WwmCnpGsfZ
2Q14ggmy
=sx8P
-----END PGP SIGNATURE-----

--YlgdkitLb/XZosMJ--
