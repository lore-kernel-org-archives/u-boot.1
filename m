Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50020E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 10:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95312801A0;
	Fri,  3 Jan 2025 11:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mjH1d+sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D701802EF; Fri,  3 Jan 2025 11:03:28 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0BC380196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 11:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so1998668666b.2
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 02:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735898605; x=1736503405; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cEn5qJQVhpCTvB5A7Vgo5Pg93HVCniyYY2vcj7Jkb08=;
 b=mjH1d+sxQaL+Zpf2hsPnBw8p/c3IeBbVMEIC8UFsyVeShPuPnh3GHeuMx7dmMdBkdm
 zMnjxwU8mIbPBowCgYnAgBBllvHUCXeLpFOYbeUH/IewT03QCtacTXZa8SjH03QGnAvr
 dWMrua0bVYrLDcHu/YQbIj8jk2cKbmXjRn0f4BkPYq4tXlgtAucAzGbcYXZkG1UGVj84
 T0Q3X3UGKZpzWTtSZEvPrvpF0b9d00uczZ4TqW2aDtjHtnP1ArNo6FNeF3DEGSEFElNh
 oRFRiJMcFzH0LyanJTds2RkH+BFZQH++RnSrctRhQTqFL3g3JFGOUgKMFZu0UOLTZ/Xx
 jPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735898605; x=1736503405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cEn5qJQVhpCTvB5A7Vgo5Pg93HVCniyYY2vcj7Jkb08=;
 b=Vrn7yFofJlu5BYjfxppb27NrnJQ30tqXz/xAL9FG9AS2EF6dJxo2SiOJuDKF58U0Mt
 ij6Gvt3leUuJU+bfZiem+UcjTcRICaTw/6CA+vZi0GH1MY2ORNecPuoOKmcwrVuyUbS8
 WtlWNKzn1fyJVanhbkWMgFkOUzj/s3rpHyT6HBwQBO+XvUOVXaJLyVi+embMBLTgP6Hk
 h7uz97mni0Wta0C3vn+3xbGGpJRr97H4eQAnyZMit859xeOiddpK6zueLJCMnQ4yL8E6
 Ji0d9KcLsL93mVJCKT131xxkxEvcYw/aR1FRkuPDgNPEtbaSXjxOo5Mva3ksLqX3UYLF
 aC1w==
X-Gm-Message-State: AOJu0YwncK+y6Wlf4u14EMErYEf5wmlmhA4ev88sYU6hU86/AQ022JPS
 AKoE4NZ5ykm0DfxkHdpoyLj2SBEVu9w7Mi0t/v8eJujBW6kmVQCdrqMDRHse01w=
X-Gm-Gg: ASbGncsHeH3XUxAo0+vi9qayEVvtM4N70Casql4NfxF2qjY8E/L2E8dAT48tXDpOKHh
 jnWz+RiAbUtXLgmIPRe6il5yf5OvxyGlkj02YIPA/BPbNx7ix3sCvo0rN5oMX12wKDSdKnO8q0A
 /p7Ekr6S8ANDaNzpLYylQ2H8fqWmC/YiI5wQKqYa87+E5suBxW0zY1eNcWoT3qE/+VwgEDHOqu4
 uRiWsHfMIhCKEj3LE3mEe2eNS/+9MM6l8GXUqHHtGaRYCwtGB2AaaqfXmTyePfakoq7WfvVqpkO
 Id6rCDnoROUoOFtV09NSvMZANc6FH4fFag==
X-Google-Smtp-Source: AGHT+IGCEoM2AVrnaq2ETJ/rLfXNH+RN4CZfgTXMXrtngYiZkApJLZ6mFMvR3IW951tgb6sHyqwdDA==
X-Received: by 2002:a17:907:6ea9:b0:aa6:834b:d138 with SMTP id
 a640c23a62f3a-aac2ad9ae43mr4159829066b.19.1735898604889; 
 Fri, 03 Jan 2025 02:03:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c381:4b2b:2e3a:bef?
 ([2a01:e0a:3cb:7bb0:c381:4b2b:2e3a:bef])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f0159e5sm1869170866b.153.2025.01.03.02.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 02:03:24 -0800 (PST)
Message-ID: <7c20233b-d61a-4114-bbb3-6866bdd5bbf5@linaro.org>
Date: Fri, 3 Jan 2025 11:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LwIP and multiple network interfaces
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <de7bf6b3-fd45-4c8f-a492-bd41db2aa904@freeshell.de>
 <20250102224724.GS3476@bill-the-cat>
 <aa6d5dce-473c-447f-91b9-fe802f0f520d@freeshell.de>
 <20250103014049.GT3476@bill-the-cat>
 <14a9901e-00fd-4a5e-aeb1-ffbe715f8965@freeshell.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <14a9901e-00fd-4a5e-aeb1-ffbe715f8965@freeshell.de>
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



On 1/3/25 02:52, E Shattow wrote:
> 
> 
> On 1/2/25 17:40, Tom Rini wrote:
>> On Thu, Jan 02, 2025 at 05:34:57PM -0800, E Shattow wrote:
>>
>>> Tom sorry about sending this reply twice, struggle here is with Thunderbird
>>> mail UI sometimes hiding "Reply All" and it missed the mail list first time
>>> around.
>>
>> No problem.
>>
>>> On 1/2/25 14:47, Tom Rini wrote:
>>>> On Thu, Jan 02, 2025 at 02:26:06PM -0800, E Shattow wrote:
>>>>> Problem: 'dhcp' must be ran twice when the network cable is plugged into a
>>>>> port other than the first network port.
>>>>>
>>>>> Network cable plugged into bottom (first) Ethernet port:
>>>>> 1. Power on
>>>>> 2. StarFive # dhcp
>>>>>
>>>>> ethernet@16030000 Waiting for PHY auto negotiation to complete....... done
>>>>> DHCP client bound to address 192.168.2.51 (3678 ms)
>>>>>
>>>>>
>>>>> Network cable plugged into top (second) Ethernet port:
>>>>> 1. Power on
>>>>> 2. StarFive # dhcp
>>>>> ethernet@16030000 Waiting for PHY auto negotiation to complete.........
>>>>> TIMEOUT !
>>>>> phy_startup() failed: -110
>>>>> FAILED: -110
>>>>> ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
>>>>> ethernet@16030000 Waiting for PHY auto negotiation to complete.........
>>>>> TIMEOUT !
>>>>> phy_startup() failed: -110
>>>>> FAILED: -110
>>>>> Could not start ethernet@16030000
>>>>> 3. StarFive # dhcp
>>>>> DHCP client bound to address 192.168.2.77 (31 ms)
>>>>
>>>> What happens when you set ethact to 1 first?
>>>>
>>>
>>>
>>> '1' literal does not seem to do something so I guess it is meant the id of
>>> the first ethernet interface:
>>
>> Yes, I misspoke sorry.
>>
>>>  From power-on:
>>>
>>> ...
>>> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
>>> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
>>> In:    serial@10000000
>>> Out:   serial@10000000
>>> Err:   serial@10000000
>>> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
>>> starting USB...
>>> No USB controllers found
>>> Working FDT set to ff700a10
>>> StarFive # env print ethact
>>> ## Error: "ethact" not defined
>>> StarFive # env set ethact 1
>>> StarFive # dhcp
>>> ethernet@16030000 Waiting for PHY auto negotiation to complete.........
>>> TIMEOUT !
>>> phy_startup() failed: -110
>>> FAILED: -110
>>> ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
>>> EQOS_DMA_MODE_SWR stuck
>>> FAILED: -110
>>> Could not start ethernet@16030000
>>>
>>> Again, from power-on:
>>>
>>> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
>>> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
>>> In:    serial@10000000
>>> Out:   serial@10000000
>>> Err:   serial@10000000
>>> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
>>> starting USB...
>>> No USB controllers found
>>> Working FDT set to ff700a10
>>> StarFive # env print ethact
>>> ## Error: "ethact" not defined
>>> StarFive # env set ethact ethernet@16040000
>>> StarFive # dhcp
>>> ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
>>> DHCP client bound to address 192.168.2.77 (149 ms)
>>
>> So then yes, the second interface works when ethact is set to use that
>> directly. This is the same behavior as the legacy stack I believe.
>>
> 
> Legacy stack does actually rotate and complete successfully when ethact environment variable does not exist and (eventually) configure the second interface though. Here with LwIP the procedure fails.
> 
> Notice that here it starts with ethernet@16030000, then rotates to ethernet@16040000 unsuccessfully, and back again to ethernet@16030000 before (again) failing and giving up. There is a network cable plugged into 'ethernet@16040000' port and if we try the command again the environment variable ethact retained 'ethact=ethernet@16040000' from the failed procedure so you're right it works as it should... except that it totally failed to do what was expected the first time.

That's unexpected indeed.

> Is this exposing a problem with this board network driver and behavior or is it something with LwIP ?
Hard to tell at this point. One thing I know for sure is that lwIP expects
eth_set_current() (called from do_dhcp()) to actually pick a valid
interface if there is one. So it should definitely select ethernet@16040000
in your scenario. Adding debug prints to eth_set_current(),
eth_current_changed() etc. should help.

Thanks,
-- 
Jerome
