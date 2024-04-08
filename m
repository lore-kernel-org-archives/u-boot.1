Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B87DCD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 06:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14E68802E;
	Mon,  8 Apr 2024 08:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EyncGvpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34BD48803A; Mon,  8 Apr 2024 08:42:29 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3003B87C77
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 08:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-516d2600569so3989332e87.0
 for <u-boot@lists.denx.de>; Sun, 07 Apr 2024 23:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712558546; x=1713163346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hA6m//3FwAT6RRGx6I6EBsnFan0W2fx08XsEH/2BKRk=;
 b=EyncGvpZidzvJ3dIkTOynY5SlVg5O6AHF3XDHApm5miPp8qBV96sBzZ6AXc7nnqy0X
 4PrICa7FZhwm7+JPOVev1/QrBY5SEL6B+ZWrV3rjzCswOzU4pGk6gvlRC2Cs4Y+m3331
 HlmiOAryyPAa4Vk1tdPtvbj+ENeFbplf41g0Ix+Rz+IT8WJZKxSRzqw2jXlIrXrIHB+5
 YrSQIiPWo7XrHPVCFzaTaVmcEocZhDoKvEf1qHDhjW8qhED6FttV4HWaKK/661rGem1O
 3ecQ0DPaoCxEuT+1qxjuQLts8RETgWoc+03YfZMlH6UChGdcHavTg2KlLEGyAzRA73Uu
 A+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712558546; x=1713163346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hA6m//3FwAT6RRGx6I6EBsnFan0W2fx08XsEH/2BKRk=;
 b=Jo2DDPqxdEgbw+0jvww2I6f/QFhU9YjQ7YbA/Vql+YWzIZxtD5ssccIkLklsi183fZ
 EQKp4ysLIrNue0lOsMxQDrdnrmfiUknvRi+ddqPX/LlrIS9wGSKFH/f5eDvmBe3/fybz
 3Ge0sasIgtMhHmDUWsrVebF2UumGf5hAPmhRgg5z9Ax9+4tHC1U17jr74caLVKl+8ent
 +79ID1HCz9tbuw9HXZ06MBKAOqOdcWSQp486trENoPx8o8K34SbYUHmPZBWMHT9kARy+
 5onMWX0ISV6CmeAJBDwcseH9nJVAfd9Qwrq9yCeu1zTXU59w5C2u+87cM2gJBItztcYH
 eZng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6qP19n1cAH2hCqFNoHhKVWKaXMOtcGw4L+dR43ulq2vmSwZaDi/Y7UrkJ2eV7imNKSm0PXSrMGuIXnvwZ+ndrmoZbyQ==
X-Gm-Message-State: AOJu0YynNpwnkhHXvC37A3SrVDTemIUQ8ZGk3f9vYgudq9xf1SFDqcjW
 g4SBlri8JiKLYuZzSEV/eQw1WSDEj8bv3443R8bbbdMCGnX70Wh2pKHpM3ve67ArAUwE6TD0LlT
 UqW1dOf577/aCj71/Lnoxm5TiTvdNSPKWa1eOtg==
X-Google-Smtp-Source: AGHT+IHncamLf0EW8FYC7E38d4NsznXIuwA8RpotWALRHSKIWH1+9popu1yO/MFGge7uAkMjHxyA2WgzL/lk1n6k+2w=
X-Received: by 2002:a19:8c5d:0:b0:516:ce6a:6f32 with SMTP id
 i29-20020a198c5d000000b00516ce6a6f32mr5846348lfj.44.1712558546453; Sun, 07
 Apr 2024 23:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <20240406140203.248211-3-ilias.apalodimas@linaro.org>
 <641bf875-ea16-4dd3-9859-4eb0b029efde@gmx.de>
In-Reply-To: <641bf875-ea16-4dd3-9859-4eb0b029efde@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Apr 2024 09:41:50 +0300
Message-ID: <CAC_iWj+fg6f2d5+rAeLcX5McM1AQO2ph65p-=1CKGQHOckuW6g@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] efi_loader: Add OS notifications for SetVariableRT
 in RAM
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com, 
 pjones@redhat.com, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Weizhao Ouyang <o451686892@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de, 
 kettenis@openbsd.org
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

Hi Heinrich,

> > +
> >
> >   /* Use internal device tree when starting UEFI application */
> >   #define EFI_FDT_USE_INTERNAL NULL
> > diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> > index 8ebbea7e5c69..d898ba6c268f 100644
> > --- a/lib/efi_loader/efi_runtime.c
> > +++ b/lib/efi_loader/efi_runtime.c
> > @@ -127,10 +127,6 @@ efi_status_t efi_init_runtime_supported(void)
> >                               EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
> >                               EFI_RT_SUPPORTED_CONVERT_POINTER;
> >
> > -     if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> > -             rt_table->runtime_services_supported |=
> > -                     EFI_RT_SUPPORTED_SET_VARIABLE;
> > -
>
[...]

> Why do you want to remove this flag?
>

I don't, I messed this up during my rebase before sending the patches.

The code in EBS() was supposed to re-enable it.
It's all fixed in patch #3, but this patch needs a change as well
rt_prop->runtime_services_supported |= ~EFI_RT_SUPPORTED_SET_VARIABLE;
should be
rt_prop->runtime_services_supported |= EFI_RT_SUPPORTED_SET_VARIABLE;
in efi_variables_boot_exit_notify()

Thanks
/Ilias

> Best regards
>
> Heinrich
>
> >       /*
> >        * This value must be synced with efi_runtime_detach_list
> >        * as well as efi_runtime_services.
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index f79041e6bedd..f97c8c57f75c 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -554,6 +554,26 @@ if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> >    */
> >   void efi_variables_boot_exit_notify(void)
> >   {
> > +     const efi_guid_t efi_guid_efi_rt_var_file = U_BOOT_EFI_RT_VAR_FILE_GUID;
> > +     const efi_guid_t rt_prop_guid = EFI_RT_PROPERTIES_TABLE_GUID;
> > +     efi_status_t ret;
> > +
> > +     if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> > +             struct efi_rt_properties_table *rt_prop =
> > +                     efi_get_configuration_table(&rt_prop_guid);
> > +
> > +             ret = efi_set_variable_int(u"RTStorageVolatile",
> > +                                        &efi_guid_efi_rt_var_file,
> > +                                        EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                        EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                        EFI_VARIABLE_READ_ONLY,
> > +                                        sizeof(EFI_VAR_FILE_NAME),
> > +                                        EFI_VAR_FILE_NAME, false);
> > +             if (ret != EFI_SUCCESS)
> > +                     rt_prop->runtime_services_supported |= ~EFI_RT_SUPPORTED_SET_VARIABLE;
> > +             else
> > +                     log_err("Can't RTStorage. SetVariableRT won't be available\n");
> > +     }
> >       /* Switch variable services functions to runtime version */
> >       efi_runtime_services.get_variable = efi_get_variable_runtime;
> >       efi_runtime_services.get_next_variable_name =
>
