Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BD4C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 15:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C32888A4;
	Wed,  7 Aug 2024 17:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y3uE0h6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693CA8882F; Wed,  7 Aug 2024 17:07:02 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F37D888BC
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 17:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7abe5aa9d5so237435766b.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723043219; x=1723648019; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KjKK0dbTInudzCJbi2UFlWFbaTnd2r+VG4m7pm6OeEw=;
 b=y3uE0h6tlQbOOScl79DtW4ofnRL+dlzgOzdf4/xSjXnSsq2QXFQDnmpdZSswdK3H0h
 2Rot9mx6+yWZgnvwwy8IOEw9ikf8+KDeqgDXSF1zrf5j4ggYyfXb++kmjRbzZywG06XH
 WYxbiqk2gxG4NWb0/kFmRwvz1wfpeXFAoYmjqkvgZIeYc+EyaGLEpAA3BOfhhyIf4FbB
 rPLFKQXA2RzgDOZhnIz29YloBfOrT1hNxjzA/dr+dZmwQ1juYQ0D5Fq62+rz5XFCw5H+
 snq+2tzuHKqvpBNDxAzqJAgpiB7qE5rpRuxofuXZo+bVpy1H6XeNbAxJ3Xi088PpWlhQ
 u3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723043219; x=1723648019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KjKK0dbTInudzCJbi2UFlWFbaTnd2r+VG4m7pm6OeEw=;
 b=YxjTs4y9/t9hutqO3/sRDtgtFVRMeg1nXqD9LlMURzqNWFXZogHFogAlh6xIsqbzLQ
 NUhWuMNz7bG4CLuWUmaKyy8RIEoRSVLmmos+qefHh/SyDTkJRDnRSwY++MqQIpKll1xc
 440y4DSoXRhdHZrksP+kY2mVxBu4Es55B62lrIBH19inaS8QdhaXPBz2YVhfI7a9cMJ8
 q9uHNH3f279vS5hZpOpQQlN+/Ezea2NPOcpkID6mUhAocs1a9JeNk0Wc7oLMOn1RTpUh
 Y7TYy3i/A09nR2pEjsd7YO/nO9Shq31FgioDbD8s1lkiQlAorWsRF624LwCthb22RGV+
 nlBA==
X-Gm-Message-State: AOJu0Yxfgo4blUy+Igz0QkOSTwiUndZ2Fl8/ibVJtwcuIQXxUy7RenEq
 mcizCM7lkSlaH2x+u5exzmF2tyjLdhDKT9qrYryvZ91b9HfcMeayVwQvgpT4HGU=
X-Google-Smtp-Source: AGHT+IGCsJ4p3w0kXYibkEbrOl/js00KljD+MyUwOVPAqnDUFIfdNzgSxiDgZTReaACKzrqfxhUO6Q==
X-Received: by 2002:a17:907:a0c8:b0:a7a:cf39:ae73 with SMTP id
 a640c23a62f3a-a7dc510800cmr1314315566b.64.1723043219205; 
 Wed, 07 Aug 2024 08:06:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3c20:d905:6027:2354?
 ([2a01:e0a:3cb:7bb0:3c20:d905:6027:2354])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ecb1c3sm645295066b.225.2024.08.07.08.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 08:06:58 -0700 (PDT)
Message-ID: <a545a465-81a0-4c58-a932-0db7e53e55af@linaro.org>
Date: Wed, 7 Aug 2024 17:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat> <20240725223401.GD989285@bill-the-cat>
 <ebc992d6-93e8-4e7e-99dc-834cc981f5a3@linaro.org>
 <20240802201635.GQ3794063@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240802201635.GQ3794063@bill-the-cat>
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



On 8/2/24 22:16, Tom Rini wrote:
> On Thu, Aug 01, 2024 at 04:40:03PM +0200, Jerome Forissier wrote:
>>
>>
>> On 7/26/24 00:34, Tom Rini wrote:
>>> On Thu, Jul 25, 2024 at 11:22:20AM -0600, Tom Rini wrote:
>>>> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
>>>>
>>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>>> reasons for doing so are:
>>>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>>>> so. With that it becomes possible to fetch and launch a distro installer
>>>>> such as Debian etc. using a secure, authenticated connection directly
>>>>> from the U-Boot shell. Several use cases:
>>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>>> binary with a different one)
>>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>>> image as it is being downloaded
>>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>>> (this is becoming more and more common on the Internet these days)
>>>>> - Possibly benefit from additional features implemented in lwIP
>>>>> - Less code to maintain in U-Boot
>>>>>
>>>>> Prior to applying this series, the lwIP stack needs to be added as a
>>>>> Git subtree with the following command:
>>>>>
>>>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>>>>
>>>> This is better than v4, and on the hardware platforms I could build and
>>>> boot on (which was most of mine except the am62x_beagleplay), the tests
>>>> ran and completed, including the tftp+boot a Linux kernel.
>>>>
>>>> The bad news is CI blows up, a lot:
>>>> https://source.denx.de/u-boot/u-boot/-/pipelines/21764
>>>> And:
>>>> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis/build/builds/9014/logs/106
>>>> which is another Kconfig dependency problem. I don't _think_ I
>>>> introduced that, but since this wasn't against top of tree, I had to
>>>> apply the cmd/Kconfig patch manually.
>>>>
>>>> I have my world build running still and may have more comments based on
>>>> that.
>>>
>>> First, with NET_LWIP being default rather than NET, there's a lot of
>>> other Kconfig dependency issues. Unfortunately I don't see an easy tool
>>> for making sure this is all clean aside from a shell loop like:
>>> for C in `(cd configs;ls)`;do make -s $C;done
>>
>> I have run this loop successfully with the upcoming v6 version. Some
>> configs do print some warnings but there is no error.
> 
> Oh. Right. So, to make the rest of the problems show up, switch the
> default stack to NET_LWIP and then we see other issues.

Indeed. I fixed a couple "unmet direct dependencies detected" warnings in
v8.

Thanks,
-- 
Jerome
