Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF22AE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169CE89718;
	Mon,  9 Dec 2024 17:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qM/wLZYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C4989724; Mon,  9 Dec 2024 17:44:35 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1014889718
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b6dd0347dbso23952185a.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733762672; x=1734367472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MedLX/HTNE00d8lqy8vuwQgUjerVjr7MS5Xz5LkTuWI=;
 b=qM/wLZYb39GXzMOdYvY7jajxGLazai/KtB3VYE0sMfrGQ9d1NSDOxi+WVdU7XQztNb
 d38AgaSsCWvmuJpX0rndiE7yNV3c+rpZFB7bp1z5JwRkW2d6JYf61OC7umQG5Zc+EL+a
 PqQO9U/GrtiU8mT/UATNIK1SqxWY1CMcn2+PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733762672; x=1734367472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MedLX/HTNE00d8lqy8vuwQgUjerVjr7MS5Xz5LkTuWI=;
 b=E5uoX6d3gPrLWxbI1kNuoEI5hohKCzK5ZoXXC+kR3p9MXcF9pBItwh3/NjKZgueZ9u
 MHJxRFfpDbO8itq/2tpr0QhMuI470+kocmaI3RCk31e7szYl/BK1XbIywaJjmIwJB+/p
 37THjgnRuGKA+ioafHrb9jrgqag0gErPizN2WihiMd0tZajwWgMJqtxrVrmiSHIAR33v
 efqcap16IIEQfgXlRLH/j+9Zgp8jIfUmcEZ9egsdPLnwHVtewQjAWDN4BDA4J+eMg4a4
 CNjy18hxWogKwVqSXjfOBeZcs0dEnt3a3ay32jPdQwNNVTD9iqyI5dOV3Y1101dVCa2u
 RUwg==
X-Gm-Message-State: AOJu0Yy837j3OKjAo/vmJfdmlhmMK++AsQx5Jfg51jRiUQ2myRLpeUYX
 T9gA0Efqdw5YDlLIhhSm1GBoXdCU90SmEvBtidMmoE9fxxuzmR7jY79xUoef0U8=
X-Gm-Gg: ASbGnctwGF4S/W5pUHLAhWsDJ7TCmncLGuw71lqLR9TwduGtso8eLpTFXoUpz1YzW5c
 1ntevVU5uXf1HDdQNYOwVOM3W4+VcydC4OBPvUVnCuvP4k+RrgT+ky8FJvd5cUAIUg+o1b7DdAU
 FKcgblteNZDfjKj+xds4tlFyK7QGKE0UEnn1VSrLt8EQYxK5KP+orJqlo49jejQPUii3OdPHu+S
 zuRq8yIVA/oMaglXZCwJ/toiGGB4g/c14erOuQoS6wWmpDA+hFl52E=
X-Google-Smtp-Source: AGHT+IELbTlTBYGXGUVMuWyV4KIspE+HfjCyTdHdQG8MO5INRMvPXZuBBTTEBMkKreT2eRQcm934SQ==
X-Received: by 2002:a05:620a:1a90:b0:7b6:d4a2:f11d with SMTP id
 af79cd13be357-7b6d4a2f300mr630329185a.50.1733762671934; 
 Mon, 09 Dec 2024 08:44:31 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6d075d9d7sm169913385a.110.2024.12.09.08.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:44:31 -0800 (PST)
Date: Mon, 9 Dec 2024 10:44:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 0/3] rpi: Tidy up booting
Message-ID: <20241209164426.GM2457179@bill-the-cat>
References: <20241206194130.GX2457179@bill-the-cat>
 <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
 <20241206235233.GB2457179@bill-the-cat>
 <CAFLszThCR3KG+AVCN_ZeVVmKXverd6g+qNnKrt5YbdTy6jEayg@mail.gmail.com>
 <20241207000029.GC2457179@bill-the-cat>
 <CAFLszTiLFe80OQy1q5eVCoZ-v0AhaKUOzdcLsWK9wEwn_SzZ9w@mail.gmail.com>
 <20241207005246.GD2457179@bill-the-cat>
 <CAFLszTju5G+icA4aLWWsYTZaEzZp+qUgvgtZ38azndH+A-6Okg@mail.gmail.com>
 <20241208161525.GH2457179@bill-the-cat>
 <CAFLszTjvozAhrejprXvfoPBKor12p-KZOwvXNHk82Avjp3wYoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4ypYJxAKDBDaU4Bs"
Content-Disposition: inline
In-Reply-To: <CAFLszTjvozAhrejprXvfoPBKor12p-KZOwvXNHk82Avjp3wYoA@mail.gmail.com>
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


--4ypYJxAKDBDaU4Bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2024 at 04:06:47PM -0700, Simon Glass wrote:

[snip]
> OK, yes it seems like fdt_high is a hack. But 'git grep fdt_high |grep
> fffff |wc' shows 74 matches, so it is still there.

Yes, it's something that needs to be done.

> Going back to my patch, do you have any comments about it? I am not
> about to boil the fdt_high ocean, sorry, but I will happily drop the
> fdt_high on rpi, since it seems unnecessary, at least for 64-bit
> kernels. I do see that kernels <4.2 require fdt_high on arm so that
> the kernel and FDT are within the same 512MB section. Is that still a
> concern?

I'm not asking you to remove fdt_high from everyone, sorry if I gave
that impression. For Pi the best option would be to set bootm_size to
512MB so that everything stays within that area, on all Pis and remove
fdt_high and initrd_high in all cases there.

> I'll also add myself as a rpi maintainer since the current ones seem
> pretty busy.

If they agree, sure.

> I am planning to continue with the bootstd work, part of which will be
> to drop the need for these variables. If there are constraints, we can
> specify those either in the kernel FIT or in U-Boot's config, and
> implement them in C code (with tests), not scripts, variables, etc.

At the high level, yes, something like the approach EFI takes where
there's not a need to relocate things after loading them to memory would
remove the need for the variables that say where things go specifically,
and only have the need for knowing what memory the OS will be able to
see initially.

--=20
Tom

--4ypYJxAKDBDaU4Bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXHmYACgkQFHw5/5Y0
tywMeQv/XvOqiKD20GaBZTYc0rgrySRspXgIyUzAxcag+qNkFB/h4fXAdKEBx/hB
gvqw8+W4AH5RLXfzWar2TIXbFm8f/v9SK3ulDiqbqNz6vXBI4A7MOQdlBvNExkBk
N9UdPLoAwX6zLc6I3D7JQ/I85N1D8YhZkBgvwlDIBA7QaxFZ4HVDLiODLwahUUuM
j4vFxJ67Iw9+SyihtGqtPVfEwrp9AMKTSPZQCxU5jxxz/Xl5CxcgaSVyGTKFkVm7
zzZcAWMDNRlb0YVufY71mmeQrEYSkERsxK/FVZ+fpJAHnB+v6loqZCRU3toAlVlz
faN0ZRxyqdKbIQ/ZiaY2wxMSab1Cw87D/piaLGHJtWU0viukohhEAbRDCKreTuaz
ZWm6OJfr4Lsj8QRfshY+1ggFdzsS9+8mWKYm+I2fZxwj+WRcDrFwbJyheHaE+km4
cBoJdfno8lRK6Tp/rUTa+4sCvWeayt+WFSyxmM0tHqOrIFqD1D0KGbaOnnxruCbG
3SFfZX/L
=cNew
-----END PGP SIGNATURE-----

--4ypYJxAKDBDaU4Bs--
