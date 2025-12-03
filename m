Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2151ED1266D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 06:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2102A83F2E;
	Wed,  3 Dec 2025 07:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lTgzbOJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2B983F3F; Wed,  3 Dec 2025 07:08:52 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A5C83E7F
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 07:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-640860f97b5so9505478a12.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 22:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764742130; x=1765346930; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssVWBM11Ye90IYy8O0LMjQSQQ6O7uA/Z14jtBPgTp20=;
 b=lTgzbOJ0PI56AFyY2kvWU5SQQh03yZ+vtECCyC+VR1cmEXnlMhABV/bO4DEYzXjX5l
 6c9VFL11VWiSf1gQloLlcvKVoRkYXpcd85qmYvB/NAikuow+73AiCdmzSKemCrCqo1K+
 VYIFaEhpPLJW3g7Y16lKZtHcy5AIIfL/buKVZ7eDOmd+lGN86H9eQGUgkDMbpFeGMNRG
 0YuRgbuzauR/WRWM6PyE+cUOTJsseKXiTh8sqolQMpYPucd8U57nQhMBdlGSVsGddhtq
 I7MwtaVgZU9y1OW8mg/5ZIlNwde6wLBO+7aywtCrv2FasszaUtROijW62FdHkjFR3LJP
 tMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764742130; x=1765346930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ssVWBM11Ye90IYy8O0LMjQSQQ6O7uA/Z14jtBPgTp20=;
 b=CdKABXnSa4lChzB7oRZASbqoh0KgSQd2Wr5w45vfe9mYh/xQQhEddpE/fcY+6T/oYT
 cI1hJub+ZsUF++36yAEyedX+MofCMginpLzWCmuH3xQlEEDy+bUwxn3vOIXSCspKH+k9
 1i2XnlEosyZlJThCKKGFNHtPN6ymTqjSvJDLG0Z8N6UlDFQOiyddjTMIAwcAGmiJL48O
 tyHoUgTI6mRHvALgNeYeQusxYfB1A65wFtHV1SOlpo/JnM6B347UGAz/oTYLoOlW5XPH
 hWJDliFDymPKCCeHAtBIA7Aw88SOaHI0kWffxcMyuWxrYwwe9vBmaNGDHN2xElzQsk8I
 Og7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWegL0y4J5ZdYXZZL8nRNJChlYbHRoP6qkSVwx/uAyXYFhoN549cON/2KHpOG1sGfMGXrTCh2U=@lists.denx.de
X-Gm-Message-State: AOJu0YxloA9B+joJv9G21Vd/QoZUUJm4aPWfOOsfV4IVvFuQIFcIM1tA
 Xo9Z4E9wJOmeQnBcwfqOIJG+Uof9TXc6wBZZcX/yj5BgNzc3PlM0PxPpXM2oBEoWVHt5ZAhse9s
 Bje25KCoBNAKQNX4qhJgDFutYc3xG/q8=
X-Gm-Gg: ASbGncuHFXIQU7plCtkRp9dTzE9845Egl/EtRQ2NtzVVyd4cH+W8ZhUCHIh+7bWciia
 /JCLH00qVl/ttnEt0n665PxlT3F2uClKoB0buhFYYdyEHoIAYx1mKU+pCvxa6getctfG4yq5HwL
 /IIhLpu+Z0Whj4+rEWTLy74im0824m4lM24aBFAcmDrTCxZ9yMBOh8ZeBsBxPg+Xmhr1jLDlzYp
 vzKMeuxCpoFUj8lDS7vJT8Uw1Nnc10UAH/f+9GwYWQ4CqqgWqg0BtEIctryh3BAaLf8AA==
X-Google-Smtp-Source: AGHT+IGwIPb9TvaxfrgUO2nlWqgSE4JUywWFSZLuYP2yr9o4HVfWkecNO7EnNCvRqbibn0WGPDzlVeCooM8f3J4XYM4=
X-Received: by 2002:a05:6402:350c:b0:643:c8b:8d61 with SMTP id
 4fb4d7f45d1cf-6479c2f7296mr832329a12.0.1764742129523; Tue, 02 Dec 2025
 22:08:49 -0800 (PST)
MIME-Version: 1.0
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
 <0FB759C1BA7AEB85+a26afcc4-c5e8-4452-a6ce-e19736be395b@radxa.com>
 <CANAwSgRRYg-QLATDWcdf8nubv1+Hqn9r_R8D1bFYui3i1nYitw@mail.gmail.com>
 <53143B48341F9068+600cd801-8c7e-4407-a3e9-13c83ac5ca67@radxa.com>
 <CANAwSgQBwoUNYQkhbkmBZ3UMAO=+NUw6rK+=vT0=BCBRxAjD6w@mail.gmail.com>
 <99ACD06BACB0AD72+efbd4b3a-db5a-4a83-97c5-c1df635385ff@radxa.com>
 <CANAwSgSc1AgkXUkEWHqKgWbOa4djL051mLh4J23m+mkVopRQdQ@mail.gmail.com>
 <a9a4deea-4f53-4103-97f9-32d96177c6e1@cherry.de>
 <CANAwSgR0cX8nkUMx6ubHjsLgrV95MMHeqMaUqGGgXgUhd77VBA@mail.gmail.com>
 <4D137134CA227A81+dba25938-64d5-4518-83a3-ee85e61eee60@radxa.com>
In-Reply-To: <4D137134CA227A81+dba25938-64d5-4518-83a3-ee85e61eee60@radxa.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 3 Dec 2025 11:38:33 +0530
X-Gm-Features: AWmQ_bkdhGsmDq3J2Xi1RlHfWN81JtTlpPfgtqFswG9xx75RVH5rgNqjq_5hncY
Message-ID: <CANAwSgSAA9G_DYeuYD9HMn=asJEEfe_9_QPsyfkj6yvpxtebgg@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner <heiko@sntech.de>
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

Hi FUKAUMI, Quentin.

Thanks for your help.

On Mon, 1 Dec 2025 at 22:50, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> Hi Anand,
>
> On 12/2/25 02:09, Anand Moon wrote:
> > Hi Quentin/ FUKAUMI,
> >
> > On Mon, 1 Dec 2025 at 16:12, Quentin Schulz <quentin.schulz@cherry.de> =
wrote:
> >>> U-Boot TPL 2025.10-1 (Oct 31 2025 - 11:12:15)
> >>> lpddr4_set_rate: change freq to 400MHz 0, 1
> >>> Channel 0: LPDDR4, 400MHz
> >>> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 =
Size=3D2048MB
> >>> Channel 1: LPDDR4, 400MHz
> >>> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 =
Size=3D2048MB
> >>> 256B stride
> >>> lpddr4_set_rate: change freq to 800MHz 1, 0
> >>> Trying to boot from BOOTROM
> >>> Returning to boot ROM...
> >>>
> >>> U-Boot SPL 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
> >>> Trying to boot from MMC1
> >>
> >> I believe this means you booted from eMMC. (MMC2 should be SD card as
> >> far as I remember)
> >>
> >> When you boot from SPI flash, you should see "Trying to boot from SPI"
> >> first, if it fails then it'll try to boot from eMMC and then SD card.
> >> This is due to
> >>
> >> u-boot,spl-boot-order =3D "same-as-spl", &sdhci, &sdmmc;
> >>
> >> in arch/arm/dts/rk3399-u-boot.dtsi + SPL_SPI* symbols in your .config.
> >>
> >>> ## Checking hash(es) for config config-1 ... OK
> >>> ## Checking hash(es) for Image atf-1 ... sha256+ OK
> >>> ## Checking hash(es) for Image u-boot ... sha256+ OK
> >>> ## Checking hash(es) for Image fdt-1 ... sha256+ OK
> >>> ## Checking hash(es) for Image atf-2 ... sha256+ OK
> >>> ## Checking hash(es) for Image atf-3 ... sha256+ OK
> >>> ## Checking hash(es) for Image atf-4 ... sha256+ OK
> >>> load_simple_fit: Skip load 'atf-5': image size is 0!
> >>>
> >>>
> >>> U-Boot 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
> >>>
> >>> SoC: Rockchip rk3399
> >>> Reset cause: POR
> >>> Model: Radxa ROCK Pi 4A
> >>> DRAM:  4 GiB (total 3.9 GiB)
> >>> PMIC:  RK808
> >>>
> >>> You see, I could not control the UART with the key pressed.
> >>
> >> Because you don't have the audio-supply patch for this U-Boot maybe? O=
r
> >> you didn't actually flash your newly compiled U-Boot on the device thi=
s
> >> U-Boot loads from.
> >>
> > My board=E2=80=99s SPI flash is running an outdated firmware that lacks=
 the
> > auto-supply patch.
> > which results in the UART console being locked
>
> As Quentin said, your board is booted from eMMC. This is why "kill SPI
> flash" didn't work.
>
> Please try to erase eMMC, e.g. `blkdiscard /dev/mmcblk0` on Linux.
>
> Or, please make & insert bootable SD and press & hold maskrom button
> (i.e. kill eMMC) while power on.
I had tried this process earlier, but if did not work
>
After installing a fresh new OS and recompiling the latest kernel
I have finally been able to get the SPI flash to detect in userspace
I just used your audio-supply patch to get this working.

alarm@rockpi4b:~$ sudo mtdinfo
Count of MTD devices:           1
Present MTD devices:            mtd0
Sysfs interface supported:      yes
alarm@rockpi4b:~$ cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00400000 00001000 "spi1.0"
alarm@rockpi4b:~$

alarm@rockpi4b:~$ sudo flash_eraseall /dev/mtd0
flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please use =
it
Erasing 4096 Kibyte @ 0 -- 100 % complete
alarm@rockpi4b:~$
alarm@rockpi4b:~$ sudo flash_erase /dev/mtd0 0 1024

[sudo] password for alarm:
Erasing 4096 Kibyte @ 0 -- 100 % complete

But this command did not erase the SPI flash completely

After running the following command, I can flash the image to SPI flash.

alarm@rockpi4b:~/u-boot-rpi4$ sudo flashcp u-boot-rockchip-spi.bin /dev/mtd=
0
alarm@rockpi4b:~/u-boot-rpi4$ re

-----
U-Boot TPL 2026.01-rc3-00080-gc589cff7dc5c (Dec 03 2025 - 11:23:01)
lpddr4_set_rate: change freq to 400MHz 0, 1
Channel 0: LPDDR4, 400MHz
BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Size=
=3D2048MB
Channel 1: LPDDR4, 400MHz
BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Size=
=3D2048MB
256B stride
lpddr4_set_rate: change freq to 800MHz 1, 0
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2026.01-rc3-00080-gc589cff7dc5c (Dec 03 2025 - 11:23:01 +0530)
Trying to boot from SPI
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
## Checking hash(es) for Image atf-4 ... sha256+ OK
load_simple_fit: Skip load 'atf-5': image size is 0!


U-Boot 2026.01-rc3-00080-gc589cff7dc5c (Dec 03 2025 - 11:23:01 +0530)

SoC: Rockchip rk3399
Reset cause: RST
Model: Radxa ROCK Pi 4A
DRAM:  4 GiB (total 3.9 GiB)
PMIC:  RK808
Core:  306 devices, 34 uclasses, devicetree: separate
MMC:   mmc@fe320000: 1, mmc@fe330000: 0
Loading Environment from MMC... Reading from MMC(0)... *** Warning -
bad CRC, using default environment

In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: Radxa ROCK Pi 4A
Net:   eth0: ethernet@fe300000

Hit any key to stop autoboot: 0
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------

Thanks for your support and guidance.
-Anand
