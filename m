Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6D2E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 20:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECDF805E2;
	Mon,  6 Jan 2025 21:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736196685;
	bh=ZpcTbYoGf+PzdmELiE3CcPD6LtQCgd+P5BIXsxo7Uq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zaRTNiZtTEmSaJRBlAjeXydfDLdl/u7ufThfoeiSZ430vQKqcD8Ocwvtmc29W7POw
	 ROTycuZS9AOZ6QcDeFxyIuaOXJq8HC5DrToxPB4SxvfA8n1wBWzMp4oYbyMTS4tLUj
	 WDvJz+AS1vJoUA+CTmbz2l4a9z7fu6Od9zqdrRAb/Vv2wafrb9zwKVObPon1DD8sHI
	 QCcbogQVG5akVPlFhp8DfBNeI9SRZawOokKnyQXjznEUxenTsLA+0ivuKPFYffVN+E
	 0exCDD/vHz2+fjnTKXP19N3gvyR/opC0FX2FGPKvbtSoOxHE5RI9mkryOrTQePDtbs
	 TFO73Xbc5sdZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2447C805FA; Mon,  6 Jan 2025 21:51:24 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD514805E1
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 21:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="TpH6WGK9"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 57936101ECB2C; Mon,  6 Jan 2025 21:51:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736196681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpcTbYoGf+PzdmELiE3CcPD6LtQCgd+P5BIXsxo7Uq0=;
 b=TpH6WGK9OmnJgLXnk5IAVULpS2KInfNiRw8iCGKN4Ak8mCtj6aEBQ68zVOvfpclLzq843e
 MunHrQ0lucIjMoZg1zhCA4d56u1y8ClabUzc3TZoZFhfQLeULFdN7XlgHA9y/2FvcABLyy
 fhxLtANJVJOw4y2wwo38G5eWJZGzxhed81q/8lwlFPadsY5i1vzthqU9ShXjpLnaj3UJUG
 wYZt34J2z7IuuUlQeN0RhtR5sNq/fQ+CoMuFok1nKPjjR/c7nOFovGe+AozEc2r9kD+rH7
 IBO/NoXlN6Pm3E1gQS1qKabcpLMxnt9atVpmZMRq248Jntc35pO7wEMD8cbqzA==
Message-ID: <016aa4e5-c33d-4f77-9a12-c218c4123403@denx.de>
Date: Mon, 6 Jan 2025 21:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMy8xN10gcGlu?=
 =?UTF-8?Q?ctrl=3A_nxp=3A_add_SCMI_pin_control_protocol_driver?=
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96440F6976C336998424F176E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 1/6/25 10:56 AM, Alice Guo (OSS) wrote:
>>> This patch provides a driver for the SCMI pin control protocol which
>>> is based on ARM's System Control and Management Interface (SCMI) 3.2.
>>> Currently, only the PINCTRL_CONFIG_SET command is implemented.
>>
>> What is the SCMI provider for this platform ?
> 
> Hi Marek,
> 
> System Manager which runs on M core sets pin or group configurations. U-Boot sends a SCMI message to System Manager to perform hardware operations. You can refer to the source code for details: https://github.com/nxp-imx/imx-sm.

Can I use optee-os as a SCMI provider instead ?

>>> +#include "pinctrl-imx.h"
>>> +
>>> +#if defined(CONFIG_IMX93)
>>
>> Use IS_ENABLED() or CONFIG_IS_ENABLED()
>>
>>> +#define DAISY_OFFSET 0x360
>>
>> Why can this offset information not be queried from the firmware interface ?
> 
> This offset information is not provided by System Manager. DAISY_OFFSET is used to convert the daisy register address in imx95-pinfunc.h for System Manager to use.
OK
