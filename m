Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0130CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EF384CE4;
	Sat,  9 May 2026 01:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j97YbvSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED16684DF6; Sat,  9 May 2026 01:37:07 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4139C84CB5
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bc1f0830f44so660627566b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778283425; cv=none;
 d=google.com; s=arc-20240605;
 b=exkQlYHTEJroJuLvG9PfFyRZPXTXkUcCYyqCa4xMOg6LV5BIujUpG5sG8NnEe4gvuC
 1neaNDXHJE8u4PoDnF7eqz77/D3GyFiO0vPKsNr14/mViGeke+xnjujLdif2HikZu0hO
 yWG2Pdrt+qQ6jJY4lkL5isyTWQJ+4iEHU0VAll8gaglyZ+FXZCeSB7LUHWohdr3lrdyB
 3tzEX7JWa4JVmKySARpMGb30MOMb2BfsK19ukq6+Het7u4pskWQ9VfDP2+Tg7PvYD0QS
 rkm6Xnu0X8PEEiVzxVuztGX2jjEoHKMSGqwKDocbN2QqU7FaWHSh+XbAusi3Mv/+9WRb
 l6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k3Lic5jJ+rPBe5vt2vgkLF1T9ZoWpxsZ2Z28UfztWnU=;
 fh=aS5+gFzCC5U8/m+k29r1E0mgtm9g+3h1Bn+q7cc0omo=;
 b=WeWUfeLgcl73WCdUFvJvfv4KIsz1jz3SsKYwfob/fJo0yyH6eoZPrTtQt/DqCJMsT6
 dULyo8Us6aRKshfqlyaacL/cPTDw2IH3MlLRnsZ/llOyiNa9vg99uAK7o16n+bCE5V3n
 4mEKmCGJ3/T9Rh3/8LYaZmoA9CH90TQV14himEqIDnk/IlNTeL21OU+sUuPvimS8AJ43
 //+yg3V3TmuNj4dTXGtmdI2w+fqpNP3ZkW0EqN0/TVzuFm74QW0IRLxhANb92rxzZOWD
 VTtrF62gzcIOGRZsF/H0aTyCXGDxqK0/MZGxvyrAAaBVBZkxQR8d1NyWYT3LXdOs9rDK
 Zy/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778283425; x=1778888225; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3Lic5jJ+rPBe5vt2vgkLF1T9ZoWpxsZ2Z28UfztWnU=;
 b=j97YbvSrdtmvA856t6jADFpW493vuGsL9tUtjzn+Xzp2EJsXLEsumlRqPrewLjkjby
 wYEP7UhkEXUjklOlZdUDlj59IcGdz+f6fRYK9sTDeBdvJTQdzM1tO5KTWTrf2VuLi0yn
 mhqKmfVvmkx6mztz8oDV0Q1VUt6rEkV+L5Nok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778283425; x=1778888225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k3Lic5jJ+rPBe5vt2vgkLF1T9ZoWpxsZ2Z28UfztWnU=;
 b=Mu4dkCuRMBBP3dzUY+FTTKoUSAAScL59rHHBRsgaeMz9ZA2pRtx5oZiqpAEB8Yibli
 N4W2MHZLfoM8Fthg18xoUBcJB+6QkgjVFpzfhV7Eo+/utXC5nzBxN1vVAXe8YyJjhf2N
 qMrUJfFKcKWmOBH3qIe2Try/ibsdkN6pYHNDt9ygU5aUQmnZtW0VWosg7Zs8ZtGDFI9g
 XEdEfK1fW92+ohwzHYsxV/X6yQ5Fuv/FEYld8JWMfryxVpshFYi60mmC2MReBIi/w/Qd
 OD+BfWaXY+E9uScZInmC99QdeGQySj2S+/2XhPXUuTNsWXyzmExIZWcLVvXRL2hHgM8G
 oJqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CZtUMQAzcf48RLxxzkN+2KsxWNJCbwjwkR7/CrIWRM5Wtq+i74Hd67HcMkQx7pM7m8bl8DLY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9ZerupTMlNUBqBWo0OZmy0lOSMd5zO08EL7C/TE3Q+i9DwFbC
 PhDgjB7GSq9JtjM1+6CebiA8KW/8K3fCzZxG5RnIbxubKFopRxF4MuMjQ53xrE2bqaNf63zTi2Q
 ae8JWoZuae6j/lBxiEfKQuGbD69vU86yj4vUYllLT
X-Gm-Gg: Acq92OHAxKPWcM3O5+ZdXbKOFzz+fxFLe6ri0IIXU33UN122Fgr6Ius/jhTzWCrhxMN
 xR+VsKfoqDowqKeESrOG3ukfL0UbCUugYeVFsyuXk5fQQB1ygRxQwM6c84c52KqueJm4cMAhLpT
 HjjHuQOb7+U7UcFkR+odIlw/JVRMuGd8oqINxUg72mxPWMUUCXpTsZXOqIv4Xee/m+F8bReYoyY
 MoI1fXD8ZTs/VYDyzU6glROSL83rdrQsUIOoU2zuQt7zqjS46jp5GcW7JHHkUHAuqlfgFuvndAt
 ICQLQg==
X-Received: by 2002:a17:906:398c:b0:bcb:b757:a8a9 with SMTP id
 a640c23a62f3a-bcbb757a994mr60285366b.12.1778283424516; Fri, 08 May 2026
 16:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154239.1E16368BFE@verein.lst.de>
 <CAFLszTgaG8RV=kWgr7Gu3tkVniq5pNVQ7RSUEv2EMyyQ4ALO6Q@mail.gmail.com>
 <20260508214222.642b15cb@lst.de>
 <CALeDE9NQKk8Cd3bAUqM6Rpf2ZDtTUkRSKnzsG+p7ycCihNvHYA@mail.gmail.com>
In-Reply-To: <CALeDE9NQKk8Cd3bAUqM6Rpf2ZDtTUkRSKnzsG+p7ycCihNvHYA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 17:36:52 -0600
X-Gm-Features: AVHnY4IwaaZI83vLCOqUl0dsP5HoQA-uy9zr8vh-IlDRkSAPMhrPj9bicHoMyBI
Message-ID: <CAFLszTiiq5Gtpn8gxi5U0nE7Uyy2B58E6qFdQ8qrWeXskJEB5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] core: Skip parent device nodes without a DT reference
 when looking for dma-ranges
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Torsten Duwe <duwe@lst.de>, Matthias Brugger <mbrugger@suse.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrea della Porta <andrea.porta@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, u-boot@lists.denx.de
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

Hi Peter,

On Fri, 8 May 2026 at 13:56, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Fri, 8 May 2026 at 20:42, Torsten Duwe <duwe@lst.de> wrote:
> >
> > On Fri, 8 May 2026 12:47:45 -0600
> > Simon Glass <sjg@chromium.org> wrote:
> > [...]
> > > There's already a unit test for device_get_dma_constraints() in
> > > test/dm/read.c (dm_test_dma_ranges). Since you are extending it to
> > > walk past nodes without an ofnode, please can you add a case
> > > exercising the new path - a sandbox device whose immediate parent has
> > > no DT reference should do it.
> >
> > I'll have a look.
> >
> > Talking unit tests, is it just me who experiences reproducible crashes
> > on RPi5 with today's master branch?
>
> Not just you, I saw crashes when I tested rc1 but I've not had time to
> bisect it and see what other platforms are affected.

I just did a bisect and this is the start and end of it:

HEAD is now at 88dc2788777 Prepare v2026.04
=E2=9C=94 ~/u [v2026.04|=E2=9C=94]
17:08 $ ub-smoke rpi5
.
                    [100%]
1 passed in 29.02s
=E2=9C=94 ~/u [v2026.04|=E2=80=A61]
17:08 $ good
You need to start by "git bisect start"

Do you want me to do it for you [Y/n]?
status: waiting for both good and bad commits
status: waiting for bad commit, 1 good commit known
=E2=9C=94 ~/u [v2026.04|BISECTING|=E2=80=A61]
17:09 $ co us/master
Previous HEAD position was 88dc2788777 Prepare v2026.04
HEAD is now at 3cdd19089f1 Merge tag 'mmc-for-2026.07-rc2' of
https://source.denx.de/u-boot/custodians/u-boot-mmc
=E2=9C=94 ~/u [:3cdd19089f1|BISECTING|=E2=80=A61]
17:09 $ ub-smoke rpi5
E
                    [100%]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ERRORS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_______________________________ ERROR at setup of test_uboot_smoke
_______________________________

request =3D <SubRequest 'u_boot' for <Function test_uboot_smoke>>
target =3D Target(name=3D'rpi5',
env=3DEnvironment(config_file=3D'/vid/software/devel/ubtest/lab/cfg/kea_env=
.cfg'),
var_dict=3DNone)
strategy =3D UBootStrategy(target=3DTarget(name=3D'rpi5',
env=3DEnvironment(config_file=3D'/vid/software/devel/ubtest/lab/cfg/kea_env=
.cfg')...covery_reset=3DFalse,
console_needs_power=3DFalse, power_on_before_reset=3DFalse,
power_on_button=3DFalse, power_off_delay=3D0.0)

    @pytest.fixture
    def u_boot(request, target, strategy):
        if request.config.option.lg_use_running_system:
            strategy.uboot.assume_active()
            target.activate(strategy.uboot)
        else:
            try:
>               strategy.transition("uboot")

/vid/software/devel/ubtest/labgrid/contrib/u-boot/conftest.py:26:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _ _ _ _ _ _ _
/vid/software/devel/ubtest/labgrid/labgrid/strategy/ubootstrategy.py:274:
in transition
    self.target.activate(self.uboot)
/vid/software/devel/ubtest/labgrid/labgrid/target.py:554: in activate
    client.on_activate()
/vid/software/devel/ubtest/labgrid/labgrid/driver/ubootdriver.py:69:
in on_activate
    self._await_prompt()
/vid/software/devel/ubtest/labgrid/labgrid/step.py:220: in wrapper
    _result =3D func(*_args, **_kwargs)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _ _ _ _ _ _ _

self =3D UBootDriver(target=3DTarget(name=3D'rpi5',
env=3DEnvironment(config_file=3D'/vid/software/devel/ubtest/lab/cfg/kea_env=
.cfg'),
...x version \\d', boot_command=3D'run bootcmd', boot_commands=3D{},
login_timeout=3D30, boot_timeout=3D30, strip_timestamp=3DFalse)

    @step()
    def _await_prompt(self):
        """Await autoboot line and stop it to get to the prompt, optionally
        enter the password.
        """
        timeout =3D Timeout(float(self.login_timeout))

        # We call console.expect with a short timeout here to detect if the
        # console is idle, which would result in a timeout without any chan=
ges
        # to the before property. So we store the last before value we've s=
een.
        # Because pexpect keeps any read data in it's buffer when a timeout
        # occours, we can't lose any data this way.
        last_before =3D None

        expectations =3D [self.prompt, self.autoboot, self.password_prompt,
                        pattern_u_boot_main_signon, TIMEOUT]
        while True:
            index, before, m, _ =3D self.console.expect(
                expectations,
                timeout=3D2
            )
            if index =3D=3D 0:
                self._status =3D 1
                break

            elif index =3D=3D 1:
                self.console.write(self.interrupt.encode('ASCII'))

            elif index =3D=3D 2:
                if not self.password:
                    raise Exception("Password entry needed but no password =
set")
                self.console.sendline(self.password)

            elif index =3D=3D 3:
                self.version =3D m.group(1).decode('ASCII')
            elif index =3D=3D 4:
                # expect hit a timeout while waiting for a match
                if before =3D=3D last_before:
                    # we did not receive anything during the previous
expect cycle
                    # let's assume the target is idle and we can safely iss=
ue a
                    # newline to check the state
                    self.console.sendline("")

                if timeout.expired:
                    output =3D self.console.read_output(False)
                    for line in output.splitlines():
                        print(line.decode('utf-8', errors=3D'replace'))
>                   raise TIMEOUT(
                        f"Timeout of {self.login_timeout} seconds
exceeded during waiting for login"
                    )
E                   pexpect.exceptions.TIMEOUT: Timeout of 30 seconds
exceeded during waiting for login

/vid/software/devel/ubtest/labgrid/labgrid/driver/ubootdriver.py:205: TIMEO=
UT
------------------------------------- Captured stdout setup
--------------------------------------
Building U-Boot in sourcedir for rpi_arm64
Bootstrapping U-Boot from dir /tmp/b/rpi_arm64
Writing U-Boot using method rpi5

  0.80 RPi: BOOTSYS release VERSION:6fe0b091 DATE: 2024/06/05 TIME: 16:41:4=
9
  0.84 BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=3D1717602109
serial 648a6bdf boardrev b04170 stc 784131
  0.94 AON_RESET: 00000003 PM_RSTS 00001000
  0.01 RP1_BOOT chip ID: 0x20001927
  0.04 PM_RSTS: 0x00001000
  0.04 part 00000000 reset_info 00000000
  0.08 PMIC reset-event 00000000 rtc 00000000 alarm 00000000 enabled 0
  0.14 uSD voltage 3.3V
  0.33 Initialising SDRAM 'Micron' 16Gb x1 total-size: 16 Gbit 4267
  0.36 DDR 4267 0 0 16 152
  2.01 OTP boardrev b04170 bootrom a a
  2.02 Customer key hash
0000000000000000000000000000000000000000000000000000000000000000
  2.09 VC-JTAG unlocked
  2.32 RP1_BOOT chip ID: 0x20001927

  2.37 RP1_BOOT chip ID: 0x20001927
  2.38 RP1_BOOT: fw size 25992
  3.93 PCI2 init
  3.93 PCI2 reset
  3.37 PCIe scan 00001de4:00000001
  3.37 RP1_CHIP_INFO 20001927

  3.40 RPi: BOOTLOADER release VERSION:6fe0b091 DATE: 2024/06/05 TIME: 16:4=
1:49
  3.47 BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=3D1717602109
serial 648a6bdf boardrev b04170 stc 3147335
  3.57 AON_RESET: 00000003 PM_RSTS 00001000
  3.61 PCIEx1: PWR 0 DET_WAKE 0
  3.64 M.2 PCIe HAT not detected.
  3.88 usb_pd_init status 3
  3.88 USB_PD CONFIG 0 41
  3.94 XHCI-STOP
  3.94 xHC0 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
  3.99 USBSTS 1
  3.01 xHC0 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
  3.06 xHC0 ports 3 slots 64 intrs 4
  3.18 XHCI-STOP
  3.18 xHC1 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
  3.23 USBSTS 1
  3.25 xHC1 ver: 272 HCS: 03000440 140000f1 07ff000a HCC: 0240fe6d
  3.30 xHC1 ports 3 slots 64 intrs 4
  3.38 Boot mode: SD (01) order f4
  3.28 USB2[2] 000206e1 connected
  3.78 USB2[2] 00200e03 connected enabled
  3.79 USB2 root HUB port 2 init
  3.85 DEV [01:00] 2.16 000000:02 class 0 VID 090c PID 1000
  3.87 MSD device [01:00] 2.16 000000:02 conf 0 iface 0 ep 82#512 01#512
  3.95 MSD [01:00] 2.16 000000:02 register MSD
  3.52 SD HOST: 200000000 CTL0: 0x00800000 BUS: 400000 Hz actual:
390625 HZ div: 512 (256) status: 0x1fff0000 delay: 276
  3.63 SD HOST: 200000000 CTL0: 0x00800f00 BUS: 400000 Hz actual:
390625 HZ div: 512 (256) status: 0x1fff0000 delay: 276
  3.97 OCR c0ff8000 [39]
CID: 0027504853443332476075149214017b
CSD: 400e00325b590000e6e97f800a400000
  3.05 SD: bus-width: 4 spec: 2 SCR: 0x02858083 0x00000000
  3.13 SD HOST: 200000000 CTL0: 0x00800f04 BUS: 50000000 Hz actual:
50000000 HZ div: 4 (2) status: 0x1fff0000 delay: 2
  3.22 MBR: 0x00000800, 1048576 type: 0x0c
  3.24 MBR: 0x00100800,17020996 type: 0x83
  3.28 MBR: 0x00000000,       0 type: 0x00
  3.32 MBR: 0x00000000,       0 type: 0x00
  3.36 Trying partition: 0
  3.38 type: 32 lba: 2048 'mkfs.fat' ' system-boot' clusters 1032412 (1)
  3.44 rsc 32 fat-sectors 8066 root dir cluster 2 sectors 0 entries 0
  3.51 FAT32 clusters 1032412
  3.57 [sdcard] autoboot.txt not found
  3.58 Select partition rsts 0 C(boot_partition) 0 EEPROM config 0 result 0
  3.65 Trying partition: 0
  3.67 type: 32 lba: 2048 'mkfs.fat' ' system-boot' clusters 1032408 (1)
  3.73 rsc 32 fat-sectors 8066 root dir cluster 2 sectors 0 entries 0
  3.80 FAT32 clusters 1032408
  3.87 Read config.txt bytes     1680 hnd 0x2fc7d
  3.90 [sdcard] pieeprom.upd not found
  3.92 usb_max_current_enable default 0 max-current 3000
  4.08 Read bcm2712-rpi-5-b.dtb bytes    80206 hnd 0x352
  4.11 dt-match: compatible: raspberrypi,5-model-b match: brcm,bcm2712
  4.17 dt-match: compatible: brcm,bcm2712 match: brcm,bcm2712
  4.23 Selecting USB low current limit

NOTICE:  BL31: v2.6(release):v2.6-239-g2a9ede0bd
NOTICE:  BL31: Built : 14:26:57, Jun 22 2023


U-Boot 2026.07-rc1-00169-g3cdd19089f1b (May 08 2026 - 17:09:17 -0600)

DRAM:  2 GiB
RPI 5 Model B (0xb04170)
Core:  24 devices, 11 uclasses, devicetree: board
"Synchronous Abort" handler, esr 0x96000045, far 0x7ffff000
elr: 000000000005d11c lr : 000000000005d0f4 (reloc)
elr: 000000003fba511c lr : 000000003fba50f4
x0 : 000000007ffff000 x1 : 60198ddf6491caa3
x2 : 1fe67ddf6491caa2 x3 : 7ffff00000000001
x4 : 0000000000000080 x5 : 0000000000000007
x6 : 0000000000000000 x7 : 000000003f746420
x8 : 0000000000000002 x9 : 000000003f745d88
x10: 0000000040000000 x11: 0000000000000000
x12: 0000000000001000 x13: 000000003fbece00
x14: 0000000000000001 x15: 0000000000000002
x16: 000000003fb8527c x17: 0000000000000000
x18: 000000003f743d90 x19: 0000000000000001
x20: 000000003f72fde8 x21: 000000003fbe4588
x22: 0000000000000000 x23: 0000000000000000
x24: 0000000000000000 x25: 0000000000000000
x26: 0000000000000000 x27: 0000000000000000
x28: 0000000000000000 x29: 000000003f72fd90

Code: f2e3fcc2 ca020061 eb02007f 9a9f1421 (a9000413)
Resetting CPU ...

resetting ...

(lots of error output here)

ERROR ../../../../../../../../vid/software/devel/ubtest/labgrid/contrib/u-b=
oot/test_smoke.py::test_uboot_smoke
- pexpect.exceptions.TIMEOUT: Timeout of 30 seconds exceeded during
waiting for login
1 error in 45.25s
=E2=9C=98-1 ~/u [:3cdd19089f1|BISECTING|=E2=80=A61]
17:09 $ pe
3cdd19089f1 (HEAD, us/master, us/WIP/06May2026, pw-503347-review)
Merge tag 'mmc-for-2026.07-rc2' of
https://source.denx.de/u-boot/custodians/u-boot-mmc
e08877916e2 Merge tag 'mips-fixes-for-v2026.07' of
https://source.denx.de/u-boot/custodians/u-boot-mips
8399b039b03 Merge tag 'efi-2026-07-rc2-2' of
https://source.denx.de/u-boot/custodians/u-boot-efi
980f8a45896 Merge tag 'net-20260506' of
https://source.denx.de/u-boot/custodians/u-boot-net
ffdce9d3fbd Merge tag 'fsl-qoriq-for-2026.07-rc2' of
https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq
de79075f0f6 mips: mtmips: align MT7621 image blobs to 8-byte boundary
5245bdc98b9 net: phy: mscc: add support for the VSC8572
9717831e293 net: macb: add gigabit implementation for fixed-link
d7fe1f4333a net: macb: do not set user_io when it does not exist
361bb8f827b net: macb: use SA1 for MAC filtering on GEM
=E2=9C=94 ~/u [:3cdd19089f1|BISECTING|=E2=80=A61]
17:10 $ bad
Bisecting: 580 revisions left to test after this (roughly 9 steps)
[6e30330d7ac1b708772b1f5c2afae4bbec7c9678] net: dwc_eth_xgmac: Move
DMA reset and pad calibration after PHY init
=E2=9C=94 ~/u [:6e30330d7ac|BISECTING|=E2=80=A61]
17:10 $ ub-bisect rpi5
Starting bisect on target rpi5 - cherry-pick commit:
running '_ub-bisect-try'
Revision 6e30330d7ac1b708772b1f5c2afae4bbec7c9678, target rpi5
E


CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.15 [sdcard]
autoboot.txt not found=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.16 Select
partition rsts 0 C(boot_partition) 0 EEPROM config 0 result 0=E2=90=8D=E2=
=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.23 Trying partition: 0=
=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.25 type: 32 lba:
2048 'mkfs.fat' ' system-boot' clusters 1032408 (1)=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.32 rsc 32
fat-sectors 8066 root dir cluster 2 sectors 0 entries 0=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.38 FAT32 clusters 1032=
408=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.45 Read
config.txt bytes     1680 hnd 0x2fc7d=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.48 [sdcard]
pieeprom.upd not found=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.50
usb_max_current_enable default 0 max-current 3000=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.64 Read
bcm2712-rpi-5-b.dtb bytes    80206 hnd 0x352=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.66 dt-match:
compatible: raspberrypi,5-model-b match: brcm,bcm2712=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.72 dt-match:
compatible: brcm,bcm2712 match: brcm,bcm2712=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) <   3.79 Selecting USB
low current limit=E2=90=8D=E2=90=A4
CONSOLE SerialLogger.rp:    SerialDriver(rpi5) < =E2=90=8D=E2=90=A4
INFO         StepLogger:   =E2=86=90 SerialDriver.expect() result=3D(4,
b'\r\n\r\nDRAM:  2 GiB\r\nRPI 5 Model B (0xb04170)\r\nCore:  24
devices, 11 uclasses, devicetree=E2=80=A6 [2.000s]
INFO         StepLogger:   =E2=86=92 SerialDriver.expect(pattern=3D['U-Boot=
>',
'stop autoboot', 'enter Password:', re.compile(b'(U-Boot( Concept)?
\\d{4}\\.\\d{2}[^\r\n]*\\))'), <class 'pexpect.exceptions.TIMEOUT'>])
INFO         StepLogger:   =E2=86=90 SerialDriver.expect() result=3D(4,
b'\r\n\r\nDRAM:  2 GiB\r\nRPI 5 Model B (0xb04170)\r\nCore:  24
devices, 11 uclasses, devicetree=E2=80=A6 [2.000s]
CONSOLE SerialLogger.rp:   SerialDriver(rpi5) > =E2=90=A4=E2=90=8D=E2=90=A4
INFO         StepLogger:   =E2=86=92 SerialDriver.expect(pattern=3D['U-Boot=
>',
'stop autoboot', 'enter Password:', re.compile(b'(U-Boot( Concept)?
\\d{4}\\.\\d{2}[^\r\n]*\\))'), <class 'pexpect.exceptions.TIMEOUT'>])
INFO         StepLogger:   =E2=86=90 SerialDriver.expect() result=3D(4,
b'\r\n\r\nDRAM:  2 GiB\r\nRPI 5 Model B (0xb04170)\r\nCore:  24
devices, 11 uclasses, devicetree=E2=80=A6 [2.000s]
CONSOLE SerialLogger.rp:   SerialDriver(rpi5) > =E2=90=A4=E2=90=8D=E2=90=A4
INFO         StepLogger:  =E2=9A=A0 UBootDriver._await_prompt() [30.715s]
exception=3DTimeout of 30 seconds exceeded during waiting for login
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR test_smoke.py::test_uboot_smoke - pexpect.exceptions.TIMEOUT:
Timeout of 30 seconds exceeded during waiting for login
1 error in 42.37s
a3075db94d49f415658bf7e961e1eae90d9abc33 is the first bad commit
commit a3075db94d49f415658bf7e961e1eae90d9abc33
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date:   Wed Jan 28 00:48:40 2026 +0100

    lmb: Reinstate access to memory above ram_top

    Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top"=
)
    and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even =
from
    same bank"). These are based on incorrect premise of the first commit, =
that
    "U-Boot does not use memory above ram_top". While U-Boot itself indeed =
does
    not and should not use memory above ram_top, user can perfectly well us=
e
    that memory from the U-Boot shell, for example to load content in there=
.

    Currently, attempt to use that memory to load large image using TFTP en=
ds
    with "TFTP error: trying to overwrite reserved memory...". With this ch=
ange
    in place, the memory can be used again.

    Fixes: eb052cbb896f ("lmb: add and reserve memory above ram_top")
    Fixes: 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even
from same bank")
    Reported-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
    Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

 lib/lmb.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)
bisect found first bad commit
=E2=9C=94 ~/u [:a3075db94d4|BISECTING|=E2=80=A61]
17:16 $

Actually I recently sent an email about this patch recently but I
forgot to cc you.

Regards,
Simon
