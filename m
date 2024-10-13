Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3138CF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E57288FA8;
	Sun, 13 Oct 2024 21:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dwD6Kogm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A4E88FB5; Sun, 13 Oct 2024 21:33:39 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE3D88FA1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbc845e12eso29037096d6.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728848016; x=1729452816; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GzaGrqloteJZwb+NP5gxlA8e10nIi1Gp2czYERJkXmA=;
 b=dwD6KogmsMrQ4dRwC2/jl1tGCjfUUXz93jnuGPoaFbzLTsDpbj+nWdP2YB96M+Ojdd
 wi6DfNe/ACmMWaSXPBCfTCF062O9WRAkurTxKYmxVDXn7p6LgyCDMPFsZl8A58EZQDWb
 +GGegI2lPWdljrlZN79BBVrAA6dJcxG+uUbhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728848016; x=1729452816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GzaGrqloteJZwb+NP5gxlA8e10nIi1Gp2czYERJkXmA=;
 b=dxNX/DcpvpyzE+3rQY6fzkX6IaHz1+y+0g1xtYbC5PVPAL61DN6QiVMtsCRGNiZ92u
 kcFPsFDIDWONpM5JhmHjVwW0clkx3dl7pHGeoh0kc3oO7GARA9xNmWy/TLpFOakgULAz
 IY9tzFdM6A2J2kp8WOlAsyt/+9gFhRL1lpAIj+a9NHv4d7YkHiT8/KD9W5UQ27IPaXoR
 bzBe3KRZP7XcnFEPK+ESHr4E1yZlk/Qmgx0k3tM5p8tKGkDcut2UsEHta8HQnMbnN3Ik
 PF0OPdybIXc8Ir2DqTyja7ShUJ5kVKCQS3ZUHpkl3Nbx2Fop1njNV6VtKUa4TMw4SDYt
 03aA==
X-Gm-Message-State: AOJu0Yymy7JOUxGeuQCeEvRW/6GouJkJZbnP5IJDYAdJygyiesMJLxTi
 EvkHTtmDLs/Pl6zEzeuRlRCwKyVVKIGjC+NKjsoPbQPYIeo+X3J5kEfzAst6mIdG8b77Z9qdM2b
 5JbfNpvbVJq78YrSV4XtnMRpTvbNU5ZloiDKa
X-Google-Smtp-Source: AGHT+IGUsUS+8O6mX6gLfkWpGBIHj4cPvBFr9rUszwG+PtE/7sgDgotJ3kpJsNnp30AJuAxWDnhLMVcZQXNlKPZznv8=
X-Received: by 2002:a05:6214:3289:b0:6cb:460c:61dc with SMTP id
 6a1803df08f44-6cbeff7562emr138468996d6.11.1728848015661; Sun, 13 Oct 2024
 12:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
In-Reply-To: <20241011223227.GA630742@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 13 Oct 2024 13:33:23 -0600
Message-ID: <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Fri, 11 Oct 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 27, 2024 at 12:02:23AM +0200, Simon Glass wrote:
>
> > Add a simple test of booting with the EFI bootmeth, which runs the app
> > and checks that it can call 'exit boot-services' (to check that all the
> > device-removal code doesn't break anything) and then exit back to
> > U-Boot.
> >
> > This uses a disk image containing the testapp, ready for execution by
> > sandbox when needed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> So lets go to the problem point. What asserts here fail due to ANSI
> escape codes being in the output and needing to be filtered out?
>
> [snip]
> > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > index e05103188b4..da2ee1ab345 100644
> > --- a/test/boot/bootflow.c
> > +++ b/test/boot/bootflow.c
> > @@ -13,6 +13,7 @@
> >  #include <cli.h>
> >  #include <dm.h>
> >  #include <efi_default_filename.h>
> > +#include <efi_loader.h>
> >  #include <expo.h>
> >  #ifdef CONFIG_SANDBOX
> >  #include <asm/test.h>
> > @@ -31,6 +32,9 @@ extern U_BOOT_DRIVER(bootmeth_android);
> >  extern U_BOOT_DRIVER(bootmeth_cros);
> >  extern U_BOOT_DRIVER(bootmeth_2script);
> >
> > +/* Use this as the vendor for EFI to tell the app to exit boot services */
> > +static u16 __efi_runtime_data test_vendor[] = u"U-Boot testing";
> > +
> >  static int inject_response(struct unit_test_state *uts)
> >  {
> >       /*
> > @@ -1205,3 +1209,62 @@ static int bootflow_android(struct unit_test_state *uts)
> >       return 0;
> >  }
> >  BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
> > +
> > +/* Test EFI bootmeth */
> > +static int bootflow_efi(struct unit_test_state *uts)
> > +{
> > +     /* disable ethernet since the hunter will run dhcp */
> > +     test_set_eth_enable(false);
> > +
> > +     /* make USB scan without delays */
> > +     test_set_skip_delays(true);
> > +
> > +     bootstd_reset_usb();
> > +
> > +     /* Avoid outputting ANSI characters which mess with our asserts */
> > +     efi_console_set_ansi(false);
> > +
> > +     ut_assertok(bootstd_test_drop_bootdev_order(uts));
> > +     ut_assertok(run_command("bootflow scan", 0));
> > +     ut_assert_skip_to_line(
> > +             "Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
> > +
> > +     ut_assertok(run_command("bootflow list", 0));
> > +
> > +     ut_assert_nextlinen("Showing all");
> > +     ut_assert_nextlinen("Seq");
> > +     ut_assert_nextlinen("---");
> > +     ut_assert_nextlinen("  0  extlinux");
> > +     ut_assert_nextlinen(
> > +             "  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
> > +     ut_assert_nextlinen("---");
> > +     ut_assert_skip_to_line("(2 bootflows, 2 valid)");
> > +     ut_assert_console_end();
> > +
> > +     ut_assertok(run_command("bootflow select 1", 0));
> > +     ut_assert_console_end();
> > +
> > +     systab.fw_vendor = test_vendor;
> > +
> > +     ut_asserteq(1, run_command("bootflow boot", 0));
> > +     ut_assert_nextline(
> > +             "** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi");
> > +     if (IS_ENABLED(CONFIG_LOGF_FUNC))
> > +             ut_assert_skip_to_line("       efi_run_image() Booting /\\EFI\\BOOT\\BOOTSBOX.EFI");
> > +     else
> > +             ut_assert_skip_to_line("Booting /\\EFI\\BOOT\\BOOTSBOX.EFI");
> > +
> > +     /* TODO: Why the \r ? */
> > +     ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
> > +     ut_assert_nextline("Exiting boot sevices");
> > +     if (IS_ENABLED(CONFIG_LOGF_FUNC))
> > +             ut_assert_nextline("     do_bootefi_exec() ## Application failed, r = 5");
> > +     else
> > +             ut_assert_nextline("## Application failed, r = 5");
> > +     ut_assert_nextline("Boot failed (err=-22)");
> > +
> > +     ut_assert_console_end();
> > +
> > +     return 0;
> > +}
> > +BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);

Thanks for taking an interest in this.

Nothing at present, as I added ut_assert_skip_to_line() to skip it
all. But it really is just wrong...I get gibberish showing up in the
terminal after I run tests! This is what I see with this series:

** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi
 7 [r [999;999H [6n 8No EFI system partition

^^^ strange output there but I'm not sure if it will come through on email

No EFI system partition
Failed to persist EFI variables
No EFI system partition
Failed to persist EFI variables
No EFI system partition
Failed to persist EFI variables
Booting /\EFI\BOOT\BOOTSBOX.EFI
U-Boot test app for EFI_LOADER

Exiting boot sevices
## Application failed, r = 5
Boot failed (err=-22)
Failures: 0

>
> --
> Tom

I just want this applied or some other fix to stop it happening. It
doesn't hurt anything and it should not be controversial.

Regards,
Simon
