Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD866FA3755
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 14:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C18988D8F;
	Fri, 13 Sep 2024 16:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z0tAsDvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18FA988D8D; Fri, 13 Sep 2024 16:37:31 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EFE988D97
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 16:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d4979b843so301602466b.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726238243; x=1726843043; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o7p6IYkeMUOG/d30Jz0jcAeJf+fDfMPbjIwINMiUugE=;
 b=z0tAsDvZdCs0CmHfWGZFU2J6wDencUZx+pApcsqDHOdvI982EhKRINt/aUbwOCZK3g
 oWGOrM47YIHPNEKJeLXOiH/D8B76V3ooECJnGeKRtAwtkb1VEgav0DJ16MjHo0V91f6M
 xEQYfw+d4GwhCT0xpoU8Dxx7D3SgeELOr/MUZVwLJFYPgicTZnTl0ZDBMdpa7OdKoa1a
 f5YUSMKPSm4jLjpDgfTlSeYZ2arxSOmwPMaMIn6cJkg2l4yJJZ+MZ2aHOgUo0xJwJfxJ
 NZAP7VVTAxl5YpYiBkmfWqVQABUdrdwP02BjjmyGIHXfxaVqEzVxA9lHyksY4mF6giv4
 VV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726238243; x=1726843043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o7p6IYkeMUOG/d30Jz0jcAeJf+fDfMPbjIwINMiUugE=;
 b=JWGLkAhW4m12FXfvvkSFStfPRYW+HjbL/Gq1bdnQI6FpaBD8YHfyJnTiAes+CicGIS
 89oZA8Y3wPutJRS6shMAQhBgs1OxM0B0LbNGWc47msU5oYTwr3Co529Uqa3G+hPnQgUC
 nuu4slVlcmN/TBGMoL4usN71t4PX0GLJsoDnZDFuQbDP3L6N4klpc9nhj5qMaD5EiJhK
 H8bLu8t7MoSGYSbPAEC7SwnPUYcTq55rTngtwnmPcztCM43p63sou9agNEUANspGSdXq
 OVwqNNfPN7pP6MXGl9g0+U9BiM2wxab+hyhxUh627t12bcfcXNJONlNrPf4hD7mAYqFp
 A0Xg==
X-Gm-Message-State: AOJu0YyHP00lQ4KoernCNzfMwcZigQBzUDe+85vuf9Y3R4agl0sJ99sj
 1KI9A3hDyVUs9GiyuEZq5XXhZfSLeYOsvcyTsJSqwd05cfxkkm0VJhZT8EDWjOU=
X-Google-Smtp-Source: AGHT+IG8WQQCaxIMovV6qTQ7FKPohTlIEM8C2iox2nc2idjkvuP61opt7nydbmsyesfBW5IWUBO+gw==
X-Received: by 2002:a17:907:efc5:b0:a8a:93d4:ac21 with SMTP id
 a640c23a62f3a-a90294bf2d3mr624832166b.28.1726238243330; 
 Fri, 13 Sep 2024 07:37:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:edd9:2a6c:c786:3e44?
 ([2a01:e0a:3cb:7bb0:edd9:2a6c:c786:3e44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25831875sm891770066b.11.2024.09.13.07.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 07:37:22 -0700 (PDT)
Message-ID: <25a3591c-0c5e-4294-9e06-f9b3ca954338@linaro.org>
Date: Fri, 13 Sep 2024 16:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/25] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
 <20240906175433.GE3879073@bill-the-cat>
 <4b66d045-5410-4991-96e5-1d9cd98cbdf9@linaro.org>
 <20240909161932.GC4252@bill-the-cat>
 <ecf381f7-d48a-48a5-9395-c12b301108d0@linaro.org>
 <20240913135947.GW4252@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240913135947.GW4252@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 9/13/24 15:59, Tom Rini wrote:
> On Fri, Sep 13, 2024 at 11:33:31AM +0200, Jerome Forissier wrote:
>>
>>
>> On 9/9/24 18:19, Tom Rini wrote:
>>> On Mon, Sep 09, 2024 at 04:11:37PM +0200, Jerome Forissier wrote:
>>>>
>>>>
>>>> On 9/6/24 19:54, Tom Rini wrote:
>>>>> On Fri, Sep 06, 2024 at 02:33:16PM +0200, Jerome Forissier wrote:
>>>>>
>>>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>>>> reasons for doing so are:
>>>>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>>>>> so. With that it becomes possible to fetch and launch a distro installer
>>>>>> such as Debian etc. using a secure, authenticated connection directly
>>>>>> from the U-Boot shell. Several use cases:
>>>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>>>> binary with a different one)
>>>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>>>> image as it is being downloaded
>>>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>>>> (this is becoming more and more common on the Internet these days)
>>>>>> - Possibly benefit from additional features implemented in lwIP
>>>>>> - Less code to maintain in U-Boot
>>>>>
>>>>> On am64x-sk (am64x_evm_a53_defconfig) I'm seeing:
>>>>> => tftpboot 80200000 EFI/arm64/grubaa64.efi
>>>>> Using ethernet@8000000port@1 device
>>>>> TFTP from server 192.168.116.10; our IP address is 192.168.116.23
>>>>> Filename 'EFI/arm64/grubaa64.efi'.
>>>>> Load address: 0x80200000
>>>>> Loading:
>>>>> ... silent hang ...
>>>>>
>>>>> Which I didn't see with v9. I can test other TI K3 platforms if it would
>>>>> help.
>>>>
>>>> Weird. I compared v9 and v10 (rebased onto the same commit as v9) but
>>>> I saw nothing obvious. Would you mind running the test again with these
>>>> traces added?
>>>>
>>>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>>>> index 1948fc1c309..9bbfd8ee5a7 100644
>>>> --- a/net/lwip/net-lwip.c
>>>> +++ b/net/lwip/net-lwip.c
>>>> @@ -35,6 +35,7 @@ static err_t linkoutput(struct netif *netif, struct pbuf *p)
>>>>  	void *pp = NULL;
>>>>  	int err;
>>>>  
>>>> +	printf("[OUT|%d]", p->len);
>>>>  	if ((unsigned long)p->payload % PKTALIGN) {
>>>>  		/*
>>>>  		 * Some net drivers have strict alignment requirements and may
>>>> @@ -252,12 +253,16 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>>>>  	int len;
>>>>  	int i;
>>>>  
>>>> -	if (!eth_is_active(udev))
>>>> +	printf("[IN]");
>>>> +	if (!eth_is_active(udev)) {
>>>> +		printf("ERR: !eth_is_active()\n");
>>>>  		return -EINVAL;
>>>> +	}
>>>>  
>>>>  	flags = ETH_RECV_CHECK_DEVICE;
>>>>  	for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
>>>>  		len = eth_get_ops(udev)->recv(udev, flags, &packet);
>>>> +		printf("[IN|%d]", len);
>>>>  		flags = 0;
>>>>  
>>>>  		if (len > 0) {
>>>
>>> I have the log, if it helps. However, with debug prints added, now it
>>> completes.
>>
>> Duh! :-/
>>
>>> And I can see (as part of trimming down my test setup) that
>>> without the prints, some tests are OK. The much smaller "helloworld.efi"
>>> file and test is fine.
>>
>> I suspect we might be hitting the test framework timeout, because TFTP
>> with lwIP is slower than with the legacy stack as mentioned in [1] (lack
>> of window size support). Although it seems weird that you don't see the
>> hash signs at all, as if no data were received?
> 
> Yeah, it's acting like no data was received or otherwise just locked up.

OK

> If you have a beagleplay it should also show the problem.

Unfortunately no, I don't have the hardware.

> I can try and
> find some time to check it out, outside the test framework, but also the> Pi platforms pass this test fine (same binary, same physical network).


That would be great because I don't have any better suggestion...


In the meantime I do have v11 ready, with one minor fix, patches removed
(posted separately) and more importantly a change to enable CMD_PXE. From
the upcoming changelog:

===
- Add (some) support for CMD_PXE and therefore drop patch "[TESTING]
configs: set CONFIG_NET=y when PXE is enabled". This is build-tested
only and it is very likely that some work is needed to make it useful.
For example, adding the code for DHCP option 209 to lwIP so that
BOOTP_PXE_DHCP_OPTION can be supported.
===

Would you like me to post this v11 today, or do you prefer we sort out
the TFTP issue with TI K3 first?

Thanks again for you support on this series!

Regards,
-- 
Jerome


