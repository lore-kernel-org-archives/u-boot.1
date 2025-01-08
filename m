Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564F6E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CFA800DF;
	Wed,  8 Jan 2025 19:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736361613;
	bh=hHaRtgbg+UvO86yYXH9jj6N7/CY1yEm7SQS/8cL8q6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qernwgg50ppLIt18pDie7+AnCBza61e95/koGltDDDVmTNFLzosCuL1jGK4wfyg24
	 JZCsbYFvT+5cGH5vQPt5KBSGbTsPxLojiTaY0ZdzBkC+mq3ggISgCSR8EIBNz89nuk
	 RlvNTVn3+hn1+WeiYokokuRR7+dAAklob31j3Y1SrZMxLbuAsrouKD/eASwwAUy5+/
	 kqs1B9F3RN2TkjvNmt+C5YOog6iTNpInwnC2NNcc6f2bAtK9wICkzv9UTZTWmLTVXw
	 I1p0wsQDQgDZO4/XNNiLNEJpUzCnV31x+6vKOy+12BUfzIfp/YpBJPZPLggBFOYlXs
	 umea0Sd4mDdmw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE87800DF; Wed,  8 Jan 2025 19:40:12 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9713D8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LLIBF3e5"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 270B01093BBDB; Wed,  8 Jan 2025 19:40:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736361609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHaRtgbg+UvO86yYXH9jj6N7/CY1yEm7SQS/8cL8q6I=;
 b=LLIBF3e5mXJz1opQvloV4FHqt3htbbeoN+W4yDSLrPinj5d7kJ3AKO+OONPVhzzvDL0byw
 xlrULdq4zYLypS/ztJu8Fdia7eoF9DIg1ThC0UsFID9i7XrVs7zenIux0GvGOa59mrzV12
 /TFDp9TryqdBAdOMjXB0yU9EUIpBPVjoKZdZ2+2GSb6hQx3Z9SCoL0/k6NmW4kt5ZSUVD9
 zRUmpWDSaWML+84em/x5E7606lTWZO1FPSlDe2aQbskF9QZe9KpIc96Cz2kYJnzETdUDlB
 zIQVNJD2zlwzjvh3KbBMdGfjHTF+UaiNGMlXZtkWDmKdHS8PIE5HDQq36m/+XA==
Message-ID: <ab77f12a-35b3-4b26-a801-3db315aea1d2@denx.de>
Date: Wed, 8 Jan 2025 19:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtFWFRdIFJlOiBbUEFU?=
 =?UTF-8?Q?CH_v3_02/17=5D_firmware=3A_scmi=3A_smt=3A_Interrupt_communication?=
 =?UTF-8?Q?_enable?=
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
 <5633e9ab-0841-4f1e-9810-743359ac9107@denx.de>
 <PAXPR04MB964422B7AB4E75400F36C017E2122@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB964422B7AB4E75400F36C017E2122@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 1/8/25 3:55 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marex@denx.de>
>> 发送时间: 2025年1月7日 19:11
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Tom Rini
>> <trini@konsulko.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
>> <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Lukasz
>> Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Simon
>> Glass <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> 抄送: u-boot@lists.denx.de; tharvey@gateworks.com; Viorel Suman
>> <viorel.suman@nxp.com>; Ye Li <ye.li@nxp.com>
>> 主题: Re: 回复: 回复: [EXT] Re: [PATCH v3 02/17] firmware: scmi: smt:
>> Interrupt communication enable
>>
>> On 1/7/25 4:24 AM, Alice Guo (OSS) wrote:
>>>> 主题: Re: 回复: [EXT] Re: [PATCH v3 02/17] firmware: scmi: smt: Interrupt
>>>> communication enable
>>>>
>>>> On 1/6/25 7:17 AM, Alice Guo (OSS) wrote:
>>>>>> On 1/3/25 7:45 AM, Alice Guo wrote:
>>>>>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>>>>>
>>>>>>> When interrupt driven communication is supported
>>>>>>
>>>>>> U-Boot does not use interrupts.
>>>>>>
>>>>>>> , the transport allows
>>>>>>> the caller to choose between interrupt and polling driven
>>>>>>> communications. To make the choice, the channel flags are used.
>>>>>>> i.MX95 uses interrupt driven communication so that Channel flags
>>>>>>> should be set to 1.
>>>>>>
>>>>>> How does this work in U-Boot, which does not use interrupts ?
>>>>>
>>>>> Hi Marek,
>>>>>
>>>>> The clearer explanation will be added in the commit log.
>>>>>
>>>>> This is based on Arm® System Control and Management Interface
>>>>> Platform
>>>> Design Document Version 3.2 (Document number: DEN0056E) 5.1.2. When
>>>> Bit[0] of Channel flags is 1, the System Manager runs on M core will
>>>> trigger general-purpose interrupts to A core. U-Boot polls
>>>> General-purpose Status (GSR) until GIPn is set.
>>>> If U-Boot does polling, why does this bit need to be set, shouldn't
>>>> the bit be cleared instead ?
>>>
>>> My commit log may have caused your misunderstanding. If the bit is not set,
>> the System Manager will not request doorbell interrupt. The following is the
>> code from imx-sm:
>>>
>>>               if (callee)
>>>               {
>>>                   /* Generate completion interrupt */
>>>                   if ((buf->channelFlags & SMT_COMP_INT) != 0U)
>>>                   {
>>>                       status = RPC_SMT_DoorbellRing(smtChannel);
>>>                   }
>>>               }
>> Can the SM be updated instead ?
> 
> System Manager not only interacts with U-Boot, but also with Linux/QNX/RTOS. System Manager cannot be changed.
How come other SCMI providers (like optee) do not need this kind of change ?
