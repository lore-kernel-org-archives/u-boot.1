Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB82CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA0584862;
	Mon, 25 May 2026 16:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X+UzoOps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AEE84882; Mon, 25 May 2026 16:43:39 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5DD584841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69d7b0be328so1245914eaf.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779720214; x=1780325014; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WeGpqtUqgEsyeR4WGTQm2BA8tgp2Ntnn/mkgrrXtkrE=;
 b=X+UzoOpsaYEkLuXSwjA18jUA70+Qo8u4k4SxD4mZi7njpZ37rtstSmRoJwfbyhSwSc
 MrrI03C2RAJy1CPCirmLHzwSyGTzyg0WAFHLmowJegCy4A3lzuudAL6is05/vUSnsnW0
 pGNDYmQV1j+Bx6lJL7/2myim2Ya5dQvkhZniA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779720214; x=1780325014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WeGpqtUqgEsyeR4WGTQm2BA8tgp2Ntnn/mkgrrXtkrE=;
 b=Glhtls7ykgE/vjnGN56HMHSrDqqke0L4auDUB1cqca72T3Ezf8qJ5zGEGVHcKVMJQh
 MOnhiuzI3tPzZBaLmTXejBs+zT2oReqe5oaqkoHtz9EdoAVCN4ue+S3t5Y6koi6ofcWF
 Kf6Y4b//Llpcq99llPRE04SWOK6ZvY2Wf7X05sPYdeR821wQ2L/vt1b9Bywklux95kyN
 UZSaesOnKyaye2p2cZeg5O3O5IQ2DTEm0I0C86oErc9KTqXz1E/jtpOqZlOtY4Ccu4o2
 w3oJZ926GcCWlb0wo7Ty0li4nshFNfMfVnJnAN6Iue4vp+bU10GPCfQhiqY63mY3HYgi
 /1rA==
X-Gm-Message-State: AOJu0YwX4f/B9Ab8E+3KMAof++87UwmY9cl8Ymc0Tx8/EIL4s4byt1nd
 KvhGsSjdRdACGEqzCtfLD5LeZZpzKBzqBOzbyTMdhb3UWNbOhPrAaBngmctDiWYSFGg=
X-Gm-Gg: Acq92OEccHckqw776hYgmfT8BlQPy2fqDiuVYQb4OrePcTzQ5U9GJs2vEtCEXO+Aen1
 P1gxUXzDk6ueiB+rFc7rMRZWmU0XOPYGX95K+iRD3KA0RANRw+l79amAObOKCezbxhk6dKQRad0
 kyGzWhh36HO7t/8mZQYlHZxsVxeCJ3smzd7fJLZ1hPcHzC/l+6C85Shl/1XfWg78kU35tV1YEqR
 b4jG2NvoDuRrFfdwdSDZsooAMiShNeHufIS3olK7CdRtecMSIAiE+AdvG3WCKzjxrKLWMnNKoE8
 aAAnfT3PTTBh/5yZq+X/7CLLyBNYXNNdq81ySCsqCSV/lRhp5X5z1YnX6+ENqrHJLFCuXU1iUAz
 4EGAsqrcQpwEf2ahnKs1nEs/V4Hb2GH9pwiySWz3idG4cYGP+5J5fXau6DMeIppJEQ/vnhRU3LC
 G3IYZ0+Ezz40pefStTEwpm4cBvCgez+P959/W2y+alCo7qYjqoD0JNlUBm6LW6Ih5QPMGlKFq5E
 OutF+HZOmjVa1pmBStfvCxtk+/ngSzfFJrf2NhS+v3h4A==
X-Received: by 2002:a05:6820:f004:b0:69d:9823:c9e0 with SMTP id
 006d021491bc7-69d9823d40emr4230006eaf.2.1779720214288; 
 Mon, 25 May 2026 07:43:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d89baab0bsm5201686eaf.10.2026.05.25.07.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:43:33 -0700 (PDT)
Date: Mon, 25 May 2026 08:43:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Richard Weinberger <richard@nod.at>,
 Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v1 3/3] fdt_support: prefer __func__ over __FUNCTION__
Message-ID: <20260525144331.GL1858239@bill-the-cat>
References: <20260525132628.755148-1-aristo.chen@canonical.com>
 <20260525132628.755148-4-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X+lR/qcXzEzK+sP1"
Content-Disposition: inline
In-Reply-To: <20260525132628.755148-4-aristo.chen@canonical.com>
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


--X+lR/qcXzEzK+sP1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 01:26:25PM +0000, Aristo Chen wrote:

> A handful of printf call sites in fdt_fixup_memory_banks,
> __of_translate_address and fdt_get_dma_range still use the
> gcc-specific __FUNCTION__ identifier. checkpatch.pl prefers the
> C99-standard __func__ for new code, and the rest of this file already
> uses __func__, so convert the remaining occurrences for consistency.
>=20
> While in __of_translate_address, also re-align the continuation line
> of the inner Bad cell count printf so the second argument lines up
> with the open parenthesis of its printf instead of being one column
> off, silencing the alignment check that scripts/checkpatch.pl reports
> on the cleanup hunk. No behavioural change.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Oh wow, I didn't realize we still had __FUNCTION__ anywhere in the code.
Can you please move this to it's own series and do a global fixup of
__FUNCTION__ -> __func__ ? Thanks!

--=20
Tom

--X+lR/qcXzEzK+sP1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRgEwAKCRAr4qD1Cr/k
CuUGAQD/ZlYxOaeP8H6ZWOMhMUSrrLwDrNe3F1dAKyvnGPxRwAD+NPJP2gbx1HqP
3Y31bKRELfQIJ8NkyKEBDryabpgSjQU=
=qW2I
-----END PGP SIGNATURE-----

--X+lR/qcXzEzK+sP1--
