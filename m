Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9852AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 23:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D73A86BEC;
	Tue,  7 Nov 2023 00:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YawQnu+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E710A86F02; Tue,  7 Nov 2023 00:41:35 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9059D86A4C
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 00:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso8488204a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 15:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699314092; x=1699918892; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgzSkUm7lI0zR5Th4XLpKP7HNyJ9z0HTgMzeEd0cotc=;
 b=YawQnu+l/+M452G2sFBnhhRo1Q8W5ei9XFw74yB+m+4Z9QeCy4TFyZ6HnNDL2z0Pcx
 OZuD/U82fG/muhKlQQVb27pSbdHnErGdiyFQaCH+XAvLDlwmskcP0tTEay1+b/laZzYT
 NKifREyCjdPgEYsF+o6p3XWsfOSC4bbTl/anuEJVV1MBSBjWbCuv46TX1X4PXk4U7k0+
 jZh925JfX1I1cb4i8k6mV9XaRMt0Gcv6jZruZizRLxNmabPBjChc9GvHNj0flag0rqpO
 wk1jWuQmEwLv8QgTuNdufx/5wJmZN6COP5TEhgqqFaoa+PVWPSbNsYybpOBWg8Agglmy
 8l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699314092; x=1699918892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgzSkUm7lI0zR5Th4XLpKP7HNyJ9z0HTgMzeEd0cotc=;
 b=NvxHryRSmVa9EGAMqCmhIfHvlcMKMkK6Li0KVxFn3RHXxxQLIxAyA3p7h4UhMSjcCX
 w/RNhEEO1zqG0KYgPQ4YRagD6h5lzYwhBnaMt3nqMXjz3ks/Jbt6PdtWT5Tx7cOSChgo
 M1c5uypHA8sR44BCaPgpGxu5MLi/tdIMTtvCr8XYejcHrQqvTsDpSSjmguMfcOjHjOOX
 1OF8lM3NPRgKxsWjE7auVvkGSbR4+RL4cpXsPAqfj+osEunnEkZD/tmowY14P64puMqx
 a4qIhO9CcL+GufX/Cx9qnTZOAfYTmqnj+mhWGrXHdl/wsCKORF5VRcxWkfBNOItBCsRN
 O+jw==
X-Gm-Message-State: AOJu0YzVoEvnhfYhw240GkNYA0ewPODsgkMhYksUIYgr8+A8AnU+nqZP
 O0C8y/cgrIsfUABNSOxJ+bOeDxc0U8Psbe3/UIE=
X-Google-Smtp-Source: AGHT+IGRh3p/2QzbZBwBAradYGvwWO4pUmehSnqShMcDP06hTkVE68NNIyd0lf6Zfo5GIQ8YzA3XAZ2O/FzwK65co0k=
X-Received: by 2002:aa7:d6d4:0:b0:53f:6ed5:4dab with SMTP id
 x20-20020aa7d6d4000000b0053f6ed54dabmr25911251edr.24.1699314091830; Mon, 06
 Nov 2023 15:41:31 -0800 (PST)
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
In-Reply-To: <CAJaLiFwRQAX1GJ=JDLS=F=kz=PF-b+9wLBRxG40JhvjzVP+9Ug@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 6 Nov 2023 15:41:19 -0800
Message-ID: <CAJaLiFzyz+C7xUK_e=V=qvVqzL0SZvXRPf9QY=O5dO9335NfVA@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, Nov 6, 2023 at 12:51=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> On Mon, Nov 6, 2023 at 11:51=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Nov 06, 2023 at 11:42:51AM -0800, Tony Dinh wrote:
> > > Hi Simon,
> > >
> > > On Mon, Nov 6, 2023 at 9:25=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > Hi Tony,
> > > >
> > > > On Wed, 4 Oct 2023 at 21:23, Tony Dinh <mibodhi@gmail.com> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Tony Dinh <mibodhi@gmail.=
com> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Sun, Oct 1, 2023 at 6:22=E2=80=AFPM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > > >
> > > > > > > Hi Tony,
> > > > > > >
> > > > > > > On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com> =
wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@ch=
romium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Tony,
> > > > > > > > >
> > > > > > > > > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.c=
om> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > > Here is an observation during testing the bootflow comm=
and.
> > > > > > > > > >
> > > > > > > > > > If there is a SCSI bootflow, scanning for USB bootflow =
will remove that existing
> > > > > > > > > > SCSI bootflow. To bring it back, I scanned for SCSI boo=
tflow again, and it was
> > > > > > > > > > back to normal. Perhaps there is some kind of indexing =
problem?
> > > > > > > > >
> > > > > > > > > Yes that's right. The 'botflow scan' command is not addit=
ive. The
> > > > > > > > > first thing it does is removing existing bootflows.
> > > > > > > >
> > > > > > > > Thanks for clarifying that. I assumed it is additive, becau=
se the
> > > > > > > > existing USB bootflow was not removed when I did a "bootflo=
w scan
> > > > > > > > scsi" immediately after (see the end of the log).
> > > > > > >
> > > > > > > Yes, but I'm not sure what is going on there. Perhaps it is a=
 bug?
> > > > > > > When you scan SCSI it should not also scan USB.
> > > > > >
> > > > > > Yes, it looks like a bug. I think I can see the problem and am =
working
> > > > > > on a patch.
> > > > >
> > > > > Just to let you know, I'm out of time to work on this topic. I wi=
ll
> > > > > revisit it some other time, if you have not already tracked it do=
wn.
> > > >
> > > > If you are able to use 'bootflow scan -l' in each case, then I migh=
t
> > > > be able to see what it is scanning USB, when you are asking for SCS=
I.
> > > > I also wonder if this bug may have been fixed due to other changes?
> > >
> > > I'm wondering about that, too. I will rerun the test with the master
> > > branch with debug trace. If we cannot see it, I'll do it again when
> > > other bootstd patches are merged. Right now I am not sure which of
> > > your bootstd patches I should apply to the tree for testing, do you
> > > have a list for that?
> >
> > Right now the only outstanding bootstd patch I know of is your recent
> > one, as I was waiting for Simon's review (which he did today) before
> > merging and applying.
>
> Thanks Tom! I'll run the test in my tree as is then.

The good news: apparently one of your recent bootstd patches has fixed
this problem! I think your bootstd mmc scanning patch is probably
where it was fixed.

I tested with rc2 plus my recent patch (not yet merged to master) in the tr=
ee:
https://patchwork.ozlabs.org/project/uboot/patch/20231102185116.21708-1-mib=
odhi@gmail.com/

For future reference, I've included the log here after the break.

All the best,
Tony

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<BEGIN LOG>

U-Boot 2024.01-rc2-tld-1-00002-g148117d278 (Nov 06 2023 - 13:36:33 -0800)
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
Warning: ethernet@70000 (eth0) using random MAC address - 2e:49:f0:ba:d8:b8
eth0: ethernet@70000
Hit any key to stop autoboot:  0
N2350 > setenv def -a
N2350 > bootdev l
Seq  Probed  Status  Uclass    Name
---  ------  ------  --------  ------------------
  0   [   ]      OK  ethernet  ethernet@70000.bootdev
---  ------  ------  --------  ------------------
(1 bootdev)

N2350 > bootflow scan usb
Bus usb@58000: USB EHCI 1.00
Bus usb3@f0000: MVEBU XHCI INIT controller @ 0xf10f4000
Register 2000120 NbrPorts 2
Starting the controller
USB XHCI 1.00
Bus usb3@f8000: MVEBU XHCI INIT controller @ 0xf10fc000
Register 2000120 NbrPorts 2
Starting the controller
USB XHCI 1.00
scanning bus usb@58000 for devices... 1 USB Device(s) found
scanning bus usb3@f0000 for devices... 1 USB Device(s) found
scanning bus usb3@f8000 for devices... 2 USB Device(s) found
** File not found /boot/boot.bmp **

N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(1 bootflow, 1 valid)

N2350 > bootflow scan scsi
pcie0.0: Link down
pcie1.0: Link down
scanning bus for devices...
SATA link 0 timeout.
Target spinup took 0 ms.
AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
flags: 64bit ncq led only pmp fbss pio slum part sxs
  Device 0: (1:0) Vendor: ATA Prod.: ST750LX003-1AC15 Rev: SM12
            Type: Hard Disk
            Capacity: 715404.8 MB =3D 698.6 GB (1465149168 x 512)
** File not found /boot/boot.bmp **

N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(1 bootflow, 1 valid)

N2350 > bootflow scan usb
** File not found /boot/boot.bmp **
N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(1 bootflow, 1 valid)

N2350 > bootflow scan scsi
** File not found /boot/boot.bmp **
N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   scsi         1  ahci_scsi.id1lun0.bootdev
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(1 bootflow, 1 valid)
N2350 >
N2350 > bootflow scan usb
** File not found /boot/boot.bmp **
N2350 > bootflow l
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------
----------------
  0  script       ready   usb_mass_    1  usb_mass_storage.lun0.boo
/boot/boot.scr
---  -----------  ------  --------  ----  ------------------------
----------------
(1 bootflow, 1 valid)

<END LOG>
