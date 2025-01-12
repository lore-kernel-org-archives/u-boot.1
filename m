Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E78E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E44458069D;
	Sun, 12 Jan 2025 23:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736719590;
	bh=xhDyLHT/vcG/SgzuvZJ/qrkg1BzZt8DDpnmM5yaKYrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t/in7v07XcJehyISTXxtKK2xiHLJNLc51zVfKelL/tuCd/j0sqxoIEdNyX6nuX3iN
	 xx4VQP7Ok1E2l7K2TuYPXPBO9/o8vyyCiMVzVdLCsqiQG1kzImxqIvUp494Ryty8Wz
	 a9lxsMUgKxmbxtlrSLx7Zb3GBubtPy2mcLOOVbq5KGioF57T8rykNH4udeO03MkA2p
	 JidblDms4aJDXskYpUMrANpZ7D32DzyLOzu5dyFeB6uYfpmxV8Tf7Nr6A7Fyk++17l
	 vAFfVtjej5ItYYBD++xiC9vhG9hMag1n4OcQXDzy5dxMsNUasHOtJws32Uah83C7oi
	 hjARO4s++U1TQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F8280657; Sun, 12 Jan 2025 23:06:30 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDCFD80027
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="O4eFTO5o"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 552EA101EC119; Sun, 12 Jan 2025 23:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736719587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhDyLHT/vcG/SgzuvZJ/qrkg1BzZt8DDpnmM5yaKYrg=;
 b=O4eFTO5obZ8Xj2RaeeXz/yJmv/s1Dm4u3f+E31kWa7RqYc+tmK/B3t50jbnnr2D/S7TaY5
 n2/pj3FE3Y8EECze+b/Da+ve94dYhNnI9oLFod90x7FcsKDxYv7ATP3bvRHqJdzC8+teF/
 L7VmoPm0Is80CkvpTX5lPYTlfLghDHwCvEZfjIrOSyTAmhI4PKuoB0EUz/wkZRRY0GxqfA
 IpBzcglcTJSnQ/hnHb92FPLoMC/Z8/wO1s1wP8VLdLNYcxM+X5PnOcqBifX8m0AJrFH+FC
 jrSt1ikDaJmfK3AZaYmqhUF5jBYZdSssgQW8/5k+LL3kb6p2v88QyrwSYgVx2A==
Message-ID: <346cbb19-b253-474e-9e64-9d6f6f2b3eac@denx.de>
Date: Sun, 12 Jan 2025 23:03:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtFWFRdIFJlOiBbUEFU?=
 =?UTF-8?Q?CH_v3_02/17=5D_firmware=3A_scmi=3A_smt=3A_Interrupt_communication?=
 =?UTF-8?Q?_enable?=
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
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
 <ab77f12a-35b3-4b26-a801-3db315aea1d2@denx.de>
 <20250110095908.GC23168@localhost.localdomain>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250110095908.GC23168@localhost.localdomain>
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

On 1/10/25 10:59 AM, Peng Fan wrote:
> On Wed, Jan 08, 2025 at 07:38:30PM +0100, Marek Vasut wrote:
>> On 1/8/25 3:55 AM, Alice Guo (OSS) wrote:
>>>> -----邮件原件-----
>>>> 发件人: Marek Vasut <marex@denx.de>
>>>> 发送时间: 2025年1月7日 19:11
>>>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Tom Rini
>>>> <trini@konsulko.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
>>>> <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Lukasz
>>>> Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Simon
>>>> Glass <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>
>>>> 抄送: u-boot@lists.denx.de; tharvey@gateworks.com; Viorel Suman
>>>> <viorel.suman@nxp.com>; Ye Li <ye.li@nxp.com>
>>>> 主题: Re: 回复: 回复: [EXT] Re: [PATCH v3 02/17] firmware: scmi: smt:
>>>> Interrupt communication enable
>>>>
>>>> On 1/7/25 4:24 AM, Alice Guo (OSS) wrote:
>>>>>> 主题: Re: 回复: [EXT] Re: [PATCH v3 02/17] firmware: scmi: smt: Interrupt
>>>>>> communication enable
>>>>>>
>>>>>> On 1/6/25 7:17 AM, Alice Guo (OSS) wrote:
>>>>>>>> On 1/3/25 7:45 AM, Alice Guo wrote:
>>>>>>>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>>>>>>>
>>>>>>>>> When interrupt driven communication is supported
>>>>>>>>
>>>>>>>> U-Boot does not use interrupts.
>>>>>>>>
>>>>>>>>> , the transport allows
>>>>>>>>> the caller to choose between interrupt and polling driven
>>>>>>>>> communications. To make the choice, the channel flags are used.
>>>>>>>>> i.MX95 uses interrupt driven communication so that Channel flags
>>>>>>>>> should be set to 1.
>>>>>>>>
>>>>>>>> How does this work in U-Boot, which does not use interrupts ?
>>>>>>>
>>>>>>> Hi Marek,
>>>>>>>
>>>>>>> The clearer explanation will be added in the commit log.
>>>>>>>
>>>>>>> This is based on Arm® System Control and Management Interface
>>>>>>> Platform
>>>>>> Design Document Version 3.2 (Document number: DEN0056E) 5.1.2. When
>>>>>> Bit[0] of Channel flags is 1, the System Manager runs on M core will
>>>>>> trigger general-purpose interrupts to A core. U-Boot polls
>>>>>> General-purpose Status (GSR) until GIPn is set.
>>>>>> If U-Boot does polling, why does this bit need to be set, shouldn't
>>>>>> the bit be cleared instead ?
>>>>>
>>>>> My commit log may have caused your misunderstanding. If the bit is not set,
>>>> the System Manager will not request doorbell interrupt. The following is the
>>>> code from imx-sm:
>>>>>
>>>>>                if (callee)
>>>>>                {
>>>>>                    /* Generate completion interrupt */
>>>>>                    if ((buf->channelFlags & SMT_COMP_INT) != 0U)
>>>>>                    {
>>>>>                        status = RPC_SMT_DoorbellRing(smtChannel);
>>>>>                    }
>>>>>                }
>>>> Can the SM be updated instead ?
>>>
>>> System Manager not only interacts with U-Boot, but also with Linux/QNX/RTOS. System Manager cannot be changed.
>> How come other SCMI providers (like optee) do not need this kind of change ?
> 
> Here to i.MX SM, this is just a doorbell to tell remote side that info
> is ready. To U-Boot i.MX, MU GSR set means SM sends data back, so with COMP_INT
> set, U-Boot could poll the MU GSR bit. Using interrupt here is not that
> accurate, it is just a doorbell.
> 
> For OP-TEE, it is using SMC, it is sync transports, SMC return means SCMI done.
> No need polling any bit or else.
In that case, do you need to check the DT /firmware/scmi node compatible 
string for compatible="arm,scmi-smc" and enable this flag only if the 
compatible is "arm,scmi", and disable the flag otherwise ?
