Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B23C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4B388A7E;
	Wed, 21 Aug 2024 18:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E7YmaErN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD4588BA7; Wed, 21 Aug 2024 18:16:37 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B598863B
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6bf6beda038so40810856d6.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724256994; x=1724861794; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bVrMJVTzDP1rE1CtEJYgijVNFK+AQOH2Luf0vt9lJuo=;
 b=E7YmaErNvhcGYzquTKNI+e4GMzDwIItRcOXz2NXfyjvm58koDmWT8+lN+VW2am7tye
 HEBx5UpBWvhi4HKjkwwPCCE8tkAxfYcRICvDAX/Vz5eaithgZa1FECuUky/+AYz//HSw
 0bkDHWEsICFKY/8YzqBXPCEyyfRcojdi6PPao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724256994; x=1724861794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVrMJVTzDP1rE1CtEJYgijVNFK+AQOH2Luf0vt9lJuo=;
 b=nigERADk0h4LuYC9D8XhCrvkQnySUw7f8jLJXjfVuM4OamYkl0qhY8DEapI6hGDlkZ
 2WzOlw1W81Lb4HJy2J7tGYkipJ70saqVj8MR6x7wen/XqBqzautRRuuDHhhlesWe+Zpn
 QlXZOUhtLA3MVyltEHPEMP9GUHoeUu1xAJ3b5rC+AmwHBPsDpu49/Q+LzLwKAV9aS83a
 /L5as0+0XgmgC6pnwhYon+98EPU6UQVQsShUPNu8wgthmGI4XQose4W1GXoZm13mrNUA
 gXrBBWZhm4O7iCopo1gUISuD3IOIdN2NLVMBBh4E9hEiIHPSAp4HQtj3LIE2FaFQlKY+
 B9cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqbp5vwnnwsbf5OSakTogKKTKVzod9808Q+iM3ZuipRRTZDjfguu/kxcpfNB53zMbBiEAgduU=@lists.denx.de
X-Gm-Message-State: AOJu0YyvA2xKE88EAU+8Jz/Lt/qViBA3agDgXZiIQ4vTllXSOVMYxycf
 oEbD9xHw1dMlNpZD8t4aUdPDNI0Lmp8uv3xsD/Ra1/VEWKVRlu3vz72hfD4wQ7qhILDtdyso8em
 8C4bWNHK9IEVTH/eKhG4BOf/LACl62Dz38YPx
X-Google-Smtp-Source: AGHT+IEcG/lnlhrYRN6iqqdNLpQM4ipygSB7a4jlhxnlGRRuDOjwf8Ulr2f7q6Jx0ikW4nLRxWh5b/KrtFpsp+7qx4A=
X-Received: by 2002:a05:6214:4b10:b0:6bf:75ad:5335 with SMTP id
 6a1803df08f44-6c156878d58mr33297206d6.55.1724256994313; Wed, 21 Aug 2024
 09:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
 <CAFLszTjjS8m2DsNp0nMEknM0ggu4QEET81iSyYFGDYWCwVjf2w@mail.gmail.com>
 <2a45562f-792f-4ad5-9871-bef82ccd2d18@linaro.org>
 <CAFLszTjwjUnGYMdujDUNePBiEU8_oMpkZYpSK8REKxrMYUadpw@mail.gmail.com>
 <eda3f2ad-d011-4ae6-b722-9114daafeae1@linaro.org>
In-Reply-To: <eda3f2ad-d011-4ae6-b722-9114daafeae1@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 10:16:23 -0600
Message-ID: <CAFLszTidT+=wySmu1uo2auxnsbdvm0Qkav-vwu-3vbU9iuEhhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] clk/qcom: add initial clock driver for sc7280
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Wed, 21 Aug 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 21/08/2024 16:37, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Wed, 21 Aug 2024 at 08:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>>> +U_BOOT_DRIVER(gcc_sc7280) = {
> >>>> +       .name           = "gcc_sc7280",
> >>>> +       .id             = UCLASS_NOP,
> >>>> +       .of_match       = gcc_sc7280_of_match,
> >>>> +       .bind           = qcom_cc_bind,
> >>>> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> >>>> +};
> >>>
> >>> This should use driver model, with a UCLASS_CLK and UCLASS_RESET
> >>
> >> Please refer to qcom_cc_bind() which binds the clock, reset, and power
> >> domain drivers.
> >
> > Gosh, why? Are these devices not in the devicetree?
>
> They are, the gcc block contains clock, reset, and pd parts. On Linux
> this is not an issue because a single device can be multiple different
> classes (e..g when you register a reset you do it for a device) whereas
> U-Boot requires a device per class.
>
> e.g. see devm_reset_controller_register() in Linux, it populates a
> struct reset_controller_dev which references the struct device created
> for the node. In U-Boot you have to create a new device which _is_ the
> reset controller.

OK, I see. Rockchip has a CRU (Clock & Reset Unit) which uses syscon
to access registers. The clock driver 'owns' the node in U-Boot and it
manually binds a reset driver. It isn't great, either.

Looking at drivers/clk/qcom/clock-sdm845.c (for example), I can't
actually find "qcom,gcc-sdm845" (for example) in U-Boot, except as a
binding. Can you please point me to the node?

Re devm_reset_controller_register(), yes the U-Boot driver model is a
lot more regular, e.g. we don't really want drivers creating their own
struct udevice. We want all devices to be created automatically by the
devicetree and most memory allocations to be done automatically. This
helps to reduce code size and execution time. You probably know all
this :-)

To a significant degree, the devicetree bindings are created without
much thought to efficient operation in U-Boot. I hope that eventually
this might change.

Anyway, with the devicetree we have, I wonder how we could do this better?

Some ideas:

1. Allow DM to bind multiple devices to each devicetree node, perhaps
as a Kconfig option (to avoid time penalty for all boards), or by
requiring a new DM_FLAG_MULTI_NODE flag. The devices would then be
independent, with no common parent device

2. As 1 but have DM create a parent 'UCLASS_MULTI' device
automatically. I am thinking that we should have a new uclass for
these things, or rename the NOP uclass. This option would allow easy
access to the parent device, if needed.

3. Implement devices which are in more than one uclass. There would
still be a primary uclass, but others can be added too. This would
involve declaring a list of secondary uclasses in the U_BOOT_DRIVER()
macro. We would then have a struct dmtag_node for each secondary
uclass, containing the ID and the uclass pointer. Certain functions
would need to be updated to support this, and again it could be behind
a Kconfig.

What do you think?

Regards,
Simon
