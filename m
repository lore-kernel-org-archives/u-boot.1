Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475F9C4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 14:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F6F87873;
	Sat,  3 Feb 2024 15:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="gcikDp3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28F3880E8; Sat,  3 Feb 2024 10:59:57 +0100 (CET)
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com
 [203.205.221.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F37B880D6
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 10:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1706954384;
 bh=6qyCIP9ogBHgEUwQHfuHqTgz9O20W9L32Q8bHjLfejs=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=gcikDp3ICuWfG1NjpC7DQgSzN3OTWm1JM7cyhD+8wMM0U5QK4L7mlF+n0+6y6z5Hk
 b7f2gKRaNhUnX0AbiEVG+skKWwQg9K8Pp7obZNfCcsAqosqCMXFLy4T0e5h/Fc+ypx
 SU0RG4RpwlFtIw+8J4zEzMMZKXm75ZMw/mF9BtjE=
Received: from [IPV6:2409:8a4c:807c:e7c1:c8d:b527:44bf:a351]
 ([2409:8a4c:807c:e7c1:c8d:b527:44bf:a351])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EEA81249; Sat, 03 Feb 2024 17:59:42 +0800
X-QQ-mid: xmsmtpt1706954382thyk8x2en
Message-ID: <tencent_BB07FFFEDC5A344A385BED0EBA35F0ADFB06@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uQ4zYlMLb4ZNy1jbP7KgQjREJELV6DyD6JxyX+BqqFAD+MRsVpl
 TjTgBg3idhwqUwz1ly8uzMcCzWAqh7t5nbCuo/GKtWkvzZSPdiOjCVsbsJ8RLgIb0luBsDjp3/QQ
 BmbzWofj7dRIVvFtZaS9DkVWMYhYG0vw3Eon/+rQaJJ/dCIEI+wwfasYDOd4dYUB+v+sfrXkchb6
 exz/9RdPS4m50jq5w/s7qFFsnBKTUNwU6hYunyFax325+b4oSyybuBB6PSyuzqzqY3WkBQ86fVn3
 VbXfSLa9xaQHJhvSxx0uTZsKJ4e2pD97UTYWNXJOfr/yv9ogFESQ2xMDqzM2cLdcd6ZJDbo1dH9m
 jzN25j304QQ0WfEuwg62NTOtvvkzLjy4i2WiWBTDU0cPmqRObO1afkvJxLA49LypVm7KwA5RrF+D
 qKm0veqtW6S//A63yvLc6I9/KdoCqMXA49ATJZVas4OPOav7v3WNVdny7mX9MBagJTJa8w5K3GhQ
 2Nm6sotaGIFO/5/HSrkpKhaooo6YT8qoqFWq+2EZuMcm9eNQ6O/EWdtdkR9twZr3ZnMeXB7c4UxS
 wbxDxzQr+YR5AGtlgEwZqXPLb+4kIsKi8fpG6a8gyP//iiqdxEd4/NhPiGZXYFYFHZ2oW6B6hAfq
 7/fR0nAxklCfLIESJzhnlLY0SW++d8HuAZO8kUoFFN4zfp63IRFHQAj6nG5UgMuXuTDKbXhi2Ysv
 vA/1sWQJ7saE1OgP5ZOUduhwviU3gULa/sCr4O8GTj/5rvt4u7KZhbZs4cTQyCLzfGN6AT+w48cJ
 OfEMpP83Zvr7ofLXMrRcMzgbVdX5yEsk85ARnLPmCyDIsULNlHyfxLLAqZfkUMnVEDZXM9um/3Fq
 Hpu80CvfRW8nIt3LQvGPF82j3O0/GLsge+dSxJjkruB2IGm3uI851duiwYwjV8pqzh4DKmkL3tCm
 l+TsvTQu4dzZMd3a8oKPj67EdIrfaHB4Mn6z1vSSxQd4x3rcthaD31e5GyQI5G5FRguq4x/eACmd
 RF/ckQSzyKo8k4L9F/LyjW6JrWA10W+tiYbv9DdQ8QsvXHYpvV
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <c7e31412-25bb-4133-8334-5edbed1e37c8@foxmail.com>
Date: Sat, 3 Feb 2024 17:59:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] poplar: add myself as co-maintainer
Content-Language: en-US
From: Yang Xiwen <forbidden405@foxmail.com>
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
 <CAAQ0ZWRFak3LwsSVCxi7sd6AmpJsegdv6A4Y=piwb8eStLTjLw@mail.gmail.com>
 <Zb36M+p4z2+zd+XB@trax> <tencent_0A657770FEC7B98668A070C65A10F4166007@qq.com>
In-Reply-To: <tencent_0A657770FEC7B98668A070C65A10F4166007@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Feb 2024 15:12:12 +0100
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

On 2/3/2024 5:45 PM, Yang Xiwen wrote:
> On 2/3/2024 4:32 PM, Jorge Ramirez-Ortiz, Gmail wrote:
>> On 03/02/24 07:54:22, Shawn Guo wrote:
>>> On Sat, Feb 3, 2024 at 5:44 AM Igor Opaniuk 
>>> <igor.opaniuk@foundries.io> wrote:
>>>>
>>>> Add myself as co-maintainer for Poplar board, as I'm currently
>>>> working on it (re-testing releases, addressing issues etc).
>>>>
>>>> CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
>>>> CC: Shawn Guo <shawn.guo@linaro.org>
>>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>>>
>>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>>
>>> I'm not actively working on poplar any more, so maybe remove me in 
>>> the meantime.
>>
>>
>> hi Igor,
>>
>> Yes please go ahead and thanks for offering.
>>
>> I'll sync with you later next week (I found my Poplar in storage, so 
>> maybe we cam improve things a little)
>> Also it would be good if we knew there are still users.
>>
>>
>> Acked-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
>>
> Hi, everyone. I'm working on a set-top box with a Hi3798MV200 SoC. It is 
> very similar to the Hi3798CV200 SoC and many peripherals and drivers can 
> be reused. I think you can try moving 
> arch/arm/include/asm/arch-hi3798cv200 to arch/arm/mach-histb and let's 
> maintain all HiSTB series SoCs/boards under it altogether? The same 
> thing also applies to TF-A. Currently upstream code refers to poplar 
> everywhere but actually the port is portable enough to handle a lot of 
> other Hi3798-series SoCs such as Hi3798MV2x, Hi3798MV3x etc..
There are some patches i sent pending for review. They are mostly 
originally sent just for Hi3798MV200, but the framework(such as 
drivers/clk/hisilicon) can be also used for poplar too. I hope you guys 
can take a look at them[1] and give your opinions about them(RBs and 
Acks are welcomed).

[1] HiSi clk framework: 
https://lore.kernel.org/u-boot/20240119-b4-hisi-clk-v1-0-279e38c95ca2@outlook.com/
>>>
>>> Shawn
> 

