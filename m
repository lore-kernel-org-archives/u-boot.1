Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0B3C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 13:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4DB82C55;
	Tue, 20 May 2025 15:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MJznTnYT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ADD982B00; Tue, 20 May 2025 15:57:27 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F0082C55
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 15:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-60657f417c4so3073570eaf.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747749444; x=1748354244; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6jMVQ2qBi0yQVW0lMJPFKCZY2LzBv/Hxy0hWJz9GLdM=;
 b=MJznTnYTkJ47MSXgprNGOkfqFAycGzNorDnTQnr0j6vgn3kKrhmAtETxALlxvKtBd1
 MCwSGyLuDbgMysCZMttVNT+PMu4eim6BBXAQ/D/ShfkzbErizK6fwnP1jKGypAHVRddY
 9vrD3ivjkJ1maWwb1W3w9LZAz27lpK5/NJvZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749444; x=1748354244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jMVQ2qBi0yQVW0lMJPFKCZY2LzBv/Hxy0hWJz9GLdM=;
 b=XGTsHeytY/ybx34bnkzCB5rHJ6JKDqo8VcgUj6NXpiISczlKq8Dx+oUq61q1f0qNUY
 Vu76Sqhirpxy2F4v/hf5oBDTTUMYM16xZ6df0+Ydc3KT6CwXLYdbNZwCvrOV7cEq9qhm
 1akMioIWwk7LQ45KErrcMvJ9mqJ4gmqTCChRgDi2unqLLErNtppRBDObL73NR3wUlLVg
 wt4E/4mRca3CXvegSIBGaqDNODy2oHDZXmnO5JjHMKN1v+oQnvXUimvePLTFnTNGbjcb
 jJOZI0mr3O7ujgePGYFCjKmEDsTlVm5n2JbB+4jsHbwNBwik1PhokG52pkdxOtdBL/fS
 IJ6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMuublHavkjutmKmzfc3dAq3LW7n8imCqUy4PbAMbxSsFphSxPNNkFGcqbsaI/YHuu5eidfDE=@lists.denx.de
X-Gm-Message-State: AOJu0YzbXUYK44bCB9zgyEFl43blFYwpSLYGt9v6/sftbLevlNu3Crjg
 XbFbeWLELkCAl1naXYF9L4YoNp7gIhbl4wBvFK3CO08bH/SoGtPKCII6UagWJcEwivo=
X-Gm-Gg: ASbGnct9F28y64Pg19fBdZiWoyqhG/DJ49at9ffPQCmFlcjAiw+WfaiBj8sdXk+dmG3
 sPGwlC1UYq2+eOxVBVi4W8iwE5cUHgvJ6/HGoMLa6XmuPNITo61qXPt0OI+fJQtvs+JSc/vQApJ
 TtOGayXg94/BHtsWXaQamcgr0iFHJfL3Ko/COBCfnD+U1JN5RFRIn9wyXLouRzcIKhhMxhHgXaX
 LUoF5HpAabjgbaOwzBOBsKgEbXQpj6YQ281V0uiN8ITfZPgSwT+zz0vmsTHEzybd76qDErSkWEm
 6Y8tkvllkc1syYLSyqWO/fPqrUFeBsmuxZNHRE1+C06hxMf5esFcmEFTurMhutSqcSyXEJzv00y
 GYEBGbEx+woIe
X-Google-Smtp-Source: AGHT+IHHgKsBJ/KetmJTz8a7FS74Mnw8BymM3pAwv7+awI9U06j1oQ0v2u1oFyfJggB9TdIDCsDN9A==
X-Received: by 2002:a05:6870:47a0:b0:2c1:ac88:4a8d with SMTP id
 586e51a60fabf-2e3c1e59ef5mr10240497fac.30.1747749444059; 
 Tue, 20 May 2025 06:57:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0aa201asm2208002fac.33.2025.05.20.06.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 06:57:23 -0700 (PDT)
Date: Tue, 20 May 2025 07:57:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 1/6] arm: uniphier: Change _debug_uart_putc function
 to inline
Message-ID: <20250520135721.GY100073@bill-the-cat>
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
 <20250520-silent_console-v5-1-ef9583d93285@thaumatec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1ce/+6n0pJUWvN6X"
Content-Disposition: inline
In-Reply-To: <20250520-silent_console-v5-1-ef9583d93285@thaumatec.com>
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


--1ce/+6n0pJUWvN6X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 01:36:39PM +0200, Lukasz Czechowski wrote:

> Update the definition of _debug_uart_putc to static inline.
> This matches the instructions in include/debug_uart.h and
> provides consistency with implementations for other platforms.
>=20
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1ce/+6n0pJUWvN6X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgsikEACgkQFHw5/5Y0
tyzPVAv/ewK1N1Qp2A30yLHW2LemriJf6ctibklln4Vgrd3aGa4xH6G9WTzhBoJd
92cj3STcPlqAJWsC3FFX+8i7hy2SAFEQ43De7z/Xh4f8mUHGQkNJguei+WfR6sUP
FU2Cq+owcDhd/Pcji933z/l/s550O6F3Y6T0DOxTdsDIDoU8JmcEGp8fZ86vvxKm
jFH6s34Ab1m1+bb1Fdy1ikujEnVcYuptGoXEMw4clWz7eRhmwH4xuhszGWs/SnV8
ZdSX2XHun1Tc/pv5rOfVl3xddtRgCojoCLWfe6+mhMv1T1C4Dk1ylnGbJftRDrXA
GxVwNu2L8TQGt/kuRd2PcVOvkvwlaS2pPFkMXKL8/EGRBiPeHouT53cnEr7MXmPg
l6X4UNt4z+aiLTb9Qwe4SU+W0TJbmgq+ZIw5rVvH4l+WdC5BAmWv4j7lQ3J8V+Ee
v0LMUrHO/q3Tndh9iqWWSeV3R0WbPC8NUbjsp6jta99kBwZbCZYB37F8CXk1Zzj0
3upEvzRK
=jvII
-----END PGP SIGNATURE-----

--1ce/+6n0pJUWvN6X--
