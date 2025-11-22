Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0991ACFC539
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 16:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445F383AEF;
	Sat, 22 Nov 2025 17:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aAz40cT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1349C839DF; Sat, 22 Nov 2025 17:23:29 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9454839DF
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 17:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e80c483a13so2005198fac.2
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 08:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763828605; x=1764433405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rQgwv2E/7TpeS6vcTgCuJzNFkt2QR+8LddIgvYbypqY=;
 b=aAz40cT3DzO9B5sAVbRVzTfNmQkc+N2BXJx86WkeepX9aJHGuOXu5reIDDwy+GtCC7
 7QMCY4xdJpupM2G1RI97+AsDFCxpQEChnXx2WrKmQC1bneVyTgomMEqo/K66hIMCd8zw
 W5Lly+3FjLEruY5SXr1BfdCAHDH0IS+u5aEgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763828605; x=1764433405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQgwv2E/7TpeS6vcTgCuJzNFkt2QR+8LddIgvYbypqY=;
 b=OUB0SR8rapHCTceskWg7qZGAi/kMOPVgkRRlxVNm5s0FAjI4ee7g/q/KeNKL87tIq+
 Q194J0H6/rnsDyD0avvZYbXcGrTUh993DKunzoS+O/ufDfT5IJpbVsJ7EqDnA1HLSYgt
 UbH2ODoVBon4S0OwzgPrbKmRn2JaM/I7s498JpfWhnqM1j3WzMk2ps2xT+sSb/VhZmUM
 UGipAGixFMdjdkHAS04XoHaHXMF7zdx9tZFbLHi3CeZguLVYTMlfzupzQpIUMlmTlsHP
 WyLdDQZcvA/8sfYwph5iNyPAwZXawMqifAlaoXP0MpeBbr5Y9P1blrjF1DEDK/yBrC6S
 s67w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0L6UMw3dgA+DhJpLgedaYK/uf10gmYSZlnPT4viSmxQZipMiEqe2G5HEgKuBi8LE6qyTX9Fk=@lists.denx.de
X-Gm-Message-State: AOJu0YwJxQjHg/ZxtjUu4l1yizVS4sDT1vVD+9f+1JEm21IKsFNtOXxc
 m4Z6TM2RQ3kJ5RkGwQ3zrS9A/RNGpkmu3Zbwk/89NUccBAlfbTS4D/iFkXkXcYClUpg=
X-Gm-Gg: ASbGnctMbnJ8jyd3kkaqA0RIv1YBWD8Otkmymo/Q/t1rCLObykal1REKlya5EzHX0+m
 N5XOPibGnMiPw/ubhq5daJeblZiK2VROd9+P8MUDHl/aiZ++/DLoysXRQEfi14It8Q0+XRSkIbJ
 SeBVrci2Ora76FWaTYvuJU7d98FXXwh1W9XzoWX9c8ja05jETWbAdjy4ZM5j6QFVBLDlm9aWWEJ
 tZ53ujMUyGpydSkPDuQ/QpHjpgQ1Pi4fV5gRuiahVenA8AinW/wjeN/DsFsyHDp1h2dtIu2iqlN
 DC5F3ZcsSi6ozrVzyUxFoXa6Jrsj9u14b83pnpS5iPrHNPlq9+GZfbD8Dm/5ZTbtJcDq+DP0iIi
 egUyKhV0G/X7ZBtIWQkWyNitG6iH9YBUcYwXZnZwQYHPHVGPAjizjZTHB8PjdvvJ1F4VtUTULLO
 XE9zEsp9BZXN223NUz1RpomUrgWxHnmBHp87oCRjmL2RfSsoQFAFUe3vjLiSYR
X-Google-Smtp-Source: AGHT+IFYH9l55v2L9fBLFhH4EiKthbbPtnUWOBGxo6/3Xq9nf+ndJUFUFFGLclfPTs1a5kepfWbgcQ==
X-Received: by 2002:a05:6808:1786:b0:450:8933:b732 with SMTP id
 5614622812f47-4511572ea1fmr2456507b6e.7.1763828605533; 
 Sat, 22 Nov 2025 08:23:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe2d3d1sm2506041b6e.3.2025.11.22.08.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Nov 2025 08:23:24 -0800 (PST)
Date: Sat, 22 Nov 2025 10:23:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND 1/9] test: fdt_test_apply requires
 CONFIG_OF_LIBFDT_OVERLAY
Message-ID: <20251122162321.GA3053902@bill-the-cat>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2rzEO1wf7C3mQj0L"
Content-Disposition: inline
In-Reply-To: <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
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


--2rzEO1wf7C3mQj0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2025 at 11:10:02AM +0100, Heinrich Schuchardt wrote:

> The `fdt apply` sub-command is only available if CONFIG_OF_LIBFDT_OVERLAY
> is enabled.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/fdt.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> index 96a8488e172..a36f2dcdda8 100644
> --- a/test/cmd/fdt.c
> +++ b/test/cmd/fdt.c
> @@ -1319,6 +1319,9 @@ static int fdt_test_apply(struct unit_test_state *u=
ts)
>  	char fdt[8192], fdto[8192];
>  	ulong addr, addro;
> =20
> +	if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
> +		return -EAGAIN;
> +
>  	/* Create base DT with __symbols__ node */
>  	ut_assertok(fdt_create(fdt, sizeof(fdt)));
>  	ut_assertok(fdt_finish_reservemap(fdt));

So, this is interesting. As part of merging this, I see that on
qemu_arm64 for example:
               u-boot: add: 0/0, grow: 4/-4 bytes: 284/-9691 (-9407)
                 function                                   old     new   d=
elta
                 print_hexdump_line                         472     556    =
 +84
                 fdt_test_move                              568     652    =
 +84
                 print_do_hex_dump                         1704    1764    =
 +60
                 print_display_buffer                      1736    1792    =
 +56
                 static.__func__                           5670    5655    =
 -15
                 bdinfo_test_all                           3064    2884    =
-180
                 fdt_test_chosen                           1496     516    =
-980
                 fdt_test_apply                            8524       8   -=
8516

So we're as expected shrinking fdt_test_apply with a build time
optimization. But we've been building and running this test as can be
seen in older pipelines and their published artifacts. Should it not
have been a failing test? Did it fail for you somewhere or was this
found by inspection?

--=20
Tom

--2rzEO1wf7C3mQj0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSHjdgAKCRAr4qD1Cr/k
CuRLAP92idBAuk1kUyvBcBfJT0iqxysZhRo+oRfmLPm3TRN9+QEAjn5dp2nGASnu
oZdKQ1wzY+3odtANjJ2xu0HVHNF35AY=
=I7rd
-----END PGP SIGNATURE-----

--2rzEO1wf7C3mQj0L--
