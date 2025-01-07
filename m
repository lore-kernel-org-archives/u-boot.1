Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92020E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9065B80600;
	Tue,  7 Jan 2025 12:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736249116;
	bh=AVm360gcrJ/YhWcQ1bkGEAj9o+OyHUnChGd5Yd/MAn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BofRykhfCQ3gP0qCJ35R5ZOGVkxG0ft4uxATJD8leZXWW1x7LdVUHGJCdAHSW7B+K
	 pyQ4GSHv2CAxDyxztJWA5X6Q3U8Q0Je/e8D7Kc5XiRTFOlx5I1UYnk4kq+q4BhytUK
	 fAqrRtakq84LUTeF1xj1sZZuvBzJg0uCZNXfCyEktH/KE5H59AhANeTtiAw2ScSkmw
	 GeYhm8KHJ9378Ws7skl9fianOkyLWsQoK7GoXzPtA96tziZUw0sU8A6e1zJoPtD8jC
	 h3hISVwjtGy5uNkFl6yTp2b23mlf7Nxf81PShMplghefLpzq0ackVvyqSIBVeAuaCS
	 mpW8shPdPnnxA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C49B0805E9; Tue,  7 Jan 2025 12:25:15 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B61D8056D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="A/d3qGK2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D3C23104811F3; Tue,  7 Jan 2025 12:25:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736249108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVm360gcrJ/YhWcQ1bkGEAj9o+OyHUnChGd5Yd/MAn4=;
 b=A/d3qGK2KvJpTUS0NZrtUHr5IcHSCSk6MsvuuVVpYKiYO7STz4Ha7A1A7sfGBTocowBW1v
 TTuZrncsiO362JtfC9gF6bI8Rjw19EY+N3u+OI8yKPaRJUL3RwC9fjIWy6kqphXbRbK7FN
 MrnKHOg9gEWZTDxqVT3JQoTd/woK5U3VeyqYLs+Xajs0vDhRAdnoieDJ1XhoB5237zoq9C
 /u38cS8+Ovn1athlTUYdjkFo0vEeKjV1Rl9VANy09lndxZIaDaXNjsE5891w8xCdSrWiTU
 rdwLXC5PE68RqVy9dNEshZEely/WCaVnNgcCfJIFU7YPJy7JEC3iSdO0wuoNQg==
Message-ID: <5633e9ab-0841-4f1e-9810-743359ac9107@denx.de>
Date: Tue, 7 Jan 2025 12:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAy?=
 =?UTF-8?Q?/17=5D_firmware=3A_scmi=3A_smt=3A_Interrupt_communication_enable?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
 <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
 <PAXPR04MB964475AEF1CB007B5949088CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <dbfd7a78-06e3-4e42-961c-5130f1707f26@denx.de>
 <PAXPR04MB96441C57A9F06EB21FF1FF59E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96441C57A9F06EB21FF1FF59E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 1/7/25 4:24 AM, Alice Guo (OSS) wrote:
>> 主题: Re: 回复: [EXT] Re: [PATCH v3 02/17] firmware: scmi: smt: Interrupt
>> communication enable
>>
>> On 1/6/25 7:17 AM, Alice Guo (OSS) wrote:
>>>> On 1/3/25 7:45 AM, Alice Guo wrote:
>>>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>>>
>>>>> When interrupt driven communication is supported
>>>>
>>>> U-Boot does not use interrupts.
>>>>
>>>>> , the transport allows
>>>>> the caller to choose between interrupt and polling driven
>>>>> communications. To make the choice, the channel flags are used.
>>>>> i.MX95 uses interrupt driven communication so that Channel flags
>>>>> should be set to 1.
>>>>
>>>> How does this work in U-Boot, which does not use interrupts ?
>>>
>>> Hi Marek,
>>>
>>> The clearer explanation will be added in the commit log.
>>>
>>> This is based on Arm® System Control and Management Interface Platform
>> Design Document Version 3.2 (Document number: DEN0056E) 5.1.2. When
>> Bit[0] of Channel flags is 1, the System Manager runs on M core will trigger
>> general-purpose interrupts to A core. U-Boot polls General-purpose Status (GSR)
>> until GIPn is set.
>> If U-Boot does polling, why does this bit need to be set, shouldn't the bit be
>> cleared instead ?
> 
> My commit log may have caused your misunderstanding. If the bit is not set, the System Manager will not request doorbell interrupt. The following is the code from imx-sm:
> 
>              if (callee)
>              {
>                  /* Generate completion interrupt */
>                  if ((buf->channelFlags & SMT_COMP_INT) != 0U)
>                  {
>                      status = RPC_SMT_DoorbellRing(smtChannel);
>                  }
>              }
Can the SM be updated instead ?
