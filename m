Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD14EE0212
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 00:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3690D869E1;
	Thu, 14 Sep 2023 02:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Htoh2Vek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB18869CA; Thu, 14 Sep 2023 02:27:42 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D613A869E1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 02:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5007616b756so599705e87.3
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694651258; x=1695256058; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTJwCMl6oRNEFrv8czX+Sqd0PHncFNE4gTW1gmIBogg=;
 b=Htoh2VekqmFWWOvyV0QiwiDgIk3BfWOzUBQuc3fWX75F1xySTzdZRvj/RsnsVlJ8Of
 hTE4AJB1iz0PKbbBX9rLw5B/V25nLWCoODX5L4ddIgn0gsg7NZVDwblnmVOVzObjMwUU
 7izjjoNmz5Tt8MeXdGDyttYKY5ad5VuHuCE07qEtU2mycAoQqjb2drefsCkTzD29kDwq
 LFN0h3Vi6YyAD9uIsb6uX7wS1ndxKz3HwNpckMNjt/jcSYr+88WmuRrwsNqJrplr9bXf
 a7eRoitC7IuQfPmbCDiNicrahbZy0wKjEHC1YyzSzrms/uvXIDQYXavLm8TY356QxKLV
 wTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694651258; x=1695256058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTJwCMl6oRNEFrv8czX+Sqd0PHncFNE4gTW1gmIBogg=;
 b=k6PYaw9bcXim6CmjbdxRmGeiRL6+0ph8axuKNYf/iPIyTzUqRKUzhYL5eVQ92WK9UP
 h8adcOD5pdcWjVL7dPsQZDdx3VOQNvcHr6bKQXg1hK8cyY4OJafWRJD5/c6w+1p10lFP
 ZIzinXZao6T7m2nwr0uagKvwP4hlL3AClZ9oD3L8rWQ36Fl+UaOov3ceUrs/oWPYiwDV
 R+oaYzmFrf0aHTxj1lcjkD38zbOCCnLeziFvaHCm9NMKYdfXA1S4RqykAUGaxf5SkzOn
 qHTWiGcQH1w9M6qYRLy31DnXVr/okLeeUzbHFQCMqycEcbbn/jN1zPVUz+TIGQfwgjff
 OjBg==
X-Gm-Message-State: AOJu0YymQxX5Jga0IofPjq7aZA7ThfYZvF1E3MGnasM0uF+t3tEDdjwr
 m20FGXzrErdd0o1uQuSPJmNX78G28VDOQJ0NdRQ=
X-Google-Smtp-Source: AGHT+IHGZVGDbpBibIZL42xiDgaxdDZXHI426f9+Vxps+P2kRrz2/w5JgwekjPfCa5IWXehArSduuI2jHv2G4TsW06M=
X-Received: by 2002:a19:e04e:0:b0:4fd:d92e:31ca with SMTP id
 g14-20020a19e04e000000b004fdd92e31camr2900494lfj.36.1694651257731; Wed, 13
 Sep 2023 17:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
 <20230913162217.GN305624@bill-the-cat>
 <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
 <20230913201355.GR305624@bill-the-cat>
In-Reply-To: <20230913201355.GR305624@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 13 Sep 2023 17:27:25 -0700
Message-ID: <CAJaLiFyE7-Rtcn98yLpBVexG+QS96f9sX+NOYu1YqW_-35_40g@mail.gmail.com>
Subject: Re: bootstd: CACHE Misaligned operation errors (Marvell Armada 385)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
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

Hi Tom,

On Wed, Sep 13, 2023 at 1:13=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Sep 13, 2023 at 12:56:53PM -0700, Tony Dinh wrote:
> > Hi Tom,
> >
> > On Wed, Sep 13, 2023 at 9:22=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:
> > >
> > > > I've been testing the boostd for a few Marvell boards and seeing th=
is
> > > > error on the Thecus N2350 (Marvell Armada 385, dual-core CPU). The
> > > > "bootflow scan scsi" command triggered the "CACHE: Misaligned
> > > > operation at range" error. However, this error did not affect the
> > > > result of the scan, i.e. the bootflow for scsi partition was create=
d
> > > > correctly, and u-boot is running normally.
> > > >
> > > > Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogether.
> > > > Perhaps this is a case where the DCACHE is not required and should =
be
> > > > turned off?
> > > >
> > > > Please see the log after the break below.
> > >
> > > Can you please try -next ?  There's at least one SCSI related cache
> > > alignment fix there that's not in master, thanks.
> >
> > Unfortunately I got the same errors. This time the ranges are
> > different, of course.
> >
> > master:
> >
> > N2350 > bootflow scan scsi
> > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3f=
b99f88
> > ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb=
9a388
> >
> > next:
> >
> > N2350 > bootflow scan scsi
> > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3f=
b80388
> > ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb=
80788
>
> Can you debug to where these calls are so we can align these buffers?
> See 02660defdc8a ("scsi: Cache align temporary buffer") for an example.

I've added some printfs to the code. Looks like the last calls were
SCSI_READ16 (0x48) in this sequence:
scsi_exec() --> ahci_scsi_exec() --> ata_scsiop_read_write()

Note that the misaligned errors do not always occur.

I've also looked at the other recent commit by Marek and tried to
enable CONFIG_BOUNCE_BUFFER:
https://github.com/u-boot/u-boot/commit/4f543e82b9831333bc0effe9540d8e6a9dd=
e3cb5
But I think it is a noop without a callback from the driver.

Please see the boot log below after the break.

Thanks,
Tony

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

U-Boot 2023.10-rc4-tld-1-00284-gce67ba1e30-dirty (Sep 13 2023 - 16:44:56 -0=
700)
Thecus N2350

SoC:   MV88F6820-A0 at 1066 MHz
DRAM:  1 GiB (533 MHz, 32-bit, ECC not enabled)
Core:  65 devices, 23 uclasses, devicetree: separate
NAND:  512 MiB
MMC:
Loading Environment from SPIFlash... SF: Detected mx25l3205d with page
size 256 Bytes, erase size 4 KiB, total 4 MiB
*** Warning - bad CRC, using default environment

Model: Thecus N2350
Net:
Warning: ethernet@70000 (eth0) using random MAC address - a2:6f:f1:4a:2e:51
eth0: ethernet@70000
Hit any key to stop autoboot:  0

N2350 > env def -a
## Resetting to default environment

N2350 > bootdev l
Seq  Probed  Status  Uclass    Name
---  ------  ------  --------  ------------------
  0   [   ]      OK  ethernet  ethernet@70000.bootdev
---  ------  ------  --------  ------------------
(1 bootdev)

N2350 > bootdev hunt scsi
Hunting with: scsi
pcie0.0: Link down
pcie1.0: Link down
scsi_scan
scanning bus for devices...
scsi_scan_dev
SATA link 0 timeout.
Target spinup took 0 ms.
AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
flags: 64bit ncq led only pmp fbss pio slum part sxs
do_scsi_scan_one
scsi_detect_dev
scsi_setup_inquiry
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x12
do_scsi_scan_one
scsi_detect_dev
scsi_setup_inquiry
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x12
scsi_ident_cpy
scsi_ident_cpy
scsi_ident_cpy
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x0
scsi_read_capacity
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x25
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x28
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x28
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x28
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x28
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x28
ata_scsiop_read_write
  Device 0: (1:0) Vendor: ATA Prod.: ST750LX003-1AC15 Rev: SM12
            Type: Hard Disk
            Capacity: 715404.8 MB =3D 698.6 GB (1465149168 x 512)

N2350 > bootflow scan scsi
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x28
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x28
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ata_scsiop_read_write
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ata_scsiop_read_write
CACHE: Misaligned operation at range [3fb6f8d8, 3fb6fcd8]
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ata_scsiop_read_write
CACHE: Misaligned operation at range [3fb6f8d8, 3fb6fcd8]
CACHE: Misaligned operation at range [3fb6f8d8, 3fb6fcd8]
CACHE: Misaligned operation at range [3fb6f8d8, 3fb6fcd8]
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb6f8=
d8
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb6fcd=
8
CACHE: Misaligned operation at range [3fb6f8d8, 3fb6fcd8]
CACHE: Misaligned operation at range [3fb6f8d8, 3fb6fcd8]
ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb6f8=
d8
ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb6fcd=
8
scsi_exec
ahci_scsi_exec
ahci_scsi_exec cmd =3D 0x48
ata_scsiop_read_write
** File not found /boot/boot.bmp **




>
> --
> Tom
