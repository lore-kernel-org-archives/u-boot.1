Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77182C4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5891E8695F;
	Mon,  6 Nov 2023 21:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nf4k0dqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3838695F; Mon,  6 Nov 2023 21:13:13 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF62780F06
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7788f513872so318354585a.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699301587; x=1699906387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dZJehB0xUWOCAprAhhIELvxTwc6vILQeiuBXyzTmOZM=;
 b=Nf4k0dqTwWPYtGwhiPC5gkQ0TSKyA7EjVF9GFiDsWW++5zopOQVCsWrrOcWOEe0C7Y
 4AWf1x0fT7F/FdpmLVKvjtcF+Wz0mfSTSlpl6NG7qRmnLXhCI0T845fsQn7+4Dy4cLpa
 ZVQ75A3l3pXxuFk7tuX93j2i0YUsKodRLOxxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699301587; x=1699906387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZJehB0xUWOCAprAhhIELvxTwc6vILQeiuBXyzTmOZM=;
 b=moLhUD5Rmxe5MRdzTvfLqMR3B2wSn8Ef9M/nDSO9G1WEYQLAWrNgJTq+zbMtq04cK+
 rLEgTEthamF0egZfAwgxGToSGDtbd3jzoIKfIB0M9ngQK/vA3QZAdT1f44hI0TDT6ufI
 xwHdOGuVy3JnhdUWI39qxnCfx2sCxbQy7vE78UJi7fUPNr4kerwbhtRz3HR1KpdA+d0m
 DxiWYpV4RLGOakQu98xnIu209z+MWW0pxvKCqR9YziN1M5QJOtp2wdBtO4JFCVEyGF8T
 lZf5Sqyl63q6XsQH7OhrxcaFNRmaCxyqJOUbpIGSaT8JC/t2jGXDDiMZcdrpBjrjpEYR
 1Hiw==
X-Gm-Message-State: AOJu0YwN/kfT9S2K+dSPJ6K2twINqDSq+SS7dyaeVKTCKrQmVcVD5I/c
 uXfNNBx0fPTj8ZscMs2LtHryzQ==
X-Google-Smtp-Source: AGHT+IE1VmMwrxzrurUUYytzDZx8K9DEvXtRm2s+N7m2KD8k3ZFQKkb1NXaIzSyWgm+4qYOuitub3g==
X-Received: by 2002:a05:620a:4094:b0:77a:739b:322e with SMTP id
 f20-20020a05620a409400b0077a739b322emr10384030qko.57.1699301587556; 
 Mon, 06 Nov 2023 12:13:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 k21-20020a05620a0b9500b007788d2f3d4asm3603095qkh.39.2023.11.06.12.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:13:06 -0800 (PST)
Date: Mon, 6 Nov 2023 15:13:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231106201304.GE496310@bill-the-cat>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s3aBxOkecmlDGip0"
Content-Disposition: inline
In-Reply-To: <20231106172601.12c36750@donnerap.manchester.arm.com>
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


--s3aBxOkecmlDGip0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 05:26:01PM +0000, Andre Przywara wrote:
> On Sat, 4 Nov 2023 19:45:06 +0000
> Simon Glass <sjg@chromium.org> wrote:
>=20
> Hi,
>=20
> > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@arm.com> wr=
ote:
> > >
> > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Simon,
> > > =20
> > > > Hi Heinrich,
> > > >
> > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com> wrote: =20
> > > > >
> > > > > On 11/1/23 19:05, Andre Przywara wrote: =20
> > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > > >
> > > > > > Hi Heinrich,
> > > > > > =20
> > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced the seed =
CSR. It
> > > > > >> provides an interface to a physical entropy source.
> > > > > >>
> > > > > >> A RNG driver based on the seed CSR is provided. It depends on
> > > > > >> mseccfg.sseed being set in the SBI firmware. =20
> > > > > >
> > > > > > As you might have seen, I added a similar driver for the respec=
tive Arm
> > > > > > functionality:
> > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.p=
rzywara@arm.com/
> > > > > >
> > > > > > And I see that you seem to use the same mechanism to probe and =
init the
> > > > > > driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> > > > > > implemented.
> > > > > > One downside of this approach is that the driver is always load=
ed (and
> > > > > > visible in the DM tree), even with the feature not being availa=
ble.
> > > > > > That doesn't seem too much of a problem on the first glance, bu=
t it
> > > > > > occupies a device number, and any subsequent other DM_RNG devic=
es
> > > > > > (like virtio-rng) typically get higher device numbers. So witho=
ut
> > > > > > the feature, but with virtio-rng, I get:
> > > > > > VExpress64# rng 0
> > > > > > No RNG device =20
> > > >
> > > > Why do we get this? If the device is not there, the bind() function
> > > > can return -ENODEV
> > > >
> > > > I see this in U-Boot:
> > > >
> > > > U_BOOT_DRVINFO(cpu_arm_rndr) =3D {
> > > >
> > > > We should not use this. =20
> > >
> > > Agreed.
> > > =20
> > > > Use the devicetree. =20
> > >
> > > No, this is definitely not something for the DT, at least not on ARM.
> > > It's perfectly discoverable via the architected CPU ID registers.
> > > Similar to PCI and USB devices, which we don't probe via the DT as we=
ll.
> > >
> > > It's arguably not proper "driver" material per se, as I've argued bef=
ore, but
> > > it's the simplest solution and fits in nicely otherwise.
> > >
> > > I was wondering if it might be something for UCLASS_CPU, something li=
ke
> > > a "CPU feature bus": to let devices register on one on the many CPU
> > > features (instead of compatible strings), then only bind() those
> > > drivers it the respective bit is set.
> > >
> > > Does that make sense? Would that be doable without boiling the ocean?
> > > As I don't know if we see many users apart from this. =20
> >=20
> > I have seen this so many times, where people want to avoid putting
> > things in the DT and then are surprised that everything is difficult,
> > broken and confusing. Why not just follow the rules? It is not just
> > about whether we can avoid it, etc. It is about how devices fit
> > together cohesively in the system, and how U-Boot operates.
>=20
> A devicetree is only for peripherals *that cannot be located by probing*.
> Which are traditionally most peripherals in non-server Arm SoCs. While I
> do love the DT, the best DT node is the one you don't need.

In general, yes, this. And we keep banging against this too. If we can
figure it out at run time, without needing device tree, we should be
doing that, not adding a device tree node/property.

A device tree check is not our only run-time "does this exist" check.

> But as Heinrich also said: those instructions are not peripherals, they
> are part of an instruction set extensions, the same story as with x86's
> RDRAND instruction. We don't have those in ACPI or so as well, because
> CPUID has you covered. The same on ARM, ID_AA64ISAR0_EL1 is readable on
> every chip (outside of EL0), and tells you whether you have the RNDR
> register or not. IIUC RISC-V is slightly different here, since not all ISA
> extensions are covered by CSRs, hence some of them indeed listed in the D=
T.
>=20
> So a proper solution(TM) would be to split this up in architectural
> *instructions* and proper TRNG *devices*, maybe wrapping this up in some
> function that tests both. This is roughly what the kernel does, somewhat
> abstracted by the concept of "entropy sources", which could be TRNG
> devices, CPU instructions, interrupt jitter or even "instruction execution
> jitter"[1], with the latter two definitely not being devices really at al=
l.
>=20
> But I don't know if U-Boot wants to go through the hassle of this whole
> framework, as we tend to implement things much easier. But a simple
> get_cpu_random() function, implemented per architecture, and with some
> kind of success flag, should be easy enough to do. Then either the users
> (UEFI?) explicitly call this before trying UCLASS_RNG, or we wrap this for
> every RNG user.

In specifics, yes, some sort of split like this sounds good and we may
or may not also want to have some option for talking with op-tee in
the case where that, rather than instructions are how we do it. And a
similar approach for timers with a possible need for something slightly
more complex for bootstage usage?

--=20
Tom

--s3aBxOkecmlDGip0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJSM0ACgkQFHw5/5Y0
tywZeQv9Ff/jLqik+mXiojGU0qz6ovp4GjHAEUfkWuGhU5a5vV8NFGa2nJz77LHr
CIntnjYy5DLYCW4++tlmY4dpdyUR1CnUJA8LWYtlXLWQvq1KWecfTGaW6fbV6GL/
6xmykjkMr9avJiiyAwuFJ/lXUMkfIillG+QMsCV9g+acuiL7i8ApNZxZOqF2j7EJ
0cc9t3/axXovJzyAZ71NsS0D2+DsER9tQG6bzucP1DmO2/LUnk/wtwnJN3vQKNig
cZZlTq+Zl+/qB+mbnZXBft7tNdlOc+IganaaLKZdN+CtMfPqghL2fN7CojqziQ3h
k+IUkChVoy0zZUdjTU/Vb9UXaZHlkoPEZQkdW7tTquJtDPrXnQrVOEWHHGrhIx0+
HMLf374XjgHVYKEP8iprGDvNLFnoPqO7zpgPkAIAONDuOwQ1sM7ZUUjnWdokqCZx
fTipK4TwGC8S2aBYTGfZOiwjXyKKm+Ag3PKpgZWRlahQ0eGnRAMZPujKAwtAnKm/
6zy+Nwq+
=j2r9
-----END PGP SIGNATURE-----

--s3aBxOkecmlDGip0--
