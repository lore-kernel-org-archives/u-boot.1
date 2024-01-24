Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2E3C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 23:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E56E876EF;
	Thu, 25 Jan 2024 00:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EbFtI5Tc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEBC38786C; Thu, 25 Jan 2024 00:23:51 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5CCA876A7
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 00:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6029e069e08so12768787b3.0
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 15:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706138628; x=1706743428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JvHemBvCzu2TpWRKM8Q+pTQDXlEG1YfFFi/6kozIXwM=;
 b=EbFtI5TcFunXr7erEmLPDGEFobmbWW0/gx9PfUlpLFcLrJH/43sHaMj1JkzGuOUhzB
 jh7UMW2hVW8Ox/V+zjqAbxLq5eOY+C+JhfuaOukfaH0ldvgWRXVpvlXgvV3CXor1ZemM
 3GqJlamy6qK7qYNS07RJn8DyZDMOc5y+A7HDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706138628; x=1706743428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvHemBvCzu2TpWRKM8Q+pTQDXlEG1YfFFi/6kozIXwM=;
 b=G0iPrjv4yy8Xk6e77H3aszb7uw/QaP9QfMCXSLirQBOeozZxgfuQBgBXH0wMYDA7s4
 EQBn3m0LdJpFgokOGrA1NyuuK8pQLTfcmI50nbomdWKf5m2TJAMqxWqejy6S57aql6j2
 K+tkYw6DMD7CFTehfbltSgkK6ltlJiMVK5jtnmimASvRFTD5B6f6nd2OuWJCcyoSC8lN
 O2p4bAaD2FmRRTaTO0Ehnl7fP1XXtVewxxiOqCW3PNYS0vHppEu4dOaVqFX5nCcHWbNZ
 78P9fIuE67GvuuFIj1C8/DFMsdBZ6mgMxSaApHBaAADxSqedm1JvGa9KYRG3QbBFtSbq
 BpDw==
X-Gm-Message-State: AOJu0Yy+5MapVQ9+upEwj7OX5le1NxnekGVZBZu+z0xTkk4IUUywf761
 hzgTUltrE0NZq8OGoHjsG2ms8C47LRma+ZAxJrxslwJeUhad5d851kRe4Laq8yA=
X-Google-Smtp-Source: AGHT+IG25N+bpbRDZ2WqNq19igPO/kqLyz91DNkhRCYNopvUIuBPu4crxsw+YAHkukbpse7ysgZl7w==
X-Received: by 2002:a0d:e8c7:0:b0:5d7:1940:f3e9 with SMTP id
 r190-20020a0de8c7000000b005d71940f3e9mr1758501ywe.81.1706138628490; 
 Wed, 24 Jan 2024 15:23:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fk4-20020a05690c334400b005ff9acf4683sm255780ywb.123.2024.01.24.15.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 15:23:46 -0800 (PST)
Date: Wed, 24 Jan 2024 18:23:45 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] riscv: separate .data and .text sections of EFI
 binaries
Message-ID: <20240124232345.GG3652023@bill-the-cat>
References: <20240124230857.64699-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6fsWaEz/61IU/BEX"
Content-Disposition: inline
In-Reply-To: <20240124230857.64699-1-heinrich.schuchardt@canonical.com>
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


--6fsWaEz/61IU/BEX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:08:57AM +0100, Heinrich Schuchardt wrote:

> EFI binaries should not contain sections that are both writable and
> executable. Separate the RX .text section from the RW .data section
>=20
> Adjust the section alignment to 4096 bytes.
>=20
> Fix conflicting SPDX license information in linker scripts introduced by
> commit 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel
> style").
>=20
> Fixes: 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel s=
tyle")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/lib/crt0_riscv_efi.S    | 39 ++++++++++++++++++++++--------
>  arch/riscv/lib/elf_riscv32_efi.lds | 26 ++++++++++++--------
>  arch/riscv/lib/elf_riscv64_efi.lds | 26 ++++++++++++--------
>  3 files changed, 61 insertions(+), 30 deletions(-)

Lets not do two distinct changes like this in a single commit, thanks.

--=20
Tom

--6fsWaEz/61IU/BEX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWxm/0ACgkQFHw5/5Y0
tyyyQgwAhzQQOXVmFkgGB5I/AWhCs5HAtLyyNF27PAphpQZz3VIi74INvX8HUEKX
7cdabf07dd18SHgUZhe2XwS89X/azklNvfb6Ay72sDIJYlIgceq0WsQTH2mm1RyA
B52V4296YtX2R317lJaisZWX3Su566xd4XGp+FCGsRH9L1xGlMNXxMd9hOrQVgbi
NEoiRaA03XUwhj8J+XCiExosk473KVgI8QXO9/DnhJPJljSHDzFwEJgJMy0JT3Pw
6LGBtvCOUq0KBu5ZNNxvJgQ7wuEbDv+c9qYNCyqSgz6tTwc3OrI+bNUk4MosocJh
AnxaEGQ8qwWCPkOAIfzz6R9vO8XYQUq7VyPUOc3kouKPGApNYr+t2wYKnNoIP0hf
cVF/qC4Ol9L4bLIB9623KdoSG/OuYmBUf63nK2+h0qqoevyE+5nAnW/RVX3KhPE9
m8dPXndu1vnKF6FxBsYd1/9BUd/Zidk0WaBPts6Hup1y6xxn4RpC3e98qgfMKa//
c9MKAYwT
=eibu
-----END PGP SIGNATURE-----

--6fsWaEz/61IU/BEX--
