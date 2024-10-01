Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D894BCF318A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 23:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E6088ED5;
	Wed,  2 Oct 2024 01:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S5MLa+qp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011B688E58; Wed,  2 Oct 2024 01:14:27 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD24388EAA
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 01:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a99de9beb2so378361985a.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727824459; x=1728429259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wRo6ZBuezVKmdlSrCKS3MKGETn+wMipFoWHHZff7RBc=;
 b=S5MLa+qp+QB/8VCXx+Gjs2sUJSksMQh9MXbNDV0yBE38aC9xL88ElKHrnMSi0vuV+A
 S/4GYLRGsUSR4TF8aOh1VvXZUEiuxl3pD92/+aIoZbgW2RQqueGazlN8w+btJ4i/RZMH
 HOFV1UeF6Ko3m7u0ZefjCXMQfuMzht9DboNpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727824459; x=1728429259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRo6ZBuezVKmdlSrCKS3MKGETn+wMipFoWHHZff7RBc=;
 b=aa2/zgA73+Ospel4wrUa09IKaLPEoOrJV9OGjwIkMfwJ9+g8nsktfxIC6W8tw2wxWk
 MjyaQJM9kJ5i9Ugag0TVddEE1uAi1PJMzmzOk/veVg/nbQ88rRM3OrcbBAM19gVayfhr
 /jjD1vqoIGC1nqg1ETOeR5REl/Vut5IwBajPdDQEW1cmY20AbFHMpYAy5JS0qdIh7au8
 EACZldEX+Zzn6ulK4qQ5YoTZWP/cr6j5G3d8Z9mtdfjahhrjr3kCGlvcXc2YkGrcpE0a
 KzraZQ30LzM0Z+ie0RtMGhvQO6EaJkwICQQYCsDfkP7V7Q3jVshfqW7KlJUL0sZMGDuz
 XLkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4GRSJdXI/w9gKEew3jA4xMtteB/wHzUExaauFrPTISJM6Jq9lbLtWaZhF1ym2vcfzVoEuyDU=@lists.denx.de
X-Gm-Message-State: AOJu0YyV16XD/eejxrITxcPEkyZHlvzIo/B7tdLobL/Wc8fAHVL+XhWE
 loaOF9Hn9S6kFMWQpH/kz7POvnelKgXblJi5mq+NSHb0JRoUTb0B5DcsGlmvuXM=
X-Google-Smtp-Source: AGHT+IF5DkruRsB/EHBpiAAtk2qkY9oJRGK9T06UhfjVosBM/KewymoEhvBlJPCQVMBtiRGnqHTxnQ==
X-Received: by 2002:a05:620a:2906:b0:7a9:af25:804d with SMTP id
 af79cd13be357-7ae626ad82cmr184784785a.6.1727824459395; 
 Tue, 01 Oct 2024 16:14:19 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b5fff6bsm54822576d6.2.2024.10.01.16.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 16:14:17 -0700 (PDT)
Date: Tue, 1 Oct 2024 17:14:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Message-ID: <20241001231415.GN4737@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
 <20241001180235.GH4737@bill-the-cat>
 <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aP6D7JZRbowoGZT0"
Content-Disposition: inline
In-Reply-To: <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
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


--aP6D7JZRbowoGZT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 12:18:39AM +0200, Heinrich Schuchardt wrote:
> On 10/1/24 20:02, Tom Rini wrote:
> > On Tue, Oct 01, 2024 at 04:34:54AM +0200, Heinrich Schuchardt wrote:
> > > On 10/1/24 02:24, Tom Rini wrote:
> > > > On Tue, Oct 01, 2024 at 01:38:56AM +0200, Heinrich Schuchardt wrote:
> > > > > On 26.09.24 23:59, Simon Glass wrote:
> > > > > > We don't want ANSI characters written in tests since it is a pa=
in to
> > > > > > check the output with ut_assert_nextline() et al.
> > > > > >=20
> > > > > > Provide a way to tests to request that ANSI characters not be s=
ent.
> > > > > >=20
> > > > > > Add a proper function comment while we are here, to encourage o=
thers.
> > > > > >=20
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >=20
> > > > > Please, consider prior review before resubmitting patches.
> > > > >=20
> > > > > As responded to all prior submissions:
> > > > >=20
> > > > > We want to test the code running on actual machines.
> > > > > We don't want to have sandbox code everywhere.
> > > > >=20
> > > > > I cannot see any test that is not passing due to the current beha=
vior.
> > > >=20
> > > > The pytests for the EFI selftests are unreliable for me, on Raspber=
ry Pi
> > > > 3, more often in 32bit mode than 64bit mode, but I feel like I see =
it
> > > > there too. And when they fail, the console log is full of ANSI esca=
pe
> > > > sequences. Is this specific test a test you run regularly on real
> > > > hardware?
> > > >=20
> > >=20
> > > It is not only the EFI test but also pytest adding color to the conso=
le
> > > output.
> >=20
> > Alright, so at least for the problems I have _today_, I've figured it
> > out, and the problem is that the watchdog test fails too quickly:
> >=20
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
> > =1B7=1B[r=1B[999;999H=1B[6n=1B8No EFI system partition
> > No EFI system partition
> > Failed to persist EFI variables
> > No EFI system partition
> > Failed to persist EFI variables
> > No EFI system partition
> > Failed to persist EFI variables
> >=20
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
> > =1B[1;37;40m
> > Testing EFI API implementation
> > =1B[0;37;40m=1B[1;37;40m
> > Selected test: 'watchdog reboot'
> > =1B[0;37;40m=1B[1;34;40m
> > Setting up 'watchdog reboot'
> > =1B[0;37;40m=1B[1;32;40mSetting up 'watchdog reboot' succeeded
> > =1B[0;37;40m=1B[1;34;40m
> > Executing 'watchdog reboot'
> > =1B[0;37;40m
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
> >=20
> > U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +000=
0)
> > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> > EEPROM not available at 0x50, trying to read at 0x51
> > SPL initial stack usage: 13368 bytes
> > Trying to boot from MMC2
> > Loading Environment from MMC... MMC Device 0 not found
> > *** Warning - No MMC card found, using default environment
> >=20
> > Starting ATF on ARM64 core...
> >=20
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
> >=20
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
> >=20
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
> >=20
> > I thought it was the escape sequences confusing the check rather than
> > the platform takes longer than expected to provide whatever the expected
> > string is. Another TI K3 platform gets slightly farther along before
> > failing the same way. I'm going back to looping over Pis to see if they
> > fail in a way that they used to in my previous lab setup.
> >=20
>=20
> The relevant error message is:
>=20
>     E   Exception: Bad pattern found on console: spl_signon
>=20
> The error occurs because the substring
>=20
>     U-Boot SPL 2024.10
>=20
> occurs multiple times during the reboot process. This is not expected in
> wait_for_boot_prompt().
>=20
> The EFI test is resetting the board and then calling restart_uboot()
> which by itself does another reset.
>=20
> While the watchdog triggered reboot is running thee test environment may
> need some time before triggering a reboot itself. This may lead to the
> observed duplicate output of the U-Boot greeter which is recorded as an
> error.
>=20
> Maybe we should directly call wait_for_boot_prompt(loop_num =3D 2).
>=20
>=20
> diff --git a/test/py/tests/test_efi_selftest.py
> b/test/py/tests/test_efi_selftest.py
> index 43f24245582..c3ee1888afb 100644
> --- a/test/py/tests/test_efi_selftest.py
> +++ b/test/py/tests/test_efi_selftest.py
> @@ -58,7 +58,7 @@ def test_efi_selftest_watchdog_reboot(u_boot_console):
>      u_boot_console.run_command(cmd=3D'bootefi selftest',
> wait_for_prompt=3DFalse)
>      if u_boot_console.p.expect(['resetting', 'U-Boot']):
>          raise Exception('Reset failed in \'watchdog reboot\' test')
> -    u_boot_console.restart_uboot()
> +    u_boot_console.wait_for_boot_prompt(loop_num =3D 2)
>=20
>  @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
>  def test_efi_selftest_text_input(u_boot_console):
>=20
> Thanks for bringing the issue to my attention.

Thanks for digging in to this more. I suspect (and I'll try and confirm
soon) that we need to take in to account:
commit 645f75f6884a22905b0e3790ca9254fa1a13216e
Author: Tom Rini <trini@konsulko.com>
Date:   Wed Apr 24 16:45:37 2024 -0600

    test/py: Make the number of SPL banners seen a variable
   =20
    Currently we have the option to tell the console code that we should
    ignore the SPL banner. We also have an option to say that we can see it
    a second time, and ignore it. However, some platforms such as TI AM64x
    will have us see the SPL banner three times. Rather than add an
    "spl3_skipped" option, rework the code. By default we expect to see the
    banner once, but boards can specify seeing it as many times as they
    expect to.
   =20
    Signed-off-by: Tom Rini <trini@konsulko.com>

as well in this area.
>=20
> Best regards
>=20
> Heinrich
>=20

--=20
Tom

--aP6D7JZRbowoGZT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8gkMACgkQFHw5/5Y0
tyws5Qv7BE2nmaTuxPCp98/2lZ2PBpVrFaHJ3J6x5a04r1uSlKNaXkBFDdTKAk5Z
i1TuU/Xq6LR980iWAnJy7cqqSSyvnnU7K40UPzz8vFkOQEPDM89gWoxaA6B5W+c7
wPQurmZpAuu4+XIO6piMO8muqGC2npliaV6gWLs02wcb2mvYUmwPkY/gmeAy0mYc
KIRZnm3ULx45DbvFCKkdtUoHK4GUBnoLkb8ya6083+bVGOIfIsRVWi3ZlP5PZB2P
iNYQGGw3YmHrIGHUQTrogVsF2qIFenmypID0/c0hLs7pHoh6nQn9kQdmrZh8IjS8
t/4TE1m2EUDfMSiNWvcvZQ+KVEckVL0O0vHKEF+9UFNuAlh4qvPWGQB0MMy6XTyF
CFV7opT70o1LTa25H3+8XCe7tD5DuQuASg5rAkA7bKQM/VxV026rl7Nlxt08no3Y
v+AZMWwNGWYSU54B7l+ihAC+bRxM0eUCCaUzPcrW07x6gWhliBQCxJDlyqMBMTf7
SVmFOXZ2
=6Plb
-----END PGP SIGNATURE-----

--aP6D7JZRbowoGZT0--
