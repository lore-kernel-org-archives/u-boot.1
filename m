Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C4D68BFA
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 13:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983728904E;
	Sun, 17 Nov 2024 14:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jfOaFIhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2242888F8E; Sun, 17 Nov 2024 14:04:44 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE7E88F8E
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 14:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa2099efdc3so627331666b.1
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 05:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731848681; x=1732453481; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4XlU2/lgz2ubgqDMM5I95mya5plcb+DgxEgPk+Flmk=;
 b=jfOaFIhUQnu6QTBDoNvLfwH2+cANnn3W9DXuwOU5LdxhuXr2dT389ftZJB/+92j4NV
 Ss+brYeWuhwZ48Hu8NGeqT8oCHCHIuMbjVpWEIfZiFprBkJHgBYrHPZB2Q5bz/+ZKcMk
 e6v/RXP7TH7TVHYPAl4RWZvOPNTmUeMWDsP3kATGpSWoenmVz7rZ7uOIq02AzDaU75mw
 Dyuo9dbGdg3yFzF/kr3w8FUCNehMLneOPqGXYU8fOyIwGbauGDujcRz9n9cx1t10Q4Y/
 uIRzzG6R+ij7ONHCNkD31sWpBr4uUwOQ8IJUYE9cGQHfzNCxovCWDjNdSrvr07+81udN
 p3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731848681; x=1732453481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4XlU2/lgz2ubgqDMM5I95mya5plcb+DgxEgPk+Flmk=;
 b=hP42dqMyDvSB15r8OrOCXFK43ZSS3Ufpe3d+ZH4RC+waaNwGwCLzHwycCiH6DGMYly
 KYEUKwKZ9tLBD83XPEWDNMil/4vPOmKkh8VPaDjvTJ8rBUdsOOudydSDu5mFk43L3Ff3
 t7Rk9gyX9sjsdpOAOigvUf0TG/gm6gG3FP9oBFUF6HjbgwIi2B2mimpY0ZSIWE1i6p3J
 kqaNbzPeiY1M2QvRDH1rfhzIdVJNBU3tdGasE78btj0ARImE1ww8PR7iZcwdPG/bie5V
 7olmwHDmqxf6MpzdCdM8BuFECK0/soU00pQTj+8Op2OxIjm9gbD91Cfr1MS1MatmXj5v
 tqGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbj7Kr85azixpIftmqc55qU1DfmOs5eW0bGmjOtud9fz9iPytw3lHHsx369Wphkhw2gJxJLdg=@lists.denx.de
X-Gm-Message-State: AOJu0YwjuNcxve/piezB6yFet3KscPWFpz58WeSkqOFhXRA2VzEKNmfM
 y93AXMmWLooSUNnFEVQqHe08lQcLi/S0587gIwe01OAVnn47KjGnRTTFs8g6ndfjP+2V3Q+3jBv
 8nuDnIFzyf+rhrvvUSfgP5kCFYy4=
X-Google-Smtp-Source: AGHT+IGpSPIoB7UTMcjPqKtwq1SNv4Kc1xNkx4WxMLTMqXtaX+WQjox0XI2AmA1lPRKasLnOeBPUablLboKlZkvFaJ8=
X-Received: by 2002:a17:907:86ac:b0:a9e:c440:2c9f with SMTP id
 a640c23a62f3a-aa2077daae2mr1203984166b.19.1731848680757; Sun, 17 Nov 2024
 05:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <CANAwSgSDjcDU-BUm7fNGC+GzaCTVVitL_jG6t0QQR0kM70Mfyw@mail.gmail.com>
 <CANV2PTOkxY0-Xa9d2ctjROHtiM_YSbjR0Z4LpywEduXFFJHL_g@mail.gmail.com>
In-Reply-To: <CANV2PTOkxY0-Xa9d2ctjROHtiM_YSbjR0Z4LpywEduXFFJHL_g@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 17 Nov 2024 18:34:24 +0530
Message-ID: <CANAwSgSHStTMucMeriXzudro5xSE8S6eaZkmXFHrZg3OdV1egg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Support OF_UPSTREAM for StarFive JH7110
To: E Shattow <lucent@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

Hi E Sattow,

I realize now that my question was outside the scope of the patches series.
Thank you for providing more details.

On Thu, 14 Nov 2024 at 23:07, E Shattow <lucent@gmail.com> wrote:
>
> Hi Anand,
>
> On Wed, Nov 13, 2024 at 8:42=E2=80=AFPM Anand Moon <linux.amoon@gmail.com=
> wrote:
> >
> > Hi Hal,
> >
> > On Mon, 11 Nov 2024 at 07:53, Hal Feng <hal.feng@starfivetech.com> wrot=
e:
> > >
> > > This patchset add OF_UPSTREAM support for StarFive JH7110 based board=
s.
> > > All the JH7110 based boards can use the DT from upstreaming linux ker=
nel.
> > > The v1.3b board device tree is set as the default device tree. Suppor=
t
> > > CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using=
 the
> > > EEPROM information.
> > >
> >
> > I am encountering an issue with my Milk-V CM. I am unable to use the
> > SD card with the CM4 IO board.
> > The onboard SPI switch does not support a boot configuration switch,
> > so the default boot is set to eMMC.
>
> Mars CM and Mars CM Lite are not able to boot from eMMC and SD Card.
> There is transistor logic on Mars CM and Mars CM Lite which only
> allows UART or SPI NOR Flash depending on the state of nRPIBOOT.
>
> Perhaps you are thinking of SPI NOR Flash boot of JH7110 which is
> jumping execution to SPI NOR Flash offset 0 where, presumed it is
> where you have U-Boot SPL?
>
> From then U-Boot SPL may load U-Boot Main payload depending on the
> state of configuration switch, so then UART for UART setting, or SPI
> NOR Flash at 0x100000 offset for SPI NOR Flash setting.
>
> U-Boot Main may then execute as normal including SD Card or eMMC. This
> is distinct from the concept of JH7110 zeroth boot loader in mask ROM
> loading from SD Card or eMMC.
>
> >
> > Please suggest a method to flash an image onto the eMMC on the CM board=
.
>
> This will not work with the OF_UPSTREAM patch set of topic (yet)
> because simply Mars CM and Mars CM Lite devicetree do not exist
> upstream.
>
> You may use U-Boot stable release v2024.10 as a recovery tool to flash
> U-Boot v2024.10 into SPI NOR Flash which, exclusive of this
> OF_UPSTREAM patch series, has some runtime fix-up adjusting the Milk-V
> Mars devicetree for Mars CM or Mars CM Lite depending on EEPROM
> content.
>
> For that to work you will also need to verify and perhaps adjust the
> EEPROM content of your Mars CM for accuracy per the advisory from
> Milk-V; from what information you have shared you may have a 4GB RAM
> model with 16GB eMMC and if that is accurate then no change to the
> EEPROM content is needed.
>
> When you have for example U-Boot v2024.10 installed to SPI NOR Flash
> and it does have the fix-up at runtime to allow functional eMMC, then
> you may use any of the methods available to that version of U-Boot:
>
> 1. You can load data from TFTP to DRAM address for write operation
> onto the eMMC directly but you will have to invent some scripting to
> do the required math between byte counts and block unit offsets.
> 2. You can load an OS from TFTP to DRAM and boot; for example the
> Debian debian-installer netinst Linux kernel and initial ramdisk.
> 3. There is not any working JH7110 on-CPU USB driver in U-Boot
> v2024.10 so the use of USB (as a reasonable person would attempt) is
> not possible. Patches exist for this and is something that will be
> possible in future but not yet. You will note that if your Mars CM is
> installed to a carrier board that has additionally a VL805 USB
> controller on the PCI bus then USB may actually work because the
> VisionFive2 has this same PCI+VL805 for USB. It is not typical though
> for CM4 carrier boards... but I recall reading that they do exist so
> worth a mention here.
>
Yes, I need to set up TFTP boot to resolve my issue.
Let me give this a try.
> >
> > I have tried the instructions to update the firmware using
> > [1] https://milkv.io/docs/mars/compute-module/boot
>
> Milk-V USB flash tool at the link loads a closed-source SPL binary via
> JH7110 UART configuration that postures as a USB endpoint (using the
> JH7110 on-CPU USB function) and the companion software that talks to
> it is "compiled" closed-source python. Make your own conclusion...
> mine is that U-Boot+TFTP is good enough and preferentially it is open
> source.
>
> See:
>
> https://docs.u-boot.org/en/v2024.10/board/starfive/milk-v_mars_cm.html
>
> https://github.com/geerlingguy/sbc-reviews/issues/22#issuecomment-1908676=
618
Cool, thanks for sharing this link. This blog shares almost all the cases
needed to resolve my issue so I will try it.
>
> https://milkv.io/docs/mars/compute-module/update-eeprom
>
> >
> > Thank you so much for your help.
> >
> > Thanks
> > -Anand
> >
> > --------EEPROM INFO--------
> > Vendor : MILK-V
> > Product full SN: MARC-V10-2340-D004E016-00000812
> > data version: 0x2
> > PCB revision: 0xc1
> > BOM revision: A
> > Ethernet MAC0 address: 6c:cf:39:00:85:6b
> > Ethernet MAC1 address: 6c:cf:39:00:85:6c
> > --------EEPROM INFO--------
> >
> > starfive_7110_pcie pcie@940000000: Starfive PCIe bus probed.
> > starfive_7110_pcie pcie@9c0000000: Starfive PCIe bus probed.
> > In:    serial@10000000
> > Out:   serial@10000000
> > Err:   serial@10000000
> > Net:   Could not fetch index
> > Could not fetch index
> > eqos_probe_resources() failed: -22
> > Could not fetch index
> > eqos_probe_resources() failed: -22
> > eth1: ethernet@16040000
> > starting USB...
> > Bus xhci_pci: Register 5000420 NbrPorts 5
> > Starting the controller
> > USB XHCI 1.00
> > scanning bus xhci_pci for devices... Resetting EP 0...
> > 3 USB Device(s) found
> >        scanning usb for storage devices... 1 Storage Device(s) found
> > Working FDT set to ff725a10
> > Hit any key to stop autoboot:  0
> > StarFive # mmc info
> > Device: mmc@16010000
> > Manufacturer ID: 15
> > OEM: 0
> > Name: AJTD4R
> > Bus Speed: 45333334
> > Mode: MMC High Speed (52MHz)
> > Rd Block Len: 512
> > MMC version 5.1
> > High Capacity: Yes
> > Capacity: 14.6 GiB
> > Bus Width: 8-bit
> > Erase Group Size: 512 KiB
> > HC WP Group Size: 8 MiB
> > User Capacity: 14.6 GiB WRREL
> > Boot Capacity: 4 MiB ENH
> > RPMB Capacity: 4 MiB ENH
> > Boot area 0 is not write protected
> > Boot area 1 is not write protected
> > StarFive # mmc rescan
> > StarFive # mmc rescan
> > StarFive #
> > StarFive # mmc part
> > ## Unknown partition table type 0
>
> I will say on-topic that although it is a regression in functionality
> for U-Boot from the v2024.10 stable release to apply OF_UPSTREAM
> series, the absence of Mars CM and Mars CM Lite should not be blockers
> for OF_UPSTREAM patch set. It is time to submit these upstream (to
> Linux kernel) which is not our problem here, and besides this there
> are more JH7110 board support devicetree being accepted upstream which
> are not represented here now. The missing functionality will be
> restored after this is done.
>
Alright, I will now flash v2024.10 to address the issue
> All users who want to have working Mars CM and Mars CM Lite should
> stay with U-Boot stable version v2024.10, and to focus on contributing
> with Linux upstream for these boards.
>
Go that.
> -E

Thanks
-Anand
