Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C66D12668
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 18:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8313C83E92;
	Tue,  2 Dec 2025 19:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bM7x5hCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89AE83E9F; Tue,  2 Dec 2025 19:06:18 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E7083E48
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 19:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-65748e230f9so53446eaf.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764698774; x=1765303574; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DDZCKgiBvAaxOMwQM6AsTqksO5ShmqaOHYbXlhiinMg=;
 b=bM7x5hCl2sv//TLh3fy6OZgLNSPVkWeSGpThPR2pgiBohy0L3d1i3TsGcJIjR2//Rq
 xpHoocg0eHPEgYNR7sMxq5ybnpMch9IZhtDkYJoLWncpgtIaZHmhwG8XyI9XW3gRDCdT
 aYqNmxOh5gisqCMQz3dOHYrePHh1nupD/+jFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764698774; x=1765303574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDZCKgiBvAaxOMwQM6AsTqksO5ShmqaOHYbXlhiinMg=;
 b=eYfpU65Ma5jIE9amxolj4JUWLk43g0W3UyDaBuN82dBpALVnVZiXn6/3Kyb8YYSv+x
 CSR4rmmP1QwXtOwKDMMZ+QbsxPvBWZi9XMk8lK2nPMOfY6RgwYvAhud9rxghC3Yp1OYU
 4opR2DzxK/j9QkgOfTZXwbqKq3kTdRRzNjhPKV8F9dDljIZZ5lRVTDWEANCM8rHwy2+9
 AsOM3pNOJ4YoVGulIHuWrmassD4I3AEryBaZapdDu1ZHUh4zGaR8AcESATW6DEH/5hZ3
 pPMEDkOaxWryf6MMAWk9s84YJA5gngCfO1zp9wVkQAoISDVw6wY9nQ4KtgjBgyQl4SM1
 r/KQ==
X-Gm-Message-State: AOJu0Yz6OFGCF0bzww7NEA4IjFYNP65GmbCECCiksaApLYudjqvCC9yr
 mlgan0DoXL8VCiFaa2ZV0KZki9+vF7o1Sh5QXaDSOz7chXnqc/2x/RVHNAlGoQ0axe4=
X-Gm-Gg: ASbGncsb/dmclMlbA/678Hx3dnuYntZjwEpSVCdn4SsOi9n4tZmb717pkQmBOJxJQi4
 qiVdSuETU0geQ4TKiCRZ4PDic+dey3dKwvDJUtopmZ+uM22XSFbqb5xclWrtFemIJKyOh2Rolby
 fKKR3VYvx6ZJeJGMq8jzTQIu9XpcW0heISzCh38YTlljy6+W2S5WhrHIhDYcpCf0XH6U8MHEV/n
 fD5cXl1bcp0BeuijMlt4LKKRlXedVz4wLi9DTHir8TZ0w2yR4xi9QHRvlsCjInuXtPbZAu7yy/7
 uBTH0H6m8l3cFQZnbMZxfP7+uXC6h9t5zojRdKDRSuZLg9jK4FzRZtbhmMQ/uwjvCgxUoA4Rmkt
 Mg1oRpyBrjIckG/4B7u+SINqJn2SG5AqCoKTddp2HyB0V+aplnTZRRMyh4rTxyQP9ctux4YzrIH
 6sxp76119zoaAQjkZ1do5uETemLTVkdiSs9zJ6ENezZ4ccjb2YOQ==
X-Google-Smtp-Source: AGHT+IE3tIq9ZNLr0kP0psFwsviJICXqJeNpp02Rg42o0dLnsEDBBLki80APWeUfPEZjdmvoVKG0GQ==
X-Received: by 2002:a05:6820:4de5:b0:656:c942:93b2 with SMTP id
 006d021491bc7-65966c00a9amr1916320eaf.4.1764698773954; 
 Tue, 02 Dec 2025 10:06:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65933237991sm4227159eaf.0.2025.12.02.10.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 10:06:13 -0800 (PST)
Date: Tue, 2 Dec 2025 12:06:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
Message-ID: <20251202180610.GE303283@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <20251121195512.GE2125796@bill-the-cat>
 <6daeb492-0c5f-433d-b4f5-56ad5ca1704d@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HZ2OJ2JgNAtn4Ptc"
Content-Disposition: inline
In-Reply-To: <6daeb492-0c5f-433d-b4f5-56ad5ca1704d@mailbox.org>
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


--HZ2OJ2JgNAtn4Ptc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 06:46:07PM +0100, Marek Vasut wrote:
> On 11/21/25 8:55 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > > Synchronize local copy of DTC with Linux 6.17 , using commits picked
> > > > from Linux kernel. This also includes two fix up patches to make the
> > > > DM core work with new 8-byte alignment checking in libfdt and anoth=
er
> > > > fix for NULL pointer check that is missing in libfdt.
> > > >=20
> > > > This depends on the following patches sent separately, which fix
> > > > various 8-byte alignment problems in the code base:
> > > >=20
> > > >   - boot: android: Always use 8-byte aligned DT with libfdt
> > > >   - test/py: android: Point fdt command to aligned addresses
> > > >   - test/py: Use aligned address for overlays in 'extension' test
> > > >   - sandbox: Fix DT compiler address warnings in sandbox DTs
> > > >   - sandbox: Fix DT compiler pin warnings in sandbox DTs
> > > >   - boot: Assure FDT is always at 8-byte aligned address
> > > >   - arm: qemu: Eliminate fdt_high and initrd_high misuse
> > > >   - efi_loader: Assure fitImage from capsule is used from 8-byte al=
igned address
> > > >   - MIPS: Assure end of U-Boot is at 8-byte aligned offset
> > >=20
> > > So, taking a look at the test branch you pointed me at, my big concern
> > > is size growth. On imx8mp_dhcom_drc02 (where we're already LTO'ing),
> > > with the CI gcc-14.2.0 toolchain full U-Boot grows by more than 6KiB =
and
> > > SPL by a bit more than 2KiB. This is a bit of a worst-case, imx8mp_na=
vqp
> > > is a bit more than 3KiB / 548 bytes, with the average feeling like
> > > ~4KiB/1KiB for aarch64.
> >=20
> > I'm coming back to this to try and better understand things. And one
> > problem here is that upstream dtc changes really trip up LTO. I made as
> > a local hack, a change for imx8mp_dhcom_pdk2 to NOT use LTO (and so SPL
> > fails to link, but it's about the same growth, given the change in
> > overflows sram by numbers). This brought the size change down from ~6KiB
> > to ~4KiB.  Since this was already a hack just for investigation, I then
> > started out with giving full U-Boot the "assume perfect dtb" mask. This
> > reduces growth by 900 bytes.
> >=20
> > A better test case is pinephone because it's aarch64 but not LTO. And
> > with a full mask in U-Boot hack, the size growth for full U-Boot is
> > around 1000 bytes and 300 bytes in SPL.
> >=20
> > And so to me, there's a few questions. The first of which is, how is
> > what's being done so terrible for LTO. It's not good for normal
> > optimizations either, but it's really bad with LTO. The second of which
> > is, is there something being done with how the sanity checks are
> > performed that can be re-examined? Take fdt_get_string for example,
> > which grows by 120 bytes without changing the mask at all, and the code
> > changes are trivial switches to the new FDT_ASSUME mechanic and dropping
> > extra parens. That shouldn't have size growth, I would expect.
>=20
> Does this patch below make your size problem go away ?
>=20
> "
> diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
> index d7cf74722b2..7f8bb05c545 100644
> --- a/scripts/dtc/libfdt/libfdt.h
> +++ b/scripts/dtc/libfdt/libfdt.h
> @@ -140,12 +140,7 @@ static inline uint16_t fdt16_ld(const fdt16_t *p)
>=20
>  static inline uint32_t fdt32_ld(const fdt32_t *p)
>  {
> -	const uint8_t *bp =3D (const uint8_t *)p;
> -
> -	return ((uint32_t)bp[0] << 24)
> -		| ((uint32_t)bp[1] << 16)
> -		| ((uint32_t)bp[2] << 8)
> -		| bp[3];
> +	return fdt32_to_cpu(*p);
>  }
>=20
>  static inline void fdt32_st(void *property, uint32_t value)
> @@ -160,16 +155,7 @@ static inline void fdt32_st(void *property, uint32_t
> value)
>=20
>  static inline uint64_t fdt64_ld(const fdt64_t *p)
>  {
> -	const uint8_t *bp =3D (const uint8_t *)p;
> -
> -	return ((uint64_t)bp[0] << 56)
> -		| ((uint64_t)bp[1] << 48)
> -		| ((uint64_t)bp[2] << 40)
> -		| ((uint64_t)bp[3] << 32)
> -		| ((uint64_t)bp[4] << 24)
> -		| ((uint64_t)bp[5] << 16)
> -		| ((uint64_t)bp[6] << 8)
> -		| bp[7];
> +	return fdt64_to_cpu(*p);
>  }
>=20
>  static inline void fdt64_st(void *property, uint64_t value)
> "
>=20
> You can see the difference caused by these new unaligned-access functions=
 in
> the disassembly (objdump -lSD) of u-boot with (top) and without (bottom) =
the
> DTC 1.7.2 patch:

I bet it does, yes. I had forgotten that we explicitly revert that
change from upstream.

> "
> 00000000402984e0 <fdt_get_string>:
> fdt_get_string():
> /tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:35
> {
>     402984e0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
>     402984e4:   aa0003e3        mov     x3, x0
>     402984e8:   2a0103e4        mov     w4, w1
>     402984ec:   910003fd        mov     x29, sp
>     402984f0:   a90153f3        stp     x19, x20, [sp, #16]
>     402984f4:   aa0203f4        mov     x20, x2
> /tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:49
>         totalsize =3D fdt_ro_probe_(fdt);
>     402984f8:   97fffe4b        bl      40297e24 <fdt_ro_probe_>
> /tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:51
>         if (totalsize < 0)
>     402984fc:   37f80a40        tbnz    w0, #31, 40298644
> <fdt_get_string+0x164>
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv #1
> /tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:55
>         absoffset =3D stroffset + fdt_off_dt_strings(fdt);
>     40298500:   39403061        ldrb    w1, [x3, #12]
>     40298504:   39403462        ldrb    w2, [x3, #13]
>     40298508:   39403c73        ldrb    w19, [x3, #15]
>     4029850c:   aa022022        orr     x2, x1, x2, lsl #8
>     40298510:   39403861        ldrb    w1, [x3, #14]
>     40298514:   aa014041        orr     x1, x2, x1, lsl #16
>     40298518:   aa136033        orr     x19, x1, x19, lsl #24
>     4029851c:   5ac00a73        rev     w19, w19
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #1
> /tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:55 (discriminat=
or
> 1)
>     40298520:   0b130093        add     w19, w4, w19
> /tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:56
>         if (absoffset >=3D (unsigned)totalsize)
>     40298524:   6b13001f        cmp     w0, w19
>     40298528:   54000969        b.ls    40298654 <fdt_get_string+0x174>  =
//
> b.plast
> /tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:58
>         len =3D totalsize - absoffset;
>     4029852c:   39400062        ldrb    w2, [x3]
>     40298530:   4b130000        sub     w0, w0, w19
> /tmp/dtc-yes/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:60
>         if (fdt_magic(fdt) =3D=3D FDT_MAGIC) {
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv #2
>     40298534:   39400461        ldrb    w1, [x3, #1]
>     40298538:   aa012041        orr     x1, x2, x1, lsl #8
>     4029853c:   39400862        ldrb    w2, [x3, #2]
>     40298540:   aa024022        orr     x2, x1, x2, lsl #16
>     40298544:   39400c61        ldrb    w1, [x3, #3]
>     40298548:   aa016041        orr     x1, x2, x1, lsl #24
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #2
> "
>=20
> "
> 0000000040297804 <fdt_get_string>:
> fdt_get_string():
> /tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:35
> {
>     40297804:   a9bd7bfd        stp     x29, x30, [sp, #-48]!
>     40297808:   910003fd        mov     x29, sp
>     4029780c:   a90153f3        stp     x19, x20, [sp, #16]
>     40297810:   2a0103f4        mov     w20, w1
>     40297814:   a9025bf5        stp     x21, x22, [sp, #32]
>     40297818:   aa0003f6        mov     x22, x0
>     4029781c:   aa0203f5        mov     x21, x2
> /tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:49
>         totalsize =3D fdt_ro_probe_(fdt);
>     40297820:   97fff833        bl      402958ec <fdt_ro_probe_>
> /tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:51
>         if (totalsize < 0)
>     40297824:   37f806a0        tbnz    w0, #31, 402978f8
> <fdt_get_string+0xf4>
> /tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:55
>         absoffset =3D stroffset + fdt_off_dt_strings(fdt);
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv #1
>     40297828:   b9400ed3        ldr     w19, [x22, #12]
>     4029782c:   5ac00a73        rev     w19, w19
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #1
> /tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:55 (discriminator
> 6)
>     40297830:   0b130293        add     w19, w20, w19
> /tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:56
>         if (absoffset >=3D (unsigned)totalsize)
>     40297834:   6b13001f        cmp     w0, w19
>     40297838:   54000689        b.ls    40297908 <fdt_get_string+0x104>  =
//
> b.plast
> /tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:58
>         len =3D totalsize - absoffset;
>     4029783c:   b94002c1        ldr     w1, [x22]
> /tmp/dtc-no/lib/libfdt/../../scripts/dtc/libfdt/fdt_ro.c:60 (discriminator
> 6)
>         if (fdt_magic(fdt) =3D=3D FDT_MAGIC) {
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv #2
>     40297840:   5281ba02        mov     w2, #0xdd0 // #3536
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #2
> "
>=20
> But the question now is, how should we handle this ? These unaligned acce=
ss
> functions are there for a reason.

The historical and short version of why they are there is that a
platform was passing the kernel a misaligned device tree and the
assumption was that it was intentional and not a bug, and so dtc put a
bunch of effort in to working around that. After discussion (in 2019 or
so) the conclusion from dtc was that they still wanted to keep these
changes, despite it being a bug that a misaligned tree was passed. I did
not further press the issue further. So doing a revert, again, is what
we need to do.

--=20
Tom

--HZ2OJ2JgNAtn4Ptc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS8qjwAKCRAr4qD1Cr/k
CjtAAQD9FdOj7AA3RJa83G/GGkm+e6drKg0wPHq8Zr/0slOT+gD+MNAtQiommsU4
ooREfUqwSqz0kt9mjEFlT4setppaHw0=
=3Emv
-----END PGP SIGNATURE-----

--HZ2OJ2JgNAtn4Ptc--
