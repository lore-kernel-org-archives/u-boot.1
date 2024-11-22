Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3C6D75E39
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 12:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBE688D4F;
	Fri, 22 Nov 2024 13:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C6H+dc8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D803389825; Fri, 22 Nov 2024 13:43:44 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB2A489830
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so17759115e9.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 04:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732279421; x=1732884221; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y6Ii8++RK160KoI1sYoluMcRuSyp/ubanCsHopNNAg8=;
 b=C6H+dc8m60HO7HlRPwfNdK85oi58kD2BjMn5RMryXQWbagB5lse3rOF0aecd0tgDjG
 RptfC4mudSJl+jUb7cyqcGELnSkF8mKsIbEXJYZHXOu4Es0PX99WWPyana83/uCuVMfp
 NNIQmTf7Ja9ZdJ0UgHJVrOfukEXMqFiAp8vdhHaMoHmltryRVQOnNBomIvCVA12bXyi/
 oluNuEjMxt4PxKiTv6QiOR2BoJTGL9zJWKszkwsoTOlekZIEplKutgBMG0g59L+k75j7
 YysMMrUbvXk5pe7uYsR5uruY03QB5fNoIDx57gYg3WM38hZYj7NMtrujizpf+cOTFbvB
 KK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732279421; x=1732884221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y6Ii8++RK160KoI1sYoluMcRuSyp/ubanCsHopNNAg8=;
 b=uunhHbvldR1s+lsIAOBpMMrrl8vhjeqkd3l1zviNBB9sRm4wmgmJVgfF4pTJtXFci3
 gXtbsA1JZF9dqoLbv7ZK/D5CSTG+HZB9cHfLA8Z3l32m5EghXPz2s2ShioLy7Bghtpaz
 L4HpIZV2vohPZE9IlIwVxfHekxqjq6knL/gkOMWd+2eaEwaOrxbBt7wsM72Acu5ttyX1
 Y9xifUqu0ZXWlSCpCwvvTF3MG90JY9TXpMNPp2KEVFprisw2y+KWVUDNqFmRMxloNU4w
 Iek4fUxGrTCAzBqQ6wsqxtIPBb5bgoMqvvVQxp8GpWoSfhDPuAhJ2g/38eFPIe0mokk/
 0A9A==
X-Gm-Message-State: AOJu0Yw2Zy6IK2JKENvxmGwrJnO7YBGLPuzb3EKKoAE9O0N3CtNG57sP
 39gbVUQg6QUTNdLy+Sbiz9vwOZhda4kzjZ+4FUVcSdKwnPmnQqhbw9zWWR4qdIs=
X-Gm-Gg: ASbGncs/99viCH+8dCIGBRmxdvS9KiaeEB7VSTqlRD5pEULnLjxvX0oEyFzroLlw1uH
 dHfsQu+l2vq2Gbe63uRfLwUYR0DGkWpfo2PsE2U2H09q7J1Ds3G8yDoVK3z1O2R/fvww5znK2lG
 ymeoJqf9wG93e7V6w7xqbAMPKtPRqoYP8cFY4sM+G1pFRVof1qLcUoX1GLaFj0E/kygw23jKhtb
 mgimhert1E5VygUw6kt9JZJL4gqAmbNAWADosXiaw4BWFqyMP5yTID49nDNkE8cX1IZVhXOz/G9
 j9uDt+FGXPxMJCoS2hdq7AliaNft0A==
X-Google-Smtp-Source: AGHT+IGmkW6qPS60ZsSTNPZDDA2GKO/o5rSmWfEIKpuT2t40q199mtHAiPmAfj0H5DHinGuI1veoLA==
X-Received: by 2002:a05:600c:524c:b0:431:58cd:b260 with SMTP id
 5b1f17b1804b1-433ce4ab2b0mr19447835e9.25.1732279421092; 
 Fri, 22 Nov 2024 04:43:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:dc89:a5fc:6ee6:7cb2?
 ([2a01:e0a:3cb:7bb0:dc89:a5fc:6ee6:7cb2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc4173sm2382652f8f.72.2024.11.22.04.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 04:43:40 -0800 (PST)
Message-ID: <d4546db0-7e09-418c-9887-27c0abf85893@linaro.org>
Date: Fri, 22 Nov 2024 13:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: fix dhcp_loop()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20241122123558.74702-1-jerome.forissier@linaro.org>
 <CAC_iWjKvaai-kraH=NXrzDAtZYJSrr1GV3520KbKGy+3zxx7HA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjKvaai-kraH=NXrzDAtZYJSrr1GV3520KbKGy+3zxx7HA@mail.gmail.com>
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



On 11/22/24 13:37, Ilias Apalodimas wrote:
> On Fri, 22 Nov 2024 at 14:36, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> The local variables ipstr, maskstr and gwstr in static function
>> dhcp_loop() cannot be pointers to read-only data, since they may be
>> written to in case the device index is > 0. Therefore make them char
>> arrays allocated on the stack.
>>
>> Reported-by: Ilias Apalodimas <ilias.apalodimas at linaro.org>
> 
> @
> But I guess we can fix that up during merging

Sorry about that. Bad copy/paste from the ML web page ;)

-- 
Jerome

> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  net/lwip/dhcp.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
>> index 23b56226921..bfc72ca6c57 100644
>> --- a/net/lwip/dhcp.c
>> +++ b/net/lwip/dhcp.c
>> @@ -27,9 +27,9 @@ static void call_lwip_dhcp_fine_tmr(void *ctx)
>>
>>  static int dhcp_loop(struct udevice *udev)
>>  {
>> -       char *ipstr = "ipaddr\0\0";
>> -       char *maskstr = "netmask\0\0";
>> -       char *gwstr = "gatewayip\0\0";
>> +       char ipstr[] = "ipaddr\0\0";
>> +       char maskstr[] = "netmask\0\0";
>> +       char gwstr[] = "gatewayip\0\0";
>>         unsigned long start;
>>         struct netif *netif;
>>         struct dhcp *dhcp;
>> --
>> 2.43.0
>>
