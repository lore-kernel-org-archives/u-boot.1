Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02E9C282C6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 03:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B8C80786;
	Tue,  4 Mar 2025 04:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741058157;
	bh=BJ3OD5CJj/7yVjXej5PiIwj6c+QnkEOwkvYaTaAU0Wg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ECcK7l4960Wb0Hscl+NdL02hceNHOMCU2MnO6sBA8zyTlvIU0eeEV5zcpYDBZTW6m
	 BnrFgeWJ1++EW4JUiwbKvFl1XBOVKJSBnun4oRzaAM4gpaKGRmKRqLzZXBiN0OqBIE
	 e2+u/FymX6yFmI4I46T6N34sVxj13hkAhmNjGu9/w6D6Ykv3RSUD3ho93XOVZklfZ3
	 IX6P2im0Vpk+bQpNfhV/Q38QRPGbOlML109m9QfQdotBIgM8XY5NL/nZCRaRfSnYDK
	 Q0qA3XyDgeLex94N3ddnH4q98u5+RjLcZ+U88ngPBp6jTO3USZhtUE9L0rTF7qeKaB
	 XR/+RzIezq4BQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B8738104B; Tue,  4 Mar 2025 04:15:56 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F02801DE
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 04:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="M0ep7+ZN"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DA7B610382C18; Tue,  4 Mar 2025 04:15:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741058153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=BJ3OD5CJj/7yVjXej5PiIwj6c+QnkEOwkvYaTaAU0Wg=;
 b=M0ep7+ZN4+hkhAunrL6/65DMz/xyw+ib/1xqJ1GxZWCfgXmOXVaE9tHfKTTgp+vHCKO57R
 QXfXYEJP5oAEGRUktd8n8wjiW7KrLZcS6w4IVOuU3dvGKM8ZS4ivJaWtK0dcHGHSb19sA8
 a35uUeVY0Vj51gI3Y6Z5VOWYWAePssclK0zFW/atxKdw+MX295ufHzRN0JO1Yam6s9fK/L
 LY2wRMbdmcMFbq2yCbHSpkpYJfZwUEx5R1nPFErclLML49DV01X6Ay31ddPGYF4nd1utfu
 Y5gXHiASnmR4Sn42FOm5f8x//s5XuKjCHI/gC78xdzE1BAAQyTU+cnXZH4Ok5Q==
Message-ID: <1081d31c-fd2d-4529-a651-5f5152d2b9ff@denx.de>
Date: Tue, 4 Mar 2025 03:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxXSBtYWlsYm94OiBhZGQgaS5NWCBN?=
 =?UTF-8?Q?essaging_Unit_=28MU=29_driver?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "lukma@denx.de" <lukma@denx.de>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250303035231.2680198-1-alice.guo@oss.nxp.com>
 <3f5b9ee6-0def-43c6-a312-6248db8c588b@denx.de>
 <PAXPR04MB96445643235AE5C18C2D8824E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96445643235AE5C18C2D8824E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 3/4/25 3:35 AM, Alice Guo (OSS) wrote:

[...]

>>> +static const struct udevice_id ids[] = {
>>> +	{ .compatible = "fsl,imx6sx-mu", .data = (ulong)&imx_mu_cfg_imx6sx },
>>> +	{ .compatible = "fsl,imx7ulp-mu", .data = (ulong)&imx_mu_cfg_imx7ulp },
>>> +	{ .compatible = "fsl,imx8ulp-mu", .data = (ulong)&imx_mu_cfg_imx8ulp },
>>> +	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
>> Wouldn't it be useful to include also fsl,imx95-mu-ele and fsl,imx95-mu-v2x for
>> iMX95 ? Esp. the ELE is something which surely is present due to the AHAB
>> container, right ?
> 
> The compatible " fsl,imx8ulp-mu" used by i.MX8ULP MU is incorrect. Will modify it in the next version.

OK

> The driver of i.MX95 ELE MU is in drivers/misc/imx_ele/ele_mu.c.

Why does Linux use MU driver for the ELE , while U-Boot has some 
separate driver ?

> No need to add the driver for i.MX95 MU V2X in U-Boot.

How so ?
