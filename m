Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F33DC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 23:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECAD80EC0;
	Fri, 21 Feb 2025 00:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740093491;
	bh=4nmDpwfgRV66He3w8N0j4Np3z+W1jDYqp6K9+Bt0TGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MLZhjEuhqKFl2CHF/LLUcrIBZBx8z7sW1/At3crGiNk3zQnPA0r4V6IhNC1S2tU3A
	 Dhr0n93wyt+U8ehzZxaI9yQXVvk4VQgz+Uj3a3dHTil5p/xjSM5ZU34f7Or7Yoa3+y
	 UCJXbMdkOgOu6bGQk6afBk1bm4tnwiHSJTJre1Nf0EK6MzL8WsPE576uffxYbeJSBm
	 8ysBdvDoc3vJCGaSkqKF2XDn1fAkeO9DLnPikNaR1zi14eTTe7nzPSmx2OLmaGPsEL
	 vTt69H7EreRArzbMkkdeGbSBOGpPfPLoULg1oacK7s0wTE/L6jH1fQ+/RHgOE2AOgO
	 2nprg3VfaSxBQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7838480F5C; Fri, 21 Feb 2025 00:18:10 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE80807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 00:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GdI/EZAx"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F3C2510382D37; Fri, 21 Feb 2025 00:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740093487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nmDpwfgRV66He3w8N0j4Np3z+W1jDYqp6K9+Bt0TGA=;
 b=GdI/EZAxXDUtAM3+rOa8McDCZJySpcDK6Hwn3GH0mBEs6Us07Jaf8kckgAgTjmhKQ0tdEH
 9dYrO6KCmu+TYA055MclSz1PC4cKSR7asee3ae+prUFpTTteHI/+e52kgjkL7ADWAVtPEo
 g5fDZeL8yXJZWFE+jyS1BLNRAwKM+dwyVGowZyFT8EfO8MJmF+yhYqyFwIMCoLk7r8qfF3
 Z4bwDzeUVOX6NWxJu7wegg83xppDhy6RsDt58RZTI7/CwofMYT5gEQvOO9TI9WDXxfMDlA
 FbcaoFvITs42fa5Z4z+7NG/IjhP/EvI4iD3CWGwB3lMhY/kzNdh5miA7E0xWUQ==
Message-ID: <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
Date: Thu, 20 Feb 2025 23:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY0IDA0LzIwXSBmaXJtd2FyZTogc2Nt?=
 =?UTF-8?Q?i=3A_add_pin_control_protocol_support_to_SCMI_agent?=
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 2/18/25 12:53 PM, Alice Guo (OSS) wrote:

[...]

>>> @@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
>>>    				drv = DM_DRIVER_GET(scmi_voltage_domain);
>>>    			}
>>>    			break;
>>> +		case SCMI_PROTOCOL_ID_PINCTRL:
>>> +			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
>>
>> Is this pinctrl protocol really imx specific ?
>>
>> If not, this needs to use some other config option to gate access to it.
> 
> Currently, it is used for some product families of the i.MX9 series products.
Is the protocol iMX specific or is it generic protocol ?
