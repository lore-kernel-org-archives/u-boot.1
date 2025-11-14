Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A69CE8D76
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 18:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C325E842EB;
	Fri, 14 Nov 2025 19:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ig2eohzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1072A842ED; Fri, 14 Nov 2025 19:54:58 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC36D842C4
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 19:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-443ac891210so116590b6e.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763146494; x=1763751294; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M6MR8Y0696AJ+NvmxoeQv/TMq2cLLSh1LjXI31Gi8E4=;
 b=ig2eohzPe/1gMTAfptPAQj/Iat4Qq2rOJN59OGQkUPZSGkfLIur372TtVLdarohm78
 D7ZqAHVZrZlBqqFnN3L813idiRaZUEs2AsUbMeJ3EQL/Vk09da4KRaoxKSNbk2W8/YUN
 jL8HP94zfOjGwqyWOXZFZMsFHeJux+X6tgrPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763146494; x=1763751294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6MR8Y0696AJ+NvmxoeQv/TMq2cLLSh1LjXI31Gi8E4=;
 b=jmVSz1EM+pH44WqEW9dT/5UfYFXCHKSns0/7veADinlNgYCP9BbL6JhYOcfA1JhOXl
 y7Y8K/VxClPf2y5KyIE+z8oyvxfgnj3mGJz1Txkmzd4cJrXJn0x39nnkhFsaSmkrpzgg
 P65LABf8atiuWIa9kZeHvlnaewNNTFiaslAAFwsydaeoV2HBp5xNP56xgl6f32387p8r
 qFs3O/R7K0BsTJEMQUsREmvJvY5nAz/vISF/ezEUxJE3de5nduNqx0PSiUHiJCmlz3WE
 rwAwcZ3wSc1OemfjpjFdvXV7cLxXo+O13r2XvBfWTrkXb5ApTPathH4G1XDt99KM7rZh
 19yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmqtiJBXKMVCEVkuHCRKLDasWOHXSN9lLqlecjH5MT4mi1yim6/Q9eYVs9hRAYJA2hf6QhGhk=@lists.denx.de
X-Gm-Message-State: AOJu0YwOzwCIqiKFY4pLmfoqwc6PwIWh7pfaUZ/SmGvAjRZFkxxc9MuL
 7lOSDmrW2YXLXOIfy/whcMmM5ylQp771jIo7wCFZLDROc/bPjEOshLmLUIiNIlpTdeM=
X-Gm-Gg: ASbGncuDcuhxNl9kUbhDy/G2CxOZmCogbVUxaGhtyTu7/6NhJlekSVWZ/aVW3vSWmBR
 cDe+Y7RP9Yy+Xzl/OEe0Ir7dEFzYdLiGUzWRc5WrtLcsxk07pZddzwv0xe/Xa9+xZc+t5nsmXZH
 WS+4uZuCIHZlgV1W9RP1Q/X6G+brORvQRVZ43Fa9LIfnERsMiNi3IooLMHV5mX+Y401ZbjqVBru
 NkagcLeZJTLq+lhfkGpsmFQ+T3rmRvEhvbw7vVw0+x2eBdk0eHIJDeGoPNisGzhJipeBY8V9Tyd
 x70mnLPNvPL4kT9dTwiC+gBiQpuJwo5ermx5mnJGy09AKqcxIf83WWmZ8svWWnkDNns+zUM6Lln
 85wgBKA3PR7nQJQ4Y5PwqGncF4Itn/3WLuy8pWFloWK9cYjzI8p0/Vd6jz2tMKC2oGalrK2dHfw
 oe7REAIwfWWhMKAvTJTPfuUjJVVH76IVcU4Id5a6o=
X-Google-Smtp-Source: AGHT+IHbznopXB3xHiiuzxWkB6BQy57cGQYX56c8kC+Y0OA0s+NaQSzA2tV+D40bK5JPwzlpjS6GLw==
X-Received: by 2002:a05:6808:c015:10b0:43f:ac46:7aaa with SMTP id
 5614622812f47-450974ea279mr1447064b6e.42.1763146494515; 
 Fri, 14 Nov 2025 10:54:54 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a5303desm2333432b6e.3.2025.11.14.10.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 10:54:53 -0800 (PST)
Date: Fri, 14 Nov 2025 12:54:50 -0600
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
Message-ID: <20251114185450.GA2125796@bill-the-cat>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
 <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
 <20251114141943.GV6688@bill-the-cat>
 <CAFLszThhPVcKhcbxA77HCwrRcq9H1+p_YvEmir3p6TEkLb1YQA@mail.gmail.com>
 <20251114144331.GA6688@bill-the-cat>
 <CAFLszTibCE57HPEgEnkVkzmcLVMbQsk5mDKP5+mrn+ZHQOGeAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BzT5aurJGxUGWmzc"
Content-Disposition: inline
In-Reply-To: <CAFLszTibCE57HPEgEnkVkzmcLVMbQsk5mDKP5+mrn+ZHQOGeAA@mail.gmail.com>
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


--BzT5aurJGxUGWmzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:10:59AM -0700, Simon Glass wrote:
> On Fri, 14 Nov 2025 at 07:43, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 07:24:53AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 14 Nov 2025 at 07:19, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Nov 14, 2025 at 05:31:40AM -0700, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
> > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > >
> > > > > > The location of memory depends on the board. Do not assume memo=
ry at fixed
> > > > > > memory locations. Use memalign() instead to allocate a buffer.
> > > > > >
> > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonic=
al.com>
> > > > [snip]
> > > > > >         /* bytes */
> > > > > >         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12=
);
> > > > > >         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 9=
9 aa bb cc dd ee ff  ..\"3DUfw........",
> > > > > > -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 :=
 8,
> > > > > > -                          (uintptr_t)buf);
> > > > > > +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 :=
 8, addr);
> > > > [snip]
> > > > > This is adding memory allocations to a test for hex dumping.
> > > > >
> > > > > It would be better and simpler to use a fixed address and make th=
is a
> > > > > sandbox-only test. I struggle to see the value of running these s=
orts
> > > > > of tests under QEMU?
> > > >
> > > > Removing context to highlight value of running tests on multiple
> > > > platforms.
> > >
> > > $ ./tools/qconfig.py -f ~PHYS_64BIT -l |grep sandbox
> > > sandbox
> > > sandbox_flattree
> > > sandbox_nocmdline
> > > sandbox_noinst
> > > sandbox_spl
> > > sandbox_vpl
> > > $ ./tools/qconfig.py -f PHYS_64BIT -l |grep sandbox
> > > sandbox64
> > > sandbox64_lwip
>=20
> If at any point you have made up your mind, please say so, rather than
> continuing what I intended to be a discussion of the pros and cons of
> this patch.

Yes, both Heinrich and I agree we should be running these tests on
hardware. Don't run them on hardware as a position has been rejected.
You can stop reading here if you don't want an explanation.

> > Good, and as soon as you restrict to "sandbox" we stop running
> > "sandbox64", it's why sandbox64 runs so much quicker in CI.
>=20
> This is a C test - test/cmd/fdt.c so it is built for all sandbox
> boards. The restriction you are referring to here is for pytests, I
> believe. The core of my argument is that running sandbox tests on
> other architectures is mostly a waste of time, assuming the compiler
> is functioning correctly. This patch is also devaluing sandbox, the
> major advantages of which is its fast, native code execution and fixed
> execution environment (memory map, etc.).
>=20
> At the very least, it would help to be clear what bugs we are hoping
> to find with this change.

The position of "don't run tests on hardware, only on sandbox" does not
sound sensible in general. In practice we need to do more, not less, on
device testing and saving milliseconds by skipping tests is noise lost
in the time it takes to acquire a runner and clone the source code or
even which runner we test things on. Spending time on "should this run
on hardware or only sandbox" is time not well spent. Finally, "do a
bunch of stuff on hardware" is still the best overall method for finding
unexpected platform bugs. It's how we catch "some clocks are wrong" or
"we configured thermals wrong" or "we configured memory wrong" and so
forth.

You mention QEMU, and yes, we will be executing these on QEMU in CI, on
some platforms, which are our fastest pytest pipelines. But we will also
being running these on hardware, which is my point and I believe
Heinrich's as well.

--=20
Tom

--BzT5aurJGxUGWmzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRd69wAKCRAr4qD1Cr/k
CrFzAQCN4N2STBuGSqRMpleNzM5sg63592M7tuN+bxm0GBs4bwD6ArPc5rGghAKg
Mg07P0M0Jc/2lKXszO4ssztUwJv//AE=
=dQvr
-----END PGP SIGNATURE-----

--BzT5aurJGxUGWmzc--
