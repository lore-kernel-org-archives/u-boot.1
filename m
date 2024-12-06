Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9795E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B1E89608;
	Fri,  6 Dec 2024 15:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GVw+zXOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A327689610; Fri,  6 Dec 2024 15:09:01 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCD189608
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d8918ec243so21595976d6.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 06:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733494138; x=1734098938; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nF9UhGhtb77M+wgVGpfXaldb1p7+8qAXraHzfJWvTq4=;
 b=GVw+zXOUSCIAap3OfJk5/6sCQQZahIY0jHuBKJvS3gy9Iir2pJtp3vFXYvuwnKg6JY
 RNC6FJ8NBUShEL5ozUko8aUj/oJW/O/74VHuNMgnLgG0NWg8ah6LUCG7LFugbklkjHeY
 niBBLdKkL6f53lEVfPKX8eEggFvk/mEY7fYGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733494138; x=1734098938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nF9UhGhtb77M+wgVGpfXaldb1p7+8qAXraHzfJWvTq4=;
 b=CewOMGuzKeXW8lRMCOixrsQ2FTEPUUdn17HpFScFKA+PoHYV03kSyRChXo6VFvD6Dv
 ajgCJOsHzO1diyK/OkI3RHUfgd4N1CY//MEHRx/ONa3N4atmSWLAuHJP4herTOZ4mMXj
 rX/yyyMs9gwEpXjyLnmDPxprIVBbp55qf+iyXwzelG6YyWo1YPtRukWF3efS8Cc6/EKy
 7wheSpWad/WkMI2zGVuUROcMAq1Pm0U6lY/FkibIwbtIz+NDCGqqci9Ivs5ueRxe8wud
 2Bjnd9T5hfUbJivEQk5n/2gJL2e4VSfpL+C6uKqgKD/6MVisTPI80sqIqkigN333ArL1
 CWMQ==
X-Gm-Message-State: AOJu0Yzih4lkI9HG89uAdKgnay+9Y6Sfglkv2Q6cCdjbTXGSy9AOURUF
 c1d/lu6xy4DOcl62i2Khgf503mcDtmT4zT0Y7llipGINZQUxpDYYPpQfDXBfrgo=
X-Gm-Gg: ASbGncsdF5mXnIygeq1IngMMosB0IF8wJeq8Svijumqn2bVuB7mEjPBMZ886XrE9Tzv
 A9/UkoyKZQD8QG4waRHFu+9wjY5Lp/cVb3wPwNJ+gQRjD0xaGKCda1WknbnwLbl7mGDLjnPqgM+
 w/i4LEWSvqSjpGhy3NyfrwS90WLCg02I6Abt3aR1NoODmpH4VQcAkqWOAUQsqYQXWHQWxstGK9S
 3Pv7XVseYZs8Chj13mOcs56WQg3SblrtBin5QGMIuQGOI8iAw==
X-Google-Smtp-Source: AGHT+IHO2w8A5ok4c4ff9TftGQSprmqtV3xQdjWjnIRWjbwP5SFjU3rJ9aVyEY/E7N3iE5H/uOBxIQ==
X-Received: by 2002:a05:6214:cc9:b0:6d8:7e5d:ef1c with SMTP id
 6a1803df08f44-6d8e7125be2mr50639896d6.21.1733494138139; 
 Fri, 06 Dec 2024 06:08:58 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da9fe7f5sm19124126d6.80.2024.12.06.06.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 06:08:57 -0800 (PST)
Date: Fri, 6 Dec 2024 08:08:52 -0600
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
Message-ID: <20241206140852.GO2457179@bill-the-cat>
References: <20241206131113.2865416-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OfMUtPZOxik/FOvQ"
Content-Disposition: inline
In-Reply-To: <20241206131113.2865416-1-sjg@chromium.org>
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


--OfMUtPZOxik/FOvQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:

> This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> ramdisk, by expanding the available space.
>=20
> It also tidies up some strange behaviour with the provided FDT, where a
> separate pointer is maintained to it, even though U-Boot has copied it
> and placed it in its own space. This avoids strange bugs where it
> accidentally gets overwritten when loading a file into memory.
>=20
>=20
> Simon Glass (3):
>   rpi: Update environment to support booti and large initrd
>   fdt: Allow expanding the devicetree during relocation
>   rpi: Use the U-Boot control FDT for fdt_addr
>=20
>  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
>  board/raspberrypi/rpi/rpi.env | 10 ++++++----
>  common/board_f.c              |  6 ++++--
>  dts/Kconfig                   | 11 +++++++++++
>  4 files changed, 29 insertions(+), 18 deletions(-)

My feedback here is the same feedback I gave the last person that wanted
to update the Pi addresses, and I forget if they came back and did that
(and it's in Peter / Matthias' queue) or not. Disabling device tree
relocation is a bug and must be removed.

After that, given the range of memory sizes available on Pi platforms,
allocating the kernel / initrd / kernel decompression buffer at run
time, ala mach-apple would make life easier in the long run.

--=20
Tom

--OfMUtPZOxik/FOvQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTBXAACgkQFHw5/5Y0
tyzUjwv9EyBlav+nhnSDElsvI/Y/EVsOy/jACfi7lBH38jwkguOOtXKutJE9FW8s
kjRMDx5DqUOvVYEFwSUcgq/XYTdpi5ZoOCfcVrCpZ+u8OpZ7dD5TKwYR3/UKa889
9qrLMbABhBk4kWpI67syRBpVWAZLuh9+e2oAXcnL0TyD8cwBYK/BmD8+CQj0bBg/
rUkfA9FNeWMi0hcUbxvcBTy0/W3LNOKwkZnZJiVubPnRpWKDffn9z5U1MMdrc6pn
y/QNyGO+jckEdQDfTdEFjgzeXnC4qAjw3u8vBrVTFoyajrPr1Pv54X+S/F58B6R6
qPyNh2aS6bhOiKjJ2napdjvfWVLios5zDFb5zABUQ/gU8WWdBfaELCgTacVvRqPE
9pKgBe5VlO7irvseB97RRKm6yhigNi+vZ7j5ZlYbxTg+73PuEXMczdM/DM7v1XKB
SFasjxTINLac2sKLNNkx8Xt9C1qTHQe0FaSaxim7vNIhqwCLmSVrGb07PBMb9cP+
xWacyhUC
=lWxm
-----END PGP SIGNATURE-----

--OfMUtPZOxik/FOvQ--
