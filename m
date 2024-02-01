Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEDBC4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 18:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 184B787BDC;
	Thu,  1 Feb 2024 19:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="2/QkMLeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCEDB87CF6; Thu,  1 Feb 2024 19:35:45 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6613C87BDB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 19:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d317aafbd1so564077241.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 10:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1706812542; x=1707417342;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccsHI/NO9wb9Z1+Bt2vCzEmhEyi0GEpCRd7QOQxUMU0=;
 b=2/QkMLeQjgAuvRNlyPiyor5WWYkVTecShQjlzA05SEIxwKauNb0YM2XLegLJ/lXEnv
 WqiP4DmRADJZD/Zm0uYo5/Ju0g9Lv6GG6dHjoGE3MFvkDQemncoqhcxWZYHi7ZZ97zjv
 wfDY9ynrmhkh1RW4iFU95JdRChEt1oBxXdvcFxHZAA4kVp8vokixG7tnOPTVFPtntkLB
 QzHdIdQbnjJiQuEmhoQbMi29foS783esjYoIOXE01QrFzw4DGCMs2T1hXesGaDFdy2Ds
 xT6+mTuQ3fUxUmMYKfVktrgTXebQgRi9QGxViSAoeXeNeLC6YeTMcrnCD8qElbCVBWmk
 ecEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706812542; x=1707417342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ccsHI/NO9wb9Z1+Bt2vCzEmhEyi0GEpCRd7QOQxUMU0=;
 b=H0ToQhRNOYH1Q5KOoFBroViNfHn3M8B64t3BJhHC4OK8yZJ0bJlt7K5T71OydPxnqC
 4oI3h/yS7IG3VRMpDeVs3PnlwTFGKJ+p84SNPrh/HVVtjJ8gqhRkvv+8Uur4OGGo5W8v
 TdW0VMpL3uiIiBte4jQlbxIvS/HXLDmkew49cmGqBnH2ckIveAXgKlVlND4p5I9CzSvT
 9mqWjlGd7YV3uUMseFduCQZdUQ5m9SYSN3YgEMzjjry7Gehi7QOvhlAoK1OgVtz1K6l1
 EsBwDwn8PowAXi7mCNTlyvhIkdIKTlTr+0EFPD2jKzM3OBKsPoTa5OQ5Z/LFqjARMx50
 Zp8A==
X-Gm-Message-State: AOJu0Ywo5MUCDPnN2JMewZVSGtqmhqv0D3IaZGYJd5vJ6eU87xSsnRym
 4IBiWUJhk0+ZN8eyxJheYs4rfT7D8GtzICHMRtO/w0h6g7ZkNCiy9a9TIcJGizdLmY3D8N7TEKE
 YcP6qNBIiPQ3GpYwLPWe8D6iwBaVMMCb6uMbFgg==
X-Google-Smtp-Source: AGHT+IGy7w66+jHx1c4iuzDoJCWz0zar70M+2PiUu3p8TCxgjhs7MCvJaB3e1T0l8pgzNdJ1pbjJke2WW4yWWR6Xn+w=
X-Received: by 2002:a05:6122:4449:b0:4b6:f582:2bac with SMTP id
 cy9-20020a056122444900b004b6f5822bacmr5564067vkb.16.1706812541956; Thu, 01
 Feb 2024 10:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
 <20240201164604.13315fa6@donnerap.manchester.arm.com>
In-Reply-To: <20240201164604.13315fa6@donnerap.manchester.arm.com>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 1 Feb 2024 18:35:28 +0000
Message-ID: <CABEcMwXYw9L957wykfZ5HcC5V88hbgEDZ-E_fYL9LhG_hyxb=g@mail.gmail.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: Andre Przywara <andre.przywara@arm.com>
Cc: marex@denx.de, bmeng.cn@gmail.com, clamor95@gmail.com, 
 Hector Martin <marcan@marcan.st>,
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

Hi Andre,

On Thu, Feb 1, 2024 at 4:46=E2=80=AFPM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> On Thu, 1 Feb 2024 09:39:54 +0000
> Shantur Rathore <i@shantur.com> wrote:
>
> Hi Shantur,
>
> > On Tue, Jan 30, 2024 at 2:01=E2=80=AFPM Andre Przywara <andre.przywara@=
arm.com> wrote:
> > >
> > > On Sat,  9 Dec 2023 18:10:56 +0000
> > > Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi,
> > >
> > > > Currently when a hub is turned on, all the ports are powered on.
> > > > This works well for hubs which have individual power control.
> > > >
> > > > For the hubs without individual power control this has no effect.
> > > > Mostly in these scenarios the hub port is powered before the USB
> > > > controller is enabled, this can lead to some devices in unexpected
> > > > state.
> > > >
> > > > With this patch, we explicitly reset the port while powering up hub
> > > > This resets the port for hubs without port power control and has
> > > > no effect on hubs with port power control as the port is still off.
> > > >
> > > > Before this patch AMicro AM8180 based NVME to USB adapter won't be
> > > > detected as a USB3.0 Mass Storage device but with this it works as
> > > > expected.
> > > >
> > > > Tested working after this patch:
> > > > 1. AMicro AM8180 based NVME to USB Adapter
> > > > 2. Kingston DataTraveler 3.0
> > > > 3. GenesysLogic USB3.0 Hub
> > > >
> > > > The drives were tested while connected directly and via the hub.
> > >
> > > so this broke USB operation on some Allwinner boards. The ports still
> > > enumerate correctly, but no devices are detected. With mainline
> > > (containing this patch), and a USB stick connected:
> > > starting USB...
> > > Bus usb@5200000: USB EHCI 1.00
> > > Bus usb@5200400: USB OHCI 1.0
> > > scanning bus usb@5200000 for devices... 1 USB Device(s) found
> > > scanning bus usb@5200400 for devices... 1 USB Device(s) found
> > >        scanning usb for storage devices... 0 Storage Device(s) found
> > >
> > > With this patch here reverted:
> > > starting USB...
> > > Bus usb@5200000: USB EHCI 1.00
> > > Bus usb@5200400: USB OHCI 1.0
> > > scanning bus usb@5200000 for devices... 2 USB Device(s) found
> > > scanning bus usb@5200400 for devices... 1 USB Device(s) found
> > >        scanning usb for storage devices... 1 Storage Device(s) found
> > >
> > > I have no clue why this happens, there is no discrete hub anywhere in=
 this
> > > setup, so I guess the code runs for the root hub here?
> > > I am attaching a log with DEBUG enabled for common/usb_hub.c, for bot=
h
> > > cases.
> > >
> > > Any clues, debug suggestions, or even a fix are warmly welcome.
> > >
> >
> > Which USB disk are you using? Is it a USB 2.0 disk ?
> > Can you try with any other USB disk to confirm?
>
> Yes, this was some USB 2.0 memory stick, on an USB 2.0 port.
> Most sunxi boards only have USB 2.0, but there is one SoC with USB 3.0, I
> will try some combinations later tonight.
>
> Thanks,
> Andre

That would be awesome.
We need to test

USB 3.0 and 2.0 ports with USB 3.0 and 2.0 drives.

Once you have tested it, can you please try the patch below

        debug("enabling power on all ports\n");
        for (i =3D 0; i < dev->maxchild; i++) {
-               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
-               debug("Reset : port %d returns %lX\n", i + 1, dev->status);
+               if (usb_hub_is_superspeed(hub)) {
+                       usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESE=
T);
+                       debug("Reset : port %d returns %lX\n", i + 1,
dev->status);
+               }
                usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
                debug("PowerOn : port %d returns %lX\n", i + 1, dev->status=
);
        }


Thanks
