Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470ADC02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438B9800D7;
	Mon,  3 Feb 2025 21:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MKIxgI8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFC980214; Mon,  3 Feb 2025 21:09:09 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E24E800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7be8f281714so437541385a.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613346; x=1739218146; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aI2Ku7y/23f28kY6wMGcS7tiirGlErH7wid6JH5CEws=;
 b=MKIxgI8NzYg6//PfEl7xtidL75EbJ6BzW0gYCl1ydztEfCsF7vgfbeXcyOof0UTIi+
 W6ZqTanLQ81UU3XDbMZ3um8wX3epzUOPPF7YVrRKvQJPd1d9jMuxq1CNF+8r8wVuQ93Q
 UzY75QEKv6NVgTY/ZaQT/goSNAUuOSdlFKrR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613346; x=1739218146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI2Ku7y/23f28kY6wMGcS7tiirGlErH7wid6JH5CEws=;
 b=YA3L/tOb+jrVNk1tk5Isgj0qevbYblIB4Evt579Fl0bSmCCqG12hzrGw4PhggNTqra
 9OjrGip6HvAOBHwzAICDQzqbCiZJCjFhdQXA7w/MqsC/zcwx2tTGcxdjoZ8bhP8D87oH
 YK0jhrH3v7PKZZC4EVT1lDM/rA+zde73C0WgNNaGRhIM2dWlyH//wWd/uDjx7J3ku1SV
 bIliyK1ET/ARwRFBRsH/ajVwLbgdMY54UoGMXT08FUu0tdrjnCZ4lfILcDhDDKMXyQm7
 mdIsYa2peAx1tbaVRczKxfPRfmUvXe7BOrQJy7HvWgtfgmnQ0/iBbhJm99MQWPRilwVz
 Ji4A==
X-Gm-Message-State: AOJu0YwS8uK+7YtKTQh3eGE2lZpjurQ8sAxLX6RILitSG2pHHEh2u4yO
 LlRnp5sWKxAaYZIp2jvlkUxdwlYVH5XLoGSAgKK0WFnCesoKSijCqbiFYNI6Fvg=
X-Gm-Gg: ASbGncto4xmXHN5dEToeK2pYnKBYNV8+Ne02k+2fMhqde881u9x/mQHnqJ7wiDmDPKf
 a9yiaAFJhl35vFDqJJPKFBzUkhw0knyifj76Nbl38ky7ZVargg7L1D0HVe/kF2XTQkkH3aKKm+8
 Z6BjbTOZwT8yGJH2oqWSHk+XcDsTfTKIRsBOTwQ5/BkLSJIva73dXm4PQTvXD1CHlOv4jCE0WBL
 JiZu3eTMEASWF2eHtdTRgXE6mNNmkiVwT3Wly10REjy7pvZPDr6Rf38Yr1ZN7ySwNdlQtorjwAV
 UupSe0/ixHe52hI=
X-Google-Smtp-Source: AGHT+IHhMJ3WMsmwqL27zpT9Z0DiVEwJOYP1DbiyvEq7qPP8Mtc7fVdnnQ5pHmHMNAJZuqRkUgLdQQ==
X-Received: by 2002:a05:620a:2551:b0:7b6:d710:2282 with SMTP id
 af79cd13be357-7bffcda112emr3617715985a.49.1738613345990; 
 Mon, 03 Feb 2025 12:09:05 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e4e9bsm53830511cf.45.2025.02.03.12.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:09:05 -0800 (PST)
Date: Mon, 3 Feb 2025 14:09:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH 14/32] efi: Rename ImageBase to image_base
Message-ID: <20250203200902.GH1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-15-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XTrbYf6v2xnYIHKr"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-15-sjg@chromium.org>
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


--XTrbYf6v2xnYIHKr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:07AM -0700, Simon Glass wrote:

> It is confusing to have a camel-case indentifier in the link scripts.
> Rename it to fit with U-Boot's snake-case style.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This isn't the linker script, it's the crt0 file. Given that this is intend=
ed to match up with
https://learn.microsoft.com/en-us/windows/win32/debug/pe-format (which I
got from looking at the commit message on commit 216459d2cf36
("efi_loader: correct SizeOfCode, SizeOfInitializedData") and
include/pe.h I don't think this is a good change. Heinrich?

--=20
Tom

--XTrbYf6v2xnYIHKr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIl4ACgkQFHw5/5Y0
tyzUZgv+KNWe12cq4KXhcqHXaJWBAwroMB4OXjcut3d0ss5EzVnOwbAHvv5GkDIO
mju9FurF2VbYG+32ygb8+706i/xNXnRQbF797yZIjSX137e0ExPUN6/ORlA7TRyb
MqNKKSEWAbwxoglvqdFxKPf09+0bw2rg7fFyTR83xz8e89Xz6COmlkDz803hxOZK
XM6UtNzx5iH+R/5XSrXYyufUTt/T3oUR5kSlAy5HsP6v90hoF2wueF+iALLocLwq
2Koek+VLOT3t51Jh79IJMvOJ9mlUoclUFHa9CTmQ6Y4b74Yem+YkqbH2gTl2djPL
2UC4dXMn7VopqpBmyd8RRKlcDXenM5bkF1t9VsCMDUXc1upNWmFyTWugWpS+ZTbL
zygbE9L30srii84IYfCWzpVckufhD1erkxvh4X9CjqDYdEIlY/9fQm9Ih3In3W8c
cE1/TDfE2+6zFV2+2fvcJBDge0r95I/rh13jlokcXmv99PgVUO84ES0ntwM6Gum5
sbIjx88i
=p7q2
-----END PGP SIGNATURE-----

--XTrbYf6v2xnYIHKr--
