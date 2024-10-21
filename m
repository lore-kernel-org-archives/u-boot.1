Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033BCD3C53F
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 06:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D51F88F8E;
	Mon, 21 Oct 2024 08:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzJy26e1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3845892B8; Mon, 21 Oct 2024 08:06:23 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9456F8895E
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7180f2f5fb0so1912498a34.1
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729490780; x=1730095580; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0kpkkO2tAHX0Y2BVMhkWR0IAL/ncG6cMy4SJDwcpVg=;
 b=dzJy26e1lSMcP9GAdCPPBbc/7WCDUmCyr9sOPnwq+IrINTPPg1k/3bmxiGLCc5G09N
 JNFwa7vbiFNx2Pak0FcLHsIka4bu6EUQtx4Z28H4MPAdd33NK6BLM+BrBB2UaLRwdzxa
 QF1ZqNP/WS8sn313YQPFFXRBhB3kSeLOQgrOn6QctJp4HTRxvN7ofG/1a/YpqmcoetEb
 ePrZKSjVHLvGRDvUH7u90ZPzMkQrj1a0V0fT728IuL8otFoOWsoEuTiQS3EgVii9XyFl
 OVaT3XHXV6W02/8X9FIPLnyKR7ow3nxBNsvfm/RNCGnWJKA3RLvoFa+oFWCL+4QvHCsp
 QwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729490780; x=1730095580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0kpkkO2tAHX0Y2BVMhkWR0IAL/ncG6cMy4SJDwcpVg=;
 b=uWBNAW+MB6mjJKUkHjnmTra12ndqNwFfNHuR19k9y+S93vABB8TuQkqNL1c35QRRZ0
 U36q+9kePEwQAKk1WSnF98Js2OudiMr/aFCXrhmqqZZZo19JBucT4Tha+cH3qvehI/oW
 vcDsX2zvDZZamsKJNM+oPEhWSD/s+f90SV6DNsxAoYP3/XrvVKCx5ni/JEIUnRimvCOu
 qytxPC4ua1YjkY3kGorDPxVo1hODbYZHS7D55TsmhoPECph6ws5v3T6EYfqfQzs5G+ox
 wW47hRlLwJWVFC+qdKQ5jFQWFIVe1Cl+FCCteX1aDHXkL5/itLZ326d5uPxHTnXYrPRl
 fNFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQmAOl6lB5uuJi+armKZ/tjxiSf+ECSYga5QX3F3iCSvMUFx5b+pJnqqXqt4pt27zuSIYaGUg=@lists.denx.de
X-Gm-Message-State: AOJu0YxhdbIHUHj8NTIfvSLAR/Ny2wpeU+zbe++Iz+OhWWuopBToZ0VR
 07hiWQh3kLBJXeGP+SnSWk8vG6t/dF5mE/wdCWvAW+TNNaG+1LR7YFytowl9RXdXdOGV7JuiIE5
 +CDek8IvbtzoeSVULAdW87Si+uH2B90HS
X-Google-Smtp-Source: AGHT+IExt5ifIlSBALHP7h0A6EQ2u0MqnGSRGKwq7G7V0UhcHBnyS/cjXojhBgC+mK05zbw/cjKJXPX+TUC3DAYZnCw=
X-Received: by 2002:a05:6870:568d:b0:270:74f2:8e97 with SMTP id
 586e51a60fabf-2892c2d086cmr7404862fac.15.1729490780161; Sun, 20 Oct 2024
 23:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <CANAwSgRJO1=w40ybTHkq-BD78rPyf13JdWp_yL1qpu=xmO2V8Q@mail.gmail.com>
 <20241015183142.GQ53053@bill-the-cat>
 <CANAwSgT0ng5R73D8jWS9MzeBJBcZT6vjgmade_d5Zoyuoe-C_A@mail.gmail.com>
 <CADg8p97=48JcJKnBZjqEth0RtJbnwQJZ2p3mJT5T-L4x1MSdQw@mail.gmail.com>
In-Reply-To: <CADg8p97=48JcJKnBZjqEth0RtJbnwQJZ2p3mJT5T-L4x1MSdQw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 21 Oct 2024 11:36:04 +0530
Message-ID: <CANAwSgQ+gPi5f0UdN3aLWa68pCBd7P52P2aw+4u+zYJ+nAEDMQ@mail.gmail.com>
Subject: Re: risc-v - efi_free_pool: illegal free
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh

On Wed, 16 Oct 2024 at 13:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 16 Oct 2024 at 10:35, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Tom.
> >
> > On Wed, 16 Oct 2024 at 00:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 12:00:01AM +0530, Anand Moon wrote:
> > >
> > > > Hi All,
> > > >
> > > > I am trying to create a RISC-V Archlinux image for the StarFive
> > > > VisionFive 2 v1.3B SBC.
> > > > Everything worked well initially, and I successfully until I upgrad=
ed
> > > > OpenSBI and U-Boot
> > > > to the latest versions.
> > >
> > > Sorry for the problems, this is known and will be fixed shortly.
> > >
> > Just wanted to submit a report.
> > > --
> > > Tom
> >
> > I have tried to build a u-boot with tag v2024.10, it's a success.
>
> Can you rebase and try with the latest -master. It should work now. Thank=
s.
>
> -sughosh
>
I do not observe this issue in the latest U-boot,
Thanks for fixing the problem.

Thanks
-Anand

-------------------
Hit any key to stop autoboot:  0
StarFive # sf probe
SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16=
 MiB
StarFive # fatload mmc 1:3 $kernel_addr_r u-boot.itb
1022723 bytes read in 66 ms (14.8 MiB/s)
StarFive # sf update $kernel_addr_r 0x100000 $filesize
device 0 offset 0x100000, size 0xf9b03
969475 bytes written, 53248 bytes skipped in 7.529s, speed 139024 B/s
StarFive # fatload mmc 1:3 $kernel_addr_r u-boot-spl.bin.normal.out
142770 bytes read in 13 ms (10.5 MiB/s)
StarFive # sf update $kernel_addr_r 0x0 $filesize
device 0 offset 0x0, size 0x22db2
142770 bytes written, 0 bytes skipped in 0.744s, speed 195449 B/s
StarFive # reset
resetting ...
=E2=96=92
U-Boot SPL 2024.10-01138-gfa0ed06a749c (Oct 21 2024 - 15:41:04 +0530)
DDR version: dc2e84f0.
Trying to boot from SPI


U-Boot 2024.10-01138-gfa0ed06a749c (Oct 21 2024 - 15:41:04 +0530)

CPU:   sifive,u74-mc
Model: StarFive VisionFive 2 v1.3B
DRAM:  8 GiB
Core:  136 devices, 26 uclasses, devicetree: board
WDT:   Not starting watchdog@13070000
MMC:   mmc@16010000: 0, mmc@16020000: 1
Loading Environment from SPIFlash... SF: Detected gd25lq128 with page
size 256 Bytes, erase size 4 KiB, total 16 MiB
*** Warning - bad CRC, using default environment

StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : StarFive Technology Co., Ltd.
Product full SN: VF7110B1-2253-D008E000-00002905
data version: 0x2
PCB revision: 0xb2
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:38:7b
Ethernet MAC1 address: 6c:cf:39:00:38:7c
--------EEPROM INFO--------

starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
starting USB...
Bus xhci_pci: Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
scanning bus xhci_pci for devices... 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Working FDT set to ff72da20
Hit any key to stop autoboot:  0
Card did not respond to voltage select! : -110
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'nvme 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=3D-14)
Card did not respond to voltage select! : -110
** Booting bootflow 'mmc@16020000.bootdev.part_3' with extlinux
1:      Arch Linux Risc-V
Retrieving file: /Image
Retrieving file: /initramfs-linux.img
append: root=3DUUID=3Dec7facf2-7c69-4ff6-96ae-49f63c054fe0 rw console=3Dtty=
1
console=3DttyS0,115200 earlycon rootwait swiotlb=3D65536
nvme_core.default_ps_max_latency_us=3D2000
Retrieving file: /dtbs/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb
## Flattened Device Tree blob at 46000000
   Booting using the fdt blob at 0x46000000
Working FDT set to 46000000
   Loading Ramdisk to fdd20000, end fe7295bf ... OK
   Loading Device Tree to 00000000fdd13000, end 00000000fdd1f480 ... OK
Working FDT set to fdd13000

Starting kernel ...

[    0.000000][    T0] Linux version 6.12.0-rc4-4-ARCH-RISC-V
(amoon@anand-m920q) (riscv64-linux-gnu-gcc (GCC) 14.2.0, GNU ld (GNU
Binutils) 2.43.1) #2 SMP PREEMPT_RT Mon Oct 21 16:19:57 IST 2024
[    0.000000][    T0] Machine model: StarFive VisionFive 2 v1.3B
[    0.000000][    T0] SBI specification v2.0 detected
[    0.000000][    T0] SBI implementation ID=3D0x1 Version=3D0x10005
[    0.000000][    T0] SBI TIME extension detected
[    0.000000][    T0] SBI IPI extension detected
[    0.000000][    T0] SBI RFENCE extension detected
[    0.000000][    T0] SBI SRST extension detected
[    0.000000][    T0] SBI DBCN extension detected
[    0.000000][    T0] efi: UEFI not found.
[    0.000000][    T0] OF: reserved mem:
0x0000000040000000..0x000000004003ffff (256 KiB) nomap non-reusable
mmode_resv1@40000000
[    0.000000][    T0] OF: reserved mem:
0x0000000040040000..0x000000004005ffff (128 KiB) nomap non-reusable
mmode_resv0@40040000
[    0.000000][    T0] cma: Reserved 16 MiB at 0x00000000ff000000 on node -=
1
[    0.000000][    T0] earlycon: uart0 at MMIO32 0x0000000010000000
(options '115200n8')
[    0.000000][    T0] printk: legacy bootconsole [uart0] enabled
[    0.000000][    T0] NUMA: Faking a node at [mem
0x0000000040000000-0x000000023fffffff]
[    0.000000][    T0] NODE_DATA(0) allocated [mem 0x23fdbf500-0x23fdc1e7f]
[    0.000000][    T0] Zone ranges:
[    0.000000][    T0]   DMA32    [mem 0x0000000040000000-0x00000000fffffff=
f]
[    0.000000][    T0]   Normal   [mem 0x0000000100000000-0x000000023ffffff=
f]
[    0.000000][    T0]   Device   empty
[    0.000000][    T0] Movable zone start for each node
[    0.000000][    T0] Early memory node ranges
