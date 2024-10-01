Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119DECEACEE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD6D89215;
	Tue,  1 Oct 2024 20:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bdFNeUqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A2989215; Tue,  1 Oct 2024 20:02:42 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1BA891E9
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb22e9c6dbso32100266d6.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727805759; x=1728410559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GDuXzHahzJYS5+jl8EJ4FexFsbhjh+6OlaC1CDvRUwc=;
 b=bdFNeUqUA7e3vGKBWefZTBZMJeCOCNEDrYbXfAsx0f2W3O62F7jYfAr7DwhyIpMVd1
 9fHBXrVa36JpBTOZL6pgo8/R+6gOYbDl2EHn3/yTOjjopQow5khWXDaS0E4arB2i6Diq
 WGgXQ2NDIUW1zP4Pbo5ZO3mONWdBbUoZgQ4ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727805759; x=1728410559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDuXzHahzJYS5+jl8EJ4FexFsbhjh+6OlaC1CDvRUwc=;
 b=YYpH+6bPWlt0fkQRDPJKymgGiXZILCXNG1SycPHcsbXPR4g6SreXhSzayClwsqcVt1
 hPQphD9pXZSPVyJvORCESOKCgalCL4Vb+CfM9WmVA9dIKOxxW9DVMTn539i8GcpinYJn
 xt5Sr7b1UK20KkjthLaf591tZGd/spBATfGcTE9X09QNj0WQcsU/Ie9f1aOTMYVtrgWI
 6aDXR0PDZ2SVWm6EFCRZ1JVrNP3B8LEq0CyPWOLUooYlMPQUQCOGHUXVoqGpskt+dAmK
 oULFxzEZYfeUVk8tdHdBIsQ1Z5vNbHTmMWSaRT8ezEyWRuMwinl8spTEJcqOlz/2jQcj
 cenA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZjklJKdfBsnDnLoYCIH2OmssPwL2PrD9w5S+L9R3guzJbdqcWmKVSgraWEEMx2sORwb/eKwo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5mdFy3k47tUD1quRHQZp6wZR5hJ3zOk8HL6vjVIzGIFyOdkU/
 xRIZRU0oklq9n0Opu/mV4DwfAUOLCAcTuCSW2hKZTDAcbR2gciP/5sWsF/9VkFE=
X-Google-Smtp-Source: AGHT+IHYJrswkeBXilfAsNPVqtJ9+tN+BKg/SFC/cz528OeFho0Iiu5kLIkczpOBpf8oZJSSJmnv8w==
X-Received: by 2002:a05:6214:398d:b0:6c1:6e3a:6d17 with SMTP id
 6a1803df08f44-6cb819c0522mr4571776d6.6.1727805758518; 
 Tue, 01 Oct 2024 11:02:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b691972sm51932786d6.146.2024.10.01.11.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 11:02:37 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:02:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Message-ID: <20241001180235.GH4737@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nc7F3hfrPwcrbyV4"
Content-Disposition: inline
In-Reply-To: <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
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


--Nc7F3hfrPwcrbyV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 04:34:54AM +0200, Heinrich Schuchardt wrote:
> On 10/1/24 02:24, Tom Rini wrote:
> > On Tue, Oct 01, 2024 at 01:38:56AM +0200, Heinrich Schuchardt wrote:
> > > On 26.09.24 23:59, Simon Glass wrote:
> > > > We don't want ANSI characters written in tests since it is a pain to
> > > > check the output with ut_assert_nextline() et al.
> > > >=20
> > > > Provide a way to tests to request that ANSI characters not be sent.
> > > >=20
> > > > Add a proper function comment while we are here, to encourage other=
s.
> > > >=20
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >=20
> > > Please, consider prior review before resubmitting patches.
> > >=20
> > > As responded to all prior submissions:
> > >=20
> > > We want to test the code running on actual machines.
> > > We don't want to have sandbox code everywhere.
> > >=20
> > > I cannot see any test that is not passing due to the current behavior.
> >=20
> > The pytests for the EFI selftests are unreliable for me, on Raspberry Pi
> > 3, more often in 32bit mode than 64bit mode, but I feel like I see it
> > there too. And when they fail, the console log is full of ANSI escape
> > sequences. Is this specific test a test you run regularly on real
> > hardware?
> >=20
>=20
> It is not only the EFI test but also pytest adding color to the console
> output.

Alright, so at least for the problems I have _today_, I've figured it
out, and the problem is that the watchdog test fails too quickly:

[snip]
test/py/tests/test_efi_selftest.py ..F

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
______________________ test_efi_selftest_watchdog_reboot __________________=
_____
test/py/tests/test_efi_selftest.py:61: in test_efi_selftest_watchdog_reboot
    u_boot_console.restart_uboot()
test/py/u_boot_console_base.py:478: in restart_uboot
    self.ensure_spawned(expect_reset)
test/py/u_boot_console_base.py:442: in ensure_spawned
    self.wait_for_boot_prompt(loop_num =3D loop_num)
test/py/u_boot_console_base.py:195: in wait_for_boot_prompt
    raise Exception('Bad pattern found on console: ' +
E   Exception: Bad pattern found on console: spl_signon
----------------------------- Captured stdout call ------------------------=
-----
=3D> setenv efi_selftest list=0D
=3D> =3D> bootefi selftest=0D
=1B7=1B[r=1B[999;999H=1B[6n=1B8No EFI system partition=0D
No EFI system partition=0D
Failed to persist EFI variables=0D
No EFI system partition=0D
Failed to persist EFI variables=0D
No EFI system partition=0D
Failed to persist EFI variables=0D
=0D
Available tests:=0D
'block image transfer' - on request=0D
'block device'=0D
'configuration tables'=0D
'controllers'=0D
'crc32'=0D
'device path'=0D
'device path utilities protocol'=0D
'conformance profile table'=0D
'event groups'=0D
'event services'=0D
'exception' - on request=0D
'ExitBootServices'=0D
'device tree'=0D
'graphical output'=0D
'HII database protocols'=0D
'load file protocol'=0D
'loaded image'=0D
'load image from file'=0D
'mem'=0D
'memory'=0D
'open protocol'=0D
'manage protocols'=0D
'register protocol notify'=0D
'reset system' - on request=0D
'reset system runtime' - on request=0D
'real time clock'=0D
'simple network protocol'=0D
'start image return'=0D
'start image exit'=0D
'text input' - on request=0D
'extended text input' - on request=0D
'text output'=0D
'task priority levels'=0D
'unicode collation'=0D
'variables'=0D
'variables at runtime'=0D
'virtual address map'=0D
'watchdog timer'=0D
'watchdog reboot' - on request=0D
=3D> =3D> setenv efi_selftest watchdog reboot=0D
=3D> =3D> bootefi selftest=0D
=1B[1;37;40m=0D
Testing EFI API implementation=0D
=1B[0;37;40m=1B[1;37;40m=0D
Selected test: 'watchdog reboot'=0D
=1B[0;37;40m=1B[1;34;40m=0D
Setting up 'watchdog reboot'=0D
=1B[0;37;40m=1B[1;32;40mSetting up 'watchdog reboot' succeeded=0D
=1B[0;37;40m=1B[1;34;40m=0D
Executing 'watchdog reboot'=0D
=1B[0;37;40m=0D
EFI: Watchdog timeout=0D
resetting ...=0D
+u-boot-test-reset am64x_evm_a53 na
Selected role am64-sk from configuration file
Selected role am64-sk from configuration file
connecting to NetworkSerialPort(target=3DTarget(name=3D'am64-sk', env=3DEnv=
ironment(config_file=3D'/home/trini/u-boot/lg_env.yaml')), name=3D'USBSeria=
lPort', state=3D<BindingState.bound: 1>, avail=3DTrue, host=3D'ti-lab-host'=
, port=3D57479, speed=3D115200, protocol=3D'rfc2217') calling microcom -s 1=
15200 -t ti-lab-host:57479
connected to 192.168.116.10 (port 57479)
Escape character: Ctrl-\
Type the escape character to get to the prompt.
=0D
U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +0000)=0D
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')=0D
EEPROM not available at 0x50, trying to read at 0x51=0D
SPL initial stack usage: 13368 bytes=0D
Trying to boot from MMC2=0D
Loading Environment from MMC... MMC Device 0 not found=0D
*** Warning - No MMC card found, using default environment=0D
=0D
Starting ATF on ARM64 core...=0D
=0D
NOTICE:  BL31: v2.10.0(release):v2.10.0-729-gc8be7c08c=0D
NOTICE:  BL31: Built : 13:50:07, Apr 24 2024=0D
I/TC: =0D
I/TC: OP-TEE version: 4.2.0-22-g16fbd46d2 (gcc version 13.2.0 (GCC)) #2 Wed=
 Apr 24 19:50:23 UTC 2024 aarch64=0D
I/TC: WARNING: This OP-TEE configuration might be insecure!=0D
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architec=
ture/porting_guidelines.html=0D
I/TC: Primary CPU initializing=0D
I/TC: GIC redistributor base address not provided=0D
I/TC: Assuming default GIC group status and modifier=0D
I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')=
=0D
I/TC: HUK Initialized=0D
I/TC: Activated SA2UL device=0D
I/TC: Fixing SA2UL firewall owner for GP device=0D
I/TC: Enabled firewalls for SA2UL TRNG device=0D
I/TC: SA2UL TRNG initialized=0D
I/TC: SA2UL Drivers initialized=0D
I/TC: Primary CPU switching to normal world boot=0D
=0D
U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:31:31 +0000)=0D
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')=0D
Trying to boot from MMC2=0D
=00?=0D
U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +0000)=0D
Resetting on cold boot to workaround ErrataID:i2331=0D
Please resend tiboot3.bin in case of UART/DFU boot=0D
resetting ...=0D
=0D
U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +0000)=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
SKIPPED [47] test/py/conftest.py:512: board "am64x_evm_a53" not supported
SKIPPED [5] test/py/conftest.py:531: .config feature "cmd_avb" not enabled
SKIPPED [1] test/py/conftest.py:531: .config feature "optee_ta_avb" not ena=
bled
SKIPPED [1] test/py/conftest.py:531: .config feature "cmd_bootstage" not en=
abled
SKIPPED [2] test/py/conftest.py:531: .config feature "bootstage_stash" not =
enabled
SKIPPED [1] test/py/tests/test_dfu.py:114: got empty parameter set ['env__u=
sb_dev_port'], function test_dfu at /home/trini/u-boot/u-boot/test/py/tests=
/test_dfu.py:113
SKIPPED [1] test/py/tests/test_efi_fit.py:401: No env__efi_fit_tftp_file bi=
nary specified in environment
FAILED test/py/tests/test_efi_selftest.py::test_efi_selftest_watchdog_reboot
!!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!!!!!!!!!!!!!!!=
!!!!!
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 failed, 17 passed,=
 58 skipped in 58.92s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

I thought it was the escape sequences confusing the check rather than
the platform takes longer than expected to provide whatever the expected
string is. Another TI K3 platform gets slightly farther along before
failing the same way. I'm going back to looping over Pis to see if they
fail in a way that they used to in my previous lab setup.

--=20
Tom

--Nc7F3hfrPwcrbyV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8OTcACgkQFHw5/5Y0
tyw8dAwAjKyU2+UtMY0E1RW9wivaXHDXLZbGrhYryox6Cif7+nsSD7OtJJ6beRTq
ZIaGy0+oIkbMFovBXqEmEJlCl+pxLWmyscW+ft7ITN7gWCL6kA+kc4VcFFv/mUXs
QSzBcWgKLfJhPrNqXhU/UMkvNllKWJ1dM/NXAyqFjXIQFeh/8SYsCkJsfyovlF27
Ce2QEkhlL4LuxdM5/4SjVgnfgB/aCA4H6xuacbPuSV1McLLM2/XJYdOq0qHWAs7V
Sbzjg+m6LOUEa5V1jwW1uzHWZhyWs+Sg9s52DXeSD3Hcy/kYZYo4crXLc54Gp885
q4aedfA8NIH/VBmi57JoeTiWaCw32VMazf7ysOIWN1VxOJol0WWSTPVumWVHYpdP
7xqfgX2pL9603Ow5DLC+klPDqX9V4LnA8u/dkzzK5XALPgwGCHS55gnNxoAlikb+
Tjs3/XVbBL0NsDwoZp9NmOzt7ZepggcLWNiCo//1GFeFMz5i2iLJF1+5sIjj8r2p
ZKgTZTQg
=5VGy
-----END PGP SIGNATURE-----

--Nc7F3hfrPwcrbyV4--
