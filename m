Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F5AEB8FA6
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B96286667;
	Wed,  6 Sep 2023 04:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilXWNU6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9326C865A4; Tue,  5 Sep 2023 20:00:19 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726EF86595
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luis.adasilvaf@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-501bd6f7d11so1733278e87.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693936815; x=1694541615; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IdwmLkEYP+dpJIzGhfO/th1E/zTz31Zxjaw0HHhYIkw=;
 b=ilXWNU6KJv8o6ApqwGsRI722Z79h+I5HJ/LAuKOloEkpeP5OKWSKjJSRdV0toQyCFp
 PCdyJoCyuNvQes6zio8KKdq4u65p4W9LM5fDeQaZ1jF1g9ZQCq6TGsX1EL0Riqk2aB9Z
 2HBnk2RD7RNvLchm85FijnwJTUJk9TJSkchjpVk7BQi28BTGE0dGYQ0MRiLSqbsfayxq
 m8wSkJ2lCOwcaoppIIs5wAPv1aB8l3JzrXvfUgLAXNpQMIMi11OP97UBDu7bhOqixrgn
 fmP5+rvTHwiNFhlpfXYEPtmEWKkbO0xsSQdKc6263LrE3ymjkhRWjiUWELOwhLo0CTFe
 1CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693936815; x=1694541615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IdwmLkEYP+dpJIzGhfO/th1E/zTz31Zxjaw0HHhYIkw=;
 b=KLTohOwWDaVr1RnkrImpFBqOUPbb9PgBw/q+RKG8o8frYeFBLJ9Aqwvb+ymQBiJc2n
 rTIvHEnIQkUW3KwTc1k6HdmYqvo0eW7EjpCwzQ4t0B0DLY7aQFjjMuy3cKi6MMrxFwf2
 A6pRZ0tt8SkJdv1Rhf4Ljnewp6h6p7kpfkPhG4JiqQbeYSeFbyfSptFPPMzMrlCy52qq
 br+m3b5csmi1F76vzp3AxGhf4tiHrUFA+eELxYeLvCWrZ5OHkKA6cg1w5XFTfUlfPj/6
 iWZyAlZ1ogIeVnLHNitkRj17tzQTh+DnVqY4o90P3UmEkcXlXquKkJpaYiUwqrry58yY
 x1RA==
X-Gm-Message-State: AOJu0YwcUORjI9Pv3FoLq+16MzFg/MQClvBNwQ1wx4JGLU4cBySLFAU9
 HquwQsmBIL2HWvGjrYWLmPGZEs9ycSXSGAI5EzdqnZOUTHk+qacw
X-Google-Smtp-Source: AGHT+IEU5/NCtfw1LQc8WdOOJhUEls2wtRH4kTzh2L1rQm3ztps4ogAevytopBBCnnOoV56TmAwkQbLGsQa+mWrT4wc=
X-Received: by 2002:ac2:5501:0:b0:4f1:4cdc:ec03 with SMTP id
 j1-20020ac25501000000b004f14cdcec03mr365771lfk.18.1693936815198; Tue, 05 Sep
 2023 11:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9LrUHa5fZpRkgjYjDQft-L32Tzpa=FzOmMnLzM-q8RttqVeQ@mail.gmail.com>
 <CAPnjgZ33SiNPRdrMXmrwvRrKgi+mp+sJ+OBbu7=yDf19Gydd9Q@mail.gmail.com>
 <CA+9LrUEGqmsUL9xu0KzwgqhWptWOU1z4x3ncvXMYUJFomSv+ug@mail.gmail.com>
 <CAPnjgZ3458G_-+Nm-GzCbcVGV4uu7DNzYKd2cNQ=JFYZVS78dA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3458G_-+Nm-GzCbcVGV4uu7DNzYKd2cNQ=JFYZVS78dA@mail.gmail.com>
From: Luis Alfredo da Silva <luis.adasilvaf@gmail.com>
Date: Tue, 5 Sep 2023 13:00:04 -0500
Message-ID: <CA+9LrUF0ZjeXpG9UC3s0BLssN03wmVG3NRHG3xuXcZ=9vGnmzQ@mail.gmail.com>
Subject: Re: NVMe support on RPi CM4 board
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 06 Sep 2023 04:56:11 +0200
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

Hi Simon, it took me some time to come back to this issue, but I was able
to enable the debug messages on drivers/nvme/nvme.c.

This is what I got when running the nvme scan command

U-Boot> pci
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x14e4     0x2711     Bridge device           0x04
01.00.00   0x1c5c     0x174a     Mass storage controller 0x08
U-Boot> nvme info
U-Boot> nvme scan
Cannot set queue count (err=3D-110)
Unable to setup I/O queues(err=3D-110)
Failed to probe 'nvme#0': err=3D-110
U-Boot>

I'm reporting as soon as I got the messages, but I'll continue
investigating.

Regards,
Luis


El mi=C3=A9, 9 ago 2023 a las 20:15, Simon Glass (<sjg@google.com>) escribi=
=C3=B3:

> Hi Luis,
>
> On Wed, 9 Aug 2023 at 10:43, Luis Alfredo da Silva
> <luis.adasilvaf@gmail.com> wrote:
> >
> > Hi Simon, I enabled the next four variables
> >
> > CONFIG_NVME_PCI=3Dy
> > CONFIG_NVME=3Dy
> > CONFIG_CMD_NVME=3Dy
> > CONFIG_PCI=3Dy
> >
> > how different is CONFIG_NVME_PCI from NVME_PCI, I took the latter value
> from several configs files in u-boot repo and from [1]
>
> I just left off the CONFIG as they all have that. This looks right to
> me. Assuming that the NVMe controller appears in 'dm tree' perhaps you
> can enable debugging in the driver and see why it is not working?
>
> Regards,
> Simon
>
>
> >
> >
> > [1]
> https://github.com/u-boot/u-boot/blob/ef8336e2705fce2502383f25d68188c6b1f=
94dd0/doc/develop/driver-model/nvme.rst#L44
> >
> > El mar, 8 ago 2023 a las 22:05, Simon Glass (<sjg@google.com>) escribi=
=C3=B3:
> >>
> >> Hi Luis,
> >>
> >> On Tue, 8 Aug 2023 at 17:09, Luis Alfredo da Silva
> >> <luis.adasilvaf@gmail.com> wrote:
> >> >
> >> > I compiled u-boot version 2023-07 and boot it on a RPi CM4 using a
> PCIe M.2
> >> > NVMe drive, but it doesn't appear to be working.
> >> >
> >> > Once u-boot has started and boot successfully it recognizes the PCIe
> device
> >> > giving me the next output
> >> >
> >> > U-Boot> pci
> >> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> >> > _____________________________________________________________
> >> > 00.00.00   0x14e4     0x2711     Bridge device           0x04
> >> > 01.00.00   0x1c5c     0x174a     Mass storage controller 0x08
> >> >
> >> > but when trying to use the nvme scan and nvme info there is not
> output.
> >> >
> >> > NVMe drive has two partitions 1st is a FAT partition, and 2nd is a
> EXT4
> >> > partition, the RPi firmware recognizes the FAT partition and u-boot
> boot
> >> > correctly.
> >> >
> >> > I don't know if this worked before, but I saw in the mailing list th=
at
> >> > there could be already support for other ARM64 boards.
> >>
> >> Is NVME_PCI enabled?
> >>
> >> Regards,
> >> SImon
>
