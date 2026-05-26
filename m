Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1D4CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 16:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8106F8469F;
	Tue, 26 May 2026 18:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cBneWZL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434D0846DF; Tue, 26 May 2026 18:30:42 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9A984671
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-47cacb4ed99so6699681b6e.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779813039; x=1780417839; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TYV3wWjJqZDFTaebokBLpHYFsBLyEw2KOVC+oMkzdT4=;
 b=cBneWZL8+6IKY3YqC0FHLznKyxcsVCmtFZvbErdmKzWFFZBbteEgp5T0SPfgbdjiTr
 1qOm8OZuUBjIoPYpyffslFfQBLi/0dval2Tj5CIehO8aypobnw6t45XfE9Ix3CzMxCfV
 LUMHX7FWzcy6ESNrAfDaf5iHnOuvamwOs2PI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779813039; x=1780417839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TYV3wWjJqZDFTaebokBLpHYFsBLyEw2KOVC+oMkzdT4=;
 b=CdDp/fszQpv/DghppZR4n9dU61oup9lt4XA45qDTNHxTsgaFHALjTduzrzgYbDmtCY
 jizKe8NYRVt5M8NmUkvwK1QP/BFSLxMLXgal5IRfRWv4xgu+JyPwBVSz7Hy9W1O/OW2W
 Xt83MdxhOZnVXEO7sgSkrqp5/YHaNiLpe4fI4gnqvAu4oMsEw0/0EF2A6gbHifnTgS4C
 XA9O3dwcNdt7vF3csoTnZPu4oek4sS4SMUlldUwHWVFu3Jx5LbhPXHX7jP36ILY1AuIb
 bnRuQAj6dJMkrw8zT3x8mvICtpoPyA/UL5kE3zqoGvNaDdQEOgJu3vooyDKclbrtUoUy
 7Hfw==
X-Gm-Message-State: AOJu0YwTHykaYWTynBy0pzKMmPEC3urbUUWRk2elYZHgkWnMcfXJmKCV
 CSdZrclxx3z3H4Lo6NJQ/AvStt26NqZlrdpnCNwvU659X5seJ+F6HQckqBt1zt16Zfo=
X-Gm-Gg: Acq92OEiVKAMdhckIjeFvtOslcjo1QOyv2W0Cqsylf2mCm9R0I8dWWiP3SvJ+sPQ7C4
 lz+GNty2kSIQlUJdhKaYc+nW+q4vGQOZMV4dq0BF00ubiCEoPzrBG9ZTEsAOWx5G6JdTsdGSx4T
 UDD7zG9I7CwyA5ACI95f/beCAnEITP2npqGzdZ0lRlsilwfOOaHIMCsSZarPw9lw3dnAD9q7+h+
 U4ZSBLTTyrclXNNQL96mlbbxX1Izuba3X1Mq6d7sp+a3QYL9YBmNn9ym0DyuZkMDziXFYAL7/U7
 H4kST9AsXRX9vAQhLQNAiQQL2gHwWzS0cf0uaLV3/N/9ssjYDeoKL77Jegz0yAwhHOgtGUKHjz8
 pHFkMEuzvG2jNVfj4PKBfGcvu2KwSXnC5YQGlvskjNeWYNMeRzVL0eY9SVLj9O6WMox4PafuRuV
 /R8xK++p4ZhVwPHeas3FwFF4+sHdYEMGJKCmXTEuUHQPYq8fqDnDb7gKoqxKIvC9qLjR6Exo1oB
 jRPhJ375b+7CHO2UXOSHvgrszgj80sX6FPKVsesa2hV5PrZq6lLz0zw
X-Received: by 2002:a05:6808:2203:b0:485:1542:74c9 with SMTP id
 5614622812f47-4854a0e9433mr11535606b6e.12.1779813038701; 
 Tue, 26 May 2026 09:30:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63976d57sm13851078fac.9.2026.05.26.09.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:30:38 -0700 (PDT)
Date: Tue, 26 May 2026 10:30:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com, sjg@chromium.org
Subject: Re: [PATCH] test/py: mtd: Add tests for mtd command
Message-ID: <20260526163036.GZ1858239@bill-the-cat>
References: <20260526073749.89059-1-love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ISZfIMOfzaPp21G9"
Content-Disposition: inline
In-Reply-To: <20260526073749.89059-1-love.kumar@amd.com>
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


--ISZfIMOfzaPp21G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 01:07:49PM +0530, Love Kumar wrote:

> Add test cases for mtd commands to verify list, erase, write, read
> and dump operations on NOR flash and binary-file data integrity.
> This test relies on boardenv_* configurations to run it for single or
> multiple MTD partitions.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  doc/develop/pytest/test_mtd.rst |  10 +
>  test/py/tests/test_mtd.py       | 648 ++++++++++++++++++++++++++++++++
>  2 files changed, 658 insertions(+)
>  create mode 100644 doc/develop/pytest/test_mtd.rst
>  create mode 100644 test/py/tests/test_mtd.py

Have you built the documentation and looked at it to make sure it
renders correctly? I ask because:

[snip]
> +"""
> +Note: This test relies on boardenv_* containing configuration values to
> +define one or more MTD partitions on which to exercise the 'mtd' U-Boot
> +command. The test reads env__mtd_partitions itself and loops over every
> +entry. Without this configuration the test is automatically skipped.
> +
> +It exercises the 'mtd' subcommands (list, erase, write, read, dump) and
> +a binary-file data integrity round-trip (tftp + write + read + cmp.b).
> +The suite works for single and stacked flash configurations. Partitions
> +whose detected MTD type is not 'NOR flash' are logged and skipped
> +per-partition.
> +
> +For Example:
> +
> +# List of MTD partitions to test. partition_name is the MTD partition
> +# name passed to every 'mtd' subcommand; flash_part_name is optional
> +# and, when set, is verified against 'SF: Detected <name>' lines in
> +# 'mtd list' output.
> +#
> +# partition_name      - MTD partition name (required)
> +# flash_part_name     - expected flash chip name (optional)
> +# expected_size       - partition size in bytes (optional cross-check)
> +# expected_erasesize  - erase-block size in bytes (optional cross-check)
> +# writeable           - bool; if False only non-destructive tests run
> +# timeout             - per-partition command timeout for long ops
> +env__mtd_partitions =3D [
> +    {
> +        'partition_name': 'qspi-fsbl-uboot',
> +        'flash_part_name': 'mt25qu512a',
> +        'expected_size': 0x1000000,
> +        'expected_erasesize': 0x10000,
> +        'writeable': True,
> +    },
> +    {
> +        'partition_name': 'rootfs_b',
> +        'flash_part_name': 'mt25qu512a',
> +        'expected_size': 0x1000000,
> +        'writeable': True,
> +    },
> +    {
> +        'partition_name': 'rootfs_a-rootfs_c-concat',
> +        'flash_part_name': 'mt25qu512a',
> +        'expected_size': 0x6000000,
> +        'writeable': True,
> +    },
> +]

I recall it being tricky to get this kind of markup to render correctly
and not produce a warning (which is fatal in CI) when doing some of the
other tests. It's possible, it's just a matter of indentation and some
other hinting to the tools that this is an example bit of code, in
essence. Thanks.

--=20
Tom

--ISZfIMOfzaPp21G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahXKqwAKCRAr4qD1Cr/k
ChRvAP0cziyDheS303c/lk+t1xUFsRBrNKo54RjUDGLTs+hvoAD/fa9Gvpniettf
CnJ0LU/pl25f2zcnkax/ZuoYpca+HAE=
=4JpS
-----END PGP SIGNATURE-----

--ISZfIMOfzaPp21G9--
