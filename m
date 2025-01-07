Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490A7E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 17:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D15801FD;
	Tue,  7 Jan 2025 18:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YFd8HUWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF72A8036B; Tue,  7 Jan 2025 18:19:21 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4211D801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 18:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 43E343F86B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736270353;
 bh=o3FYfRfzn/zdHM1H0C2jScCPXChAzoOVUIu7wsOeL1w=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YFd8HUWBdsBAM2MuoroMKqxEknxZvAt9ok09+gvs9bVnk1EQHhZX/dtNY/gDthtgc
 H+WQbFnakSAL7gwZBIF4VVBuKKTD1vq3O+h3FsND8eVzJl/n2BIBtTpZII5Mw0wuOE
 tyF7F70/h3JIrIGwA5vBsw5q79guZzmhrsa2yTlLRXkhGemMU2k8p+8onjXrCQHJym
 MDfy/JtUy67Ekz2OtChjacPl/H7LLmzipbovZl+J/Xum54pwE4mtYrAg+Y54IsWo0Y
 AgBt9kdxTiz1mK6Mt/IrNpA/GjfsiyLQ4LAxk9zSETuSxPaYeRhwFWl6CPF9x+nfC3
 mXFB1/R7n9IHA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e2579507so6972317f8f.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 09:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736270352; x=1736875152;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o3FYfRfzn/zdHM1H0C2jScCPXChAzoOVUIu7wsOeL1w=;
 b=mF76ixDmyp9WD4O1OX0PnT1PqqqMmGE5uZ6oeJaEVkT2G/dmLIOw7WdyN/G6MM8HWK
 26B+zHQXK9J4zWeG/58DXr7rjSkfZraONWxgPLtg6oJfwUhlE9eO6o/sPI5zHq7mTt3h
 UF6qtv0lVyHO7tOBgOjAZo7MpmeViERGqRH1B6LXab+BicsPrCN5JJ80PeBsDWGPn8h+
 hDYGU+K0ok4pw7kfLRwQxi662CawSnki7XYI2rwPIw1OX7CKPhDEewvEgz9hk9OsJ4ET
 reoSWZB1a3l+Qg1GVookvl2OQx+U8TEydDSwjRGooDvCxR/FP/E3YAc7nCcU5FukdCCQ
 dwow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVISTB39DANNjD37chSo+Nt7FJhyH7cllgbFJMSYyouQlOOnSheFQ5yr167Amk02tSoCJh7Qc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzvb96RUJUoQl2UG1xx8/oYjmkwcrylfpsAR6sn8zQrUPq43xrU
 azoTN08JtCITwhbLNOhyUh0XWSvsYhMHDSICysl4xF+56nNikk8vREo8QQFmY1Oy+fH0O249El+
 tzjXHaDsjCQVL2legr+brqHKNExfUKoBMVn5+O9sYk1tuyBYbR5U1FZRrMBhBE0rMNXw=
X-Gm-Gg: ASbGnctFqNUy2jgjx0+BOPaliOQE79cankGwWnZNCfHqZlwOjtW0KG/seaZk1+vLEe6
 C/bU/Y4ldoLT7uHLvjjRXWfaCXxYCSIoKAqsM9uSG3aK5VoXHpDg08v4hwsWth71aqVEHQYBqjw
 LPz65ee1yt5aS9a+GwNA1biA6MjdYxgTTuN4P3m/oZW1+26wyGv0jr1bA56r2DSf4CB7Oef25P1
 BtHlRrZkecJdAUuze/HG2trdQRs3Vb3WS/l6p+n2KJs1C+bjHnjCB6cEMsVZDNBymrp/j4UIvn8
 Lbweg6CD95k2UhFXsl85MdE1ir6eBUl3L7pEtEN4+HER0xk=
X-Received: by 2002:a05:6000:480a:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-38a221fa8c6mr59277262f8f.33.1736270351071; 
 Tue, 07 Jan 2025 09:19:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG00KFIVPnm6A3CHW4Ywke2IAPVC/TIRCQzYnqRWHX+AxS/nHHssgj5mCfqMZIOcPoAE79UCA==
X-Received: by 2002:a05:6000:480a:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-38a221fa8c6mr59277142f8f.33.1736270349076; 
 Tue, 07 Jan 2025 09:19:09 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:2e2d:73b3:5130:24d1:c9b7?
 ([2a02:3035:6e0:2e2d:73b3:5130:24d1:c9b7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a47c9b2efsm31289232f8f.91.2025.01.07.09.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 09:19:08 -0800 (PST)
Message-ID: <05ffa461-d4ae-4522-b9db-b7ee34e20737@canonical.com>
Date: Tue, 7 Jan 2025 18:19:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] efi_loader: install DXE services table
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 u-boot@lists.denx.de
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <20250102181133.378867-4-heinrich.schuchardt@canonical.com>
 <CAC_iWjJhQQrNPyFDTAdo14X+x_CWer05+WVWu71xu_vxUb1iTw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJhQQrNPyFDTAdo14X+x_CWer05+WVWu71xu_vxUb1iTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 07.01.25 14:30, Ilias Apalodimas wrote:
> On Thu, 2 Jan 2025 at 20:11, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The debug version of the UEFI shell requires a DXE services table to exist.
>>
>> Implement the table and let all DXE functions return EFI_UNSUPPORTED.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   include/efi_dxe.h          |  54 ++++++++++++
>>   include/efi_loader.h       |   7 ++
>>   lib/efi_loader/Kconfig     |   7 ++
>>   lib/efi_loader/Makefile    |   1 +
>>   lib/efi_loader/efi_dxe.c   | 176 +++++++++++++++++++++++++++++++++++++
>>   lib/efi_loader/efi_setup.c |   6 ++
>>   6 files changed, 251 insertions(+)
>>   create mode 100644 include/efi_dxe.h
>>   create mode 100644 lib/efi_loader/efi_dxe.c
>>
>> diff --git a/include/efi_dxe.h b/include/efi_dxe.h
>> new file mode 100644
>> index 00000000000..5623189de0c
>> --- /dev/null
>> +++ b/include/efi_dxe.h
>> @@ -0,0 +1,54 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + *  DXE services table
>> + *
>> + *  Copyright (c) 2025 Heinrich Schuchardt
>> + */
>> +
>> +#ifndef _EFI_DXE_H
>> +#define _EFI_DXE_H 1
>> +
>> +#include <efi.h>
>> +
>> +/**
>> + * define DXE_SERVICES_SIGNATURE - DXE services signature ('DXE_SERV')
>> + */
>> +#define DXE_SERVICES_SIGNATURE 0x565245535f455844
>> +/**
>> + * define DXE_SERVICES_REVISION - DXE services revision (1.8)
>> + */
>> +#define DXE_SERVICES_REVISION 0x00010050
>> +
>> +/**
>> + * define EFI_DXE_SERVICES_TABLE_GUID - GUID of the EFI DXE services table
>> + */
>> +#define EFI_DXE_SERVICES_TABLE_GUID \
>> +       EFI_GUID(0x5ad34ba, 0x6f02, 0x4214, \
>> +                0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
>> +
>> +struct efi_dxe_services {
>> +       struct efi_table_hdr hdr;
>> +
>> +       efi_status_t (EFIAPI *add_memory_space)(void);
>> +       efi_status_t (EFIAPI *allocate_memory_space)(void);
>> +       efi_status_t (EFIAPI *free_memory_space)(void);
>> +       efi_status_t (EFIAPI *remove_memory_space)(void);
>> +       efi_status_t (EFIAPI *get_memory_space_descriptor)(void);
>> +       efi_status_t (EFIAPI *set_memory_space_attributes)(void);
>> +       efi_status_t (EFIAPI *get_memory_space_map)(void);
>> +       efi_status_t (EFIAPI *add_io_space)(void);
>> +       efi_status_t (EFIAPI *allocate_io_space)(void);
>> +       efi_status_t (EFIAPI *free_io_space)(void);
>> +       efi_status_t (EFIAPI *remove_io_space)(void);
>> +       efi_status_t (EFIAPI *get_io_space_descriptor)(void);
>> +       efi_status_t (EFIAPI *get_io_space_map)(void);
>> +       efi_status_t (EFIAPI *dispatch)(void);
>> +       efi_status_t (EFIAPI *schedule)(void);
>> +       efi_status_t (EFIAPI *trust)(void);
>> +       efi_status_t (EFIAPI *process_firmware_volume)(void);
>> +       efi_status_t (EFIAPI *set_memory_space_capabilities)(void);
>> +};
>> +
>> +extern efi_guid_t efi_dxe_services_table_guid;
>> +
>> +#endif /* _EFI_DXE_H */
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index c1258098217..d474866184f 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -663,6 +663,13 @@ efi_status_t efi_smbios_register(void);
>>    */
>>   efi_status_t efi_hob_list_register(void);
>>
>> +/**
>> + * efi_dxe_services_register() - install DXE services table
>> + *
>> + * Return:     status code
>> + */
>> +efi_status_t efi_dxe_services_register(void);
>> +
>>   struct efi_simple_file_system_protocol *
>>   efi_fs_from_path(struct efi_device_path *fp);
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index ec38a0ea352..ed3470508ff 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -384,6 +384,13 @@ config EFI_DT_FIXUP
>>            The EFI device-tree fix-up protocol provides a function to let the
>>            firmware apply fix-ups. This may be used by boot loaders.
>>
>> +config EFI_DXE
>> +       bool 'DXE services table'
>> +       default y
>> +       help
>> +         Install the DXE services table. The debug version of the UEFI shell
>> +         requires it.
>> +
>>   config EFI_LOADER_HII
>>          bool "HII protocols"
>>          default y
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index 195ed8667fe..4f250f21811 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -33,6 +33,7 @@ obj-y += efi_console.o
>>   obj-y += efi_device_path.o
>>   obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
>>   obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
>> +obj-$(CONFIG_EFI_DXE) += efi_dxe.o
>>   obj-y += efi_dt_fixup.o
>>   obj-y += efi_fdt.o
>>   obj-y += efi_file.o
>> diff --git a/lib/efi_loader/efi_dxe.c b/lib/efi_loader/efi_dxe.c
>> new file mode 100644
>> index 00000000000..f8920575b0c
>> --- /dev/null
>> +++ b/lib/efi_loader/efi_dxe.c
>> @@ -0,0 +1,176 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *  DXE services table
>> + *
>> + *  Copyright (c) 2025 Heinrich Schuchardt
>> + */
>> +
>> +#include <efi_dxe.h>
>> +#include <efi_loader.h>
>> +
>> +efi_guid_t efi_dxe_services_table_guid = EFI_DXE_SERVICES_TABLE_GUID;
>> +
>> +static efi_status_t EFIAPI add_memory_space(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI allocate_memory_space(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI free_memory_space(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI remove_memory_space(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI get_memory_space_descriptor(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI set_memory_space_attributes(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI get_memory_space_map(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI add_io_space(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI allocate_io_space(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI free_io_space(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI remove_io_space(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI get_io_space_descriptor(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI get_io_space_map(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI dispatch(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI schedule(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI trust(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI process_firmware_volume(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static efi_status_t EFIAPI set_memory_space_capabilities(void)
>> +{
>> +       EFI_ENTRY();
>> +
>> +       return EFI_EXIT(EFI_UNSUPPORTED);
>> +}
>> +
>> +static struct efi_dxe_services efi_dxe_services = {
>> +       .hdr = {
>> +               .signature = DXE_SERVICES_SIGNATURE,
>> +               .revision = DXE_SERVICES_REVISION,
>> +               .headersize = sizeof(struct efi_dxe_services),
>> +       },
>> +       .add_memory_space = add_memory_space,
>> +       .allocate_memory_space = allocate_memory_space,
>> +       .free_memory_space = free_memory_space,
>> +       .remove_memory_space = remove_memory_space,
>> +       .get_memory_space_descriptor = get_memory_space_descriptor,
>> +       .set_memory_space_attributes = set_memory_space_attributes,
>> +       .get_memory_space_map = get_memory_space_map,
>> +       .add_io_space = add_io_space,
>> +       .allocate_io_space = allocate_io_space,
>> +       .free_io_space = free_io_space,
>> +       .remove_io_space = remove_io_space,
>> +       .get_io_space_descriptor = get_io_space_descriptor,
>> +       .get_io_space_map = get_io_space_map,
>> +       .dispatch = dispatch,
>> +       .schedule = schedule,
>> +       .trust = trust,
>> +       .process_firmware_volume = process_firmware_volume,
>> +       .set_memory_space_capabilities = set_memory_space_capabilities,
> 
> Do we plan on ever implementing those? If not we could use a single
> function returning EFI_UNSUPPORTED instead of all of them for code
> size reasons

Currently I don't plan to implement these. But I wanted to be able to add

     #define _DEBUG 1

to find out which of the functions is possibly used.

On x86 and sandbox I don't think our memory restrictions are very tight.

Best regards

Heinrich

> 
> Cheers
> /Ilias
>> +};
>> +
>> +efi_status_t efi_dxe_services_register(void)
>> +{
>> +       struct efi_dxe_services *dxe;
>> +
>> +       dxe = efi_alloc(sizeof(struct efi_dxe_services));
>> +       if (!dxe)
>> +               return EFI_OUT_OF_RESOURCES;
>> +
>> +       memcpy(dxe, &efi_dxe_services, sizeof(struct efi_dxe_services));
>> +
>> +       return efi_install_configuration_table(&efi_dxe_services_table_guid, dxe);
>> +}
>> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>> index 393b690c3ee..796da5d5678 100644
>> --- a/lib/efi_loader/efi_setup.c
>> +++ b/lib/efi_loader/efi_setup.c
>> @@ -260,6 +260,12 @@ efi_status_t efi_init_obj_list(void)
>>          if (ret != EFI_SUCCESS)
>>                  goto out;
>>
>> +       if (IS_ENABLED(CONFIG_EFI_DXE)) {
>> +               ret = efi_dxe_services_register();
>> +               if (ret != EFI_SUCCESS)
>> +                       goto out;
>> +       }
>> +
>>          if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>>                  ret = efi_ecpt_register();
>>                  if (ret != EFI_SUCCESS)
>> --
>> 2.47.1
>>

