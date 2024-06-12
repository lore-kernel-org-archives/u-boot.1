Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE12C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 23:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C398888A1;
	Thu, 13 Jun 2024 01:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nhnn/wKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3298C88863; Wed, 12 Jun 2024 22:25:01 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D1D8867D
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-681ad081695so191356a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223897; x=1718828697; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Se1SXhKr6SLpDBmEMEFkaN7sgM8srHIXel/BHHfei9w=;
 b=Nhnn/wKygkis9ZRzE4Voyj3UKYZvrWyW7NWk9J4ofy60OzrqdW3vIi/bR40AR2W0gY
 9mMu2x6YCE7PgZvXWHwtvU1aoJZnjTdgSaRvMruCZtGlw8PTbk3Rv8I4UGQy9LRWba0G
 YVWRjSRmAyskT7+b+EezDO5+b9IUpf0Jnzqr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223897; x=1718828697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Se1SXhKr6SLpDBmEMEFkaN7sgM8srHIXel/BHHfei9w=;
 b=W1rx1o9FbIjPS4k5sS1Q2caGlOEv+VGGrOl8VhwxiI7lYrRWrM+yfHutKx2u7Vs2g3
 OuxyyFPaYWAsEPeP9RuEtK2BjlrHZrwWrwaS0xoHVOhn1CXJ2R2sBEFvnYi4gUX1jmL3
 YkIx1CLIEJ0anwmmLs/IIepHwKX5yNyZu38fNAMkWHn5Lxh1PKJ8UdbsLaSphiE88Chj
 OynFqqoVDqQ0+nlwkJHq6lwjO5+Y7FxGYPQz1vEqOPqyyuGAuTi7yNrfC5QihP//wWY6
 MEPzGtKMI3cT2H497olAe1l/Q6udVZP0fvk24UVukfIGlpwmuhk8tWvQfqXiUvZf8j8P
 xtVQ==
X-Gm-Message-State: AOJu0YxQ+1TQqFvxD2p8AMejRBE17hZmwC7RNjTuduMoqG77tW45pl4n
 Y/x5CDnWSAvML/QD1h+eXNPBPqypf6YSaXSy3pwABiD2nTVKgaovx0Buy1xQCFaziMRyndYT2L5
 m5jhxXZ09tng4VEZWiWx3TTSXuX6DcMNqE63L
X-Google-Smtp-Source: AGHT+IFmTy4fW3SQf1NiS7xl7kbYhyiHePllnbH5Sqbm5EyvdkHkSGpfFXU8wKlXlF0dtelm8HL13wBNtd+Ip+WNjfI=
X-Received: by 2002:a05:6a20:daa2:b0:1b8:3ddc:913b with SMTP id
 adf61e73a8af0-1b8a8dfb0ecmr3217076637.0.1718223896724; Wed, 12 Jun 2024
 13:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240611200156.2245525-1-sjg@chromium.org>
 <CAC_iWjKAaWnphnBUi6YTRMn1EthbX5mZtjh78YXyxWoXqmJcGw@mail.gmail.com>
In-Reply-To: <CAC_iWjKAaWnphnBUi6YTRMn1EthbX5mZtjh78YXyxWoXqmJcGw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:36 -0600
Message-ID: <CAFLszTi7BoAoDc9=+m77pwSAuGSZDQeX-MgzWc9ZJC3ZxJXwMQ@mail.gmail.com>
Subject: Re: [PATCH 00/42] labgrid: Provide an integration with Labgrid
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Allen Martin <amartin@nvidia.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, Andrew Davis <afd@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Trevor Woerner <twoerner@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 13 Jun 2024 01:41:34 +0200
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

Hi Ilias,

On Wed, 12 Jun 2024 at 00:09, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Tue, 11 Jun 2024 at 23:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Labgrid provides access to a hardware lab in an automated way. It is
> > possible to boot U-Boot on boards in the lab without physically touching
> > them. It relies on relays, USB UARTs and SD muxes, among other things.
> >
> > By way of background, about 4 years ago I wrong a thing called Labman[1]
> > which allowed my lab of about 30 devices to be operated remotely, using
> > tbot for the console and build integration. While it worked OK and I
> > used it for many bisects, I didn't take it any further.
> >
> > It turns out that there was already an existing program, called Labgrid,
> > which I did not know about at time (thank you Tom for telling me). It is
> > more rounded than Labman and has a number of advantages:
> >
> > - does not need udev rules, mostly
> > - has several existing users who rely on it
> > - supports multiple machines exporting their devices
> >
> > It lacks a 'lab check' feature and a few other things, but these can be
> > remedied.
> >
> > On and off over the past several weeks I have been experimenting with
> > Labgrid. I have managed to create an initial U-Boot integration (this
> > series) by adding various features to Labgrid[2] and the U-Boot test
> > hooks.
> >
> > I hope that this might inspire others to set up boards and run tests
> > automatically, rather than relying on infrequent, manual test. Perhaps
> > it may even be possible to have a number of labs available.
> >
> > Included in the integration are a number of simple scripts which make it
> > easy to connect to boards and run tests:
> >
> > ub-int <target>
> >     Build and boot on a target, starting an interactive session
> >
> > ub-cli <target>
> >     Build and boot on a target, ensure U-Boot starts and provide an interactive
> >     session from there
> >
> > ub-smoke <target>
> >     Smoke test U-Boot to check that it boots to a prompt on a target
> >
> > ub-bisect
> >     Bisect a git tree to locate a failure on a particular target
> >
> > ub-pyt <target> <testspec>
> >     Run U-Boot pytests on a target
> >
> > Some of these help to provide the same tbot[4] workflow which I have
> > relied on for several years, albeit much simpler versions.
> >
> > The goal here is to create some sort of script which can collect
> > patches from the mailing list, apply them and test them on a selection
> > of boards. I suspect that script already exists, so please let me know
> > what you suggest.
> >
> > I hope you find this interesting and take a look!
>
> Thanks this is interesting!

Thanks!

> I only got cc'ed on the cover letter and I'll slowly have a look on
> the rest. A naive question -- I saw you did integrate this on gitlab
> with your internal lab. How secure is this? Could we schedule weekly
> builds that run on various remote labs and get results on actual
> hardware? Or do we have to rely on users for that ?

I believe this could be done. My understanding is that any custodian
can push to a tree which runs on all available runners.

If you have any ideas on the script I mentioned, let me know!

Regards,
Simon


>
> Thanks
> /Ilias
>
> >
> > [1] https://github.com/sjg20/u-boot/tree/lab6a
> > [2] https://github.com/labgrid-project/labgrid/pull/1411
> > [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> > [4] https://tbot.tools/index.html
> >
> >
> > Simon Glass (42):
> >   trace: Update test to tolerate different trace-cmd version
> >   binman: efi: Correct entry docs
> >   binman: Regenerate nxp docs
> >   binman: ti: Regenerate entry docs
> >   binman: Update the entrydocs header
> >   buildman: Make mrproper an argument to _reconfigure()
> >   buildman: Make mrproper an argument to _config_and_build()
> >   buildman: Make mrproper an argument to run_commit()
> >   buildman: Avoid rebuilding when --mrproper is used
> >   buildman: Add a flag to force mrproper on failure
> >   buildman: Retry the build for current source
> >   buildman: Add a way to limit the number of buildmans
> >   dm: core: Enhance comments on bind_drivers_pass()
> >   initcall: Correct use of relocation offset
> >   am33xx: Provide a function to set up the debug UART
> >   sunxi: Mark scp as optional
> >   google: Disable TPMv2 on most Chromebooks
> >   meson: Correct driver declaration for meson_axg_gpio
> >   test: Allow signaling that U-Boot is ready
> >   test: Make bootstd init run only on sandbox
> >   test: Use a constant for the test timeout
> >   test: Pass stderr to stdout
> >   test: Release board after tests complete
> >   log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
> >   test: Allow connecting to a running board
> >   test: Decode exceptions only with sandbox
> >   test: Avoid failing skipped tests
> >   test: dm: Show failing driver name
> >   test: Check help output
> >   test: Create a common function to get the config
> >   test: Introduce the concept of a role
> >   test: Move the receive code into a function
> >   test: Separate out the exception handling
> >   test: Detect dead connections
> >   test: Tidy up remaining exceptions
> >   test: Introduce lab mode
> >   test: Improve handling of sending commands
> >   test: Fix mulptiplex_log typo
> >   test: Avoid double echo when starting up
> >   test: Try to shut down the lab console gracefully
> >   test: Add a section for closing the connection
> >   CI: Allow running tests on sjg lab
> >
> >  .gitlab-ci.yml                                | 151 +++++++++++++++++
> >  arch/arm/dts/sunxi-u-boot.dtsi                |   1 +
> >  arch/arm/mach-omap2/am33xx/board.c            |  18 +-
> >  configs/chromebook_link64_defconfig           |   1 +
> >  configs/chromebook_link_defconfig             |   1 +
> >  configs/chromebook_samus_defconfig            |   1 +
> >  configs/chromebook_samus_tpl_defconfig        |   1 +
> >  configs/nyan-big_defconfig                    |   4 +-
> >  configs/snow_defconfig                        |   1 +
> >  drivers/core/lists.c                          |  16 ++
> >  drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |   2 +-
> >  drivers/pinctrl/meson/pinctrl-meson-axg.c     |   4 +-
> >  drivers/pinctrl/meson/pinctrl-meson-axg.h     |   2 +-
> >  drivers/pinctrl/meson/pinctrl-meson-g12a.c    |   4 +-
> >  lib/initcall.c                                |   6 +-
> >  test/py/conftest.py                           |  86 ++++++++--
> >  test/py/tests/test_dm.py                      |   5 +-
> >  test/py/tests/test_help.py                    |   6 +-
> >  test/py/tests/test_log.py                     |  11 +-
> >  test/py/tests/test_trace.py                   |   6 +-
> >  test/py/tests/test_ut.py                      |   1 +
> >  test/py/u_boot_console_base.py                | 154 ++++++++++++------
> >  test/py/u_boot_console_exec_attach.py         |  31 +++-
> >  test/py/u_boot_console_sandbox.py             |   2 +-
> >  test/py/u_boot_spawn.py                       | 123 ++++++++++++--
> >  test/test-main.c                              |  16 +-
> >  tools/binman/entries.rst                      | 115 +++++++++----
> >  tools/binman/entry.py                         |   2 +-
> >  tools/binman/etype/efi_capsule.py             |  40 ++---
> >  tools/binman/etype/efi_empty_capsule.py       |  22 +--
> >  tools/binman/etype/ti_secure.py               |  45 ++---
> >  tools/buildman/builder.py                     |  18 +-
> >  tools/buildman/builderthread.py               |  44 +++--
> >  tools/buildman/buildman.rst                   |   8 +-
> >  tools/buildman/cmdline.py                     |   6 +-
> >  tools/buildman/control.py                     | 141 +++++++++++++++-
> >  tools/buildman/pyproject.toml                 |   6 +-
> >  tools/buildman/test.py                        | 121 ++++++++++++++
> >  tools/u_boot_pylib/terminal.py                |   7 +-
> >  39 files changed, 1003 insertions(+), 226 deletions(-)
> >
> > --
> > 2.34.1
> >
