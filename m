Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D97DC36005
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 03:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B339810E8;
	Wed, 26 Mar 2025 04:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742958038;
	bh=3Gkz0zbCUEeMX6TmwCAt5nCzLJLeRQsEaxXMK8iF9UY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q7vuMpoJ9Lmz1CaqrtQ7MiZAcj78y+wapKpcEEUDpbNRAc3Yw2Wa9bsJ2Vtkw+Kcp
	 YPtU3eXFj4QtvLtNrH2cU1ViFUdswhYLWZmgi4dzcpRAOyCCuoNwvY5E461cgnixrK
	 F2KGT9PxmD3ZXY27UZot5NiEYL49mUQ8+ZQ8qX6qjncB4OErz6wpd+26tQ/N3K+RX8
	 mqtQEXm6ZcERnDvs96ycSNrlyiERi6NlyrVLLfgfN43VRa4GuScq2fggrDlX2qymmh
	 YasUgconAczRsWHghHxNOkz41Ra8heWXFunBNPbfvBS1Cqq0irPuZ0tyiJrKOkVMSP
	 /69iGT3brm/mQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70FAA8186D; Wed, 26 Mar 2025 04:00:37 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74449806FC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 04:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HSuWqZtL"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C6D6910382D3C; Wed, 26 Mar 2025 04:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742958034; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3Gkz0zbCUEeMX6TmwCAt5nCzLJLeRQsEaxXMK8iF9UY=;
 b=HSuWqZtL6Qc01C5f43m92b1++DIIH1+cWcvn08sxj+WHinwDiXLrTxr48K0Dn5hGu861fC
 TuyKHA8Uag3ydxxqPZNZlw0YZRC57VVphP69Btv4RaoKI+1xFj7XgUHmSC4WOndhrNWSsO
 WqyXfKFNSbUrW3HtpnBaKC18NAzVKRcIIbGNkeBJhCs/1RejzIKrFJPfCtdu2xQNSWUQxT
 J+GaOZOi4fDWqo3kwEra/TWJlBUJtAmtbDFNHTlfIHNPEz0VoXWw2u3qrMu0DfUbwvfIAO
 M0FoPzeWkE2ezok2/cX73uAbcGOQcj11uxhgkinTZ1iilmTvbRvwYi88DnbDkw==
Message-ID: <bc232085-3efb-43fb-b176-eaf43e52f1f8@denx.de>
Date: Wed, 26 Mar 2025 04:00:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
 <20250325080614.GC27303@nxa18884-linux>
 <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
 <PAXPR04MB8459808C7CC6C16DB43B973388A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB8459808C7CC6C16DB43B973388A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On 3/26/25 2:52 AM, Peng Fan wrote:
>> Subject: Re: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver
>> based on SCMI pin control protocol
>>
>> On 3/25/25 9:06 AM, Peng Fan wrote:
>>
>> [...]
>>
>>>>> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
>>>>> index 7abb2a6f36b..279ebbad440 100644
>>>>> --- a/include/scmi_protocols.h
>>>>> +++ b/include/scmi_protocols.h
>>>>> @@ -24,6 +24,7 @@ enum scmi_std_protocol {
>>>>>     	SCMI_PROTOCOL_ID_SENSOR = 0x15,
>>>>>     	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
>>>>>     	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
>>>>> +	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
>>>> If this is the IMX specific pinctrl protocol, please make sure to
>>>> name it accordingly , SCMI_PROTOCOL_ID_PINCTRL_IMX or
>> something .
>>>
>>> This ID is generic ID, not i.MX specific.
>>>
>>> i.MX SCMI pinctrl follows ARM SCMI spec, but i.MX pinctrl bindings
>> are
>>> different compared with ARM SCMI generic pinconf bindings, so we
>> need
>>> a separate driver for i.MX.
>> But then, why is it using the same protocol ID ?
> 
> i.MX System Manager FW pinctrl follows ARM SCMI spec,
> the ID value is 0x19.
> 
> 
> If you look at linux kernel driver
> 
> drivers/pinctrl/pinctrl-scmi.c
> drivers/pinctrl/freescale/pinctrl-scmi-imx.c

Is the second driver upstream at all ? I don't see it in linux-next ?

> Both use same ID 0x19.
> 
> It is fine to use below, if it is fine to you.
> SCMI_PROTOCOL_ID_PINCTRL_IMX = 0x19.
How does the kernel discern which driver it should use to communicate 
with the SCMI provider if both drivers are compiled into the kernel ?
