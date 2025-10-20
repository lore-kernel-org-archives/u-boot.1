Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8E2CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 16:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0458334F;
	Mon, 20 Oct 2025 18:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l6LWSbJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91B6383631; Mon, 20 Oct 2025 18:05:36 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5304B82E34
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-43f9cc65f66so2594802b6e.2
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760976332; x=1761581132; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5cTzywJV36GPWdEBoUH4GIY6WsmyVsGyojtJTHEBvgQ=;
 b=l6LWSbJVDcbcIVD2HLliBkt57+lvR4hpGL4CUy5rqqfXoIw4+3puapLyJFsaG+xnaY
 W8oa+K2N8vKI+7VFWuZntAxJCN1/nxqYPneSop3vbWSJSjYgpwlc+APf4ziOmPUjUk5M
 R1eiszB5LueN5/aFj6yDJfow2yrUevZ/RaL5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760976332; x=1761581132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cTzywJV36GPWdEBoUH4GIY6WsmyVsGyojtJTHEBvgQ=;
 b=khPdQW6tjDwGW59vLuJZPwEPjWhm1kAVOC77yIY0PMcJ/rmSRg/mmyN20kLbke4ss7
 75/xqABue3Nr6jh2h4MjkDyCrcHRBdSrBxUpCYlWVU4t/kwPOGB73raz/zRoB24QcdCR
 tdI+VvTkyrPGKb0NMJl0urIParpuoyKeh8t7WWoQLCF4Jlfx9HbzC3ANTszv2paS8xO5
 oFzF1x0TVHKZeL3gZ4u9rZrBLkjSkdvYydbOeR5SaeOukYQmE+lHPznEdJR58C8pgC6i
 /T4tvCp2RubitqGSlu/aEbsuHzz2EPbmCyAoz4hIBXnkH/xM2uUoubUjby/63ggqoZ95
 CW2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD1ile7cU4EMRIgIowEjajsromCxhcepnhMP6CT15DDVWoqgXlDAJS5SMoUYvBkKCLc05zrVc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1aG6TnshBfvpruxRgtYK1NlmXjq5KwQjjHPogCSkt2Eaqy8gZ
 8SP/x1HuBuk/DUbUMRHgQ3ow3Le+CRqb7KfJfg9AH2cMGVDKh79AMsgV26D/8FBaP5w=
X-Gm-Gg: ASbGncvZ2lqjBHcZV78Dx+CZD2HEKKUu0SNSZMDCgTGWi6Wb3NnUQwDEQXUywzsg0DT
 cDb+XPddmTXpIaBGMPIU2y26v48TGsqn0EFi2yZBbA0mhdFmfjDajpM/N1+nhvRXwrROJc1ZFf+
 19RUb91ikrzxulG4SPrHgJGSafjtT+Jm05bAuyhkt5qTXW1P1r6CuVslM/rYTG7rWhgM6xsswOy
 EIp99qlmkD6t7U7haR6L23HpiJk4wfxXc0YeBGrkY0mTcFq1PrAaq3zicH4gOCps3RTQleG9AKf
 aW7MbBCR/penxS0yFzzSB/43V+uCb8PaJHeyE3UG85KSn7dpadg/UJZb6VyCqTL5ymTgzJ8qJ9i
 M+nvw0NlE+UlrEozsFQfALMcVmNyn724RWF0eFqEEoVf6ATrDfmGRdPR6ZdTwZB3UYAtICEenxz
 ph/3rbZh60WctQF8xJ+szFScCrtuybxwmHJVJ7GrmzoLj5RK8LHw==
X-Google-Smtp-Source: AGHT+IGos3NS66adg6s+P81YNKuTksxPOts6Ar4lelyYBVotMOfkoYBVx1L9wlJKnUOd88TQFKrRyA==
X-Received: by 2002:a05:6808:6c88:b0:439:b9b4:2d77 with SMTP id
 5614622812f47-443a30e144amr5647597b6e.34.1760976331982; 
 Mon, 20 Oct 2025 09:05:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2888ef0besm2691021a34.20.2025.10.20.09.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 09:05:31 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:05:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251020160527.GY6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
 <20251020115009.532a1a99@kmaincent-XPS-13-7390>
 <20251020141548.GS6688@bill-the-cat>
 <20251020143729.GW6688@bill-the-cat>
 <20251020171613.76ffddac@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3Mn9IsQCUhsRcDfH"
Content-Disposition: inline
In-Reply-To: <20251020171613.76ffddac@kmaincent-XPS-13-7390>
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


--3Mn9IsQCUhsRcDfH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent wrote:
> On Mon, 20 Oct 2025 08:37:29 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote:
> > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent wrote: =20
> > > > On Sun, 19 Oct 2025 10:48:37 -0600
> > > > Tom Rini <trini@konsulko.com> wrote:
> > > >  =20
> > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote: =20
> > > > > > Hi Kory,
> > > > > >=20
> > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> > > > > > <kory.maincent@bootlin.com> wrote:   =20
> > > > > > >
> > > > > > > This series converts the extension board framework to use UCL=
ASS as
> > > > > > > requested by Simon Glass, then adds extension support to pxe_=
utils
> > > > > > > and bootmeth_efi (not tested) to enable extension boards devi=
cetree
> > > > > > > load in the standard boot process.
> > > > > > >
> > > > > > > I can't test the imx8 extension scan enabled by the
> > > > > > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > > > > > > I also can't test the efi bootmeth change as I don't have such
> > > > > > > board.   =20
> > > > > >=20
> > > > > > You can test this with sandbox, using one of the bootmeth tests,
> > > > > > perhaps. Let me know if you need help with this.   =20
> > > > >=20
> > > > > But the question is, does the real hardware platform work before/=
after
> > > > > this, not does the sandbox test still work before/after this. =20
> > > >=20
> > > > It seems the bootlflow scan is not working on the sandbox on next b=
ranch.
> > > > Is this issue known? =20
> > >=20
> > > Is it fine on master? The next branch will be out of date until it
> > > re-opens with -rc2 being released (2 weeks from today). =20
> >=20
> > ... out of sync local calendar, 3 weeks from today, not 2.
>=20
> bootstd test suit is not working on master with the sandbox_defconfig:
> https://termbin.com/un0p
>=20
> Noticeable things are;
> test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D bootdev_find_by_any=
(seq, &dev, &mflags): Expected 0x0 (0), got 0xffffffed (-19)
> Test: bootdev_test_any: bootdev.c (flat tree)
> test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D bootdev_find_by_any=
(seq, &dev, &mflags): Expected 0x0 (0), got 0xffffffed (-19)
> Test 'bootdev_test_any' failed 2 times
>=20
> And a nice segfault:
> Test: bootflow_set_arg: bootflow.c
> Test: bootflow_system: bootflow.c
> [3]    569337 segmentation fault (core dumped)  ./u-boot
>=20
> Maybe things are missing to run sandbox_defconfig on my computer?
> With the sandbox64_defconfig there is not core dump anymore but there is =
still
> the failed line:
> Test 'bootdev_test_bootable' failed 2 times
>=20
> And the uboot is reboot infinitely during the bootflow test:
> ./u-boot -T -c "ut bootstd"
> https://termbin.com/alu5

I see the same thing you do when running them outside of pytest, but
they're also fine within pytest.
https://docs.u-boot.org/en/latest/develop/pytest/usage.html should help
get you started, and you can just run all of the ut tests under that.

--=20
Tom

--3Mn9IsQCUhsRcDfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZdxAAKCRAr4qD1Cr/k
CmGfAPsFnqex9aqVk2/n5+dfzET+35Ius7UtfuRxWCvmS/pIkAD/Z5sRZ3OiIqY6
am/mcTOazG7/U2YBE1DmMPVsMyHQ4QE=
=/8Yd
-----END PGP SIGNATURE-----

--3Mn9IsQCUhsRcDfH--
