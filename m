Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE134C48286
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 16:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1946F87C65;
	Thu,  1 Feb 2024 17:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E3186F7E; Thu,  1 Feb 2024 17:46:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8E96B87C65
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 17:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B9BDA7;
 Thu,  1 Feb 2024 08:46:50 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B99123F738;
 Thu,  1 Feb 2024 08:46:06 -0800 (PST)
Date: Thu, 1 Feb 2024 16:46:04 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Shantur Rathore <i@shantur.com>
Cc: marex@denx.de, bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin
 <marcan@marcan.st>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon
 Glass <sjg@chromium.org>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
Message-ID: <20240201164604.13315fa6@donnerap.manchester.arm.com>
In-Reply-To: <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Thu, 1 Feb 2024 09:39:54 +0000
Shantur Rathore <i@shantur.com> wrote:

Hi Shantur,

> On Tue, Jan 30, 2024 at 2:01=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
> >
> > On Sat,  9 Dec 2023 18:10:56 +0000
> > Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi,
> > =20
> > > Currently when a hub is turned on, all the ports are powered on.
> > > This works well for hubs which have individual power control.
> > >
> > > For the hubs without individual power control this has no effect.
> > > Mostly in these scenarios the hub port is powered before the USB
> > > controller is enabled, this can lead to some devices in unexpected
> > > state.
> > >
> > > With this patch, we explicitly reset the port while powering up hub
> > > This resets the port for hubs without port power control and has
> > > no effect on hubs with port power control as the port is still off.
> > >
> > > Before this patch AMicro AM8180 based NVME to USB adapter won't be
> > > detected as a USB3.0 Mass Storage device but with this it works as
> > > expected.
> > >
> > > Tested working after this patch:
> > > 1. AMicro AM8180 based NVME to USB Adapter
> > > 2. Kingston DataTraveler 3.0
> > > 3. GenesysLogic USB3.0 Hub
> > >
> > > The drives were tested while connected directly and via the hub. =20
> >
> > so this broke USB operation on some Allwinner boards. The ports still
> > enumerate correctly, but no devices are detected. With mainline
> > (containing this patch), and a USB stick connected:
> > starting USB...
> > Bus usb@5200000: USB EHCI 1.00
> > Bus usb@5200400: USB OHCI 1.0
> > scanning bus usb@5200000 for devices... 1 USB Device(s) found
> > scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >        scanning usb for storage devices... 0 Storage Device(s) found
> >
> > With this patch here reverted:
> > starting USB...
> > Bus usb@5200000: USB EHCI 1.00
> > Bus usb@5200400: USB OHCI 1.0
> > scanning bus usb@5200000 for devices... 2 USB Device(s) found
> > scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >        scanning usb for storage devices... 1 Storage Device(s) found
> >
> > I have no clue why this happens, there is no discrete hub anywhere in t=
his
> > setup, so I guess the code runs for the root hub here?
> > I am attaching a log with DEBUG enabled for common/usb_hub.c, for both
> > cases.
> >
> > Any clues, debug suggestions, or even a fix are warmly welcome.
> > =20
>=20
> Which USB disk are you using? Is it a USB 2.0 disk ?
> Can you try with any other USB disk to confirm?

Yes, this was some USB 2.0 memory stick, on an USB 2.0 port.
Most sunxi boards only have USB 2.0, but there is one SoC with USB 3.0, I
will try some combinations later tonight.

Thanks,
Andre
