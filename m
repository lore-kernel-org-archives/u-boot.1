Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0684ACCD19F
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA0482C84;
	Mon, 20 Oct 2025 19:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mH/wLri1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C99FF831D6; Mon, 20 Oct 2025 19:17:14 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C25807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 19:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-43f935f7d14so1751203b6e.3
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760980631; x=1761585431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vpk0ZZAsHNKfZSdAd7Y/AMuo9As5kMXULH/fqp7MfQs=;
 b=mH/wLri1CKEzJRw0t+xdpTq6NtyHYAVgl2/fz50GtE4TfU410z7Ji2XTO98jEc/cIT
 U9XgmNB52LefE7nESuiQcfVRR89Ptzdq14xWP2Xdkn/3J/kY1iT74C8YbyzEDyXcuavD
 6gf/d2BcS8eZsERbQaYEshXJSIERLvniLxGIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760980631; x=1761585431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpk0ZZAsHNKfZSdAd7Y/AMuo9As5kMXULH/fqp7MfQs=;
 b=jTELlvN7laCNIeOHt88txyWNyXG4Lkqfrkcx7X73+/hI88qemDQFDMOXbpmmKHbeBD
 AmdQ6cNanANCrXb3/9dqwJ1QNxeQsGUggHL3zMGnG5DEhMLijIDgZYtu+kg6f4nBG1SH
 RePPMwa5GZxbRrRQIvxaF7dTmCTy7AIGm+tW1tg3/Cta2RIE2vzB/zBImG+tjeWolaSN
 pAI4ifTZR8rOiyNNQsDZW6GXOgOOqW7NhdB6DB0LC+FKYkqecwW+UYxv3Ikr7tD5IR7S
 B0SHNQriqLg5wc4B6lAGX2CXt8Bv7DqiPhwPrCUpJXP/OEMSdDbu/RVwSfX9LfOlDz2C
 p1wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZiHly6i74hJcBmO/Qb6r2bRVHqxx6UTYyIFDWxRu9fc7NzrDlSRyO2WVi9p3GU2NsuPrVzx0=@lists.denx.de
X-Gm-Message-State: AOJu0YwWMUVjiCCbeetX7xZET98SDasnA0S3iVVXeV6TS+uxXVCIE/uq
 EuaiUY30Cxrt/EO2IMsT3wwY0IYKQ6CrXA9+Sj2bzz6zGIyf4tXX79LQqWu9Ap3voR0=
X-Gm-Gg: ASbGncvehv/kzfYNVxTJ9CHpNzJXNwqQcLVspNTUHm9AnlimjSD3GwkZEe917OT1fZ6
 zom6+lLQuZkjZ+/9vu/OyTUAHJSgM99XxTN6tGupEu8+V0wLM0HB+KC3NpGSHhQNOdD/Ae1DZch
 cH7UeKJRoaoR5arNCOcS6TWkO3CYygR39Ou8SQg2RbP2+4PiwCzcl/guWBHV9b0TG9iRF3lfjly
 7I4KRRCbkPZ8dR4xsFsWljREH90lSfmqxHQRH+5UOZ3n3I8SZWkV8L7FeBv9KEhlBT5rG8o9LER
 jgJEglSaXbeIhCvlZZzF+lRUvMAMN6HWJLjMIaCyGb8C5zX3chGTKbdDV5526pmLlhHybkwqGLQ
 AVFO000+xm1/SMs6Nhra4hpSxtFl+H+9fq2xKP0osP3rVAbk7QCyuXKZfmf8FF9Zjx/c82oqKjC
 lInaN9ZrWG6uOT4+RNUoStyESiCsS0U/MPlufb8e+pk7X31EwifA==
X-Google-Smtp-Source: AGHT+IHlfN2mvdy/YVOUdmneB6/vurVf/fdZzqQBPkPQ+jchoFo9F/rW3m67MGwWJEL3TUvUU/FAoQ==
X-Received: by 2002:a05:6808:30a2:b0:438:3350:8d25 with SMTP id
 5614622812f47-443a2ff491dmr5714437b6e.40.1760980630724; 
 Mon, 20 Oct 2025 10:17:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dc4dafd6sm1998439b6e.5.2025.10.20.10.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 10:17:09 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:17:07 -0600
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
Message-ID: <20251020171707.GA6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
 <20251020115009.532a1a99@kmaincent-XPS-13-7390>
 <20251020141548.GS6688@bill-the-cat>
 <20251020143729.GW6688@bill-the-cat>
 <20251020171613.76ffddac@kmaincent-XPS-13-7390>
 <20251020160527.GY6688@bill-the-cat>
 <20251020190854.4b318829@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NkBwt/UWRa4Tmja/"
Content-Disposition: inline
In-Reply-To: <20251020190854.4b318829@kmaincent-XPS-13-7390>
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


--NkBwt/UWRa4Tmja/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 07:08:54PM +0200, Kory Maincent wrote:
> On Mon, 20 Oct 2025 10:05:27 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent wrote:
> > > On Mon, 20 Oct 2025 08:37:29 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >  =20
> > > > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote: =20
> > > > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent wrote:   =
=20
> > > > > > On Sun, 19 Oct 2025 10:48:37 -0600
> > > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > > >    =20
> > > > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote: =
  =20
> > > > > > > > Hi Kory,
> > > > > > > >=20
> > > > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> > > > > > > > <kory.maincent@bootlin.com> wrote:     =20
> > > > > > > > >
> > > > > > > > > This series converts the extension board framework to use
> > > > > > > > > UCLASS as requested by Simon Glass, then adds extension s=
upport
> > > > > > > > > to pxe_utils and bootmeth_efi (not tested) to enable exte=
nsion
> > > > > > > > > boards devicetree load in the standard boot process.
> > > > > > > > >
> > > > > > > > > I can't test the imx8 extension scan enabled by the
> > > > > > > > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > > > > > > > > I also can't test the efi bootmeth change as I don't have=
 such
> > > > > > > > > board.     =20
> > > > > > > >=20
> > > > > > > > You can test this with sandbox, using one of the bootmeth t=
ests,
> > > > > > > > perhaps. Let me know if you need help with this.     =20
> > > > > > >=20
> > > > > > > But the question is, does the real hardware platform work
> > > > > > > before/after this, not does the sandbox test still work
> > > > > > > before/after this.   =20
> > > > > >=20
> > > > > > It seems the bootlflow scan is not working on the sandbox on ne=
xt
> > > > > > branch. Is this issue known?   =20
> > > > >=20
> > > > > Is it fine on master? The next branch will be out of date until it
> > > > > re-opens with -rc2 being released (2 weeks from today).   =20
> > > >=20
> > > > ... out of sync local calendar, 3 weeks from today, not 2. =20
> > >=20
> > > bootstd test suit is not working on master with the sandbox_defconfig:
> > > https://termbin.com/un0p
> > >=20
> > > Noticeable things are;
> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D bootdev_find_by=
_any(seq,
> > > &dev, &mflags): Expected 0x0 (0), got 0xffffffed (-19) Test:
> > > bootdev_test_any: bootdev.c (flat tree) test/boot/bootdev.c:160,
> > > bootdev_test_any(): 0 =3D=3D bootdev_find_by_any(seq, &dev, &mflags):=
 Expected
> > > 0x0 (0), got 0xffffffed (-19) Test 'bootdev_test_any' failed 2 times
> > >=20
> > > And a nice segfault:
> > > Test: bootflow_set_arg: bootflow.c
> > > Test: bootflow_system: bootflow.c
> > > [3]    569337 segmentation fault (core dumped)  ./u-boot
> > >=20
> > > Maybe things are missing to run sandbox_defconfig on my computer?
> > > With the sandbox64_defconfig there is not core dump anymore but there=
 is
> > > still the failed line:
> > > Test 'bootdev_test_bootable' failed 2 times
> > >=20
> > > And the uboot is reboot infinitely during the bootflow test:
> > > ./u-boot -T -c "ut bootstd"
> > > https://termbin.com/alu5 =20
> >=20
> > I see the same thing you do when running them outside of pytest, but
> > they're also fine within pytest.
> > https://docs.u-boot.org/en/latest/develop/pytest/usage.html should help
> > get you started, and you can just run all of the ut tests under that.
>=20
> Weird I got errors also within pytest.
> See the html test log attached generated by the following command:
> ./test/py/test.py --bd sandbox -k bootstd

Same. There's some implicit dependencies around I believe. Doing "-k ut"
should work, as I tried that (via my wrapper around all this) as well as
just running all the tests (which is longer).

--=20
Tom

--NkBwt/UWRa4Tmja/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZukgAKCRAr4qD1Cr/k
CgxSAP49MrcO16554XTsllqeaYWUFKMacOVyO3KtKVXX4TkAYwEAx/RkVCLFesFd
qB+IRHkJJtcUEecjiAk3Tk1Yti9h+Ak=
=jeDJ
-----END PGP SIGNATURE-----

--NkBwt/UWRa4Tmja/--
