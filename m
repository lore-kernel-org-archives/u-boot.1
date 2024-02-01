Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A82C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 11:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B83878E2;
	Thu,  1 Feb 2024 12:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="MNkcr2PV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A316187C58; Thu,  1 Feb 2024 12:19:06 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE7D8746C
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 12:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4bfe7d5ed66so290050e0c.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 03:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1706786342; x=1707391142;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHGljRkv10DEhkql4aCmkddkZauQMbz4gc18594fz1Y=;
 b=MNkcr2PVlX+px4NnXKal064susACKt4UuVgLSoyTZCWOsXzIkDxa8ANALKSAH5XRPt
 2MXt92KjF+Z+V0hE4xLoxJZ/BCbG2e+JuTvk7jqebGOK4XQLlX7JuRGacq1PdoDDMUNf
 roJ62twfO9IcwA2bLdofqbVtOPkWyIRdtvHhCDKTSZZlBr3+oZQjOeiJ61/1fjuNA4XZ
 c1BtzJ7IuOwMZNhxjyk0P9JfA0+8U2jb6o7iYDFcthcCr/XYso6rUDRBo9XZgpiwCh5K
 VzJtpFrLIlkx+b08Pc33TWyL4PygBoqfK7bBhShkjQ+/761j5JCQ5rO5nDTfmmIzue4C
 fDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706786342; x=1707391142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHGljRkv10DEhkql4aCmkddkZauQMbz4gc18594fz1Y=;
 b=tLPqO3HbikDuROfLPjzOsMwul4yLKPMEoL/Af+ZiIhQ5sOBpxvYCUMbcQ7dOOY8hW3
 PYd1dA7HS67dxD+cmZTrt7DiEOQw5xUe/XCfrVPg6qrBsSrVX6w6znTF50ut1WOkFpj0
 RA/jRrTlU6o46NMOU8bbEjwilK+vgWL82VWh+3QIlsQccuVvD6PhYNqISDAcY6RMk65U
 A2z0fmSNeW7yWHzhPW1UsQbOTLsAx7QY77rqBJsJOTBEWcvZh8Q4te/yY0nxEfBdAJoU
 yHa59boWG+ZX70Ny3uTTxv2p0GAywKvsZNVtDEK+kF8AVsVB4/7i7QsBDI1ghLF6ROId
 XCeQ==
X-Gm-Message-State: AOJu0Yy4kXu27OfobAxALCzPbWmHRjNmAlgOqN4KA5h+F0AJ7iRVyuZj
 wFG2+K7xZRxC0GwLvx3MWQuaFecGg2fP+IsC1DOSuy4b4lozj39UoWsq4DTE1rI7mwaY6vM1HYL
 T/hcM0NNfsHx/UXQX1i6qwMVv8iwJ5Ry2MqdOZYEHQbD8zF5KY2A=
X-Google-Smtp-Source: AGHT+IF1NxFUZ4LrQSwjM1jizE9lCk7BteD6G5oExtNM1/Lk9BZ1+zCP2+ejHFkveIldNr/myxn4Kq+W4lKReWN2Rko=
X-Received: by 2002:a05:6122:2010:b0:4b7:b55b:a8e9 with SMTP id
 l16-20020a056122201000b004b7b55ba8e9mr4867960vkd.13.1706786341860; Thu, 01
 Feb 2024 03:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
 <3f508431-c4bd-4885-b3b9-f281b6a653e1@denx.de>
In-Reply-To: <3f508431-c4bd-4885-b3b9-f281b6a653e1@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 1 Feb 2024 11:18:50 +0000
Message-ID: <CABEcMwXR5VZNCgKbQDbPafj2mmmAkE6_ehoM8KfMuGjCyX09aA@mail.gmail.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: Marek Vasut <marex@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, bmeng.cn@gmail.com,
 clamor95@gmail.com, Hector Martin <marcan@marcan.st>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

On Thu, Feb 1, 2024 at 11:13=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 2/1/24 10:39, Shantur Rathore wrote:
> > Hi Andre,
> >
> > On Tue, Jan 30, 2024 at 2:01=E2=80=AFPM Andre Przywara <andre.przywara@=
arm.com> wrote:
> >>
> >> On Sat,  9 Dec 2023 18:10:56 +0000
> >> Shantur Rathore <i@shantur.com> wrote:
> >>
> >> Hi,
> >>
> >>> Currently when a hub is turned on, all the ports are powered on.
> >>> This works well for hubs which have individual power control.
> >>>
> >>> For the hubs without individual power control this has no effect.
> >>> Mostly in these scenarios the hub port is powered before the USB
> >>> controller is enabled, this can lead to some devices in unexpected
> >>> state.
> >>>
> >>> With this patch, we explicitly reset the port while powering up hub
> >>> This resets the port for hubs without port power control and has
> >>> no effect on hubs with port power control as the port is still off.
> >>>
> >>> Before this patch AMicro AM8180 based NVME to USB adapter won't be
> >>> detected as a USB3.0 Mass Storage device but with this it works as
> >>> expected.
> >>>
> >>> Tested working after this patch:
> >>> 1. AMicro AM8180 based NVME to USB Adapter
> >>> 2. Kingston DataTraveler 3.0
> >>> 3. GenesysLogic USB3.0 Hub
> >>>
> >>> The drives were tested while connected directly and via the hub.
> >>
> >> so this broke USB operation on some Allwinner boards. The ports still
> >> enumerate correctly, but no devices are detected. With mainline
> >> (containing this patch), and a USB stick connected:
> >> starting USB...
> >> Bus usb@5200000: USB EHCI 1.00
> >> Bus usb@5200400: USB OHCI 1.0
> >> scanning bus usb@5200000 for devices... 1 USB Device(s) found
> >> scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >>         scanning usb for storage devices... 0 Storage Device(s) found
> >>
> >> With this patch here reverted:
> >> starting USB...
> >> Bus usb@5200000: USB EHCI 1.00
> >> Bus usb@5200400: USB OHCI 1.0
> >> scanning bus usb@5200000 for devices... 2 USB Device(s) found
> >> scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >>         scanning usb for storage devices... 1 Storage Device(s) found
> >>
> >> I have no clue why this happens, there is no discrete hub anywhere in =
this
> >> setup, so I guess the code runs for the root hub here?
> >> I am attaching a log with DEBUG enabled for common/usb_hub.c, for both
> >> cases.
> >>
> >> Any clues, debug suggestions, or even a fix are warmly welcome.
> >>
> >
> > Which USB disk are you using? Is it a USB 2.0 disk ?
> > Can you try with any other USB disk to confirm?
>
> I don't think this is device specific, see the logs. Hardware from Andre
> worked before this patch, does not work after this patch. There seem to
> be no connection event with this patch.

I am trying to evaluate if this is happening due to a USB 2.0 device.
I see that the host is USB 2.0. I have tested this on my RK3399 board on bo=
th
USB 2.0 and USB 3.0 ports.
If this is not behaving on USB 2.0 ports then I can put a condition
for this to happen
only on USB 3.0 ports.
