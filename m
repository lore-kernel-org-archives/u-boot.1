Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4857BE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0958012C;
	Fri, 13 Dec 2024 15:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TAFYXArd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E344D80137; Fri, 13 Dec 2024 15:24:16 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66EF380104
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6390=TH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1734099846;
 bh=/lRGwqiTqgLhpDhA3woUKq4Q6xfvTe0UmrmZhdaWGd4=;
 b=TAFYXArdyuNzSyzalJDMIuyHQ9nvdE2WGQrl5FNkwj98UANBrJrYPbI5Fa/TtrlMq2ASvG2Wh
 n4cjA0s23peId8FSOJJi4u6TfZH78S+HNUCpEAuuPIwARCSacspCwAnauvcL5M7KY1uEbkiRYsR
 eHYh/IdzaU279Z+83xoaHenDJFmqh9z+Z1cf1bwTdK/OFhfK9WbGaHAni60KGcwsFWTnWTB9Rzh
 +LLATvzvnKxS+q8QVFUnIo8uHvMAmCmwYAP/L9eh54Txkx3/6YfkGxOXWYtxgBOJruRBj2dGTEj
 i2waGERnArm332E6V2lRmgxeUdC5/t51cq1A5UQqAlNg==
Message-ID: <f890f264-e4e9-4216-8b6d-10062c978edb@kwiboo.se>
Date: Fri, 13 Dec 2024 15:24:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3588-generic: Enable support for RK3582
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
 <20241210222341.3537543-3-jonas@kwiboo.se>
 <362cb14a-5f41-4d9c-ba98-121b7f3d893a@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <362cb14a-5f41-4d9c-ba98-121b7f3d893a@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675c438496abc14790b83bc3
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

Hi Quentin,

On 2024-12-13 14:45, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 12/10/24 11:23 PM, Jonas Karlman wrote:
>> Add Kconfig option OF_SYSTEM_SETUP=y to support booting boards with a
>> RK3582 SoC. CPU and GPU cores are failed based on ip-state and policy.
>>
>> Tested on a ROCK 5C Lite v1.1:
>>
>>    cpu-code: 35 82
>>    ip-state: 10 00 00
>>    fail gpu
>>    fail cpu cpu@400
>>    fail cpu cpu@500
>>
>> and on a Radxa E52C:
>>
>>    cpu-code: 35 82
>>    ip-state: 00 04 00
>>    fail gpu
>>    fail cpu cpu@600
>>    fail cpu cpu@700
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Can we add RK3582 somewhere in Kconfig, documentation and all?
> 
> The idea being to show that we actually support this SoC with the RK3588 
> code. Not everyone would be aware of that.

Sounds good, I will add something to documentation and Kconfig option
help in v2.

Regards,
Jonas

> 
> Cheers,
> Quentin

