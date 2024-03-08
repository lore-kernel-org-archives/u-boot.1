Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5E4C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 21:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0839287D39;
	Fri,  8 Mar 2024 22:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V/6ZuoMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8799187D3D; Fri,  8 Mar 2024 22:48:45 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BF487CF1
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 22:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7dad83f225cso861251241.2
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 13:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709934520; x=1710539320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9DHTEC+qHRmJukpGYng39a0vlJ0P3OvfMjEkcrrxRGw=;
 b=V/6ZuoMpHa3VY3EJUqIXrku+TTrHOZbc1A0W0A15obxAeCBfguoOfd3C3NivSegOzh
 Y1+UUlW98cfR9e1BNs/9VmFdv1kOl1kCcLA7LHL1G+/Qjsa7QBgMgxgAumwGiYoAt/FD
 l/oyeDMVTAg4hh7SWDkOjBMdvunEoOpRS5e4pUQXd2BvgDJxSAoEFuOb1IszSaebYuU8
 4KaV/i0GbDhNO2/TSOADtfzvGdekbadXvDQWKf9vob0fbSbkM38PeYXFfvzeNorIJNYG
 AK5ysdp4Z4oZOdwTMk/Ak8uALlR/fKE/HURP+zb67QsjyCSyM5hHQCnifWX37tSFCruz
 wWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934520; x=1710539320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9DHTEC+qHRmJukpGYng39a0vlJ0P3OvfMjEkcrrxRGw=;
 b=t6H1qx0q6kze7pVfojfgVl2JUR6VCJ/ECGNF0Jf1MDuaP/6SobvExeYwsUkjLcHCpn
 3ocb5rKq1jDbT0SO5C7snLo+gV2uewL8VbB2LKF+6q980c2DLVwO+eyHwI85lxz+mCZn
 QWIfl0HgKZv8qgxfTA7QT2ADrGetqTLT6tPxjF4Ayt7MaLY2+wXZuZPCIlDTDmPPQeXD
 9O3j9DPT6O40aZqY6kRLnPYpR20MrIbszm9iPbscvc98xjc61tAiAGiLsPyc6mjyAD5A
 FRD2hU8AVPc9tUaWWrWZKwT1O63uWedmF/lCdrjVI9eRanNQPP/HfY8vG5gN1PLSvz6c
 Mk7g==
X-Gm-Message-State: AOJu0Yx2hYYM5+u2ivcPoBWrZsf1ngq6Y2UT3IzZ3TW8pMMv/NrbTpBZ
 dTi7cEG1te+h2Dok/CsfuxXhAg4bb1TDdN1rNE3RIVz1z7kCYSi8ZR22F1KYA3qs2ZE3Z5O87Cx
 tlpjbBzZ+zagCrzNcZAgCZfhfZ61OZRQIfUo=
X-Google-Smtp-Source: AGHT+IE9i/IYjGs3OTlG9XtASUXM38eoGsz6BD8JDE/p4Q4IwF38aDy+N9e4DCLYG3mPVZK5CNWX9TCYAMqOboG3ylU=
X-Received: by 2002:a05:6122:10c7:b0:4c9:79d6:7f17 with SMTP id
 l7-20020a05612210c700b004c979d67f17mr533717vko.9.1709934519955; Fri, 08 Mar
 2024 13:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-6-heinrich.schuchardt@canonical.com>
 <CANV2PTOCK--hOr_HbbjHcjYT40fVm5DD2GsfV3cZu2XFm7WX=Q@mail.gmail.com>
 <937b1f61-7412-4609-b9a5-549d7fd6a950@canonical.com>
In-Reply-To: <937b1f61-7412-4609-b9a5-549d7fd6a950@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 8 Mar 2024 13:48:28 -0800
Message-ID: <CANV2PTOUip_ebfFiP5UaXBCENRdR6f2kZpPKU1p9ODbjS5gmrg@mail.gmail.com>
Subject: Re: [RFC 5/5] doc: describe Milk-V Mars board
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Yes this reference to GPIO high/low states is clearer to understand. Have
you tested the DIP switch functionality to confirm?; It is not shown in the
MilkV documentation or outdated schematics and I don't have a Mars to test.
I did find function descriptions from what is likely cut-and-paste of
VisionFive2 board reference.

Ref:
https://github.com/milkv-mars/mars-files/blob/main/Mars_hardware_schematics=
/Mars_V1.11_20230821.pdf
Sheet 7 of 22 JH7110 GPIOs
There is a schematic for SW2 (bootloader button?) that lists an inset table=
:
* - GPIO_1
  - GPIO_0
  - Boot
* - 0
  - 0
  - Flash
* - 0
  - 1
  - SD
* - 1
  - 0
  - eMMC
* - 1
  - 1
  - UART

That circuit on SW2 appears to pull high both RGPIO_1 and RGPIO_0 with
transistors. Again, no DIP switch as this is an earlier revision.

Ref:
https://doc-en.rvspace.org/VisionFive2/Developer_Guide/JH7110_Boot_UG.pdf
page 9 table 1-4:
RGPIO1=3D0x0 RGPIO0=3D0x0 Boot Source: Quad SPI NOR flash memory, Read SPL =
from
Sector 0.
RGPIO1=3D0x1 RGPIO0=3D0x1 Boot Source: UART0, (description of UART Xmodem
function).

Following in the same document on page 13 figure 2-1 Boot Flow:
JH7110 supports the following boot devices.
QSPI Flash (For SPL + OpenSBI + U-Boot) + NVMe/SD Card/eMMC (For Kernel + F=
i
le System and later)
Note: System will detect in sequence whether it can boot from the following
device sequence: NVMe > SD > eMMC. For example, if the boot program is foun=
d
on the SD, eMMC will be ignored.

Again in this document Figure 4-2 on page 17 is a visual listing of the DIP
switch positions for QSPI, SDIO, eMMC, and UART boot modes, of the
VisionFive2 board.

The only consistent physical interface over VisionFive2, Mars, Star64, Mars
CM all is RGPIO1=3DL RGPIO0=3DL SPI and RGPIO1=3DH RGPIO1=3DH UART; either =
by DIP
switch or pushbutton attached circuit. So, I question our assumptions about
what the actual behavior is for RGPIO1=3DH RGPIO0=3DL pairing and RGPIO1=3D=
L
RGPIO0=3DH, and in what circumstance would there be followed a device
sequence as suggested by the JH7110 reference. Why does the StarFive
documentation list a JH7110 boot device sequence if there is also these H+L
or L+H pairings to choose the device?

On Thu, Mar 7, 2024 at 6:37=E2=80=AFPM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 3/8/24 00:20, E Shattow wrote:
> >
> > On Sun, Mar 3, 2024 at 5:02=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com
> > <mailto:heinrich.schuchardt@canonical.com>> wrote:
> > ...
> >
> >     +The board provides the DIP switches MSEL[1:0] to select the boot
> >     device out of
> >     +SPI flash, eMMC, SD-card, UART. To select booting from SD-card set
> >     the DIP
> >     +switches MSEL[1:0] to 10.
> >
> >
> > This does not match the [Milk-V Mars vendor
> > documentation](https://milkv.io/docs/mars/getting-started/bootloader
> > <https://milkv.io/docs/mars/getting-started/bootloader>). Maybe you
> have
> > a different board revision?
>
> Thank you for reviewing.
>
> My board revision is V1.21 according to the silk screen.
>
> The Milk-V Mars has DIP switches for the boot selection as shown in
> https://gist.github.com/xypron/e28f95b1ed6911aeb9699ba63ae1a885
>
> If you look at the photo
>
> https://milkv.io/assets/images/mars-icon-04-e8814f18158a0e9d4387f4fa33069=
3f1.webp
> in the https://milkv.io/mars page, it also shows DIP switches (in the
> SPI-Flash position) on a rev 1.2 board.
>
> Did you see a board without DIP switches being sold?
>
> The silk screen markings on the board and the switch don't match.
> The same confusion exists on the VisionFive2.
>
> So maybe I should better write in a table:
>
> SPI-Flash:
> GPIO0=3DL
> GPIO1=3DL
>
> SD-Card:
> GPIO0=3DH
> GPIO1=3DL
>
> eMMC:
> GPIO0=3DL
> GPIO1=3DH
>
> UART:
> GPIO0=3DH
> GPIO1=3DH
>
> Best regards
>
> Heinrich
>
