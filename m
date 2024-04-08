Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4E3C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 09:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2088187EB2;
	Mon,  8 Apr 2024 11:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nq6+HgVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF6887F50; Mon,  8 Apr 2024 11:41:32 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC4887D0A
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 11:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d895138d0eso3865301fa.1
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712569289; x=1713174089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=170HvUNjAgP+2pAKkupoLCzi0TryMkns+6sX6O5pAlk=;
 b=nq6+HgVOJUsQcbmLV8/5hGLMUJXK1npncuj5DYarQn1gGY75NZgRwwTihoIsAu5v6V
 rEnnzgXbhfTGB0XweOJDDzb0Z9RdDTquuyPenBooTw4ND5N0XcMSHTzaMiQ2pMyWpEap
 h1oK+ydbhr8MsFB6JREf7zJANica3jjJWsMLYK0nCNWhdyvquU2dtBbSEfu3j3+zH5id
 VMbMuFXH+M/F8M/7LyU8BuzT2HzaxrMOTQIahUwPJ3l1CCB0pbGG9t3kdizlqu47f4t+
 cNUrWhgO35Dh769/WnaTSWu505vgd+n2/EKy00vCdsQxJFq3EbXb0i73KLBC5L1pCw8D
 NsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712569289; x=1713174089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=170HvUNjAgP+2pAKkupoLCzi0TryMkns+6sX6O5pAlk=;
 b=OpARojsWSCnkty6jaD+ylbrO3pGGWxa+/InklmEIvlE+2HN7f7qREO3BP3s794wD4s
 9t1wotxukM7+SRGSq4L1VzU4uY+IBc8u8xdNRXMbpQtu6hKXD9cCZ3PvarPz7pGrOKij
 vyagdcKtFyWbNp0pnBIgyYQDd1tp6nV6bpyoNL9Gxo5lzUN2k3IhXS14Kg4mKxXaP4sJ
 TYn/Nm0CJRPLXdBWR0j0nWGiADjOviLCWrkiBpYn0HhAGuiP6yHSIg1vFxfJbIGOupwQ
 d49NNlBQNXwMPVuUbRUVi6SiUJiP6gEOQugoWwLW2ZM/uUL6mLfDfCGMbruHUUW5tVVJ
 /OaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrbAZyHNtXPCiQA/CUtf55JtdR1w/wmjqCepyN95wp8QWZ9CGcIue+WSfo/PArUyZHWIR8OarEs/+cyKkcPuZX/2cS9g==
X-Gm-Message-State: AOJu0YytnfUt517Bh2YJf2pMP/IeP7+mkwr3wWTjIUHxbvQB+C9erXkT
 0MMEIyj1gnbJtToAJ0eLsX5xVRgG2MgYOjYicROWRCo64RANJDFxeiaMXfJ73az0PwL9Swu8JO4
 6nV+IbSSOKEeGStMoiIHxIEjNxWoZry/Xt+EMPg==
X-Google-Smtp-Source: AGHT+IFHyHtWgIpxA5aJa25WiOshXYsC7fDN9Bo8qh6ATRKkkGVVjWmv/6QPmUtVCY1Nvmmxz3tDJm82vlxiqNAQrbM=
X-Received: by 2002:a2e:a717:0:b0:2d8:71d4:4c62 with SMTP id
 s23-20020a2ea717000000b002d871d44c62mr3962936lje.49.1712569289498; Mon, 08
 Apr 2024 02:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <20240406140203.248211-4-ilias.apalodimas@linaro.org>
 <6c399b8c-f5f8-4b1b-a74a-0de72ef9002e@gmx.de>
 <CAC_iWj+epdSKG-ZfRc5SfUevMhe6NyaC6cgSJK2KcqiZs=r0fw@mail.gmail.com>
 <2b8595fd-334c-4045-b80d-3980a0646812@gmx.de>
In-Reply-To: <2b8595fd-334c-4045-b80d-3980a0646812@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Apr 2024 12:40:53 +0300
Message-ID: <CAC_iWj+BOiDUji5HjW7N7VWcmp869E53rti6K2cC86pL7r+E4Q@mail.gmail.com>
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

On Mon, 8 Apr 2024 at 11:29, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 4/8/24 10:12, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> > On Mon, 8 Apr 2024 at 09:41, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 4/6/24 16:01, Ilias Apalodimas wrote:
> >>> Previous patches enabled SetVariableRT using a RAM backend.
> >>> Although EBBR [0] defines a variable format we can teach userspace tools
> >>> and write the altered variables, it's better if we skip the ABI
> >>> requirements completely.
> >>>
> >>> So let's add a new variable, in its own namespace called "VarToFile"
> >>> which contains a binary dump of the updated RT, BS and, NV variables.
> >>>
> >>> Some adjustments are needed to do that. Currently we discard BS-only
> >>> variables in EBS(). We need to preserve those on the OS RAM backend
> >>> that exposes the variables. Since BS-only variables can't appear at RT
> >>> we need to move the memory masking checks from efi_var_collect() to
> >>> efi_get_next_variable_name_mem()/efi_get_variable_mem() and do the
> >>> filtering at runtime. We also need to make efi_var_collect() available
> >>> at runtime, in order to construct the "VarToFile" buffer with BS, RT &
> >>> NV variables.
> >>>
> >>> All users and applications (for linux) have to do when updating a variable
> >>> is dd that variable in the file described by "RTStorageVolatile".
> >>>
> >>> Linux efivarfs uses a first 4 bytes of the output to represent attributes
> >>> in little-endian format. So, storing variables works like this:
> >>>
> >>> $~ efibootmgr -n 0001
> >>> $~ dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c of=/boot/efi/ubootefi.var skip=4 bs=1
> >>>
> >>> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
> >>
> >> This change actually doubles the amount of memory needed to store a
> >> variable at runtime. How do you reflect this in QueryVariableInfo()?
> >>
> >
> > It doesn't double it. Only BS, RT, NV variables are added to VarToFile.
> > QueryVariableInfo isn't supported at runtime, but with the current
> > code we have at boot time the VarToFile would be included in the
> > calculations.
>
> VarToFile does not exist at boot time. Nothing stops the user from
> writing NV variables to fill up the memory buffer. VarToFile will be as
> large as the sum of NV variables and will not fit into the buffer when
> efi_variables_boot_exit_notify() is invoked.

Yes, tbh when I was initially writing this, I was allocating 2x the
variable size buffer to get away from this limitation. But I
eventually decided variables for embedded would be small enough to not
suffer from this that much.
Anyway, I can either allocate 2x size and adjust some code size checks
or move the variable filling in GetVariable as you suggested earlier.
Any preference?

Thanks
/Ilias


>
> >
> >>>
> >>> Suggested-by:Ard Biesheuvel <ardb@kernel.org> # dumping all variables to a variable
> >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>> ---
> >>>    include/efi_variable.h            |  15 +++-
> >>>    lib/efi_loader/efi_boottime.c     |   2 +
> >>>    lib/efi_loader/efi_var_common.c   |  43 +++++------
> >>>    lib/efi_loader/efi_var_file.c     |   1 -
> >>>    lib/efi_loader/efi_var_mem.c      |  90 ++++++++++-------------
> >>>    lib/efi_loader/efi_variable.c     | 118 ++++++++++++++++++++++++------
> >
> > [...]
> >
> >>>     * @data:           buffer to which the variable value is copied
> >>>     * @timep:          authentication time (seconds since start of epoch)
> >>> + * @mask:            bitmask with required attributes of variables to be collected.
> >>> + *                      variables are only collected if all of the required
> >>
> >> This line looks incomplete.
> >
> > Yes, fixed
> >
> >>
> >>>     * Return:          status code
> >>>     */
> >>>    efi_status_t __efi_runtime
> >>>    efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> >>>                     u32 *attributes, efi_uintn_t *data_size, void *data,
> >>> -                  u64 *timep);
> >>> +                  u64 *timep, u32 mask);
> >>>
> >>>    /**
> >
> > [...]
> >
> >>>        return EFI_UNSUPPORTED;
> >>> @@ -557,11 +593,11 @@ void efi_variables_boot_exit_notify(void)
> >>>        const efi_guid_t efi_guid_efi_rt_var_file = U_BOOT_EFI_RT_VAR_FILE_GUID;
> >>>        const efi_guid_t rt_prop_guid = EFI_RT_PROPERTIES_TABLE_GUID;
> >>>        efi_status_t ret;
> >>> +     struct efi_var_file *buf;
> >>> +     loff_t len;
> >>> +     bool fail = false;
> >>>
> >>>        if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> >>> -             struct efi_rt_properties_table *rt_prop =
> >>> -                     efi_get_configuration_table(&rt_prop_guid);
> >>> -
> >>>                ret = efi_set_variable_int(u"RTStorageVolatile",
> >>>                                           &efi_guid_efi_rt_var_file,
> >>>                                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >>> @@ -569,11 +605,47 @@ void efi_variables_boot_exit_notify(void)
> >>>                                           EFI_VARIABLE_READ_ONLY,
> >>>                                           sizeof(EFI_VAR_FILE_NAME),
> >>>                                           EFI_VAR_FILE_NAME, false);
> >>> +             if (ret != EFI_SUCCESS) {
> >>> +                     fail = true;
> >>> +                     goto out;
> >>> +             }
> >>> +
> >>> +             ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> >>> +             if (ret != EFI_SUCCESS) {
> >>> +                     fail = true;
> >>> +                     goto out;
> >>> +             }
> >>> +
> >>> +             ret = efi_set_variable_int(u"VarToFile",
> >>> +                                        &efi_guid_efi_rt_var_file,
> >>> +                                        EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >>> +                                        EFI_VARIABLE_RUNTIME_ACCESS,
> >>> +                                        len,
> >>> +                                        buf, false);
> >>>                if (ret != EFI_SUCCESS)
> >>> -                     rt_prop->runtime_services_supported |= ~EFI_RT_SUPPORTED_SET_VARIABLE;
> >>> -             else
> >>> -                     log_err("Can't RTStorage. SetVariableRT won't be available\n");
> >>> +                     fail = true;
> >>> +out:
> >>> +             if (fail) {
> >>> +                     efi_set_variable_int(u"RTStorageVolatile",
> >>> +                                          &efi_guid_efi_rt_var_file,
> >>> +                                          EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >>> +                                          EFI_VARIABLE_RUNTIME_ACCESS |
> >>> +                                          EFI_VARIABLE_READ_ONLY, 0, 0,
> >>> +                                          false);
> >>
> >> Not providing VarToFile because the memory buffer is more than half
> >> filled before ExitBootServices() is unexpected behavior. This needs rework.
> >
> > Why? We should add the SetVariable at runtime to the documentation.
>
> Depending on the number of variables existing at boot time support you
> will be creating VarToFile or not. I can't see that users will fancy this.
>
> Best regards
>
> Heinrich
>
> >
> >>
> >> It is not necessary to create VarToFile in the internal memory buffer.
> >> You could generate it when the user calls GetVariable() in the user
> >> provided buffer.
> >
> > Yes, but that would make some functions look a bit messier, since we
> > have to inject code specifically looking for VarToFile.
> > OTOH it would make SetVariable at runtime easier to read since all the
> > size calculations and variable creation would go away.
> > But in any case, we have to add the variable at runtime (perhaps with
> > a value of 0?) -- users need to know it's there to be able to read it.
> > But if you are fine with the special conditions in GetVariable at
> > runtime, I can easily move the logic to GetVariable.
> >
> > Thanks
> > /Ilias
> >
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>> +                     efi_set_variable_int(u"VarToFile",
> >>> +                                          &efi_guid_efi_rt_var_file,
> >>> +                                          EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >>> +                                          EFI_VARIABLE_RUNTIME_ACCESS, 0, 0,
> >>> +                                          false);
> >>> +             } else {
> >>> +                     struct efi_rt_properties_table *rt_prop =
> >>> +                             efi_get_configuration_table(&rt_prop_guid);
> >>> +
> >>> +                     rt_prop->runtime_services_supported |=
> >>> +                                     EFI_RT_SUPPORTED_SET_VARIABLE;
> >>> +             }
> >>>        }
> >>> +
> >>>        /* Switch variable services functions to runtime version */
> >>>        efi_runtime_services.get_variable = efi_get_variable_runtime;
> >>>        efi_runtime_services.get_next_variable_name =
> >>> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> >>> index dde135fd9f81..9d0e270591ea 100644
> >>> --- a/lib/efi_loader/efi_variable_tee.c
> >>> +++ b/lib/efi_loader/efi_variable_tee.c
> >>> @@ -969,7 +969,6 @@ void efi_variables_boot_exit_notify(void)
> >>>                log_err("Can't populate EFI variables. No runtime variables will be available\n");
> >>>        else
> >>>                efi_var_buf_update(var_buf);
> >>> -     free(var_buf);
> >>>
> >>>        /* Update runtime service table */
> >>>        efi_runtime_services.query_variable_info =
> >>> --
> >>> 2.37.2
> >>>
> >>
>
