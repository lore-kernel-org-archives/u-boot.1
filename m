Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D850FC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 21:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF2988231;
	Sat, 27 Apr 2024 23:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="m2fSCXRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D9888231; Sat, 27 Apr 2024 23:25:12 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D33588205
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 23:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ABF093FE5E
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714253109;
 bh=VP25mScTmGZZxpPlgpP88QETakbIldgtp1db94pyHJQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=m2fSCXRCt+3nyevOSJinKp5dxL9ja/9+gNKJ55U/nURpqg0JOoePdM/fgnOdMAT0l
 6F/YktGS7n2xzLvWVPyc3w1SkqyE65tzE5kGZwESl9p9GGv71BthrKId2URwzXbEpW
 mUdMFREaStQISisCrnDU3nNryKdW0ASrb1RH3S1xTyUV9Iv9n9LT+/9qjzafUMInBa
 mk1yVgvZfSF1qw30MqF89mbmNGDvMm5ajZSzpTUsJ9nIYtl5KqDOmOjzaVMdN3sYCz
 OLe2KqWlI0oApUmUxiD6SO6DI7nNjw4fYch3TbpcxeIv9f4eT9SBtCwsZDEh0MvmTj
 4HmSITfyNJROA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34b0b409775so1238500f8f.2
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 14:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714253109; x=1714857909;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VP25mScTmGZZxpPlgpP88QETakbIldgtp1db94pyHJQ=;
 b=cmA2ZxIJ6JZkWVab219zlnWi1Ttl9MLagIkMteJTNDutsBe2HEeJ7yGVmC/cWUXj9b
 uvP2WhhkKW55uc7mU4wkREpYedpa/aVLBP4ZIt0viBw80J7DtyN+rr0Mfewo2TlqTBgs
 /SuhxhX0/NLzL3thwNhCDPsOm3keQCrDls8Yc8VQVUtYP5znLpTF25GASBifbfL+K5Ia
 Wfe2o62MC1ujUC+m6EAAI2uqzRmn+R8SGVzIs6wi3GhKGyaYoZvz3T2rXjDGb3v6kjtx
 iGnzWHkFs4byI1Gdjnoz3bD6dsFdQyIoeZVC50tXdrlIMjUhI0C+MofxcjUMpKe8jfUf
 2rJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOssl1eV1nTBzL/989ewsjBqieEP9Lp2Dx2CulkM1cHQW1ug/k9PP3nZmIuWUvkpotrF8RbIuYgZCuLfKVyU4VZSK5JA==
X-Gm-Message-State: AOJu0YzhSpEIDMVkV2MFqYOBFzafAHd/crpVzIqJDQBFwYn50zw0gG8W
 7F1Dfbn2Jg5vI9oCxw1lySAchhdRTUe6EHTRjmH6e8ThhDpuqMAek73bsyiHxIEWPIjXWX6tGu5
 Jy79GsJAI+j7Al3ePheBFt6y4979kZAGBkCRTArbfxmru2URn3JaX4VYaj8uJgWm2kxU=
X-Received: by 2002:a05:600c:4fd2:b0:41b:e0e5:a525 with SMTP id
 o18-20020a05600c4fd200b0041be0e5a525mr1291911wmq.17.1714253108715; 
 Sat, 27 Apr 2024 14:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuU1WDt+C1I4PL9bOCjabG7MhHAaoevactrza7zQRpliaPhd8OYw1a8WL/TMtqkdkzTmCfCQ==
X-Received: by 2002:a05:600c:4fd2:b0:41b:e0e5:a525 with SMTP id
 o18-20020a05600c4fd200b0041be0e5a525mr1291895wmq.17.1714253108178; 
 Sat, 27 Apr 2024 14:25:08 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0041bff91ea43sm1336443wmq.37.2024.04.27.14.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Apr 2024 14:25:07 -0700 (PDT)
Message-ID: <1a2f27c2-9006-478b-a4cd-59dfec854143@canonical.com>
Date: Sat, 27 Apr 2024 23:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/14] cmd: eficonfig: add support for setting fdt
To: E Shattow <lucent@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-5-heinrich.schuchardt@canonical.com>
 <CANV2PTMG-eKjkDyumyvj-oqt+vNtyOW_Am650X5m88P6P1Qf5A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTMG-eKjkDyumyvj-oqt+vNtyOW_Am650X5m88P6P1Qf5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/27/24 19:21, E Shattow wrote:
> On Fri, Apr 26, 2024 at 7:25 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> We already support creating a load option where the device-path
>> field contains the concatenation of the binary device-path and
>> optionally the device path of the initrd which we expose via the
>> EFI_LOAD_FILE2_PROTOCOL.
>>
>> Allow to append another device-path pointing to the device-tree
>> identified by the device-tree GUID.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/eficonfig.c | 68 +++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 63 insertions(+), 5 deletions(-)
>>
>> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
>> index 1c57e66040b..d314051ee58 100644
>> --- a/cmd/eficonfig.c
>> +++ b/cmd/eficonfig.c
>> @@ -62,6 +62,7 @@ struct eficonfig_filepath_info {
>>   struct eficonfig_boot_option {
>>          struct eficonfig_select_file_info file_info;
>>          struct eficonfig_select_file_info initrd_info;
>> +       struct eficonfig_select_file_info fdt_info;
>>          unsigned int boot_index;
>>          u16 *description;
>>          u16 *optional_data;
>> @@ -1308,6 +1309,10 @@ static efi_status_t eficonfig_show_boot_option(struct eficonfig_boot_option *bo,
>>          if (ret != EFI_SUCCESS)
>>                  goto out;
>>
>> +       ret = prepare_file_selection_entry(efi_menu, "Fdt File: ", &bo->fdt_info);
>> +       if (ret != EFI_SUCCESS)
>> +               goto out;
>> +
>>          ret = create_boot_option_entry(efi_menu, "Optional Data: ", bo->optional_data,
>>                                         eficonfig_boot_add_optional_data, bo);
>>          if (ret != EFI_SUCCESS)
>> @@ -1394,21 +1399,39 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>>          struct efi_device_path *final_dp = NULL;
>>          struct efi_device_path *device_dp = NULL;
>>          struct efi_device_path *initrd_dp = NULL;
>> +       struct efi_device_path *fdt_dp = NULL;
>>          struct efi_device_path *initrd_device_dp = NULL;
>> +       struct efi_device_path *fdt_device_dp = NULL;
>>
>> -       const struct efi_initrd_dp id_dp = {
>> +       const struct efi_initrd_dp initrd_prefix = {
>>                  .vendor = {
>>                          {
>>                          DEVICE_PATH_TYPE_MEDIA_DEVICE,
>>                          DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
>> -                       sizeof(id_dp.vendor),
>> +                       sizeof(initrd_prefix.vendor),
>>                          },
>>                          EFI_INITRD_MEDIA_GUID,
>>                  },
>>                  .end = {
>>                          DEVICE_PATH_TYPE_END,
>>                          DEVICE_PATH_SUB_TYPE_END,
>> -                       sizeof(id_dp.end),
>> +                       sizeof(initrd_prefix.end),
>> +               }
>> +       };
>> +
>> +       const struct efi_initrd_dp fdt_prefix = {
>> +               .vendor = {
>> +                       {
>> +                       DEVICE_PATH_TYPE_MEDIA_DEVICE,
>> +                       DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
>> +                       sizeof(fdt_prefix.vendor),
>> +                       },
>> +                       EFI_FDT_GUID,
>> +               },
>> +               .end = {
>> +                       DEVICE_PATH_TYPE_END,
>> +                       DEVICE_PATH_SUB_TYPE_END,
>> +                       sizeof(initrd_prefix.end),
>>                  }
>>          };
>>
>> @@ -1424,6 +1447,12 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>>                  goto out;
>>          }
>>
>> +       bo->fdt_info.current_path = calloc(1, EFICONFIG_FILE_PATH_BUF_SIZE);
>> +       if (!bo->fdt_info.current_path) {
>> +               ret =  EFI_OUT_OF_RESOURCES;
>> +               goto out;
>> +       }
>> +
>>          bo->description = calloc(1, EFICONFIG_DESCRIPTION_MAX * sizeof(u16));
>>          if (!bo->description) {
>>                  ret =  EFI_OUT_OF_RESOURCES;
>> @@ -1456,13 +1485,20 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>>                  if (lo.file_path)
>>                          fill_file_info(lo.file_path, &bo->file_info, device_dp);
>>
>> -               /* Initrd file path(optional) is placed at second instance. */
>> +               /* Initrd file path (optional) is placed at second instance. */
>>                  initrd_dp = efi_dp_from_lo(&lo, &efi_lf2_initrd_guid);
>>                  if (initrd_dp) {
>>                          fill_file_info(initrd_dp, &bo->initrd_info, initrd_device_dp);
>>                          efi_free_pool(initrd_dp);
>>                  }
>>
>> +               /* Fdt file path (optional) is placed as third instance. */
>> +               fdt_dp = efi_dp_from_lo(&lo, &efi_guid_fdt);
>> +               if (fdt_dp) {
>> +                       fill_file_info(fdt_dp, &bo->fdt_info, fdt_device_dp);
>> +                       efi_free_pool(fdt_dp);
>> +               }
>> +
>>                  if (size > 0)
>>                          memcpy(bo->optional_data, lo.optional_data, size);
>>          }
>> @@ -1484,11 +1520,23 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>>                          ret = EFI_OUT_OF_RESOURCES;
>>                          goto out;
>>                  }
>> -               initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
>> +               initrd_dp = efi_dp_concat((const struct efi_device_path *)&initrd_prefix,
>>                                            dp);
>>                  efi_free_pool(dp);
>>          }
>>
>> +       if (bo->fdt_info.dp_volume) {
>> +               dp = eficonfig_create_device_path(bo->fdt_info.dp_volume,
>> +                                                 bo->fdt_info.current_path);
>> +               if (!dp) {
>> +                       ret = EFI_OUT_OF_RESOURCES;
>> +                       goto out;
>> +               }
>> +               fdt_dp = efi_dp_concat((const struct efi_device_path *)&fdt_prefix,
>> +                                      dp);
>> +               efi_free_pool(dp);
>> +       }
>> +
>>          dp = eficonfig_create_device_path(bo->file_info.dp_volume, bo->file_info.current_path);
>>          if (!dp) {
>>                  ret = EFI_OUT_OF_RESOURCES;
>> @@ -1505,6 +1553,13 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>>                          goto out;
>>                  }
>>          }
>> +       if (fdt_dp) {
>> +               final_dp = efi_dp_merge(final_dp, &final_dp_size, fdt_dp);
>> +               if (!final_dp) {
>> +                       ret = EFI_OUT_OF_RESOURCES;
>> +                       goto out;
>> +               }
>> +       }
>>
>>          if (utf16_utf8_strlen(bo->optional_data)) {
>>                  len = utf16_utf8_strlen(bo->optional_data) + 1;
>> @@ -1522,9 +1577,12 @@ out:
>>          free(bo->description);
>>          free(bo->file_info.current_path);
>>          free(bo->initrd_info.current_path);
>> +       free(bo->fdt_info.current_path);
>>          efi_free_pool(device_dp);
>>          efi_free_pool(initrd_device_dp);
>>          efi_free_pool(initrd_dp);
>> +       efi_free_pool(fdt_device_dp);
>> +       efi_free_pool(fdt_dp);
>>          efi_free_pool(final_dp);
>>
>>          return ret;
>> --
>> 2.43.0
>>
> 
> Would it make sense to skip showing the user partitions that are not
> valid (or why does the Linux Swap partition not show here but the
> Linux partition with ext4 does? Neither is valid for selecting Fdt
> File ?) and/or extend eficonfig for user-entered data? For example if
> I was very sure I wanted U-Boot to search a location but I just didn't
> have the SD Card that configuration is meant for currently inserted, I
> must use efidebug to configure this?

The eficonfig command shows the partitions with a file-system that 
U-Boot supports. What problems do you see in being able to specify that 
a device-tree file shall be loaded from an ext4 file-system?

> 
> It was always confusing how Edit action hides from view an automatic
> (global?) boot option i.e. 'mmc 0' that is configurable from Change
> Boot Order. I guess that there would have just been File
> EFI\BOOT\BOOTRISCV64.EFI to show and that is not interesting enough
> information for the added complexity of a save-disabled Edit entry.
> However now or in future there will be useful information to display
> so this should become viewable as a save-disabled entry from Edit
> (rename? View/Edit) action, where it is convenient to see File
> constant EFI\BOOT\BOOTRISCV64.EFI and also the detected values that

This file name is not stored in the Boot#### variable. It would be 
confusing to show a file name here.

> will be used i.e. from parsing U-Boot variable $fdtfile. I do not mean
> that this should be a method for editing U-Boot environment variables,
> only that it would be useful to know for example when
> $fdtfile=vendor/boardname.dtb that the U-Boot EFI code heuristic has
> decided that this currently resolves to mmc
> 0:1/dtb\vendor\boardname.dtb value. If the automatic values are not
> what the user wants then they may create a new boot entry or leave the
> context of eficonfig to update something that affects the detection
> logic such as U-Boot env variables, and perhaps again enter eficonfig
> to confirm that the heuristic is now doing what they would like.

The eficonfig command is used to edit the EFI variables Boot#### and 
BootOrder. This is the content shown by the command.

With patch 14 a logic is implemented to read a device-tree file supplied 
on the boot partition.

Which file will be loaded is not known when the boot option is edited as 
multiple directories are scanned and the value of $fdtfile may be 
changed by the user before invoking the bootmgr. Scanning which such 
file exists while running the editor would unnecessarily complicate the 
code.

For sure the fall-back logic should be documented.

Best regards

Heinrich

> Without any visibility of this global boot option from the Edit
> action, it is not known to need to edit the boot order after adding a
> boot entry where before there was apparently none. Some of that could
> be addressed with documentation but the best result would be it being
> obvious through use. It's not really obvious now that something named
> 'mmc 0' only appearing in the Boot Order action of eficonfig what
> filename it requires or if it is going to use an Initrd and/or Fdt.
> 
> Aside these more broad usability concerns there was success in adding
> a boot item with Fdt setting and changing the order that it be
> preferred entry.
> 
> Tested-by: E Shattow <lucent@gmail.com>

