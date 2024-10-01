Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1E8CF3189
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 22:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E170A88CD9;
	Wed,  2 Oct 2024 00:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SeBMrgTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0092B88D15; Wed,  2 Oct 2024 00:18:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AF08897F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 00:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727821125; x=1728425925; i=xypron.glpk@gmx.de;
 bh=c8Q6vwASIbYVS0HGtlnhkR3LyGlr2tD369nrHz06yhA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SeBMrgTjSWkYsfx5uVivNKeJGzjv5iCrreckbLjKpE1H4wl/SBXK6u1772FDbWp6
 Q1cWeB5m3+o1C77O5s12Hd2LESqRCBWenh6oT1C2KYVmFtrD1HyqkcdBkEYCEDHs0
 t3eOIauB2JfvYxIbvvtOmFc0LXAWPXxzeOfAzGu3xm6WoZdpaJIKyTNO4taxz6Dab
 kgmJ4KcEYhfOqZ8DxlFsDyFMqhm728xk4tIw9PE5zx8DEPu24zrmC/J54f88t/4Dy
 L5S7X8X2caMkfPMDAHh81nKZSSkgh117RAi8ESFVGmWF7K8yqiy2rzjf9jntPcb+W
 IaX+qyplgQGVzs7gzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.215]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1sSn073aOd-00QOqv; Wed, 02
 Oct 2024 00:18:44 +0200
Message-ID: <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
Date: Wed, 2 Oct 2024 00:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
 <20241001180235.GH4737@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241001180235.GH4737@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SRKp9tNeAfy/u9q8J7pYGcTxBy+b44AJ6UxtfwQEaOIH++kuQjg
 sS1d04Mqi3W9D9rZiS5y6w/fg0uxSuEKXZ4sflit4dVhL29sZDLBwU7bemrMZtjs5JojqLm
 oAMyhV0cs5eg7ISHO6UUHVrLjPUpghpJD7Xt3DqndfzeY68vqCkoIkfUSYpqreiUh4GZSAl
 WRk+0qO4ONJIDxdkBaDMA==
UI-OutboundReport: notjunk:1;M01:P0:q8bdlqJXKdI=;ai2zPSahRi2K1MUjMPVA2VUA0Rc
 vDkblzRdC4iB+g3nTOrhdYQEopTkHsxYDpEBE7YzUlGxTmwMA96s509FgGNICSXnBnLnFxqnL
 FoVTG8OQSUzNEWzq74qck1k3BVYipD49mnEOpik7ZiC57hicWOn7YKD9bggJdkeAoeGgHBFli
 YFTWUbQh6pfa+FiehGpzhrbIBsoxixQXIAMmCKdR5hFJ/3c/LfNJp4L0l/LuwJcbORpEzAMXB
 Yo8hMU2emE4+VM9KcNjyc1PDENPMgj1lSbWuwZaMDT127IMiCKYI0Rk5YFU+ViKwpTKm9RdnK
 XwXXgh38DEJlPg8lKAB8PvQZXQx3U7hr6Pzp/Lrlxlr/M4yUrWJqC7nCSbZwZvWFxxYvN+bez
 QiNOtK7FbT2Q2SJVSFFLrCZOxO/r1zifT3xtse/33UROtbiRiWhYcd/uUc6olegK6pyIc2PBh
 f5OMh/uYhx+t0lcMW8AJHN0TcX8LC0T89MVIplQCOD9kL9dpH9zKBrOKZNOXg84fIOTsQdOzw
 lB0nVPQVFFMCfLWceWfLjuZeRPRDL5X4o/vTb5L4Lgd6bcRbpsH1umlmODZKt0Zy+V/2RzgZs
 O3ZMar4qmyx16Q53EVSB1oo/7KW6HrtFXyyk5ME2mFUyRxO+qOeRSL2vaKVm3a+N3pzws5t5R
 1U47WzYJpkXuXL8fScDl+uuTdQ4JTUNJtZxo/pgatKG5DWwWczWDpo0yWuQvtWpGT/0uvpTy5
 317EyrjHuXI7VU2PYJOO3u6+eMDH9QNfi52ORznPMZZOPyEondfdxrrUhwPTTAS/Bi5rCVtm+
 7V7FJRW4XM40a6eNrDv9+FYw==
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

On 10/1/24 20:02, Tom Rini wrote:
> On Tue, Oct 01, 2024 at 04:34:54AM +0200, Heinrich Schuchardt wrote:
>> On 10/1/24 02:24, Tom Rini wrote:
>>> On Tue, Oct 01, 2024 at 01:38:56AM +0200, Heinrich Schuchardt wrote:
>>>> On 26.09.24 23:59, Simon Glass wrote:
>>>>> We don't want ANSI characters written in tests since it is a pain to
>>>>> check the output with ut_assert_nextline() et al.
>>>>>
>>>>> Provide a way to tests to request that ANSI characters not be sent.
>>>>>
>>>>> Add a proper function comment while we are here, to encourage others=
.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>
>>>> Please, consider prior review before resubmitting patches.
>>>>
>>>> As responded to all prior submissions:
>>>>
>>>> We want to test the code running on actual machines.
>>>> We don't want to have sandbox code everywhere.
>>>>
>>>> I cannot see any test that is not passing due to the current behavior=
.
>>>
>>> The pytests for the EFI selftests are unreliable for me, on Raspberry =
Pi
>>> 3, more often in 32bit mode than 64bit mode, but I feel like I see it
>>> there too. And when they fail, the console log is full of ANSI escape
>>> sequences. Is this specific test a test you run regularly on real
>>> hardware?
>>>
>>
>> It is not only the EFI test but also pytest adding color to the console
>> output.
>
> Alright, so at least for the problems I have _today_, I've figured it
> out, and the problem is that the watchdog test fails too quickly:
>
> [snip]
> test/py/tests/test_efi_selftest.py ..F
> test/py/u_boot_console_base.p
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> ______________________ test_efi_selftest_watchdog_reboot _______________=
________
> test/py/tests/test_efi_selftest.py:61: in test_efi_selftest_watchdog_reb=
oot
>      u_boot_console.restart_uboot()
> test/py/u_boot_console_base.py:478: in restart_uboot
>      self.ensure_spawned(expect_reset)
> test/py/u_boot_console_base.py:442: in ensure_spawned
>      self.wait_for_boot_prompt(loop_num =3D loop_num)
> test/py/u_boot_console_base.py:195: in wait_for_boot_prompt
>      raise Exception('Bad pattern found on console: ' +
> E   Exception: Bad pattern found on console: spl_signon
> ----------------------------- Captured stdout call ---------------------=
--------
> =3D> setenv efi_selftest list
> =3D> =3D> bootefi selftest
> =1B7=1B[r=1B[999;999H=1B[6n=1B8No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> No EFI system partition
> Failed to persist EFI variables
> No EFI system partition
> Failed to persist EFI variables
>
> Available tests:
> 'block image transfer' - on request
> 'block device'
> 'configuration tables'
> 'controllers'
> 'crc32'
> 'device path'
> 'device path utilities protocol'
> 'conformance profile table'
> 'event groups'
> 'event services'
> 'exception' - on request
> 'ExitBootServices'
> 'device tree'
> 'graphical output'
> 'HII database protocols'
> 'load file protocol'
> 'loaded image'
> 'load image from file'
> 'mem'
> 'memory'
> 'open protocol'
> 'manage protocols'
> 'register protocol notify'
> 'reset system' - on request
> 'reset system runtime' - on request
> 'real time clock'
> 'simple network protocol'
> 'start image return'
> 'start image exit'
> 'text input' - on request
> 'extended text input' - on request
> 'text output'
> 'task priority levels'
> 'unicode collation'
> 'variables'
> 'variables at runtime'
> 'virtual address map'
> 'watchdog timer'
> 'watchdog reboot' - on request
> =3D> =3D> setenv efi_selftest watchdog reboot
> =3D> =3D> bootefi selftest
> =1B[1;37;40m
> Testing EFI API implementation
> =1B[0;37;40m=1B[1;37;40m
> Selected test: 'watchdog reboot'
> =1B[0;37;40m=1B[1;34;40m
> Setting up 'watchdog reboot'
> =1B[0;37;40m=1B[1;32;40mSetting up 'watchdog reboot' succeeded
> =1B[0;37;40m=1B[1;34;40m
> Executing 'watchdog reboot'
> =1B[0;37;40m
> EFI: Watchdog timeout
> resetting ...
> +u-boot-test-reset am64x_evm_a53 na
> Selected role am64-sk from configuration file
> Selected role am64-sk from configuration file
> connecting to NetworkSerialPort(target=3DTarget(name=3D'am64-sk', env=3D=
Environment(config_file=3D'/home/trini/u-boot/lg_env.yaml')), name=3D'USBS=
erialPort', state=3D<BindingState.bound: 1>, avail=3DTrue, host=3D'ti-lab-=
host', port=3D57479, speed=3D115200, protocol=3D'rfc2217') calling microco=
m -s 115200 -t ti-lab-host:57479
> connected to 192.168.116.10 (port 57479)
> Escape character: Ctrl-\
> Type the escape character to get to the prompt.
>
> U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +0000=
)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> EEPROM not available at 0x50, trying to read at 0x51
> SPL initial stack usage: 13368 bytes
> Trying to boot from MMC2
> Loading Environment from MMC... MMC Device 0 not found
> *** Warning - No MMC card found, using default environment
>
> Starting ATF on ARM64 core...
>
> NOTICE:  BL31: v2.10.0(release):v2.10.0-729-gc8be7c08c
> NOTICE:  BL31: Built : 13:50:07, Apr 24 2024
> I/TC:
> I/TC: OP-TEE version: 4.2.0-22-g16fbd46d2 (gcc version 13.2.0 (GCC)) #2 =
Wed Apr 24 19:50:23 UTC 2024 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/archi=
tecture/porting_guidelines.html
> I/TC: Primary CPU initializing
> I/TC: GIC redistributor base address not provided
> I/TC: Assuming default GIC group status and modifier
> I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)=
')
> I/TC: HUK Initialized
> I/TC: Activated SA2UL device
> I/TC: Fixing SA2UL firewall owner for GP device
> I/TC: Enabled firewalls for SA2UL TRNG device
> I/TC: SA2UL TRNG initialized
> I/TC: SA2UL Drivers initialized
> I/TC: Primary CPU switching to normal world boot
>
> U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:31:31 +0000=
)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> Trying to boot from MMC2
> ?
> U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +0000=
)
> Resetting on cold boot to workaround ErrataID:i2331
> Please resend tiboot3.bin in case of UART/DFU boot
> resetting ...
>
> U-Boot SPL 2024.10-rc5-00022-g17da9795c115 (Oct 01 2024 - 14:29:10 +0000=
)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> SKIPPED [47] test/py/conftest.py:512: board "am64x_evm_a53" not supporte=
d
> SKIPPED [5] test/py/conftest.py:531: .config feature "cmd_avb" not enabl=
ed
> SKIPPED [1] test/py/conftest.py:531: .config feature "optee_ta_avb" not =
enabled
> SKIPPED [1] test/py/conftest.py:531: .config feature "cmd_bootstage" not=
 enabled
> SKIPPED [2] test/py/conftest.py:531: .config feature "bootstage_stash" n=
ot enabled
> SKIPPED [1] test/py/tests/test_dfu.py:114: got empty parameter set ['env=
__usb_dev_port'], function test_dfu at /home/trini/u-boot/u-boot/test/py/t=
ests/test_dfu.py:113
> SKIPPED [1] test/py/tests/test_efi_fit.py:401: No env__efi_fit_tftp_file=
 binary specified in environment
> FAILED test/py/tests/test_efi_selftest.py::test_efi_selftest_watchdog_re=
boot
> !!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!!!!!!!!!!!!=
!!!!!!!!
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 failed, 17 pass=
ed, 58 skipped in 58.92s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> I thought it was the escape sequences confusing the check rather than
> the platform takes longer than expected to provide whatever the expected
> string is. Another TI K3 platform gets slightly farther along before
> failing the same way. I'm going back to looping over Pis to see if they
> fail in a way that they used to in my previous lab setup.
>

The relevant error message is:

     E   Exception: Bad pattern found on console: spl_signon

The error occurs because the substring

     U-Boot SPL 2024.10

occurs multiple times during the reboot process. This is not expected in
wait_for_boot_prompt().

The EFI test is resetting the board and then calling restart_uboot()
which by itself does another reset.

While the watchdog triggered reboot is running thee test environment may
need some time before triggering a reboot itself. This may lead to the
observed duplicate output of the U-Boot greeter which is recorded as an
error.

Maybe we should directly call wait_for_boot_prompt(loop_num =3D 2).


diff --git a/test/py/tests/test_efi_selftest.py
b/test/py/tests/test_efi_selftest.py
index 43f24245582..c3ee1888afb 100644
=2D-- a/test/py/tests/test_efi_selftest.py
+++ b/test/py/tests/test_efi_selftest.py
@@ -58,7 +58,7 @@ def test_efi_selftest_watchdog_reboot(u_boot_console):
      u_boot_console.run_command(cmd=3D'bootefi selftest',
wait_for_prompt=3DFalse)
      if u_boot_console.p.expect(['resetting', 'U-Boot']):
          raise Exception('Reset failed in \'watchdog reboot\' test')
-    u_boot_console.restart_uboot()
+    u_boot_console.wait_for_boot_prompt(loop_num =3D 2)

  @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
  def test_efi_selftest_text_input(u_boot_console):

Thanks for bringing the issue to my attention.

Best regards

Heinrich

