Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4749C3ABD9
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 07:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CEC8129F;
	Wed, 14 May 2025 09:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axegjwNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F2881DD6; Wed, 14 May 2025 09:30:44 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 982D380107
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5fcab0243b5so8337594a12.1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747207842; x=1747812642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AaTerfVlqSY6JTnVtADtlV8YAWhL0g9CoKuYnBXg2lA=;
 b=axegjwNwciH30fKHJfxLuYT05qg64QPt0VjhPyFRhTsW8d1CECy2g7zK0ErOJGg3tX
 +czecwluAaBFD+dPWUZDAAwoZ7Hsv4jgmLjAxpW47SVDjBxvlrFU4yZeJFABg6td7U7Y
 UYuAmyKPLEzaxiuciHHyAL1HTvHPpcE7c3PwByFoA7q+WG3p7f6T5riZxZist7hV+HM5
 DFtmcxwUnoDN+DsffC1kZK6ch0tbtcZXoTu2O99AylOtywXJv4sbOj+lTLS1M9zMKZSk
 VajNC1QYHobm9XhF9DA28ERQuv8GJleQTQdaaoNh0e25mCJ7ZjZL5UVAfwlHtLMlfblv
 9W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747207842; x=1747812642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AaTerfVlqSY6JTnVtADtlV8YAWhL0g9CoKuYnBXg2lA=;
 b=dZvR1UQTWxBS4kcPIswtvqKJPFdIlr7ADB1Y36UXH3d0jTXPmFR3BTGf1mFnpNjaen
 /0hotRG8TglJGQhXFVftAzWfdMz1wRKIdmnUolSjGH4OiX0deYdU+tw6t+7RsOI0YzWf
 lbEBPiRdjiWIWpAM2F+4fjLR3duzbmv5Qkn5TF6d4QvVp37ImoNBodMg0BQLRD0FcqFy
 zZDLFn2x9SaXaFWTc+g+hQmG44G/i/oUXRYewmMrAo+UFfemtFWnqS4edlOH6zpdSlr6
 V0SPcizDTvAxJFe50Efh1CUjGJOM84imywrn25BNOv6AND0Eq8XVbCILAVbb4DGuHy0Z
 VuNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj9kUms7FpXM7+K1LGKSGHpptNqJDyMTWCfKQ8oAGONokYySx5sdEopfvzJZmeg5Sbp+WtBBE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2picTHbbTsi9QVsqrmfhxtaOIIKPqP/6Wa8W4FdXPW1E4fQgP
 Eakk2y/0X+ht4Z/3rs+2xhsY3bJs+F0xi4VzOYahjs8TTiVViYKr+PcLy2rbXsgM+0Aeq5bcrLf
 K8Guo01Q72adu+bSLztPh7xj5eZ4=
X-Gm-Gg: ASbGnctvJCX2eWMBBlsTiUyVnK0PnlSZtBGtRehRQqTJ/Ha2zu/2qpoc2osAEaWQmrc
 JrCs0O3WXBfIrcO9OKQ3g3goZAxNUpFuHikPuapXH0wns45gXd9zJ6r5WWZr6FtJqvhLSD7T0SZ
 4L7/o6VXb1egWmfapwb4Nk3T4o4vQmYiw=
X-Google-Smtp-Source: AGHT+IEO70faFoZOtn+XqU4eHDMo8rDZW2umOHAsGG2CzlBswEsioX8JoszUYJhoJfT07c193QKniGl+HjgKKTU8nxQ=
X-Received: by 2002:a17:907:c290:b0:ad2:3fa9:7511 with SMTP id
 a640c23a62f3a-ad4f726ee3fmr211001466b.41.1747207841787; Wed, 14 May 2025
 00:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
 <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
 <183EB9E9446C2114.11104@groups.io>
 <CANAwSgRxLqj+dGH4jDMZFDkAJXe=V7fmKGdEdPU=+cR5NKyg3A@mail.gmail.com>
 <03e20ce1-6e37-4141-b5d6-2f87254a69a1@cherry.de>
In-Reply-To: <03e20ce1-6e37-4141-b5d6-2f87254a69a1@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 14 May 2025 13:00:23 +0530
X-Gm-Features: AX0GCFu6YDd5GQN3gT8I60z4HabUT-2VGZwYM3beGwX65IIzbNJ8phPDP3uxRTg
Message-ID: <CANAwSgSsjpOf8Ru_np5=g3DFnAjPvM_E8+5B7iNir7HfyXb_-g@mail.gmail.com>
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 open list <u-boot@lists.denx.de>, Wayne Schroeder <raz@chewies.net>
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

On Tue, 13 May 2025 at 21:52, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> On 5/13/25 6:14 PM, Anand Moon wrote:
> > Hi All,
> >
> > On Mon, 12 May 2025 at 13:51, Anand Moon via groups.io
> > <linux.amoon=gmail.com@groups.io> wrote:
> >>
> >> Hi Quentin,
> >>
> >> On Mon, 12 May 2025 at 12:36, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>
> >>> Hi Anand,
> >>>
> >>> On 5/9/25 7:45 PM, Anand Moon wrote:
> >>>> Hi Quentin,
> >>>>
> >>>> On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>
> >>>>> Hi Neil, Anand,
> >>>>>
> >>>>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
> >>>>>> On 09/05/2025 09:02, Anand Moon wrote:
> >>>>>>> Add conditional compilation for the usb5744_i2c_init() function based
> >>>>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> >>>>>>>
> >>>>>>>      CC      net/net-common.o
> >>>>>>>      AR      net/built-in.o
> >>>>>>>      LDS     u-boot.lds
> >>>>>>>      LD      u-boot
> >>>>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
> >>>>>>> `usb5744_i2c_init':
> >>>>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
> >>>>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
> >>>>>>> reference to `i2c_get_chip'
> >>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
> >>>>>>> undefined reference to `dm_i2c_write'
> >>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
> >>>>>>> undefined reference to `dm_i2c_write'
> >>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>>>>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
> >>>>>>> undefined reference to `dm_i2c_write'
> >>>>>>> Segmentation fault (core dumped)
> >>>>>>> make: *** [Makefile:1824: u-boot] Error 139
> >>>>>>> make: *** Deleting file 'u-boot'
> >>>>>>>
> >>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>>>>>> ---
> >>>>>>>     common/usb_onboard_hub.c | 4 ++++
> >>>>>>>     1 file changed, 4 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> >>>>>>> index 1242513c631..92e3f3a92c9 100644
> >>>>>>> --- a/common/usb_onboard_hub.c
> >>>>>>> +++ b/common/usb_onboard_hub.c
> >>>>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
> >>>>>>>         int (*init)(struct udevice *dev);
> >>>>>>>     };
> >>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>>>>>>     static int usb5744_i2c_init(struct udevice *dev)
> >>>>>>>     {
> >>>>>>>         /*
> >>>>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
> >>>>>>>         return 0;
> >>>>>>>     }
> >>>>>>> +#endif
> >>>>>>>     int usb_onboard_hub_reset(struct udevice *dev)
> >>>>>>>     {
> >>>>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
> >>>>>>>     };
> >>>>>>>     static const struct onboard_hub_data usb5744_data = {
> >>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>>>>>>         .init = usb5744_i2c_init,
> >>>>>>> +#endif
> >>>>>>>         .power_on_delay_us = 1000,
> >>>>>>>         .reset_us = 5,
> >>>>>>>     };
> >>>>>>
> >>>>>> I think you should completely disable usb5744_data in this case
> >>>>>>
> >>>>>
> >>>>> I would recommend to go the same route as the Linux kernel which has a
> >>>>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
> >>>>> the necessary dependencies.
> >>>>>
> >>>> On Linux kernel, it needs to parse the device node with i2c-bus.
> >>>>
> >>>
> >>> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with
> >>> dev_read_phandle_with_args with i2c-bus?
> >>>
> >> ok.
> >>>>> We probably should be careful and figure out which boards are actually
> >>>>> using the usb5744 and add this symbol to their defconfig so they don't
> >>>>> regress.
> >>>>>
> >>>>   From my initial analysis configs/xilinx_zynqmp_kria_defconfig
> >>>> which use CONFIG_USB_ONBOARD_HUB
> >>>> I believe using DM_I2C to guard the code is the best approach.
> >>>> it should be around .init() callback to guard this to work.
> >>>>
> >>>
> >>> I disagree. The driver clearly supports the USB5744 and the driver is
> >>> compiled regardless of DM_I2C support which is required (as far as I
> >>> understood, maybe that's incorrect?) for being able to use USB5744? I
> >>> don't like hidden dependencies.
> >>>
> >> Okay, I will add a new configuration option to guard the code as done
> >> in the Linux kernel.
> >>> Also, I believe Neil's point is we shouldn't try to probe the USB5744 if
> >>> there is no DM_I2C support, simply excluding .init() callback will
> >>> probably just render this "support" of USB5744 non-functional?
> >>>
> >> Let me debug this more, I will update the next version.
> >> I need to check if this binds correctly to the USB hub reset.
> >
> > I am trying to get the usb_onboard_hub to bind.
> > but this driver is not getting probed in the first place,
> > I am missing some configuration to get this working.
> >
>
> Don't know your setup, but maybe have a look at
> https://lore.kernel.org/u-boot/20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com/
> ?
Thank you for the tip. I've incorporated all the changes as
suggested in this series. However, I'm still unable to get the
usb_onboard_hub_probe to execute, which is preventing me
from further debugging.
>
> Cheers,
> Quentin
Thanks
-Anand
