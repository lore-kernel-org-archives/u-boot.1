Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968A2D1A426
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 22:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3BB28939F;
	Sat, 12 Oct 2024 00:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l4gbrpcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F35A893F7; Sat, 12 Oct 2024 00:16:43 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99A98906C
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so22354386d6.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728684999; x=1729289799; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aK+qm4/YKBxR+ylO/mCAXjUsh6jMyivBp1QoyUctD/Q=;
 b=l4gbrpcwKa3p/Pypc/BFup0Q7SNsrWYZgatThXyJOILfvcu9BzNpRPP0gt2USL1/yu
 HvE+sJBHyJIB27PVuWj2/ietw2di/IOEX6YNGf2abNR8l4xpXBFMlT/0TOspDDHHEG77
 YRTYO8L0gv+qOHgM6P9wHK1aVqvt+YakhXotU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728684999; x=1729289799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aK+qm4/YKBxR+ylO/mCAXjUsh6jMyivBp1QoyUctD/Q=;
 b=jSr2K69kBZAaeVih1GViKtquZrTsErt0NSgloPgBu3pszhQrU/U8AhA2sOdP/OuKk1
 ZbLCfc2Ld6fLmWJMqAUGPmz3HGcxJXhUEM1gR3ytfeC8KPOwWJqkMjuUfNN3ab9iwPmC
 d2Mr7BQU8vtw4HqW2n1OeQSAfV1CMlzA6aHcSBmEVIRDeoQ1ZRPe8uPkNYaLPKN7wHfx
 ER6svthpeZawZpwAFpEffFF0JOBRw3rExSg+TnaIksbGn9L1yHjnZ2vfEKd65Eln+jIX
 QIgOfgZ5vpPDLBz5bHv4GfsXQyRc8sVzSxjstDI3wYP16G+ZNK6iAztoLoArrwnPv2km
 IFxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJpCQwIYCMJKSl9HWzug/eaRyPcNCdAt7FmjqvFdTm0zRhGdQugV3UY1n5r7wnuh4YGE1uW9A=@lists.denx.de
X-Gm-Message-State: AOJu0YxG3K3OOX418gILo9wGiQ8F9XsGKflDV++SleTkDk95BmbRlINq
 xZHz4kKJX1XqdIi40EWmgwwRYGgq4czF54VBIu2mgcLHCEEiRU2Z+rQ/MwVmfJzYBUatUl4tzM0
 WaCjDM8y8wfrLG4ajsugT1/Hmr7wJye+v2ydD
X-Google-Smtp-Source: AGHT+IHjsYhEnHQMSOHffVW8dArcFTy8ddU6KQ7+fzj6ouURknPJ+f41gfUBlv49MR1IF4d0l5r8uXcs6GXZDb0rAUA=
X-Received: by 2002:a05:6214:20e8:b0:6cb:5bde:d78 with SMTP id
 6a1803df08f44-6cbe520243bmr153437846d6.3.1728684999427; Fri, 11 Oct 2024
 15:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
 <20241001180235.GH4737@bill-the-cat>
 <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
In-Reply-To: <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Oct 2024 16:16:28 -0600
Message-ID: <CAFLszTj6Zuj0b3kEA4OKOQY_D5XMWmtbn+HJXik+xSrB7LUjLA@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich, Tom,

On Tue, 1 Oct 2024 at 16:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote=
:
>
> On 10/1/24 20:02, Tom Rini wrote:
> > On Tue, Oct 01, 2024 at 04:34:54AM +0200, Heinrich Schuchardt wrote:
> >> On 10/1/24 02:24, Tom Rini wrote:
> >>> On Tue, Oct 01, 2024 at 01:38:56AM +0200, Heinrich Schuchardt wrote:
> >>>> On 26.09.24 23:59, Simon Glass wrote:
> >>>>> We don't want ANSI characters written in tests since it is a pain t=
o
> >>>>> check the output with ut_assert_nextline() et al.
> >>>>>
> >>>>> Provide a way to tests to request that ANSI characters not be sent.
> >>>>>
> >>>>> Add a proper function comment while we are here, to encourage other=
s.
> >>>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>
> >>>> Please, consider prior review before resubmitting patches.
> >>>>
> >>>> As responded to all prior submissions:
> >>>>
> >>>> We want to test the code running on actual machines.
> >>>> We don't want to have sandbox code everywhere.
> >>>>
> >>>> I cannot see any test that is not passing due to the current behavio=
r.
> >>>
> >>> The pytests for the EFI selftests are unreliable for me, on Raspberry=
 Pi
> >>> 3, more often in 32bit mode than 64bit mode, but I feel like I see it
> >>> there too. And when they fail, the console log is full of ANSI escape
> >>> sequences. Is this specific test a test you run regularly on real
> >>> hardware?
> >>>
> >>
> >> It is not only the EFI test but also pytest adding color to the consol=
e
> >> output.
> >
> > Alright, so at least for the problems I have _today_, I've figured it
> > out, and the problem is that the watchdog test fails too quickly:
> >
> > [snip]
> > test/py/tests/test_efi_selftest.py ..F
> > test/py/u_boot_console_base.p
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > ______________________ test_efi_selftest_watchdog_reboot ______________=
_________
> > test/py/tests/test_efi_selftest.py:61: in test_efi_selftest_watchdog_re=
boot
> >      u_boot_console.restart_uboot()
> > test/py/u_boot_console_base.py:478: in restart_uboot
> >      self.ensure_spawned(expect_reset)
> > test/py/u_boot_console_base.py:442: in ensure_spawned
> >      self.wait_for_boot_prompt(loop_num =3D loop_num)
> > test/py/u_boot_console_base.py:195: in wait_for_boot_prompt
> >      raise Exception('Bad pattern found on console: ' +
> > E   Exception: Bad pattern found on console: spl_signon
> > ----------------------------- Captured stdout call --------------------=
---------
> > =3D> setenv efi_selftest list
> > =3D> =3D> bootefi selftest
> >  7 [r [999;999H [6n 8No EFI system partition
> > No EFI system partition
> > Failed to persist EFI variables
> > No EFI system partition
> > Failed to persist EFI variables
> > No EFI system partition
> > Failed to persist EFI variables
> >
> > Available tests:
> > 'block image transfer' - on request
> > 'block device'
> > 'configuration tables'
> > 'controllers'
> > 'crc32'
> > 'device path'
> > 'device path utilities protocol'
> > 'conformance profile table'
> > 'event groups'
> > 'event services'
> > 'exception' - on request
> > 'ExitBootServices'
> > 'device tree'
> > 'graphical output'
> > 'HII database protocols'
> > 'load file protocol'
> > 'loaded image'
> > 'load image from file'
> > 'mem'
> > 'memory'
> > 'open protocol'
> > 'manage protocols'
> > 'register protocol notify'
> > 'reset system' - on request
> > 'reset system runtime' - on request
> > 'real time clock'
> > 'simple network protocol'
> > 'start image return'
> > 'start image exit'
> > 'text input' - on request
> > 'extended text input' - on request
> > 'text output'
> > 'task priority levels'
> > 'unicode collation'
> > 'variables'
> > 'variables at runtime'
> > 'virtual address map'
> > 'watchdog timer'
> > 'watchdog reboot' - on request
> > =3D> =3D> setenv efi_selftest watchdog reboot
> > =3D> =3D> bootefi selftest
> >  [1;37;40m
> > Testing EFI API implementation
> >  [0;37;40m [1;37;40m
> > Selected test: 'watchdog reboot'
> >  [0;37;40m [1;34;40m
> > Setting up 'watchdog reboot'
> >  [0;37;40m [1;32;40mSetting up 'watchdog reboot' succeeded
> >  [0;37;40m [1;34;40m
> > Executing 'watchdog reboot'
> >  [0;37;40m
> > EFI: Watchdog timeout
> > resetting ...
> > +u-boot-test-reset am64x_evm_a53 na
> > Selected role am64-sk from configuration file
> > Selected role am64-sk from configuration file
> > connecting to NetworkSerialPort(target=3DTarget(name=3D'am64-sk', env=
=3DEnvironment(config_file=3D'/home/trini/u-boot/lg_env.yaml')), name=3D'US=
BSerialPort', state=3D<BindingState.bound: 1>, avail=3DTrue, host=3D'ti-lab=
-host', port=3D57479, speed=3D115200, protocol=3D'rfc2217') calling microco=
m -s 115200 -t ti-lab-host:57479
> > connected to 192.168.116.10 (port 57479)
> > Escape character: Ctrl-\
> > Type the escape character to get to the prompt.
> >
> > U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +000=
0)
> > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> > EEPROM not available at 0x50, trying to read at 0x51
> > SPL initial stack usage: 13368 bytes
> > Trying to boot from MMC2
> > Loading Environment from MMC... MMC Device 0 not found
> > *** Warning - No MMC card found, using default environment
> >
> > Starting ATF on ARM64 core...
> >
> > NOTICE:  BL31: v2.10.0(release):v2.10.0-729-gc8be7c08c
> > NOTICE:  BL31: Built : 13:50:07, Apr 24 2024
> > I/TC:
> > I/TC: OP-TEE version: 4.2.0-22-g16fbd46d2 (gcc version 13.2.0 (GCC)) #2=
 Wed Apr 24 19:50:23 UTC 2024 aarch64
> > I/TC: WARNING: This OP-TEE configuration might be insecure!
> > I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/arch=
itecture/porting_guidelines.html
> > I/TC: Primary CPU initializing
> > I/TC: GIC redistributor base address not provided
> > I/TC: Assuming default GIC group status and modifier
> > I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala=
)')
> > I/TC: HUK Initialized
> > I/TC: Activated SA2UL device
> > I/TC: Fixing SA2UL firewall owner for GP device
> > I/TC: Enabled firewalls for SA2UL TRNG device
> > I/TC: SA2UL TRNG initialized
> > I/TC: SA2UL Drivers initialized
> > I/TC: Primary CPU switching to normal world boot
> >
> > U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:31:31 +000=
0)
> > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> > Trying to boot from MMC2
> > ?
> > U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +000=
0)
> > Resetting on cold boot to workaround ErrataID:i2331
> > Please resend tiboot3.bin in case of UART/DFU boot
> > resetting ...
> >
> > U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +000=
0)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > SKIPPED [47] test/py/conftest.py:512: board "am64x_evm_a53" not support=
ed
> > SKIPPED [5] test/py/conftest.py:531: .config feature "cmd_avb" not enab=
led
> > SKIPPED [1] test/py/conftest.py:531: .config feature "optee_ta_avb" not=
 enabled
> > SKIPPED [1] test/py/conftest.py:531: .config feature "cmd_bootstage" no=
t enabled
> > SKIPPED [2] test/py/conftest.py:531: .config feature "bootstage_stash" =
not enabled
> > SKIPPED [1] test/py/tests/test_dfu.py:114: got empty parameter set ['en=
v__usb_dev_port'], function test_dfu at /home/trini/u-boot/u-boot/test/py/t=
ests/test_dfu.py:113
> > SKIPPED [1] test/py/tests/test_efi_fit.py:401: No env__efi_fit_tftp_fil=
e binary specified in environment
> > FAILED test/py/tests/test_efi_selftest.py::test_efi_selftest_watchdog_r=
eboot
> > !!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!!!!!!!!!!!=
!!!!!!!!!
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 failed, 17 pas=
sed, 58 skipped in 58.92s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > I thought it was the escape sequences confusing the check rather than
> > the platform takes longer than expected to provide whatever the expecte=
d
> > string is. Another TI K3 platform gets slightly farther along before
> > failing the same way. I'm going back to looping over Pis to see if they
> > fail in a way that they used to in my previous lab setup.
> >
>
> The relevant error message is:
>
>      E   Exception: Bad pattern found on console: spl_signon
>
> The error occurs because the substring
>
>      U-Boot SPL 2024.10
>
> occurs multiple times during the reboot process. This is not expected in
> wait_for_boot_prompt().
>
> The EFI test is resetting the board and then calling restart_uboot()
> which by itself does another reset.

We had this discussion a while back and I was very-much opposed to
restarting U-Boot within a test. It has set a bad precedent and now
several tests do it.

This is another EFI thing that I would like to resolve at some point.
As previously mentioned, I understand we might be one test to check
that U-Boot does actually kick up a firmware update when started, but
I don't think we should be restarting willy-nilly.

>
> While the watchdog triggered reboot is running thee test environment may
> need some time before triggering a reboot itself. This may lead to the
> observed duplicate output of the U-Boot greeter which is recorded as an
> error.
>
> Maybe we should directly call wait_for_boot_prompt(loop_num =3D 2).
>
>
> diff --git a/test/py/tests/test_efi_selftest.py
> b/test/py/tests/test_efi_selftest.py
> index 43f24245582..c3ee1888afb 100644
> --- a/test/py/tests/test_efi_selftest.py
> +++ b/test/py/tests/test_efi_selftest.py
> @@ -58,7 +58,7 @@ def test_efi_selftest_watchdog_reboot(u_boot_console):
>       u_boot_console.run_command(cmd=3D'bootefi selftest',
> wait_for_prompt=3DFalse)
>       if u_boot_console.p.expect(['resetting', 'U-Boot']):
>           raise Exception('Reset failed in \'watchdog reboot\' test')
> -    u_boot_console.restart_uboot()
> +    u_boot_console.wait_for_boot_prompt(loop_num =3D 2)
>
>   @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
>   def test_efi_selftest_text_input(u_boot_console):
>
> Thanks for bringing the issue to my attention.

Regards,
Simon
