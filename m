Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBAEEE6B43
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE7B83A64;
	Fri,  6 Feb 2026 19:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XRZ0oKS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B614183AA7; Fri,  6 Feb 2026 19:00:42 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DB4836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-408778a8ec4so1979408fac.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770400839; x=1771005639; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wEamugUF1doRd6vqgYW1m0Z+Q914q8EWCEZnE5LVexs=;
 b=XRZ0oKS2EBaH9eRSjfBYtLll9bLPy6oAX8PQ3NUEE4VhwoQA6ziDQasJLHolwbmyKq
 m3x6y/fVyMQ5fiUUBdQ/X1pdCztXwivyYudWQUtgEshoXjBbvs6uefHq8wOADrR9KDuk
 whhQDZZajqz6oUUCgvUKGrq9HeogYaG9HPel0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770400839; x=1771005639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wEamugUF1doRd6vqgYW1m0Z+Q914q8EWCEZnE5LVexs=;
 b=uBPLsZRqQZGpALnqhxujpMzUe0f92C85Lo7hRvVgiJkpIkeh1sO/gpdR77kE7RGSYt
 eYhyAKS8LWf/lt+BxXQ+5VxFVyip6+2LOdfw5m7y5qBWZx91293O44icdvzAYgrCmHi3
 uwoJIoRfAtUo0ZcIG2gWp+CXxUA4t+Is2RAyKp7uWsK8mlGrR2uQM9b/Fa6Yo2OPN8VD
 z5hzGdiSKvSzrzg4EwKLIBFetied736bk23dw0hxl2sZHC/plQcSeFMp5PN42drg/aUT
 CU73r5c4SOmlkI1GKSzU1s571Z6OznfXGZjyopnCrUMdPnLuz8s6L87E/kCbEUvnmHsj
 GtfQ==
X-Gm-Message-State: AOJu0YympCD1j4QAm9z7RD9DGytJNG1FOwTM5hDcaRYxkra/PkAoDMh7
 jiZWKHJtlVTsJmpPqI6siD8JGv9zNEyLY7kBhllWfmdUWyAdGLaEVsinpXwNh3FdLMM=
X-Gm-Gg: AZuq6aLn9ftmHpVC2kHVLzrK4BtXYs2VgkX6vc9kyUriMNHaPEU32J5BYzXNvkhVkXB
 qg2hGzj7fyHy95+ZULSwEH8Cd7IJeqpkARzcaUzInP4FcYrjdMBZjm/lZTIp8rq8yvkJm0m/1P6
 E/wT8aVS9Tsy/IYK/LlmyzWxhw169XGCo++OGsCspIzF0bazje/ijHOh0vsCergM/20OXnAHQ6F
 RtvHoYyqpiUVDFO33B1Ibzu/YuWZtSAn84Kp1b4X7+j4M6N5hj6EN18nVFa+XQvuj+fQ2wglcfZ
 xzL0En+0siTKW0YekppJSZvoCy8Bj36kD58Ljm98GaN5Y/NXMAoFLLAN0Eenvh5J+sFdzw3QRyx
 jF8+Nm+eEW8FXtTWpqHYL09q50GXXZ671JAC4+NtQbZ7VPzLHRcy89SbQ/N7WLWFEDKDK6wg9/Y
 iXCnvivkJGUtk0JtMd5E6nH65KpujOAtGNvT3VxL8QyoaEcAbwhvSYyF99oZx7Gtf2JLgMgkXco
 qSjoMKq0dNU1FltsCKTRuHYgY+SPymGQ1WuB5c=
X-Received: by 2002:a05:6870:41d4:b0:404:3bb4:46c4 with SMTP id
 586e51a60fabf-40a96c97e83mr1879583fac.19.1770400839032; 
 Fri, 06 Feb 2026 10:00:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99787738sm2250609fac.15.2026.02.06.10.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:00:38 -0800 (PST)
Date: Fri, 6 Feb 2026 12:00:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Brian Sune <briansune@gmail.com>,
 Phil Phil Sutter <phil@nwl.cc>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
Subject: Re: [PATCH v2] arm: spl: Ensure 8 byte alignment of appended DTB
 without separate BSS
Message-ID: <20260206180034.GW2603314@bill-the-cat>
References: <20260130183635.2612933-1-trini@konsulko.com>
 <20260205234158.3768337-1-trini@konsulko.com>
 <d3550af8-04ba-4cca-a062-5973f9dac251@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BqWpx0guGBCL+t0S"
Content-Disposition: inline
In-Reply-To: <d3550af8-04ba-4cca-a062-5973f9dac251@mailbox.org>
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


--BqWpx0guGBCL+t0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 06:09:49PM +0100, Marek Vasut wrote:
> On 2/6/26 12:41 AM, Tom Rini wrote:
> > Historically, when we have an appended device tree and also our
> > resulting binary will contain the BSS section, we have ensured that
> > everything will be where it's expected to be by declaring that the BSS
> > is overlayed with a symbol matches the end of the port
>=20
> part ?
>=20
> > of the ELF binary
> > that is objcopy'd to the binary we concatenate with. This in turn means
> > that the logic to generate a "pad" file, which is the size found in the
> > __bss_size symbol, will be correct and then we can concatenate the
> > device tree and it will begin at __bss_size at run time.
> >=20
> > With commit 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
> > we removed this overlay as part of trying to ensure that we met both the
> > requirements of the device tree to be 8 byte aligned as well as that our
> > logic to generate the -pad file would match what ended up in the
> > resulting binary. While it was correct to remove an unused section it
> > did not solve ultimately solve the problem for all cases.
>=20
> solve ultimately solve ... one solve is enough

Yeah, oops.

> > To really fix the problem, we need to do two things. First, our final
> > section prior to _image_binary_end must be 8 byte aligned (for the case
> > of having a separate BSS and so our appended DTB exists at this
> > location). This cannot be '.binman_sym_table' as it may be empty, and in
> > turn the ELF type would be NOBITS and so not copied with objcopy. The
> > __u_boot_list section will never be empty
>=20
> How can we be sure of that ?

That __u_boot_list will never be empty? There's too much non-trivial
code using it.

> > , so it is our final section,
> > and ends with a '. =3D ALIGN(8)' statement. Second, as this is the end =
of
> > our copied data it is safe to declare that the BSS starts here, so use
> > the OVERLAY keyword to place the BSS here.
>=20
> [...]
>=20
> > @@ -99,5 +99,6 @@ SECTIONS
> >   ASSERT(_image_binary_end % 8 =3D=3D 0, \
> >          "_image_binary_end must be 8-byte aligned for device tree");
> > +
> >   ASSERT(ADDR(.bss) % 8 =3D=3D 0, \
> >          ".bss must be 8-byte aligned");
> Please drop this extra newline ^ .

I'll fix that (and the port->part and solve) when applying, assuming no
feedback from the toolchain gurus.

--=20
Tom

--BqWpx0guGBCL+t0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYYsPgAKCRAr4qD1Cr/k
CgqrAP9cxMEZK/zBcvHrCd2VFprHBohIH454Z7CgXPJBjUhFRAD+LCVPW2KXok4y
KM7oaklKb+y1E6a5esDDWy0/wjTQkw0=
=M0f5
-----END PGP SIGNATURE-----

--BqWpx0guGBCL+t0S--
