Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB75C4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49ECB86FFD;
	Mon,  6 Nov 2023 17:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zcc7wN50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA71D86FFD; Mon,  6 Nov 2023 17:46:33 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2901A86335
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77896da2118so299239885a.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699289190; x=1699893990; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g17bMKk8hyhOT0sOtSf0ApQHsvJYVrTdVF61t97W4tw=;
 b=Zcc7wN50HS7pXDMId/BMGC76B4PcqJu0Kh5ADOpDP72OYUnfrCkeiD1tECTA5dzwzW
 N6QpT2/fNezI2ngsUTirdMfOeAq5YzAUq8K6+8gj4yembpUOBKCn5WW2dj6E85B9GBMl
 FE4+EVIBLQNSN+zob5vQDMBReQGDPpsHNGcLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289190; x=1699893990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g17bMKk8hyhOT0sOtSf0ApQHsvJYVrTdVF61t97W4tw=;
 b=aDhjbWL5f0cWmqqSfSvdpXqMHeT0PBRQePVLQAtUz1B2FkCkFt4cR3ge9PRqQNbCcX
 0i9DQBMqVWNZMjn//IK4Vs+51Xa1jPEMKgSHoIbf+gZx8+CH2n5nEE+WsLYrQN9FE7vi
 321sjx59UOggqqCVar419cti/mSqdWiPh7b9TdsT3JS4lGvk1W3Qhm69wtDLI3c3eBlZ
 JHT7MOIA1H7OOcIBGjChsEIiXd5+qhpKDlq6skmUiv/zHP5QATYtrqJzDTmka/RUCbNS
 OPqGmpqs5EN2cykQMI9yAefHXaoBsMenO2fGWqu978UFCG1FmaHchtouwxBJfNAwCvVX
 rWpw==
X-Gm-Message-State: AOJu0Yzmjb0e5FpJuGgZ0p/mSjrGX6Fg6uvfMPl+q4ONOalUCiAaGuno
 sM6jKAh3mWAH4ICd6gz+PLzYag==
X-Google-Smtp-Source: AGHT+IEMA0ddam6vGqxFWYrPPY/4VRIGZ6SJyGBOpHGd/0L5CevnE5zshJkRZ0d7sY5930x0Wpeynw==
X-Received: by 2002:a05:6214:411c:b0:66d:373f:32d4 with SMTP id
 kc28-20020a056214411c00b0066d373f32d4mr31754260qvb.16.1699289189706; 
 Mon, 06 Nov 2023 08:46:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 a13-20020a0ce90d000000b00670a31f77b4sm3578877qvo.93.2023.11.06.08.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:46:29 -0800 (PST)
Date: Mon, 6 Nov 2023 11:46:27 -0500
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
Message-ID: <20231106164627.GA496310@bill-the-cat>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p/RvDdwv0Ol1MCSl"
Content-Disposition: inline
In-Reply-To: <20231104171212.3d041a4f@slackpad.lan>
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


--p/RvDdwv0Ol1MCSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 05:12:12PM +0000, Andre Przywara wrote:
> On Fri, 3 Nov 2023 13:38:58 -0600
> Simon Glass <sjg@chromium.org> wrote:
>=20
> Hi Simon,
>=20
> > Hi Heinrich,
> >=20
> > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > On 11/1/23 19:05, Andre Przywara wrote: =20
> > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > >
> > > > Hi Heinrich,
> > > > =20
> > > >> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR.=
 It
> > > >> provides an interface to a physical entropy source.
> > > >>
> > > >> A RNG driver based on the seed CSR is provided. It depends on
> > > >> mseccfg.sseed being set in the SBI firmware. =20
> > > >
> > > > As you might have seen, I added a similar driver for the respective=
 Arm
> > > > functionality:
> > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przyw=
ara@arm.com/
> > > >
> > > > And I see that you seem to use the same mechanism to probe and init=
 the
> > > > driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> > > > implemented.
> > > > One downside of this approach is that the driver is always loaded (=
and
> > > > visible in the DM tree), even with the feature not being available.
> > > > That doesn't seem too much of a problem on the first glance, but it
> > > > occupies a device number, and any subsequent other DM_RNG devices
> > > > (like virtio-rng) typically get higher device numbers. So without
> > > > the feature, but with virtio-rng, I get:
> > > > VExpress64# rng 0
> > > > No RNG device =20
> >=20
> > Why do we get this? If the device is not there, the bind() function
> > can return -ENODEV
> >=20
> > I see this in U-Boot:
> >=20
> > U_BOOT_DRVINFO(cpu_arm_rndr) =3D {
> >=20
> > We should not use this.
>=20
> Agreed.
>=20
> > Use the devicetree.
>=20
> No, this is definitely not something for the DT, at least not on ARM.
> It's perfectly discoverable via the architected CPU ID registers.
> Similar to PCI and USB devices, which we don't probe via the DT as well.
>=20
> It's arguably not proper "driver" material per se, as I've argued before,=
 but
> it's the simplest solution and fits in nicely otherwise.
>=20
> I was wondering if it might be something for UCLASS_CPU, something like
> a "CPU feature bus": to let devices register on one on the many CPU
> features (instead of compatible strings), then only bind() those
> drivers it the respective bit is set.
>=20
> Does that make sense? Would that be doable without boiling the ocean?
> As I don't know if we see many users apart from this.

I think we have a similar problem with how we're doing with DM_TIMER and
armv7-a/armv7-m/armv8[1]. We shouldn't need the drivers in drivers/timer/
to cover platforms where SYS_ARCH_TIMER is (or should be!) enabled. But
in turn, the code under arch/arm/cpu/*/*timer.c doesn't implement the
uclass side of things, only the regular API. This is because there's
nothing to probe even because we don't support the kind of multi-arch
binary where it'd be possible to not have the feature.

--=20
Tom

[1]: We do have the problem of armv7-r not having this feature so things
like say TI K3 platforms need the platform driver on the Cortex-R host.
A similar issue is the pre-ARMv7 i.MX platforms.

--p/RvDdwv0Ol1MCSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJGFgACgkQFHw5/5Y0
tyyKXQwAtdUBIY6lZ4yzlX6cPQIGnMwYMjOw9oREwdBkVQM8nsIOMYAHw4S8WGjA
0ejY7ka1T7x4wcJ6W+X4Klfjylf8T5JlFNb9xrNYNTkXyL0DnIU3PuL50whrTINZ
Vex/f7p8U2v9T+IfH86WrHSYoAOhCwvJQ3TFehZkZpRwPuE0pXFwOBhkVgtmxoWa
M5UUlmTxAIDI+8n2jBK14sd3koCZWsFpzA36PyM25OyFis+svWsE4/CNKhcPM4ZE
fOCECI7g6uS2ZC8vKxZJDfr436yYVzxzGBxwR+9V+hPSFVeIDcpxrC4LMweP2x4o
Zjrv1WRYBtpVQQSMi743xBKRhA2Dbid3xZ7pOSlXeckdmriXOX4j2IXshpi1+8Iw
7+zOqJ8FVJnWUvmJmGZ1ElbOkAEywwUTFAVrD+ZqTGGhX9xlGXP5Tx5MPDAy8Id5
v3wmM8tJeRKNyV+NVZqKVgjY+IfyVsMhC0HrDbEZ9nD7RR/zYkwvjlSdym3ikAlb
m95+/whM
=ZtuO
-----END PGP SIGNATURE-----

--p/RvDdwv0Ol1MCSl--
