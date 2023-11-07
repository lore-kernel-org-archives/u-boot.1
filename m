Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BF3C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 01:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868FE870F2;
	Tue,  7 Nov 2023 02:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YBTtpb+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1DF86C56; Tue,  7 Nov 2023 02:09:27 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD90F870C5
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 02:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so8795974a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 17:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699319364; x=1699924164; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/QNKcrnN8Nyx45p2GfUihMjCXRJ/jQB/1N3o/fOcQY=;
 b=YBTtpb+6EXhWyov46QS1UBFjv8PEOUfidN/INlRP+VHq6Nqo6S/DqyqyhA6J6HuPVj
 /8Se2ll/5Hf/tspg54KsF8Q6CKM67OcmMnylYxl85z2AV3RV77ju/x0olzjSrNnwLEbR
 CyShyLEo/CwP6jrs7MseZB4g1bj3Ox5oKbtJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699319364; x=1699924164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/QNKcrnN8Nyx45p2GfUihMjCXRJ/jQB/1N3o/fOcQY=;
 b=FCXodGYl9nHNUG0YbZKBzxT3t5iSL0kCg8tvD2bXyo61hm8W0ZB1UMAinNef0KwRa4
 KuFTZbVkCAfB2S/WfPYbcPJogv0D27lAB4vzTrYNEPB8rN4JA8U/71GQZjJlTHKv06hP
 JcDEz2VCKY6/72dNsQlJKV4kb+yuMziimv82t7UY5ElkcmsSaX8uXYlUby5IEJ1s9oFV
 EndF06ulcUA5l8UNXutvQ4GxC0nw8X5Sho3JVxtwqD8IwMORhVEVxDsz7PLNVbDNRV9k
 7oXSZ/AXDnemaDKc5nY3glq+3Qc6sRvPr8XXj3mBf2asBul09NwTz1fiug1yTzZuhhYf
 Z8WQ==
X-Gm-Message-State: AOJu0YwCfaXZ29xSsYwpoCHTj2e+pr/xGHT+0UEul4OKAzU1jWcTY5ld
 B7c4hJLDIr6Srfbvt0VCfQsnB85e4JIRu6k8o4tjFQ==
X-Google-Smtp-Source: AGHT+IFhOhp51dOED7MEHScnN+F7CNEttjXjLdZoAnlHT1qi1vqDipoRhJmo+9jYog8NoxO+2anp466S2XwHZy10Uf8=
X-Received: by 2002:a50:9b5d:0:b0:53d:f4a2:5140 with SMTP id
 a29-20020a509b5d000000b0053df4a25140mr23582037edj.33.1699319364084; Mon, 06
 Nov 2023 17:09:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
 <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
 <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
 <CAJaLiFzsJP5u5ziHW7U5_0uqeGdr4uxHRG7kso2K-jahqLKBsg@mail.gmail.com>
 <CAJaLiFyqr88c8L1Lg+99XnP4geebwqrdKhSV4_h9uf1Mjr94Qw@mail.gmail.com>
 <CAPnjgZ1vxy+hYpHaCGC=g2sFOK_xPCP4N_QFvxdO4xVb-SP+FA@mail.gmail.com>
 <CAJaLiFzLFOH08CGRt5QY4-keSuO=947_gF1meyRiMWz5H0gcyg@mail.gmail.com>
 <20231106195057.GD496310@bill-the-cat>
 <CAJaLiFwRQAX1GJ=JDLS=F=kz=PF-b+9wLBRxG40JhvjzVP+9Ug@mail.gmail.com>
 <CAJaLiFzyz+C7xUK_e=V=qvVqzL0SZvXRPf9QY=O5dO9335NfVA@mail.gmail.com>
In-Reply-To: <CAJaLiFzyz+C7xUK_e=V=qvVqzL0SZvXRPf9QY=O5dO9335NfVA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 01:09:12 +0000
Message-ID: <CAPnjgZ1kkbJk3h3KcQ0JBZKrfyuXCQB-X2D2xeUukvbG+35vjg@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tony,

On Mon, 6 Nov 2023 at 23:41, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Simon,
>
> On Mon, Nov 6, 2023 at 12:51=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wro=
te:
> >
> > On Mon, Nov 6, 2023 at 11:51=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Mon, Nov 06, 2023 at 11:42:51AM -0800, Tony Dinh wrote:
> > > > Hi Simon,
> > > >
> > > > On Mon, Nov 6, 2023 at 9:25=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> > > > >
> > > > > Hi Tony,
> > > > >
> > > > > On Wed, 4 Oct 2023 at 21:23, Tony Dinh <mibodhi@gmail.com> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Tony Dinh <mibodhi@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Sun, Oct 1, 2023 at 6:22=E2=80=AFPM Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Tony,
> > > > > > > >
> > > > > > > > On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@=
chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Tony,
> > > > > > > > > >
> > > > > > > > > > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail=
.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Simon,
> > > > > > > > > > >
> > > > > > > > > > > Here is an observation during testing the bootflow co=
mmand.
> > > > > > > > > > >
> > > > > > > > > > > If there is a SCSI bootflow, scanning for USB bootflo=
w will remove that existing
> > > > > > > > > > > SCSI bootflow. To bring it back, I scanned for SCSI b=
ootflow again, and it was
> > > > > > > > > > > back to normal. Perhaps there is some kind of indexin=
g problem?
> > > > > > > > > >
> > > > > > > > > > Yes that's right. The 'botflow scan' command is not add=
itive. The
> > > > > > > > > > first thing it does is removing existing bootflows.
> > > > > > > > >
> > > > > > > > > Thanks for clarifying that. I assumed it is additive, bec=
ause the
> > > > > > > > > existing USB bootflow was not removed when I did a "bootf=
low scan
> > > > > > > > > scsi" immediately after (see the end of the log).
> > > > > > > >
> > > > > > > > Yes, but I'm not sure what is going on there. Perhaps it is=
 a bug?
> > > > > > > > When you scan SCSI it should not also scan USB.
> > > > > > >
> > > > > > > Yes, it looks like a bug. I think I can see the problem and a=
m working
> > > > > > > on a patch.
> > > > > >
> > > > > > Just to let you know, I'm out of time to work on this topic. I =
will
> > > > > > revisit it some other time, if you have not already tracked it =
down.
> > > > >
> > > > > If you are able to use 'bootflow scan -l' in each case, then I mi=
ght
> > > > > be able to see what it is scanning USB, when you are asking for S=
CSI.
> > > > > I also wonder if this bug may have been fixed due to other change=
s?
> > > >
> > > > I'm wondering about that, too. I will rerun the test with the maste=
r
> > > > branch with debug trace. If we cannot see it, I'll do it again when
> > > > other bootstd patches are merged. Right now I am not sure which of
> > > > your bootstd patches I should apply to the tree for testing, do you
> > > > have a list for that?
> > >
> > > Right now the only outstanding bootstd patch I know of is your recent
> > > one, as I was waiting for Simon's review (which he did today) before
> > > merging and applying.
> >
> > Thanks Tom! I'll run the test in my tree as is then.
>
> The good news: apparently one of your recent bootstd patches has fixed
> this problem! I think your bootstd mmc scanning patch is probably
> where it was fixed.
>
> I tested with rc2 plus my recent patch (not yet merged to master) in the =
tree:
> https://patchwork.ozlabs.org/project/uboot/patch/20231102185116.21708-1-m=
ibodhi@gmail.com/
>
> For future reference, I've included the log here after the break.
>
> All the best,
> Tony
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <BEGIN LOG>
>
> U-Boot 2024.01-rc2-tld-1-00002-g148117d278 (Nov 06 2023 - 13:36:33 -0800)
> Thecus N2350
>
> SoC:   MV88F6820-A0 at 1066 MHz
> DRAM:  1 GiB (533 MHz, 32-bit, ECC not enabled)
> Core:  65 devices, 23 uclasses, devicetree: separate
> NAND:  512 MiB
> MMC:
> Loading Environment from SPIFlash... SF: Detected mx25l3205d with page
> size 256 Bytes, erase size 4 KiB, total 4 MiB
> *** Warning - bad CRC, using default environment
>
> Model: Thecus N2350
> Net:
> Warning: ethernet@70000 (eth0) using random MAC address - 2e:49:f0:ba:d8:=
b8
> eth0: ethernet@70000
> Hit any key to stop autoboot:  0
> N2350 > setenv def -a
> N2350 > bootdev l
> Seq  Probed  Status  Uclass    Name
> ---  ------  ------  --------  ------------------
>   0   [   ]      OK  ethernet  ethernet@70000.bootdev
> ---  ------  ------  --------  ------------------
> (1 bootdev)
>
> N2350 > bootflow scan usb
> Bus usb@58000: USB EHCI 1.00
> Bus usb3@f0000: MVEBU XHCI INIT controller @ 0xf10f4000
> Register 2000120 NbrPorts 2
> Starting the controller
> USB XHCI 1.00
> Bus usb3@f8000: MVEBU XHCI INIT controller @ 0xf10fc000
> Register 2000120 NbrPorts 2
> Starting the controller
> USB XHCI 1.00
> scanning bus usb@58000 for devices... 1 USB Device(s) found
> scanning bus usb3@f0000 for devices... 1 USB Device(s) found
> scanning bus usb3@f8000 for devices... 2 USB Device(s) found
> ** File not found /boot/boot.bmp **
>
> N2350 > bootflow l
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filen=
ame
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
> /boot/boot.scr
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (1 bootflow, 1 valid)
>
> N2350 > bootflow scan scsi
> pcie0.0: Link down
> pcie1.0: Link down
> scanning bus for devices...
> SATA link 0 timeout.
> Target spinup took 0 ms.
> AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> flags: 64bit ncq led only pmp fbss pio slum part sxs
>   Device 0: (1:0) Vendor: ATA Prod.: ST750LX003-1AC15 Rev: SM12
>             Type: Hard Disk
>             Capacity: 715404.8 MB =3D 698.6 GB (1465149168 x 512)
> ** File not found /boot/boot.bmp **
>
> N2350 > bootflow l
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filen=
ame
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
> /boot/boot.scr
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (1 bootflow, 1 valid)
>
> N2350 > bootflow scan usb
> ** File not found /boot/boot.bmp **
> N2350 > bootflow l
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filen=
ame
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
> /boot/boot.scr
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (1 bootflow, 1 valid)
>
> N2350 > bootflow scan scsi
> ** File not found /boot/boot.bmp **
> N2350 > bootflow l
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filen=
ame
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
> /boot/boot.scr
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (1 bootflow, 1 valid)
> N2350 >
> N2350 > bootflow scan usb
> ** File not found /boot/boot.bmp **
> N2350 > bootflow l
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filen=
ame
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
> /boot/boot.scr
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (1 bootflow, 1 valid)
>
> <END LOG>

That's great! Thank you for testing and for the log.

Regards,
Simon
