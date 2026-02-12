Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587A6EB4917
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 12:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5712583DCA;
	Thu, 12 Feb 2026 13:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FRgcc5b3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474ED83E13; Thu, 12 Feb 2026 13:45:35 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA3BF83D5D
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 13:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-79427f739b0so82172817b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 04:45:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770900331; cv=none;
 d=google.com; s=arc-20240605;
 b=NvwR2o8yfVnBjLmYEj9vWpx5rJ4fs5HZ5JOcwyF0ksqNm8HdfpHGJdxfCkUmeITynh
 jmYVrlc/74LgjEFkhk3ZSpIrB4YHGXIk4GRsOXNZ4AmWxaJC4FADhBPmwhpy7NhuK7mY
 j4l3ci02owMTvPglOzO/IQ9ypzi19CWXj+Ma1NYeHuALw6iD+VT4m2O/tywh9ADRO86O
 nXMEXjgtJw9y7VpYWwnOkBVJCn1DcGvNtLk7wHni+k4xqoKa8VRyGaRdq70fMIbRuYlR
 UqEaccpkZ8a8d+SJgnPpdq7YGqSj7C7QBmQttZQcsRPq1vgEh+OzIYK/e7wHpARBDTLs
 6mkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nyR4nO1EwLufk5r5zVPXg8ODjYk83VQHLjsqtr0ZNXA=;
 fh=sguOQ+BBUTR4dVcRw81QQyh6ATMApOtbiN4EC7H+87E=;
 b=MX6JhgA0BmagXeqz/AWU7XaUj3K5KaWNG7i7Xgn9zkLRmCjhMG7wd6TOMuEYGmNw+h
 gZ0Tmkwu9w7M/0THpv8DqNIm7QtPfZgOTY5hqVTu3vgxHXwck5S0/Ifr9Td+Lk/xgRMw
 eaO0GGLJv9/g90hjrAo+yZxSXrnqggw4lDPvCb76ZOangvsZMyaTOZP6g9Qb5PC4x23V
 r1IeLVGNoieaJmmWVZ3pocFl3F27eGIPG9P2Roowg4h2+MaWrgKnCpIpurssJRabwKK6
 t53KhgyPtHECWoY3/w7wDsrkUEIyPFyAu/3A0GxYUN/Ii/R+nSQxaR/1XtCsGdEjWR/k
 rA4A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770900331; x=1771505131; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyR4nO1EwLufk5r5zVPXg8ODjYk83VQHLjsqtr0ZNXA=;
 b=FRgcc5b3hRNu4njEH5Bp8b3mPFb66U2GhtWb3EjO0SbTpif3oNc6Ol8qIgYkA/7mAs
 gOLuGm3rz2rA5Oera4suGZKl5s/0AePxvrcYGePPLbY9a/sc1ciTktOegjcFwWCq9WOQ
 rmuAztECwMx/qh9qALdFAiKyLVVYih+oDoG0qsUz9v2ht2YowgNE+yG4bTQq8zLWe7zG
 XKVEzMS2XTyJDZnCmgAMbtUheRvIJ/vqbQI7lZceSM/F4ozvtiyTshYytnw6GCoJJ3Z0
 1bgrVIklJnfbqqRUy+cpy0c/6nIINQmLS9y1LBDGR4mQUf2lLNVdgi0daMZugSttsuBU
 fYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770900331; x=1771505131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nyR4nO1EwLufk5r5zVPXg8ODjYk83VQHLjsqtr0ZNXA=;
 b=C3+Vt1UtI71qtlsMKn480a7iQzX/eTu0KTL5bFvqUHeupniTuT1FOHyrfE23heKxM+
 vLa4E2kK9298ib4wCjl+XkR7SQXhwv89s3qfqA/jFhlax2Rbb2sj0Rmc5bJiDzBL9xgD
 Min5WvryeHMiAofWtnUKfZPPxLsfx5xmhAL2YYN4nhQKbMWWhstvs6DACeMji6GvWE0u
 gCtlh12yPWIqJUdh7iV8vTd+NcdulIOk9lU9Aycgal0lq7876AzxXngwlZslX8Nt/svu
 uedWS1cG/dRLGUrd0XLfB1v5czWMdurtv3PJSS/MHCm1aA+m3Z94UylNuer4cICBnTZV
 7XoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCcdiMgti2yZDRgyLDKANqxnjai3X0KNavWsnilzOut9FPkyR1NKf4DKTik6sNPMXEYe+/1sg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6jenHXrw/RnTJiSsTZN0cJbLdk6aOJE+z/TcLtufBa6vqu02s
 upXdAGVqreZeYSfx+gZs78zSXALrTjTFLlFYwhTNWqLZL6xbA99c1claP+HSa3LgBpFLVJo5k/P
 XK1Qr2sEcymZCmUQ+SIfIBX7Nlisf7Fr92FK+OaW27Q==
X-Gm-Gg: AZuq6aK0F9NTn48LPQFmjVTh5iaSI1tZCQqdJkAO3+z37bRySBpnVA6PMlKtzymANHF
 ujn1jjfdSMAmwRPSipGI3cYgCwg7Fa3f6y87Avmf85JSm268VgJWpxDEQ4D/Jb1K4gCWdgvDUPR
 QmGju+ZYucEUPiHrl8hA3lFXIQdC4wM81U5s6II6KISb2ZnjfRZGu9SxJeNP6pKsoOro0TuJq1u
 nWYBuwgRKW4+94C0hTDJesCVhGZ3ZM2U9kzuBLMIEfsx9mAQQzY2DDnhCK6wuMtzusN0MvvoY0O
 SD9RIrYU7FSDXUKtEjPgm29Zl0YPYM1+rCEWbPvKfI1n8ib5bmKe3+zeocxnNPHdWbluMLn/c6H
 WFOHfKrP4JewaqX+VYF9aMd/m18mEeEZfjrendHo/RyyC8EFVoaljxC25VueQRNFQisyBSfUce6
 +heuvl4nYcFPRYY6CG22+An7YeQ6ZH1jOYDZOtq0p6iTBQ+OkPxD/ELhtaYzn4/9xGsow3IYN3b
 jQkGmhtEOVYkOd1n2A37KfcFYnUzV5UA+aLuyM3gYKCPknhHSGTsRCAOUGuMUK1Ubd9O+/GwpmU
 bQ96cGVAI1n8w6+kUCvC8TKd0cxQFp2nZZ3n6wCT53dR
X-Received: by 2002:a05:690c:6904:b0:795:294c:fd4d with SMTP id
 00721157ae682-7973777b960mr26949447b3.37.1770900331439; Thu, 12 Feb 2026
 04:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
 <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
 <20260204161345.GY2603314@bill-the-cat>
 <CAC_iWj+qEmxNeGVBcLcrzNM=BkVj0QW2VYW6ZNGTKD6BeRTNHA@mail.gmail.com>
 <CAMDkj5yg24MwQz4G8Y62S7mB_6D=p+0Qrooe77RKQ+C4CPwA1Q@mail.gmail.com>
 <CAC_iWjKUqkjOFsk7+dj+7tn_hrbngoq4CyjCxg0xLbU=-X+GXA@mail.gmail.com>
 <CAMDkj5z0UuUi0qPfaykEVF=MmbEqXUup4GejaLAyJmg3PGByMg@mail.gmail.com>
In-Reply-To: <CAMDkj5z0UuUi0qPfaykEVF=MmbEqXUup4GejaLAyJmg3PGByMg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Feb 2026 14:44:54 +0200
X-Gm-Features: AZwV_QjtRYchTn8SXKukUrpzfZ146dTmdet46-4t935bzinmdiTuHBf9MW6LG5k
Message-ID: <CAC_iWjLqTObHeujWD_6Uix8i_6PZtPTJekVu6DShSwH2Kvobng@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Raymond Mao <raymondmaoca@gmail.com>
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

That's weird.

I tried again on -next and got this
Handle 0x0006, DMI type 9, 24 bytes
System Slot Information
Designation: Not Specified
Type: Unknown
Data Bus Width: Unknown
Current Usage: Unknown
Length: Unknown
Characteristics: Unknown
Bus Address: 0000:00:00.0
Data Bus Width (Base): 0
Peer Devices: 0
Height: Not applicable

Handle 0x0007, DMI type 16, 23 bytes
Physical Memory Array
Location: Unknown
Use: Unknown
Error Correction Type: Unknown
Maximum Capacity: 0 kB
Error Information Handle: Not Provided
Number Of Devices: 1

Handle 0x0008, DMI type 17, 104 bytes
Memory Device
Array Handle: 0x0000
Error Information Handle: Not Provided
Total Width: Unknown
Data Width: Unknown
Size: No Module Installed
Form Factor: <OUT OF SPEC>
Set: None
Locator: <BAD INDEX>
Bank Locator: <BAD INDEX>
Type: Unknown
Type Detail: Other Unknown Fast-paged Static Column Pseudo-static
RAMBus Synchronous

Handle 0x0009, DMI type 19, 31 bytes
Memory Array Mapped Address
Starting Address: 0x00000000000
Ending Address: 0x000000003FF
Range Size: 1 kB
Physical Array Handle: 0x0000
Partition Width: 1

Handle 0x000A, DMI type 32, 11 bytes
System Boot Information
Status: No errors detected

I am using a debian unstable with a 6.18 kernel

Cheers
/Ilias

On Thu, 12 Feb 2026 at 02:24, Raymond Mao <raymondmaoca@gmail.com> wrote:
>
> Hi Ilias
>
> On Wed, Feb 11, 2026 at 10:20=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 11 Feb 2026 at 16:30, Raymond Mao <raymondmaoca@gmail.com> wrot=
e:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > Apologies for the late reply.
> > > >
> > > > I did test the patches but I see something weird on smbios type 17.
> > > >
> > > > Handle 0x0008, DMI type 17, 104 bytes
> > > > Memory Device
> > > >         Array Handle: 0x0000
> > > >         Error Information Handle: Not Provided
> > > >         Total Width: Unknown
> > > >         Data Width: Unknown
> > > >         Size: No Module Installed
> > > >         Form Factor: <OUT OF SPEC>
> > > >         Set: None
> > > >         Locator: <BAD INDEX>
> > > >         Bank Locator: <BAD INDEX>
> > > >         Type: Unknown
> > > >         Type Detail: Other Unknown Fast-paged Static Column
> > > > Pseudo-static RAMBus Synchronous
> > > >         Speed: 512 MT/s
> > > >         Manufacturer: <BAD INDEX>
> > > >         Serial Number: Not Specified
> > > >         Asset Tag: Not Specified
> > > >         Part Number: Not Specified
> > > >         Rank: Unknown
> > > >         Configured Memory Speed: Unknown
> > > >         Minimum Voltage: Unknown
> > > >         Maximum Voltage: Unknown
> > > >         Configured Voltage: Unknown
> > > >         Memory Technology: <OUT OF SPEC>
> > > >         Memory Operating Mode Capability: None
> > > >         Firmware Version: Not Specified
> > > >         Module Manufacturer ID: Bank 3, Hex 0x04
> > > >         Module Product ID: Unknown
> > > >         Memory Subsystem Controller Manufacturer ID: Unknown
> > > >         Memory Subsystem Controller Product ID: Unknown
> > > >         Non-Volatile Size: 16383 PB
> > > >         Volatile Size: Unknown
> > > >         Cache Size: Unknown
> > > >         Logical Size: Unknown
> > > >
> > > > Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> > > > I tested this in QEMU
> > > >
> > >
> > > I just retested it by below qemu cmd after I rebased it to the curren=
t master:
> > > qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu cortex-a57 -=
m
> > > 2G  -nographic
> > >
> > > Below is the type17 I got:
> > > ```
> > > Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
> > > Memory Device:
> > > Physical Memory Array Handle: 0x0000
> > > Memory Error Information Handle: 0xfffe
> > > Total Width: 0x0000
> > > Data Width: 0x0000
> > > Size: 0xffff
> > > Form Factor: Unknown
> > > Device Set: 0x00ff
> > > Device Locator:
> > > Bank Locator:
> > > Memory Type: Unknown
> > > Type Detail: 0x0004
> > > Speed: 0x0000
> > > Manufacturer:
> > > Serial Number:
> > > Asset Tag:
> > > Part Number:
> > > Attributes: 0x0000
> > > Extended Size: 0x00000000
> > > Configured Memory Speed: 0x0000
> > > Minimum voltage: 0x0000
> > > Maximum voltage: 0x0000
> > > Configured voltage: 0x0000
> > > Memory Technology: Unknown
> > > Memory Operating Mode Capability: 0x0004
> > > Firmware Version:
> > > Module Manufacturer ID: 0x0000
> > > Module Product ID: 0x0000
> > > Memory Subsystem Controller Manufacturer ID: 0x0000
> > > Memory Subsystem Controller Product ID: 0x0000
> > > Non-volatile Size: 0xffffffffffffffff
> > > Volatile Size: 0xffffffffffffffff
> > > Cache Size: 0xffffffffffffffff
> > > Logical Size: 0xffffffffffffffff
> > > Extended Speed: 0x0000
> > > Extended Configured Memory Speed: 0x0000
> > > PMIC0 Manufacturer ID: 0x0000
> > > PMIC0 Revision Number: 0x0000
> > > RCD Manufacturer ID: 0x0000
> > > RCD Revision Number: 0x0000
> > > ```
> > >
> > > If you didn't use smbios_generic.dtsi to insert new nodes, or add new
> > > 'memory@' / 'memory-controller@' nodes into your DT, you should get
> > > the same result as mine by default.
> > > If you still can not get it, can you give me your build instruction
> > > and qemu cmd for reproducing?
> >
> > I used qemu_arm64_lwip_defconfig
> >
> > qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> >           -machine virt,secure=3Doff -bios u-boot.bin -chardev
> > socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> >           -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device
> > tpm-tis-device,tpmdev=3Dtpm0 \
> >           -device virtio-rng-pci -drive
> > id=3Dos,if=3Dnone,file=3D../debian.qcow2 -device virtio-blk-device,driv=
e=3Dos
> >  is the command line
> >
>
> I did these steps with a clean build (exactly the same as your ones):
> $ make O=3Dout_lwip qemu_arm64_lwip_defconfig
> $ CROSS_COMPILE=3Daarch64-none-linux-gnu- make O=3Dout_lwip -j4 all
> $ cd out_lwip
> $ killall swtpm
> $ rm -rf /tmp/mytpm1
> $ mkdir -p /tmp/mytpm1
> $ swtpm_setup --tpmstate /tmp/mytpm1 --tpm2 --pcr-banks sha256
> $ swtpm socket --tpmstate dir=3D/tmp/mytpm1 --ctrl
> type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock --log level=3D40 --tpm2 -t -d
> $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> -machine virt,secure=3Doff -bios u-boot.bin -chardev
> socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=
=3Dtpm0 \
> -device virtio-rng-pci -drive id=3Dos,if=3Dnone,file=3D../debian.qcow2
> -device virtio-blk-device,drive=3Dos
>
> SMBIOS type17 shows no difference:
> ```
> Handle 0x0008, DMI type 17, 104 bytes at 0x7e64b141
> Memory Device:
> Physical Memory Array Handle: 0x0000
> Memory Error Information Handle: 0xfffe
> Total Width: 0x0000
> Data Width: 0x0000
> Size: 0xffff
> Form Factor: Unknown
> Device Set: 0x00ff
> Device Locator:
> Bank Locator:
> Memory Type: Unknown
> Type Detail: 0x0004
> Speed: 0x0000
> Manufacturer:
> Serial Number:
> Asset Tag:
> Part Number:
> Attributes: 0x0000
> Extended Size: 0x00000000
> Configured Memory Speed: 0x0000
> Minimum voltage: 0x0000
> Maximum voltage: 0x0000
> Configured voltage: 0x0000
> Memory Technology: Unknown
> Memory Operating Mode Capability: 0x0004
> Firmware Version:
> Module Manufacturer ID: 0x0000
> Module Product ID: 0x0000
> Memory Subsystem Controller Manufacturer ID: 0x0000
> Memory Subsystem Controller Product ID: 0x0000
> Non-volatile Size: 0xffffffffffffffff
> Volatile Size: 0xffffffffffffffff
> Cache Size: 0xffffffffffffffff
> Logical Size: 0xffffffffffffffff
> Extended Speed: 0x0000
> Extended Configured Memory Speed: 0x0000
> PMIC0 Manufacturer ID: 0x0000
> PMIC0 Revision Number: 0x0000
> RCD Manufacturer ID: 0x0000
> RCD Revision Number: 0x0000
> ```
>
> By the way, I don't think it has any relationship with swtpm and the
> linux distro, so I also simply tried:
> $ qemu-system-aarch64 -m 1024 -smp 2 -nographic -cpu cortex-a57 \
> -machine virt,secure=3Doff -bios u-boot.bin
>
> All works with the same type17 output.
>
> Regards,
> Raymond
>
> > Cheers
> > /Ilias
> >
> >
> > >
> > > Regards,
> > > Raymond
> > >
> > >
> > > > Regards
> > > > /Ilias
> > > >
> > > > On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote:
> > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Anyone have a chance to review this patch set? It is the last p=
iece of
> > > > > > work to support all required SMBIOS types in U-Boot.
> > > > >
> > > > > I've been waiting for Ilias or Heinrich to have time to look at t=
his.
> > > > >
> > > > > --
> > > > > Tom
