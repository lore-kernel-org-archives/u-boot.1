Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D826FC4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 16:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32ACE87CC1;
	Thu,  1 Feb 2024 17:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="hQgyWRDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C604587D16; Thu,  1 Feb 2024 17:00:32 +0100 (CET)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284A687C66
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 17:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4bff041ebb9so446057e0c.3
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 08:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1706803229; x=1707408029;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irwkznNMA9J+MuRsJzmNwmXHSmpr5tIChtQTPt7YVRA=;
 b=hQgyWRDT3wcUSl6T/M82b8XCuS6fL0SoLHlDeOnfhwdJIvSMYCBpWVcP9CjsLqOHFg
 xWmo3LkF9DLxSPDmmfVOzk/27mpANoVp3cN4d/4aAxnhqBnsxYBXwdn4ccmvBW87978i
 4mlVVLaX8OhSdiabqVNdGuyR8Dns8bcZt5BhYf5KE6KE4QMD1NAU8A22+gi+uWd7xWNc
 H+6QnqrvmxJj2sagg9ErYXwBYxEQCmk1XGvFi0bmsDIMgI7UQ1++F4jAUbSQt42cN2OP
 CJyXLvfaX7NiSTfxmgkBbOC+IVlX16pSiHE9lLyYHBHd1bNCXGz7rBIaHbr69aN+Hy6N
 g9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706803229; x=1707408029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irwkznNMA9J+MuRsJzmNwmXHSmpr5tIChtQTPt7YVRA=;
 b=TUfYmXVawKuF2fton4jBW2bP25pEabQomMZTgCGWc2ErCU5wb6H6NqgJOZq1YgLpPv
 rPNZTe6qpON40V1CzuTX/ushiOli9RHGxhvKNsQ1hw1G/S1o6gprSyuRrd/Qd4xzzqFi
 lmoaxP6Um1B+MeS9Y8hqAYAWg9dj8cYOlrbs6VmdDA7e9I2B5d/RJk8ZvNo+MXsdfw17
 wWq7pVtCQcrwxbpUOWFeFEi6rk9rF9rzIXlC9vNCG62U6tLt5uTv3AcWxtb7sUgDlLOb
 B5PjOf/IGUgQsrpN+H8j5A35Kp6rIyUh7w2bc5bl5a3DN7hlQ+Yvp4vjkpzwAT4uAReF
 gR/Q==
X-Gm-Message-State: AOJu0Yy1MCPbzPqiKa0vOnxIWWvRoAnKZZWoRnpyBidM3PkGSv8UJMfV
 ulz0TzMVBbmHxDK+Wke4TpN7Ev0z3zED1jb8Vy73dK+B2CT6ngNfPGzf3nDSoVz5HrNoJEC7a5E
 AqoSVQi3e2i/3jAfYSk0PMCeCW4bfZfCIOU0BNQ==
X-Google-Smtp-Source: AGHT+IHYCWnpad5eTz/HpH10zaLAM49TTgK4YQIcZrp2UT4fk9ELkZX9G7Vz14DgPLk5nRL2hrOkcW2l4JKs5/TK7z0=
X-Received: by 2002:a05:6122:4c03:b0:4b6:cb66:778c with SMTP id
 ff3-20020a0561224c0300b004b6cb66778cmr4610525vkb.16.1706803228853; Thu, 01
 Feb 2024 08:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
 <3f508431-c4bd-4885-b3b9-f281b6a653e1@denx.de>
 <CABEcMwXR5VZNCgKbQDbPafj2mmmAkE6_ehoM8KfMuGjCyX09aA@mail.gmail.com>
 <810f330e-a5cc-49cc-8a7b-1b7ad5b08910@denx.de>
In-Reply-To: <810f330e-a5cc-49cc-8a7b-1b7ad5b08910@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 1 Feb 2024 16:00:17 +0000
Message-ID: <CABEcMwXZUT8KMjFfriwTbPU3bNs7UGP3wW6i_yMSy7fLQ7xasA@mail.gmail.com>
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

On Thu, Feb 1, 2024 at 2:53=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 2/1/24 12:18, Shantur Rathore wrote:
> > On Thu, Feb 1, 2024 at 11:13=E2=80=AFAM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 2/1/24 10:39, Shantur Rathore wrote:
> >>> Hi Andre,
> >>>
> >>> On Tue, Jan 30, 2024 at 2:01=E2=80=AFPM Andre Przywara <andre.przywar=
a@arm.com> wrote:
> >>>>
> >>>> On Sat,  9 Dec 2023 18:10:56 +0000
> >>>> Shantur Rathore <i@shantur.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>>> Currently when a hub is turned on, all the ports are powered on.
> >>>>> This works well for hubs which have individual power control.
> >>>>>
> >>>>> For the hubs without individual power control this has no effect.
> >>>>> Mostly in these scenarios the hub port is powered before the USB
> >>>>> controller is enabled, this can lead to some devices in unexpected
> >>>>> state.
> >>>>>
> >>>>> With this patch, we explicitly reset the port while powering up hub
> >>>>> This resets the port for hubs without port power control and has
> >>>>> no effect on hubs with port power control as the port is still off.
> >>>>>
> >>>>> Before this patch AMicro AM8180 based NVME to USB adapter won't be
> >>>>> detected as a USB3.0 Mass Storage device but with this it works as
> >>>>> expected.
> >>>>>
> >>>>> Tested working after this patch:
> >>>>> 1. AMicro AM8180 based NVME to USB Adapter
> >>>>> 2. Kingston DataTraveler 3.0
> >>>>> 3. GenesysLogic USB3.0 Hub
> >>>>>
> >>>>> The drives were tested while connected directly and via the hub.
> >>>>
> >>>> so this broke USB operation on some Allwinner boards. The ports stil=
l
> >>>> enumerate correctly, but no devices are detected. With mainline
> >>>> (containing this patch), and a USB stick connected:
> >>>> starting USB...
> >>>> Bus usb@5200000: USB EHCI 1.00
> >>>> Bus usb@5200400: USB OHCI 1.0
> >>>> scanning bus usb@5200000 for devices... 1 USB Device(s) found
> >>>> scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >>>>          scanning usb for storage devices... 0 Storage Device(s) fou=
nd
> >>>>
> >>>> With this patch here reverted:
> >>>> starting USB...
> >>>> Bus usb@5200000: USB EHCI 1.00
> >>>> Bus usb@5200400: USB OHCI 1.0
> >>>> scanning bus usb@5200000 for devices... 2 USB Device(s) found
> >>>> scanning bus usb@5200400 for devices... 1 USB Device(s) found
> >>>>          scanning usb for storage devices... 1 Storage Device(s) fou=
nd
> >>>>
> >>>> I have no clue why this happens, there is no discrete hub anywhere i=
n this
> >>>> setup, so I guess the code runs for the root hub here?
> >>>> I am attaching a log with DEBUG enabled for common/usb_hub.c, for bo=
th
> >>>> cases.
> >>>>
> >>>> Any clues, debug suggestions, or even a fix are warmly welcome.
> >>>>
> >>>
> >>> Which USB disk are you using? Is it a USB 2.0 disk ?
> >>> Can you try with any other USB disk to confirm?
> >>
> >> I don't think this is device specific, see the logs. Hardware from And=
re
> >> worked before this patch, does not work after this patch. There seem t=
o
> >> be no connection event with this patch.
> >
> > I am trying to evaluate if this is happening due to a USB 2.0 device.
> > I see that the host is USB 2.0. I have tested this on my RK3399 board o=
n both
> > USB 2.0 and USB 3.0 ports.
> > If this is not behaving on USB 2.0 ports then I can put a condition
> > for this to happen
> > only on USB 3.0 ports.
>
> Doesn't Linux perform this reset for all ports unconditionally ?


Looks like it doesn't
https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2841
