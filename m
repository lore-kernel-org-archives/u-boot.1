Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DB0C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4057A81E25;
	Tue,  3 Jun 2025 16:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fEh2Ty6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F8282A76; Tue,  3 Jun 2025 16:13:37 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2A780F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad89333d603so1091058566b.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748960014; x=1749564814; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=keROR8EKQ+sBwdW/jkRTZwOie2ciYqMwaqN/Gji4ekU=;
 b=fEh2Ty6MqblIoyd5EAYNWvCWnJx1EOfxoYyE4FmGXktnLpXi4XOTulQcQ+A+eUrigA
 mLBpUD+yjyEDdJf9DAoj10GXns1VjJjvS1IxPXLj9JvWH2XXb/P8kSNacJrJ8lzq4LuQ
 LWn5J652fMnma5h3Qv/XUWui92gEaYfC2AKmImOAGzmYXTIB9608kdKYNLPwUrDZHzQw
 fPyFLD6p9j3wfu5/BZi9u4+HbAL6rKqXC60s7lnxKmem22u01/1Si91m77SagyTMvs0l
 pC9UFe7mSGMjvQ7WymoMltd5/GCA/6kB3JynRHNK2EpFOzfBUc+/GsIziImZ7mYS3ckL
 zLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748960014; x=1749564814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=keROR8EKQ+sBwdW/jkRTZwOie2ciYqMwaqN/Gji4ekU=;
 b=BlQhQ/8fxn5B8ot2z3+Czlew0JH6UVqKTx653cZrR2VL2ZC/7+8Xq2nPhwzMdP9I4R
 zm0s3RA5Cu6NRLNTD1SzJEKkolLp9I0ORrP1I6iSp/ByV+GhH4bD+AaRsbmXd/R37xpY
 ptVV6Lqus1pwsk7EboVVVVJRGn6ezgtOOLgx1fQOU3cWOh4aGIpc+o12hxuXGDTpU1HT
 pmpAkC3leQjptnvzK4yk0YiV2l1rxy5uTJUVY8hYgne+6SY8OrfH1Q4lFM5g2hnjG1S6
 2f8ni2uSR8uO9hEOSpBhJGutfPyl9a4URD7XNyrJnLIo5IQ13Ec/p9qFCdWDzYgZ2dBe
 P2GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/e0hHjdDyYXypr+G/7V6mQFPgI+MN2RpV25sMUpudWxssgPDXD6kx7fFxbMUzgoWuNw5mD84=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+o8W3uFzbWQXqWB2bnYXGn5gSQ8a3I/2Th2TNgeaj1idc2t4Z
 bpCnxCe2TL39s///iegd2BbdbQmG2XOXNrSNQA6PIo8rRERzb6qOPYtdpXiiSny7nT4=
X-Gm-Gg: ASbGncvH/Da2d2PKWlvWUn8SaHWN1m/2Nmh6BaSqIJNKLzzAPh8m/ly7V9LXxas+UEG
 Ip67Wc3rMUTNzdEs/9KEgNVWiItW6VkxmE0OxUTTuGPICBdCgqjs/5gi939/RZLUhg2Wl9v5UHc
 1gNpd0scZGhTDVjwwZCZHoFmZC4iz0wcOS3oewZ8pKwGbB3Dv/QxKMqG+HwSSFTbNimpOAWiPCd
 zCRdZT02QYv4E0bNb3LWYSdbJJCmuTTFVjHSF7naG9cMEuqS2X6sazokWuCUHEQDAj4x9MnsIkh
 8LqOe5MplhgNZPuFni5AyMGy+9YU7G7tZ4+rP5S3CXQNc6Jlr2EKsZTAfCw=
X-Google-Smtp-Source: AGHT+IFsOu2bckFcftRYROGavawz+TJAC1iabgBsUB4BKNvfX8As+DNc0yqAWZbpjVgbbGuq5Culjg==
X-Received: by 2002:a17:907:7b9e:b0:ad5:d597:561e with SMTP id
 a640c23a62f3a-adb32439f94mr1585065666b.56.1748960013908; 
 Tue, 03 Jun 2025 07:13:33 -0700 (PDT)
Received: from [10.5.0.2] ([194.15.111.82]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd045edsm951658366b.119.2025.06.03.07.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 07:13:33 -0700 (PDT)
Message-ID: <9be491bb-ea4b-4643-be20-39c3f9961cc9@linaro.org>
Date: Tue, 3 Jun 2025 16:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: lwip: add sntp command
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <20250521151516.16729-3-jerome.forissier@linaro.org>
 <C092D71D-1A30-44D5-8043-07EE04DA571B@gmx.de>
 <3f6c6f3c-ac48-4f24-bb64-23e86fbeb5fa@linaro.org>
 <20250603140659.GC1382132@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250603140659.GC1382132@bill-the-cat>
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



On 6/3/25 16:06, Tom Rini wrote:
> On Tue, Jun 03, 2025 at 03:49:05PM +0200, Jerome Forissier wrote:
>> Hi Heinrich,
>>
>> On 6/2/25 23:23, Heinrich Schuchardt wrote:
>>> Am 21. Mai 2025 17:14:42 MESZ schrieb Jerome Forissier <jerome.forissier@linaro.org>:
>>>> Implement the sntp command when NET_LWIP=y.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>
>>>> cmd/Kconfig                |  13 ++--
>>>> cmd/net-lwip.c             |   5 ++
>>>> include/net-common.h       |  11 ++++
>>>> lib/lwip/Makefile          |   1 +
>>>> lib/lwip/u-boot/arch/cc.h  |   4 ++
>>>> lib/lwip/u-boot/lwipopts.h |   4 ++
>>>> net/lwip/Makefile          |   1 +
>>>> net/lwip/sntp.c            | 128 +++++++++++++++++++++++++++++++++++++
>>>> 8 files changed, 161 insertions(+), 6 deletions(-)
>>>> create mode 100644 net/lwip/sntp.c
>>>>
>>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>>> index f21d27cb27f..58f629e1c34 100644
>>>> --- a/cmd/Kconfig
>>>> +++ b/cmd/Kconfig
>>>> @@ -2061,12 +2061,6 @@ config CMD_CDP
>>>> 	  and to retrieve configuration data including the VLAN id using the
>>>> 	  proprietary Cisco Discovery Protocol (CDP).
>>>>
>>>> -config CMD_SNTP
>>>> -	bool "sntp"
>>>> -	select PROT_UDP
>>>> -	help
>>>> -	  Synchronize RTC via network
>>>> -
>>>> config CMD_LINK_LOCAL
>>>> 	bool "linklocal"
>>>> 	depends on (LIB_RAND || LIB_HW_RAND)
>>>> @@ -2144,6 +2138,13 @@ config CMD_PING
>>>> 	help
>>>> 	  Send ICMP ECHO_REQUEST to network host
>>>>
>>>> +config CMD_SNTP
>>>
>>> The command should depend on RTC support.
>>>
>>>> +	bool "sntp"
>>>> +	select PROT_UDP if NET
>>>> +	select PROT_UDP_LWIP if NET_LWIP
>>>> +	help
>>>> +	  Synchronize RTC via network
>>>> +
>>>> config CMD_TFTPBOOT
>>>> 	bool "tftp"
>>>> 	select PROT_UDP_LWIP if NET_LWIP
>>>> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
>>>> index cecf8d02555..2ffee64f97e 100644
>>>> --- a/cmd/net-lwip.c
>>>> +++ b/cmd/net-lwip.c
>>>
>>> Please, put every command into a separate file instead of duplicating the #ifdef chaos of the old network stack.
>>
>> While I agree that cmd/net.c is painful re. #ifdef's, I believe
>> cmd/net-lwip.c is not bad at all. In fact I took care of having only the
>> command wrappers in there (U_BOOT_CMD(...)), so it's just 55 lines at
>> the moment. The implementations are in
>> net/lwip/{dhcp,dns,ping,sntp,tftp,wget}.c. So I don't think there is
>> a need to change that. Or I could move the U_BOOT_CMD(...) into
>> net/lwip/*.c as well, leaving only the non-net commands under cmd/ (apart
>> from the legacy NET stuff).
>>
>> Any opinions on that?
> 
> While there are commands outside of cmd/ they are the exception (and
> generally ought to be moved) so if we go the route of breaking up
> cmd/net-lwip.c I'd rather see cmd/lwip/${cmd}.c instead.

To be clear, you mean moving net/lwip/${cmd}.c into cmd/lwip/ in addition to
splitting cmd/net-lwip.c?

Thanks,
-- 
Jerome
