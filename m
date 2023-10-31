Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265C4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 19:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2755C86F86;
	Tue, 31 Oct 2023 20:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B1hQwypv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23C687009; Tue, 31 Oct 2023 20:26:52 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE2B86F86
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 20:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso33748866b.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698780410; x=1699385210; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCTiY1Vacsag8RDbQH1wHGgm2pbXqRX89noUrLsqoDU=;
 b=B1hQwypvxXWUrWWHao6hHNvln9y/wRmqgt2oJK+ivHIdsY2xfqNB1Re2e5tqf5kI1L
 ti3HYRD5AAK3kG51/GG+UrqmWsplp8vvSvIvfuOsDq9KCDm5UYAaaXFJEq0LmHwtP5F8
 hh3ZvEwYSJKEbIbZeocflXfImYlM4MNUgEt1VQK1LsWhmPkaVCZ63hfcxCtir/6B0uwA
 zjKJMXgAyfgarfb/NHz3GqO7TkE1ApXcbThtNETlk1GWvAY/LIEBHUMsubPOsdWqjxIN
 mQUWz4mgmtqSRQFTFBI8HkZO+60YXzrHN0V0OHhpzgfuvVRr8yJiq1Hjh3txhoJU0m7d
 buOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698780410; x=1699385210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCTiY1Vacsag8RDbQH1wHGgm2pbXqRX89noUrLsqoDU=;
 b=O2c8HPZHdQFGwFNgav1MJ3Fwvb5TdOgEHTSyhoO3/OrM8/LUPiRzIk5nzsoAj2OzRM
 EQIbinnfvlRngfcJzpY+lGmRWHSPh4om5KBzsbY/XwleJljRqz19yNOlEfZdVQjAxNR7
 aF1LnT0q8r6oCWg1ehcFZOPKP0iE4Ubw/yJj71BrkL3QEaz5ekfdYEeywCGPenBtvuAU
 2efg0bUuTMwpe0d2syLUT78m4PTIDBNbCorau5iVgUa7RTyRE4a0pgKg/nbnLPFORCaU
 Zen8PzIKuQjqxmZHmOoBP1GiTaDvh1CxGJS5JPO9kopixNLI/9TtFdy4xvfFxwFxFMb7
 PspA==
X-Gm-Message-State: AOJu0YwxWXop3p/YMYOQE2huPw8Lrp4esjJlg8Z/AEzk69/k5eEnk4g3
 zVy76MYSECwoaAiCAe0N9H4r4hd1wCzNAMa0QX0=
X-Google-Smtp-Source: AGHT+IHcHuSVWJZknqlBkyLSoVVnmMfyhViUGaR8JHOUPrvnd+4+0+AlDwOjVRXe/oetq/+bIveONmQjc2UojxKHRT4=
X-Received: by 2002:a17:906:cb97:b0:9b8:df8e:cbd0 with SMTP id
 mf23-20020a170906cb9700b009b8df8ecbd0mr238739ejb.37.1698780410176; Tue, 31
 Oct 2023 12:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231030194650.11594-1-mibodhi@gmail.com>
In-Reply-To: <20231030194650.11594-1-mibodhi@gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 31 Oct 2023 12:26:38 -0700
Message-ID: <CAJaLiFz3gcT5bA8q2f5h8tqSDeMKhQQkg-Z5KdQAmATmA0EKRg@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Skip over bad device during bootflows scanning
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>
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

Hi Simon,

On Mon, Oct 30, 2023 at 12:47=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrot=
e:
>
> During scanning for the next bootdev, if bootdev_next_prio() encounters
> a device error (e.g. ENOSYS), let it continue scanning the next devices,
> not stopping prematurely.
>
> Background:
>
> During scanning for bootflows, it's possible for bootstd to encounter a
> faulty device controller. Also when the same u-boot is used for another
> variant of the same board, some device controller such as SATA might
> not exist.
>
> I've found this issue while converting the Marvell Sheevaplug board to
> use bootstd. This board has 2 variants, the original Sheevaplug has MMC a=
nd
> USB only, but the later variant comes with USB, MMC, and eSATA ports. We
> have been using the same u-boot (starting with CONFIG_IDE and later with =
DM
> CONFIG_SATA) for both variants. This worked well with the old
> envs-scripting booting scheme.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  boot/bootdev-uclass.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> index 44ae98a926..b1d48e5b69 100644
> --- a/boot/bootdev-uclass.c
> +++ b/boot/bootdev-uclass.c
> @@ -677,8 +677,6 @@ int bootdev_next_prio(struct bootflow_iter *iter, str=
uct udevice **devp)
>                                                         BOOTFLOWIF_SHOW);
>                                 log_debug("- bootdev_hunt_prio() ret %d\n=
",
>                                           ret);
> -                               if (ret)
> -                                       return log_msg_ret("hun", ret);
>                         }
>                 } else {
>                         ret =3D device_probe(dev);
> --
> 2.39.2
>

Per your request, here is the console trace log when the device error
occurs. Perhaps we could improve bootdev_next_prio() to make the error
status more visible in the console with printf? I've briefly looked at
other device bootdev hunt drivers and did not see enough console
output for this type of error, so it might be better that we have this
output either in bootdev_next_prio() or bootdev_hunt_drv().

<BEGIN LOG>
U-Boot 2024.01-rc1-tld-1-00003-gd697d7b93a-dirty (Oct 26 2023 - 16:17:16 -0=
700)
Marvell-Sheevaplug

SoC:   Kirkwood 88F6281_A0
DRAM:  512 MiB
Core:  17 devices, 12 uclasses, devicetree: separate
NAND:  512 MiB
MMC:   338-uclass_find_device_by_seq() 0
346-uclass_find_device_by_seq()    - 0 'mvsdio@90000'
349-uclass_find_device_by_seq()    - found
252-  mvebu_mmc_power_up() mvebu_mmc mvsdio@90000: power up
399-mvebu_mmc_initialize() mvebu_mmc mvsdio@90000: mvebu_mmc_initialize
338-uclass_find_device_by_seq() 1
346-uclass_find_device_by_seq()    - 0 'mvsdio@90000'
353-uclass_find_device_by_seq()    - not found
mvsdio@90000: 0
Loading Environment from NAND... 338-uclass_find_device_by_seq() 0
346-uclass_find_device_by_seq()    - 0 'ethernet-controller@72000'
349-uclass_find_device_by_seq()    - found
OK
In:    serial
Out:   serial
Err:   serial
Net:   eth0: ethernet-controller@72000
Hit any key to stop autoboot:  0

=3D> env def -a
## Resetting to default environment

=3D> bootflow scan -l
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------
338-uclass_find_device_by_seq() 0
346-uclass_find_device_by_seq()    - 0 'extlinux'
349-uclass_find_device_by_seq()    - found
338-uclass_find_device_by_seq() 1
346-uclass_find_device_by_seq()    - 0 'extlinux'
346-uclass_find_device_by_seq()    - 1 'script'
349-uclass_find_device_by_seq()    - found
338-uclass_find_device_by_seq() 2
346-uclass_find_device_by_seq()    - 0 'extlinux'
346-uclass_find_device_by_seq()    - 1 'script'
346-uclass_find_device_by_seq()    - 2 'pxe'
349-uclass_find_device_by_seq()    - found
871-   bootdev_hunt_prio() Hunting for priority 1
883-   bootdev_hunt_prio() exit 0
715-  bootdev_setup_iter() - bootdev_hunt_prio() ret 0
83-bootstd_get_bootdev_order() - targets <NULL> 00000000
746-  bootdev_setup_iter() setup labels 00000000
641-   bootdev_next_prio() next prio 0: dev=3D00000000/none
659-   bootdev_next_prio() - ethernet-controller@72000.boo: 6, want 0
659-   bootdev_next_prio() - mvsdio@90000.bootdev: 2, want 0
668-   bootdev_next_prio() None found at prio 0, moving to 1
871-   bootdev_hunt_prio() Hunting for priority 1
883-   bootdev_hunt_prio() exit 0
678-   bootdev_next_prio() - bootdev_hunt_prio() ret 0
659-   bootdev_next_prio() - ethernet-controller@72000.boo: 6, want 1
659-   bootdev_next_prio() - mvsdio@90000.bootdev: 2, want 1
668-   bootdev_next_prio() None found at prio 1, moving to 2
871-   bootdev_hunt_prio() Hunting for priority 2
Hunting with: mmc
783-    bootdev_hunt_drv() Hunting with: mmc
879-   bootdev_hunt_prio() bootdev_hunt_drv() return 0
883-   bootdev_hunt_prio() exit 0
678-   bootdev_next_prio() - bootdev_hunt_prio() ret 0
659-   bootdev_next_prio() - ethernet-controller@72000.boo: 6, want 2
659-   bootdev_next_prio() - mvsdio@90000.bootdev: 2, want 2
756-  bootdev_setup_iter() Selected bootdev: mvsdio@90000.bootdev
134-bootflow_iter_set_dev() iter: Setting dev to mvsdio@90000.bootdev, flag=
s 0
Scanning bootdev 'mvsdio@90000.bootdev':
573-bootdev_get_bootflow() ->get_bootflow mvsdio@90000.bootdev,0=3D00000000
337-   mvebu_mmc_set_ios() mvebu_mmc mvsdio@90000: bus[0] clock[0]
321-   mvebu_mmc_set_bus() mvebu_mmc mvsdio@90000: ctrl 0xf809:
push-pull 1bit-width
279-   mvebu_mmc_set_clk() mvebu_mmc mvsdio@90000: clock off
337-   mvebu_mmc_set_ios() mvebu_mmc mvsdio@90000: bus[1] clock[0]
321-   mvebu_mmc_set_bus() mvebu_mmc mvsdio@90000: ctrl 0xf809:
push-pull 1bit-width
279-   mvebu_mmc_set_clk() mvebu_mmc mvsdio@90000: clock off
337-   mvebu_mmc_set_ios() mvebu_mmc mvsdio@90000: bus[1] clock[97703]
321-   mvebu_mmc_set_bus() mvebu_mmc mvsdio@90000: ctrl 0xf809:
push-pull 1bit-width
287-   mvebu_mmc_set_clk() mvebu_mmc mvsdio@90000: clock (97703) div : 1022
85-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: cmdidx [0x0]
resp_type[0x0] cmdarg[0x0]
88-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: cmd 0 (hw state 0x20f8)
233-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: resp[0x0] mvebu_mmc
mvsdio@90000: cmdidx [0x8] resp_type[0x15] cmdarg[0x1aa]
88-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: cmd 8 (hw state 0x20f8)
233-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: resp[0x15]
mvebu_mmc mvsdio@90000: cmdidx [0x37] resp_type[0x15] cmdarg[0x0]
88-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: cmd 55 (hw state 0x20f8)
233-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: resp[0x15]
mvebu_mmc mvsdio@90000: cmdidx [0x0] resp_type[0x0] cmdarg[0x0]
88-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: cmd 0 (hw state 0x20f8)
233-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: resp[0x0] mvebu_mmc
mvsdio@90000: cmdidx [0x1] resp_type[0x1] cmdarg[0x0]
88-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: cmd 1 (hw state 0x20f8)
233-  mvebu_mmc_send_cmd() mvebu_mmc mvsdio@90000: resp[0x1] Card did
not respond to voltage select! : -110
333-bootdev_get_sibling_blk() act: returning err=3D-95
550-default_get_bootflow() sibling_blk ret=3D-95, blk=3D(none)
559-default_get_bootflow() blk: returning err=3D-108
375-      bootflow_check() check: returning err=3D-108
414- bootflow_scan_first() check - ret=3D-108
191-           iter_incr() entry: err=3D-108
248-           iter_incr() inc_dev=3D1
281-           iter_incr() labels 00000000
641-   bootdev_next_prio() next prio 2: dev=3D1fb4e800/mvsdio@90000.bootdev
668-   bootdev_next_prio() None found at prio 2, moving to 3
871-   bootdev_hunt_prio() Hunting for priority 3
883-   bootdev_hunt_prio() exit 0
678-   bootdev_next_prio() - bootdev_hunt_prio() ret 0
659-   bootdev_next_prio() - ethernet-controller@72000.boo: 6, want 3
659-   bootdev_next_prio() - mvsdio@90000.bootdev: 2, want 3
668-   bootdev_next_prio() None found at prio 3, moving to 4
871-   bootdev_hunt_prio() Hunting for priority 4

Hunting with: ahci
783-    bootdev_hunt_drv() Hunting with: ahci
Removing devices on SATA bus...
Cannot find SATA device (err=3D0)
786-    bootdev_hunt_drv()   - hunt result -38
879-   bootdev_hunt_prio() bootdev_hunt_drv() return -38
883-   bootdev_hunt_prio() exit -38
678-   bootdev_next_prio() - bootdev_hunt_prio() ret -38
681-   bootdev_next_prio() hun: returning err=3D-38
308-           iter_incr() ret=3D-38, dev=3D00000000 none
134-bootflow_iter_set_dev() iter: Setting dev to (none), flags 0
No more bootdevs
326-           iter_incr() incr: returning err=3D-19
434-  bootflow_scan_next() iter_incr: ret=3D-19
436-  bootflow_scan_next() done: returning err=3D-19
422- bootflow_scan_first() get: returning err=3D-19
---  -----------  ------  --------  ----  ------------------------
----------------
(0 bootflows, 0 valid)

<END LOG>

All the best,
Tony
