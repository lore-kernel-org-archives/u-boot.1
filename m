Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED59FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37349864C3;
	Mon,  6 Nov 2023 21:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HMlwrbCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129FF86FB4; Mon,  6 Nov 2023 21:46:19 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 332FC863C8
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b3ec45d6e9so3009151b6e.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699303571; x=1699908371; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Nxzi1v7MuipQ1c6PMUhBUlxSDKXBs3kDuJgFvohAHY=;
 b=HMlwrbCiismqqoRIqqIVCm9hMgV/KYPd87IO3YWx6YnGLUTHyuw32fdk3lKf7ziyPA
 DLVQQXTMrwq7OjW80Vwk0ontRL1TnWPHg/Oh4dmOR29wE568/e1Rq0IXWPRy8bGQAzt7
 ye6sy6WODdMXg0JdymNJAJWQdg+B8OtUMCYec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699303571; x=1699908371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Nxzi1v7MuipQ1c6PMUhBUlxSDKXBs3kDuJgFvohAHY=;
 b=DVtgjcTFHA65o6ngdmpCr/Kri3gXp3t6IswGPN7JOqxmjoXmQqWmEydFOaeRBJzd43
 KDZDPIS5Bj5zRWEfeLSo1XnzrwW6zFHAT8vVjksbAQ7FKXmNp7sKb+DnK2O2lorHsg0x
 uUnGMWbGRBfexIRxctfP1u9TRpXhGDhzJhZNJ1otFscQK78DRCQSC0M22cbIYsKAnixF
 wpLrFyLHz1kDVZu+pBZWuixmsT1WhQf53YvoSJqB6f0V0ya8E3y2pVvwPPg4ZR6dV8JE
 3Cm7Ww3DJK1c7q/7EZ66JfsdtOOof4FAAH1967Hlv2zv23je9Y2iv3sxuSdAU/W8+nRB
 T8rw==
X-Gm-Message-State: AOJu0Yx516sgA8Sa+wBagsLkDMn1q7C3W9PU2tUPjHL2Deu23BfHz8Ml
 Z4dljWCqGlwo7RuClCv3cUVx1A==
X-Google-Smtp-Source: AGHT+IHlymEVkSsI8p/8xYG4kSNNNjVnxnIQd85ur7W4qYxM/p4Y18vi9FxL/A96F2cO30bt23Aj2w==
X-Received: by 2002:a05:6808:19a5:b0:3a8:f3e7:d691 with SMTP id
 bj37-20020a05680819a500b003a8f3e7d691mr39122942oib.37.1699303571707; 
 Mon, 06 Nov 2023 12:46:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 u5-20020a0cea45000000b00670bd5a3720sm3764312qvp.97.2023.11.06.12.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:46:11 -0800 (PST)
Date: Mon, 6 Nov 2023 15:46:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
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
Message-ID: <20231106204608.GJ496310@bill-the-cat>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BYj++zQpFk7GhKE8"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
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


--BYj++zQpFk7GhKE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 01:38:39PM -0700, Simon Glass wrote:
> Hi Andre,
>=20
> On Mon, 6 Nov 2023 at 10:26, Andre Przywara <andre.przywara@arm.com> wrot=
e:
> >
> > On Sat, 4 Nov 2023 19:45:06 +0000
> > Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@arm.com> =
wrote:
> > > >
> > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > > Hi Heinrich,
> > > > >
> > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > >
> > > > > > On 11/1/23 19:05, Andre Przywara wrote:
> > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced the see=
d CSR. It
> > > > > > >> provides an interface to a physical entropy source.
> > > > > > >>
> > > > > > >> A RNG driver based on the seed CSR is provided. It depends on
> > > > > > >> mseccfg.sseed being set in the SBI firmware.
> > > > > > >
> > > > > > > As you might have seen, I added a similar driver for the resp=
ective Arm
> > > > > > > functionality:
> > > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre=
=2Eprzywara@arm.com/
> > > > > > >
> > > > > > > And I see that you seem to use the same mechanism to probe an=
d init the
> > > > > > > driver: U_BOOT_DRVINFO and fail in probe() if the feature is =
not
> > > > > > > implemented.
> > > > > > > One downside of this approach is that the driver is always lo=
aded (and
> > > > > > > visible in the DM tree), even with the feature not being avai=
lable.
> > > > > > > That doesn't seem too much of a problem on the first glance, =
but it
> > > > > > > occupies a device number, and any subsequent other DM_RNG dev=
ices
> > > > > > > (like virtio-rng) typically get higher device numbers. So wit=
hout
> > > > > > > the feature, but with virtio-rng, I get:
> > > > > > > VExpress64# rng 0
> > > > > > > No RNG device
> > > > >
> > > > > Why do we get this? If the device is not there, the bind() functi=
on
> > > > > can return -ENODEV
> > > > >
> > > > > I see this in U-Boot:
> > > > >
> > > > > U_BOOT_DRVINFO(cpu_arm_rndr) =3D {
> > > > >
> > > > > We should not use this.
> > > >
> > > > Agreed.
> > > >
> > > > > Use the devicetree.
> > > >
> > > > No, this is definitely not something for the DT, at least not on AR=
M.
> > > > It's perfectly discoverable via the architected CPU ID registers.
> > > > Similar to PCI and USB devices, which we don't probe via the DT as =
well.
> > > >
> > > > It's arguably not proper "driver" material per se, as I've argued b=
efore, but
> > > > it's the simplest solution and fits in nicely otherwise.
> > > >
> > > > I was wondering if it might be something for UCLASS_CPU, something =
like
> > > > a "CPU feature bus": to let devices register on one on the many CPU
> > > > features (instead of compatible strings), then only bind() those
> > > > drivers it the respective bit is set.
> > > >
> > > > Does that make sense? Would that be doable without boiling the ocea=
n?
> > > > As I don't know if we see many users apart from this.
> > >
> > > I have seen this so many times, where people want to avoid putting
> > > things in the DT and then are surprised that everything is difficult,
> > > broken and confusing. Why not just follow the rules? It is not just
> > > about whether we can avoid it, etc. It is about how devices fit
> > > together cohesively in the system, and how U-Boot operates.
> >
> > A devicetree is only for peripherals *that cannot be located by probing=
*.
>=20
> I have to stop you there. It absolutely is not limited to that.

It is limited to that if we're going to keep using the device trees that
Linux uses. Full stop. There's not really wiggle room there either.

--=20
Tom

--BYj++zQpFk7GhKE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJUIoACgkQFHw5/5Y0
tyyBggv/QFhUg3IVbdllOZduIjkhq7jA2TtliU3ZcddiW6CJQXDk2pCkdY/ZZEb3
i1XYFplhTILUc0DTK3TMvedAsiakrfBPeDgOPCBQ3MKas5Taznuif3fx0doyPeF+
MUEyO0Au2AOaHrk2Wkz8x/gKoegjWjfRDim6tX5YaiNiBJpWk6SVJm9VAhRcsbtC
TYILGWzU1tEQvUK78FRocf1deK57fKhjLpyyNujjVDlC5JNLr9amMnMlNHo4/boz
s2kVmHszC0lpx/F2ZHRaocz4xgrXgQu4FU4PzOy+aVMb3orw63mrEGHV7zgpn8yk
6WC79ogPs6A9VU6kaqUZxRwOFidE7i6pSWIlm6FjxQyK9IaM8ofwgXTINP4KmRzd
OgTw+rpfvj64GWKQXq8wRdvPc2ReddoQL2qlD/c8tK9CxlQZfjbp0UnGdKklpgwz
U8Y+VmW+Yxs8Vwdj9rghTUkbqzLBmfUKN4kQZrMBIjeI86T39ioApnU2F9MvREu6
ukfviYCt
=tMha
-----END PGP SIGNATURE-----

--BYj++zQpFk7GhKE8--
