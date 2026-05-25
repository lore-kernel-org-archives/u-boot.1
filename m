Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069A8CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B86847C4;
	Mon, 25 May 2026 16:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IlF9SVw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0D7484837; Mon, 25 May 2026 16:48:47 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29AE847B0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43b65572608so853420fac.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779720524; x=1780325324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4al+2yNglJNAFE3UvSSRSXs5f3Q/UkIdAJVamACTGPQ=;
 b=IlF9SVw15U/DrUwLWcM7ijCjJrWFzeX4x9qJ1n/40JC/pcGuNz+3ozv/gp7ANxxkT+
 2CnfmKNhMNYRuKSmRyTKuFTyP9y+N/TphSZTFZSONYsnGL6Hvs2H9xUhKTcYpp0FD1/v
 9AnwOfThPc8qsag9sTJnMNaL0hkwGcAr8Eg78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779720524; x=1780325324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4al+2yNglJNAFE3UvSSRSXs5f3Q/UkIdAJVamACTGPQ=;
 b=iFMaPy1uUaUlnPLCc964P2m0hOOhaNxe7SQKqMOXvq8565CV43o16Iolel9VPHXx9P
 UgpMdF6Vh9u8nmRfXOMqGjjFu0mJkxJ86yvliyOc62BCnFZG9O3dCrGrYOkw6xojCFCW
 qRiQCQdatIEhvOxHyrv4gtyuJVH/grFnGUFKvX18lvxAovd1KjtdmJFi8P2VcnwNf29l
 eELx0S+X0Ihs3veVJ8Qgv6/MkmC2hKUPq4M6aQQ2/q1AVJAT+jCZHwIts84GIcCiTC3E
 yvWQMm6n+rTl+eUo9jvtwuzleAlLb9T9+HsrOucWrKlrHALwGJ+XjkQrN+EXW+4E6n56
 YZ+w==
X-Gm-Message-State: AOJu0YyE+HiG8AGmtZb8Q0COMLP/mC2hB+jrgoQnUtW/SZomTO5wEV2V
 5UbnT+KhHhTP0dB/c9FscxJ7eU8jAkCbES9yIOBDDM1nkJCSKZ+RDbVGueolzsBrnL73AaU40MD
 S2NjTW1k=
X-Gm-Gg: Acq92OGhEW8zt65W1plmMyUfJLl3gmLxWWbef0dJ/KMb2ND3OZUYU90ncnq5XwxJgBS
 FojDEkjVPuo2Uibj6dYPwNSzDO/cznGu6uMqMAFluiImS6h1TXLMqVH92LrDKMBcmWj6ZwNmZqm
 K/uA8kUUQpLQlbccvcP+EpL4HACJ9tyHvmX874LxyIjmOEg0sS8q8bz1nybIBnhVS9ReYKhW7/i
 UdQ7uP96EXJ6xDD3A9tMxupROkI+6CDOXkR9tL9cHHZUvJ8kWEGpKTx04bTQlL1EjwtbXOZ857Z
 x1VOY9zrwCzZzJw5KaAkNU5KmLm33Xx6IoNpxhScvr1l2s2n1i21JFdXsLtTZ3T7RzUFkbXB5i4
 UKC2c4yB2fhlMU5u1aJUpsEihG1lWs5trntE9hBjVnXCaWQRMMjGC/3BPPTRgFho+/zEsoRVjqG
 qd1T49Bv0r6iQpqA9hOFGLAeAkHwSU+S+1k386rMvWfpEZPdbF4ngC+HwhyFT7v2PnS72pOnUOH
 tbG3x9vNfMFIV/PEaCSoXRl5LiyIH+RyfOH+cY9UKdZBZahn2acvExN
X-Received: by 2002:a05:6820:824:b0:69b:8c61:796c with SMTP id
 006d021491bc7-69d7ecb7ad2mr7810351eaf.42.1779720524491; 
 Mon, 25 May 2026 07:48:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d836c6f22sm5420735eaf.1.2026.05.25.07.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:48:43 -0700 (PDT)
Date: Mon, 25 May 2026 08:48:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/3] fdt_support: validate property lengths in chosen
 and dma-range fixups
Message-ID: <20260525144842.GA3352571@bill-the-cat>
References: <20260525132628.755148-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QpZTA1pMoeHgjMrX"
Content-Disposition: inline
In-Reply-To: <20260525132628.755148-1-aristo.chen@canonical.com>
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


--QpZTA1pMoeHgjMrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 01:26:22PM +0000, Aristo Chen wrote:

> boot/fdt_support.c contains a number of helpers that fix up the kernel
> devicetree handed to the OS during bootm/booti. Several of those
> helpers consume fdt_getprop() results without validating the returned
> length against the per-entry size implied by the surrounding cell-count
> arithmetic. When the OS devicetree is not signature-verified, for
> example an unsigned FIT, a DT loaded from $fdtaddr or $fdtcontroladdr,
> or a DT supplied over a network boot, the property is
> attacker-influenced and the missing checks turn into out-of-bounds
> reads or writes on the FDT blob and on stack buffers.
>=20
> The first patch targets fdt_fixup_stdout(). The function copies the
> value of /aliases/serialN into a fixed 256-byte stack buffer before
> publishing it as /chosen/linux,stdout-path, but does not check that
> the property fits. The patch rejects an oversized property with a
> warning and -FDT_ERR_NOSPACE so the unbounded memcpy cannot run.
>=20
> The second patch addresses fdt_get_dma_range(). The function reads one
> full dma-ranges entry of (na + pna + ns) * sizeof(u32) bytes after
> checking only that the returned length is non-zero. A dma-ranges
> property shorter than one entry causes the subsequent fdt_read_number()
> and fdt_translate_dma_address() calls to read past the property within
> the FDT blob. The patch validates the length against one full entry
> and returns -EINVAL when the property is too short, matching the
> existing failure paths in this function.
>=20
> The third patch is an unrelated cleanup. A handful of printf call
> sites in fdt_fixup_memory_banks, __of_translate_address and
> fdt_get_dma_range still use the gcc-specific __FUNCTION__ identifier
> while the rest of the file already uses the C99-standard __func__.
> The patch converts the remaining occurrences for consistency with the
> rest of the file.
>=20
> Aristo Chen (3):
>   fdt_support: bound serialN alias length before copying to stack
>   fdt_support: validate dma-ranges length in fdt_get_dma_range

I'm a little concerned about the potential size growth of adding
warnings in these cases, can you please check how much the growth is and
move them to debug() if it's non-trivial? Thanks.

--=20
Tom

--QpZTA1pMoeHgjMrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRhSQAKCRAr4qD1Cr/k
CsyoAQCRyIu+1eXGE6IlAsOyhzzLN0+SqQZ3p4z10VEtJCBZiAD8Da/7PtVMQENZ
TolvCLV+YE3sL8z2wXLac8XgmhQMBw8=
=+yza
-----END PGP SIGNATURE-----

--QpZTA1pMoeHgjMrX--
