Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37354CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 09:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3585807C0;
	Tue, 21 Oct 2025 11:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K9zamill";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC997831D6; Tue, 21 Oct 2025 11:52:21 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 381A3807B1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso9194852a12.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761040339; x=1761645139; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=33DDEm9EiOG4/z3wGtLd+RiptaMgjbDVgYr1WJAYsrU=;
 b=K9zamill/1rd5hsvOto+AQXYcJnFVtm2MWmU7UqqSUgKInRsCgMuIvao7DHGhADxcX
 IAbauaJrRW0v6yyJLf9fD02A5QePiLKrAUdvdo1G0FMORtcGzoOAPfqQlasC9uHSuSlm
 lcAQ+df6anWQ8m/mMOJeD9KIOuan2N4OQ9IqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040339; x=1761645139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=33DDEm9EiOG4/z3wGtLd+RiptaMgjbDVgYr1WJAYsrU=;
 b=YlIplvlLx+VsLx+0r5yuzhqfDF4GutMXG0m8qSTfyzm+lpN1zjWbwUwyrb2xVioE3e
 Ymi69B6zAA5JGPqjyA2iK/kGn+DJ4u/o2Pu9DOUsxg4XPvdnSHiD7Q9p3HisRMjrzqY2
 pMuqndw/Av9WoTwJKsbmZGMIF86W6cjZFko6MK5hi/etnqOjPWTGBv9GEiHmLHVeWlRX
 IPgUgJzZQO6YefxMi4AtNL88Cm5mQhHnr/escqWt5ucZ2Pxytz7UEKNPSUdIHYVONvad
 ufa2KBz8TkEB9iPhkl/gUpVayZMvmrw2+rIeSVG/91nzvDleDIJy9UqP0dF9r0yMr/rG
 s/Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTaamspw3Frl3AY+VQWKslYNIoJmfaOP9xnUMOS8zQEularnzYvIBVlGaITWgjckeJ3aWxSM8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5zceP3/BuR+B2pEa96mV2QVp4JnlcaszHb+O7WFNI+xD1O4b0
 J7JI5Xj0Q44fBfemRWl1DVSNBiIKXUTAE8wrQV4i0tgWP3b5ZRKYzjLorXwfRIOOFFmenWuDFAf
 NWbAqRYGASXtlpZMQM/Z8U28INgXJ5itSNzq6T6bO
X-Gm-Gg: ASbGncuIppiwCQ01PoDmZKOH3n7s+7n/KbiIxie2MTbpfz/vhFdSSyAOmWG5RjEi0Im
 enX2tpuxxWfxtmAxiuYSegl7IN5cqqQksIwv6TAkNMR4t/TmsOqcUdqLLrK7lRfrgq49vIyD3XD
 xOWcOefMxu+ocy99ZWxEm3C4jgTIbIiYVtdhIafpwG7NUpQxEBbE63S3lVYZZ4pT9QC6u7PHR9+
 utISaTXHq5GIVEsUdy+tpbrcILlrjFlDedFzNSvaoG0Hh9RPV3whP5iI2ZGApk4RZZz/KU=
X-Google-Smtp-Source: AGHT+IEnmRz/1RDYFRzQKi3b9i8kkMqLUYKw9nc2XANIzFRDeX0PZeLvRHWy2KWwz6DteIiDvhif4nWFGBYAQaK8hnU=
X-Received: by 2002:a05:6402:2681:b0:634:64b3:3900 with SMTP id
 4fb4d7f45d1cf-63c1f64729fmr16960891a12.9.1761040338415; Tue, 21 Oct 2025
 02:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
 <20251020115009.532a1a99@kmaincent-XPS-13-7390>
 <20251020141548.GS6688@bill-the-cat> <20251020143729.GW6688@bill-the-cat>
 <20251020171613.76ffddac@kmaincent-XPS-13-7390>
 <20251020160527.GY6688@bill-the-cat>
 <20251020190854.4b318829@kmaincent-XPS-13-7390>
 <20251020171707.GA6688@bill-the-cat>
 <87h5vsbt2t.fsf@kernel.org> <20251021110225.2d94a13b@kmaincent-XPS-13-7390>
In-Reply-To: <20251021110225.2d94a13b@kmaincent-XPS-13-7390>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Oct 2025 10:52:05 +0100
X-Gm-Features: AS18NWCiLf8QGfSjbH-cpFD43inkPhS-iHsSdg6P-OL7cDgdoj6KdFpm6rGjWJs
Message-ID: <CAFLszTjw+LTvspVNrnxmc+kii+vMPU1qzV=1y3BSwWGXEvoagw@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds its
 support to boot flows
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Kory,

On Tue, Oct 21, 2025, 10:02 Kory Maincent <kory.maincent@bootlin.com> wrote=
:

> On Tue, 21 Oct 2025 09:40:58 +0200
> Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>
> > On Mon, Oct 20, 2025 at 11:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Mon, Oct 20, 2025 at 07:08:54PM +0200, Kory Maincent wrote:
> > >> On Mon, 20 Oct 2025 10:05:27 -0600
> > >> Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> > On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent wrote:
> > >> > > On Mon, 20 Oct 2025 08:37:29 -0600
> > >> > > Tom Rini <trini@konsulko.com> wrote:
> > >> > >
> > >> > > > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote:
> > >> > > > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent wrot=
e:
> > >> > > > >
> > >> > > > > > On Sun, 19 Oct 2025 10:48:37 -0600
> > >> > > > > > Tom Rini <trini@konsulko.com> wrote:
> > >> > > > > >
> > >> > > > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass
> wrote:
> > >> > > > > > >
> > >> > > > > > > > Hi Kory,
> > >> > > > > > > >
> > >> > > > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> > >> > > > > > > > <kory.maincent@bootlin.com> wrote:
> > >> > > > > > > > >
> > >> > > > > > > > > This series converts the extension board framework t=
o
> use
> > >> > > > > > > > > UCLASS as requested by Simon Glass, then adds
> extension
> > >> > > > > > > > > support to pxe_utils and bootmeth_efi (not tested) t=
o
> > >> > > > > > > > > enable extension boards devicetree load in the
> standard
> > >> > > > > > > > > boot process.
> > >> > > > > > > > >
> > >> > > > > > > > > I can't test the imx8 extension scan enabled by the
> > >> > > > > > > > > imx8mm-cl-iot-gate_defconfig as I don't have this
> board.
> > >> > > > > > > > > I also can't test the efi bootmeth change as I don't
> have
> > >> > > > > > > > > such board.
> > >> > > > > > > >
> > >> > > > > > > > You can test this with sandbox, using one of the
> bootmeth
> > >> > > > > > > > tests, perhaps. Let me know if you need help with this=
.
> > >> > > > > > > >
> > >> > > > > > >
> > >> > > > > > > But the question is, does the real hardware platform wor=
k
> > >> > > > > > > before/after this, not does the sandbox test still work
> > >> > > > > > > before/after this.
> > >> > > > > >
> > >> > > > > > It seems the bootlflow scan is not working on the sandbox
> on next
> > >> > > > > > branch. Is this issue known?
> > >> > > > >
> > >> > > > > Is it fine on master? The next branch will be out of date
> until it
> > >> > > > > re-opens with -rc2 being released (2 weeks from today).
> > >> > > >
> > >> > > > ... out of sync local calendar, 3 weeks from today, not 2.
> > >> > >
> > >> > > bootstd test suit is not working on master with the
> sandbox_defconfig:
> > >> > > https://termbin.com/un0p
> > >> > >
> > >> > > Noticeable things are;
> > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x0 (0), got
> > >> > > 0xffffffed (-19) Test: bootdev_test_any: bootdev.c (flat tree)
> > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x0 (0), got
> > >> > > 0xffffffed (-19) Test 'bootdev_test_any' failed 2 times
> > >> > >
> > >> > > And a nice segfault:
> > >> > > Test: bootflow_set_arg: bootflow.c
> > >> > > Test: bootflow_system: bootflow.c
> > >> > > [3]    569337 segmentation fault (core dumped)  ./u-boot
> > >> > >
> > >> > > Maybe things are missing to run sandbox_defconfig on my computer=
?
> > >> > > With the sandbox64_defconfig there is not core dump anymore but
> there
> > >> > > is still the failed line:
> > >> > > Test 'bootdev_test_bootable' failed 2 times
> > >> > >
> > >> > > And the uboot is reboot infinitely during the bootflow test:
> > >> > > ./u-boot -T -c "ut bootstd"
> > >> > > https://termbin.com/alu5
> > >> >
> > >> > I see the same thing you do when running them outside of pytest, b=
ut
> > >> > they're also fine within pytest.
> > >> > https://docs.u-boot.org/en/latest/develop/pytest/usage.html should
> help
> > >> > get you started, and you can just run all of the ut tests under
> that.
> > >>
> > >> Weird I got errors also within pytest.
> > >> See the html test log attached generated by the following command:
> > >> ./test/py/test.py --bd sandbox -k bootstd
> > >
> > > Same. There's some implicit dependencies around I believe. Doing "-k
> ut"
> > > should work, as I tried that (via my wrapper around all this) as well
> as
> > > just running all the tests (which is longer).
> >
> > That's my understanding as well
> >
> > In Kory's log we see:
> >
> >         MMC:   Can't map file 'mmc1.img': Invalid argument
> >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> >         Can't map file 'mmc1.img': Invalid argument
> >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> >                    mmc_probe() mmc1 - probe failed: -1
> >         mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argument
> >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> >         , mmc0: 0 (SD)
> >
> > These mmc1.img are needed for the bootstd tests to run properly.
> >
> > These mmc*.img are generated in test_ut.py (see setup_cros_image() for
> > example)
> >
> > So, In order to only run the bootstd tests, I think we need to to run:
> >
> >     $ ./test/py/test.py --bd sandbox --build -k test_ut
> >     $ ./test/py/test.py --bd sandbox --build -k bootstd
> >
> > Then we can just call:
> >
> >     $ ./test/py/test.py --bd sandbox --build -k bootstd
>
> Ok after installing missing dependencies and running test_ut tests I have
> less
> errors but there are still bootflow errors. See the test-log attached.
> I suppose all the tests should pass, right?
>

How are you running the tests? This is described in the docs. Search for
'tests'.

https://docs.u-boot.org/en/latest/develop/tests_sandbox.html#running-sandbo=
x-tests-directly

Regards,
Simon




> Regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>
