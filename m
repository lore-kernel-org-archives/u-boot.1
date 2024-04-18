Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4553C04FF8
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0848848B;
	Thu, 18 Apr 2024 19:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v+DHPghN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447748848B; Thu, 18 Apr 2024 19:04:17 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E8688662
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516d6e23253so1281268e87.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713459853; x=1714064653; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xRbmUTtEM5vlzgRuSVsaV8WabDiPi3va+LhmeZq0QF4=;
 b=v+DHPghNHnwDQ/W0gd57dHNG8s42yTZQnBPrP+TNqYgzezRLFEl82Hr6TWL1C0C5cu
 kjpBRD1JE1ohsfhyofuJfd/zQ4/FdfhrtTnbx995H3QxdlPMepaqFT22uLPzht6341qL
 xJOrBdgUX1zVG6N8/vlkIIanJOtJFV66vjplp0CnLEl7ITq0aCaho7hnJ8P1/Z/cX9yC
 WJahJxuMimvuftEJOnz7sdJ7DYmvVzPiB2XqazLukMMGBtwzOaa2wLGtt78RtPvxR4w2
 3x6i/wcAnE9KXYsbgFbwGlDoTc5VAgFFCJXH4HTvreLMXegPQ3naZ1ooeoNhMag1RtHb
 6MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713459853; x=1714064653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xRbmUTtEM5vlzgRuSVsaV8WabDiPi3va+LhmeZq0QF4=;
 b=dVOWC9jDU1hAnC3jpRzHXESufsdd+5UPtnfgDyIvqrctQyiFGbyUMUDggoJywNlW+D
 Cax/gxmcPLa6fn6c3rpT4QivucsIZA7h0BuuqOMiMQKyTQE6xasZdlZxRe6cDEmpxIG4
 OrT2di2oMWnU2JPr5CVHI7sskVYnED/K/j1SsDvHMVg4vmzgbgyTNdv3oCaPzG2l3BO0
 KJFcr2BxW6qBYmGCxTjgea8ff8NTFT2RmweDKNIQNp87XA7GTV7F4Uk7/vEzBfZJDUqF
 7VTQyh8DgRelVXwIhlZcdJf1FiFxFdWFnTwW8+45e7NfIqrFHPxVFGOcpjf1lHpfHkX+
 8HSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyW2apP9XVa3NeDlob+iSJqp9dPOgn433noMe0klhqbfOMIsRDJQEvAmzG6xiLNBdRI86pP9lMO7JJGezZCRcE1D7UsQ==
X-Gm-Message-State: AOJu0YxIJgI5ic0EMH5SQngGRk1Sx8D5pGcS00B01bS0xe4S93UQE20N
 vKtfBii+usWhk3NJ6TPk/IgML6HBU5l5miYWIRd+nuujauSiVaM+uZxb2nRm1qbzr9QuwP9bwFI
 apRrfhQ4tQSIFFC8B2WEKm4Uq+VlHFaWWEVZPHQ==
X-Google-Smtp-Source: AGHT+IE045dOGl9I0MZJzqlF2TrlmphLVXbqkhq6bZuf3+9kcyJZSBaK7OfGHf2Vr/EOZT+S9zkDC5Zec33bxR5//Ko=
X-Received: by 2002:ac2:442d:0:b0:518:dcae:c0e9 with SMTP id
 w13-20020ac2442d000000b00518dcaec0e9mr2454640lfl.20.1713459853293; Thu, 18
 Apr 2024 10:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
 <20240418125456.50944-4-ilias.apalodimas@linaro.org>
 <87sezig0sn.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjJVRRx_w0cLhfsF6+tW1qyYmyGvEeWwgETXaKMsshW+kQ@mail.gmail.com>
 <67fc85ab-70d7-4558-aa67-dc18a0bbbeab@canonical.com>
 <CAC_iWjKXUW321d-6532oaY2egU4CSszVr1rQba5TUd1fWfu55w@mail.gmail.com>
 <2bb74ebd-dbb6-4ebd-985b-82d3406c4e81@gmx.de>
In-Reply-To: <2bb74ebd-dbb6-4ebd-985b-82d3406c4e81@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Apr 2024 20:03:36 +0300
Message-ID: <CAC_iWjJzmogY7220MZ_SCB=Unky=L_7V3DZSFKFm9fA+5QmHJg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] efi_loader: add an EFI variable with the file
 contents
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: kettenis@openbsd.org, caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com, 
 pjones@redhat.com, trini@konsulko.com, kojima.masahisa@socionext.com, 
 takahiro.akashi@linaro.org, raymond.mao@linaro.org, sjg@chromium.org, 
 matthias.schiffer@ew.tq-group.com, j@jannau.net, abdellatif.elkhlifi@arm.com, 
 sughosh.ganu@linaro.org, richard.henderson@linaro.org, CFSworks@gmail.com, 
 alpernebiyasak@gmail.com, o451686892@gmail.com, u-boot@lists.denx.de, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

On Thu, 18 Apr 2024 at 19:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 18.04.24 17:59, Ilias Apalodimas wrote:
> > On Thu, 18 Apr 2024 at 18:42, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 18.04.24 17:36, Ilias Apalodimas wrote:
> >>> Hi Mark,
> >>>
> >>> On Thu, 18 Apr 2024 at 18:15, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >>>>
> >>>>> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>>> Date: Thu, 18 Apr 2024 15:54:52 +0300
> >>>>
> >>>> Hi Illias,
> >>>>
> >>>>>
> >>>>> Previous patches enabled SetVariableRT using a RAM backend.
> >>>>> Although EBBR [0] defines a variable format we can teach userspace tools
> >>>>> and write the altered variables, it's better if we skip the ABI
> >>>>> requirements completely.
> >>>>>
> >>>>> So let's add a new variable, in its own namespace called "VarToFile"
> >>>>> which contains a binary dump of the updated RT, BS and, NV variables
> >>>>> and will be updated when GetVariable is called.
> >>>>>
> >>>>> Some adjustments are needed to do that.
> >>>>> Currently we discard BS-only variables in EBS(). We need to preserve
> >>>>> those on the RAM backend that exposes the variables. Since BS-only
> >>>>> variables can't appear at runtime we need to move the memory masking
> >>>>> checks from efi_var_collect() to efi_get_next_variable_name_mem()/
> >>>>> efi_get_variable_mem() and do the filtering at runtime.
> >>>>>
> >>>>> We also need an efi_var_collect() variant available at runtime, in order
> >>>>> to construct the "VarToFile" buffer on the fly.
> >>>>>
> >>>>> All users and applications (for linux) have to do when updating a variable
> >>>>> is dd that variable in the file described by "RTStorageVolatile".
> >>>>
> >>>> I simehow missed your reply to the issue I raised with picking the
> >>>> right ESP to write variables back to.
> >>>
> >>> No worries, I did send v3 quickly myself...
> >>>
> >>>>    I'm not convinced that the ESP
> >>>> that was used to install Linux on is necessarily th right one.  In
> >>>> particular, consider a system with multiple disks, say eMMC and an
> >>>> NVMe disk.  Suppose U-Boot is installed on eMMC and picks the ESP on
> >>>> that disk to store the EFI variables.
> >>>
> >>> And who creates ESP on the eMMC? I assume you have one OS installed in
> >>> the eMMC and another one in the nvme?
> >>
> >> E.g. you have a naked NVMe. At first boot there will be an ESP on the
> >> installation medium. The installer may create an ESP on the NVMe drive
> >> and put GRUB there.
> >>
> >> Later the user will typically remove the installation module if U-Boot
> >> is on SPI flash.
> >>
> >> U-Boot has no chance to know this beforehand.
> >>
> >> Best regards
> >
> > Ok thanks, Heinrich, as you mentioned offline that's what the Ubuntu
> > installer does.
> > In this case again, neither the DP nor the relative path directly
> > solves the problem, since that second ESP doesn't exist to begin with.
> >
> > Can we get some more info on the installer? When it tries to write
> > Boot0000 which ESP is mounted? The 'installer' one or the newly
> > created one in the NVME? Because if it's the latter things should
> > work.
>
> The ESP on the NVMe is mounted at /boot/efi. This is where GRUB is
> installed as (/boot/efi)/EFI/ubuntu/grubriscv64.efi.

Yes but if I understand you correctly the installer will work just
fine. Let me try and describe the process in case we are missing
something
- The installer starts from a USB and contains an ESP which is mounted
if I understand you correctly
- The installation creates a new ESP
- Once the installation is about to end, the new ESP is mounted and
grub/shim is copied over. At that point, it will also try to set
Boot0000 pointting to shim. But the installer *knows* which ESP it
mounted, so it can use that partition to write the updated
ubootefi.var

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >>
> >>>
> >>>> Now I install Linux on the NVMe
> >>>> disk, which creates an ESP to store its bootloader.  With your
> >>>> proposed changes, Linux will probably end up writing the variables to
> >>>> the ESP on the NVMe.  Now you reboot and U-Boot still reads the EFI
> >>>> variables from eMMC and you've lost any changes...
> >>>
> >>> I understand the problem, but my concern is that using a DP just
> >>> delegates the problem -- it doesn't solve it.
> >>>
> >>> To use the 'correct' partition, U-Boot has to *decide* which ESP is
> >>> going to be used and inject it in RTVolatileStorage.
> >>> But if U-Boot decides about the 'correct' ESP the relative path would
> >>> work as well. So what's needed here is a mechanism to correlate the
> >>> booted OS with the ESP it will use and force the variable loading from
> >>> that file. Am I missing anything?
> >>>
> >>> /Ilias
> >>>>
> >>>>> Linux efivarfs uses a first 4 bytes of the output to represent attributes
> >>>>> in little-endian format. So, storing variables works like this:
> >>>>>
> >>>>> $~ efibootmgr -n 0001
> >>>>> $~ dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c of=/boot/efi/ubootefi.var skip=4 bs=1
> >>>>>
> >>>>> [0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
> >>>>>
> >>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org> # dumping all variables to a variable
> >>>>> Co-developed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com> # contributed on efi_var_collect_mem()
> >>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>>> ---
> >>>>>    include/efi_variable.h            |  16 +++-
> >>>>>    lib/charset.c                     |   2 +-
> >>>>>    lib/efi_loader/efi_runtime.c      |  25 +++++
> >>>>>    lib/efi_loader/efi_var_common.c   |   6 +-
> >>>>>    lib/efi_loader/efi_var_mem.c      | 151 +++++++++++++++++++-----------
> >>>>>    lib/efi_loader/efi_variable.c     |   6 +-
> >>>>>    lib/efi_loader/efi_variable_tee.c |   5 -
> >>>>>    7 files changed, 146 insertions(+), 65 deletions(-)
> >>>>>
> >>>>> diff --git a/include/efi_variable.h b/include/efi_variable.h
> >>>>> index 42a2b7c52bef..223bb9a4a5bd 100644
> >>>>> --- a/include/efi_variable.h
> >>>>> +++ b/include/efi_variable.h
> >>>>> @@ -271,13 +271,16 @@ const efi_guid_t *efi_auth_var_get_guid(const u16 *name);
> >>>>>     *
> >>>>>     * @variable_name_size:      size of variable_name buffer in bytes
> >>>>>     * @variable_name:   name of uefi variable's name in u16
> >>>>> + * @mask:            bitmask with required attributes of variables to be collected.
> >>>>> + *                      variables are only collected if all of the required
> >>>>> + *                      attributes match. Use 0 to skip matching
> >>>>>     * @vendor:          vendor's guid
> >>>>>     *
> >>>>>     * Return: status code
> >>>>>     */
> >>>>>    efi_status_t __efi_runtime
> >>>>>    efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size, u16 *variable_name,
> >>>>> -                            efi_guid_t *vendor);
> >>>>> +                            efi_guid_t *vendor, u32 mask);
> >>>>>    /**
> >>>>>     * efi_get_variable_mem() - Runtime common code across efi variable
> >>>>>     *                          implementations for GetVariable() from
> >>>>> @@ -289,12 +292,15 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size, u16 *variable_na
> >>>>>     * @data_size:               size of the buffer to which the variable value is copied
> >>>>>     * @data:            buffer to which the variable value is copied
> >>>>>     * @timep:           authentication time (seconds since start of epoch)
> >>>>> + * @mask:            bitmask with required attributes of variables to be collected.
> >>>>> + *                      variables are only collected if all of the required
> >>>>> + *                      attributes match. Use 0 to skip matching
> >>>>>     * Return:           status code
> >>>>>     */
> >>>>>    efi_status_t __efi_runtime
> >>>>>    efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> >>>>>                      u32 *attributes, efi_uintn_t *data_size, void *data,
> >>>>> -                  u64 *timep);
> >>>>> +                  u64 *timep, u32 mask);
> >>>>>
> >>>>>    /**
> >>>>>     * efi_get_variable_runtime() - runtime implementation of GetVariable()
> >>>>> @@ -334,4 +340,10 @@ efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
> >>>>>     */
> >>>>>    void efi_var_buf_update(struct efi_var_file *var_buf);
> >>>>>
> >>>>> +efi_status_t __efi_runtime efi_var_collect_mem(struct efi_var_file *buf,
> >>>>> +                                            efi_uintn_t *lenp,
> >>>>> +                                            u32 check_attr_mask);
> >>>>> +
> >>>>> +u32 efi_var_entry_len(struct efi_var_entry *var);
> >>>>> +
> >>>>>    #endif
> >>>>> diff --git a/lib/charset.c b/lib/charset.c
> >>>>> index df4f04074852..182c92a50c48 100644
> >>>>> --- a/lib/charset.c
> >>>>> +++ b/lib/charset.c
> >>>>> @@ -387,7 +387,7 @@ int u16_strcasecmp(const u16 *s1, const u16 *s2)
> >>>>>     *           > 0 if the first different u16 in s1 is greater than the
> >>>>>     *           corresponding u16 in s2
> >>>>>     */
> >>>>> -int u16_strncmp(const u16 *s1, const u16 *s2, size_t n)
> >>>>> +int __efi_runtime u16_strncmp(const u16 *s1, const u16 *s2, size_t n)
> >>>>>    {
> >>>>>         int ret = 0;
> >>>>>
> >>>>> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> >>>>> index c8f7a88ba8db..73831c527e00 100644
> >>>>> --- a/lib/efi_loader/efi_runtime.c
> >>>>> +++ b/lib/efi_loader/efi_runtime.c
> >>>>> @@ -130,6 +130,8 @@ efi_status_t efi_init_runtime_supported(void)
> >>>>>                                 EFI_RT_SUPPORTED_CONVERT_POINTER;
> >>>>>
> >>>>>         if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> >>>>> +             u8 s = 0;
> >>>>> +
> >>>>>                 ret = efi_set_variable_int(u"RTStorageVolatile",
> >>>>>                                            &efi_guid_efi_rt_var_file,
> >>>>>                                            EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >>>>> @@ -141,6 +143,29 @@ efi_status_t efi_init_runtime_supported(void)
> >>>>>                         log_err("Failed to set RTStorageVolatile\n");
> >>>>>                         return ret;
> >>>>>                 }
> >>>>> +             /*
> >>>>> +              * This variable needs to be visible so users can read it,
> >>>>> +              * but the real contents are going to be filled during
> >>>>> +              * GetVariable
> >>>>> +              */
> >>>>> +             ret = efi_set_variable_int(u"VarToFile",
> >>>>> +                                        &efi_guid_efi_rt_var_file,
> >>>>> +                                        EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >>>>> +                                        EFI_VARIABLE_RUNTIME_ACCESS |
> >>>>> +                                        EFI_VARIABLE_READ_ONLY,
> >>>>> +                                        sizeof(s),
> >>>>> +                                        &s, false);
> >>>>> +             if (ret != EFI_SUCCESS) {
> >>>>> +                     log_err("Failed to set VarToFile\n");
> >>>>> +                     efi_set_variable_int(u"RTStorageVolatile",
> >>>>> +                                          &efi_guid_efi_rt_var_file,
> >>>>> +                                          EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >>>>> +                                          EFI_VARIABLE_RUNTIME_ACCESS |
> >>>>> +                                          EFI_VARIABLE_READ_ONLY,
> >>>>> +                                          0, NULL, false);
> >>>>> +
> >>>>> +                     return ret;
> >>>>> +             }
> >>>>>                 rt_table->runtime_services_supported |= EFI_RT_SUPPORTED_SET_VARIABLE;
> >>>>>         }
> >>>>>
> >>>>> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> >>>>> index aa8feffd3ec1..7862f2d6ce8a 100644
> >>>>> --- a/lib/efi_loader/efi_var_common.c
> >>>>> +++ b/lib/efi_loader/efi_var_common.c
> >>>>> @@ -182,7 +182,8 @@ efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> >>>>>    {
> >>>>>         efi_status_t ret;
> >>>>>
> >>>>> -     ret = efi_get_variable_mem(variable_name, guid, attributes, data_size, data, NULL);
> >>>>> +     ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
> >>>>> +                                data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
> >>>>>
> >>>>>         /* Remove EFI_VARIABLE_READ_ONLY flag */
> >>>>>         if (attributes)
> >>>>> @@ -195,7 +196,8 @@ efi_status_t __efi_runtime EFIAPI
> >>>>>    efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
> >>>>>                                    u16 *variable_name, efi_guid_t *guid)
> >>>>>    {
> >>>>> -     return efi_get_next_variable_name_mem(variable_name_size, variable_name, guid);
> >>>>> +     return efi_get_next_variable_name_mem(variable_name_size, variable_name,
> >>>>> +                                           guid, EFI_VARIABLE_RUNTIME_ACCESS);
> >>>>>    }
> >>>>>
> >>>>>    /**
> >>>>> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> >>>>> index 6c21cec5d457..940ab6638823 100644
> >>>>> --- a/lib/efi_loader/efi_var_mem.c
> >>>>> +++ b/lib/efi_loader/efi_var_mem.c
> >>>>> @@ -61,6 +61,23 @@ efi_var_mem_compare(struct efi_var_entry *var, const efi_guid_t *guid,
> >>>>>         return match;
> >>>>>    }
> >>>>>
> >>>>> +/**
> >>>>> + * efi_var_entry_len() - Get the entry len including headers & name
> >>>>> + *
> >>>>> + * @var:     pointer to variable start
> >>>>> + *
> >>>>> + * Return:   8-byte aligned variable entry length
> >>>>> + */
> >>>>> +
> >>>>> +u32 __efi_runtime efi_var_entry_len(struct efi_var_entry *var)
> >>>>> +{
> >>>>> +     if (!var)
> >>>>> +             return 0;
> >>>>> +
> >>>>> +     return ALIGN((sizeof(u16) * (u16_strlen(var->name) + 1)) +
> >>>>> +                  var->length + sizeof(*var), 8);
> >>>>> +}
> >>>>> +
> >>>>>    struct efi_var_entry __efi_runtime
> >>>>>    *efi_var_mem_find(const efi_guid_t *guid, const u16 *name,
> >>>>>                   struct efi_var_entry **next)
> >>>>> @@ -184,53 +201,6 @@ u64 __efi_runtime efi_var_mem_free(void)
> >>>>>                sizeof(struct efi_var_entry);
> >>>>>    }
> >>>>>
> >>>>> -/**
> >>>>> - * efi_var_mem_bs_del() - delete boot service only variables
> >>>>> - */
> >>>>> -static void efi_var_mem_bs_del(void)
> >>>>> -{
> >>>>> -     struct efi_var_entry *var = efi_var_buf->var;
> >>>>> -
> >>>>> -     for (;;) {
> >>>>> -             struct efi_var_entry *last;
> >>>>> -
> >>>>> -             last = (struct efi_var_entry *)
> >>>>> -                    ((uintptr_t)efi_var_buf + efi_var_buf->length);
> >>>>> -             if (var >= last)
> >>>>> -                     break;
> >>>>> -             if (var->attr & EFI_VARIABLE_RUNTIME_ACCESS) {
> >>>>> -                     u16 *data;
> >>>>> -
> >>>>> -                     /* skip variable */
> >>>>> -                     for (data = var->name; *data; ++data)
> >>>>> -                             ;
> >>>>> -                     ++data;
> >>>>> -                     var = (struct efi_var_entry *)
> >>>>> -                           ALIGN((uintptr_t)data + var->length, 8);
> >>>>> -             } else {
> >>>>> -                     /* delete variable */
> >>>>> -                     efi_var_mem_del(var);
> >>>>> -             }
> >>>>> -     }
> >>>>> -}
> >>>>> -
> >>>>> -/**
> >>>>> - * efi_var_mem_notify_exit_boot_services() - ExitBootService callback
> >>>>> - *
> >>>>> - * @event:   callback event
> >>>>> - * @context: callback context
> >>>>> - */
> >>>>> -static void EFIAPI
> >>>>> -efi_var_mem_notify_exit_boot_services(struct efi_event *event, void *context)
> >>>>> -{
> >>>>> -     EFI_ENTRY("%p, %p", event, context);
> >>>>> -
> >>>>> -     /* Delete boot service only variables */
> >>>>> -     efi_var_mem_bs_del();
> >>>>> -
> >>>>> -     EFI_EXIT(EFI_SUCCESS);
> >>>>> -}
> >>>>> -
> >>>>>    /**
> >>>>>     * efi_var_mem_notify_exit_boot_services() - SetVirtualMemoryMap callback
> >>>>>     *
> >>>>> @@ -261,11 +231,7 @@ efi_status_t efi_var_mem_init(void)
> >>>>>         efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
> >>>>>         efi_var_buf->length = (uintptr_t)efi_var_buf->var -
> >>>>>                               (uintptr_t)efi_var_buf;
> >>>>> -     /* crc32 for 0 bytes = 0 */
> >>>>>
> >>>>> -     ret = efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
> >>>>> -                            efi_var_mem_notify_exit_boot_services, NULL,
> >>>>> -                            NULL, &event);
> >>>>>         if (ret != EFI_SUCCESS)
> >>>>>                 return ret;
> >>>>>         ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
> >>>>> @@ -276,10 +242,71 @@ efi_status_t efi_var_mem_init(void)
> >>>>>         return ret;
> >>>>>    }
> >>>>>
> >>>>> +/**
> >>>>> + * efi_var_collect_mem() - Copy EFI variables matching attributes mask from
> >>>>> + *                         efi_var_buf
> >>>>> + *
> >>>>> + * @buf:     buffer containing variable collection
> >>>>> + * @lenp:    buffer length
> >>>>> + * @mask:    mask of matched attributes
> >>>>> + *
> >>>>> + * Return:   Status code
> >>>>> + */
> >>>>> +efi_status_t __efi_runtime
> >>>>> +efi_var_collect_mem(struct efi_var_file *buf, efi_uintn_t *lenp, u32 mask)
> >>>>> +{
> >>>>> +     static struct efi_var_file __efi_runtime_data hdr = {
> >>>>> +             .magic = EFI_VAR_FILE_MAGIC,
> >>>>> +     };
> >>>>> +     struct efi_var_entry *last, *var, *var_to;
> >>>>> +
> >>>>> +     hdr.length = sizeof(struct efi_var_file);
> >>>>> +
> >>>>> +     var = efi_var_buf->var;
> >>>>> +     last = (struct efi_var_entry *)
> >>>>> +            ((uintptr_t)efi_var_buf + efi_var_buf->length);
> >>>>> +     if (buf)
> >>>>> +             var_to = buf->var;
> >>>>> +
> >>>>> +     while (var < last) {
> >>>>> +             u32 len = efi_var_entry_len(var);
> >>>>> +
> >>>>> +             if ((var->attr & mask) != mask) {
> >>>>> +                     var = (void *)((uintptr_t)var + len);
> >>>>> +                     continue;
> >>>>> +             }
> >>>>> +
> >>>>> +             hdr.length += len;
> >>>>> +
> >>>>> +             if (buf && hdr.length <= *lenp) {
> >>>>> +                     efi_memcpy_runtime(var_to, var, len);
> >>>>> +                     var_to = (void *)var_to + len;
> >>>>> +             }
> >>>>> +             var = (void *)var + len;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (!buf && hdr.length <= *lenp) {
> >>>>> +             *lenp = hdr.length;
> >>>>> +             return EFI_INVALID_PARAMETER;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (!buf || hdr.length > *lenp) {
> >>>>> +             *lenp = hdr.length;
> >>>>> +             return EFI_BUFFER_TOO_SMALL;
> >>>>> +     }
> >>>>> +     hdr.crc32 = crc32(0, (u8 *)buf->var,
> >>>>> +                       hdr.length - sizeof(struct efi_var_file));
> >>>>> +
> >>>>> +     efi_memcpy_runtime(buf, &hdr, sizeof(hdr));
> >>>>> +     *lenp = hdr.length;
> >>>>> +
> >>>>> +     return EFI_SUCCESS;
> >>>>> +}
> >>>>> +
> >>>>>    efi_status_t __efi_runtime
> >>>>>    efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> >>>>>                      u32 *attributes, efi_uintn_t *data_size, void *data,
> >>>>> -                  u64 *timep)
> >>>>> +                  u64 *timep, u32 mask)
> >>>>>    {
> >>>>>         efi_uintn_t old_size;
> >>>>>         struct efi_var_entry *var;
> >>>>> @@ -291,11 +318,22 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> >>>>>         if (!var)
> >>>>>                 return EFI_NOT_FOUND;
> >>>>>
> >>>>> +     /*
> >>>>> +      * This function is used at runtime to dump EFI variables.
> >>>>> +      * The memory backend we keep around has BS-only variables as
> >>>>> +      * well. At runtime we filter them here
> >>>>> +      */
> >>>>> +     if (mask && !((var->attr & mask) == mask))
> >>>>> +             return EFI_NOT_FOUND;
> >>>>> +
> >>>>>         if (attributes)
> >>>>>                 *attributes = var->attr;
> >>>>>         if (timep)
> >>>>>                 *timep = var->time;
> >>>>>
> >>>>> +     if (!u16_strcmp(variable_name, u"VarToFile"))
> >>>>> +             return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
> >>>>> +
> >>>>>         old_size = *data_size;
> >>>>>         *data_size = var->length;
> >>>>>         if (old_size < var->length)
> >>>>> @@ -315,7 +353,8 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> >>>>>
> >>>>>    efi_status_t __efi_runtime
> >>>>>    efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
> >>>>> -                            u16 *variable_name, efi_guid_t *vendor)
> >>>>> +                            u16 *variable_name, efi_guid_t *vendor,
> >>>>> +                            u32 mask)
> >>>>>    {
> >>>>>         struct efi_var_entry *var;
> >>>>>         efi_uintn_t len, old_size;
> >>>>> @@ -324,6 +363,7 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
> >>>>>         if (!variable_name_size || !variable_name || !vendor)
> >>>>>                 return EFI_INVALID_PARAMETER;
> >>>>>
> >>>>> +skip:
> >>>>>         len = *variable_name_size >> 1;
> >>>>>         if (u16_strnlen(variable_name, len) == len)
> >>>>>                 return EFI_INVALID_PARAMETER;
> >>>>> @@ -347,6 +387,11 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
> >>>>>         efi_memcpy_runtime(variable_name, var->name, *variable_name_size);
> >>>>>         efi_memcpy_runtime(vendor, &var->guid, sizeof(efi_guid_t));
> >>>>>
> >>>>> +     if (mask && !((var->attr & mask) == mask)) {
> >>>>> +             *variable_name_size = old_size;
> >>>>> +             goto skip;
> >>>>> +     }
> >>>>> +
> >>>>>         return EFI_SUCCESS;
> >>>>>    }
> >>>>>
> >>>>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> >>>>> index 47bb79920575..0cbed53d1dbf 100644
> >>>>> --- a/lib/efi_loader/efi_variable.c
> >>>>> +++ b/lib/efi_loader/efi_variable.c
> >>>>> @@ -209,14 +209,16 @@ efi_get_variable_int(const u16 *variable_name, const efi_guid_t *vendor,
> >>>>>                      u32 *attributes, efi_uintn_t *data_size, void *data,
> >>>>>                      u64 *timep)
> >>>>>    {
> >>>>> -     return efi_get_variable_mem(variable_name, vendor, attributes, data_size, data, timep);
> >>>>> +     return efi_get_variable_mem(variable_name, vendor, attributes, data_size,
> >>>>> +                                 data, timep, 0);
> >>>>>    }
> >>>>>
> >>>>>    efi_status_t __efi_runtime
> >>>>>    efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
> >>>>>                                u16 *variable_name, efi_guid_t *vendor)
> >>>>>    {
> >>>>> -     return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
> >>>>> +     return efi_get_next_variable_name_mem(variable_name_size, variable_name,
> >>>>> +                                           vendor, 0);
> >>>>>    }
> >>>>>
> >>>>>    /**
> >>>>> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> >>>>> index dde135fd9f81..4f1aa298da13 100644
> >>>>> --- a/lib/efi_loader/efi_variable_tee.c
> >>>>> +++ b/lib/efi_loader/efi_variable_tee.c
> >>>>> @@ -959,11 +959,6 @@ void efi_variables_boot_exit_notify(void)
> >>>>>                 log_err("Unable to notify the MM partition for ExitBootServices\n");
> >>>>>         free(comm_buf);
> >>>>>
> >>>>> -     /*
> >>>>> -      * Populate the list for runtime variables.
> >>>>> -      * asking EFI_VARIABLE_RUNTIME_ACCESS is redundant, since
> >>>>> -      * efi_var_mem_notify_exit_boot_services will clean those, but that's fine
> >>>>> -      */
> >>>>>         ret = efi_var_collect(&var_buf, &len, EFI_VARIABLE_RUNTIME_ACCESS);
> >>>>>         if (ret != EFI_SUCCESS)
> >>>>>                 log_err("Can't populate EFI variables. No runtime variables will be available\n");
> >>>>> --
> >>>>> 2.40.1
> >>>>>
> >>>>>
> >>
>
