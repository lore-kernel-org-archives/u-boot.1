Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4B8CE7B12
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63777840B5;
	Fri, 14 Nov 2025 15:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fx37aIx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242A3840EE; Fri, 14 Nov 2025 15:19:50 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CDD83EF2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e4228e0fb7so1008337fac.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763129987; x=1763734787; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=plRbgx4Y4wXhCgUBnt1QCx6DrxpEGtd1CiUoi3+hDaw=;
 b=Fx37aIx/XgmZzS3pp9yo8EW5bWgbDsvqquCUVMEqIFsp2RTfiaqm7Tx+W8uLK6OUFh
 459R2X3zt8c18OotWWh82LehHAF0btFkFHFv5q+9tM0GQK0OIYgRWyQFqke5O3OYcmD1
 Ime2kT9ZpdptmHvuEc2vHPAYWavKeYS7kybtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763129987; x=1763734787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plRbgx4Y4wXhCgUBnt1QCx6DrxpEGtd1CiUoi3+hDaw=;
 b=Y+k2NKp9HHJQvjGHshcnOW0ZYiXuYn0pm5Qi0PJ2aB1YnJ8iFsDIjnbAWNZswjg6UU
 HRZ4PvbqZVuPuUVgP9oMfC5FrPEzCbp7BmM+ypI1co29F50pgA5/7oA7XvJUzHuIFuEl
 GMBaxJAJoSBvSXyT8huqCyyBIUwQbsd5BUG/A7o9OQ3qXRYhXFIcophpJ9A/dVYb0Jga
 dBSbHQHPvsl99paTzWcMVOSwgdnaXL3X02DrLM6VHkuBAOpI9kDDUA7Tfpr4ql9p32Ir
 +q0AXlWJXCEAvJkD8HDMoyV2wxWwhVVrImNqGQ3dZ59HdAj4+sSKnl3R37SKjkbqZJ3V
 G/ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyc0mCBOlUAKcnERYh2VSIBCzpUgCoRcbQrkamJVHWeuCv5dAojeevcWdFsETZ6lTK2XVJz44=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ3y5g2w4Jrrk1A27fN+z+b1lCuWWjXU30ezWhCEP2ymY+EI1o
 N7CMonwc0YlnBATSKmK8G04TTr6osLt4sSgvLF/FQ6lOKjlv+vbG0v7zTKvWoUpa1aA=
X-Gm-Gg: ASbGncsBcrLumK7ZBBX/R5jVJtFjrUAYJeKTgKNS821j8X1leE3exMdfgSJ0xEtmqfs
 qepB8svwF4l9I5SpQe6b6MEhg6p/cbaFmPq5t3KykpLbM0SyVU5ac4hVzeumyfy/mVFg0K5vyoA
 kddzlN++bRz7nBQQbitRr/9tqur76pw0WWJvW7uBwZ6vCNRlbXvP5gQlO0HltGINaXoS5tO6yUj
 MmWSsBVuIcyKI2KeVb8RNjGvRSoGB6SP875mCncDE++pEEPxaET+7ZuhRLEDlIxYkD2CcSCHypy
 KXBP/0IG2Rng2thG0K207k9GFMm8V1on3tS9CKfd7Yl2Q9SbI9yn8dAfFibUQ2n8z6jk/Fmj/tl
 ag0D5xxdmKFTampOWR8D4eYS8FdSqW6fmJLMRW5mQY+LEWWhjw90hB3EfoZabvykQeCa7WmWvnV
 fIe+prfFlzd3GvMXfPSsv4k1Hob5lQ0teGLtLISQg=
X-Google-Smtp-Source: AGHT+IEwvh1bEGWaA8AhVdQqTKONi1Jbvx90uPWZ+iqbM8ciFOsuNX3/696iKt4xCHiMUPCginVn6w==
X-Received: by 2002:a05:6871:ea0d:b0:3d3:b66b:48e3 with SMTP id
 586e51a60fabf-3e868e31157mr1480105fac.1.1763129986695; 
 Fri, 14 Nov 2025 06:19:46 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522637e1sm2758730fac.12.2025.11.14.06.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:19:46 -0800 (PST)
Date: Fri, 14 Nov 2025 08:19:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
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
Subject: Re: [PATCH 6/9] test: cmd/fdt: do not use fixed buffer addresses
Message-ID: <20251114141943.GV6688@bill-the-cat>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
 <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+vBPjAjExJBQNxB9"
Content-Disposition: inline
In-Reply-To: <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
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


--+vBPjAjExJBQNxB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 05:31:40AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > The location of memory depends on the board. Do not assume memory at fi=
xed
> > memory locations. Use memalign() instead to allocate a buffer.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
[snip]
> >         /* bytes */
> >         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
> >         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb =
cc dd ee ff  ..\"3DUfw........",
> > -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> > -                          (uintptr_t)buf);
> > +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr=
);
[snip]
> This is adding memory allocations to a test for hex dumping.
>=20
> It would be better and simpler to use a fixed address and make this a
> sandbox-only test. I struggle to see the value of running these sorts
> of tests under QEMU?

Removing context to highlight value of running tests on multiple
platforms.

--=20
Tom

--+vBPjAjExJBQNxB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRc6fwAKCRAr4qD1Cr/k
CsYJAPwKaBuZOfQzDl9e/cc8ZjYHbVUSAWG0gOHq6tvFWuvIwgD/VPDf/883ISVT
0JOWLTZnnfH5kGHPSqd0haMfIDIcgAM=
=BEoa
-----END PGP SIGNATURE-----

--+vBPjAjExJBQNxB9--
