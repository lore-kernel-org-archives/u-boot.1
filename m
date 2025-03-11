Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACF3C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9C6807D9;
	Tue, 11 Mar 2025 14:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nJqB8ci2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CF681197; Tue, 11 Mar 2025 14:37:19 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E550F8003E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 16D473F167
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741700236;
 bh=Etm9/xjkVYpnqenW65zDsJmra7ix0TzQfqcL1cpjjjc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=nJqB8ci2S77PApChsaUqm6EsqDd69i+n4R/cfG6OAOanOUNipZ8x9oXTzA6hg7q7Y
 A8p76WXl8Stek713vUqu8KRiKIrnr1ZcuVYMXY83H9ca8iq4Bl/AIl4H7AbagDlO2I
 yf6mPV52dtVH51rFfCS72U8420nA7fdUOrKW/RF/fd9o94mJYKqcl8z/4TTZoeTCEN
 f+RyHoMI/H8fsvxZZELkuXNYLV8TQGCc9FjLSDTshwYwf9FMj0s7EvleVQOmUErC6H
 4q4ZTHSd5E5iHMYJRvwLwldXFijCpyz9bhYaC9YFKyEAreFRndXhZHJM87iu5uLzCW
 BjPsDL0sysVMA==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39123912ff0so2427742f8f.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700235; x=1742305035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Etm9/xjkVYpnqenW65zDsJmra7ix0TzQfqcL1cpjjjc=;
 b=iCorJnIUgKhuRYAOvUdiX4wwOWSlk1zO1WwMXyYsSijWIKUXCGnY6BSK+WuXVAgKfI
 6/VCFqwtb/JQGYbzBdhwe+aqQ2JAjkcceagPflp6tlwRmL5KRIrGkqQTBnVlKSLddHQH
 OpvGNIgdAoJ2aDXN+qtUXtB3eHuTfnABLhzLcaHzuTNZmTZAp/BJn71auYP3G5rJ/7ig
 Ncs2RufdUU3fRcuKsPqNIW91MMHXwa2OyTRWM17vO0EeoozJ14sn9K6ro18OjZSR0mqC
 4j81SnItUwHo1WiiJKr1atYlicY6EEPJ3c35IDQLFhEO/aBotYX+G0wJWTDyVUe8IRtI
 v52A==
X-Gm-Message-State: AOJu0YyM9TLeWX6BHUzIFuphv2KDCte0W4sbdERa7H2WUppJobBjM9oz
 N/DK5w04SfaX2Rb+CsQwwYwt3RLlrYGm3wzM4XD4jLy/OPHezyhbJcTMWKYm1iKnz4NNr5ffeeE
 e24w7j0Alj+kKH2MVjsy2zwAUgglErVUegDI+F0s4kBH+cENAWlfzQRXFurCiIbwN1DM=
X-Gm-Gg: ASbGncsePO5SmZ77Zup64tGwWbl3w+6hBbczxH9ocEu15PVitkmHNzgtWkBjAhVAJBm
 qEJ7+UiA1/0A4BdeBYnEnBsOaZu6WM4ax78A73LOi+KqOa/ZlDvWNwch0Xn8e/y9Y0QUB26pxDO
 Cf9L3je8j3DzkyJNL7Q21tLV+Y8smfDAq1PnBlk8t/JRGiMCFmQtNxszu6Nqa5mXZ7i8SVpOIWm
 4hBg52yTdMNixcU+ohemiK8iAVNXBHL1EFn9JVy/at0dk0eRktR/rEOSeLt0WXZNdYB6dL5xMUb
 3hiTKRLAhE74SXH+RWFuS6qFk5HIaFyO20xPKDSPf2LVB/cgyKHFIHFlGFDQqtaSR0KQ9j4vvbm
 o4GFmuW242kAE
X-Received: by 2002:a05:6000:1aca:b0:390:f738:246b with SMTP id
 ffacd0b85a97d-39132d1cc3fmr14404454f8f.15.1741700234939; 
 Tue, 11 Mar 2025 06:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFZG1g96fdIMJEMdD9xraCvBWHJ2k2umK1/zv61qwyvFqB4czLbn5eZs6r9FUSpPz0Y0347A==
X-Received: by 2002:a05:6000:1aca:b0:390:f738:246b with SMTP id
 ffacd0b85a97d-39132d1cc3fmr14404421f8f.15.1741700234578; 
 Tue, 11 Mar 2025 06:37:14 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1037b4sm18290075f8f.92.2025.03.11.06.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 06:37:13 -0700 (PDT)
Message-ID: <52d6c43b-1f08-4c0e-9bdc-8e7d492ef545@canonical.com>
Date: Tue, 11 Mar 2025 14:37:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] efi_loader: remove unused code from copy_fdt()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250310115750.1019051-1-sughosh.ganu@linaro.org>
 <20250310115750.1019051-2-sughosh.ganu@linaro.org>
 <CAC_iWjLiufizRnkEYoKXF9kpC1pPzknz5EbsJ50fpE1Bn7YrYw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjLiufizRnkEYoKXF9kpC1pPzknz5EbsJ50fpE1Bn7YrYw@mail.gmail.com>
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

On 11.03.25 14:21, Ilias Apalodimas wrote:
> Heinrich, do you remember why this was originally here?
>   I looked at 6422820ac3e59 which moved that code around, but the same
> code was there as well
> 
> On Mon, 10 Mar 2025 at 13:58, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>>
>> There is logic in the copy_fdt() function which is iterating over the
>> platform's DRAM banks and setting the fdt_ram_start variable. However,
>> this variable is not used subsequently in the function. Remove this
>> superfluous code.
>>
>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> ---
>> Changes since V6: New patch
>>
>>   lib/efi_loader/efi_helper.c | 14 +-------------
>>   1 file changed, 1 insertion(+), 13 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
>> index 04b2efc4a3b..15ad042bc61 100644
>> --- a/lib/efi_loader/efi_helper.c
>> +++ b/lib/efi_loader/efi_helper.c
>> @@ -454,23 +454,11 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle,
>>    */
>>   static efi_status_t copy_fdt(void **fdtp)
>>   {
>> -       unsigned long fdt_ram_start = -1L, fdt_pages;
>> +       unsigned long fdt_pages;
>>          efi_status_t ret = 0;
>>          void *fdt, *new_fdt;
>>          u64 new_fdt_addr;
>>          uint fdt_size;
>> -       int i;
>> -
>> -       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>> -               u64 ram_start = gd->bd->bi_dram[i].start;
>> -               u64 ram_size = gd->bd->bi_dram[i].size;
>> -
>> -               if (!ram_size)
>> -                       continue;
>> -
>> -               if (ram_start < fdt_ram_start)
>> -                       fdt_ram_start = ram_start;
>> -       }

The removed code was introduced by Alex in 2016 with patch
ad0c1a3d2cea ("efi_loader: Put fdt into convenient location").

Writing the device-tree at the start of RAM may have worked for some 
boards at the time but on many others this would be inside reserved memory.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

>>
>>          /*
>>           * Give us at least 12 KiB of breathing room in case the device tree
>> --
>> 2.34.1
>>
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

