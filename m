Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3560C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 09:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 648FC81E72;
	Fri,  2 May 2025 11:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zYs2OilC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6312A81FDE; Fri,  2 May 2025 11:45:02 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D9A80F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 11:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so16977885e9.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746179100; x=1746783900; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ru5NOrPnnmnAEljz+vQqM+krA1J0oNM8JI9N10p4xyA=;
 b=zYs2OilCJpLRZI3F/Y+BWFV+JZZqsi6SsHmBU019WlbNpMiLiuh3ovXidRNU0OKVLP
 jX/nPG91xfRb7WuuiXJFpQvw5u/w+ovsPOyQpT4Stq9mXfM43btzzaO/Gz57/GV/lQN5
 EUAlKJGOy8BWri2+U6jEprp6k5HFG1Ce6ks5QsMffVsTWlOP7JpfgRtUJbeF5L51/2na
 Jp6pf+ETCa2KB8csdg3oYAbUbZbdr2+SRqTTRNTKCDXXTdfcO9TtZM01PiXEwBGUoiU2
 V0g3bMdEBiU05qOmMFndzDp5Yip7FTVRLf+A5jwgtYbTQ4X3b584JOvdVVvp0l08ZSKG
 zdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746179100; x=1746783900;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ru5NOrPnnmnAEljz+vQqM+krA1J0oNM8JI9N10p4xyA=;
 b=IKsuxlT2TT9irg5yRIZS9BKrKma7rNLNPzGMJa27sFB3ETMtSeuZImbpvzaesYL2EO
 App6OIzEdk75KZNVsjMQFko9rs2g2A3BQQb4wzE2KsEKf8RY86fht7OCZqjvJMlPJVGu
 FdE2PZPxAyMScB6H9PVOBvAnT4yvRCU0/lqszWii3zoloHB0IdduI3pR0V2ORoU4cmkK
 dTt3Y9qH5xDPY0AY0eZazXPYlQHoeUMxLBeFAeh0WR79na6Tq0nKxE4dzD3rYW1kGt/q
 x1qqktP0X/CCEHaFlLL9m+nQ5BFyeASyEy0Pblu5I0BLzaSBoNeZd5BUKGWRm+4uWIXg
 oRZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUkPEf6+31tjBUcFF4rVAOJzGWEFSJThn2aP6c6EdHyLNkGw4IzlFjeJChVGf310qQxi6n47c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2DyV5JQThRKcycgpqqK1KEhaPTtX4n5A+skBPER+xDqqmwpNW
 U0CETzp+Rdr9mY1My6QJYA0yUwWPNVXr92lpiPIjj5UGEFyv2NorPlGyRhtd40A=
X-Gm-Gg: ASbGncvqr0gwAek8x5NchRcaEO2HOX7TGaG37W5sYBcoVEP9yG+t/APlSGcq9smkjoo
 +QocPragTvsbxtAHgJjXoL5MjVj/64dWdD0IY27/yZnpXbn6HOVP+a72CuNP0omrLwMR32tWy1n
 4uu3A897eLLE9TPYM3mllCbV05uP4jRSM+2DczbRX42sSa66i8NHSRC34iv0/lsVjGrOQUYHiLD
 MTYsoztBAb4UwhMsXjRD/ri5MwiKas68VXMJYf1Scfjfm3+EFWH7L6pJZw5URHPRyqzBUFUwf/E
 I2sidjp8nNvlqbii4ZX8HfQNLtrqmD7SaumMqHdE2S0Oq/KBzprmuDJrmu4=
X-Google-Smtp-Source: AGHT+IFmGQfhcVg5UNa9vJ/obYC3+Po3MMXYXUlIxS7kdj7btcC45FdEk5rT8BRXwT99TeOTUHa5SQ==
X-Received: by 2002:a05:600c:19c6:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-441bbec269dmr17851285e9.14.1746179099606; 
 Fri, 02 May 2025 02:44:59 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2aecedcsm85946595e9.15.2025.05.02.02.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 02:44:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 12:44:57 +0300
Message-Id: <D9LKTV9QKJRU.ZTIVOHQA6AUF@linaro.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Simon Glass"
 <sjg@chromium.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Tuomas Tynkkynen"
 <tuomas.tynkkynen@iki.fi>, "Patrick Rudolph"
 <patrick.rudolph@9elements.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, <u-boot@lists.denx.de>
Subject: Re: [RFC 7/8] efi_loader: create EFI BOOTDEV
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-8-heinrich.schuchardt@canonical.com>
 <CAFLszTiUL=zOtK3=yu_XpW_x=iKtBCFNqZ65Q+qv=AAPQMjUBw@mail.gmail.com>
 <785ae15f-62c0-45e3-ae7e-6b56c4a3c3d6@canonical.com>
In-Reply-To: <785ae15f-62c0-45e3-ae7e-6b56c4a3c3d6@canonical.com>
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

Hi Heinrich,

[...]

>>> +static const struct udevice_id efi_bootdev_ids[] =3D {
>>> +       { .compatible =3D "u-boot,bootdev-efi" },
>>> +       { }
>>> +};
>>> +
>>> +U_BOOT_DRIVER(efi_bootdev) =3D {
>>> +       .name           =3D "efi_bootdev",
>>> +       .id             =3D UCLASS_BOOTDEV,
>>> +       .ops            =3D &efi_bootdev_ops,
>>> +       .bind           =3D efi_bootdev_bind,
>>> +       .of_match       =3D efi_bootdev_ids,
>>> +};
>>> +
>>> +/**
>>> + * efi_bootdev_hunt() - find devices used by EFI boot manager
>>> + *
>>> + * Invoke all hunters that have not been invoked by now.
>>> + * This should only be the network hunter.
>>> + *
>>> + * @info:      info structure describing this hunter
>>> + * @show:      true to show information from the hunter
>>> + *
>>> + * Return:     0 if device found, -EINVAL otherwise
>>> + */
>>> +static int efi_bootdev_hunt(struct bootdev_hunter *info, bool show)
>>> +{
>>> +       return bootdev_hunt(NULL, 0);
>>
>> This recursive calling of hunting is very strange. Since bootmgr seems
>> to need all the hunting to be done, you could move this line to
>> somewhere in bootmgr.
>
> Thank you Simon for reviewing.
>
> I added patch 5/8 to avoid infinite recursion.
>
> Maybe we should move this to efi_init_obj_list() because in the
> eficonfig and and efidebug command we also assume that all boot devices
> have been hunted down. If a device has not been probed you cannot create
> a boot option for it.

I don't think teaching the EFI subsystem internals of a Kconfig option is t=
he right thing to do.
What happens if someone compiles without that? Can't we have a generic func=
tion somewhere that does
that? And then we can decide when to call it, efi_init_obj_list() of the co=
mmands themselves
explicitly.

Thanks
/Ilias
>
>>
>>> +}
>>> +
>>> +BOOTDEV_HUNTER(efi_bootdev_hunt) =3D {
>>> +       .prio           =3D BOOTDEVP_6_EFI,
>>> +       .uclass         =3D UCLASS_EFI_BOOT_MGR,
>>> +       .hunt           =3D efi_bootdev_hunt,
>>> +       .drv            =3D DM_DRIVER_REF(efi_bootdev),
>>> +};
>>> +
>>> +static int efi_bootdev_create(void)
>>> +{
>>> +       int ret;
>>> +       struct udevice *dev_mgr;
>>> +       struct udevice *dev;
>>> +
>>> +       ret =3D device_bind_driver(gd->dm_root, "efimgr",
>>> +                                "efimgr", &dev_mgr);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret =3D device_bind_driver(dev_mgr, "efi_bootdev",
>>> +                                "efimgr.bootdev", &dev);
>>> +       return ret;
>>> +}
>>> +
>>> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, efi_bootdev_create);
>>> +
>>> +U_BOOT_DRIVER(efimgr) =3D {
>>> +       .name           =3D "efimgr",
>>> +       .id             =3D UCLASS_EFI_BOOT_MGR,
>>> +};
>>> +
>>> +UCLASS_DRIVER(efimgr) =3D {
>>> +       .id             =3D UCLASS_EFI_BOOT_MGR,
>>> +       .name           =3D "efimgr",
>>> +};
>>> --
>>> 2.48.1
>>>
>>
>> I am not seeing any tests in this series. At least we should update
>> the bootflow_efi() test or add something similar.
>
> I have not looked into the tests because I first wanted to have feedback
> if the general direction is ok.
>
> Unfortunately most bootstd tests are checking console output line by
> line instead of functional tests which makes them fail now.
>
> The bootstd tests should better have been written in a way that would
> allow running them on real boards without making assumptions about the
> board.
>
> Best regards
>
> Heinrich

