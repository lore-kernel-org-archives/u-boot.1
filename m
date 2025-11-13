Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74D5CD6E63
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 14:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1116483E43;
	Thu, 13 Nov 2025 15:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UU9RLToL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B311B83E5D; Thu, 13 Nov 2025 15:03:31 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 614FF83956
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 15:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6571763793bso365360eaf.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 06:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763042608; x=1763647408; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xtALxTAdiMcGYPNTSftmnkxBO9CqpS2Ya7cUTnb+6DI=;
 b=UU9RLToL4+1RnFkL2ZPi1AU1gbd7iGKINgwCWmwD0FUR0Wxa/aR/Fa6EhAAcsLBadx
 0Jg5rkNMKzkGZQ4T8GLyqcD6MPz4l9kWn08y+Jq7n23Di/EeGOQ+uAkK2O1aWQXxmWUY
 2mgEWkLWcVqKWYiMElPhL3vKTSU4+h/U7KKpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763042608; x=1763647408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtALxTAdiMcGYPNTSftmnkxBO9CqpS2Ya7cUTnb+6DI=;
 b=uh9MK/WcTkeXLm2xfNcWfWaK/rxV0dttpVIAkXAuGVwRhtV6sOnaoQbuGl/HiTZ+NA
 2kRGdl5wyn/K9GdisB/uREjXC24menp4shSC+8HKC3eSDWRZruLi+u/EhF0Apqof5dz3
 Xzzv83ZNY7HUaDklmzvh571MQYg589C5f/mZzaJVusWn1B16qUwq2i9DGeR6kLr1HPgL
 eTGxHLsdK6kQtU+gkSTSz6MfFo9Zp+Fw46WbW/turSf1RWsE1R/as88nY/KRFzhoGlPM
 jeOMa0868NvEdzmdsdpx//XMGHPNc76uxF8ITVAHaJWkirAxbr4MrUr/vkobfofM/HCA
 0kRg==
X-Gm-Message-State: AOJu0Yx59ysDWkxjQDivM5G1ZsOWFoB+6tIfYer3j51+B/d/hybd4pa/
 hpzBhtZJL+RtFyOTRW/VK3pfO8XrjB0X35olLHYx89j15Kp6+vjjQACWNFfKxGLQBZY=
X-Gm-Gg: ASbGncuqG3ggww9k/2hHIGMW3/305spp/4h3yS7W0qqRZXX3FyHbr7o4CiN6uKX/ls6
 b7mQgI8Fp0Ormesduly5rq2uiveiR2n8vlYHX+LRYNDmcS3SOA246V5SShX8WGEsuXRz3qUpVtW
 Bda25wSFQROJpcesiVL5UOLgYVoIONB4HszdJmVEmN4deNXcfOFk2YMX7iwUI9qI0IdcvAuzYJW
 eTMnVKQ/Umg3SNxEj3+xHiP7xG/yJOWnUkFACDXt22A3fMXGfuCpFMm1s3chD9tXYh1E56yW5wW
 J7iis7OhxfY4FHuUYxcJuDM/VlAbI69QjSnV0tWSaU75EbpexmQ5Lw0Omp/QKnljjjs0CCsrGlM
 VAYLFnVIZt1+uvb6v3chFz78dYSKTkzVcfYPQcOEfhremmV4R3JdK73MgRrear2a/B4F3nSkigT
 0JuoNTGy5rSGvM8IWH5S0SrU+BOMjY977ku7tILjs=
X-Google-Smtp-Source: AGHT+IHIsGVDZY9LZPqXi7l/txgeFQtyqXsq8cF9Fh6CK8EZp/VuKPvNhBrBjJ1+Jb1XETvQgHHruQ==
X-Received: by 2002:a05:6808:150e:b0:450:3da1:aecb with SMTP id
 5614622812f47-450743f810fmr3306829b6e.1.1763042607743; 
 Thu, 13 Nov 2025 06:03:27 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a684611sm995854b6e.15.2025.11.13.06.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:03:26 -0800 (PST)
Date: Thu, 13 Nov 2025 08:03:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH] arm: qemu: Eliminate fdt_high and initrd_high misuse
Message-ID: <20251113140324.GH6688@bill-the-cat>
References: <20251113115539.947871-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vJFP/g8/pcUkyrHa"
Content-Disposition: inline
In-Reply-To: <20251113115539.947871-1-marek.vasut+renesas@mailbox.org>
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


--vJFP/g8/pcUkyrHa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:55:28PM +0100, Marek Vasut wrote:

> The fdt_high and initrd_high have nasty side-effects , which may lead
> to DT placed at 4-byte aligned offset when used in place, which then
> prevents Linux on arm64 from booting. This is difficult to debug and
> inobvious, with little to no gain. Remove this to let U-Boot place the
> DT at correctly aligned address.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

And this is something that needs to be done more widely too. I'll look
at that once we get this series landed to -next. Thanks!

--=20
Tom

--vJFP/g8/pcUkyrHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRXlLAAKCRAr4qD1Cr/k
CqcYAQCxe1wygCu4Giab1cke5pzDIFYchWS9JuDCp6bfBSe9wgD6AzX8WUiGMVJK
TWRzm3GhdkS4NHcuWMmKW4mX+A3pbAU=
=689q
-----END PGP SIGNATURE-----

--vJFP/g8/pcUkyrHa--
