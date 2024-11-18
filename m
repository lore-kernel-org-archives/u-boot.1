Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54FCD49221
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 13:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 274C589449;
	Mon, 18 Nov 2024 14:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zRyuUhOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4774289449; Mon, 18 Nov 2024 14:45:50 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B5B0893E7
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 14:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cb15b84544so2705723a12.2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 05:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731937547; x=1732542347; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ZMsAm3pFgrqrP6WveZH7Yhs7Vcn9sl1IvRfMXIQUgs=;
 b=zRyuUhOpSsVD8dq2xsRbVbwc84bM4TckWkyEGT6vyIh7TjW8TaRS4R0odM03MrMqnr
 OIQz7Zojafkrptp9AaQEnDrgUppyEXUUx5nTE5cfbTa6sweS1kXPHe+DjXGAjaJBuJlA
 +pcLIDvFWyaYkODN85FoPbs0pG/WkcMB2WD0mRykuMJx5n9SX9wGZ5gitZLmuG3xEMCA
 vlydWIIuSvy4JKz/1aDDiqz4pPa9HXNZdHLjZ5eG90CsZbw8h6hFrQmHCiDg/AYuz8/x
 FNbqOhaIRra8gXLMb9lPEi3aYzd4oM7rRzXR1bGK1u+2QynLugLvB2hw0SASyDRO5z+p
 cPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731937547; x=1732542347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZMsAm3pFgrqrP6WveZH7Yhs7Vcn9sl1IvRfMXIQUgs=;
 b=lBB2IIvTrXcm7WwmhKqgu8Xsy/H7ZO5kP6zbHzjZLcyxHzwD5hYKuxIJoAxxXRvgwj
 n7yWFJzXWTjUi3hf905Eve/KqcnIHH077T/5ZkRyqWfANcPnUSK80g6YzKBt1DGvNLqM
 okm7Vq8eCFacZwqUGP7iXR5HzNjVk6sKZRAQRfw+W9xWySiZveqR+zuWN/WKg40eKx7Y
 qYR/oIPQvOIZmCTS7fGtFNk8z3F5F39AQ3VbDW3fJaAB4INuyNPsGkOtTzXjZ9J3+1DU
 uOQmHHFLYUNlDNb6J0nMy2SeJqrh9BqMrYqF9N313dU+Ei7ZgzVayFdKezliWk0Vp+ep
 inPg==
X-Gm-Message-State: AOJu0YxphQ6CRC7AUDjE5WS9qPneMq+ptW/AWgR7a/x/i2E6lhxkzFKE
 aK2otCdftX4uEEtepVfDNTODegjf+IpODlw74eMda5DQKr8oB+vx/v0am6O6EiA=
X-Google-Smtp-Source: AGHT+IFgajpASZl0Nzj6EkpAGU8kAHLz3RyJL88SN0wUCzZjTN/14wFmoSIW19u42UfsHji8DKYMIw==
X-Received: by 2002:a17:906:eec9:b0:a9e:c954:6afb with SMTP id
 a640c23a62f3a-aa48355294dmr1198337666b.51.1731937546654; 
 Mon, 18 Nov 2024 05:45:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:db7:e082:63c2:d847?
 ([2a01:e0a:3cb:7bb0:db7:e082:63c2:d847])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df26c84sm544485966b.35.2024.11.18.05.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 05:45:46 -0800 (PST)
Message-ID: <8ae75fe7-d17f-4f55-9a62-09278e238ac9@linaro.org>
Date: Mon, 18 Nov 2024 14:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
To: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 xypron.glpk@gmx.de
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-8-adrianox@gmail.com>
 <CAC_iWjJ19963N20Y52hVpQ8=-n8ifziyTcXdCNFkKR5+9nm3Ug@mail.gmail.com>
 <CAMGU2hWt3YhijXdaKXmEE21rgQBwJ-X6taTy=1MY3TjEAcPLZg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAMGU2hWt3YhijXdaKXmEE21rgQBwJ-X6taTy=1MY3TjEAcPLZg@mail.gmail.com>
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



On 11/18/24 13:35, Adriano Córdova wrote:
> Hi Ilias,
> 
> El lun, 18 nov 2024 a las 9:22, Ilias Apalodimas (<
> ilias.apalodimas@linaro.org>) escribió:
> 
>> Hi Adriano,
>>
>> On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>>>
>>> Add the functions efi_net_set_addr and  efi_net_get_addr to set
>>> and get the ip address from efi code in a network agnostic way.
>>> This could also go in net_common, or be compiled conditionally
>>> for each network stack.
>>>
>>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>>> ---
>>>
>>> (no changes since v2)
>>>
>>>  include/efi_loader.h     |  16 +++++++
>>>  lib/efi_loader/efi_net.c | 100 +++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 116 insertions(+)
>>>
>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>> index 39809eac1b..612bc42816 100644
>>> --- a/include/efi_loader.h
>>> +++ b/include/efi_loader.h
>>> @@ -125,6 +125,22 @@ static inline void efi_set_bootdev(const char *dev,
>> const char *devnr,
>>>                                    size_t buffer_size) { }
>>>  #endif
>>>
>>> +#if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
>>> +void efi_net_get_addr(struct efi_ipv4_address *ip,
>>> +                     struct efi_ipv4_address *mask,
>>> +                     struct efi_ipv4_address *gw);
>>> +void efi_net_set_addr(struct efi_ipv4_address *ip,
>>> +                     struct efi_ipv4_address *mask,
>>> +                     struct efi_ipv4_address *gw);
>>> +#else
>>> +static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
>>> +                                    struct efi_ipv4_address *mask,
>>> +                                    struct efi_ipv4_address *gw) { }
>>> +static inline void efi_net_set_addr(struct efi_ipv4_address *ip,
>>> +                                    struct efi_ipv4_address *mask,
>>> +                                    struct efi_ipv4_address *gw) { }
>>> +#endif
>>> +
>>>  /* Maximum number of configuration tables */
>>>  #define EFI_MAX_CONFIGURATION_TABLES 16
>>>
>>> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
>>> index 7cd536705f..dd84b3f18d 100644
>>> --- a/lib/efi_loader/efi_net.c
>>> +++ b/lib/efi_loader/efi_net.c
>>> @@ -17,6 +17,7 @@
>>>
>>>  #include <efi_loader.h>
>>>  #include <malloc.h>
>>> +#include <vsprintf.h>
>>>  #include <net.h>
>>>
>>>  static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
>>> @@ -997,3 +998,102 @@ out_of_resources:
>>>         printf("ERROR: Out of memory\n");
>>>         return EFI_OUT_OF_RESOURCES;
>>>  }
>>> +
>>> +void efi_net_get_addr(struct efi_ipv4_address *ip,
>>> +                     struct efi_ipv4_address *mask,
>>> +                     struct efi_ipv4_address *gw)
>>> +{
>>> +#ifdef CONFIG_NET_LWIP
>>> +       char *ipstr = "ipaddr\0\0";
>>> +       char *maskstr = "netmask\0\0";
>>> +       char *gwstr = "gatewayip\0\0";
>>
>> You generally can't define strings like that and expect to change
>> them. The compiler places the string literal somewhere in memory which
>> is immutable.
>> If you want to keep the code as is, you need to define these as ipstr[].
>>
>>> +       int idx;
>>> +       struct in_addr tmp;
>>> +       char *env;
>>> +
>>> +       idx = dev_seq(eth_get_dev());
>>> +
>>> +       if (idx < 0 || idx > 99) {
>>> +               log_err("unexpected idx %d\n", idx);
>>> +               return;
>>> +       }
>>> +
>>> +       if (idx) {
>>
>> Is 0 not legal here?
>> And why is the behavior differnt with and without LWIP?
>>
> 
> This is how the lwip code deals with the environment variables for the IP
> address, see
> get_udev_ipv4_info in
> https://github.com/u-boot/u-boot/blob/a38390284ad4261723d3a2411ba988828e994535/net/lwip/net-lwip.c#L91
> In here I am trying to be consistent with that.

It's a mistake and an oversight on my part. Ilias is right. I will send a
patch to fix lwIP.

Thanks,
-- 
Jerome

> In legacy the network stack
> just uses the variables net_ip and net_netmask.
> 
> 
>>> +               sprintf(ipstr, "ipaddr%d", idx);
>>> +               sprintf(maskstr, "netmask%d", idx);
>>> +               sprintf(gwstr, "gatewayip%d", idx);
>>> +       }
>>> +
>>> +       env = env_get(ipstr);
>>> +       if (env && ip) {
>>> +               tmp = string_to_ip(env);
>>> +               memcpy((void *)ip, (void *)&tmp, 4);
>>> +       }
>>> +
>>> +       env = env_get(maskstr);
>>> +       if (env && mask) {
>>> +               tmp = string_to_ip(env);
>>> +               memcpy((void *)mask, (void *)&tmp, 4);
>>> +       }
>>> +       env = env_get(gwstr);
>>> +       if (env && gw) {
>>> +               tmp = string_to_ip(env);
>>> +               memcpy((void *)gw, (void *)&tmp, 4);
>>> +       }
>>> +#else
>>> +       if (ip)
>>> +               memcpy((void *)ip, (void *)&net_ip, 4);
>>> +       if (mask)
>>> +               memcpy((void *)mask, (void *)&net_netmask, 4);
>>
>> Get rid of casts etc.
>>
>>> +#endif
>>> +}
>>> +
>>> +void efi_net_set_addr(struct efi_ipv4_address *ip,
>>> +                     struct efi_ipv4_address *mask,
>>> +                     struct efi_ipv4_address *gw)
>>> +{
>>> +#ifdef CONFIG_NET_LWIP
>>> +       char *ipstr = "ipaddr\0\0";
>>> +       char *maskstr = "netmask\0\0";
>>> +       char *gwstr = "gatewayip\0\0";
>>> +       int idx;
>>> +       struct in_addr *addr;
>>> +       char tmp[46];
>>> +
>>> +       idx = dev_seq(eth_get_dev());
>>> +
>>> +       if (idx < 0 || idx > 99) {
>>> +               log_err("unexpected idx %d\n", idx);
>>> +               return;
>>> +       }
>>> +
>>> +       if (idx) {
>>> +               sprintf(ipstr, "ipaddr%d", idx);
>>> +               sprintf(maskstr, "netmask%d", idx);
>>> +               sprintf(gwstr, "gatewayip%d", idx);
>>> +       }
>>> +
>>> +       if (ip) {
>>> +               addr = (struct in_addr *)ip;
>>> +               ip_to_string(*addr, tmp);
>>> +               env_set(ipstr, tmp);
>>> +       }
>>> +
>>> +       if (mask) {
>>> +               addr = (struct in_addr *)mask;
>>> +               ip_to_string(*addr, tmp);
>>> +               env_set(maskstr, tmp);
>>> +       }
>>> +
>>> +       if (gw) {
>>> +               addr = (struct in_addr *)gw;
>>> +               ip_to_string(*addr, tmp);
>>> +               env_set(gwstr, tmp);
>>> +       }
>>> +#else
>>> +       if (ip)
>>> +               memcpy((void *)&net_ip, (void *)ip, 4);
>>> +       if (mask)
>>> +               memcpy((void *)&net_netmask, (void *)mask, 4);
>>> +#endif
>>> +}
>>> --
>>> 2.43.0
>>>
>>
>> Cheers
>> /Ilias
>>
> 
> Thanks,
> Adriano
> 
