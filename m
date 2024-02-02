Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDD2C48286
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5792283CF3;
	Fri,  2 Feb 2024 01:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B81987D63; Fri,  2 Feb 2024 01:13:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7A7EE87CDB
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 01:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 715A5DA7;
 Thu,  1 Feb 2024 16:14:06 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97B4C3F5A1;
 Thu,  1 Feb 2024 16:13:22 -0800 (PST)
Date: Fri, 2 Feb 2024 00:12:18 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Shantur Rathore <i@shantur.com>
Cc: marex@denx.de, bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin
 <marcan@marcan.st>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon
 Glass <sjg@chromium.org>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
Message-ID: <20240202001218.63b4e9c3@minigeek.lan>
In-Reply-To: <CABEcMwXYw9L957wykfZ5HcC5V88hbgEDZ-E_fYL9LhG_hyxb=g@mail.gmail.com>
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
 <20240201164604.13315fa6@donnerap.manchester.arm.com>
 <CABEcMwXYw9L957wykfZ5HcC5V88hbgEDZ-E_fYL9LhG_hyxb=g@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 1 Feb 2024 18:35:28 +0000
Shantur Rathore <i@shantur.com> wrote:

Hi Shantur,

> Hi Andre,
>=20
> On Thu, Feb 1, 2024 at 4:46=E2=80=AFPM Andre Przywara <andre.przywara@arm=
.com> wrote:
> >
> > On Thu, 1 Feb 2024 09:39:54 +0000
> > Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Shantur,
> > =20
> > > On Tue, Jan 30, 2024 at 2:01=E2=80=AFPM Andre Przywara <andre.przywar=
a@arm.com> wrote: =20
> > > >
> > > > On Sat,  9 Dec 2023 18:10:56 +0000
> > > > Shantur Rathore <i@shantur.com> wrote:
> > > >
> > > > Hi,
> > > > =20
> > > > > Currently when a hub is turned on, all the ports are powered on.
> > > > > This works well for hubs which have individual power control.
> > > > >
> > > > > For the hubs without individual power control this has no effect.
> > > > > Mostly in these scenarios the hub port is powered before the USB
> > > > > controller is enabled, this can lead to some devices in unexpected
> > > > > state.
> > > > >
> > > > > With this patch, we explicitly reset the port while powering up h=
ub
> > > > > This resets the port for hubs without port power control and has
> > > > > no effect on hubs with port power control as the port is still of=
f.
> > > > >
> > > > > Before this patch AMicro AM8180 based NVME to USB adapter won't be
> > > > > detected as a USB3.0 Mass Storage device but with this it works as
> > > > > expected.
> > > > >
> > > > > Tested working after this patch:
> > > > > 1. AMicro AM8180 based NVME to USB Adapter
> > > > > 2. Kingston DataTraveler 3.0
> > > > > 3. GenesysLogic USB3.0 Hub
> > > > >
> > > > > The drives were tested while connected directly and via the hub. =
=20
> > > >
> > > > so this broke USB operation on some Allwinner boards. The ports sti=
ll
> > > > enumerate correctly, but no devices are detected. With mainline
> > > > (containing this patch), and a USB stick connected:
> > > > starting USB...
> > > > Bus usb@5200000: USB EHCI 1.00
> > > > Bus usb@5200400: USB OHCI 1.0
> > > > scanning bus usb@5200000 for devices... 1 USB Device(s) found
> > > > scanning bus usb@5200400 for devices... 1 USB Device(s) found
> > > >        scanning usb for storage devices... 0 Storage Device(s) found
> > > >
> > > > With this patch here reverted:
> > > > starting USB...
> > > > Bus usb@5200000: USB EHCI 1.00
> > > > Bus usb@5200400: USB OHCI 1.0
> > > > scanning bus usb@5200000 for devices... 2 USB Device(s) found
> > > > scanning bus usb@5200400 for devices... 1 USB Device(s) found
> > > >        scanning usb for storage devices... 1 Storage Device(s) found
> > > >
> > > > I have no clue why this happens, there is no discrete hub anywhere =
in this
> > > > setup, so I guess the code runs for the root hub here?
> > > > I am attaching a log with DEBUG enabled for common/usb_hub.c, for b=
oth
> > > > cases.
> > > >
> > > > Any clues, debug suggestions, or even a fix are warmly welcome.
> > > > =20
> > >
> > > Which USB disk are you using? Is it a USB 2.0 disk ?
> > > Can you try with any other USB disk to confirm? =20
> >
> > Yes, this was some USB 2.0 memory stick, on an USB 2.0 port.
> > Most sunxi boards only have USB 2.0, but there is one SoC with USB 3.0,=
 I
> > will try some combinations later tonight.
> >
> > Thanks,
> > Andre =20
>=20
> That would be awesome.
> We need to test
>=20
> USB 3.0 and 2.0 ports with USB 3.0 and 2.0 drives.

So I had some mixed and apparently inconsistent results:
- On the Pine-H64 (H6 SoC with USB 3.0 + USB 2.0) it worked with
  mainline, but only after I applied some pending sunxi USB PHY
  regulator patches. This is an unrelated issue, those patches
  are needed to enable USB 3.0 support on that board (shared regulator
  conflict).
  I tested a USB 2.0 and a USB 3.0 drive in both kind of slots, with
  and without the patch.
- On the OrangePi Zero 3 (H616 SoC with USB 2.0 only), the USB 3.0
  drive would not work with mainline. A USB 2.0 drive was fine.
  Applying your patch below fixed that problem, now both drives worked.
- On the OrangePi Zero (H3 with USB 2.0 only), it worked with and
  without the patch below, with both the USB 2.0 and USB 3.0 drive.
- On the BananaPi M64 (A64 with USB 2.0 only and an onboard USB 2.0
  hub) it also worked in all cases: with and without the patch, USB 2.0
  and USB 3.0 drive.

So the good news is: with the patch below it worked in all cases, with
all drives in all slots, on all boards. With current mainline some
drives don't work at least on the board with the H616 SoC.

I cannot really say if that makes sense, and the results above maybe
more per board than per SoC (different VBUS supply), but would
pragmatically tend to use the patch, feel free to add my Tested-by:
when sending:

Tested-by: Andre Przywara <andre.przywara@arm.com>

Just one tiny thing:

> Once you have tested it, can you please try the patch below
>=20
>         debug("enabling power on all ports\n");
>         for (i =3D 0; i < dev->maxchild; i++) {
> -               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> -               debug("Reset : port %d returns %lX\n", i + 1, dev->status=
);
> +               if (usb_hub_is_superspeed(hub)) {

this must be: usb_hub_is_superspeed(dev)

So many thanks for that patch, that seem to have fixed it for me - even
though I don't understand why. But then again I only have superficial
USB knowledge.

Cheers,
Andre


> +                       usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RE=
SET);
> +                       debug("Reset : port %d returns %lX\n", i + 1,
> dev->status);
> +               }
>                 usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
>                 debug("PowerOn : port %d returns %lX\n", i + 1, dev->stat=
us);
>         }
>=20
>=20
> Thanks

