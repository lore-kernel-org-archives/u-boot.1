Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E271BC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 11:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021E3876BF;
	Tue,  2 Jan 2024 12:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o2LY7lRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8722876E2; Tue,  2 Jan 2024 12:54:58 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067BB876BF
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 12:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-466eb1aeb6eso772280137.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704196494; x=1704801294; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xxifxQvJmpXMLX2mNKIquWVHr6WSXXk6V8epaNwPrKY=;
 b=o2LY7lRKbtlwqCDf4a4t/ZFrYhQk/N27b91MqEb43X397eCN/XgmhOy5iN52Gtn1yj
 o3WcUKzuAqD03/7j0gpXyETbZwfhbj8uNxONqNdL+F0qb/74O8AwaQCTvKX4zwXbMX1y
 PSk0hSprR7LkH4NxEM1PjGrNNb09lCsEv+s88Xisp6RBXGAI7lww9m82PnvpVri1ri6l
 F9he/T6oxlkX9WiYwtS41ZkYT1QjEnD7gf+n5Ih9mhaINDQMMatqqrncckcRmT9gPUtH
 KSiGb6Kri/a/FcQrSIIV7aGArYjd+ifiuL7fkMavkEuBSqWGxae9FY1+Ag8Txy0jn/lu
 5juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704196494; x=1704801294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xxifxQvJmpXMLX2mNKIquWVHr6WSXXk6V8epaNwPrKY=;
 b=ghTs/DzjzEWam1skYBYFk7l4AAtinqbGZ0AZbnXmdmkLqv6wqhOEZ23AJS2mpuUV3j
 xUqG5NZMDkj69Q9w5Nv3F2mMm0O9XbtyjAIcLm9cvgdzsKcxIdqVM9Jdf21CT5rp9KVA
 apr+aEC3P9b/xU+wc3T/mCDF84JhXhnx56Zw83nAWmMaqtN2nkLwscCnVwtQfrcxcD/E
 LmxFVMDphEC0ne51qa2GSPUn1i3vUArKHxFh0x+9TTpdl3+Vstg7ZRWI5Kf8JkcDzH14
 bL/6Z7COZ7uUYNlSrd31SVM5inicfTaLOgKZdQOY4oRAhMnMcFaB+gxSPDhMyQT1DyxE
 ihJg==
X-Gm-Message-State: AOJu0YwQYLrruqF0Tw37iPqPjOFTffQBzvOGW/dcH6tL/ZeEhs9+8asI
 vsHMj4llC8ciNMcYu2FACiJMpSI0ERyLV7KR2d07e8rfZuv7kw==
X-Google-Smtp-Source: AGHT+IGLQKTzGoZx61Grxn/fvTVx4wYjV/ObXoZ3llV3wWvfKYmLLTKuHE67Gj1eBApvT6N7AiYN2NZdqpVtHAqGnyA=
X-Received: by 2002:a05:6102:1516:b0:466:c07b:6afa with SMTP id
 f22-20020a056102151600b00466c07b6afamr8025115vsv.4.1704196494109; Tue, 02 Jan
 2024 03:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-12-b6dd9704219e@linaro.org>
 <CAFA6WYMvb230qm95QLPW4iNOXPk0fhxDCP-OFN1FWLCsx9P2yA@mail.gmail.com>
 <e45ca070-82fc-4e5b-a7e9-eb44e956b98f@linaro.org>
 <CAFA6WYNn0PDxikfVNnACiT2HZ=zge=O7XnpynPVfe61rKiedDA@mail.gmail.com>
 <5b833208-49b9-4cff-8160-930bf26172b0@linaro.org>
In-Reply-To: <5b833208-49b9-4cff-8160-930bf26172b0@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 2 Jan 2024 17:24:42 +0530
Message-ID: <CAFA6WYPN+oEXCB3dS4EcBrOy6hKNhPawXhhx3x+FvTZ6Nb-b1g@mail.gmail.com>
Subject: Re: [PATCH v2 12/32] board: dragonboard410c: upstream DT compat
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Tue, 2 Jan 2024 at 14:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 26/12/2023 10:30, Sumit Garg wrote:
> > On Fri, 22 Dec 2023 at 21:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Hi Sumit,
> >>
> >> [...]
> >>>> -       if (init == USB_INIT_HOST) {
> >>>> -               /* Start USB Hub */
> >>>> -               dm_gpio_set_dir_flags(&hub_reset,
> >>>> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> >>>> -               mdelay(100);
> >>>> -               /* Switch usb to host connectors */
> >>>> -               dm_gpio_set_dir_flags(&usb_sel,
> >>>> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> >>>> -               mdelay(100);
> >>>> -       } else { /* Device */
> >>>> -               /* Disable hub */
> >>>> -               dm_gpio_set_dir_flags(&hub_reset, GPIOD_IS_OUT);
> >>>> -               /* Switch back to device connector */
> >>>> -               dm_gpio_set_dir_flags(&usb_sel, GPIOD_IS_OUT);
> >>>> +       /* Select "default" or "device" pinctrl */
> >>>> +       switch (init) {
> >>>> +       case USB_INIT_HOST:
> >>>> +               pinctrl_select_state(usb, "default");
> >>>> +               break;
> >>>> +       case USB_INIT_DEVICE:
> >>>> +               pinctrl_select_state(usb, "device");
> >>>> +               break;
> >>>> +       default:
> >>>> +               debug("Unknown usb_init_type %d\n", init);
> >>>> +               break;
> >>>
> >>> Can this pinctrl configuration move to the corresponding USB driver instead?
> >>
> >> Possibly, this is definitely something where DT is currently lacking,
> >> similar discussions in Linux resulted in the USB onboard_hub driver, it
> >> would be nice to add support for that U-Boot at some point.
> >>
> >> I don't think putting the pinctrl code directly into the USB driver is
> >> the right way to go, as it definitely wouldn't be accepted in upstream
> >> DT bindings.
> >
> > As discussed in the other thread,
> > arch/arm/mach-snapdragon/board_apq8016.c would be a better place for
> > the time being.
>
> I would instead prefer this go in mach-snapdragon/board.c and include a
> conditional to check for a named pinctrl on the USB device, using
> "uclass_find_device_by_seq()" to fetch the device would then make this
> properly generic.

Yes, that can be a further step and I don't expect that to be part of
this series. But since this patch is moving stuff, we should move SoC
specific bits to mach-snapdragon/board_apq8016.c rather than its
opposite to the db410c specific file.

>
> This is really not relevant to this patch series, but is a change that
> makes sense when introducing support for new boards, let's limit
> discussion to the other thread [1].

But why? The USB stuff we are discussing here is relevant to existing
board support, right?

-Sumit

>
> [1]:
> https://lore.kernel.org/u-boot/f805111d-106e-4904-ae9d-e63596f7db4e@linaro.org/
> >
> > -Sumit
> >
> >>>
> >>> -Sumit
> >>>
> >> --
> >> // Caleb (they/them)
>
> --
> // Caleb (they/them)
