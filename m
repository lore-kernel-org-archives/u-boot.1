Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC1CC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 08:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16283880F3;
	Thu, 28 Mar 2024 09:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="COh6K9Pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37544880F3; Thu, 28 Mar 2024 09:34:12 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1794880B2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d485886545so9950151fa.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711614848; x=1712219648; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MPGZ6Ade+Jys6IGgkWlcBBtkwM0k4StVHzWYvkq2Xrw=;
 b=COh6K9PjzqRFcXWEXTqPP8+zODiKL+2P9RzINstXkUXuEqZnF79vgXiolztEwy+mX8
 p0itNVzygfI57Kjj0krEOtVwV9oBaQmIrTLahfBL7USV/neDfBofcFFMUYQUjg4P80pB
 jUMmmSXVDppjOobo+uK2g1E3RcSOLvihGDscnql6cSrribU9YTfIKhSqWP2tWqQmXYDM
 9ImPE5FocyrBfcQZ2S1zl9F+o5bg3gzBiKiJ8IxxTxLI9zAYQ2D4Hl5unpOsm51+FeOh
 0ZTmZrrJerm7oPQTZfcFuubjKfWnxTRhmtpgBIkxpwKAJCWLH3APN++4zsOfT60gZ2JB
 lSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711614848; x=1712219648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MPGZ6Ade+Jys6IGgkWlcBBtkwM0k4StVHzWYvkq2Xrw=;
 b=cFCeQNfqGPltC3tTPEFm6FGO4/r8jdPTRBWrybzWMWYpvSfmCumbx+cILCJyNZRbmf
 cpEXeZH8e+KqYgByKxT+D6hz/vEnmAWPmU1hlwtCql8U54fAQNwYXlqtPxl52BB0YT+u
 KeWAYVDXVNFRL3MI86P6jp00G3XF4OLL3PTnXyPNeO1ySunFv4I9kCfdKOh9wMAf+qRt
 mEYy1uWCY3VbiIPd7jQvkIiSQSJZvzAB/7HSYJRwvsQr0rC6h8E1nQBvhrtFSgpRUAMP
 m6C/+K4rQsTlulEEZR25NzkJaeiihRQyLT+Zv7euruCwBqvBoxvUyAT53cVMmiHunRlQ
 Y6EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzdDq8Jr7PevtTPLe06Aht4do0GgLSSPgfbuy7RnqnvphBwBAHVDQy/c+bRjwYIchtwoS4tHQi8Lh9YvFpTNJlai+p0g==
X-Gm-Message-State: AOJu0YwGyaRiMhzg1VxfUV3zWmafwcuatVeQzJ9At3B5UYrJVERD3cea
 hRO3U3F3bLtl0jxOtWtsee3/6H2MeSQZdRF6/3qiuC5oYaEOT6C5JxtfD9xQVSETfRaM/iZFCXD
 tkmX5xu3uwD2fwKnokpyULg4AhNeIi2Oq2I4Dog==
X-Google-Smtp-Source: AGHT+IGlQV4jbj2ddsQG69zLvZMLCXbh/UvolyjJ43tbws+DBTDCFmsVOvsBarrB7XJp4fe3UGFQ0NSROU6rX/r5t2k=
X-Received: by 2002:a2e:8010:0:b0:2d4:a20f:299f with SMTP id
 j16-20020a2e8010000000b002d4a20f299fmr2157995ljg.35.1711614847866; Thu, 28
 Mar 2024 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU12-4EJN_RPGPPTfTVden2=beq-XaeFL=dF7t+AAqje=Q@mail.gmail.com>
 <CAC_iWj+B0r7o8Hwi_KZM=+L9t6=THH=pzY38jrcDDdAntWT3Rw@mail.gmail.com>
 <CAJ+vNU0380ved3FWt_R4UVR3stFrb3B4dLTx=m6dp0377MK6hQ@mail.gmail.com>
 <afab8b1e-ad41-47fc-ad76-383151f4caf2@linux.ibm.com>
 <CAC_iWjK47NBn89yMs0FsMGtOijHTAta5uYmZL=oumzhzyW29WQ@mail.gmail.com>
 <CAJ+vNU228uHF3D6BzLjZifb1d-GN7tSTLJmaZRDk0tQWDrYknw@mail.gmail.com>
 <CAC_iWjK8SHvZeEUgDeBRYpq8LgU=M5bqQQbSYwTxsrV_H1hdVA@mail.gmail.com>
 <CAJ+vNU0ONNOr2-sQTMVnuhQPug+mUimcfMMQj=DEs9a8fprMOg@mail.gmail.com>
In-Reply-To: <CAJ+vNU0ONNOr2-sQTMVnuhQPug+mUimcfMMQj=DEs9a8fprMOg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Mar 2024 10:33:31 +0200
Message-ID: <CAC_iWj+kE+-q60GzPBcO2xYxKX6eUSkJ1UwC4atg4BmXHNzA7g@mail.gmail.com>
Subject: Re: tcg2_platform_get_log failing to read address and size of
 memory-region via ofnode_get_addr_size
To: Tim Harvey <tharvey@gateworks.com>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>, 
 u-boot <u-boot@lists.denx.de>, Ruchika Gupta <ruchika.gupta@linaro.org>, 
 Samuel Lee <slee@gateworks.com>
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

Hi Tim,

[...]

> > > > > >
> > > > > > Would you agree with removing the requirement for the event log?
> > > > >
> > > > >
> > > > > No, the log is required, otherwise it's fairly meaningless work. You
> > > > > need the log in your OS to verify the contents of the TPM.
> > > >
> > > > It's the other way around. You trust the TPM and replay the event log
> > > > in memory to verify it's correct.
> > > > That being said, I do agree the event log is pretty useful when trying
> > > > to understand how and what the platform measured. In any case, I'd
> > > > rather fix any issues rather than sidestep them.
> > > >
> > >
> > > Why do you need a log to verify the contents of the TPM? If the PCR's
> > > are not correct you can't get your secrets from the TPM and if they
> > > are you can regardless of a log. Where is this log requirement in the
> > > TCG specification?
> >
> > Yes, as I said you *validate* the eventlog by looking at the TPM PCRs,
> > not the other way around.
> > The problem with the TCG spec is
> > - EFI_TCG2_PROTOCOL.GetEventLog can only returns either EFI_SUCCESS or
> > EFI_INVALID_PARAMETER. There's no EFI_UNSUPPORTED
> > - EFI_TCG2_PROTOCOL.HashLogExtendEvent has a flag
> > (EFI_TCG2_EXTEND_ONLY) which allows you to only extend PCRs and not
> > log them
> >
> > But I can't find anywhere in the spec a statement that says "the
> > eventlog is optional"
> >
> > >
> > > Please see Linux commit 805fa88e0780b ("tpm: Don't make log failures
> > > fatal") which has a commit log of:
> > >
> > > If a TPM is in disabled state, it's reasonable for it to have an empty
> > > log.
> >
> > Yes, an empty log. Not missing a log overall. Which makes sense if the
> > TPM is disabled.
> >
> > >  Bailing out of probe in this case means that the PPI interface
> > > isn't available, so there's no way to then enable the TPM from the OS.
> > > In general it seems reasonable to ignore log errors - they shouldn't
> > > interfere with any other TPM functionality.
> > >
> > > That last sentence makes sense to me; Sure the log may be 'useful' to
> > > some but I feel like it's not a requirement and it certainly is not a
> > > requirement for Linux.
> > >
> > > > The return value of ofnode_get_addr_size() depends on a couple Kconfig
> > > > options. Any chance those differ from the ones Eddie is using?
> > > >
> > >
> > > I have the same dt changes. I think this has something to do with the
> > > whole are we using of or fdt, and is of live:
> > >
> > > $ git diff
> > > diff --git a/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
> > > b/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
> > > index 97ed34a3c586..5752a38c7b4c 100644
> > > --- a/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
> > > +++ b/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
> > > @@ -14,6 +14,17 @@
> > >                 usb1 = &usbotg2;
> > >         };
> > >
> > > +       reserved-memory {
> > > +               #address-cells = <1>;
> > > +               #size-cells = <1>;
> > > +               ranges;
> > > +
> > > +               event_log: tcg_event_log@40000000 {
> > > +                       no-map;
> > > +                       reg = <0x40000000 0x2000>;
> > > +               };
> > > +       };
> > > +
> > >         led-controller {
> > >                 compatible = "gpio-leds";
> > >                 pinctrl-names = "default";
> > > @@ -91,6 +102,7 @@
> > >         tpm@1 {
> > >                 compatible = "tcg,tpm_tis-spi";
> > >                 reg = <0x1>;
> > > +               memory-region = <&event_log>;
> > >                 spi-max-frequency = <36000000>;
> > >         };
> > >  };
> > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > > index 994f8089ba34..0bc08cebed2f 100644
> > > --- a/lib/tpm-v2.c
> > > +++ b/lib/tpm-v2.c
> > > @@ -672,11 +673,14 @@ __weak int tcg2_platform_get_log(struct udevice
> > > *dev, void **addr, u32 *size)
> > >                 phys_addr_t a;
> > >                 fdt_size_t s;
> > >
> > > +printf("%s %s ofnode=%px valid=%d is_np=%d of_live_active=%d\n",
> > > __func__, dev->name, dev_ofnode(dev).np, ofnode_valid(dev_ofnode(de
> > > v)), ofnode_is_np(dev_ofnode(dev)), of_live_active());
> > >                 if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
> > >                                                0, &args))
> > >                         return -ENODEV;
> > > +printf("%s %s args:%d\n", __func__, dev->name, args.args_count);
> > >
> > >                 a = ofnode_get_addr_size(args.node, "reg", &s);
> > > +printf("%s %s a:%px\n", __func__, dev->name, (void*)a);
> > >                 if (a == FDT_ADDR_T_NONE)
> > >                         return -ENOMEM;
> > >
> > > This shows the following:
> > > tcg2_platform_get_log tpm@1 ofnode=00000000000054d0 valid=1 is_np=0
> > > of_live_active=0
> > > tcg2_platform_get_log tpm@1 args:0
> > > tcg2_platform_get_log tpm@1 a:ffffffffffffffff
> > > ^^^ can't get address of reg
> > >
> > > so we have a valid of_node in the dev structure but its not a np?
> > >
> > > dev_read_phandle_with_args() is returning success but was not able to
> > > parse any args, so we should not use 'args.node' as the arg of
> > > ofnode_get_addr_size(args.node, "reg", &s);
> > >
> > > I think the mix of dev_read_phandle_with_args and ofnode_get_addr_size
> > > is wrong. U-Boot is full of constructs like this that are extremely
> > > confusing... missing fdt with of and the concept of if its live or
> > > not. I'm hoping Simon can shed some light on this and maybe give or
> > > point to a primer on all the of/dt/live stuff?
> >
> > Thanks that helps. I'll try to reproduce it with sandbox and/or QEMU
> > with OF_LIVE and see if I get something.
> >
>
> Ilias,
>
> I think the following is needed here:
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 994f8089ba34..6b9d587e491c 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -675,8 +675,7 @@ __weak int tcg2_platform_get_log(struct udevice
> *dev, void **addr, u32 *size)
>                 if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
>                                                0, &args))
>                         return -ENODEV;
> -
> -               a = ofnode_get_addr_size(args.node, "reg", &s);
> +               a = ofnode_get_addr_size_index(args.node, 0, &s);
>                 if (a == FDT_ADDR_T_NONE)
>                         return -ENOMEM;
>
>
> Best Regards,

Looking at the sandbox config file OF_LIVE is enabled. I haven't
looked into the differences on ofnode_get_addr_size(),
ofnode_get_addr_size_index(), why is the index one needed?

btw, why are you trying to create the eventlog area like this? IIRC
linux doesn't support that. Looking at the latest kernel
'tcg_event_log' is only defined in aspeed bmc's on TPMs so I guess
they have a special usecase for that, hence the code Eddie carried in
U-Boot.
For your case, isn't it preferable to add the log area with
linux,sml-base, linux,sml-size? Linux will try to read the eventlog in
that case.

Thanks
/Ilias
>
> Tim
