Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7856BECD6FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 00:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA5F8388D;
	Thu, 12 Feb 2026 01:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C7HgvHpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1205383B64; Thu, 12 Feb 2026 01:24:30 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF238367F
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 01:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-948ab1c79ebso1922313241.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:24:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770855866; cv=none;
 d=google.com; s=arc-20240605;
 b=D2PRqjTxNw8qv8wO8CzDG2zzVPxTn/flHF3A8YujueWG8Dm8Z5Yq1hMJQq6hCnBbqR
 ekSgkJ4cPiIJ5egw81kFn21pE3SqNQONVai/DzwetV0tFphPyuExnaGU2SsYCBVyck6c
 M9IJp3AS0rdbvPzDuDT3Iz43uxrA1DHb9Of5/C+Eyzup2Cll48bWQ7FGg0H4Yqxee3IU
 xt15QWKRiodB/s5h3/QcsYaPuCZJ7jY9ggm2nye+cH9yfiLHaHLvoszivOtKxeM4fuHE
 NujY86WHNdPIu7znlD4MlR+4yRmtT3N3QDMZMGraZOgb2mh6aZdN31eZ1aOLqQKCyNbU
 u6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LVjIcqKdq8oUdaNhF6yr7D5rDbVrLTCHNvbxGSaA9mM=;
 fh=Hk20VDK9fNt2srtI7sPxUFOa0ijpDW6EOTE15xuY8Q4=;
 b=Se0d2C2+l4/RKpuRJXG2rENn8Y+whMDyePo4EbdBXLme6HG0szOtutwqYzRrU+NGLQ
 aV93cDgkUyjjwBbricbcRqOxJAn2TCL+IP9D1+in8FRwDztbuHKSP0BiNhcA8g7mRX9N
 SZztfHm/gtHnzl6+ubBxoRMIKPvJIhZ9PDn1vN7A/7PXsabUbNXD5z2AUbOgKSAw6cxa
 x7Y2TRXt4Wq1IyNPYxbxarmFjBp8T4ZjTY1NMK2t+ZqGgRE/SVZpJAVlJx4sv0xz8aI/
 t0piLUxhV2LK479RioVIxI2hdX14gJNdNWOgw/DaH6MkAX3UfAFFFvQ3M2b/hfnItKcV
 Hb0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770855866; x=1771460666; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVjIcqKdq8oUdaNhF6yr7D5rDbVrLTCHNvbxGSaA9mM=;
 b=C7HgvHpV5supPLVeg+Hh9TyXMTjj0Xy0ANkSUMoU6dVxhcWrGysFep8jHvX8QyEDiD
 I2b7GEn2Xpk6VO3BdjctliXJaokpXXcLCPWS5pZWYzZ4ShiKfS6Imex1hGLmDAkmpr/n
 2ACaIwUi7mVQlvVTXSVdgv8BBX5N6BcgT53lnZL4eIoFwrJybl4154oQD6mx4LZKgOUo
 0sI6hUE2CwxtWX7Hu/GMaTL6ndw99d8boji7R1IY6Wf6/rUt+8j4wb+UjMwohINe8iWD
 lWZ7fXfEAGwwDLGbTDey11BYNxbbEwWX1pSAzK1PLMQ+9miKrk9qXYit2AeAH49o5mSx
 zwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770855866; x=1771460666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LVjIcqKdq8oUdaNhF6yr7D5rDbVrLTCHNvbxGSaA9mM=;
 b=JzvEaAz9scFK8P6+kzPkP/ssjy+/5WXlTStCvkThFjXeTiHL03A5ILRFNYIU6h5ODB
 TecRoVVoW+rROWRBSYqdOLFO/fIwcvlo3C7APs9Q/PFIy9h6IjXbvAaGFoX/i4JVE85G
 Mn+ihSR09FfqAB5K0di4D2QWJ91GjhVhf8oFPuE/mhOYRnLsjg7nS1OXiyErLnW7aEPZ
 n3I95cIdqcWzpSgGt+0JsujrPDa/42S0b/gDdSSPaq6GYcVzl0Zyfn1qC/VGGWyDuDSt
 vZbH6bsu+gFpi/lLkP8BdGwt8OnnAoFANz+v8QiT+0KogN95168VFe6PgsmdLCNgVd50
 Eu+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqeAduMkEnySykGuIXbX2XLBJch07DaZO4FL7Keg++bB9lzLNWVJylF7P2s/VdohQSgFlqxXI=@lists.denx.de
X-Gm-Message-State: AOJu0YwViUnpgSBYK7TQXAZa5AVSW+lv75b3MzYSoHPvZrg9ROm9a5OI
 rQ05jXacNkEaT1l1RjYpsI1twRV8Zd0M7ZSdnopXkbLKDig475YTm3OjV6xA1rMWa8fphbuAiCt
 /dnMLoakqqUQkTLCmiPIFZhSRJrlbHIM=
X-Gm-Gg: AZuq6aL3x9RobwB3u/FAI/r4uUtKPyPuXTZ0u9c0NA8BjDwMi4aL19dVSlqkDXc97bb
 GXi287QituRhxC7LrkYpQAEMjoQvZp+AvRFZ8/YFl4DEMwIkMIqo98QatKxstGSJ0M289EIonX7
 /3ixax60nRvsa+6nvz6sK9b6TAc4iM1SPdbPkeBzNj/ZXP423APe36U+EOj5RN65EfwosWIzHDA
 5o6OOcNrnjuEYiUv9c1AtI2+mDp421Nc+db2QPU5xiSGEZWl+SCf50VhxuOolFpC/TOJRHy/M7Q
 rhJgqUq2
X-Received: by 2002:a05:6102:c87:b0:5fd:7140:e38b with SMTP id
 ada2fe7eead31-5fdfbe1b045mr399024137.35.1770855866486; Wed, 11 Feb 2026
 16:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
 <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
 <20260204161345.GY2603314@bill-the-cat>
 <CAC_iWj+qEmxNeGVBcLcrzNM=BkVj0QW2VYW6ZNGTKD6BeRTNHA@mail.gmail.com>
 <CAMDkj5yg24MwQz4G8Y62S7mB_6D=p+0Qrooe77RKQ+C4CPwA1Q@mail.gmail.com>
 <CAC_iWjKUqkjOFsk7+dj+7tn_hrbngoq4CyjCxg0xLbU=-X+GXA@mail.gmail.com>
In-Reply-To: <CAC_iWjKUqkjOFsk7+dj+7tn_hrbngoq4CyjCxg0xLbU=-X+GXA@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 11 Feb 2026 19:24:15 -0500
X-Gm-Features: AZwV_Qih7lqs87yfEOqhv1Q-xmXjMzj7YKfKfcGeIAaDTNWcCRWxl059lUscT1k
Message-ID: <CAMDkj5z0UuUi0qPfaykEVF=MmbEqXUup4GejaLAyJmg3PGByMg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Samuel Holland <samuel.holland@sifive.com>
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

Hi Ilias

On Wed, Feb 11, 2026 at 10:20=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 11 Feb 2026 at 16:30, Raymond Mao <raymondmaoca@gmail.com> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > Apologies for the late reply.
> > >
> > > I did test the patches but I see something weird on smbios type 17.
> > >
> > > Handle 0x0008, DMI type 17, 104 bytes
> > > Memory Device
> > >         Array Handle: 0x0000
> > >         Error Information Handle: Not Provided
> > >         Total Width: Unknown
> > >         Data Width: Unknown
> > >         Size: No Module Installed
> > >         Form Factor: <OUT OF SPEC>
> > >         Set: None
> > >         Locator: <BAD INDEX>
> > >         Bank Locator: <BAD INDEX>
> > >         Type: Unknown
> > >         Type Detail: Other Unknown Fast-paged Static Column
> > > Pseudo-static RAMBus Synchronous
> > >         Speed: 512 MT/s
> > >         Manufacturer: <BAD INDEX>
> > >         Serial Number: Not Specified
> > >         Asset Tag: Not Specified
> > >         Part Number: Not Specified
> > >         Rank: Unknown
> > >         Configured Memory Speed: Unknown
> > >         Minimum Voltage: Unknown
> > >         Maximum Voltage: Unknown
> > >         Configured Voltage: Unknown
> > >         Memory Technology: <OUT OF SPEC>
> > >         Memory Operating Mode Capability: None
> > >         Firmware Version: Not Specified
> > >         Module Manufacturer ID: Bank 3, Hex 0x04
> > >         Module Product ID: Unknown
> > >         Memory Subsystem Controller Manufacturer ID: Unknown
> > >         Memory Subsystem Controller Product ID: Unknown
> > >         Non-Volatile Size: 16383 PB
> > >         Volatile Size: Unknown
> > >         Cache Size: Unknown
> > >         Logical Size: Unknown
> > >
> > > Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> > > I tested this in QEMU
> > >
> >
> > I just retested it by below qemu cmd after I rebased it to the current =
master:
> > qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu cortex-a57 -m
> > 2G  -nographic
> >
> > Below is the type17 I got:
> > ```
> > Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
> > Memory Device:
> > Physical Memory Array Handle: 0x0000
> > Memory Error Information Handle: 0xfffe
> > Total Width: 0x0000
> > Data Width: 0x0000
> > Size: 0xffff
> > Form Factor: Unknown
> > Device Set: 0x00ff
> > Device Locator:
> > Bank Locator:
> > Memory Type: Unknown
> > Type Detail: 0x0004
> > Speed: 0x0000
> > Manufacturer:
> > Serial Number:
> > Asset Tag:
> > Part Number:
> > Attributes: 0x0000
> > Extended Size: 0x00000000
> > Configured Memory Speed: 0x0000
> > Minimum voltage: 0x0000
> > Maximum voltage: 0x0000
> > Configured voltage: 0x0000
> > Memory Technology: Unknown
> > Memory Operating Mode Capability: 0x0004
> > Firmware Version:
> > Module Manufacturer ID: 0x0000
> > Module Product ID: 0x0000
> > Memory Subsystem Controller Manufacturer ID: 0x0000
> > Memory Subsystem Controller Product ID: 0x0000
> > Non-volatile Size: 0xffffffffffffffff
> > Volatile Size: 0xffffffffffffffff
> > Cache Size: 0xffffffffffffffff
> > Logical Size: 0xffffffffffffffff
> > Extended Speed: 0x0000
> > Extended Configured Memory Speed: 0x0000
> > PMIC0 Manufacturer ID: 0x0000
> > PMIC0 Revision Number: 0x0000
> > RCD Manufacturer ID: 0x0000
> > RCD Revision Number: 0x0000
> > ```
> >
> > If you didn't use smbios_generic.dtsi to insert new nodes, or add new
> > 'memory@' / 'memory-controller@' nodes into your DT, you should get
> > the same result as mine by default.
> > If you still can not get it, can you give me your build instruction
> > and qemu cmd for reproducing?
>
> I used qemu_arm64_lwip_defconfig
>
> qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
>           -machine virt,secure=3Doff -bios u-boot.bin -chardev
> socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
>           -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device
> tpm-tis-device,tpmdev=3Dtpm0 \
>           -device virtio-rng-pci -drive
> id=3Dos,if=3Dnone,file=3D../debian.qcow2 -device virtio-blk-device,drive=
=3Dos
>  is the command line
>

I did these steps with a clean build (exactly the same as your ones):
$ make O=3Dout_lwip qemu_arm64_lwip_defconfig
$ CROSS_COMPILE=3Daarch64-none-linux-gnu- make O=3Dout_lwip -j4 all
$ cd out_lwip
$ killall swtpm
$ rm -rf /tmp/mytpm1
$ mkdir -p /tmp/mytpm1
$ swtpm_setup --tpmstate /tmp/mytpm1 --tpm2 --pcr-banks sha256
$ swtpm socket --tpmstate dir=3D/tmp/mytpm1 --ctrl
type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock --log level=3D40 --tpm2 -t -d
$ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
-machine virt,secure=3Doff -bios u-boot.bin -chardev
socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
-tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=
=3Dtpm0 \
-device virtio-rng-pci -drive id=3Dos,if=3Dnone,file=3D../debian.qcow2
-device virtio-blk-device,drive=3Dos

SMBIOS type17 shows no difference:
```
Handle 0x0008, DMI type 17, 104 bytes at 0x7e64b141
Memory Device:
Physical Memory Array Handle: 0x0000
Memory Error Information Handle: 0xfffe
Total Width: 0x0000
Data Width: 0x0000
Size: 0xffff
Form Factor: Unknown
Device Set: 0x00ff
Device Locator:
Bank Locator:
Memory Type: Unknown
Type Detail: 0x0004
Speed: 0x0000
Manufacturer:
Serial Number:
Asset Tag:
Part Number:
Attributes: 0x0000
Extended Size: 0x00000000
Configured Memory Speed: 0x0000
Minimum voltage: 0x0000
Maximum voltage: 0x0000
Configured voltage: 0x0000
Memory Technology: Unknown
Memory Operating Mode Capability: 0x0004
Firmware Version:
Module Manufacturer ID: 0x0000
Module Product ID: 0x0000
Memory Subsystem Controller Manufacturer ID: 0x0000
Memory Subsystem Controller Product ID: 0x0000
Non-volatile Size: 0xffffffffffffffff
Volatile Size: 0xffffffffffffffff
Cache Size: 0xffffffffffffffff
Logical Size: 0xffffffffffffffff
Extended Speed: 0x0000
Extended Configured Memory Speed: 0x0000
PMIC0 Manufacturer ID: 0x0000
PMIC0 Revision Number: 0x0000
RCD Manufacturer ID: 0x0000
RCD Revision Number: 0x0000
```

By the way, I don't think it has any relationship with swtpm and the
linux distro, so I also simply tried:
$ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
-machine virt,secure=3Doff -bios u-boot.bin

All works with the same type17 output.

Regards,
Raymond

> Cheers
> /Ilias
>
>
> >
> > Regards,
> > Raymond
> >
> >
> > > Regards
> > > /Ilias
> > >
> > > On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > Anyone have a chance to review this patch set? It is the last pie=
ce of
> > > > > work to support all required SMBIOS types in U-Boot.
> > > >
> > > > I've been waiting for Ilias or Heinrich to have time to look at thi=
s.
> > > >
> > > > --
> > > > Tom
