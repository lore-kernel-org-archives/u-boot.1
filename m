Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D8BCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FE080F0E;
	Mon,  4 May 2026 19:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oMLiEv5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F44B8394E; Mon,  4 May 2026 19:04:49 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA3480077
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-47bdee5bfc4so3184832b6e.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777914285; x=1778519085; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KYVxAmrT1PIDFEBbeUx86K0xofv/Pk8vERtObJJstsE=;
 b=oMLiEv5Tuh1dGEGmcBp315tFMZELuIiMTNdZA0DUrIZlLUT4qSIbLc8hged+4/LUTI
 YmFfL6mpMFQ8bbn3Yr35VExD8/G30ksblwRgncm1F6g0OhqYL2LSGDdtA747eyjuf4Lz
 jrV3MjbG2A+PQDs3GKl1Io5Gjzqcy3QFlhHus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777914285; x=1778519085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYVxAmrT1PIDFEBbeUx86K0xofv/Pk8vERtObJJstsE=;
 b=K9buh6rTufUGvXU1IRHH/iT4X2bZKtOK/siPCK8kammwP7a8IqsKeGcNVKgGUxykYb
 wG2Wwbo3ybSiUU712dZmcWuvDUKXJRHus+NDcLTHAXvwm4JT/xV2Gfil9hr0GitBWdQ+
 8SoKm39s7p+YMQbUih02gsy8s3Cj6sMNmnALp7UE8d+OIjLC0Oh0UJBdpcfdvk0XzhWe
 PYrXvfIfFF9Ytgkw6iiTDASaaWwCKY88Y3GGmAYqZcRskjkuf/4SHx1Px9r6OIJVGLOI
 Oi5blNYiNuNJvG5siydXjdeyHwCPXXNd9yCKp6r4xbdVsoUB3pArK22PONMPZdlz+uC0
 lkNg==
X-Gm-Message-State: AOJu0YxbUglssoOUcQ0h8kSYK3ZhmV6BNTxoN+8kUymqk9QZAaDEihqX
 XWxusqBy4PgauWOnjVMGXl9Tte/u34wsfooB89Cbyp+A5u63NvO5PqAJewoTAnVckvg=
X-Gm-Gg: AeBDietdn0F/sGY8tflvB9Y8XQh5Zw8+q65bvLWQarDZc/cTRKPlJrFMtE2FvWO/NNp
 pfehXuqQTJ+C+9pjgX5vu0v7Nin3jsHAAUfx06mfr2e27uQbMI1nQNBHoU/Kl8BVzmLCyfPq2le
 eyDk5ZK8llXWYZBlPfcURS7MDwhL+g6b1Dgo1wFRQe2e5p1KqbY727Otj++/4gCZbAtly12P5Z7
 wk4/DQMexp/noEvne2csrAZigey68TGj1BFy25viDbOln0R0xas5wsXVM6T/zBbUXp3InAKBThf
 r8Sz509ylhi5aSwLv6qPUja8QOxVHsJHxcAZ0T9wXu2L4h5e2nBnHT68Ub6LSGzQvtI0MAwb3mz
 SgJsP85BBT/MeZ2WYCD2ELuddNZGhRrAYhLIcKH7rIX1fFuSGiIjCLtutcbFe8iUEk17OGpmlOD
 ao+jL1cst3Umsv5fX/Oe89ddX6M8G+hyNaJch6Q0dFnLQ3tBguX/m/FhquItCcHw85A3+SZ/KQU
 PUIZg0OsRNRJ2jUEZPLhY9OXxiyWDm8Gp6s7Q8WhzXgxjCFvbkM1ri1DGbVzA==
X-Received: by 2002:a05:6808:1a05:b0:479:fad9:662b with SMTP id
 5614622812f47-47d36592351mr193649b6e.24.1777914284965; 
 Mon, 04 May 2026 10:04:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d324e2sm10602201fac.13.2026.05.04.10.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:04:44 -0700 (PDT)
Date: Mon, 4 May 2026 11:04:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Brad Klingerman <bdklingerman@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Makefile: remove block from conv=block,sync in SPL
 alignment dd
Message-ID: <20260504170442.GG1614990@bill-the-cat>
References: <20260501143850.2714779-1-bdklingerman@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HiS9dM7blhjUzHZa"
Content-Disposition: inline
In-Reply-To: <20260501143850.2714779-1-bdklingerman@gmail.com>
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


--HiS9dM7blhjUzHZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2026 at 09:38:50AM -0500, Brad Klingerman wrote:

> The line that produces $(SPL_BIN)-align.bin invokes dd with
> conv=3Dblock,sync but no cbs=3D operand. The result of dd conv=3Dblock
> without cbs=3D is unspecified. GNU coreutils outputs anyway, but
> uutils (default in Ubuntu 26.04 LTS) errors out for files with
> newlines, including SPL binaries, producing:
>=20
>     dd: conv=3Dblock or conv=3Dubnblock specified without cbs=3DN
>=20
> Either the block operand must be removed, or cbs=3DN must be added.
> conv=3Dblock is for converting newline-terminated variable-length
> records to fixed-length space-padded ones, which is meaningless
> for a binary SPL image. The intent of the rule is 4-byte
> alignment, which conv=3Dsync alone provides by padding the final
> block to bs=3D bytes with NULs.
>=20
> During build, u-boot-spl-align.bin errors silently due to '@'.
>=20
> Reproduced with uutils dd 0.8.0:
>=20
>     $ dd if=3D/dev/urandom of=3D/tmp/in bs=3D1 count=3D10000
>     $ dd if=3D/tmp/in of=3D/tmp/out conv=3Dblock,sync bs=3D4
>     dd: conv=3Dblock or conv=3Dunblock specified without cbs=3DN
>     $ dd if=3D/tmp/in of=3D/tmp/out conv=3Dsync bs=3D4
>     [succeeds]
>=20
> Output is byte-identical to GNU dd's output for binary input.
>=20
> Signed-off-by: Brad Klingerman <bdklingerman@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--HiS9dM7blhjUzHZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafjRpgAKCRAr4qD1Cr/k
CoaxAQCpR5OarOd3vbnxQez4QuPDhUfEt48gPZyveM62jemVwwEAzlJHDLyRwuM9
3w5XCQ/7SpecQsig88gJu/XJNWjXXgs=
=FV+l
-----END PGP SIGNATURE-----

--HiS9dM7blhjUzHZa--
