Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7873ECDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 04:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6383386D80;
	Thu, 12 Oct 2023 06:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kUVEOUuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D534886D41; Thu, 12 Oct 2023 06:28:28 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7989286DC4
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 06:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d13ac2796so1827006d6.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084904; x=1697689704; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aqgAY+S9AJ5ku5GPqXteCPUi2MjOo/5/OkoAeKKmdxY=;
 b=kUVEOUuQcJxy7LH4a2df6Pn4LUTpUFYrsXx+KKt4/tuiNpg/FBS70TlGgq9qGlMkCQ
 ba+7RKjqhDkhA92B8UBSsS1qCobRWTddZwRH8bhBNYTanhnrVe4BQRv2HdbNL8LiPYEt
 1EJAR+q9n9w3YlFgTsSdUex1LCrhWTUJJMTqIcKF4x5NJyNINlJOzozv9WMSsTNWGfga
 4y9l3IFjSzIeJBZGW19vkAe4bwisg44u23X4bYt0ImrpwRDKherIyTJ2OkNz1xRWhxJK
 ypeDGCGiiiWae9Y9eG6OhWCka1ku+xJfWSZU75uQXnwrzo4sQyZ4z/JqXDA9ggJnRrf9
 HNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084904; x=1697689704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aqgAY+S9AJ5ku5GPqXteCPUi2MjOo/5/OkoAeKKmdxY=;
 b=k3VhOmXBr+qFDCPkyacGVKPcyjOcOCnCDA72FJZUuYWjb1+18Dmhgc3/UPpqrEcS6G
 a6xX54p5sKvfpE9ai338Rm1pLzSkb5DJYlp3Tlg0i746L1tjcEPgw1q2ji4JFW4ywiOh
 cAaK9Jc9Kv+6yIXYZZCGaLFFizvOiwxWNDm2CSYMqxdJWW5HqQ9UgYnWhkIF+PCEPjWj
 hmgBxE9LUokjelwh4jHBWONqcWNbIKYvWK2pDCRe9zAGwRpiReS7Mfv/Uv2371dm+fYX
 kWjZL1+2rrnu/YylYuQOrnkO+yPF3NjksLfjLooit2BWdDaOLGoxZCi0xx8GR1yp8DMn
 +SRA==
X-Gm-Message-State: AOJu0YxfOVG2Axj1C+QSMZEeHtqfanQdZBasusUzekXFmpYWG6BqKWS4
 iR45SumYvQTsZCyexjv0Aqo=
X-Google-Smtp-Source: AGHT+IESvoGqMNU2wPAbvzkrrmC7QDmoXOD6+8nWp7Qdp89T3Au/oAOMpp6/7tivgcwiOWCU1SiJCw==
X-Received: by 2002:a05:6214:398a:b0:656:4a21:2c5a with SMTP id
 ny10-20020a056214398a00b006564a212c5amr23796689qvb.9.1697084903750; 
 Wed, 11 Oct 2023 21:28:23 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 a14-20020a0cca8e000000b00655e4f57732sm6223802qvk.35.2023.10.11.21.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:28:23 -0700 (PDT)
Message-ID: <96125bdb-8363-62a6-1702-53b4bb63dea2@gmail.com>
Date: Thu, 12 Oct 2023 00:28:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/26] spl: fit: Fix entry point for SPL_LOAD_FIT_FULL
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marex@denx.de>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-4-seanga2@gmail.com>
 <CAPnjgZ2RWZZbQMfF9_KUN+FsoVGoHKPq_sJ9=1GorNkrftwmbA@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ2RWZZbQMfF9_KUN+FsoVGoHKPq_sJ9=1GorNkrftwmbA@mail.gmail.com>
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

On 10/11/23 23:41, Simon Glass wrote:
> On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> The entry point is not always the same as the load address. Use the value
>> of the entrypoint property if it exists and is nonzero (following the
>> example of spl_load_simple_fit).
>>
>> Fixes: 8a9dc16e4d0 ("spl: Add full fitImage support")
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   common/spl/spl_fit.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> The check for 0 makes me uneasy, but I can't imagine it being valid in practice.

This is mostly to match spl_load_simple_fit:

	/*
	 * If a platform does not provide CONFIG_SYS_UBOOT_START, U-Boot's
	 * Makefile will set it to 0 and it will end up as the entry point
	 * here. What it actually means is: use the load address.
	 */

SYS_UBOOT_START doesn't seem to be set very often and defaults to TEXT_BASE. That
appears to be undefined on

	efi-x86_app64 efi-x86_app32 xtfpga 3c120 10m50

but none of these platforms define SPL_LOAD_FIT. So maybe this is moot?

--Sean

> 
>>
>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>> index ce6b8aa370a..e3cdf8e5c05 100644
>> --- a/common/spl/spl_fit.c
>> +++ b/common/spl/spl_fit.c
>> @@ -884,8 +884,10 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
>>                  return ret;
>>
>>          spl_image->size = fw_len;
>> -       spl_image->entry_point = fw_data;
>>          spl_image->load_addr = fw_data;
>> +       if (fit_image_get_entry(header, ret, &spl_image->entry_point) ||
>> +           !spl_image->entry_point)
>> +               spl_image->entry_point = fw_data;
>>          if (fit_image_get_os(header, ret, &spl_image->os))
>>                  spl_image->os = IH_OS_INVALID;
>>          spl_image->name = genimg_get_os_name(spl_image->os);
>> --
>> 2.37.1
>>

