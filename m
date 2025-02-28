Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A64EC282D0
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1933810EB;
	Fri, 28 Feb 2025 20:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740770841;
	bh=L9gnxP/SaSKMvZswZCcSCmP1gsWaSdQ/XyKVd7EV/7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M51ZYgGjzQf7959zx+/o1TGkGJfLZGwS7NNQvc1ipqABXRKB58R2bzPU3f5iIT8pm
	 3/Cwx8SnLB5q5XvL7P+7HGTevyPujl+U75OlcE4plB1pGuYVJ/kdkFTG0pz2lys+BV
	 eR0u5jOppKCF/OtLw0MuYpQHotItK6mNTQ/v58CJb4U8sDCcj6BBZZYcHVbUvyfLwx
	 a6Tl7WRgoJGtB2ALt1YRDgQwni/wn16Sa7AZY6uVFyqKqSaoFM+eO75jRIjn/4YZhZ
	 aqP600GKujOAHiq1oRCkUui4lNS3vsOrg7HaPRE9yg0HHSoOurW8BHwbtEIIVQQXAE
	 IKk+SYuxp0Apw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F12810F5; Fri, 28 Feb 2025 20:27:20 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC2A809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Lm8LS5+R"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ACB4C102FD52C; Fri, 28 Feb 2025 20:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740770837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9gnxP/SaSKMvZswZCcSCmP1gsWaSdQ/XyKVd7EV/7U=;
 b=Lm8LS5+RCUg3j79aIDVGzPP5WwG1b5l5jQJZ0caM/IaiEgbCiFTl4xLzCKCEUFDkpVlZ37
 xsfXsJ07Lm/CFpvDXcwykK/lQSmbwg6Zj6jGMSdKdPfOJ8Q+TB0b69uN/ZJoQ40MTrsTfS
 MQ+Gnr6jtdV/otmeJEHQFz+930yViocO5WLu5wknVrypKf4Kak1NevhU5MjwwLDdUSyhrC
 X73sOcVo0RRMzc6wGB4+sSCTQhoETfiN5DGnjxz3hqu26uU1wnqZeYXVbCy7qbTm+QbEkt
 ss2WDmzn52yN6b6syC+eWJywkS9rcJ4XzzxvffaUVZ+i0YxQmehfF62d8DG9vQ==
Message-ID: <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
Date: Fri, 28 Feb 2025 19:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjQgMDQvMjBdIGZpcm13?=
 =?UTF-8?Q?are=3A_scmi=3A_add_pin_control_protocol_support_to_SCMI_agent?=
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
 <20250224022831.GA9876@nxa18884-linux>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250224022831.GA9876@nxa18884-linux>
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

On 2/24/25 3:45 AM, Peng Fan wrote:

[...]

>>>>>>> @@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice
>>>> *dev)
>>>>>>>      				drv = DM_DRIVER_GET(scmi_voltage_domain);
>>>>>>>      			}
>>>>>>>      			break;
>>>>>>> +		case SCMI_PROTOCOL_ID_PINCTRL:
>>>>>>> +			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
>>>>>>
>>>>>> Is this pinctrl protocol really imx specific ?
>>>>>>
>>>>>> If not, this needs to use some other config option to gate access to it.
>>>>>
>>>>> Currently, it is used for some product families of the i.MX9 series products.
>>>> Is the protocol iMX specific or is it generic protocol ?
>>>
>>> SCMI_PROTOCOL_ID_PINCTRL is not unique to iMX, but drivers/pinctrl/nxp/pinctrl-scmi.c (drv = DM_DRIVER_GET(scmi_pinctrl_imx)) is only for iMX.
>> This patch is changing common code, it shouldn't be littered with
>> vendor-specific ifdeffery or if(IS_ENABLED(...))ery . Can this be made fully
>> generic, similar to e.g. regulator protocol ?
> 
> In Linux Kernel, there are two drivers, pinctrl-scmi.c and pinctrl-imx-scmi.c.
> Both follows ARM SCMI 3.2, but pinctrl-imx-scmi has some special settings
> to align with i.mx iomuxc array based settings, mux,input,pad and etc.
> 
> In gerneral, imx part could be merged with pinctrl-scmi.c but that will
> make code not clean.
In that case, why does U-Boot not have pinctrl-imx-scmi.c to contain the 
iMX customization too ? If this protocol is IMX specific, it shouldn't 
be ifdeffed in common code.
