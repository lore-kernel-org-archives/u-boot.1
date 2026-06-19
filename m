Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D126CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 20:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A6C84873;
	Fri, 19 Jun 2026 22:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KiOBP1vv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 555C7848EB; Fri, 19 Jun 2026 22:04:27 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30ACD801A9
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 22:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so1396714a34.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781899464; x=1782504264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NbsxBVQPAdiLJASbw8F2clC/EmmVY7x5qwbT2NF4SMY=;
 b=KiOBP1vvnEl00MWRX5J4ELsauLoEf3+C9YzGNhewTeZfHDHsIS08ATJU7Id5j7DyLc
 um/mJWdy0nEJ6bkmkUYV0YjJ6H75bn1vFw9jI7mIywjfc3u0qMSTo42iBxLWqJbKs18X
 jwfTQXxw8dUgO6QyQ+Yj7fxNbae/MvGIgLF9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781899464; x=1782504264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbsxBVQPAdiLJASbw8F2clC/EmmVY7x5qwbT2NF4SMY=;
 b=XOk/KzclF9m6La0iS0FolxC+FJgCttwwM9NaqD1IRlX6d5ifAyamch1gp2iG3csuWQ
 W8UXBkyqoKqTbkMEX8BRhweNCm3fl/YIpLkC4gsArRI8zMl5nsIciF2grPzTRyg7DMhF
 lzUmrfpGpPhawX6qqqR1GeXhSQ61wX0DIG/mA3PbWXz3eX/dK4N+PbGCsK/8JbqTgGUa
 +F0GOsNH+lru/9V1J17hGQb0Ep2YfCRycZkktPnPI0NKWgipqcz9JtoN7tQC+ZdTp+A/
 bAONhYf0HKEKX2icFXzQRHjC8bSOmJ8uJe0w/IWUqJCq3nrpTp5D1nM7zx5IKfpF1nOx
 /R6w==
X-Gm-Message-State: AOJu0YwCQY4vibNtsEwZwCAdrUl0+gXL1sjaa1JZBxvD1olUuCgdboBK
 A2GWICeNTruFIrFK8U3OEgcceaw9mp6WqVezxvcn5Xv2Qkar1rVhzkIQEtpipM4qgbE=
X-Gm-Gg: AfdE7cllrjTGLPxufYSOo6iBpEGkoDQyd2d6ojFgUG1hEW/gEfFFr41HIZaNzvvy309
 MKEDMVFqEbzvGRvnGNQB2jGKQseSLdSqSqh0GzAhPAqz7HJiILEWq8BAgqJbpQAFXPDdDY6hxpp
 GW7KnANOKVYO5l9ssWHJdQQBNmV+aIii/E85u8sddnK9gR1rpnTQIzGwwtLk1JpgU7HLDZjm003
 tS9C1Hiik+cEdoN7V70X1y1Krhrx1en6nD824LBwhYF5wEb6S5KihbGJqOYHwbDBwwK9/Z7ZiB8
 XUtxBllNw3uxXpCgaahXi7ASrKWbntcFVVfxB7Q+gj2X3E7CoqQxNrVJINPtCTNb1vR2ySbpzl6
 Y+MxQIn8i4b0jkHM70k7yU9vsReik+PuzUytLwN1rEKS5Ni2UlOuUMm88923E7enpCZIimcO5dS
 iV8zQJfLcfRgA3CSNp8Ay+0SkwLx+dCnYLZZ0zdGKtr7dMSGtu/pIevK4OJcCpEWhJoGT4D4Yxn
 AOTmDdFcbEZhoHvUemkpPWHqEpZ2IO9T6GoGXiY
X-Received: by 2002:a05:6830:82d6:b0:7e6:50c0:87a6 with SMTP id
 46e09a7af769-7e92d83a030mr3720265a34.8.1781899463853; 
 Fri, 19 Jun 2026 13:04:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-189-154-245.totalplay.net.
 [187.189.154.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e94429a5bdsm84706a34.22.2026.06.19.13.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 13:04:22 -0700 (PDT)
Date: Fri, 19 Jun 2026 14:04:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Strydom <qstrydom0@gmail.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 james.hilliard1@gmail.com, malysagreg@gmail.com,
 tien.fong.chee@altera.com, sughosh.ganu@arm.com, philip.molloy@analog.com
Subject: Re: [PATCH] spl: pad external DTB to _image_binary_end with separate
 BSS
Message-ID: <20260619200419.GW382693@bill-the-cat>
References: <20260619105529.50815-1-qstrydom0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6fwgwpAU+niKGwdx"
Content-Disposition: inline
In-Reply-To: <20260619105529.50815-1-qstrydom0@gmail.com>
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


--6fwgwpAU+niKGwdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 11:55:29AM +0100, Quentin Strydom wrote:

> When CONFIG_SPL_SEPARATE_BSS is enabled, fdt_find_separate()
> expects the SPL control DTB at _image_binary_end. However,
> u-boot-spl-dtb.bin is currently generated by concatenating
> u-boot-spl-nodtb.bin and the SPL DTB directly, without padding
> up to _image_binary_end.
>=20
> On evb-ast2600 this places the appended SPL DTB at 0xc92c while
> _image_binary_end is 0xc930. The SPL therefore checks four bytes
> past the FDT header and fails early with:
>=20
>   Missing DTB
>   No serial driver found
>=20
> Add padding between the xPL nodtb binary and the DTB when separate
> BSS is enabled, so the DTB is placed where fdt_find_separate()
> expects it.
>=20
> Signed-off-by: Quentin Strydom <qstrydom0@gmail.com>

I'm glad someone has been able to test this on hardware now, and I'm
sorry it wasn't fixed when dealing with the rest of the fallout here.
I'm not sure this is quite the correct fix however as we should be
ensuring that output file and _image_binary_end agree. What sections
are, and aren't being included when we create the -nodtb.bin file? I
think the place I ended up putting the '. =3D ALIGN(8)' in commit=20
8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device tree
is aligned") ended up not being correct on this platform.

--=20
Tom

--6fwgwpAU+niKGwdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajWgvwAKCRAr4qD1Cr/k
CoAWAQD4AIxUs1lVJ/c+PzQZix9ERRqs58mOYcQGOLiSUM0CVwEAlFL6U2Gnm+UD
i9/7UwMOK8k2CxY4Rx+ed9TqSmCIzwE=
=6LzQ
-----END PGP SIGNATURE-----

--6fwgwpAU+niKGwdx--
