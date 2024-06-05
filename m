Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A689C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 12:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7490688361;
	Wed,  5 Jun 2024 14:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dSEh5fzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EA788354; Wed,  5 Jun 2024 14:22:39 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A9181F9A
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 14:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57a4d7ba501so2277188a12.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 05:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717590156; x=1718194956; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tvfKxh1NAixOZ2tvaLePgKMmMXnQc3Czoj4pD83sQb4=;
 b=dSEh5fzzTWMR9ksOru82uFLo8AbK2xuaH8fXV18tXF15qJIe1rjp5IxYPpwNkQanf9
 TqdBlaBCqGB6+VNEGrMKZ1D+kbGIHsEr4Uys6RFG0iLbzJJKIcBR7C4P+1xvFlTIUxe1
 8BnFpRImCQOD+mULeMqpxwKHrnU/7C74OFQ+AnFtuzs1QjnnB8TwyHzi4qNSv2YN39bT
 mleKvPdmDXhYD5fKhlk3iDR/ewzm55Eg3LWmAlSPijxgMFazFC/2QJPFUe8vZYIS6SPI
 Ts3ufbBogTKHqUg7+kv3ZyqSC1SOrHE2aGfpig6/mJhijkLtmeIi6H5L+PL4vAcL9IxN
 6yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717590156; x=1718194956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tvfKxh1NAixOZ2tvaLePgKMmMXnQc3Czoj4pD83sQb4=;
 b=UMrhz+JUcjUJ+oQ7C83/AJg6wzU8D3FHYXzpfc7zs9EOmkt+S38VZjHM2T4any8H06
 ohlBMA+OvYtJnwt12wd4/XoA8PWfnYk4x0UOSeWWHi+ICqnjOLJ3sBnkmqdOxE8k8JyQ
 nC7xFISEjVMFtm95JBYAkFclhQIbeQW5vOdGKulR2vhfiz1oLldMJM1HqB1cLEwyHduB
 7clZjERCa/bVk51wkAnVdnb32oEZxHqRWHGaR1f3ODdpR3ZkYK1ILmqHodKDpF6u/dtR
 7iCA4ZN/mqDCb2M5Qh0lQJcfP/R2u7rciWyog98A5J0boTFmPvTxdmgjxaN7M0xikPEs
 nXeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcHRs6vnxSZZ2KvOGspipgxDhSAXGXyiCyyxodAeN9MGAOwLJrh5xkAjr+/eT3qJkis6EqIL4JZlz23AyVA7NSHv/1jA==
X-Gm-Message-State: AOJu0YyXyikDM3rjKHQiTfreoQBv7TnlMDIpFhT5BkP1ybNGEK/NrKL0
 mZeuTLrqovzffMzY9FyLGFAUp9ejGq4aybs0oxUaYFQRcyES0RHeX6jD/pi2y2c=
X-Google-Smtp-Source: AGHT+IGy0rTVSoYRB8nPNayJs708y2XXUIE3PgGPveoBGQr4jlANR6msaonohU7VTJ3XygCJ2RRezg==
X-Received: by 2002:a50:cd55:0:b0:57a:33a5:9b78 with SMTP id
 4fb4d7f45d1cf-57a8b7c6234mr1429310a12.34.1717590155864; 
 Wed, 05 Jun 2024 05:22:35 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a66ed0d68sm5041009a12.63.2024.06.05.05.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 05:22:34 -0700 (PDT)
Message-ID: <3588d5a6-5446-450e-91c2-251dd139dfaf@linaro.org>
Date: Wed, 5 Jun 2024 14:22:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] efi: add a helper to generate dynamic UUIDs
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-2-ca4a4865db00@linaro.org>
 <54c1e53b-a6a0-410c-b6de-ac9f7a492f76@gmx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <54c1e53b-a6a0-410c-b6de-ac9f7a492f76@gmx.de>
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



On 05/06/2024 07:52, Heinrich Schuchardt wrote:
> On 5/31/24 15:50, Caleb Connolly wrote:
>> Introduce a new helper efi_capsule_update_info_gen_ids() which populates
>> the capsule update fw images image_type_id field. This allows for
>> determinstic UUIDs to be used that can scale to a large number of
>> different boards and board variants without the need to maintain a big
>> list.
>>
>> We call this from efi_fill_image_desc_array() to populate the UUIDs
>> lazily on-demand.
>>
>> This is behind an additional config option as it depends on V5 UUIDs and
>> the SHA1 implementation.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   lib/efi_loader/Kconfig        | 23 +++++++++++++++
>>   lib/efi_loader/efi_capsule.c  |  1 +
>>   lib/efi_loader/efi_firmware.c | 66 
>> +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 90 insertions(+)
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 430bb7f0f7dc..e90caf4f8e14 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -235,8 +235,31 @@ config EFI_CAPSULE_ON_DISK_EARLY
>>         If this option is enabled, capsules will be enforced to be
>>         executed as part of U-Boot initialisation so that they will
>>         surely take place whatever is set to distro_bootcmd.
>>
>> +config EFI_CAPSULE_DYNAMIC_UUIDS
>> +    bool "Dynamic UUIDs for capsules"
>> +    depends on EFI_HAVE_CAPSULE_SUPPORT
>> +    select UUID_GEN_V5
> 
> This select will create a build error if CONFIG_SHA1=n as
> CONFIG_UUID_GEN_V5 depends on it.

Ack
> 
>> +    help
>> +      Select this option if you want to use dynamically generated v5
>> +      UUIDs for your board. To make use of this feature, your board
>> +      code should call efi_capsule_update_info_gen_ids() with a seed
>> +      UUID to generate the image_type_id field for each fw_image.
>> +
>> +      The CapsuleUpdate payloads are expected to generate matching UUIDs
>> +      using the same scheme.
>> +
>> +config EFI_CAPSULE_NAMESPACE_UUID
>> +    string "Namespace UUID for dynamic UUIDs"
>> +    depends on EFI_CAPSULE_DYNAMIC_UUIDS
>> +    help
>> +      Define the namespace or "salt" UUID used to generate the per-image
>> +      UUIDs. This should be a UUID in the standard 8-4-4-4-12 format.
> 
> As UUIDs can be formatted low-endian or big-endian I would not know how
> the value will be interpreted.

Arguably it doesn't matter, it's just salt which is roughly UUID shaped :D
> 
> Why do we need a vendor specific name-space if we are using compatible
> strings which are vendor specific themselves?

If vendor A and vendor B both build embedded products based on a 
Qualcomm RB2 (for example), they might both use the same DTB but 
customise other parts of U-Boot. We want them both to be able to use 
LVFS to provide updates, so they need a way to avoid conflicting UUIDs.

I think requiring them to use a custom compatible might be a bit 
arbitrary, especially if they aren't using any custom hardware.
> 
>> +
>> +      Device vendors are expected to generate their own namespace UUID
>> +      to avoid conflicts with existing products.
>> +
>>   config EFI_CAPSULE_FIRMWARE
>>       bool
>>
>>   config EFI_CAPSULE_FIRMWARE_MANAGEMENT
>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
>> index 0937800e588f..ac02e79ae7d8 100644
>> --- a/lib/efi_loader/efi_capsule.c
>> +++ b/lib/efi_loader/efi_capsule.c
>> @@ -19,8 +19,9 @@
>>   #include <mapmem.h>
>>   #include <sort.h>
>>   #include <sysreset.h>
>>   #include <asm/global_data.h>
>> +#include <uuid.h>
>>
>>   #include <crypto/pkcs7.h>
>>   #include <crypto/pkcs7_parser.h>
>>   #include <linux/err.h>
>> diff --git a/lib/efi_loader/efi_firmware.c 
>> b/lib/efi_loader/efi_firmware.c
>> index ba5aba098c0f..a8dafe4f01a5 100644
>> --- a/lib/efi_loader/efi_firmware.c
>> +++ b/lib/efi_loader/efi_firmware.c
>> @@ -244,8 +244,71 @@ void efi_firmware_fill_version_info(struct 
>> efi_firmware_image_descriptor *image_
>>
>>       free(var_state);
>>   }
>>
>> +#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
>> +/**
>> + * efi_capsule_update_info_gen_ids - generate GUIDs for the images
>> + *
>> + * Generate the image_type_id for each image in the 
>> update_info.images array
>> + * using the first compatible from the device tree and a salt
>> + * UUID defined at build time.
>> + *
>> + * Returns:        status code
>> + */
>> +static efi_status_t efi_capsule_update_info_gen_ids(void)
>> +{
>> +    int ret, i;
>> +    struct uuid namespace;
>> +    const char *compatible; /* Full array including null bytes */
>> +    struct efi_fw_image *fw_array;
>> +
>> +    fw_array = update_info.images;
>> +    /* Check if we need to run (there are images and we didn't 
>> already generate their IDs) */
>> +    if (!update_info.num_images ||
>> +        memchr_inv(&fw_array[0].image_type_id, 0, 
>> sizeof(fw_array[0].image_type_id)))
>> +        return EFI_SUCCESS;
>> +
>> +    ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_UUID,
>> +            (unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
>> +    if (ret) {
>> +        log_debug("%s: CONFIG_EFI_CAPSULE_NAMESPACE_UUID is invalid: 
>> %d\n", __func__, ret);
>> +        return EFI_UNSUPPORTED;
>> +    }
> 
> You don't want end-users to be the first to find this issue. This must
> be a build time check.

Simply boot testing a production build should hit this error path... But 
sure a built time check would be better. Could you suggest how I might 
do this? Can we have host tools that are used during build? Where abouts 
should I add this?
> 
>> +
>> +    compatible = ofnode_read_string(ofnode_root(), "compatible");
>> +
>> +    if (!compatible) {
>> +        log_debug("%s: model or compatible not defined\n", __func__);
> 
> You are not reading model here.

Ah yeah.
> 
>> +        return EFI_UNSUPPORTED;
>> +    }
>> +
>> +    if (!update_info.num_images) {
>> +        log_debug("%s: no fw_images, make sure update_info.num_images 
>> is set\n", __func__);
> 
> I thought we were using capsules without images in A/B updates and need
> to process them?

I'm not sure I understand. This is just a sanity check, though it's 
actually duplicated above and this one should be dropped (it's a 
holdover from a previous version of this patch).
> 
>> +        return -ENODATA;
>> +    }
>> +
>> +    for (i = 0; i < update_info.num_images; i++) {
>> +        gen_uuid_v5(&namespace,
>> +                (struct uuid *)&fw_array[i].image_type_id,
>> +                compatible, strlen(compatible),
>> +                fw_array[i].fw_name, u16_strsize(fw_array[i].fw_name)
>> +                - sizeof(uint16_t),
>> +                NULL);
>> +
>> +        log_debug("Image %ls UUID %pUs\n", fw_array[i].fw_name,
>> +              &fw_array[i].image_type_id);
>> +    }
>> +
>> +    return EFI_SUCCESS;
>> +}
>> +#else
>> +static efi_status_t efi_capsule_update_info_gen_ids(void)
>> +{
>> +    return EFI_SUCCESS;
> 
> Why should we have a case were we don't generate the image UUIDs?
> Don't we get rid of capsule GUIDs in the device-trees?

Many boards have hardcoded GUIDs, which may or may not be in used. So we 
can't just break them all by migrating them over. This will have to be 
done incrementally by device maintainers.
> 
> Best regards
> 
> Heinrich
> 
>> +}
>> +#endif
>> +
>>   /**
>>    * efi_fill_image_desc_array - populate image descriptor array
>>    * @image_info_size:        Size of @image_info
>>    * @image_info:            Image information
>> @@ -282,8 +345,11 @@ static efi_status_t efi_fill_image_desc_array(
>>           return EFI_BUFFER_TOO_SMALL;
>>       }
>>       *image_info_size = total_size;
>>
>> +    if (efi_capsule_update_info_gen_ids() != EFI_SUCCESS)
>> +        return EFI_UNSUPPORTED;
>> +
>>       fw_array = update_info.images;
>>       *descriptor_count = update_info.num_images;
>>       *descriptor_version = EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
>>       *descriptor_size = sizeof(*image_info);
>>
> 

Kind regards,

-- 
// Caleb (they/them)
