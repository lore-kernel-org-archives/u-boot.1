Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C23C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 15:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E2C881A2;
	Mon, 26 Aug 2024 17:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PT664hAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7512881A5; Mon, 26 Aug 2024 17:08:14 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6524688009
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so39192725e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724684892; x=1725289692; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xh2ae1nMmlHlhjOsJcutG8226FPrmKEmv0s4RbnnyYc=;
 b=PT664hAzZK/wP9D8Q1NybiFWX9HIpmCBFtyA8FdFa1/dfStfWxrbQxyjQXEjlkDJfE
 OARLYdHXxur1QPIrXeYKI52XMoWgzFnaQRWjI1omVbAgkXkeCo4tfvfiY7K+GI4f9xLL
 azshn1HEKttTf1QFuLDUgh/mzTCI4qeg2e5KRlUzbz4ewd5vyhEg/0xGYOHdZmG25N7t
 Nn1/yq2nCs+1cNw7INm1KpTrXt2mc+3wazzEyrZ9JJUSb9il9yZQFnpCrO2RRpkFLum9
 snigKTs19U1YtjEOTXTZlkGa18hbkYlNVXX0AyOmjSzAeaRVc5UepnOhLn/A9sTlofg4
 ZgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724684892; x=1725289692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xh2ae1nMmlHlhjOsJcutG8226FPrmKEmv0s4RbnnyYc=;
 b=gBFvz4svBtt8knx3UBwsr9Dx34dZUA9ysnB3hzK9IaHpcFXJ+S2auJiDsn5jDmfgtY
 guytj4HUrQ/JJCGsaaJnRrNbv0Xrpp807a9AAY/78sjK1yJcw99D6y+pz7rGjnd7yvqi
 o73OsoCiiZ1sSDThxiN+OOzO22dHaBMKhL6WBrKxgBFEJHkSzY/72OofE5QJYTQSJYee
 WzgLw0howXNLk39mMlqwwzNmNy5z5YLlK4nKCZ0KhOxvYS0dNgq+oXNkOsMHginGQvt3
 UIg0jD8ze2WNi/n1TKGzF/1QV8pwFYdvfHX0Ye407pa9xvmmh28r0oHoreThIW0DXdPe
 EQoA==
X-Gm-Message-State: AOJu0YzCPoaUFzIL0iEj7B6nMdkB+QX79HCaiuniqIBz/TqOQPr/EkU2
 5EOXMzGRMMRb0/mB+mmV2Yni2Ug2/W31enQ0AUOKsJPI/VL2aNoTwiC6pt/Ugnw=
X-Google-Smtp-Source: AGHT+IFWJ7z6KcZDOhdS4/NdBRdMMfVacG4AwncgG6O/5agan9ndkar2Q33d/f76TGeK43oIT/Zvcw==
X-Received: by 2002:a05:600c:3c9e:b0:428:141b:ddfc with SMTP id
 5b1f17b1804b1-42acca01336mr74909045e9.31.1724684891467; 
 Mon, 26 Aug 2024 08:08:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:600f:f83:7439:fd9c?
 ([2a01:e0a:3cb:7bb0:600f:f83:7439:fd9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac518038asm158331035e9.45.2024.08.26.08.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 08:08:11 -0700 (PDT)
Message-ID: <9e04c58d-1d34-4073-a4e4-db22311bfd44@linaro.org>
Date: Mon, 26 Aug 2024 17:08:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/23] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <20240823211825.GZ1626301@bill-the-cat>
 <12d558ef-6c76-4ae5-9aa3-7e34eb5e2a60@linaro.org>
 <20240826144714.GF2479150@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240826144714.GF2479150@bill-the-cat>
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



On 8/26/24 16:47, Tom Rini wrote:
> On Mon, Aug 26, 2024 at 01:45:10PM +0200, Jerome Forissier wrote:
>>
>>
>> On 8/23/24 23:18, Tom Rini wrote:
>>> On Fri, Aug 23, 2024 at 03:48:04PM +0200, Jerome Forissier wrote:
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
>>> As an odd thing, the series leads to ethernut5 failing to build,
>>> strangely over the RTC driver it uses, for me.
>>
>> Weird.
>>
>>> I did have to manually
>>> merge the CMD_WGET related patch, 
>>
>> Weird.
>>
>>> but I don't think that was what went
>>> wrong here.
>>
>> Could you try to build from GitHub perhaps?
>> Branch https://github.com/jforissier/u-boot/tree/to-upstream/v9 builds
>> fine here:
>>
>> $ ./tools/buildman/buildman ethernut5
>> Building current source for 1 boards (1 thread, 24 jobs per thread)
>>        arm:  w+   ethernut5
>> +===================== WARNING ======================
>> +This board does not use CONFIG_DM_I2C (Driver Model
>> +for I2C drivers). Please update the board to use
>> +CONFIG_DM_I2C before the v2022.04 release. Failure to
>> +update by the deadline may result in board removal.
>> +See doc/develop/driver-model/migration.rst for more info.
>> +====================================================
>>     0    1    0 /1              ethernut5
> 
> I think you weren't on latest next branch when you posted v9, and that's
> at least the merge conflict. I see the platform builds on your branch as
> well, but fails still, on mine.

I was on latest master as recommended by the documentation [1] but perhaps
I missed an announcement that next should be used instead?
Anyway I'm looking into the issues now. Thanks!

[1] https://docs.u-boot.org/en/latest/develop/sending_patches.html

--  
Jerome
