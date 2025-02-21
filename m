Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41197C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 19:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3548D80F7B;
	Fri, 21 Feb 2025 20:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740166890;
	bh=T5VC0g+Rwabkq8jzLw9Blv7F//37usAeyy6GCcFPq8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RF5ARtR4PToexnSrxWHr93IsuOwAahgYk8kRoPlsZKoz1DG8Se3Sd2XguCg0ndJWr
	 j7jcKzdh1Zmn41a3eSTomIf93f8omxf2zlTn4n45UJkJxEEeJFh82TjlBq/mzQ4wXk
	 /RpeUsdD4U1uwiMmCwjsZkIWP8rzlm9fQsRTX1qFtikbdyoZcBrvYaWzddCQ08bEfU
	 g6zHwfxTyjG6sxa9FVwUpHJ414Sc0HNQQ3n1MGIr8grLucHwkBI9bdHwLa/1yo0MUJ
	 TnCc/GUAD+aUqAUH6p6pMXZVXtzpYVCsbD/U3rzm+tNgU2e1RtPhA8fSA/L/Ey0rRh
	 ljHKh3wGOjzGA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EF8806FE; Fri, 21 Feb 2025 20:41:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C9880F56
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 20:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GZIMdfze"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DF61910382D3C; Fri, 21 Feb 2025 20:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740166885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T5VC0g+Rwabkq8jzLw9Blv7F//37usAeyy6GCcFPq8Q=;
 b=GZIMdfze6Dj+mmY2MyhTUFViCXaOnunlKtHh7eyd89PIiZ13VBHXjo5Bonf4qwP8p7e0TH
 7wiI5rC4PsJ/zLciCukYcCIdmrYlqLqw9sSHeVBFfufZhY6bKuyGmKeAeeBFCI9kwEbRU2
 Zudds3zWpSwhD7dyMfg9efJswiUnhKBv1gMnXUorXj6MHGAScoN6sDOBAO5XZjAEbkw0HG
 Ov/lT6HufIgs1+RtUmFSbNPTmT+Bm3KdQFPpsFsVGbPZz/57MilX1JjKPkqowRtrvJ1s8Q
 6ax7h29z9/A+Dh+pClesa7U1ScTfJBTCVXqatv2IPJWDiUrfenI/pdE2DB3pyw==
Message-ID: <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
Date: Fri, 21 Feb 2025 18:55:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjQgMDQvMjBdIGZpcm13?=
 =?UTF-8?Q?are=3A_scmi=3A_add_pin_control_protocol_support_to_SCMI_agent?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 2/21/25 2:47 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marex@denx.de>
>> 发送时间: 2025年2月21日 6:35
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Tom Rini
>> <trini@konsulko.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
>> <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Lukasz
>> Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Simon
>> Glass <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> 抄送: u-boot@lists.denx.de; tharvey@gateworks.com; Alice Guo
>> <alice.guo@nxp.com>
>> 主题: Re: 回复: [PATCH v4 04/20] firmware: scmi: add pin control protocol
>> support to SCMI agent
>>
>> On 2/18/25 12:53 PM, Alice Guo (OSS) wrote:
>>
>> [...]
>>
>>>>> @@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice
>> *dev)
>>>>>     				drv = DM_DRIVER_GET(scmi_voltage_domain);
>>>>>     			}
>>>>>     			break;
>>>>> +		case SCMI_PROTOCOL_ID_PINCTRL:
>>>>> +			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
>>>>
>>>> Is this pinctrl protocol really imx specific ?
>>>>
>>>> If not, this needs to use some other config option to gate access to it.
>>>
>>> Currently, it is used for some product families of the i.MX9 series products.
>> Is the protocol iMX specific or is it generic protocol ?
> 
> SCMI_PROTOCOL_ID_PINCTRL is not unique to iMX, but drivers/pinctrl/nxp/pinctrl-scmi.c (drv = DM_DRIVER_GET(scmi_pinctrl_imx)) is only for iMX.
This patch is changing common code, it shouldn't be littered with 
vendor-specific ifdeffery or if(IS_ENABLED(...))ery . Can this be made 
fully generic, similar to e.g. regulator protocol ?
