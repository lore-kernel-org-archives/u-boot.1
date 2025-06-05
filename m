Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD61C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 21:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735DF81E25;
	Thu,  5 Jun 2025 23:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PvgdSblj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1808D81F0D; Thu,  5 Jun 2025 23:48:20 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA688091A
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 23:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-60bd30dd387so763673eaf.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749160097; x=1749764897; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4dvW1MK82APgh+yzCtjGmO8T/cyoY7t9VZfu4A+UdoI=;
 b=PvgdSbljIXutweYtIq/K8psZBAUUqpFL1977gT0ZlXwg0AWAV/lF9Cby+w6gmyRkkF
 DilJgvvVBCtAz+ccWHA12l10M4BIBkvyLcNbCpRh2faHrL8FfRRdD9CrcnKd368G7iFc
 cJznQBNHUH4I7TOvl07+oELHLl3fCJaqqfK9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749160097; x=1749764897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dvW1MK82APgh+yzCtjGmO8T/cyoY7t9VZfu4A+UdoI=;
 b=jxQAoKucrsfEyH1vVPK7nLjGri0Z0GPRnQ2LmAkVxkF+/B5SZf2YLenRcJp+iTepRt
 or4HqOhrAFSf1TioXK5v8jHRuJUtbeNsXfLt+SXwKtVN33nz4q++WLNYmrqf2J79KBQW
 kuCNxfCuEckYB6R3SM/gd8oi5iy660OPRXZtG8Fq3SgArxtEBhKzJ9tWF1LYDRDOfDi5
 EfaD4A9+aeEQJQ7z05ux4S6RWfxOuwaFD+kUMhvprvGHkRcSneMH3Bo9PPk16C0BsqU+
 nymA/fvpDZxNadPFYivG366r8V/QisVuUmXyHKzIKJOnC097LQZnx8LwHBO96OvuGKxQ
 2hXw==
X-Gm-Message-State: AOJu0YzTLrYQsvafRRUhQRUczeL8p6k5ezrc7HM4VXRwqjdBzX1wYNnm
 6bbdE/MmLdNgtrlcFFr78nWK+88JB/26ZtGGUpuUY29wm4mENrOQfCjgMQd6Cc9DhP0=
X-Gm-Gg: ASbGncvFSOzSFZ1SFclTZuPXg3DxSh0ebFi/kGbwL1TgAdWQDRps8eMH44yBwCbdtR7
 4bfC0gjB1fTLU5zHPDSNs0CK71CVI0Zz/B/fgB9kTYfti2yVtZQKAH++aUkPx79CJ04iF9a+Dmj
 6uDIz0TggttF6vr23RgusMkGLgClpQpOOen5uBSUHo0N1HhVrfpoCljvHJVEOlQTLQHZa5GtrBs
 phBZKNe6TWYRgBS70+ralswJyQ6urWU+WHyoqLABAb6J95ZzTDxE3h3YY1MP24H+iw+vhJ6hxE/
 ktthE5zwxYdLRIKjfl2bZT9dX1IjiRN0QFql/lCJM01PzfVZaJhr+oS3cfeB9Br6im2aezuGEnD
 pvBUl15+fYakJJcsvE9lKSEA=
X-Google-Smtp-Source: AGHT+IHgYYwG0qcm95YY+lBFwgvp8YXiPej2b+JUCH+U5z9dZO+sKGDfTA4XeCVxeug9loBYnnAeqA==
X-Received: by 2002:a05:6820:178e:b0:60e:e75c:5ef2 with SMTP id
 006d021491bc7-60f3cf49936mr714846eaf.7.1749160096689; 
 Thu, 05 Jun 2025 14:48:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f3e7db22fsm26258eaf.24.2025.06.05.14.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 14:48:15 -0700 (PDT)
Date: Thu, 5 Jun 2025 15:48:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] ARM: bootm: Add support for starting Linux through
 OpTee-OS on ARMv7a
Message-ID: <20250605214813.GA2088131@bill-the-cat>
References: <20250512165307.148434-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PqUsftriKOy6KutR"
Content-Disposition: inline
In-Reply-To: <20250512165307.148434-1-marek.vasut@mailbox.org>
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


--PqUsftriKOy6KutR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 06:52:12PM +0200, Marek Vasut wrote:

> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a.
> This is only supported if U-Boot runs in PL1 secure. This change adds
> two components, one is fitImage OpTee-OS loadable handler, which makes
> a note of OpTee-OS being loaded and stores the load address for later
> jump to it. The second part is the actual jump to Linux through OpTee-OS.
> The jump through OpTee-OS requires set up of multiple CPU registers, r1
> and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
> Linux kernel entry point. This setup is done by new assembler function
> boot_jump_linux_via_optee().
>=20
> The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
> configuration write, this cannot be moved easily, hence the ifdef.
>=20
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

The lack of a cover letter isn't the final problem, because I could
summarize this easily enough. However, this causes a large number of
targets to now have warnings, such as imx8mp-icore-mx8mp-edimm2.2 and
gxp.

--=20
Tom

--PqUsftriKOy6KutR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhCEJ0ACgkQFHw5/5Y0
tywLDAwAiAI1Ilnof01FN2Yz+6qO0ri46qY/Cqb/vyB4XP68duei7yADgg3gv5Gl
5bOMBr5j9ILBJuiDZ1JHFvo5fpUddlb/62D8e3dRHIhx0xXhNLxHix1gwQjpijz0
hLiFeBcC/5GC0/VwnHhUgcqvhWLk5ic6oRxlET4FbfJ1XqGlb6IFw0dxa1z+rTwX
CZcgbiOkAdOcfYTvVosQV9EHhf3WFnl1IycqE/MXQdD4BCsFAoX72GG0i9aF8JK5
/djyvX/rmbOXBPcfWB0JUDPZGgY3zvzM61vLVTXb+RKAdFPuHHKcuhovmz1kCVwp
gn+c9NTZAYAt117tv+pdEGqDTvmWn84m4nLk+ldIZb8rweBqETa0RfKDl5p7SqxX
07ONsPNit1XDy5RHnF4rNXuLTRdu/z4E9TwuvHeMQGCCQVhBaV08mUwqsnhqH7Zx
QCgFIwTSLIfN7rqNYsY0Z/YrOwwZNzZ26b8lLT/eAVPr/pPOfqHJ5m+QYKGbPa86
SJ2L7rzf
=vcmT
-----END PGP SIGNATURE-----

--PqUsftriKOy6KutR--
