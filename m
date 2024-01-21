Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F61C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 21:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86064877BB;
	Sun, 21 Jan 2024 22:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="fal6Msqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA21C8775F; Sun, 21 Jan 2024 22:37:47 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7854487872
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 22:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6853f6ff6e1so13224896d6.2
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1705873064; x=1706477864;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ha36yMCgm77Hv/ChSoVe1yjlAR9tYzTBaLTrsZlQURY=;
 b=fal6Msqnu+rxsBejpEMqy537PelcMNaKBERQv+BoS5an9ooPBgMwUZbC6eLdhgHdTo
 hPKLLOpLmVkjOHwAqUYJTEckSRWa/nCEuZ71CtuzyrlQTUysbqJ1NXfiuUcyTh7WNYdW
 YZcwC7aGRiPAbKZ2Cpq09bxvG2WdQqu5yS3hIckyRo7EH1Hb94X+bPhUY+rw8aY+3wby
 oAXx/Jzp+tCb+LpHmK7LGohrcOnI8aIgQD4yjNqv/9w5IdP7vpZiuwB/GAR0TcvRN82/
 vzURilyAk8P40w9jgVwMKj0lELaNODjdggGE55wT32sC/MsD0sBl4kO57xeorqwNpGWw
 fiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705873064; x=1706477864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ha36yMCgm77Hv/ChSoVe1yjlAR9tYzTBaLTrsZlQURY=;
 b=kkzozby3tsxDIgMOzmLOFptnNdiW3Xd7cxMHf/y6S/5txq6wzToCw+doM7aQK6YuPu
 cPn616ZCns2D/39i6kiBCBNKRMvIhcZUOSpt+waeZhUIO+6kYZmsFBVKn9yHaEGv2Cg7
 Iy46Qn8A+MxLwhRhjN6nSUOBl49j6iNjhAP2GsGlHT+dX38gGS0YigawfreIoc8+0woU
 MyVXArHNLNZjFdNmNf0/DNSLuwgYCJ5yDN0rUavmtmDmbyzHjf+5YOW0vVhyrSUbTlfD
 4eiUpi9oEBwlJYhutS89rVCWo6SSRWfhVDi1vEZKV+otbsfIWt1gcPxAvSabb4a/EhA1
 VTiw==
X-Gm-Message-State: AOJu0YwksdG/vTCLTrWWZeDl/zGbkECh/2G0fXhfINIixE+AscB5qtWY
 56muK60LIr+VVtICmNSWmfmuZLoW7uFki1ZSc2um6oKCh3zXlfUwTu3YswXoo1/pZXhozpzCVBq
 Zs1gpgi0zH5Gr3iqMyxseDquX8uTkvmn2IcReGA==
X-Google-Smtp-Source: AGHT+IEWo3nVlFmVpCDBwqCLVR/PZM60xSE2zQUKN7tvIYRed1fR1RM07XuqmN3BDnyzCNLR8feo8X5ymrFRB26BoyI=
X-Received: by 2002:a0c:ca8f:0:b0:685:3856:5eff with SMTP id
 a15-20020a0cca8f000000b0068538565effmr3885852qvk.9.1705873064286; Sun, 21 Jan
 2024 13:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20231209181057.331815-1-i@shantur.com>
 <CABEcMwWzt=z=3XNWq5iAKmmnB+UsjTzp4_OUs3V8bNuc_i5zMw@mail.gmail.com>
 <0b0659ab-8361-481b-b863-0b4db0db53b5@denx.de>
In-Reply-To: <0b0659ab-8361-481b-b863-0b4db0db53b5@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 21 Jan 2024 21:37:33 +0000
Message-ID: <CABEcMwU-Pjn7wkWe2jipFHyQFF-_-G8ugH0ECvxqqZTFex3w5Q@mail.gmail.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin <marcan@marcan.st>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Tue, Jan 16, 2024 at 12:45=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 1/8/24 23:11, Shantur Rathore wrote:
> > Hi Marex,
> >
> > On Sat, Dec 9, 2023 at 6:12=E2=80=AFPM Shantur Rathore <i@shantur.com> =
wrote:
> >>
> >> Currently when a hub is turned on, all the ports are powered on.
> >> This works well for hubs which have individual power control.
> >>
> >> For the hubs without individual power control this has no effect.
> >> Mostly in these scenarios the hub port is powered before the USB
> >> controller is enabled, this can lead to some devices in unexpected
> >> state.
> >>
> >> With this patch, we explicitly reset the port while powering up hub
> >> This resets the port for hubs without port power control and has
> >> no effect on hubs with port power control as the port is still off.
> >>
> >> Before this patch AMicro AM8180 based NVME to USB adapter won't be
> >> detected as a USB3.0 Mass Storage device but with this it works as
> >> expected.
> >>
> >> Tested working after this patch:
> >> 1. AMicro AM8180 based NVME to USB Adapter
> >> 2. Kingston DataTraveler 3.0
> >> 3. GenesysLogic USB3.0 Hub
> >>
> >> The drives were tested while connected directly and via the hub.
> >>
> >> Signed-off-by: Shantur Rathore <i@shantur.com>
> >>
> >> ---
> >>
> >> Changes in v3:
> >> - Split up patches as seperate series
> >>
> >> Changes in v2:
> >> - As requested, added fix for regulator-always-on in RockPro64
> >>
> >>   common/usb_hub.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/common/usb_hub.c b/common/usb_hub.c
> >> index 70279f301d..3fb7e14d10 100644
> >> --- a/common/usb_hub.c
> >> +++ b/common/usb_hub.c
> >> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_devic=
e *hub)
> >>
> >>          debug("enabling power on all ports\n");
> >>          for (i =3D 0; i < dev->maxchild; i++) {
> >> +               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> >> +               debug("Reset : port %d returns %lX\n", i + 1, dev->sta=
tus);
> >>                  usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER)=
;
> >> -               debug("port %d returns %lX\n", i + 1, dev->status);
> >> +               debug("PowerOn : port %d returns %lX\n", i + 1, dev->s=
tatus);
> >>          }
> >>
> >>   #ifdef CONFIG_SANDBOX
> >> --
> >> 2.40.1
> >>
> >
> > Do you think it is the right time to get this in early so it can be
> > tested for a longer time before the next release ?
>
> Yes, I think so, sorry for the delay.
>
> I asked Tom to pick it directly and provided RB .

Thanks Marek,

Just realised Tom isn't included in this chain.

@Tom Rini - Can I request you to please merge this earlier in this release.

Kind regards,
Shantur
