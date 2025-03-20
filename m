Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D45C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 04:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6B58083E;
	Thu, 20 Mar 2025 05:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742443437;
	bh=9Hl0I4Qf15QwVCtgZ4Ow17tgr/QA09bLEv2yIgI3tH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fqRigY9UvGjx8K9zylycpRlvF/shgPJvGFGc2K8trGKvWiBr+mo6p5cQDLZJ7+euk
	 CzBFY40nuLrzZZudl/aniCbDGiQgcm1cskb04n40rmRJtHz5XKSBbUykkxCgi4r5eo
	 hmuLukqTAehhH8mAaTfjrN8YXB+hgzpNCeXb1GkG89jUwMmjBvRJVsxnNxR21EQyVG
	 FHLGWfng6ot35k6k4rfTtqUpAn9IBBtzfCrXFU/t2S1m1XI/kraJwkn5DSnVRxsr2c
	 qgvnGnm1GQ1YRW+34S/nqLk7d6x6cr1alGb3HD/sH6NAwUH4yAMCDkNbzSj/rGPuvE
	 jmr2mAeaqm5ig==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9143B809D4; Thu, 20 Mar 2025 05:03:55 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2F6803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 05:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hceSYL5X"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD779101E91CA; Thu, 20 Mar 2025 05:03:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742443431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=9Hl0I4Qf15QwVCtgZ4Ow17tgr/QA09bLEv2yIgI3tH0=;
 b=hceSYL5XZv6zSGJNkE+ZSbJTFVgKCk6xdVCnkbQUx1LFkICWKUAe8vKsv5SekgUQ3J3Hfp
 OTjW0PVSYh/7DJrt8MFRhlOcFZtVpTRKHPM6UwqKEdKOBHYCXV0q7BLPHR4ZlfQkNbBCsx
 8hGdZCq5gUQMECiyoS6/5A0SeDwrxmRISJLLsZNiLR9mYaZqTYXfoG+WUdu+Wv51BlmNet
 qA2P03tUPHPsVoQlCISY0UQEyuyMxc7mmUtFx0H0RaX+mVHmgqQe++VuE3HAAFPp5zokIe
 +V361RsBoRuxR3cDa/mnzNwvbfSljeo2mytAjcy6InfcLnrkn3aT5rZEsiWLKA==
Message-ID: <1a99da2c-8076-481b-aec4-8aff3f1f7b64@denx.de>
Date: Thu, 20 Mar 2025 05:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSN?=
 =?UTF-8?Q?=3A_=5BPATCH_v4_04/20=5D_firmware=3A_scmi=3A_add_pin_control_prot?=
 =?UTF-8?Q?ocol_support_to_SCMI_agent?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
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
 <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
 <PAXPR04MB9644FE1F92AFF132649A7EA5E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <3b232bda-000e-4f6b-8661-eeb72fc78b67@denx.de>
 <PAXPR04MB96443A9429499C5FF777EDEDE2CB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <fb46746a-1d50-4226-8f56-2dade4f52891@denx.de>
 <PAXPR04MB9644E5C1DF5B039D6BB65F6DE2D82@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644E5C1DF5B039D6BB65F6DE2D82@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 3/20/25 3:28 AM, Alice Guo (OSS) wrote:

Hello Alice,

>>>> - Basically duplicate the mechanism in 7940a93eb977 ("net: phy:
>>>> Iterate over both registered PHYs and struct phy_driver linker list"), call it
>> e.g.
>>>> U_BOOT_SCMI_DRIVER()
>>>> - Switch SCMI drivers to use U_BOOT_SCMI_DRIVER , have each one list
>>>> a protocol ID (instead of the PHY IDs), and then use the
>>>> scmi_agent-uclass.c to iterate over all the linker lists
>>>>
>>>> About the MX95 specifics and handling those, it is possible to have
>>>> two drivers which support the same hardware compiled into U-Boot and
>>>> have them decide at bind time which driver should bind and which not,
>>>> look at drivers/mtd/renesas_rpc_hf.c rpc_hf_probe() and
>>>> drivers/spi/renesas_rpc_spi.c
>>>> rpc_spi_bind() for example of doing this.
>>>>
>>>> I hope this helps untangle the SCMI implementation.
>>>
>>> Thank you for providing the example. Please review my patch set.
>>> https://patchwork.ozlabs.org/project/uboot/patch/20250305-imx95-v1-2-2
>>> 86d15acbb8a@oss.nxp.com/
>>> https://patchwork.ozlabs.org/project/uboot/patch/20250305-imx95-v1-3-2
>>> 86d15acbb8a@oss.nxp.com/
>>
>> I will try to review this this week, I apologize for the delayed replies.
> 
> Hi Marek,
> 
> Are you available this week to review? 😊
Ugh, sorry, I am working toward it. I apologize for the abysmal delay.

Thank you for the reminder.
