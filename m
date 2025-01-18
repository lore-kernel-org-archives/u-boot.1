Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B859FC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 17:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067BE803CB;
	Sat, 18 Jan 2025 18:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qllmrpnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6CC8063E; Sat, 18 Jan 2025 18:03:49 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B977C80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 18:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6ea711805so426411485a.1
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 09:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737219825; x=1737824625; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8I3thPw7yHoaoUvSlDHEwkZLOuH4DiM7iVuzVOUDpew=;
 b=qllmrpnjSqkfQBlspZxTB5hW4yGSIsdAs92h+ndNZd8B+jCGTaFFcE1m5wKcOhv0or
 NEc0YmqJ8E5k/3tDceOcej4H45UeYiKACDNcGyd5II591LXZ9Dq+0PJbRuvsc2QnoBRI
 wwh5ZHOUvKTlsQ/G1lpvrV3GFeGM/CRpz9F1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737219825; x=1737824625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8I3thPw7yHoaoUvSlDHEwkZLOuH4DiM7iVuzVOUDpew=;
 b=rizREKIyUQMr8H3xsnOyONA4zI+SWbvQMNGdesgBJ3nNxLOI5Qv9oPPBa0KD9V3pAX
 Yxkl87WlVWwexqm6YggZOjKL4SKRcw/XP1/yio5O5fwm8+SzQX1ftY84lf5Lj5EXNT+p
 yvbewenecmRV9O6S5L7Yg0RJIi3tQihbBq2nXQQC04AoRE1X8W2zx/oKf+9S99QjZx4Y
 GoDcHp+5NHTQbwg9wJiZU8VsMHhaLzRcdaT6LLdPq39tpbZXUsHTXikljYKUybbGXTqb
 /4VcikSZZvQu9VH9Dh2IZvipjH6UJQHPvsd+XLXQx9NClxdhhUUK3QTOawjXrmJ73own
 QxPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1EsHO4E0qasPTDIKtoKgan+Vdpx7RC6FHOWfhNnmyv85R9IwOipQyRPpDyZ6DJjZyu3bQUQk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp75Zr/OsNL8cYi8t4kc59Zx4NKEZOzNqU1yuUeRNMAK1/pror
 feOqtSheblT42ayyVYU9s9P8oXqktbdoCWHIcUl5tqkYdI2uDAACkIfqzxXjoLc=
X-Gm-Gg: ASbGncuPYrFJduy2ToM9K+fMlI5H+YIfQawzQRpq8p9Psu8+Tr8Pfy/NLgoh0sjZgI5
 iRPJqHdyvNW13+/Xj4RPJXkXnxvFdYRBHJcLA5Bz14l0gCQxN2AKHFigJF7gC78HK2PT/+JtWw1
 Nc16i9i07KbqqD1tGYgoCzKDz9Y0PQOafs7SizA1SFP9WTbAumuWJgHuwXG8NkbyoPM8Adpmwn4
 eG287gdKK/3GYpNTvw5GkTnDE3bOmjnHMz9xNqZstoZ6KHWxecTzX7mlUnLR5dy0hI=
X-Google-Smtp-Source: AGHT+IFZ7SKBIVqQ3PcXAjDqiZujhrLgJyPLX2YTkEio3aAzI25q4rTX6kOuqPjHyhBD9wVw+YfW3A==
X-Received: by 2002:a05:620a:2405:b0:7b6:cbc6:c87c with SMTP id
 af79cd13be357-7be6320c3d0mr1012854985a.30.1737219825402; 
 Sat, 18 Jan 2025 09:03:45 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be6147e30asm244131885a.31.2025.01.18.09.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 09:03:44 -0800 (PST)
Date: Sat, 18 Jan 2025 11:03:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Message-ID: <20250118170340.GZ3476@bill-the-cat>
References: <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
 <CAFLszTgWe7-zDejNzn1+QDLhjAHz8e=m+r5zYSmf91RAY=ZkTQ@mail.gmail.com>
 <20250108191457.GQ3476@bill-the-cat>
 <CAFLszTh8BZGEpTs_gxo89dMdd6v3PmuFtTMHxmfGXDUwmdaMfQ@mail.gmail.com>
 <20250109165121.GZ3476@bill-the-cat>
 <CAFLszThGNgH2rtLK5d+YEj4-p+cFpVLtMu_+Z_SHYbU8vp6Wkw@mail.gmail.com>
 <20250110164829.GJ3476@bill-the-cat>
 <CAFLszThVjiDgi5_V0yRbWo2pbbv3LEZA4TM=dkiJTd8D6gTe=g@mail.gmail.com>
 <20250113202026.GC3476@bill-the-cat>
 <CAFLszThscvJzBrnSovQsrMr5ie75NVc1yUss0-c_WZLksC7Rcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8oQ1YURXnwHHXYnT"
Content-Disposition: inline
In-Reply-To: <CAFLszThscvJzBrnSovQsrMr5ie75NVc1yUss0-c_WZLksC7Rcg@mail.gmail.com>
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


--8oQ1YURXnwHHXYnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 08:35:42PM -0800, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Jan 2025 at 13:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 13, 2025 at 12:01:36PM -0700, Simon Glass wrote:
[snip]
> > > > Sure. test/cmd/hash.c::dm_test_cmd_hash_md5 fails randomly, in mayb=
e 1
> > > > out of 100 runs, via pytest, in sandbox. Not via "./u-boot -T -c 'ut
> dm
> > > > dm_test_cmd_hash_md5'" however (I stopped checking after 1000
> > > > iterations). I was iterating over "and built with clang" but I think
> it
> > > > happens with gcc too, from the actual failures in CI. And you can u=
se
> > > > "-k ut" to limit to just what's matched there, so it's a quicker
> > > > iteration.
> > >
> > > Hmmm do you have a link? It's hard to imagine what it is, but perhaps
> > > a dependency on a previous test.
> >
> > Sure:
> > https://source.denx.de/u-boot/u-boot/-/jobs/993200#L286
> >
> > My current gut feeling is that we've got some section overlap issue
> > somewhere. And, FWIW, if I turn off EFI_LOADER I still see it. And if
> > you use the same binary it won't always fail.
>=20
> The only way I think the hash command can return CMD_RET_USAGE is if there
> are not enough arguments.
>=20
> The only way that can happen with this code:
>=20
> ut_assertok(run_command("hash md5 $loadaddr 0", 0));
>=20
> is if loadaddr is undefined.
>=20
> But (like you, I suspect) I cannot find how that could be.
>=20
> In fact, I can't even build with clang:
>=20
> $ buildman -O clang-17 --bo sandbox -w -o /tmp/b/sandbox-clang
> Building current source for 1 boards (1 thread, 32 jobs per thread)
>    sandbox:  +   sandbox
> +/usr/bin/llvm-ar: error: arch/sandbox/cpu/built-in.o: Opaque pointers are
> only supported in -opaque-pointers mode (Producer: 'LLVM17.0.6' Reader:
> 'LLVM 14.0.0')
> +make[2]: *** [scripts/Makefile.build:333: arch/sandbox/cpu/built-in.o]
> Error 1
> +make[1]: *** [Makefile:1906: arch/sandbox/cpu] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
>     0    0    1 /1              sandbox

This command works fine for me in the CI container, so I don't know
what's going on with your local installation. I've also seen CI fail
enough times now with just regular sandbox that I don't _think_ it's a
compiler specific issue. Thanks for looking in to this more!

--=20
Tom

--8oQ1YURXnwHHXYnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeL3ukACgkQFHw5/5Y0
tyyrXwwAup9c5wuHN6RRAuhtu8kHBcF2GCZMI8hTbEjpIbvBCp8ylhgg1EDMhLhx
jO1qEIpPXASZKSjEzWWhgLSPPB6a4LduzYRcIdKJ6sTe0295+X+iGlF6sVugXVsj
MJiPwCnarwSAS4s4t3MCC3m/ufsEdt42mq2w8a2Wyd6l7HWwjpcSj/s+0VyqeRj1
0jw4Wls1/mjDix7RgCX35XLH87BhnSowfkLgkKRu6rgQoxmfRF+GHY5aoHCpCHNw
Nwx/7mh6SH42CUuz+GR7L4X5U6EEwXHjXNz90XEq3QMpi6n0Vc3CGSNbdHNl+kv2
nkszvrY2pHlvJH0qldUb6umS6LBORDzCe/Lh1PhP3R0VyTL0rs1tia/tBLe4uT9h
K7SG3ababOURD7nZAmZAIJfHWhZWiRyZKv4HEeBj8b1sj34LW4IcWupmuznsMgTZ
0yeAkswFf79TVTEIkJQVY+e+Ij95BApS8yBk/YaHHJ3XRT1KBBA194tEGrlA0hg+
gcKSPWxA
=NWhK
-----END PGP SIGNATURE-----

--8oQ1YURXnwHHXYnT--
