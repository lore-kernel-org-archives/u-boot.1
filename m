Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07CCECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A9C88F8F;
	Tue, 10 Sep 2024 11:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i5KfQqty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C60288FA1; Tue, 10 Sep 2024 11:34:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66FE88F90
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cae102702so28331405e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725960888; x=1726565688;
 darn=lists.denx.de; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cFhYW+uQasQPL+BgMIJNbw195u3Hs9NzSHNSDzauB8=;
 b=i5KfQqtyXmhOpcnu0heoa0MhCq7jExpJEho+K56jQMFLWx5nJ4BcZe3fasxMnekhnI
 G3rCkjg8oSVHizKhamm6xxEA25sVbLsVMKS+cYaCL9u2hVJjCuSbzcVhQkhhPB4/0Blz
 y77Ejg+R7Sls+1fpKnTGQpDsEUF10lkfyHVOaqqYTXFQXSKjKwkN5q4wjdI5dcTOj6Ay
 wOoH+mJqDLyEIuEANt035csbsSAmuj8C8td4WMz1CE/mu71z0KRQVHiGtzvqV4RG4EGo
 zbmia/VakzaRg188cqvhuxTXeqew/lFJokuD28C9HFEF5XeEB41SUax0zsQ9TeuylOaW
 4dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960888; x=1726565688;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5cFhYW+uQasQPL+BgMIJNbw195u3Hs9NzSHNSDzauB8=;
 b=k8WZlPxmUnHIbxYs5uFMqOpcAoX9JHm4+3mDv7q+yli6OPUa9ME5CVHAGIJWOEL2eC
 wVX/1uGIlPT7sHwhHkZNKWqkp8+Tw6a1I12xQCiR6lZGVTA55TDuw3CZkeDIywmZtl4w
 CFBsG0xVsEnIGHLDdC/zHysUgnKpZs2Nv1M04JxZk8ljGLi8wvg3knVY3DklX5we2yLh
 QfP3/u4oLkf6ZVYnhk+6SQsdEYsy+7yUo3Y4XjTDt1YA3C2DoeLCC+Kv3FVGSqx5Ko1/
 GIk9F9U9ERPwIOmY+a/iM/9vUTmtrNzVCUqeF4xuH88VEl0dCPKgggLByiJC0+gI2OAU
 Uktg==
X-Gm-Message-State: AOJu0YzxTXBZmVcxbmnhaQW/66kWTKx9U8ardum+88ztmdMzaaRmio79
 sPQz9zvF3h4lN2o31Qd1CdjU6EN79XVvtaC5qifhwoOuUWYsjheC4jc1ndiTwcw=
X-Google-Smtp-Source: AGHT+IEwbWqpt84LfUa6WKCjwEzhJ2mGPja1LWO33NjCnxOxH2Fe1a86FZRtHEynJJMorcYCd6CAYw==
X-Received: by 2002:a05:600c:4e88:b0:426:6876:83bb with SMTP id
 5b1f17b1804b1-42cae73d7eemr66421795e9.17.1725960887501; 
 Tue, 10 Sep 2024 02:34:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:e102:5b46:c66:4ddc?
 ([2a05:6e02:10a5:e010:e102:5b46:c66:4ddc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb2ca95a6sm86906955e9.21.2024.09.10.02.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 02:34:47 -0700 (PDT)
Message-ID: <93c2ad0e-67fb-4f94-992c-c8d47f38dda8@baylibre.com>
Date: Tue, 10 Sep 2024 11:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootstd: android: Add U-Boot version to cmdline
To: Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <87plpb9ats.fsf@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <87plpb9ats.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Le 10/09/2024 à 10:23, Julien Masson a écrit :
> On Tue 10 Sep 2024 at 10:23, Mattijs Korpershoek<mkorpershoek@baylibre.com>  wrote:
>
>> When booting into Android fastbootd (a subset of recovery), the default
>> UI shows the bootloader version in the screen [1].
>> This is done via the ro.bootloader property which should come from the
>> bootloader.
>>
>> Provide the U-Boot version via a kernel commandline argument so that
>> fastbootd can show it properly on the screen.
>>
>> [1]https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/main/fastboot/fastboot.cpp#42
>>
>> Signed-off-by: Mattijs Korpershoek<mkorpershoek@baylibre.com>
>> ---
>>   boot/bootmeth_android.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>> index 6e8d3e615db0..2fb82a5073de 100644
>> --- a/boot/bootmeth_android.c
>> +++ b/boot/bootmeth_android.c
>> @@ -22,6 +22,7 @@
>>   #include <malloc.h>
>>   #include <mapmem.h>
>>   #include <part.h>
>> +#include <version.h>
>>   #include "bootmeth_android.h"
>>   
>>   #define BCB_FIELD_COMMAND_SZ 32
>> @@ -171,6 +172,12 @@ static int configure_serialno(struct bootflow *bflow)
>>   	return bootflow_cmdline_set_arg(bflow, "androidboot.serialno", serialno, false);
>>   }
>>   
>> +static int configure_bootloader_version(struct bootflow *bflow)
>> +{
>> +	return bootflow_cmdline_set_arg(bflow, "androidboot.bootloader",
>> +					PLAIN_VERSION, false);
>> +}
>> +
>>   static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>>   {
>>   	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
>> @@ -267,6 +274,8 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>>   	/* Ignoring return code: setting serial number is not mandatory for booting */
>>   	configure_serialno(bflow);
>>   
>> +	configure_bootloader_version(bflow);
>> +
>>   	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL) {
>>   		ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",
>>   					       "1", false);
>>
>> ---
>> base-commit: 360aaddd9cea8c256f50c576794415cadfb61819
>> change-id: 20240904-bootmeth-bootloader-version-2a2b35fce4cf
>>
>> Best regards,
>> -- 
>> Mattijs Korpershoek<mkorpershoek@baylibre.com>
>>
> Reviewed-by: Julien Masson<jmasson@baylibre.com>

Reviewed-by: Guillaume La Roque<glaroque@baylibre.com>
