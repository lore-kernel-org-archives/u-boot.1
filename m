Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD6AFD377A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF0C83E61;
	Wed, 25 Feb 2026 18:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N1AGO4Ov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333C183DEA; Wed, 25 Feb 2026 18:26:29 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C9A83D77
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D44223FCAF
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772040386;
 bh=SCiOecOIfvoEn3iuNaxWTsiw9HRb4U6Dv4aSZ52KpjI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=N1AGO4OvGRPkFVQt/8AYdamtRMNn3uR+3tFapPOKP2qMNIuBFUIpwidGXmpJowYwf
 q7E5Y8rgODWSPTPm8C9QeVXlbUw4GTGXRmWgMC4ppUpxoV1Fl/QHFFK8T3Yw+4ffc/
 J+r8PCh51YuOAHI1BDy7IluzRkfKKQBP47Yfg4bKd4dycnPDkKouK1ZiJgNFwkHsrf
 D61EFAemGW7mxrAb/PIl944gDggS9As89LKaJNoQ9L21Dpa1YLqtme0Tg+net9Ovlx
 mBoZcCQSYV1RX+m+9jd/VOl3E/8TeGuTfqAeAQlaJbRur9cOkMYHlueiR5tpgU85Aa
 t9wtoUjwK6wVYcfL0IjxQPTqrC0b1IZZo330VXdInswGiKVTBcRa8ZnDxsGrXB0INl
 vGEJSs5GNwJGs8dbLg0e4F5Jjd5IytTPVSYEpeVu2H9/8cklLaF9i/dfB3Z+RvPk7P
 qsHjglD0wO0KaOKI7KXCIPkxi6JdDmVKCEvim1/qHHCtu+VtXBrs036MtboY5/+fDc
 VNA8x9Iqk94GhCn+X/r9ZbbxfYsu6fNxB8bSDlAmB0j0nhmRrnE8GTMcCiyzjAUH5j
 fIRHy1I3SaTtaLE3nIKBS4D6aUfpD9DVh3qqZo3gNJChTE1T6kEa2txt6489osEvfg
 0jXHpZPTs1rm0S/LZYze4DvI=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cd6dfe6so74955e9.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040386; x=1772645186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SCiOecOIfvoEn3iuNaxWTsiw9HRb4U6Dv4aSZ52KpjI=;
 b=KahVdbGGkmK79q9zpl5M+JH2fwlGKa/eocAYYjMd7bDuqwn+3Ti9gIidglMuW1Di2d
 7DnnsjuBVvnz5/Vxl7ZHm0kQuloaveQ/gFxL4wEXOvCtfArEneHCIMc6evo+EJazOX2j
 J9AiHyU6BeiBcFnXhosL0u7dHttWkEer7I4sKDZ4S+4Hfc/OhGly209CgIplPFYEFbkh
 Z8glVedKZCu79OwEpYsv34wXmPdltYvcIuDS4vNPQV3j9RpeMR8Pj5zsLl2H0i975Gxr
 6816AjfDMEOnTHLAyyJ9XWBH9Sw7UFAhAYwePzew6FlLrih9tMyrwtx19neRyJIyBDXh
 7Z4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvBwaU7gqSxmro9nYmZvnVkXeq7umWqF3tFlPRK8KL9jjnueU7NhvpnEJRBa+QgCSEgwsMIpY=@lists.denx.de
X-Gm-Message-State: AOJu0YwkBlBrdgzzEsfwH+u7ZST/9f0hJUWAfHksN5y3Dpj1rIH43JQY
 SoDzYSMUsS1BIGKvWG99CFKmu329f96IOnPBIIW0eVyrlr/lDy8iWBQu7pGZqauj3/pilyhQ2f1
 LwCEtWSGXUaF0b0VJbNslnmDcjv500922eUeWudCkTjuPFL+5Qzp8lBWSvb6N8zQYcJxBlT+A/x
 Tqmhw=
X-Gm-Gg: ATEYQzy0eYKHmmbqg9uJG+N7Vu3+nQODBRBdF5GZRIxVCipF64gqjRX8s0/bA05KTMk
 LR+ukZc2wX6oZKEcKOL/lmLmTID+shVFZQoBAB+ZN4gkwFVFHNQSn+Nn5CgoSkVvNsJ9Yza0hbL
 TFWd0zsOgCrNsXny48n9WTzs5jH/3KGGf47xP5HazS4iVbXMoJwM9Rmsj+l7+61FR2S/kOrxa3N
 Tw4Vrjk2aIleqyTwEHUlcuNZBF/X3pOXIiB9IaG+6jfow0zDk9DmuXL8mBF9usUqwGOFkEW1uiv
 WXBQmz8RHjNgOZ8AWMeUExCppAczoyglfR18ZMXSaW/MIEHBD8GXG3R/4HYXQnVtE2dbYMilLnY
 ChbIdgw4wUE0aCWQxvOXSwX5yKnNqHwp/bSNBjBLMY6rC3XwUjzJ1NzsA1QEn7AMxcqrAagQik6
 TkssfS4J6oE+uS1n6YLlJ9S9ODiY9dPA0BmpFThIed4cDmZLgXERg=
X-Received: by 2002:a05:600c:3e0b:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-483c21a57aemr20215325e9.27.1772040386387; 
 Wed, 25 Feb 2026 09:26:26 -0800 (PST)
X-Received: by 2002:a05:600c:3e0b:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-483c21a57aemr20214895e9.27.1772040385976; 
 Wed, 25 Feb 2026 09:26:25 -0800 (PST)
Received: from [192.168.103.130]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccff00sm16556465e9.25.2026.02.25.09.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 09:26:25 -0800 (PST)
Message-ID: <2e092562-6c0a-46e0-8cd7-5d5226d304a2@canonical.com>
Date: Wed, 25 Feb 2026 18:26:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: exynos: don't imply non-existent CONFIG_KEYBOARD
To: Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, u-boot@lists.denx.de
References: <20260225100023.46116-1-heinrich.schuchardt@canonical.com>
 <20260225143736.GD1593142@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225143736.GD1593142@bill-the-cat>
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

On 2/25/26 15:37, Tom Rini wrote:
> On Wed, Feb 25, 2026 at 11:00:23AM +0100, Heinrich Schuchardt wrote:
> 
>> Symbol CONFIG_KEYBOARD does not exist.
>> Don't imply it.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/arm/mach-exynos/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index b084b7284aa..06448e875ef 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -34,7 +34,6 @@ config ARCH_EXYNOS5
>>   	imply CMD_HASH
>>   	imply CRC32_VERIFY
>>   	imply HASH_VERIFY
>> -	imply KEYBOARD
>>   	imply USB_ETHER_ASIX
>>   	imply USB_ETHER_RTL8152
>>   	imply USB_ETHER_SMSC95XX
> 
> Should this be DM_KEYBOARD ? I'm not sure about USB_KEYBOARD instead,
> but it looks like USB_KEYBOARD should be a depends on, not selects
> DM_KEYBOARD, too.
> 

ARCH_EXYNOS5 depends on ARCH_EXYNOS.
ARCH_EXYNOS selects DM_KEYBOARD.

As DM_KEYBOARD is always selected for ARCH_EXYNOS5 we should be fine 
with the patch as is.

odroid_defconfig has ARCH_EXYNOS5 but does not enable any keyboard:

.config:198:CONFIG_ARCH_EXYNOS5=y
.config:1218:CONFIG_DM_KEYBOARD=y
.config:1219:# CONFIG_APPLE_SPI_KEYB is not set
.config:1220:# CONFIG_BUTTON_KEYBOARD is not set
.config:1221:# CONFIG_CROS_EC_KEYB is not set
.config:1222:# CONFIG_I8042_KEYB is not set
.config:1663:# CONFIG_USB_KEYBOARD is not set

As the board has no video, adding a USB keyboard would not be helpful.

.config:1682 # CONFIG_VIDEO is not set

Best regards

Heinrich
