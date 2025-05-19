Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3285C3ABDD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 13:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4D182B0E;
	Mon, 19 May 2025 15:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M6gTXjXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A0C82B32; Mon, 19 May 2025 15:35:09 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C5181FEE
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 15:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad53cd163d9so482030666b.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747661707; x=1748266507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=67TX9BENfpuEUro5thPb5C8dfwu/e2aIKpyy1xWTrcE=;
 b=M6gTXjXjWzLEDEXyoiL3aN9/6SWFB2AqXngnTmn2WmLu+MLPn+C6tDqIlTaDABdR6n
 8YTN5jr8GZsC9p8xanmdeCeMDm/A8GGq9lJzXExKCE7buFU1mVGY9RL3SGfiSbrZ/yHi
 W/koGuPR5WZkmV/w1f3yEjabmFYhS6jGW/LvcrTXIAfr3UDnmrbIr1aby1jnIE3/yClu
 AGTXLRN6rEgjmGJvbkeG3PbUkUC3g1A1pfXlfe9ZExI5VGNLWiPBq6tE8JpIl2BJ7Lbg
 7h4BdBrSDMfIsfTe4bRo1yeDod+xkDOZuwhgWsLVpZIOAEwelkmBPo/3oPXH6ofjzjaE
 9IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747661707; x=1748266507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=67TX9BENfpuEUro5thPb5C8dfwu/e2aIKpyy1xWTrcE=;
 b=xJpmDj26lzbBYiZjfnuDaPvFsiQFVlYkWxzVOGx2DnPbxuJYbw8Zq+Oaf1HrSbwkbg
 WrToeyVsHRflkEMPAWcarC81Rroqkh3UTjFf+BCreesRimBdQ9TnHUsCq8eo/HXCJBxU
 HajrGly7xNwXlCzY8RMIs0MVo6Z98f64/Kk+/91hy5vMOOAflqxKCttaPyyw6YP+wwQ4
 mqdJ46XRGlTMbM43M8srDocT6WB+g3ctKzS0mzKzXKE33+ZkeHahpr8qYy2GR3OagEb1
 EaSmqy7sVFa/+OaBy9EtQ7CTD157amIWSg6Mh7IKaB/+mF7kDQjVrJeF+8XqpSVyIcjU
 trfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLiS1iK4mrFOufybRaQHcTv2o+AXY6zzLTM/LzTCjHi1dnxuhsuiqmwnVCL8x/+hQ4DXNrrQU=@lists.denx.de
X-Gm-Message-State: AOJu0YwfPY+jijawSGZbrerJjD+CcM+Cp8S2zshsU2aoOEP2CkYpBWRU
 wNO/nJr2i2cH/mp1UTapkWNGWqoniaZukEBiYhMu03pT1FV3ld+AEOjhiXxbzDLxUzC7ho9j8BX
 TwqIzjl61OiCcVGuIyK+vnrB4h/AKLag=
X-Gm-Gg: ASbGncsSKsccJ3VFN21eH8GUAZXHYV1TvloKjwS1444naof3XPUl7WYe29ETAJNBSwb
 ZeNMnpUL65lnNc7kJrL38ZT9fmX587EXmfCl2mkhleQLNVOB5W2iddLlJS/Zhq/FGZ2Vw258X5u
 b5HU4jDRszmjDaV3geavI8+8O9GdgsjTFYpvnGbRvmEg==
X-Google-Smtp-Source: AGHT+IH0MeVqYgmwlB67dmIeAwSFTNGtUdeqone5PvDsYKJH0Y1A1m6pgk0JqyqX/6UYEWV1mE9cirEq9F3J37jxGo4=
X-Received: by 2002:a17:907:c985:b0:ad5:365a:1352 with SMTP id
 a640c23a62f3a-ad5365a29c7mr751001366b.1.1747661706853; Mon, 19 May 2025
 06:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com>
 <CANAwSgSMJGy6hXP8++pfnqkuzH66zhn=UROK4MTs5mrdnyyhFA@mail.gmail.com>
 <3d255a1e-5a3f-4cfe-ae0a-6736dbc49340@cherry.de>
In-Reply-To: <3d255a1e-5a3f-4cfe-ae0a-6736dbc49340@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 19 May 2025 19:04:50 +0530
X-Gm-Features: AX0GCFvXHtYe036mXr_yelGM8FTnrS17mLMtYCpO0GN4DEMIN4gOIv_K7dh2410
Message-ID: <CANAwSgQ+hjmsbG-=o7-5b6tU--OMF6RNmk_4FQnZmMXU_erf+Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Mon, 19 May 2025 at 18:45, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> On 5/19/25 2:42 PM, Anand Moon wrote:
> > Hi Lukasz,
> >
> > On Fri, 25 Apr 2025 at 16:32, Lukasz Czechowski
> > <lukasz.czechowski@thaumatec.com> wrote:
> >>
> >> Currently the check in usb_onboard_hub_bind is relying on specific
> >> compatible string for the Michrochip USB5744. Replace this with
> >> more generic approach that will allow to add new types of devices
> >> to the of_match table. Because the driver only needs to bind one
> >> "half" of the hub, the peer-hub node is used to find out if it
> >> was already done. In case peer-hub was bound, -ENODEV is returned.
> >>
> >> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> >> ---
> >>   common/usb_onboard_hub.c | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> >> index 7fe62b043e6a..9f8c1a304cdf 100644
> >> --- a/common/usb_onboard_hub.c
> >> +++ b/common/usb_onboard_hub.c
> >> @@ -9,6 +9,7 @@
> >>
> >>   #include <asm/gpio.h>
> >>   #include <dm.h>
> >> +#include <dm/device.h>
> >>   #include <dm/device_compat.h>
> >>   #include <i2c.h>
> >>   #include <linux/delay.h>
> >> @@ -179,8 +180,8 @@ err:
> >>   static int usb_onboard_hub_bind(struct udevice *dev)
> >>   {
> >>          struct ofnode_phandle_args phandle;
> >> -       const void *fdt = gd->fdt_blob;
> >> -       int ret, off;
> >> +       struct udevice *peerdev;
> >> +       int ret;
> >>
> >>          ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
> >>          if (ret == -ENOENT) {
> >> @@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *dev)
> >>                  return ret;
> >>          }
> >>
> >> -       off = ofnode_to_offset(phandle.node);
> >> -       ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
> >> -       if (!ret)
> >> +       ret = device_find_global_by_ofnode(phandle.node, &peerdev);
> >> +       if (ret) {
> >> +               dev_dbg(dev, "binding before peer-hub %s\n",
> >> +                       ofnode_get_name(phandle.node));
> >>                  return 0;
> >> +       }
> >> +
> >> +       dev_dbg(dev, "peer-hub %s has been bound\n", peerdev->name);
> >>
> >>          return -ENODEV;
> >>   }
> >>
> >
> > Thanks for your work
> >
> > I'm currently trying to reorder my changes for the
> > Odroid Amlogic platform on top of your patch series.
> > However, I'm facing an issue where the probe is not getting called
> > and it isn't working on the Odroid N2+ board. I'm struggling to identify the
> > missing piece that's causing this failure. Could you share some pointers?
> >
>
> Is the probe function never called or is the device not successfully
> probed? not the same thing :)
>
> Looking at the device tree for the Odroid N2, it seems the onboard USB
> hub is improperly defined.
> Except the compatible and peer-hub properties, **everything** else in
> both nodes need to be absolutely identical because only the first one to
> bind will be probed, and that isn't necessarily stable across reboots or
> rebuilds. So the vdd-supply need to be the same, the reset-gpios need to
> be present and the same as well.
>
Yep I have modified this locally for testing.
> Also, I assume phy-supply for the USB PHY would be enough for toggling
> the enable pin of the USB hub but I'm not sure if it's proper or not,
> maybe we should rather have an enable-gpios in the onboard driver too?
>
Ok I will check this.
> Finally, please also read the cover letter where we explain that the
> second patch fixes some issues when doing a `usb reset`, but that
> there's still a corner case that doesn't work: if the HW default isn't
> holding the reset line then the device may not appear when enumerating,
> because the hub will be found before the device is probed and goes
> through a reset, then the core will detect the device is removed (due to
> reset) and not probe it, so that could also be an issue here.
OK I feel dwc2 is not working on this boards
so I am looking into this issue only dwc3 hub get detected.
>
> Cheers,
> Quentin
Thanks
-Anand
