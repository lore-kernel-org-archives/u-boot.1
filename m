Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3BBC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 08:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394308091A;
	Mon, 12 May 2025 10:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HbMSnlPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6B482162; Mon, 12 May 2025 10:21:57 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB8F805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 10:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso800370866b.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747038115; x=1747642915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SqCXjGOaOyRmuJ2LM1ogFVqI2c0WVm4Zk9Cf68+F7j0=;
 b=HbMSnlPP8d60QMs/kMjh5oAO6RhkIuRs+If9SVFCP7xoeBZMIgP+ujJNxAUf7n7LDi
 iY7NC82OT/1VJFz6zeSdJAo7Z6lkWlT8rOEv+PntuTWfRi+3CJdA+l1G8ffQtR9JdpsN
 Y7KcHLDt/rt6HHtmnuFw3L6dDqb3i43p//ykNoN7wljBs+EZ6NwPhSCELKeajrG67xCP
 fYcAbwCKLw7Pm2WwPhjOS18JgSjBPPpC1TaHaws1T6UiK9prVUabiuNs8p3PyHW9lic4
 ihBYAHnzGIRmBEq8lWKHdIK5cqyVOaftA4C46uVfK6KL9gNq8/FCC3K1RY2Tdbge9k47
 LbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747038115; x=1747642915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SqCXjGOaOyRmuJ2LM1ogFVqI2c0WVm4Zk9Cf68+F7j0=;
 b=OqscLYHYsFlHYX/TsGJItS3HJiaKlf9hCVVMlrKC4Pc1jO2YBCPB1jC+SLqE4g6uqq
 4sRkm4HZAly1fNLmStMNqZnQtC06eEqLRUWT/s7+cnYazGHY31WhPzScqrNxkgT9Gqc8
 D8AQK6xkUM9ebVL3pEGsxgjH5mpJKmbYtHYkWzO+n8eR+4oLWwMhmD9Yudfp9lpma2lb
 6zcZhQNc709TpB2sRObGmWYUE3E3pVedLIcSlqynAOUy4R4Z14t/NBcOckl5EVpuDP8A
 sdcb1eNiSMMhnSO5ppB3fZg6ZNZ6nlr+T0uV5WAtNmuYr6nxZWGuQstrk8kmzyUsgWqo
 Cetw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCkftSH+q0oLcfzpTijDMtqKYdjpJ7S2rJlirkELwhQ5QUF6h+UNCrT0e2O+brYuTSigiGIJg=@lists.denx.de
X-Gm-Message-State: AOJu0YzIq6BLJf4Zz5Xt+C8CkPEgb0I4G1o0d6fcIdwJPEbpfdjniczC
 +gj1iuosSnrmLgysYwyhLvlLOy4f/cSy5XEetDzzsX81hwxtk2TmP/0/ygyGSz8HPVfa//UTILN
 Gr0ybSzfp/+sfnpHk4L83llgZ/yY=
X-Gm-Gg: ASbGnctJBYS2WdOCvqMEOEF3vFulGEJSkPdfkBx72cmIyNwDzVanTBFp2kGeRoiG2lo
 cYvm5+WVQDJIRJOOerumGXNxoLndfp4wYI4Na4nm1YM/W6MDt8hLwEvmW0Ha2T3HqFTwaCoCS2q
 oZKW01OPZurGnKR79LHBU7E4ebT8CoQYM=
X-Google-Smtp-Source: AGHT+IEWIKijUTwMIiigL/EJ3c6UQ7gcBPPvilcngKePbm88GEeM2UTF9NXvrXv4MUS/40Ec+LHi8i9Vi3Zf9nvuYaY=
X-Received: by 2002:a17:907:9448:b0:ad2:532e:abe9 with SMTP id
 a640c23a62f3a-ad2532eb047mr300419866b.1.1747038114696; Mon, 12 May 2025
 01:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
 <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
In-Reply-To: <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 12 May 2025 13:51:40 +0530
X-Gm-Features: AX0GCFtNQncvN1aV-AXS1b-FEVMEFAwQVnI_E3jnIh4qArk3RODuc2xdg3-UUrc
Message-ID: <CANAwSgTH3n3=9vAs5XFBcPLHhfyuwTUFKnBMU2sB=HEuRO24ZQ@mail.gmail.com>
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>, 
 "open list:P200" <u-boot-amlogic@groups.io>, Wayne Schroeder <raz@chewies.net>
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

On Mon, 12 May 2025 at 12:36, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> On 5/9/25 7:45 PM, Anand Moon wrote:
> > Hi Quentin,
> >
> > On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Neil, Anand,
> >>
> >> On 5/9/25 9:57 AM, Neil Armstrong wrote:
> >>> On 09/05/2025 09:02, Anand Moon wrote:
> >>>> Add conditional compilation for the usb5744_i2c_init() function based
> >>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> >>>>
> >>>>     CC      net/net-common.o
> >>>>     AR      net/built-in.o
> >>>>     LDS     u-boot.lds
> >>>>     LD      u-boot
> >>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
> >>>> `usb5744_i2c_init':
> >>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
> >>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
> >>>> reference to `i2c_get_chip'
> >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
> >>>> undefined reference to `dm_i2c_write'
> >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
> >>>> undefined reference to `dm_i2c_write'
> >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
> >>>> undefined reference to `dm_i2c_write'
> >>>> Segmentation fault (core dumped)
> >>>> make: *** [Makefile:1824: u-boot] Error 139
> >>>> make: *** Deleting file 'u-boot'
> >>>>
> >>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>>> ---
> >>>>    common/usb_onboard_hub.c | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> >>>> index 1242513c631..92e3f3a92c9 100644
> >>>> --- a/common/usb_onboard_hub.c
> >>>> +++ b/common/usb_onboard_hub.c
> >>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
> >>>>        int (*init)(struct udevice *dev);
> >>>>    };
> >>>> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>>>    static int usb5744_i2c_init(struct udevice *dev)
> >>>>    {
> >>>>        /*
> >>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
> >>>>        return 0;
> >>>>    }
> >>>> +#endif
> >>>>    int usb_onboard_hub_reset(struct udevice *dev)
> >>>>    {
> >>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
> >>>>    };
> >>>>    static const struct onboard_hub_data usb5744_data = {
> >>>> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>>>        .init = usb5744_i2c_init,
> >>>> +#endif
> >>>>        .power_on_delay_us = 1000,
> >>>>        .reset_us = 5,
> >>>>    };
> >>>
> >>> I think you should completely disable usb5744_data in this case
> >>>
> >>
> >> I would recommend to go the same route as the Linux kernel which has a
> >> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
> >> the necessary dependencies.
> >>
> > On Linux kernel, it needs to parse the device node with i2c-bus.
> >
>
> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with
> dev_read_phandle_with_args with i2c-bus?
>
ok.
> >> We probably should be careful and figure out which boards are actually
> >> using the usb5744 and add this symbol to their defconfig so they don't
> >> regress.
> >>
> >  From my initial analysis configs/xilinx_zynqmp_kria_defconfig
> > which use CONFIG_USB_ONBOARD_HUB
> > I believe using DM_I2C to guard the code is the best approach.
> > it should be around .init() callback to guard this to work.
> >
>
> I disagree. The driver clearly supports the USB5744 and the driver is
> compiled regardless of DM_I2C support which is required (as far as I
> understood, maybe that's incorrect?) for being able to use USB5744? I
> don't like hidden dependencies.
>
Okay, I will add a new configuration option to guard the code as done
in the Linux kernel.
> Also, I believe Neil's point is we shouldn't try to probe the USB5744 if
> there is no DM_I2C support, simply excluding .init() callback will
> probably just render this "support" of USB5744 non-functional?
>
Let me debug this more, I will update the next version.
I need to check if this binds correctly to the USB hub reset.
> Cheers,
> Quentin
Thanks
-Anand
