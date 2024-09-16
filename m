Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB16C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF3B88EFD;
	Mon, 16 Sep 2024 17:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hjEm+nIF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BFD883D4; Mon, 16 Sep 2024 17:43:09 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE93F88EFD
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c524b4f8b9so38466776d6.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726501386; x=1727106186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qk3xVaT5BdpvTP6wp5Wjg++iOu/zROVNmA6vuJFYuKo=;
 b=hjEm+nIF6AZTIQkQ7RF1ScUgdXlC8516aebcIVg0LMZsbswOvHcxqcvo7/gcJ0BLa1
 xxOJAHfLrR/5mo9rlVdppmsN/af/1ZdJNhw19Gs0Tx1FLP4J6Kip9IGIy201xtub9jKd
 3qwmJEDCSjtZoEkfsr7ZIkV6clMbf9OQIpfdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501386; x=1727106186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qk3xVaT5BdpvTP6wp5Wjg++iOu/zROVNmA6vuJFYuKo=;
 b=svhaJjP7EMgYpnTy0tEpnifgp/N1XYWd9cpd78EQf7jvBcE/19bPKMUu/CX7pOKPSh
 l4FO6kVqAD5SCKHr9GRrmof6JsAum5Wiah9gYix6nfR/MJoRAcId0BjJEs5Jstywv9ts
 x6b3MLIqwRooYsNa2wfvMK/pFk69XQanOpNK/7hf6rolgXB/eXPREzcXL4VUl2XEIqXT
 /5pQ8rZ8EZR/rvE64Os0XSleCNaQelKwcwWphxv7tPgTQ71jL8K99fFBWE/RoT76pAQf
 4+ww0Qpum4ZPK8TdASeX46xArb0yBC/Y/Do5AzI4EKu9NbzUvGLPqZPI4+u2m47YPRIo
 5opA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvqD7Ll9cvW2MZskcHFW8WvB7luSCJelhu8+DWdh8ZH9480IIcnFgxynA+Uvt4M4ztF+niSd8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxt4nF+tFI76qhan3ylg11Fk/uJI1ucGMY1d0WmBc6S8TEVJzKA
 MBHBQ2H1rl1e5pSDt15LfprACH0iDHocXe7czZPjGYawVImExzjTk5IkUbHTcjDGc5VITu78oOQ
 nsjWFoZkQRaGFNpLaAwZC+1s7mLHTJDEFF4zp94CR23SXLnmbYy41Ct8=
X-Google-Smtp-Source: AGHT+IHgpGPjuv4y53+N5ZGWOIeBV/76QH4UmZi+SEIyYEbZH+7zcmziV+9ErbFwsCVWvuvsaK996/snvCeZg4pCM68=
X-Received: by 2002:a05:6214:450b:b0:6c5:5a63:7ee5 with SMTP id
 6a1803df08f44-6c57def3025mr220199906d6.9.1726501385771; Mon, 16 Sep 2024
 08:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-15-sjg@chromium.org>
 <18f3b613-5191-4bfb-b6d1-f10d9c790853@gmx.de>
In-Reply-To: <18f3b613-5191-4bfb-b6d1-f10d9c790853@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:42:48 +0200
Message-ID: <CAFLszTgvC7RL53jHFKQDL4kUgq97SU79fxvJO71azS0vHSm1iQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] test: efi: boot: Add a test for the efi bootmeth
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 02.09.24 03:18, Simon Glass wrote:
> > Add a simple test of booting with the EFI bootmeth, which runs the app
> > and checks that it can call 'exit boot-services' (to check that all the
> > device-removal code doesn't break anything) and then exit back to
> > U-Boot.
> >
> > This uses a disk image containing the testapp, ready for execution by
> > sandbox when needed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > ---
> >
> > Changes in v5:
> > - Rebase on updated efif series
> > - Deal with sandbox CONFIG_LOGF_FUNC
> >
> > Changes in v4:
> > - Add efi_loader tag to some patches
> > - Split out non-EFI patches into a different series
> >
> > Changes in v2:
> > - Add many new patches to resolve all the outstanding test issues
> >
> >   test/boot/bootflow.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 64 insertions(+)
> >
> > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > index 37884dbd441..d8da3aac493 100644
> > --- a/test/boot/bootflow.c
> > +++ b/test/boot/bootflow.c
> > @@ -13,6 +13,7 @@
> >   #include <cli.h>
> >   #include <dm.h>
> >   #include <efi_default_filename.h>
> > +#include <efi_loader.h>
> >   #include <expo.h>
> >   #ifdef CONFIG_SANDBOX
> >   #include <asm/test.h>
> > @@ -31,6 +32,9 @@ extern U_BOOT_DRIVER(bootmeth_android);
> >   extern U_BOOT_DRIVER(bootmeth_cros);
> >   extern U_BOOT_DRIVER(bootmeth_2script);
> >
> > +/* Use this as the vendor for EFI to tell the app to exit boot services */
> > +static u16 __efi_runtime_data test_vendor[] = u"U-Boot testing";
> > +
> >   static int inject_response(struct unit_test_state *uts)
> >   {
> >       /*
> > @@ -1205,3 +1209,63 @@ static int bootflow_android(struct unit_test_state *uts)
> >       return 0;
> >   }
> >   BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
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
> > +     /* signal to helloworld to exit boot services */
>
>
> What 'helloworld' are you relating to?

That comment is stale so can be dropped. It dates from when the test
used the helloword binary.

>
> Best regards
>
> Heinrich
>
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
>

Regards,
Simon
