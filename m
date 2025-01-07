Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F063E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 407AE80609;
	Tue,  7 Jan 2025 12:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736249108;
	bh=j7k75kbmBlZspX0xcgCj/MVWw0a7UgQvRw7oNefqXio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hX6fD+D30jNr1koahdeCcf10KHmOAkr1t+szD6bGKlLnnBoqEOh6LFO2YgXAVZge+
	 z8Asi0NnwCkavUtsl1mMU19u8pMeJt0uKy4LqTIKLIQd0VGK+Vddc4cVITIQvVS88A
	 9Zb3vNebU4V9JxfqRdBqHowBLhj75rdO4U5FU0ySNoLFZ9duKTwQafRavmmSq7VVMM
	 2LW3DeLua3IxmIuTQQTYfVGTPjBAEqRLC5x44UMZsgOKs2AwlogT+7wXVj8Je32IV6
	 lksdNwLF+J73TbHq+iP88JIKOkRKS8ryuPvuP7NdkJ7mcTyTFHHkeGDJmDarFSrNHm
	 46cW8i0oqDWGg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52257805E2; Tue,  7 Jan 2025 12:25:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EE48805EA
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LL8x9eCT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C5D2104811F3; Tue,  7 Jan 2025 12:25:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736249102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j7k75kbmBlZspX0xcgCj/MVWw0a7UgQvRw7oNefqXio=;
 b=LL8x9eCT4gEmD2dRN+TYXeBi7KH3TO4OeUfiFoB/lHX5AF3eYAdiQk8X7SGzjbWg08wmSX
 hUG0t+4ZO0bJXyP0KJafmqUGPKZ+NgfK2u0Dtdj8YK4gm4o+t9BDWSZSC8orPOllkWe18G
 9Vd0TL1QYJW3cEfs+bqMPzq4Vo9Q2Z9dRH4Cr/RYS0OAXy9cBNczR+EyvWRpv916tdPD6w
 n0yb61W5LGt29i8f9eACpEwdmYSAO/+aL5te+FKtMzR+f++xJdCNrOu5w84HlGY4DhiROq
 uV4ISLcOBZR2MQad2Ia4lUb1mAENMjB4pbI9/b89MImt9WlnZFV+tFUhPYdYHw==
Message-ID: <27d250fc-ec48-4850-831f-b4d76b8ed240@denx.de>
Date: Tue, 7 Jan 2025 12:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMS8xN10gbWFp?=
 =?UTF-8?Q?lbox=3A_add_i=2EMX95_Messaging_Unit_=28MU=29_driver?=
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Peng Fan
 <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-1-6744df5dc020@oss.nxp.com>
 <22f8e29b-1372-4384-a5d4-5316c1f4f160@denx.de>
 <PAXPR04MB96447B0DA009A2730D207B7FE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <001a00ca-5980-4ffc-8fe7-67267a71615c@denx.de>
 <20250107044653.GA9383@localhost.localdomain>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250107044653.GA9383@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/7/25 6:01 AM, Peng Fan wrote:
> On Mon, Jan 06, 2025 at 09:39:57PM +0100, Marek Vasut wrote:
>> On 1/6/25 6:27 AM, Alice Guo (OSS) wrote:
>>>> 主题: [EXT] Re: [PATCH v3 01/17] mailbox: add i.MX95 Messaging Unit (MU)
>>>> driver
>>>>
>>>> Caution: This is an external email. Please take care when clicking links or
>>>> opening attachments. When in doubt, report the message using the 'Report this
>>>> email' button
>>>>
>>>>
>>>> On 1/3/25 7:45 AM, Alice Guo wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> i.MX95 Messaging Unit (MU) enables 2 processors on a chip to
>>>>> communicate and coordinate by passing messages (e.g. frame
>>>>> information, event notices and requests) through the MU interface.
>>>>> This patch provides a driver for i.MX95 MU using the common mailbox
>>>>> framework. Currently, SCMI exchanges on i.MX95 uses a mailbox
>>>>> transport with SMT format, and the hardware used is this MU.
>>>> Is this ported from Linux ? If so, as of which mainline Linux kernel commit ?
>>>
>>> Yes, u-boot/drivers/mailbox/imx-mailbox.c is ported v6.12.8 Linux.
>>
>> Please add that information into the commit message, including the kernel
>> version and Linux commit ID , in case this driver needs to be updated.
>>
>>>> Can you add older iMX SoC support while adding this driver ? It seems
>>>> imx6..imx95 MU IP look very similar.
>>>
>>> This patch-set is only for i.MX95. I can add the older iMX SoC support in the future.
>> Maybe you could split off addition of the MU driver into separate series and
>> do it for all the SoCs right away instead ?
> 
> Adding other SoCs support needs tests, but to tests other platforms, we
> need more work. We could not just put code here that not tested for other SoCs.
If you are already porting the MU driver for Linux, there is a good 
chance the support for other SoCs was already tested in Linux, so it 
should be safe to port it over in full to U-Boot that way ?
