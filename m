Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B5CE7E65A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 19:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD3886BE7;
	Tue, 26 Sep 2023 21:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYQjLtd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F57A86BE2; Tue, 26 Sep 2023 21:40:59 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2580086C26
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 21:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-530bc7c5bc3so11555200a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695757256; x=1696362056; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCBwF/Vh/qaz5iCp1c/qoDg7paabbS7CBAuV/bBUsPI=;
 b=DYQjLtd8J5Rpm2/R3AVuNq9I0fkqsEtly9Aeg+f8Pr4YiIpiN+lgCk1b3CD0KWvC8l
 PDCLZxKoS2Ggl9t4wW6iuTNf0BbxFLdmLAU0/EfhKeYEO63lrnPyE9noO+jmyWFf2GEm
 mKkU6x1Q70gQVCTlB7xjv+adbl4odbrsZvyUQOCleDs8qC1qG6xO54Izo1naHsb2elwE
 z/r+WqKMgDAAmvJGbmzqZJLK2W8+XF4y3R+anPDqMFwetqofx3FHX1rYUA8jMzBJdJ9S
 qTKzU5Y0bzeu3P+iv+hvBMhaFAHJDe3Xd+JbE5MJG0PzSmmLgW7Juw5D/SGrtTvtwrKP
 j9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695757256; x=1696362056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCBwF/Vh/qaz5iCp1c/qoDg7paabbS7CBAuV/bBUsPI=;
 b=VGKzqOL5Xo2ZMtAyk5pfhyx8YNXoCPnT/YREsUkkHwL86O1p7zCXp1W/JV8A3yMWTF
 HM/aTC4Ai2jhKIzu76Lcpks/efVRsoHDbKzBoQHbmpdLYX5uLsVyWLEodyY7A8b70U4K
 AnncTfO+Kq6LbH/m9KYbT/yRme714YnrvPC3i4eHZ7oeujVhbcJfLNy2+rfs/LYXW6UL
 WgNLFx/2Sl3cdEzAyjW+OR4fAIDwn6OjxDS9RFOl1zTU/uzlf0eyco2l05guTyaJTRCK
 ErSCxkxxNUA1meJCN5ZlujyaPo0OoPvSYVpZLwharjd9NANV+/uOvFVqQ8PmqsLxY1+w
 ilJA==
X-Gm-Message-State: AOJu0YzNps0bbI0VrtZ0a43/43z3nz1evHyqzoHe15FlT7iObHLYvoae
 jOjNqMOrhBTwTpUq75kIEf5FCc7ysgyBVQA2BsM=
X-Google-Smtp-Source: AGHT+IHJWwAXxoXdxAzvV5vWOdr67TSzfQfJsMhQWD2I7E8ppmqlgn6KgqN3Vm2kkhIIF9DT+dK67MPH4xJGAJcJCK0=
X-Received: by 2002:a05:6402:1347:b0:530:9e59:5795 with SMTP id
 y7-20020a056402134700b005309e595795mr51220edw.4.1695757256359; Tue, 26 Sep
 2023 12:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
In-Reply-To: <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 26 Sep 2023 12:40:44 -0700
Message-ID: <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tony,
>
> On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > Here is an observation during testing the bootflow command.
> >
> > If there is a SCSI bootflow, scanning for USB bootflow will remove that=
 existing
> > SCSI bootflow. To bring it back, I scanned for SCSI bootflow again, and=
 it was
> > back to normal. Perhaps there is some kind of indexing problem?
>
> Yes that's right. The 'botflow scan' command is not additive. The
> first thing it does is removing existing bootflows.

Thanks for clarifying that. I assumed it is additive, because the
existing USB bootflow was not removed when I did a "bootflow scan
scsi" immediately after (see the end of the log).

Thanks,
Tony

>
> >
> > Please see the log below after the break.
> >
> > All the best,
> > Tony
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > <BEGIN LOG>
> >
> > U-Boot 2023.10-rc4-tld-1-00044-g9c21b2a350-dirty (Sep 18 2023 - 12:16:5=
9 -0700)
> > Thecus N2350
> >
> > <snip>
> >
> > N2350 > env def -a
> > ## Resetting to default environment
> >
> > N2350 > bootflow scan scsi
> > pcie0.0: Link down
> > pcie1.0: Link down
> > scanning bus for devices...
> > SATA link 0 timeout.
> > Target spinup took 0 ms.
> > AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> > flags: 64bit ncq led only pmp fbss pio slum part sxs
> >   Device 0: (1:0) Vendor: ATA Prod.: ST750LX003-1AC15 Rev: SM12
> >             Type: Hard Disk
> >             Capacity: 715404.8 MB =3D 698.6 GB (1465149168 x 512)
> > ** File not found /boot/boot.bmp **
> >
> > N2350 > bootflow l
> > Showing all bootflows
> > Seq  Method       State   Uclass    Part  Name                      Fil=
ename
> > ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> >   0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
> > /boot/boot.scr
> > ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> > (1 bootflow, 1 valid)
> >
> > N2350 > bootflow scan usb
> > Bus usb@58000: USB EHCI 1.00
> > Bus usb3@f0000: MVEBU XHCI INIT controller @ 0xf10f4000
> > Register 2000120 NbrPorts 2
> > Starting the controller
> > USB XHCI 1.00
> > Bus usb3@f8000: MVEBU XHCI INIT controller @ 0xf10fc000
> > Register 2000120 NbrPorts 2
> > Starting the controller
> > USB XHCI 1.00
> > scanning bus usb@58000 for devices... 1 USB Device(s) found
> > scanning bus usb3@f0000 for devices... 1 USB Device(s) found
> > scanning bus usb3@f8000 for devices... 2 USB Device(s) found
> > ** File not found /boot/boot.bmp **
> >
> > N2350 > bootflow l
> > Showing all bootflows
> > Seq  Method       State   Uclass    Part  Name                      Fil=
ename
> > ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> >   0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
> > /boot/boot.scr
> > ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> > (1 bootflow, 1 valid)
> >
> > N2350 > bootflow scan scsi
> > ** File not found /boot/boot.bmp **
> > ** File not found /boot/boot.bmp **
> >
> > N2350 > bootflow l
> > Showing all bootflows
> > Seq  Method       State   Uclass    Part  Name                      Fil=
ename
> > ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> >   0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
> > /boot/boot.scr
> >   1  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
> > /boot/boot.scr
> > ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> > (2 bootflows, 2 valid)
> >
> > <END LOG>
>
> Regards,
> Simon
