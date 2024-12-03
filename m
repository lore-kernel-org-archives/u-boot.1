Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E7E64AA6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30938961F;
	Tue,  3 Dec 2024 14:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bQYZ8aXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469DD89651; Tue,  3 Dec 2024 14:52:51 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4343889328
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ffc1009a06so81804341fa.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733233965; x=1733838765; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uqgR80OyjNhhkrJ05jglLjbHxVwvrr4+lTxqFk79oZQ=;
 b=bQYZ8aXA72CCgBIa/66C3qL/5rX4ojFI3RL/JD1/st5HYcSUsDQCaEFF+b/dN8/d6J
 u90ngjS3p9TtAvKLRYzRV6Bk5MaMJZnyEa7I+m+aQ8RK/CdoRUZi4x1RRH/6vgC4QU+y
 lm8rT2/p8oRVO9jn/eo2xpcFJ18rWzuCjRWqE2zk8CloHOCBAirKujef42CqliRHgU8T
 HiyoPhyyyfRlA5eBkIRY+r10ZFMKvB+osYlJMtv4HCf16bwePMdPxKxygQc4l1lwuUgm
 IDNGTdXj+81XwrHobp/y7MPuoYVo5PCTtE8Dpnl9WiIk9QG5xa+ZDmwoIoNtbVWk+YWm
 g9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233965; x=1733838765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uqgR80OyjNhhkrJ05jglLjbHxVwvrr4+lTxqFk79oZQ=;
 b=Sr/TVVQ9fCoCMQlxMBUemALNERn/Z68WiDUQ8gWlUMxqUG90AWZyeXJ9IAdaklhOYa
 NbSWrkBrf9fh88c13pKSBZcCXWJv+cllTQfIID0AKslYMeNTWphtmanEdFX8VryD9leJ
 Vidqq3zIpyyVNATzhrEtreKJ+icOfuqCm3hzPe1FpOWGj/6aoK9ni8kQd4dxVt2jD7Cx
 6/BamKwYHzDjoq/ouDIh8IyZidrykC7jsM8SMtanTpvqX/lBXywxQeHWtIEFWaSZX/0H
 VDQkdNaaVU4/0WAXqnW7N/PjC9s5g6kuTL9ZCmstqkqbjUInF+f48g1BfZEZslz8YgGE
 Z5qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8oTVFKuNWDIgMhqHNflPqnGKO3wkSn70vGwfXM80PF8B0cFprShPwJRx+zKdoJBXSEfdzBxU=@lists.denx.de
X-Gm-Message-State: AOJu0YyfFqQUhElelp2nF7U6RC9oI4Ig5+JojHhNK3TTBKJKQjnPlxTA
 hS7NWj4zS0gczhWRyD+JkP9Pv8OzFH4VzuXmhpE4R/A5gs4yW71ySciiUvIIcrQ=
X-Gm-Gg: ASbGncsHgieNrOW9L3pOg+Jw2fo7ICU3vYUE1lf719vGD1XYvnHCIR9KJpCyTHCI4XX
 h5eTjlV9s9sPEfOj412n11x6sjoV7yhaX0rvcUlvXYkjtW9ZLX3jWKQm0rbpP2DFUZyb9FmOWyJ
 op5kwKFlv/sWqw4EgxLRcTLhLaLx5imD4i5Y/mLpNEtUm0LWcYqIrLxrEn47IRLwnrE7n1S+sGK
 31vgD8VFlnUtM2LUST8+2o81E6il6TtT+DZXs8H5QasF9cKeBmxAn5VGW9bCA==
X-Google-Smtp-Source: AGHT+IEM0c0E7gnYbQGulIqz1oiI7u6E86kfLgsN5ORCPKWTA/4XrOAfG24xl9yb8UTA6t0OI9M3mA==
X-Received: by 2002:a2e:b88f:0:b0:2ff:d044:61fc with SMTP id
 38308e7fff4ca-30009d028d3mr30037491fa.33.1733233965488; 
 Tue, 03 Dec 2024 05:52:45 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599905164sm617027066b.141.2024.12.03.05.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 05:52:45 -0800 (PST)
Message-ID: <93e4e5d6-5b51-48f8-97bd-5576bbbfa547@linaro.org>
Date: Tue, 3 Dec 2024 14:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/14] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-7-adrianox@gmail.com>
 <bd88b800-a650-4512-843f-9ac4436169e5@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <bd88b800-a650-4512-843f-9ac4436169e5@gmx.de>
Content-Type: text/plain; charset=UTF-8
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



On 12/3/24 11:51, Heinrich Schuchardt wrote:
> On 28.11.24 15:44, Adriano Cordova wrote:
>> Add the functions efi_net_set_addr and  efi_net_get_addr to set
>> and get the ip address from efi code in a network agnostic way.
>> This could also go in net_common, or be compiled conditionally
>> for each network stack.
>>
>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> ---
>> (no changes since v5)
>> Changes in v5:
>> - When possible use sizeof in memcpy instead of hardcoded value
>>
>> Changes in v4:
>>   - Removed unnecessary casts
>>   - Changed char *ipstr by char ipstr[].
>>
>> (no changes since v2)
>>   include/efi_loader.h     |  16 +++++
>>   lib/efi_loader/efi_net.c | 125 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 141 insertions(+)
>>
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index 39809eac1b..612bc42816 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -125,6 +125,22 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
>>                      size_t buffer_size) { }
>>   #endif
>>
>> +#if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
>> +void efi_net_get_addr(struct efi_ipv4_address *ip,
>> +              struct efi_ipv4_address *mask,
>> +              struct efi_ipv4_address *gw);
>> +void efi_net_set_addr(struct efi_ipv4_address *ip,
>> +              struct efi_ipv4_address *mask,
>> +              struct efi_ipv4_address *gw);
>> +#else
>> +static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
>> +                     struct efi_ipv4_address *mask,
>> +                     struct efi_ipv4_address *gw) { }
>> +static inline void efi_net_set_addr(struct efi_ipv4_address *ip,
>> +                     struct efi_ipv4_address *mask,
>> +                     struct efi_ipv4_address *gw) { }
>> +#endif
>> +
>>   /* Maximum number of configuration tables */
>>   #define EFI_MAX_CONFIGURATION_TABLES 16
>>
>> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
>> index 7cd536705f..3491d4c481 100644
>> --- a/lib/efi_loader/efi_net.c
>> +++ b/lib/efi_loader/efi_net.c
>> @@ -17,6 +17,7 @@
>>
>>   #include <efi_loader.h>
>>   #include <malloc.h>
>> +#include <vsprintf.h>
>>   #include <net.h>
>>
>>   static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
>> @@ -997,3 +998,127 @@ out_of_resources:
>>       printf("ERROR: Out of memory\n");
>>       return EFI_OUT_OF_RESOURCES;
>>   }
>> +
>> +/**
>> + * efi_net_get_addr() - get IP address information
>> + *
>> + * Copy the current IP address, mask, and gateway into the
>> + * efi_ipv4_address structs pointed to by ip, mask and gw,
>> + * respectively.
>> + *
>> + * @ip:        pointer to an efi_ipv4_address struct to
>> + *        be filled with the current IP address
>> + * @mask:    pointer to an efi_ipv4_address struct to
>> + *        be filled with the current network mask
>> + * @gw:        pointer to an efi_ipv4_address struct to be
>> + *        filled with the current network gateway
>> + */
>> +void efi_net_get_addr(struct efi_ipv4_address *ip,
>> +              struct efi_ipv4_address *mask,
>> +              struct efi_ipv4_address *gw)
>> +{
>> +#ifdef CONFIG_NET_LWIP
>> +    char ipstr[] = "ipaddr\0\0";
>> +    char maskstr[] = "netmask\0\0";
>> +    char gwstr[] = "gatewayip\0\0";
>> +    int idx;
>> +    struct in_addr tmp;
>> +    char *env;
>> +
>> +    idx = dev_seq(eth_get_dev());
>> +
>> +    if (idx < 0 || idx > 99) {
>> +        log_err("unexpected idx %d\n", idx);
>> +        return;
>> +    }
>> +
>> +    if (idx) {
>> +        sprintf(ipstr, "ipaddr%d", idx);
>> +        sprintf(maskstr, "netmask%d", idx);
>> +        sprintf(gwstr, "gatewayip%d", idx);
>> +    }
>> +
>> +    env = env_get(ipstr);
>> +    if (env && ip) {
>> +        tmp = string_to_ip(env);
>> +        memcpy(ip, &tmp, sizeof(tmp));
>> +    }
>> +
>> +    env = env_get(maskstr);
>> +    if (env && mask) {
>> +        tmp = string_to_ip(env);
>> +        memcpy(mask, &tmp, sizeof(tmp));
>> +    }
>> +    env = env_get(gwstr);
>> +    if (env && gw) {
>> +        tmp = string_to_ip(env);
>> +        memcpy(gw, &tmp, sizeof(tmp));
>> +    }
>> +#else
>> +    if (ip)
>> +        memcpy(ip, &net_ip, sizeof(net_ip));
>> +    if (mask)
>> +        memcpy(mask, &net_netmask, sizeof(net_netmask));
>> +#endif
>> +}
>> +
>> +/**
>> + * efi_net_set_addr() - set IP address information
>> + *
>> + * Set the current IP address, mask, and gateway to the
>> + * efi_ipv4_address structs pointed to by ip, mask and gw,
>> + * respectively.
>> + *
>> + * @ip:        pointer to new IP address
>> + * @mask:    pointer to new network mask to set
>> + * @gw:        pointer to new network gateway
>> + */
>> +void efi_net_set_addr(struct efi_ipv4_address *ip,
>> +              struct efi_ipv4_address *mask,
>> +              struct efi_ipv4_address *gw)
>> +{
>> +#ifdef CONFIG_NET_LWIP
>> +    char ipstr[] = "ipaddr\0\0";
>> +    char maskstr[] = "netmask\0\0";
>> +    char gwstr[] = "gatewayip\0\0";
>> +    int idx;
>> +    struct in_addr *addr;
>> +    char tmp[46];
>> +
>> +    idx = dev_seq(eth_get_dev());
>> +
>> +    if (idx < 0 || idx > 99) {
>> +        log_err("unexpected idx %d\n", idx);
>> +        return;
>> +    }
> 
> The same logic can be found in LWIP's dhcp_loop(), get_udev_ipv4_info().
> 
> After this series I think it is time to carve it out into a function.
> 
> It is unclear to me form where the idx > 99 in the LWIP stack is
> derived. struct udevice device defines seq_ as integer.
> 
>> +
>> +    if (idx) {
>> +        sprintf(ipstr, "ipaddr%d", idx);
>> +        sprintf(maskstr, "netmask%d", idx);
>> +        sprintf(gwstr, "gatewayip%d", idx);
> 
> @Jerome,
> 
> The usage of environment variables ipaddr#, netmask#, gatewayip# by the
> LWIP stack should be documented in doc/usage/environment.rst. Could you,
> please, provide a patch.

https://lists.denx.de/pipermail/u-boot/2024-December/573696.html

Thanks!

-- 
Jerome

> 
> For this patch
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
>> +    }
>> +
>> +    if (ip) {
>> +        addr = (struct in_addr *)ip;
>> +        ip_to_string(*addr, tmp);
>> +        env_set(ipstr, tmp);
>> +    }
>> +
>> +    if (mask) {
>> +        addr = (struct in_addr *)mask;
>> +        ip_to_string(*addr, tmp);
>> +        env_set(maskstr, tmp);
>> +    }
>> +
>> +    if (gw) {
>> +        addr = (struct in_addr *)gw;
>> +        ip_to_string(*addr, tmp);
>> +        env_set(gwstr, tmp);
>> +    }
>> +#else
>> +    if (ip)
>> +        memcpy(&net_ip, ip, sizeof(*ip));
>> +    if (mask)
>> +        memcpy(&net_netmask, mask, sizeof(*mask));
>> +#endif
>> +}
> 
