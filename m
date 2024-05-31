Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ED1C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 11:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1A78831F;
	Fri, 31 May 2024 13:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d23+E3eE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEA888735; Fri, 31 May 2024 13:26:45 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102CD87F33
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 13:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57a23997da3so1788104a12.3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 04:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717154802; x=1717759602; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4na6akkByxgCxfZIdrVp8ZL37eo0gOEgcl/k+zGGPMs=;
 b=d23+E3eEwnsA3/3ZOtvvJJn7hBXxjAF2KQXXX6hGViyj0svO3JILU0Mv9lyHNfUzLR
 Ub3Arxe+5LwuHsNgPFgY0+N8v1RzTwrBk6KZzzkdcKj/rGUuTt5BJZw6u1z+VNxtS018
 BztvEWKREGAXEd3TcHqQUEw74WTyOMOPBR82V0xsKjRoyWYalpS/0ikWLYtmqTlxCUl1
 GJFXOI9qOWj8j45uMj2ppN/LqZNSA7wBwO34Knrk3MoN+6r5qrp63rzPJBRXvg05PFCn
 odzZXoHAq/3CM6/ezrlwLTHddageTtYi18zcKn0T8dPC5+kWXi7z7a8kScYJdSPDJyvH
 MXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717154802; x=1717759602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4na6akkByxgCxfZIdrVp8ZL37eo0gOEgcl/k+zGGPMs=;
 b=gXZ8QvqELrbg1aNYmrr/xcAAZTlhnWMijcqstyUvaGgRGqwBx07MWwNtbMic7nyFQo
 SAFhr98x2OqoGpzHf+yBo3eM6ppYV/6IPUDCS6fMTMnMvNuOITr0m65lGxSsOOvzKaUk
 2cBznyNQBkWGMoBLaU2FMQ89roU2Ih6dRU9rsTID/I+htSRIiAEaPbUAoQSAs45aslEF
 BrzQVBNk55g/5sfgcnflGSLlh31FL6BHzkEWQhdoIjaKpJw3QseNozTLT4XR8ugEK7uE
 ShRMCXzCM4L8DJqtqZe9iYl6mtJGUfiVSv52PBj91wPdbhojblRfmBIwbjdeCeo39hBn
 vEFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa97vN8qcpr6sSu8dFvNQUvJGLZxPlS7CC6pj7Nap/BCFIlYl9YRireVPRBww9Jc9A6bMUAz95hxJL9d2Y0Eurm4Qbzw==
X-Gm-Message-State: AOJu0YzJY32ldnBTG8s8GW+uKl6wq06iSffIugm93RiuAtEa+DCdC8Cm
 KzgwRK+8/J7P5/mlr5FKrvAoPdDsW1TsLTIfxo8QcvOi/PZtx4fmjsyv/kLwoBA=
X-Google-Smtp-Source: AGHT+IHu83s8vgIophycFUrD4QV9bj1RYi2ndxtoOx/Ovsf9kKkw7/Uo/VX0iasWRYo/W7rE0DXYvA==
X-Received: by 2002:a17:906:63d1:b0:a59:aa69:9791 with SMTP id
 a640c23a62f3a-a68208fe2ecmr103754766b.34.1717154802328; 
 Fri, 31 May 2024 04:26:42 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab85c42sm75728166b.163.2024.05.31.04.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 04:26:41 -0700 (PDT)
Message-ID: <ff49dafd-4550-4680-a4f0-b1808718dd51@linaro.org>
Date: Fri, 31 May 2024 13:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] efi: add a helper to generate dynamic UUIDs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-2-c26f31057bbe@linaro.org>
 <CAC_iWjK_3ZFzeFN-Ej-OAhB8EDzkywy11j6dL3qNhAELz8r79g@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAC_iWjK_3ZFzeFN-Ej-OAhB8EDzkywy11j6dL3qNhAELz8r79g@mail.gmail.com>
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



On 30/05/2024 16:56, Ilias Apalodimas wrote:
> Hi Caleb,

Hi Ilias,
> 
> [...]
> 
>>
>>   #include <crypto/pkcs7.h>
>>   #include <crypto/pkcs7_parser.h>
>>   #include <linux/err.h>
>> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
>> index ba5aba098c0f..a8dafe4f01a5 100644
>> --- a/lib/efi_loader/efi_firmware.c
>> +++ b/lib/efi_loader/efi_firmware.c
>> @@ -244,8 +244,71 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
>>
>>          free(var_state);
>>   }
>>
>> +#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
>> +/**
>> + * efi_capsule_update_info_gen_ids - generate GUIDs for the images
>> + *
>> + * Generate the image_type_id for each image in the update_info.images array
>> + * using the first compatible from the device tree and a salt
>> + * UUID defined at build time.
>> + *
>> + * Returns:            status code
>> + */
>> +static efi_status_t efi_capsule_update_info_gen_ids(void)
>> +{
>> +       int ret, i;
>> +       struct uuid namespace;
>> +       const char *compatible; /* Full array including null bytes */
>> +       struct efi_fw_image *fw_array;
>> +
>> +       fw_array = update_info.images;
>> +       /* Check if we need to run (there are images and we didn't already generate their IDs) */
>> +       if (!update_info.num_images ||
>> +           memchr_inv(&fw_array[0].image_type_id, 0, sizeof(fw_array[0].image_type_id)))
> 
> Why not just go a guidcmp()? memchr_inv() will return the first
> invalid match, but we don't need that

guidcmp() would require allocating a zero guid to compare to, this is 
just a check for any non-zero byte in the GUID so memchr_inv() seemed 
more fitting.

I can switch to guidcmp() for readability.
> 
>> +               return EFI_SUCCESS;
>> +
>> +       ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_UUID,
>> +                       (unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
>> +       if (ret) {
>> +               log_debug("%s: CONFIG_EFI_CAPSULE_NAMESPACE_UUID is invalid: %d\n", __func__, ret);
>> +               return EFI_UNSUPPORTED;
>> +       }
>> +
>> +       compatible = ofnode_read_string(ofnode_root(), "compatible");
>> +
>> +       if (!compatible) {
>> +               log_debug("%s: model or compatible not defined\n", __func__);
>> +               return EFI_UNSUPPORTED;
>> +       }
>> +
>> +       if (!update_info.num_images) {
>> +               log_debug("%s: no fw_images, make sure update_info.num_images is set\n", __func__);
>> +               return -ENODATA;
>> +       }
> 
> [...]
> 
> Cheers
> /Ilias

-- 
// Caleb (they/them)
