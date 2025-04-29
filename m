Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16A8C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 19:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10F8829A1;
	Tue, 29 Apr 2025 21:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KMHb6LFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC9282A64; Tue, 29 Apr 2025 21:14:12 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4971782958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 21:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60219a77334so3327294eaf.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745954049; x=1746558849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yuk5jqHqV5tRuMqxHiHEeQFOFX+Nf+eBjTbA25EjkH8=;
 b=KMHb6LFTYSSrkukJXWQ9DWEbAHCK6+m62f9PaZ46aCNTPp/Y/pp99/3hedXk8jSray
 gmqH6Gd51J6RtaXWx/kH3XUmmsQXd11FK9wdy/MWMOisms18072Qll83HDcFE+oXzMVo
 91oKoZEXIjWstM8iKvbyjXCd0gFt3V74xOhng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745954049; x=1746558849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yuk5jqHqV5tRuMqxHiHEeQFOFX+Nf+eBjTbA25EjkH8=;
 b=sTAuhb9/O0VmGmlpS22WwTMrS7eIuFuw36XHrCeWU0LklbBbYHjtUxkUOxw6Elzger
 DKD5YCgsxWVrOEBSKc529n/YsXWkqg8S3iWb7aagKLZRaOF/jH3Th3OjxQs90rkBCABU
 JyB3SKNklrDydvy3a9q4oAVFz3qJlAxuzChWVaRmUhwXDtOGT3wq9f8VfqG3poZjW7zF
 O/G98yunPjvK7jw2nJ1o4/O/XuxQm8YAQ9fGN5mrUKvhxfJovFX2PtUEzIJu0KZVFOl5
 NLd5r8+bA1PBaqO81eMztGxK8c2beQ4VfKaYfXY3pB9YhDfhIWlFkOMqBRZVGjpM48Cz
 9JgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjCKCzeyMq11NMFWTzACvsY0+irTF8GNh3T3+NNKmWnL9YeyOhkJSIM0IBRDRuiencAnNJeN8=@lists.denx.de
X-Gm-Message-State: AOJu0YzBGqe8XQL5+fTO0MRb7kWX+io0PsmZ7lKgxr/rImEX0LYzw7IX
 5JWswQsVyD6S7oADG3EHtCagPRnYclEJWyt4TuSG0EC95Qdi83A7/MEMyLbx0aQ=
X-Gm-Gg: ASbGncsFyXa4qdcx/nmTd61FzDqRaKAAMHhQYgjNhTNguUeB8g/6H4urG8BZiEAn/OV
 L3YbdvbB74e88ayB6tBA6I8gXEFyrDgPRNhUL3jX1ALh7gUmOadqeEjaFH9WVRn8fI1GUzlKJBQ
 540wrVY/u062NfH//D64QrphPunPdEzqAvVsdK0XkD9+yTtJUMp33pFvhTtzLuVhijwh4wWekHm
 SG8zea5kbZOppnwAiMQ3OhEF+GlPiG6GqGInPcd+HucZt4FpaANxovQJsIhtgdjm0qov0Vy1RSM
 EEt6vaOfQYY8hFHDvkXKhYdXxnYHqVFNA9pR0GEiWKdB8OkOeKTmOXPvoDGY5kijcvLqBzTtQzs
 Y2g==
X-Google-Smtp-Source: AGHT+IF0OzRP4/+QfFLcBT+B1bqAQBbqx1799wrAFRhJWdVa2O1w0HQBD9xQKXs5bPmY30Lob/stdw==
X-Received: by 2002:a05:6871:7416:b0:2b8:3c87:b491 with SMTP id
 586e51a60fabf-2da6a3433dfmr144313fac.26.1745954048816; 
 Tue, 29 Apr 2025 12:14:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973b7959bsm2926907fac.36.2025.04.29.12.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 12:14:07 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:14:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Nathaniel Hourt <I@nathaniel.land>
Subject: Re: [PATCH 1/2] Makefile: Strip leading spaces when preprocessing
 generated_defconfig
Message-ID: <20250429191405.GK1261075@bill-the-cat>
References: <20250427145011.17331-1-ziyao@disroot.org>
 <20250427145011.17331-2-ziyao@disroot.org>
 <1526A781-5592-43DE-94F2-221DAA484192@gmx.de>
 <aA5RcIbI7uhsGmu8@pie.lan> <20250427161627.GZ5495@bill-the-cat>
 <aA78p0FgCZYmoeBM@pie> <20250428144943.GA5495@bill-the-cat>
 <aBDGoWxfU5I2_ZXs@pie.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fMUJCmjmCzsUcew5"
Content-Disposition: inline
In-Reply-To: <aBDGoWxfU5I2_ZXs@pie.lan>
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


--fMUJCmjmCzsUcew5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 12:31:29PM +0000, Yao Zi wrote:
> On Mon, Apr 28, 2025 at 08:49:43AM -0600, Tom Rini wrote:
> > On Mon, Apr 28, 2025 at 03:57:27AM +0000, Yao Zi wrote:
> > > On Sun, Apr 27, 2025 at 10:16:27AM -0600, Tom Rini wrote:
> > > > On Sun, Apr 27, 2025 at 03:46:56PM +0000, Yao Zi wrote:
> > > > > On Sun, Apr 27, 2025 at 05:19:04PM +0200, Heinrich Schuchardt wro=
te:
> > > > > > Am 27. April 2025 16:50:10 MESZ schrieb Yao Zi <ziyao@disroot.o=
rg>:
> > > > > > >Clang's preprocessor may emit extra spaces for lines starting =
with '#'.
> > > > > > >Lines with these extra characters cannot be handled by Kconfig=
 and will
> > > > > > >be ignored with warnings like,
> > > > > > >
> > > > > >=20
> > > > > >=20
> > > > > > Do you have an example for reprocing the issue?
> > > > >=20
> > > > > Sure,
> > > > >=20
> > > > > 	clang-19 -E -nostdinc -P -I . -undef -x assembler-with-cpp \
> > > > > 		configs/starfive_visionfive2_defconfig
> > > > >=20
> > > > > or a smaller example for demonstrating the behaviour,
> > > > >=20
> > > > > 	cat << EOF | clang -E -P -x assembler-with-cpp -
> > > > > 	# comment line
> > > > > 	normal line
> > > > > 	EOF
> > > > >=20
> > > > > and you could see the strange indentation. For reproducing the ex=
act
> > > > > Kconfig warnings,
> > > > >=20
> > > > > 	make ARCH=3Driscv \
> > > > > 		CC=3D'clang-19 --target=3Driscv64-unknown-linux-musl' \
> > > > > 		starfive_visionfive2_defconfig
> > > > >=20
> > > > > (Clang is called clang-19 on my machine)
> > > > >=20
> > > > > > Is there an understanding why Clang behaves in this way?
> > > > >=20
> > > > > Sadly I have no idea. I guess it may serve for improving
> > > > > human-readability of the preprocessed output.
> > > >=20
> > > > This is https://github.com/llvm/llvm-project/issues/78778
> > >=20
> > > Thanks for the reference! I did a quick search among LLVM's issues
> > > before sending the patch but didn't find anything useful.
> > >=20
> > > Do you think such workaround is acceptable? It seems the link should =
be
> > > included in commit message as well.
> >=20
> > I'd like to see if we can get llvm to fix this moving forward first. Can
> > you please comment on the issue as you're hitting this now too?
>=20
> Sure it should be fixed in LLVM and I've left a comment in the issue.
>=20
> But even though it's fixed in upstream, it will be nice to have such
> compatibility workarounds for some time to keep compatibile with older
> Clang toolchains, about which my concern is most.

Depending on what the LLVM people say, we can say what / how long of a
workaround to keep in.

--=20
Tom

--fMUJCmjmCzsUcew5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgRJPYACgkQFHw5/5Y0
tywyuQv9EiV68Uhu23zjPaVjjctZz+mZxCctwZ0KbK8gTGlbotDnHnADv/JBsSDg
N1RWxcCRp7dcBqNdotno4GJoCXyikLI34DP04jsJnor2nsjVm4D/0q6cmwPASEHk
BQWI5+1sdjnPhqfZr1S9tpy8CdaSPMeblAoFyN5hQajbXTt89ZQCVpWgM8y7/oA8
iBp/pw51+P1fhPDgpnP6d4jzj/P7sjiTiHeamO78UymakHLTHa1CnrbozPpK7h5p
/zuGvYHhpWfhlfDwPqFW+1rA7NNs3wDJTS4QkbVS+u01O63goLBmMdtTzbCr33EI
L+/a2cVkEM0kUMDlWNjBQ1/DGilpQfImLRhUexpv/CL55RHeEGKgxWmenkh9Lykp
dEixaFSsFpDyIM6R+8rV+MFyAM3nZsYugpEJZpFSKWc21+cDBoorvHh7TgUb6rIW
naze2c0Oh6nQVPSv2plmY3qO/Tou3U5Gg2VRDVEKi3IOFPugMAqC14oVvFirWre3
RHSjVtds
=b7K/
-----END PGP SIGNATURE-----

--fMUJCmjmCzsUcew5--
