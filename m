Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B59D6E2CA
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E7280050;
	Thu, 18 Dec 2025 20:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F+oh9pxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9DFF800AB; Thu, 18 Dec 2025 20:00:45 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE55D8003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65cff0b394aso569505eaf.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766084436; x=1766689236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CwPYmHbOIO3cyAVLbswkbislhWdkY82XwpVa7zEHsS0=;
 b=F+oh9pxfpdmZzJ/Xtm99JVxqrv/EUh4m3lzp8UA3jxwi6T6GkS9ZjseTjbYULmH0jP
 jNl8sY5H+p85jZ6v0ZHFAZ+2wM6L7EZ8ROdb0RqBjTt0M93R2/1RgHChlV9Uqry39di6
 I12bLQrc8pjUSHOKk0snZMejb9yVfAym9EG1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084436; x=1766689236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwPYmHbOIO3cyAVLbswkbislhWdkY82XwpVa7zEHsS0=;
 b=qY1qriT35PDT+dyJEZ4amjumZT+sxUz8V6k93qpzvD94R8/SMylxVOt8L4bHMMWX2E
 OimI0lh768IyfC7QQLIdV7++16aRIBD2LaeA3VfzDvnm+JEhYvYaDhBoYFdNvLF/THsa
 EsvuwqpLI77H4wx/epNB5cjJXqB1qxMwPdqqSvIRK8rFspu+SfkzG1sVrIBdlqsNDXq6
 kSqi8fr5hfU8kcKDnr4Ot4LmrGBdzZIiL5/zEw6TG0W6EJwA/PeootFdPWL3/+CIkx7P
 7mYFjGLlS/kTLjpagN/fSdAtY9fqxRGMvEBygqz8AIk8Tqd25ugdUDbGUlpGIXT7WKzV
 EJxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt7Hg6CSVguhWmkhOCNTJVT2rYnYX4tf3H4rGNtC/1hdikiPYdqjlJenluyB+ieNWb22EQvfo=@lists.denx.de
X-Gm-Message-State: AOJu0YxpMy0jfoaHpfhqbPYgWGSLQZGWriNDzn2ArziOeEnyu5XiEUFU
 hHpp39DpUriy4NoeB8SlD6/sFDRwaJ4UTnCfct9uMqhUKyi0TI7i2FSJv0scrkPcVos=
X-Gm-Gg: AY/fxX6AJzPwOXRhAXoVMeqFeVFD93xkTABzLkQLXED0DnvfPY8E4cFIXEymTRmHWkl
 RABrTYorJnn4WVEQX4NT8+plzboxLMQr6mMhgkhuplSS69DqnHNiMhZoRYlWyW8sISFDdW6sAmW
 uiIFrSRSTKEYReHRkgx5c2Q+x1qJVsHXnHcaplgROAro5Sbe6trjPRFFVDZMlgA+XC92HdBnPV4
 nfqxAKX8Mx9fx0PvnFLiCM35r5NXDLct8G1xSO41srYM8vdNteNR2xC9z9Gnuwjx+dJ7ZR882x/
 ZExvaMTJ0ZyqYQVVNGr3bQJKGpkxLnBLI9kke8//mE6E0vAW64x1nWZlc+7p1YXqeX6O/z6ZMTi
 iEYI2ygs7yfg8q4Hn5qv6TQHdswQwmuOIC7ycSJFiiInKgC8G6JlrU23jEUKiIS9OYAWzOYnm3G
 cTn6WIfMyg9p1O7TUvxU5Y1mRgBC/Y7TjC7dcCgPqxztIODfyFEQ==
X-Google-Smtp-Source: AGHT+IG7ZQEBXGaUYFSDvWVOvyZinBCGf23JBWttCjrYPud29BFIpOlggb0d1iBD2yfXYp1281tPPg==
X-Received: by 2002:a4a:ba10:0:b0:659:9a49:9020 with SMTP id
 006d021491bc7-65d0eaf3c3dmr171971eaf.77.1766084434994; 
 Thu, 18 Dec 2025 11:00:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f6f0e78sm95786eaf.15.2025.12.18.11.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:00:34 -0800 (PST)
Date: Thu, 18 Dec 2025 13:00:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] m68k: Add support for M68040 CPU
Message-ID: <20251218190032.GL303283@bill-the-cat>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-3-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ML7PWzh8hdQNV4Mj"
Content-Disposition: inline
In-Reply-To: <20251218185252.957388-3-visitorckw@gmail.com>
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


--ML7PWzh8hdQNV4Mj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 06:52:51PM +0000, Kuan-Wei Chiu wrote:
> Add support for the Motorola 68040 architecture. Currently, m68k
> support in U-Boot is primarily focused on ColdFire (MCF5xxx) variants.
> Introduce the necessary infrastructure to support the classic M680x0
> series, specifically targeting the M68040 as emulated by QEMU.
>=20
> The implementation includes exception vectors, early startup code, and
> minimal CPU initialization and relocation stubs. It also defines the
> standard m68k boot information structure used for passing hardware
> information to the operating system. To ensure compatibility, ColdFire-
> specific library objects such as cache and interrupt handling are
> excluded from the build when M68040 is selected.
>=20
> Additionally, apply a specific workaround during the early memory
> reservation stage. Use a manual loop to clear global data instead of
> the standard memset() function, as utilizing memset() at this point was
> observed to cause a hang on the QEMU platform.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
[snip]
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 8ade6f7b9d1..a41c375f6be 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -56,6 +56,9 @@ config MCF5441x
>          select DM_SERIAL
>  	bool
> =20
> +config M68040
> +    bool
> +

The file is unfortunately inconsistent about tabs vs spaces, but all the
new options should be tab-indent only, and no extra blank lines added.

--=20
Tom

--ML7PWzh8hdQNV4Mj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaURPTQAKCRAr4qD1Cr/k
CiTTAQDIEBTDB5IU6QAqcnLFkS8+JPOSkxKSXnKVNWubzLSfVgD/dJSl05BMr6ll
5TOvmN+2jpaJyaloIvz7yRfF/bYlSAo=
=ibpq
-----END PGP SIGNATURE-----

--ML7PWzh8hdQNV4Mj--
