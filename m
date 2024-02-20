Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45823C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E510087FBF;
	Tue, 20 Feb 2024 15:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c4eAxZ4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3318687FB5; Tue, 20 Feb 2024 15:47:23 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A68887FB0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KClTwm097218;
 Tue, 20 Feb 2024 06:47:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708433249;
 bh=DjBdYWL0mxCcp+ERtpWZ9VJA5XzDfBjf9w2B8Un4UYA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=c4eAxZ4w6i+m7ivtsOTIJ+TAQ9fj1ZJhAWbrvfuexSN6KDdrYyIjN89gtckT/mcox
 G8Tke38yIFZKeMfnmj5BTIvc2bHC43vtOrdVyqp7UoKAsMZyRO5pZuP6fU0vx1ZESI
 OItG6/r2DwTgLRPm9fXgIR+rxtqtM0lINZBTBPLU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KClTMs065017
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 06:47:29 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 06:47:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 06:47:29 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KClSil119280;
 Tue, 20 Feb 2024 06:47:28 -0600
Date: Tue, 20 Feb 2024 06:47:28 -0600
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Neha Francis
 <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@google.com>, Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew
 <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Andreas
 Dannenberg <dannenberg@ti.com>, Romain Naour <romain.naour@smile.fr>
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
Message-ID: <20240220124728.bbywtw254jgz3eee@obsession>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
 <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
 <e6222770-cbcd-45e2-94fe-eb55fb0a2f94@siemens.com>
 <5679ced7e927e1eb858a47d25abbd4025b4b67b7.camel@gmail.com>
 <dba0d25f-121d-4146-a78b-ac3beeeb1531@siemens.com>
 <782ea2c0-eef5-478d-a122-cc6e2d066762@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <782ea2c0-eef5-478d-a122-cc6e2d066762@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 08:48-20240220, Jan Kiszka wrote:
> On 19.02.24 19:37, Jan Kiszka wrote:
> > On 17.02.24 12:36, Alexander Sverdlin wrote:
> >> Hi Jan!
> >>
> >> On Sat, 2024-02-17 at 09:42 +0100, Jan Kiszka wrote:
> >>>> U-Boot 2024.01 (Feb 15 2024 - 01:43:17 +0100)
> >>>>
> >>>> SoC:   AM62X SR1.0 HS-FS
> >>>> Model: Texas Instruments AM625 SK
> >>>> DRAM:  2 GiB
> >>>> Core:  56 devices, 23 uclasses, devicetree: separate
> >>>> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> >>>> Loading Environment from nowhere... OK
> >>>> In:    serial@2800000
> >>>> Out:   serial@2800000
> >>>> Err:   serial@2800000
> >>>> Net:   eth0: ethernet@8000000port@1
> >>>> Hit any key to stop autoboot:  0 
> >>>> switch to partitions #0, OK
> >>>> mmc1 is current device
> >>>> SD/MMC found on device 1
> >>>> Failed to load 'uEnv.txt'
> >>>> Scanning for bootflows in all bootdevs
> >>>> Seq  Method       State   Uclass    Part  Name                      Filename
> >>>> ---  -----------  ------  --------  ----  ------------------------  ----------------
> >>>> Scanning global bootmeth 'efi_mgr':
> >>>> No EFI system partition
> >>>> No EFI system partition
> >>>> Failed to persist EFI variables
> >>>> Scanning bootdev 'mmc@fa00000.bootdev':
> >>>> Scanning bootdev 'mmc@fa10000.bootdev':
> >>>> Unknown uclass 'usb' in label
> >>>> link up on port 1, speed 100, full duplex
> >>>> BOOTP broadcast 1
> >>>> BOOTP broadcast 2
> >>>> BOOTP broadcast 3

I am pretty sure ethernet is not enabled in upstream u-boot.

> >>>> ...
> >>>> ---
> >>>>
> >>>> I suppose TI's BSP has older U-Boot... So it's not providing necessary
> >>>> script for BOOTSTD, I suppose?
> >>>>
> >>>
> >>> You can make the BeagleBone boot via EFI, but it requires a hybrid
> >>> partition table (ROM loader want DOS, EFI needs GPT). A Debian
> >>> integration with this can be found for Isar [1] in this series [2]. It's
> >>> only using upstream sources (plus still one u-boot patch to get wifi
> >>> working).
> >>>
> >>> If you want legacy script booting, I suspect you need to flip some extra
> >>> switches explicitly by now.
> >>
> >> Thanks for the hints!
> >> I'm wondering, if this was a deliberate "let's stop booting all the
> >> pre-existing embedded distros" decision? (buildroot, yocto/meta-ti...)

It was more of a "lets standardize one way of booting across all ARM
devices as much as we can" effort - EBBR and others inclusive. To that
effort,  distro_boot and bootstd have made significant steps forward.
NOTE: yocto, buildroot etc will need a few tweaks to get things
operational unfortunately. BUT, note: bootstd was what beagleplay was
introduced upstream as default in the first place - so all we are
finding is that introduced behavior.

> >>
> > 
> > FWIW, I'm not seeing other boot methods being specifically disabled in
> > beagleplay in 2024.01 or even newer. I didn't try the result, but this
> > may actually be some other issue and real bug, nothing obviously intended.
> > 
> 
> I'm not even sure about this anymore, though there is still a bug, just 
> a different one:
> 
> ...
> U-Boot 2024.04-rc2-00040-g3e6f2a94bfc (Feb 20 2024 - 08:42:59 +0100)
> 
> SoC:   AM62X SR1.0 GP
> Model: BeagleBoard.org BeaglePlay
> DRAM:  2 GiB
> Core:  98 devices, 27 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1, mmc@fa20000: 2
> Loading Environment from nowhere... OK
> In:    serial@2800000
> Out:   serial@2800000
> Err:   serial@2800000
> Net:   No ethernet found.
> 
> Press SPACE to abort autoboot in 2 seconds
> => print bootmeths 
> bootmeths=script extlinux efi pxe
> => bootflow scan -l
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------  ----------------
> Scanning bootdev 'mmc@fa00000.bootdev':
>   0  efi          ready   mmc          2  mmc@fa00000.bootdev.part_ efi/boot/bootaa64.efi
> Scanning bootdev 'mmc@fa10000.bootdev':
>   1  extlinux     ready   mmc          1  mmc@fa10000.bootdev.part_ /extlinux/extlinux.conf
> Unknown uclass 'usb' in label
> "Synchronous Abort" handler, esr 0x86000004, far 0x3030303030303840
> elr: 3030302fb0bc0840 lr : 3030302fb0bc0840 (reloc)
> elr: 3030303030303840 lr : 3030303030303840
> x0 : 00000000ffffffed x1 : 0000000000000000
> x2 : 0000000000000002 x3 : 00000000ffb49d30
> x4 : 00000000fffd4c00 x5 : 00000000ffb49d50
> x6 : 0000000000000000 x7 : 00000000ffb4e890
> x8 : 0000000000006924 x9 : 00000000ffb1212c
> x10: 0000000000000003 x11: 0000000000006914
> x12: 00000000ffb1221c x13: 00000000ffb12b40
> x14: 00000000ffb12b40 x15: 00000000ffb12535
> x16: 00000000fff8a9d4 x17: 0000000000000000
> x18: 00000000ffb23da0 x19: 0000314074726f70
> x20: 00000000fffed000 x21: 00000000fffef000
> x22: 0000000000000000 x23: 00000000fffef000
> x24: 00000000fffef000 x25: 0000000000000000
> x26: 00000000fffc7174 x27: 0000000000000000
> x28: 0000000000000000 x29: 74656e7265687465
> 
> Same with 2024.01 release.

boot_targets=mmc1 mmc0 usb pxe

networking ran into some significant challenges. I was hoping to get
networking merged but the series got offset and network never made it..
Dropping pxe from boot_targets

=> setenv boot_targets mmc1 mmc0 usb
=> print bootmeths
bootmeths=script extlinux efi pxe
=> print boot_targets
boot_targets=mmc1 mmc0 usb
=> bootflow scan -l
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------  ----------------
Scanning bootdev 'mmc@fa00000.bootdev':
  0  extlinux     ready   mmc          1  mmc@fa00000.bootdev.part_ /extlinux/extlinux.conf
Scanning bootdev 'mmc@fa10000.bootdev':
  1  extlinux     ready   mmc          1  mmc@fa10000.bootdev.part_ /extlinux/extlinux.conf
Unknown uclass 'usb' in label
No more bootdevs
---  -----------  ------  --------  ----  ------------------------  ----------------
(2 bootflows, 2 valid)
=>



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
