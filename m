Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CD9E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E170080628;
	Tue,  7 Jan 2025 12:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736249116;
	bh=e/kp7WMiraXzqpdjwNaH4WcFRwFnc+0D6I4tiTwexeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TPKnTHYeNFhv0C5Nzg3t0vc3Mw/G52PoFlyRPpI/e4MvZRY5LmHfHLp2P/b0wXm/O
	 7B169S9tsX4YfBaB+p1odwNmtYWTiDU5VzAOSOh3/H6Cyr2cj6lDE0K0cUMerPNl5D
	 o6sG3G84CWMfd8olshttIG4R1CfbrQFs/a1fRpAJrR4zv9ZxsDdl2CjjP7YC40lkzM
	 Fwh/m9yioYVXAgNX3IZeotQSEaYq6N6YAP4DLs9wmeNoP2P418W5EfwHPcjp2RSsfk
	 f26V4m5tDpCmN/9c5X1QTcL5eg64ybTU6d4xCDd4bfKqjql6r6d7qJTa0izFjwx1of
	 sAhUV4dXHPMpw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1528056D; Tue,  7 Jan 2025 12:25:16 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8F180619
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="g1+xJCAN"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF7461048589C; Tue,  7 Jan 2025 12:25:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736249110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/kp7WMiraXzqpdjwNaH4WcFRwFnc+0D6I4tiTwexeU=;
 b=g1+xJCANdRgQvuoUxDtz/webgyPu87aLGsPQb6wxMwDTOcfCtWweD0iWJN2pKIVNCc+Hhv
 J80vtImY8ko1hfSE1DJ/St8uc1N1wb6zI4bFah1ReNyo/UdA0so5mBbsHMgqXv1PonMAWu
 iIRitTnS2DxrdTrTj5gr1HEpCOtGtiH7s1rYcIbe0dZDlo5Z/tvQt/pXiHUdn059ZzQnG0
 Nit9q5yxDU1Zpme3jBeNLRjsOP9NpYojmnlmU7HJ9K59nErT+eCVfc5doGhjdrSiBF+NkS
 /5gbR6Tlqx0+J0SmLHZybhouU6rg3qM3qbheczmQxi3amPfQB80rxOgg05Bc6g==
Message-ID: <7c7ab649-2bda-4693-8e41-c41c8e820c06@denx.de>
Date: Tue, 7 Jan 2025 12:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAz?=
 =?UTF-8?Q?/17=5D_pinctrl=3A_nxp=3A_add_SCMI_pin_control_protocol_driver?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Peng Fan
 <peng.fan@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
 <61075a72-7a89-4bcf-8d96-f9fc24dfd5a5@denx.de>
 <PAXPR04MB96440F6976C336998424F176E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <016aa4e5-c33d-4f77-9a12-c218c4123403@denx.de>
 <PAXPR04MB964470D51ACF7CCD08EE87F0E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB964470D51ACF7CCD08EE87F0E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 1/7/25 7:39 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marex@denx.de>
>> 发送时间: 2025年1月7日 4:46
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Tom Rini
>> <trini@konsulko.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
>> <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Lukasz
>> Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Simon
>> Glass <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> 抄送: u-boot@lists.denx.de; tharvey@gateworks.com; Peng Fan
>> <peng.fan@nxp.com>; Ranjani Vaidyanathan
>> <ranjani.vaidyanathan@nxp.com>; Ye Li <ye.li@nxp.com>
>> 主题: Re: 回复: [EXT] Re: [PATCH v3 03/17] pinctrl: nxp: add SCMI pin control
>> protocol driver
>>
>> On 1/6/25 10:56 AM, Alice Guo (OSS) wrote:
>>>>> This patch provides a driver for the SCMI pin control protocol which
>>>>> is based on ARM's System Control and Management Interface (SCMI) 3.2.
>>>>> Currently, only the PINCTRL_CONFIG_SET command is implemented.
>>>>
>>>> What is the SCMI provider for this platform ?
>>>
>>> Hi Marek,
>>>
>>> System Manager which runs on M core sets pin or group configurations.
>> U-Boot sends a SCMI message to System Manager to perform hardware
>> operations. You can refer to the source code for details:
>> https://github.com/nxp-imx/imx-sm.
>>
>> Can I use optee-os as a SCMI provider instead ?
> 
> You cannot replace System Manager with optee-os.

I think optee-os is also capable of being SCMI provider, so I have to 
wonder, why does NXP use custom hand-written SCMI provider instead of 
something already available, like that optee-os ?

And one more question, would it be possible to make U-Boot NOT depend on 
SCMI at all and instead have regular clock/pinctrl drivers which can 
configure the hardware using plain register writes, like it is done on 
MX8M and older SoCs ? That would surely make hardware bring up easier .
