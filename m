Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5C9D111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 12:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E6A583837;
	Sun, 30 Nov 2025 13:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L+xJrKzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC00583849; Sun, 30 Nov 2025 13:12:56 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CADB8312A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 13:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-640b0639dabso5761037a12.3
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764504773; x=1765109573; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCZZIMduCxuaFh6enoX63BBUdTtLHBaN52Y4hw222bE=;
 b=L+xJrKzP6KNubY9Xye8NlHnZtLcP7XN8ZufGp7zzubGJZXUUu1iPU8w+SE+5YWa72W
 b+d9JqvGTHRiVskFTbTOAevgtIW3fe9rN6Rvm55aFn2nfyb746QaENuNST91xpOoOwf9
 Ey43LIISDb3N0njNy4+VwRfJfxww+7ZjrPc9HuV/eWikVd9oTltTwQJrc9PAelE5QOAo
 DYoxJl5NFoWt9eofS+kU/mTafXw2fUPg1xwMq38JMPcuUDDaQDLvPK7k36X+/iJqXXdh
 4WqZ1Rwxoy42YWSl0CelrHXlBmod7CcTmOpXpir7kIZCiSy2P1ndT6FgrzzUkgrGCJSx
 kCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764504773; x=1765109573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZCZZIMduCxuaFh6enoX63BBUdTtLHBaN52Y4hw222bE=;
 b=ku6DUzIz5CiflW/J4DbNILYy2+HLx9ASidD/vu4JS7WZ+ws482SeRTKoupn1uISWuj
 +26/kobBHtrdYngWQ65Ew2wTiVUGgmAqL8uKr06zsindX4XNJmYf5EZDPnI8VgsEkt8J
 OYQoRdcHxx1xNCRHYIbmaU2Z8VtLOg8QJG7Bd50sVBZ4YZ+1zAzdqqSyuEhWwSK74E4i
 S4pxRHnhZ0ZaaXC/Z7vJkfYtqqykfs56jPD1SnpxDI3autSzlQvwIzsG9GRP0BpZxYFF
 NTHarN0msOns1JCMhMBrW75J0IoUbPIQrn4zbwTkwHADAhVmkZnImcN9Hrpv6qrH1s82
 TuWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt1Jlk90jTy13h7C8iZdOdb9DC0RIFl4g3yaz76dOu07IxaGdeBZLintvI+hQQrSZpeafFTu0=@lists.denx.de
X-Gm-Message-State: AOJu0YyNNUmvmV1uXlUQWPksuzKebC+0jir3DUR5+Gwt8cIcfJQTdv77
 d1pwHGcIeAWqU6683o2nBQvYRlnOaBOY63G2FwapaVkclxkjCytyroxX82IGRkZ0m310VsI3c+F
 DC7rUc5Xw5VUVLuqfgT1+etPdeku8JJo=
X-Gm-Gg: ASbGncumd/qHS4+vkfo056JudawezhooyeNser61dJTEBk2sPW+r6tRiOOpPf7gMgFg
 OJPQ4uO/jeWhzsuW0ELoxNrztLt3E+OXcMnE9W8jkdMx33YFHQueh5/8MjQY052MTBwO3bK1ZPc
 ijVMesHfZB17YpWGR8Pvg0ku1bm6Bkhku8+uv1eCEVZiUvg6eltVuaFDs3t69D/VJ8wsKkbMuKi
 hwBxmCkevPqD1xjV8zzyBXGzDZyhbTn4Ob0jyjZu+SE70ATCksgI/cMQ8a855Cbt+SLrvDB/iAs
 Ath3
X-Google-Smtp-Source: AGHT+IGK7RPp35r/z6ExwakaLG0GV59RPehNEXgjjsYJjwfYsaDnjOcCMthpwEicRauqFtsdN/irmSvOQgPINJ+wxTg=
X-Received: by 2002:a05:6402:1461:b0:640:c779:909 with SMTP id
 4fb4d7f45d1cf-6455468d6c8mr29946861a12.27.1764504773204; Sun, 30 Nov 2025
 04:12:53 -0800 (PST)
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
In-Reply-To: <99ACD06BACB0AD72+efbd4b3a-db5a-4a83-97c5-c1df635385ff@radxa.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 30 Nov 2025 17:42:36 +0530
X-Gm-Features: AWmQ_bkCBvieblH_sZux-5s9cqq9FYIH1WQ-QDXS3MVYFdBGxp7dbd3RlUQ4Pig
Message-ID: <CANAwSgSc1AgkXUkEWHqKgWbOa4djL051mLh4J23m+mkVopRQdQ@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi FUKAUMI,

On Sun, 30 Nov 2025 at 13:24, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> Hi Anand,
>
> On 11/30/25 16:27, Anand Moon wrote:
> > Hi FUKAUMI
> >
> > On Sat, 29 Nov 2025 at 15:22, FUKAUMI Naoki <naoki@radxa.com> wrote:
> >>
> >> Hi Anand,
> >>
> >> On 11/29/25 16:25, Anand Moon wrote:
> >>> Hi FUKAUMI,
> >>>
> >>> On Sat, 29 Nov 2025 at 10:09, FUKAUMI Naoki <naoki@radxa.com> wrote:
> >>>>
> >>>> Hi Anand,
> >>>>
> >>>> On 11/28/25 14:50, Anand Moon wrote:
> >>>>> Hi Heinrich,
> >>>>>
> >>>>>>> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus=
.
> >>>>>>>
> >>>>>>> But I am booting from SPI flash, so I cannot stop this board in t=
he
> >>>>>>> U-Boot prompt.
> >>>>>>>
> >>>>>>> Is there any other way to flash the SPI flash u-boot-rockchip-spi=
.bin image
> >>>>>>> in the user space to spi flash? using dd coammnd
> >>>>>>>
> >>>>>>>     From the schematics, it has W25Q64FWZPIG
> >>>>>>>
> >>>>>>> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_=
20181112.pdf
> >>>>>>>
> >>>>>>> I have tried to enable SPI flash, but it is not getting detected =
on
> >>>>>>> the board in userspace.
> >>>>>>
> >>>>>>
> >>>>>> https://wiki2.radxa.com/Rockpi4/dev/usb-install
> >>>>>> has some guidance how to avoid booting from SPI NOR flash.
> >>>>>>
> >>>>> Thanks for your tip.
> >>>>>
> >>>>> I've attempted this method, but it hasn't worked for me.
> >>>>> Could you provide the SPI details for this board so I can map it in=
 driver code
> >>>>> and from userspace and then attempt to erase or reflash the image?
> >>>>>
> >>>>> on my board
> >>>>> [    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
> >>>>> [    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff f=
f ff ff ff
> >>>>
> >>>> Are you using dts with "audio-supply =3D <&vcc_3v0>;"? It should fix=
 SPI too.
> >>>>
> >>> Thanks for your tip.
> >>>
> >>> I have applied the patch from FUKAUMI, and now my console output has
> >>> started working
>
> How did you use patched dts? And what does "my console output has
> started working" mean?
>
> >>>> 1. Make u-boot-rockchip.bin with "audio-supply =3D <&vcc_3v0>;"
> >>>> 2. Write it to microSD card
> >>>> 3. Insert it
> >>>> 4. Kill SPI flash
> >>>> 5. Boot U-Boot from SD card
> >>>> 6. Revert 4.
> >>>> 7. Try "sf probe" "sf erase"
> >>>>
> >>> Yes, I have tried these steps (4 Kill SPI flash) ->
> >>> I have shortened the SPI1_CLK and GNG in the GPIO header
> >>> But this board first boots from SPI flash, I don't know the reason.
> >>>
> >>> I noticed your patch references the W25Q128.
> >>> Did you get this device detection in userspace?
> >>>
> >>> This output is from your patch.
> >>> =3D> led blue:status off
> >>> =3D> sf probe
> >>> SF: Detected w25q128 with page size 256 Bytes, erase size 4 KiB, tota=
l 16 MiB
> >>> =3D> led blue:status on
> >>> =3D> sf probe
> >>> jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
> >>> Failed to initialize SPI flash at 1:0 (error -2)
> >>>
> >>> Could this explain why I=E2=80=99m unable to detect the device from u=
serspace?
> >>
> >> What happens if you lower the SPI clock?
> >> e.g.
> >>    spi-max-frequency =3D <10000000>;
> >>
> > Thanks for your input, but I have a bad old U-Boot in my SPI chip,
> > which blocks the UART. I need to erase the SPI chip externally
> > or erase the chip from user space.
>
> If you can use patched dts on Linux, please try lower frequency and see
> spi-nor found or not on Linux. W25Q64FW max frequency is 104MHz, not 108M=
Hz.
>
Thanks,  I have tried all the things you suggested

alarm@rockpi4b:~$ dmesg | grep spi
[    0.000000] Kernel command line: console=3DttyS2,1500000
root=3DLABEL=3DROOT_MNJRO rw rootwait audit=3D0 splash
plymouth.ignore-serial-consoles dyndbg=3D"file
drivers/mtd/spi-nor/spi-nor.c +p"
[    0.000000] Unknown kernel command line parameters "splash
dyndbg=3Dfile drivers/mtd/spi-nor/spi-nor.c +p", will be passed to user
space.
[    1.293692] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff =
ff
[    1.435572]     dyndbg=3Dfile drivers/mtd/spi-nor/spi-nor.c +p
alarm@rockpi4b:~$ cat /proc/mtd
dev:    size   erasesize  name
alarm@rockpi4b:~$

Yes, I have applied your suggestion and built the kernel
Still, I am not able to detect the SPI flash in user space.

Here is the bootlogs [1] https://pastebin.com/25fCqwRT
My console works after I apply your patch to the kernel.

U-Boot TPL 2025.10-1 (Oct 31 2025 - 11:12:15)
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

U-Boot SPL 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
Trying to boot from MMC1
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
## Checking hash(es) for Image atf-4 ... sha256+ OK
load_simple_fit: Skip load 'atf-5': image size is 0!


U-Boot 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)

SoC: Rockchip rk3399
Reset cause: POR
Model: Radxa ROCK Pi 4A
DRAM:  4 GiB (total 3.9 GiB)
PMIC:  RK808

You see, I could not control the UART with the key pressed.
Here are my local Linux DTS changes
-------
 git diff arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
index 9c741d1a3047..adbd14d7bd9b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
@@ -42,6 +42,17 @@ &sound {
        hp-det-gpios =3D <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
 };

+&spi1 {
+       status =3D "okay";
+
+       flash@0 {
+               compatible =3D "jedec,spi-nor";
+               reg =3D <0>;
+               spi-max-frequency =3D <104000000>;
+               vcc-supply =3D <&vcc3v3_sys>;
+       };
+};
+
 &uart0 {
        status =3D "okay";

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
index 55285c7c6e54..484bab2fea9d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
@@ -37,7 +37,8 @@ &spi1 {
        flash@0 {
                compatible =3D "jedec,spi-nor";
                reg =3D <0>;
-               spi-max-frequency =3D <108000000>;
+               spi-max-frequency =3D <104000000>;
+               vcc-supply =3D <&vcc3v3_sys>;
        };
 };

Winbord nor patch as per U-Boot configuration

$ git diff drivers/mtd/spi-nor/winbond.c
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 63a93c9eb917..38449464b67b 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -295,7 +295,14 @@ static const struct flash_info winbond_nor_parts[] =3D=
 {
                .id =3D SNOR_ID(0xef, 0x70, 0x17),
                .name =3D "w25q64jvm",
                .size =3D SZ_8M,
-               .no_sfdp_flags =3D SECT_4K,
+               .flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+               .no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ |
SPI_NOR_QUAD_READ,
+       }, {
+               .id =3D SNOR_ID(0xef, 0x60, 0x17),
+               .name =3D "w25q64dw",
+               .size =3D SZ_8M,
+               .flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+               .no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ |
SPI_NOR_QUAD_READ,
        }, {
                .id =3D SNOR_ID(0xef, 0x70, 0x18),
                .name =3D "w25q128jv",
@@ -322,6 +329,7 @@ static const struct flash_info winbond_nor_parts[] =3D =
{
                .no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ |
SPI_NOR_QUAD_READ,
                .otp =3D SNOR_OTP(256, 3, 0x1000, 0x1000),
        }, {
+
                .id =3D SNOR_ID(0xef, 0x80, 0x17),
                .name =3D "w25q64jwm",
                .size =3D SZ_8M,
amoon@amoon-t440s:~/mainline/linux-stable-6.y-devel$

> Are you sure your board has W25Q64FW? What is the board ver. do you have?

I have my Radxa Rock Pi 4b Plus with eMMC soldered to the board as
shown link below.

[2] https://jumpshare.com/share/1GYCqbrd3GC1Z1tpHMMf (BOARD)
> I'm not asking about schematic, but actual chip soldered on *your board*.
>
> Please check Component Placement Map for location:
>   https://radxa.com/products/rock4/4bp#downloads
>
Sorry, I could not read the SPI chip info. My mobile camera cannot
detect the chip id
Here is the PCB image of the board.

[3] https://jumpshare.com/share/fUUSVTKPIqwlbWyrIP7g (SPI CHIP)

> Best regards,
>
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
>
Thanks
-Anand
