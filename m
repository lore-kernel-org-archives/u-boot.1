Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1202D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 10:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EF580433;
	Mon, 15 Dec 2025 11:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O1HHWIpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D813B8051F; Mon, 15 Dec 2025 11:51:12 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA5880050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 11:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so1137881f8f.1
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 02:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765795869; x=1766400669; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=slpC7qvZn/CCeo9dF8OxehQS2U+i/HvX1j2QLOAyoeM=;
 b=O1HHWIpQa1V5v2DTopnqOs/GG/eVg+/9o50eb7K7hd037uZUK4bzL/mqq0FgG2Fg5r
 a7QhVAMg9L3ZskyP8l5PTzDGMeOx0K9sfiAeRBe61vdVuNJHIAshRkqgD9GWHHj+P6GY
 Or6RaElZmhLpMhUYJXk1Q0afLoU+ixHcE96he9kVZJnrWaD48gwZulCj0cIPQbAsCmaF
 KS5cZuABkmDsIYX09zfRWlSVE1zYFMPaotnUiT1Ex5EZtdv9HL7DdK3mvlUpDAKgurfe
 ayiIXvZkgtmwwb8LWhVji4Wx2FBAFtPNMRiD9Yi8kGnc22f4e23+JQ974fQ4pZyFNHta
 +qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765795869; x=1766400669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=slpC7qvZn/CCeo9dF8OxehQS2U+i/HvX1j2QLOAyoeM=;
 b=tcbD6L5KQ7Yxn/thSMXdlXUAQQXe6t1A/WdfdIbvfjtXNaY2wJjqaFeR5FguFg01xX
 SUT/H85eMX50TFLSTjwUu6bsGCUAFxNOfrEK7Ar+s/a/m/hT3vnMamY0rBdmXjVlfccK
 21+Ju+fe1GHDXVlxZFNa6TOrYEPheOE3E2nuNee6DpocY3ZP//3n/EwTyQdgd/FM7q3Z
 CS10oKsLMM/WteMeo0hw0OJAcGpEMM2HrfvjaBoaMPxxdNDfAamANOA12EpIfziBqSMu
 IUKw4clamyLbRVilnNdv0KunubV+e5m5hNfcqMDz4QwlMeHlJVc6IfbsXU0xxBYKy2L1
 93pQ==
X-Gm-Message-State: AOJu0YyVks2KFPIGs0SQM4Dd4d+pH4Q1T+01xAEOjnQGKITSwqEwiacN
 ZZtndZ9GwQRyG4whz6pTVe/m9EcFrQs5q/Sv6f7lpsXlR6cZ8TVU6bmGDQitccwzkAc=
X-Gm-Gg: AY/fxX4m0/jaRt3OxtGUdYc7I/S5y17xPWPoCFz+eUeq9eP0NdEJ4noLgUyIy71Mp19
 JCbH729cS14XI+WnMQMpR3uRPgUfLJxN9J4CX8Z2SuLyF0mKna/II7ATcFPCQ6d6iU76wzaudAF
 65Vz1404BXFhQQO8d8pjTz5Y7N0ZRInqkFiGt+jrKXRivLkcKUqJGo2EqLpKmkJGWz3/stl+nhw
 qcEajz6WqL+/+cQvYNdEJ2aIHi4xOMMNVyQiIOxNCb/D4YPfuC1cqp0DDRsmXncTiZLXReOQnKO
 mPJwQzwDZ1VS/K/jrC98UvUx88p7Wcqu/tX3zN6eZ2QoxcTjLff5ieNDQ/+3csAPzZSunOcDHO6
 zzOiOy5z2xPJSc4n+LfFLPKrbXx7Xb1a9uSR3PDPW3bhUZlHunQXMW8W+9qCM0S/qoLWEc0QFs2
 tnTXo+L3ZBiHZc1F7oKJo2utJxImQblVU0TCqtCcRKBv2VawO8hvZVhCYtY0Ea4RI=
X-Google-Smtp-Source: AGHT+IGo6PS8ijJsM+VslKkAtuJKPppF7QdWvodmYeVJaWXswXLDM5tm+qA+LgiLk9tO4cR5DUEhZw==
X-Received: by 2002:a05:6000:2287:b0:42b:2fc8:186 with SMTP id
 ffacd0b85a97d-42fb46ee92dmr11432161f8f.46.1765795869218; 
 Mon, 15 Dec 2025 02:51:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:fed:3801:3471:f76:7a83:5241?
 ([2a0a:ef40:fed:3801:3471:f76:7a83:5241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f5f6ede8sm11501026f8f.4.2025.12.15.02.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 02:51:08 -0800 (PST)
Message-ID: <322ef73e-83b6-427e-aac1-8f0214de0de8@linaro.org>
Date: Mon, 15 Dec 2025 10:51:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_selftest: enhance LoadImage test
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20251214110937.136425-1-heinrich.schuchardt@canonical.com>
 <CAC_iWj+dMSBLJF7prZkKmcXYXiXeajRGrQ8a_3SubbH-c7O=Mg@mail.gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <CAC_iWj+dMSBLJF7prZkKmcXYXiXeajRGrQ8a_3SubbH-c7O=Mg@mail.gmail.com>
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

On 15/12/2025 10:45, Ilias Apalodimas wrote:
> On Sun, 14 Dec 2025 at 13:09, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Check that only a file-system installed on a handle for thethe
> 
> Typo here, please fix it on merge. Also can you expand the commit
> message a bit, explaining that load_image will eventually call
> efi_dp_find_obj() catching errors in that?
> 
>> device-patch node immediately preceding the file path node is

And a typo here I think. s/patch/path/

Andrew

>> used for LoadImage().
>>
>> The test can be run with
>>
>>      setenv efi_selftest load image from file
>>      bootefi selftest
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> The addtional test succeeds with current U-Boot but fails
>> after applying
>>
>> [PATCH v2] efi_loader: Trigger capsule updates with automatically generated boot options
>> https://lore.kernel.org/u-boot/20251208151503.1681988-1-ilias.apalodimas@linaro.org/
>> ---
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
>>   lib/efi_selftest/efi_selftest_loadimage.c | 45 +++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/lib/efi_selftest/efi_selftest_loadimage.c b/lib/efi_selftest/efi_selftest_loadimage.c
>> index 24548f1ae63..967eaa58c69 100644
>> --- a/lib/efi_selftest/efi_selftest_loadimage.c
>> +++ b/lib/efi_selftest/efi_selftest_loadimage.c
>> @@ -125,6 +125,44 @@ static struct {
>>          }
>>   };
>>
>> +/* Incorrect file device path */
>> +static struct {
>> +       struct efi_device_path_vendor vendor;
>> +       struct efi_device_path_controller ctrl;
>> +       struct efi_device_path path;
>> +       u16 file[sizeof(FILE_NAME)];
>> +       struct efi_device_path end;
>> +} __packed dp_file2 = {
>> +       .vendor = {
>> +               .dp = {
>> +                       .type = DEVICE_PATH_TYPE_HARDWARE_DEVICE,
>> +                       .sub_type = DEVICE_PATH_SUB_TYPE_VENDOR,
>> +                       .length = sizeof(struct efi_device_path_vendor),
>> +               },
>> +               .guid = EFI_GUID(0x4f9a0ebf, 0xa179, 0x88a6, 0x25, 0x68,
>> +                                0x10, 0x72, 0xb1, 0x93, 0x51, 0x71),
>> +       },
>> +       .ctrl = {
>> +               .dp = {
>> +                       .type = DEVICE_PATH_TYPE_HARDWARE_DEVICE,
>> +                       .sub_type = DEVICE_PATH_SUB_TYPE_CONTROLLER,
>> +                       .length = sizeof(struct efi_device_path_controller),
>> +               },
>> +               .controller_number = 1,
>> +       },
>> +       .path = {
>> +               .type = DEVICE_PATH_TYPE_MEDIA_DEVICE,
>> +               .sub_type = DEVICE_PATH_SUB_TYPE_FILE_PATH,
>> +               .length = sizeof(struct efi_device_path) + sizeof(dp_file.file),
>> +       },
>> +       .file = FILE_NAME,
>> +       .end = {
>> +               .type = DEVICE_PATH_TYPE_END,
>> +               .sub_type = DEVICE_PATH_SUB_TYPE_END,
>> +               .length = sizeof(struct efi_device_path),
>> +       }
>> +};
>> +
>>   /* File system info */
>>   static struct file_system_info priv_file_system_info = {
>>          {
>> @@ -517,6 +555,13 @@ static int execute(void)
>>                  return EFI_ST_FAILURE;
>>          }
>>
>> +       ret = boottime->load_image(false, handle_image, &dp_file2.vendor.dp,
>> +                                  NULL, 0, &handle);
>> +       if (ret == EFI_SUCCESS) {
>> +               efi_st_error("Invalid file path accepted\n");
>> +               return EFI_ST_FAILURE;
>> +       }
>> +
>>          return EFI_ST_SUCCESS;
>>   }
>>
>> --
>> 2.51.0
>>

