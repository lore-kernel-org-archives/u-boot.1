Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1192BD26D7A
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 17:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C86784248;
	Fri,  9 Jan 2026 18:10:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kUvOUKb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC3284248; Fri,  9 Jan 2026 18:10:04 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233F484206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 18:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7c6e815310aso3579838a34.0
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 09:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767978601; x=1768583401; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ovlQJ5DjNZKPHOs08lMR1o09vWD3qC2GUH+fiaU3Tjs=;
 b=kUvOUKb9+doYO3cv7kjPZhU0kBQV1/8+3G3TSqhNIrXbQPOmPO77B0PmDuXi0X+kcz
 1qyL+nKqPM89seS7Clp4Sr32lZ80z67QoV8ka2mWhTBjnRiHlGlstB2bXUfQQQnGILfE
 xzy7ozulTw2t7Bj0hQnALzQjNHUu8O9qqS31k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767978601; x=1768583401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovlQJ5DjNZKPHOs08lMR1o09vWD3qC2GUH+fiaU3Tjs=;
 b=QH5sEVJBL6eNh2yEfC0Cu0xIR1i5HsnLUes2FkJBULViP8qbZsP5qd1CXuf0ETx7Ri
 GJnjwdr8qF9xp54RO0S0Mm5o8+bkPnQFuTP7Kj//g0ggySbPG79P4+VF+uyVQDBnD3R3
 rcprpWJh3XuFfWQwzlQ9ralxNJ9BZElQ2NJzUZnz4G36br7CQCxVleZqFppFrw+AQqRQ
 HR5xsqpPtu8H+/2zhvdB96D5KRIsid+DsAETd+Ys7Ouf5eexVe+Gv+94LjrHNY6laSLd
 eQ5Pmdk9AZBeD2dSlOlvGyJdN9vGk/AhmzYBmYgr+8DfhJcOmoay0h0+GmoYY+HsRXMb
 99pg==
X-Gm-Message-State: AOJu0Yzfa8IZnOyrBJrxoD8WdUrxdO1flUJHWy3AEaW2JeKwUrP/GMxq
 a1zqNY2I+EXone4zlqDISOVvAc6WFImo45T7R9U6AFoJax0o9zs0wUGgWL4zRFU9SBCDy8mW3/T
 KMcictOk=
X-Gm-Gg: AY/fxX4X4HNC4jWv3FrKtQcnlCzm7ZfoFeOSTByv6yJPmGYTrRMLO29AljWrVnyFZwd
 wSFHFBjzud1pdpawG3xYeHkB5K/dP9GNPzy5lzr5/p9MB8laxJlFA/qoqbm3soOh/3EANymdVyA
 VOpdlQBcGwzZyj9km2eGoh68fJ0A8Q/dztO1Z/amLrGXNfga6PBPjiTGr0qImWchGeuLrHDzEEP
 Tz8vZ/9TbWcbK1m2J5EoxCvgV+Fm1PQyTpZLS37X9t1R0M/gJ/gvUZaSqyf+ZO5TStMm5brzw4z
 snfeplpEVUCnqNZNPewZxhCmnJ521YzHKerIhzjZwiQwPj4Fs+EMVqEV4OT6gRiqs7qzZRpqmfk
 oH5W9IvHWzKOItG2qNYr5h9nsqx0dMjrSXfdlHS3uqlI1WiW+JGjvEg0O6jjv5kbMADWGKgizDM
 lwTpTU9ksITx6EmzC76uzbS0XJ51f+AySE/4QjRh7RIvK5hdHLEAvTnSGQMLahuatm+ff6RCfs9
 b5qT+vGq3rhrOt57nbdM0+aSHCSZENq3LSmFzc=
X-Google-Smtp-Source: AGHT+IHkTgBGGcl6I3dxejxzrOg7tSLOZbGPwCaEseRqnI29lLe1Uxr8lshEzRIXBGuBFBK2osf/Vw==
X-Received: by 2002:a05:6830:90f:b0:7c7:2cdb:ff4b with SMTP id
 46e09a7af769-7ce50c0006bmr7262828a34.20.1767978600542; 
 Fri, 09 Jan 2026 09:10:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478ee668sm8063822a34.29.2026.01.09.09.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 09:10:00 -0800 (PST)
Date: Fri, 9 Jan 2026 11:09:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuri Honegger <yuri.honegger@icloud.com>
Cc: u-boot@lists.denx.de
Subject: Re: Placement of FDT in memory
Message-ID: <20260109170958.GE3416603@bill-the-cat>
References: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PCJ0SFlWZlzgVOj5"
Content-Disposition: inline
In-Reply-To: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
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


--PCJ0SFlWZlzgVOj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 11:04:59PM +0100, Yuri Honegger wrote:

> Hello,
> Recently I've been playing around with the imx23-olinuxino=20
> (mx23_olinuxino_defconfig) and booting NetBSD using u-boot. During that, =
I've=20
> noticed that NetBSD panics because u-boot places the device tree in the B=
SS
> section of NetBSD. NetBSD clears the BSS section and then complains=20
> that the device tree is corrupt.
>=20
> Reading the logs, it appears that FDT and kernel get loaded at non-overla=
pping
> ranges, but then u-boot relocates the device tree right after the kernel =
into
> the BSS section.
>=20
> ## Booting kernel from Legacy Image at 42000000 ...
> Image Name: NetBSD/earmv5 11.99.4
> Image Type: ARM Linux Kernel Image (no loading done) (uncompressed)
> Data Size: 11950164 Bytes =3D 11.4 MiB
> Load Address: 00000000
> Entry Point: 00000000
> Verifying Checksum ... OK
> ## Flattened Device Tree blob at 41000000
> Booting using the fdt blob at 0x41000000
> Working FDT set to 41000000
> XIP Kernel Image (no loading done) to 42000040
> Loading Device Tree to 42b93000, end 42b99a0a ... OK
> Working FDT set to 42b93000
> Starting kernel ...
>=20
> The bootm command seems to insist on having to relocate the device tree.
>=20
> Is this something the OS is expected to deal with?
>=20
> In the meantime, I've managed to work around this by running
> env set fdt_high 0x41000000;
> before bootm. Is there a better solution than this to force the placement
> of the device tree?

So, interesting setup. It's not a FIT image, it's a legacy image, so
there's a few details missing that might be helpful here. But, why are
you loading the image so high in memory? And we're calling it a Linux
kernel, not a NetBSD image, so we should likely be updating our docs for
booting modern NetBSD releases.

The big problem is that for a legacy image, we don't (and can't in
many/most cases) know where the OS ends it's BSS and so have to hope
that we're relocating to the correct spot (in other cases we can see
this overlap and avoid it). At
https://docs.u-boot.org/en/latest/usage/environment.html#list-of-environmen=
t-variables
we document all of the environment variables and bootm_low / bootm_size
/ bootm_mapsize are relevant to this case, along with perhaps just
loading the kernel image lower in memory to start with?

--=20
Tom

--PCJ0SFlWZlzgVOj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWE2YgAKCRAr4qD1Cr/k
CuBdAQD23G6lRHi/7f4eKXbMnPke/CzefpSyzX2ORWY0j7TGsAD9FWWjJfTNKNIK
Wwv0rJD502NYYdKG93y4JhKgGYtIEQo=
=bsXl
-----END PGP SIGNATURE-----

--PCJ0SFlWZlzgVOj5--
