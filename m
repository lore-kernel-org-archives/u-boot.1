Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4B5CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 08:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372B887FA3;
	Mon,  8 Apr 2024 10:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UVRkB2mC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9876587FDA; Mon,  8 Apr 2024 10:12:44 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C63287FA3
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 10:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-516cbf3fe68so5035748e87.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712563961; x=1713168761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eH6L79UKleVvvcHQ5e/V2sXr8PaH61wSG44BaRtcRLI=;
 b=UVRkB2mCNZMCRdgCLsohItYVVsNjyrZGzvT+YOQYQULD/jZ5Yf/Ovn2APmii7G3vpu
 BiS+XW+x2ZVfBKv2iqnLzBI40LqNhtlrbf9L8wrPwUIJtv+mNWxToSzHBEMlX+TlSu+u
 +49wD2cXMG5RMGQZ6Xy9n8dRRM20hTpJREnm+zgDW/3OvScDu8pEyyFcdf7WBwaysyz2
 0VN4XZEsIq20/DiII3k5BeH8n56Qxv6Mw7HKgqEGx2dvHWjPK/g1Ge2dhnBkxTdWauLl
 b3aeheY4WI3a7TylpdhbFnDGoJb20NnFhzYydsJ7k21u63SjdmeySKAFR6bJczj12r95
 Ws7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563961; x=1713168761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eH6L79UKleVvvcHQ5e/V2sXr8PaH61wSG44BaRtcRLI=;
 b=Dl5sAHWQS9bGMVzRcQO+jloEi9wpPaB0bVNG5nPwQy4Hmw/l9ZdOyvCeBF/erKAg4Q
 S8rtUHojO89W3lRy25bduOuuYRAP0jPZ8jZGCq40rU5xtaFFeBy5it9CfTYVrJpcQNyH
 Etw/ElQ2VX38fv4FJQIdbRhcU1pdBMgElxRs67H+eEi0rFl6JsqzLP3cWJW6L6ETQX4c
 Q5OszIxtkwF+99CQBB+mxvcig8Ngq2tGQQKrVI4qoP75TP0Ax250sPQ8XvMtg15+d3AZ
 C3AGtl4XbalpRVl/aMQ6XIBBqYXhmcOLFstaxq4ex67JPgJzn4trd5Mq7Py1J+VJIBEq
 ZaYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqXRpDzuzyW7AKNe3I/zrmqo1NjBERAbZZEPoy+koxpcjSgMVqX2jTHU9lgzQDOfgA0ny+dPaquI206A/8MfOz2+sCVA==
X-Gm-Message-State: AOJu0YzaFpqGg9FESH7kiBwroYDP7xHraTuBHkBFFG22FI7YPDU2RVUv
 z28TVWQeZPRV1RO6bLEEztIX8SXQTe11E+5lcERCFg6aG2aMNBS4MLnBaKTiXb/3pFCiG+YBDpW
 v/Nw1MLSjT9hIBR5rb91swUuPkxsQ1HpsH69zWQ==
X-Google-Smtp-Source: AGHT+IFMOwVST3CheUt4NcdrW2RQB5CxCA/+3DRnEt6Gehu/CQh2FagfD3QEJiHREscJeUxeW+oUpJP+KJQtZ8tTkqc=
X-Received: by 2002:ac2:494b:0:b0:516:d6db:cc22 with SMTP id
 o11-20020ac2494b000000b00516d6dbcc22mr4158352lfi.3.1712563961211; Mon, 08 Apr
 2024 01:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <20240406140203.248211-4-ilias.apalodimas@linaro.org>
 <6c399b8c-f5f8-4b1b-a74a-0de72ef9002e@gmx.de>
In-Reply-To: <6c399b8c-f5f8-4b1b-a74a-0de72ef9002e@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Apr 2024 11:12:04 +0300
Message-ID: <CAC_iWj+epdSKG-ZfRc5SfUevMhe6NyaC6cgSJK2KcqiZs=r0fw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] efi_loader: add an EFI variable with the variable
 file contents
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

Hi Heinrich

On Mon, 8 Apr 2024 at 09:41, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 4/6/24 16:01, Ilias Apalodimas wrote:
> > Previous patches enabled SetVariableRT using a RAM backend.
> > Although EBBR [0] defines a variable format we can teach userspace tools
> > and write the altered variables, it's better if we skip the ABI
> > requirements completely.
> >
> > So let's add a new variable, in its own namespace called "VarToFile"
> > which contains a binary dump of the updated RT, BS and, NV variables.
> >
> > Some adjustments are needed to do that. Currently we discard BS-only
> > variables in EBS(). We need to preserve those on the OS RAM backend
> > that exposes the variables. Since BS-only variables can't appear at RT
> > we need to move the memory masking checks from efi_var_collect() to
> > efi_get_next_variable_name_mem()/efi_get_variable_mem() and do the
> > filtering at runtime. We also need to make efi_var_collect() available
> > at runtime, in order to construct the "VarToFile" buffer with BS, RT &
> > NV variables.
> >
> > All users and applications (for linux) have to do when updating a variable
> > is dd that variable in the file described by "RTStorageVolatile".
> >
> > Linux efivarfs uses a first 4 bytes of the output to represent attributes
> > in little-endian format. So, storing variables works like this:
> >
> > $~ efibootmgr -n 0001
> > $~ dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c of=/boot/efi/ubootefi.var skip=4 bs=1
> >
> > [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
>
> This change actually doubles the amount of memory needed to store a
> variable at runtime. How do you reflect this in QueryVariableInfo()?
>

It doesn't double it. Only BS, RT, NV variables are added to VarToFile.
QueryVariableInfo isn't supported at runtime, but with the current
code we have at boot time the VarToFile would be included in the
calculations.

> >
> > Suggested-by:Ard Biesheuvel <ardb@kernel.org> # dumping all variables to a variable
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   include/efi_variable.h            |  15 +++-
> >   lib/efi_loader/efi_boottime.c     |   2 +
> >   lib/efi_loader/efi_var_common.c   |  43 +++++------
> >   lib/efi_loader/efi_var_file.c     |   1 -
> >   lib/efi_loader/efi_var_mem.c      |  90 ++++++++++-------------
> >   lib/efi_loader/efi_variable.c     | 118 ++++++++++++++++++++++++------

[...]

> >    * @data:           buffer to which the variable value is copied
> >    * @timep:          authentication time (seconds since start of epoch)
> > + * @mask:            bitmask with required attributes of variables to be collected.
> > + *                      variables are only collected if all of the required
>
> This line looks incomplete.

Yes, fixed

>
> >    * Return:          status code
> >    */
> >   efi_status_t __efi_runtime
> >   efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> >                    u32 *attributes, efi_uintn_t *data_size, void *data,
> > -                  u64 *timep);
> > +                  u64 *timep, u32 mask);
> >
> >   /**

[...]

> >       return EFI_UNSUPPORTED;
> > @@ -557,11 +593,11 @@ void efi_variables_boot_exit_notify(void)
> >       const efi_guid_t efi_guid_efi_rt_var_file = U_BOOT_EFI_RT_VAR_FILE_GUID;
> >       const efi_guid_t rt_prop_guid = EFI_RT_PROPERTIES_TABLE_GUID;
> >       efi_status_t ret;
> > +     struct efi_var_file *buf;
> > +     loff_t len;
> > +     bool fail = false;
> >
> >       if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> > -             struct efi_rt_properties_table *rt_prop =
> > -                     efi_get_configuration_table(&rt_prop_guid);
> > -
> >               ret = efi_set_variable_int(u"RTStorageVolatile",
> >                                          &efi_guid_efi_rt_var_file,
> >                                          EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > @@ -569,11 +605,47 @@ void efi_variables_boot_exit_notify(void)
> >                                          EFI_VARIABLE_READ_ONLY,
> >                                          sizeof(EFI_VAR_FILE_NAME),
> >                                          EFI_VAR_FILE_NAME, false);
> > +             if (ret != EFI_SUCCESS) {
> > +                     fail = true;
> > +                     goto out;
> > +             }
> > +
> > +             ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> > +             if (ret != EFI_SUCCESS) {
> > +                     fail = true;
> > +                     goto out;
> > +             }
> > +
> > +             ret = efi_set_variable_int(u"VarToFile",
> > +                                        &efi_guid_efi_rt_var_file,
> > +                                        EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                        EFI_VARIABLE_RUNTIME_ACCESS,
> > +                                        len,
> > +                                        buf, false);
> >               if (ret != EFI_SUCCESS)
> > -                     rt_prop->runtime_services_supported |= ~EFI_RT_SUPPORTED_SET_VARIABLE;
> > -             else
> > -                     log_err("Can't RTStorage. SetVariableRT won't be available\n");
> > +                     fail = true;
> > +out:
> > +             if (fail) {
> > +                     efi_set_variable_int(u"RTStorageVolatile",
> > +                                          &efi_guid_efi_rt_var_file,
> > +                                          EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                          EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                          EFI_VARIABLE_READ_ONLY, 0, 0,
> > +                                          false);
>
> Not providing VarToFile because the memory buffer is more than half
> filled before ExitBootServices() is unexpected behavior. This needs rework.

Why? We should add the SetVariable at runtime to the documentation.

>
> It is not necessary to create VarToFile in the internal memory buffer.
> You could generate it when the user calls GetVariable() in the user
> provided buffer.

Yes, but that would make some functions look a bit messier, since we
have to inject code specifically looking for VarToFile.
OTOH it would make SetVariable at runtime easier to read since all the
size calculations and variable creation would go away.
But in any case, we have to add the variable at runtime (perhaps with
a value of 0?) -- users need to know it's there to be able to read it.
But if you are fine with the special conditions in GetVariable at
runtime, I can easily move the logic to GetVariable.

Thanks
/Ilias

>
> Best regards
>
> Heinrich
>
> > +                     efi_set_variable_int(u"VarToFile",
> > +                                          &efi_guid_efi_rt_var_file,
> > +                                          EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                          EFI_VARIABLE_RUNTIME_ACCESS, 0, 0,
> > +                                          false);
> > +             } else {
> > +                     struct efi_rt_properties_table *rt_prop =
> > +                             efi_get_configuration_table(&rt_prop_guid);
> > +
> > +                     rt_prop->runtime_services_supported |=
> > +                                     EFI_RT_SUPPORTED_SET_VARIABLE;
> > +             }
> >       }
> > +
> >       /* Switch variable services functions to runtime version */
> >       efi_runtime_services.get_variable = efi_get_variable_runtime;
> >       efi_runtime_services.get_next_variable_name =
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > index dde135fd9f81..9d0e270591ea 100644
> > --- a/lib/efi_loader/efi_variable_tee.c
> > +++ b/lib/efi_loader/efi_variable_tee.c
> > @@ -969,7 +969,6 @@ void efi_variables_boot_exit_notify(void)
> >               log_err("Can't populate EFI variables. No runtime variables will be available\n");
> >       else
> >               efi_var_buf_update(var_buf);
> > -     free(var_buf);
> >
> >       /* Update runtime service table */
> >       efi_runtime_services.query_variable_info =
> > --
> > 2.37.2
> >
>
