Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF175C54798
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 06:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740E687D8C;
	Sun, 25 Feb 2024 07:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kuIiTMpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1861887DAB; Sun, 25 Feb 2024 07:55:33 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231BB87D26
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 07:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc09556599so18983945ad.1
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708844128; x=1709448928; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2auTDxf8bHE3w+JCcJHc8PGsCWJIA0tu9gma1XB5GOs=;
 b=kuIiTMplTkwY1Hl9LBH2mXG0hcj+sV+MUppPbHk+3+FMKvxcVRYfStcbm5KqSyMTbO
 Md0Lpt6Ejm1GqZFE95JkzF4+siDFZnSwsm52k9+E79RQiSDo9HOqFy2ohH3a1ZXGvIZQ
 gZhnoaU4z0zC3lYpqKuCkvKMgewlyf1vh6neFQtAyw0L5ugzk4WFzBJCl5Ms1C7WSWRt
 iPND/OYJ2ydy3zV1B7CfJBwQ7mu4fAngbpuollQaNCVlx/j1BYCrNIakzKiNF6Zu+/Zu
 Vr64Al1ILySuALyGuXE5b5Al34LdaIZNQfjTOpr9oIH3lhJCumZv8hfytRWuDGqK7gL7
 ZeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708844128; x=1709448928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2auTDxf8bHE3w+JCcJHc8PGsCWJIA0tu9gma1XB5GOs=;
 b=kEZ6TPOjNeWmD9k2yPzcHWpF6nY1HOpskPAdasUq5UyYhrlcev39zkK6d6rrS12xH+
 +qjz+XpgRU1MGhstx7Vvc5ZZqdE6PR7DtH52VGYMLB9ASrFMHcyG0iWC6oQTcSAZWrNg
 SGICHfpW2A3h+0nG2eig5AgD1bnxJ0u+dgzCaXEl2gHkmXsq70b/GoQF4t6tVo/LAV/z
 4EQ/NEPGX66EfPMhtdZORF7fjY5NcYlog2R+OC1IhymBNszvoamPa2YL1ZODrs4mCsGK
 QAzF72HdVQqUL0rCCaYNbk38p2ae7FGUL0k/LqwtJCFjJWHLohXful8shy9GekxisWKi
 QeOA==
X-Gm-Message-State: AOJu0Yy79dQIpWnAAyElNEIDC/u3wa61NYAmf+FX2CD6DoPMd6p2i6bN
 oemGoGbES2cqWrty5B8piX/TlEJSnc5HU+uhbJPCQAVxcHmWSmgjJ1B7Eu4JQidQ0Doa6uRRC4a
 LBdys+uhOOv8nnhpUcZJuCBNHKQM=
X-Google-Smtp-Source: AGHT+IEughkOi5kdO1r0uWnNJHOHe3hdgF22G3LixRUfmpS/KU79NzpqlrYkaNYaDImUT1OYFZH6O3k9SfL8DHdM0i8=
X-Received: by 2002:a17:902:7ec8:b0:1db:cb54:5e77 with SMTP id
 p8-20020a1709027ec800b001dbcb545e77mr4497235plb.22.1708844127764; Sat, 24 Feb
 2024 22:55:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHseuWAmUbWJtmH8TNtr6_P3ibd6+1yT2kKticNdbfLdMViLqA@mail.gmail.com>
 <CANAwSgR-Bd0ck-LkYb9QcNigP3Ht61RxYds5=YFyX58pdeusCw@mail.gmail.com>
In-Reply-To: <CANAwSgR-Bd0ck-LkYb9QcNigP3Ht61RxYds5=YFyX58pdeusCw@mail.gmail.com>
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Sun, 25 Feb 2024 07:55:16 +0100
Message-ID: <CAHseuWD93woj0sq6iMBjdKs2_Ny4=P_3TWtZRGdUFijDMSRzXw@mail.gmail.com>
Subject: Re: Raspberry Pi 3b Plus USB-Ethernet lan78xx_eth address not set
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Anand,

Thanks for the update.

Yes, I can set it manually. But this should be done by u-boot, right? Is
there any reason why this is not happening on Pi 3b plus?
I have other Raspberry Pi (4 & 3b) and they are working fine.

Also, is this MAC address for LAN75xx or LAN78xx? The error message shows
lan78xx_eth.


On Sun, Feb 25, 2024, 06:50 Anand Moon <linux.amoon@gmail.com> wrote:

> Hi,
>
> On Sat, 24 Feb 2024 at 01:56, Sourabh Hegde Ramu
> <hrsourabh1107@gmail.com> wrote:
> >
> > Hello,
> >
> > I have a Raspberry Pi 3B Plus which I want to integrate with U-boot
> > (v2023.10) .
> >
> > I am using rpi_3_32b_defconfig to generate u-boot.bin. But while booting
> I
> > am getting below error
> >
> > Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
> > In:    serial,usbkbd
> > Out:   serial,vidconsole
> > Err:   serial,vidconsole
> > Net:   No ethernet found.
> > starting USB...
> > Bus usb@7e980000: USB DWC2
> > scanning bus usb@7e980000 for devices...
> > Error: lan78xx_eth address not set.
> > 3 USB Device(s) found
> >        scanning usb for storage devices... 0 Storage Device(s) found
> > Hit any key to stop autoboot:  0
> >
> > In the "bdinfo", "current eth" is not set
> >
> > U-Boot> bdinfo
> > boot_params = 0x00000100
> > DRAM bank   = 0x00000000
> > -> start    = 0x00000000
> > -> size     = 0x3b400000
> > flashstart  = 0x00000000
> > flashsize   = 0x00000000
> > flashoffset = 0x00000000
> > baudrate    = 115200 bps
> > relocaddr   = 0x3b360000
> > reloc off   = 0x3b358000
> > Build       = 32-bit
> > current eth = unknown
> > eth-1addr   = (not set)
> > IP addr     = <NULL>
> >
> > I also enabled LAN75xx in menuconfig and re-compiled u-boot. But still
> the
> > same error.
> >
> > However on Raspberry Pi 3B, I don't see this error and "current eth" is
> set
> > to "smsc95xx_eth" and "ethaddr" is also available.
> >
> > Can anyone please let me know the issue with Raspberry Pi 3b plus?
> >
> > Thanks in advance.
>
> Can you set the MAC address in boot environment?
>
> # setenv ethaddr 00:14:05:42:03:BB
> # saveenv
>
> It should update the mac address for LAN75xx
> printenv should display the mac address
>
> Thanks
> -Anand
>
