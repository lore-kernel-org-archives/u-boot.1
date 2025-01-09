Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F50E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 20:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE33A800C2;
	Thu,  9 Jan 2025 21:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736453448;
	bh=f77WqUSwNiH1/kP54nFarQo2Jq1LUbIlWkjcBN2qRBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=urLylb4oohiQYgQpTkVYiJol6oRu+tV85ul4WVxORVs5csm1gLSq94ni2gGbhoMqj
	 LjdarZm2ymUtC1Q3zkxKyxKJj9d7zi2wGLD2lc8kijSfhD4eRBCIY3+r9PkQ4V1FUu
	 zDiysW3ty3agnG+PlAKb0HVcrTLG5Ekmk2W0GIF4jg9WivIKfZU78T6iWnYqr0FBSj
	 DYGr+pwuQC+0+1x0XEv2jYylf/e8gNIDl9BXWChlt42FdnCN5DbrwNj9QvdrDvSJxz
	 VAcJH2HatJYOr/c2RTFdAzci4A5wy9Caok/7Yv/GGqEWhSC6QyIvYLRJ4armuTZGkS
	 550xxyU2KQAfw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46462800C2; Thu,  9 Jan 2025 21:10:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285C48001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 21:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZPix29s3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4BFC41093DA13; Thu,  9 Jan 2025 21:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736453444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f77WqUSwNiH1/kP54nFarQo2Jq1LUbIlWkjcBN2qRBs=;
 b=ZPix29s3ew+Mvxsp+2MxHIpd2lQntE35lNm7OrjH94QbgWJhcaxH7LwTxio3ah+DI7yoWW
 TzvViQKtB85llWZD1GBQXMGou81ryUrTNNIeEUCr+KtsBTMDTiM2XjrsJjyEKa3Wj2CxPA
 C/tOYT2XuWjyHjf3wqArH7doPmmQ5L1JFUR7sLczOL9teVv2/qefxrT0g3fIJCtP9q7Cay
 YoozX9i43x4GuygpTgRK6TaxP/xVDRedFkX4+flqW7/luMfBb569365rRXzfu3MyPTGEEW
 CP3pAXMeYraW7XQxuJBdIychWn7h75mJGGF5MKYFInA1LI0460FrQt7o6TTRgQ==
Message-ID: <c5526919-2aa2-4fb3-9300-85bf7f3f6a90@denx.de>
Date: Thu, 9 Jan 2025 21:03:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtFWFRdIFJlOiBbUEFU?=
 =?UTF-8?Q?CH_v3_02/17=5D_firmware=3A_scmi=3A_smt=3A_Interrupt_communication?=
 =?UTF-8?Q?_enable?=
To: Peng Fan <peng.fan@nxp.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
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
 <ab77f12a-35b3-4b26-a801-3db315aea1d2@denx.de>
 <PAXPR04MB84597A7947C6019CAEC5C92C88132@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB84597A7947C6019CAEC5C92C88132@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/9/25 1:49 AM, Peng Fan wrote:

[...]

>>>>> My commit log may have caused your misunderstanding. If the bit
>> is
>>>>> not set,
>>>> the System Manager will not request doorbell interrupt. The
>> following
>>>> is the code from imx-sm:
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
>>> System Manager not only interacts with U-Boot, but also with
>> Linux/QNX/RTOS. System Manager cannot be changed.
>> How come other SCMI providers (like optee) do not need this kind of
>> change ?
> 
> Could we use a Kconfig option here, saying CONFIG_SCMI_INTR_EN?
> Then to i.MX95, select this Kconfig option and not break others
> saying optee.
> 
> There is less chance for System Manager to change. If you would
> like to do some change, you could do a PR, I could ask owner to
> give a look.
My understanding is that SCMI is supposed to be an ABI and that ABI is 
supposed to be the same across different platforms, correct ?

Therefore, I am wondering why does the MX95 need this special 
workaround, and whether that workaround should be fixed in the SCMI 
server OR whether other platforms need the same change as well ?
