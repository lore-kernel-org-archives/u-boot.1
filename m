Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF8CE6781D
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 15:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B9388DB5;
	Mon, 11 Nov 2024 16:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HHZXvHg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F87888CF1; Mon, 11 Nov 2024 16:43:14 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B2D88EFD
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 16:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b148919e82so318930385a.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731339791; x=1731944591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DrpxU59Gp5m9dGr148j+SYaDaeMdErNVwWrR5x2eI2Q=;
 b=HHZXvHg3+wr8qd6T4DYwA5J9AXrgPCbxVRX0mYICw2Ny1c9/U+9frNXXqb8EtUIUq/
 +wirLZDih4q8CRgzSIpHTd683elKPahS3fQVYBZanlq6iuL9uHDVayHztNqvd1jFgTUt
 qyMSRdCbZRf15qPEVXTrfbNCI3BxUnR0CkFc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731339791; x=1731944591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrpxU59Gp5m9dGr148j+SYaDaeMdErNVwWrR5x2eI2Q=;
 b=Z9uy2O8OK8q3iiWgtz/Xdz6tSykgyvVNNOHY0ZjqvOn+y2Bn4jo+6Lxf7F8ZrokWUT
 ecs5RM8jJAGQtPnXKF5DR1JUIcuOFgHy1X2o3Gmb72xXbRYRvpnrnBw/fx02npwDxcu+
 5uNV3dy0VcAggn8kstxY+uxJ9cZOc5a0jVGP8Q/dYrVQKUquN56oKSJV6Abj16NtXgj9
 O3iVpsfYiDEzlCEQfPO11GgLJhy3iiffnWmLsjtBSLOf4Efj3n9iTdncFEzE2nrQ7WDm
 3/F3QLyyXzUV8V2sAzSLi+5yFSgjC5Z1hFC1F/JHVcrn68bJnCbrByiI82kdIwwzY1dq
 GtRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVYYjUr0uOfSN9bmnCxlg9IzjLx7VxJAWqnM2omyjoNeJlTYkM+6a6KeIrDU4bTQrKBUJ/vNw=@lists.denx.de
X-Gm-Message-State: AOJu0YwoLc0JPoD9hN+5FVA/tYFt181BAwVTQjou6Z2XRM7a2se4jf+I
 ujdBmVi4FMA9lbglvu6RyyNjcEk3rBh/xd3LFxnuBS91EPd/QJer5Sit9jIl1wE=
X-Google-Smtp-Source: AGHT+IGowXw1Y2K1qI6mtPgLDB0Vft0IMlmk+8q3qxXNFuGKM+aAC77PX7awFm0oSqZ0jDpiY2nBjA==
X-Received: by 2002:a05:620a:2916:b0:7b1:456e:2a26 with SMTP id
 af79cd13be357-7b331e5f68dmr1758564885a.54.1731339789485; 
 Mon, 11 Nov 2024 07:43:09 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32acdf2fbsm506552985a.105.2024.11.11.07.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 07:43:08 -0800 (PST)
Date: Mon, 11 Nov 2024 09:43:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjd@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] Makefile: fix empty MK_ARCH when using ccache
Message-ID: <20241111154305.GT3600562@bill-the-cat>
References: <20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de>
 <9883B8AA-CA7D-4A59-ADB0-ABC86210273F@gmx.de>
 <2dfa3ca0-346a-431c-b412-68f5ca1e2d8e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0HDhxfmDafNsIn5x"
Content-Disposition: inline
In-Reply-To: <2dfa3ca0-346a-431c-b412-68f5ca1e2d8e@cherry.de>
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


--0HDhxfmDafNsIn5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 03:43:27PM +0100, Quentin Schulz wrote:
> Hi Heinrich,
>=20
> On 11/11/24 3:27 PM, Heinrich Schuchardt wrote:
> > Am 11. November 2024 14:20:49 MEZ schrieb Quentin Schulz <foss+uboot@0l=
eil.net>:
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > >=20
> > > One can use ccache by prefixing the typical CROSS_COMPILE value with
> > > "ccache " (e.g. "ccache aarch64-gnu-linux-" for Aarch64). This however
> > > makes the MK_ARCH empty because sed won't find a match anymore since =
it
> > > expects the CROSS_COMPILE value to start with the actual toolchain (w=
ith
> > > an unlimited number of white spaces before).
> > >=20
> > > This is failing builds since commit 7506c1566998 ("sandbox: Report ho=
st
> > > default-filename in native mode").
> > >=20
> > > Add "ccache" prefix to ignore but participate in the matching regex u=
sed
> > > by sed to identify the target architecture.
> > >=20
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > > One can use ccache by prefixing the typical CROSS_COMPILE value with
> > > "ccache " (e.g. "ccache aarch64-gnu-linux-" for Aarch64). This however
> > > makes the MK_ARCH empty because sed won't find a match anymore since =
it
> > > expects the CROSS_COMPILE value to start with the actual toolchain (w=
ith
> > > an unlimited number of white spaces before).
> > >=20
> > > This is failing builds since commit 7506c1566998 ("sandbox: Report ho=
st
> > > default-filename in native mode").
> > >=20
> > > Add "ccache" prefix to ignore but participate in the matching regex u=
sed
> > > by sed to identify the target architecture.
> > > ---
> > > Makefile | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/Makefile b/Makefile
> > > index 7275a02f24ca64ebd46c5dc6e769dcdee9917dca..71743db16fca930567edd=
67eb77f1c94e9b7b4e9 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -21,7 +21,7 @@ include include/host_arch.h
> > > ifeq ("", "$(CROSS_COMPILE)")
> > >    MK_ARCH=3D"${shell uname -m}"
> > > else
> > > -  MK_ARCH=3D"${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*=
\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> > > +  MK_ARCH=3D"${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\?=
[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
> >=20
> > The target architecture cannot be determined in this way.
> >=20
> > You could use the riscv64 compiler to compile riscv32 when providing a =
gcc flag.
> >=20
> > You should not make any assumptions about the naming scheme of vendor t=
oolchains.
> >=20
>=20
> I am assuming nothing more than what we are already assuming for the last
> three and half years, c.f. f7691a6d736bec7915c227ac14076f9993a27367.

Yes and also, ugh, I wonder if that works right for using clang, too. It
does for how I use it, which involves setting CROSS_COMPILE anyhow but I
don't know if the LLVM-only option would work. Of course I also don't
know if that works today. The original logic is fragile, this makes it
no more or less fragile, and I'm not 100% sure I like that everyone know
has to set and test against HOST_ARCH, which we weren't before
7506c1566998 ("sandbox: Report host default-filename in native mode").

This should probably come in just after I tag -rc2 as it's a fix at
least.

--=20
Tom

--0HDhxfmDafNsIn5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcyJgUACgkQFHw5/5Y0
tyxL+Qv/bE8EF4T+2UVa2pMWSJ0yXUfUTNm9fVsl94G/5sQdmWj4br8YLqsB6/ZC
uFuixvYt+ktgGveIFmQDxu/xuftlWVDSnypE5GShRTGW7ld85Y9OQgrwK0/a4XrJ
UbH8EX5HalZfiKo4OBE9PuXL2sNM2PrU1BqHYZEKLP37zftuWtj2LnN3Rv6DaSlI
XyZldnCgvlGulnbVwx/iAva7FpLYnwtljL73uGOeqnBAeCKWMD/OALW+FkPvYX63
s3C20h2s3lGNudg1A5WTJY/1BOln+OUduzDBPSMKbJbTXzg+REXXNwbJzCNDQxqL
6b+crgAmLzqHM58z5yCO63dFBUM2goYmDE+0y6LBS94l9bVmNfaZFWZWaoCX4xsP
HvkJ9bHu03jRS+Dl9PJJkWIarUqC6AwWP/ZlZap9EWW9aopHzttgm3zcOfzAvS2J
cRGmPhYuRR42Sb7+ShjZWVsnSSWCQLIV/u755ZCfDRLQ1G/Fsy2OenDO6eOV6MAi
Y7CcpXzm
=uC7A
-----END PGP SIGNATURE-----

--0HDhxfmDafNsIn5x--
