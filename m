Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EA2C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 14:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9DB87968;
	Sat,  3 Feb 2024 15:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="X3hYi4ks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20D287CED; Sat,  3 Feb 2024 11:33:50 +0100 (CET)
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com
 [203.205.221.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150F187CBE
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 11:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1706956421;
 bh=0MClFFMtE9S+/8bpVZTEKJZHPtoPYlLMAbDNS8L0i/Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=X3hYi4ksiKlO/uCnfZ5HsnfZnv8/Lc+82J72tVxoWBcq7RQfoZL7g9scvV1Yn1lLH
 QJ9Pa+ZV3lj922WQgwr87ZKXw2UzzmEanh6XmKOr3v8+S/ZnSvzzio4gf0TkchXsAR
 PrNYDaZ3Ll7emDNVJS6kU+nGMvsirtUN2GFn/HVo=
Received: from [IPV6:2409:8a4c:807c:e7c1:c8d:b527:44bf:a351]
 ([2409:8a4c:807c:e7c1:c8d:b527:44bf:a351])
 by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
 id 867854F8; Sat, 03 Feb 2024 18:33:39 +0800
X-QQ-mid: xmsmtpt1706956419t2jy5gc77
Message-ID: <tencent_D52DF41AE002F7337EA9B99E68CA70C1DA07@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+VKkU/viHmodpER5qGj1FYWBSqrAzJRFFh/AU9ezqIx8sD5W0ww
 7tltPoZo1U4Wi+XIJh5B9Q9bHJsARNpiJdJSFGANiXR9Xtz9/q1T9itRP+6Kr4mSj4tINEOZo775
 uRHsuIxaPw9fJWeCnhZ/DSLkHW4lEC24kH2T8RVQ7rhDljdxk07T5B4FbEeoR5jEfPhoUL8NKrcR
 9d2KPwUNPH3wwKuBEcEkj3yBvBTGW2i6xdfXELQilU8n/aitUDS/vaBB2Od4RGnB7Q+VJDIZWKAP
 W/RXDV/adWuIDuaPHKXUP9IN7/0wNIxZtPkKbTtjsh8ofVzSJA8CvP069iusx4TNsXw3AOZo/mey
 Xg+xNbuijIoSSq7UTFAv7qgS8SmDXoDUbAnyGjXlxm22B9eo+msO89v+BKuWXvu9osKz50dcYDGb
 5nOWxDfcierSyhCpu3UPsKQt7dcNjF66rf6L39Vk0UiS16LV5JhO5c2Z2WwpybvW+EDrHhRMgJqq
 dN7g/cly2R+RReAQwqu5eMJRwSc6VpCn19qD6/gZAWViGsauvE2aZQqTolO0b4m7h/pHumezGQEH
 wMTc5njyT0YFAYUfzNNuHHwrIX0351HU4VpTzrfpbqPwAq9eaXkgXihQ33v5J7tpfyKZ7zfWgNNd
 UxSR0XFHFxxCBwFT8kQh+9kdN2/lJ8zXokTO+5ALyo+m4HDgnvEl4+vORFTZ9rH2MJzK6HRNNnYW
 Kjhn36cnicQ+5WZnGF+iQCY4Ls76WrGHkL435ZSOveNei/S2EdhptA3Zyojyb1Lxzd64jmVYdpgL
 X+b3mh+nHb7x5DPOu73bNMPuq2MbHNGLJ4NVMh0I8HRWoeOT+RxQRUkxWD0M9g31k8oOPMEa2vJr
 0OQwMsiAGdcX/aIrYGgz5WuTWYt9edm2UMOwz9U0Wo7MjRcZqMWU2QtxEy4UHTvUlDgOBEU4ho2y
 ZeCSro5l9l0qdaYKJb3tSKPOjRQfZP7uvjK1MJH1to1p1kzjy/wqyCUj+S9JPYXiYia31lHzXKsp
 RdmLH6XpI3JeQSsHd0PGWHf4dsmRPZC/bI0VeTOr0A1L1J4MXp/FhyRKkVHSLn2gSX6CqeGd77YB
 M262r+
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <6366c731-a4b0-4120-b78d-4e4aa62662da@foxmail.com>
Date: Sat, 3 Feb 2024 18:33:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] poplar: add myself as co-maintainer
Content-Language: en-US
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
 <CAAQ0ZWRFak3LwsSVCxi7sd6AmpJsegdv6A4Y=piwb8eStLTjLw@mail.gmail.com>
 <Zb36M+p4z2+zd+XB@trax> <tencent_0A657770FEC7B98668A070C65A10F4166007@qq.com>
 <Zb4TLv2E58KvrgCO@trax>
From: Yang Xiwen <forbidden405@foxmail.com>
In-Reply-To: <Zb4TLv2E58KvrgCO@trax>
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

On 2/3/2024 6:19 PM, Jorge Ramirez-Ortiz, Gmail wrote:
> On 03/02/24 17:45:42, Yang Xiwen wrote:
>> On 2/3/2024 4:32 PM, Jorge Ramirez-Ortiz, Gmail wrote:
>>> On 03/02/24 07:54:22, Shawn Guo wrote:
>>>> On Sat, Feb 3, 2024 at 5:44 AM Igor Opaniuk <igor.opaniuk@foundries.io> wrote:
>>>>>
>>>>> Add myself as co-maintainer for Poplar board, as I'm currently
>>>>> working on it (re-testing releases, addressing issues etc).
>>>>>
>>>>> CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
>>>>> CC: Shawn Guo <shawn.guo@linaro.org>
>>>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>>>>
>>>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>>>
>>>> I'm not actively working on poplar any more, so maybe remove me in the meantime.
>>>
>>>
>>> hi Igor,
>>>
>>> Yes please go ahead and thanks for offering.
>>>
>>> I'll sync with you later next week (I found my Poplar in storage, so maybe we cam improve things a little)
>>> Also it would be good if we knew there are still users.
>>>
>>>
>>> Acked-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
>>>
>> Hi, everyone. I'm working on a set-top box with a Hi3798MV200 SoC. It is
>> very similar to the Hi3798CV200 SoC and many peripherals and drivers can be
>> reused. I think you can try moving arch/arm/include/asm/arch-hi3798cv200 to
>> arch/arm/mach-histb and let's maintain all HiSTB series SoCs/boards under it
>> altogether? The same thing also applies to TF-A. Currently upstream code
>> refers to poplar everywhere but actually the port is portable enough to
>> handle a lot of other Hi3798-series SoCs such as Hi3798MV2x, Hi3798MV3x
>> etc..
> 
> Sure, if this is indeed a family we should do that (documentation was
> scarce back them when I did the initial port).
About docs, I've got some. But still, some critical datasheets are 
missing. Most peripherals are the common ones, like DWC3(USB), 
PL061(GPIO), DWMMC(eMMC/SD), PL011(serial), SP905(watchdog). But there 
are some cores that are difficult to find docs. e.g. USB2 INNO PHY, USB3 
nano PHY, PMU, TZPC/TZASC, HDMI etc..

Please ping me if you find some documents about them. Especially PMU and 
USB PHYs, it's quite hard to write a mainline driver for them without 
datasheets.
> 
> maybe you'd like to take a stab Igor?
> 
> 
>>>>
>>>> Shawn
>>

