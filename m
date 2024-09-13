Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A2FFA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FF7889B8;
	Fri, 13 Sep 2024 11:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eQMeCXpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3F4889EF; Fri, 13 Sep 2024 11:33:36 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3259C88936
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374b5f27cf2so1372479f8f.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726220014; x=1726824814; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c57AeCEqklFAskexxIbqD9KpRV+wParv6AN/xjIlnt8=;
 b=eQMeCXpVUfshwula1rLOS05bHhTccUjuj3XKMEv56nYD7PEJH+FKBQWo6vqVoN4Udc
 hOB1Uk1sWDkG7kR+IsbN1hykKZuO+Jewjj3yPnEZ5bcsW31QGH2obDOrQ3trbSJmiOIh
 gfO5icv+elvw14wi2H768l6bbo/tQ7Hfjb3kbh1GQM70uAvzdJMe4jQn841LyTaRLr1J
 hJToAhM0LcW2Gwh1XZCAhzCnNQ18Gfx2fcPipbVFdaiot9AEhgBzI1hoAfhSVqGmGwLj
 uGPTv3uypZyMlwZZZ9RTZxlwjNB5WxxAZ7Ff5pK4HCouZh5Y8yZ9g+CaVy05I35Pnuvd
 HEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726220014; x=1726824814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c57AeCEqklFAskexxIbqD9KpRV+wParv6AN/xjIlnt8=;
 b=fT0FypUcr5bq+0Yp+ezXyIxyTiUcQUokm0y5cj/OAKVLvr2yZO+mlsjgSs7U6ogWPG
 hpsCsnXnbjyrqscQYC77mVpzftVBGzmPX+x+BKKjfPk21j13fD74lQK875tthR5MhRPf
 b9lVTRmfc9wKfFIQY9QusgPfMfenGRouup+L01vcAyGPT8zs8n6HFvV0dUKOr0dqp/df
 G7jJ+5LLkOYKRX7ibM6P31Tdemav4a2NoTh28rRns1WhxDabZaZx9DtXemhHSM1P8LMO
 OAxHfUw09/u5pLKMg/613knJg2gMMNuRr6ZHiLLWVxnSyWYLogMQFCbgLslL1efNg6Hq
 2fdw==
X-Gm-Message-State: AOJu0YzXFNiMWECuSYBHF3b3GEILFzot74iQ0UD07uvfwWcrMSjtI5kY
 6w72Y/5R9JoSZxwjhZpQehQAk5he+kcnYv0bTuvPVoE4LVbhaFTWvv16wUkLwB0=
X-Google-Smtp-Source: AGHT+IE2v+SAZFwZeLn+ComtrhB/HlE4KxEOHJwPQ1swsUHUMGWBkG2M2XZJGgO8njTUnF/ZsHt01A==
X-Received: by 2002:a5d:5582:0:b0:374:cb17:c62f with SMTP id
 ffacd0b85a97d-378c2cd542emr3241294f8f.11.1726220013462; 
 Fri, 13 Sep 2024 02:33:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:edd9:2a6c:c786:3e44?
 ([2a01:e0a:3cb:7bb0:edd9:2a6c:c786:3e44])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3687sm16358473f8f.71.2024.09.13.02.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 02:33:33 -0700 (PDT)
Message-ID: <ecf381f7-d48a-48a5-9395-c12b301108d0@linaro.org>
Date: Fri, 13 Sep 2024 11:33:31 +0200
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
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240909161932.GC4252@bill-the-cat>
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



On 9/9/24 18:19, Tom Rini wrote:
> On Mon, Sep 09, 2024 at 04:11:37PM +0200, Jerome Forissier wrote:
>>
>>
>> On 9/6/24 19:54, Tom Rini wrote:
>>> On Fri, Sep 06, 2024 at 02:33:16PM +0200, Jerome Forissier wrote:
>>>
>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>> reasons for doing so are:
>>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>>> so. With that it becomes possible to fetch and launch a distro installer
>>>> such as Debian etc. using a secure, authenticated connection directly
>>>> from the U-Boot shell. Several use cases:
>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>> binary with a different one)
>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>> image as it is being downloaded
>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>> (this is becoming more and more common on the Internet these days)
>>>> - Possibly benefit from additional features implemented in lwIP
>>>> - Less code to maintain in U-Boot
>>>
>>> On am64x-sk (am64x_evm_a53_defconfig) I'm seeing:
>>> => tftpboot 80200000 EFI/arm64/grubaa64.efi
>>> Using ethernet@8000000port@1 device
>>> TFTP from server 192.168.116.10; our IP address is 192.168.116.23
>>> Filename 'EFI/arm64/grubaa64.efi'.
>>> Load address: 0x80200000
>>> Loading:
>>> ... silent hang ...
>>>
>>> Which I didn't see with v9. I can test other TI K3 platforms if it would
>>> help.
>>
>> Weird. I compared v9 and v10 (rebased onto the same commit as v9) but
>> I saw nothing obvious. Would you mind running the test again with these
>> traces added?
>>
>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>> index 1948fc1c309..9bbfd8ee5a7 100644
>> --- a/net/lwip/net-lwip.c
>> +++ b/net/lwip/net-lwip.c
>> @@ -35,6 +35,7 @@ static err_t linkoutput(struct netif *netif, struct pbuf *p)
>>  	void *pp = NULL;
>>  	int err;
>>  
>> +	printf("[OUT|%d]", p->len);
>>  	if ((unsigned long)p->payload % PKTALIGN) {
>>  		/*
>>  		 * Some net drivers have strict alignment requirements and may
>> @@ -252,12 +253,16 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>>  	int len;
>>  	int i;
>>  
>> -	if (!eth_is_active(udev))
>> +	printf("[IN]");
>> +	if (!eth_is_active(udev)) {
>> +		printf("ERR: !eth_is_active()\n");
>>  		return -EINVAL;
>> +	}
>>  
>>  	flags = ETH_RECV_CHECK_DEVICE;
>>  	for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
>>  		len = eth_get_ops(udev)->recv(udev, flags, &packet);
>> +		printf("[IN|%d]", len);
>>  		flags = 0;
>>  
>>  		if (len > 0) {
> 
> I have the log, if it helps. However, with debug prints added, now it
> completes.

Duh! :-/

> And I can see (as part of trimming down my test setup) that
> without the prints, some tests are OK. The much smaller "helloworld.efi"
> file and test is fine.

I suspect we might be hitting the test framework timeout, because TFTP
with lwIP is slower than with the legacy stack as mentioned in [1] (lack
of window size support). Although it seems weird that you don't see the
hash signs at all, as if no data were received?

[1] http://patchwork.ozlabs.org/project/uboot/patch/318048700dfb511c4634505adb1e95ce8be189c0.1725625913.git.jerome.forissier@linaro.org/

Regards,
-- 
Jerome
