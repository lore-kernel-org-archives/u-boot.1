Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5817EE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5424280079;
	Tue,  7 Jan 2025 13:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736254743;
	bh=G2EGKqqJ0AB1oi//pNZQQ1amr32KDRQguc8Z6itfO/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H3yW6DMZh7y6KET1/s1J5WgrBDRnGRBbVWdS8EERIUB7mFmmMd3ybQmX/NunvDDLh
	 q8cNmdkLzvb7MPiUkU1sExptQW8sEuWg7QJrbSyqtDz8a/2ZXYO+JKYB5e23v3XjLt
	 LfJgVaWCE10eI7oybGl4aMr3VmcPKoU+Ssh2lj/y0EQcBpKu+ZGtxge8hfKFCX9TDD
	 eU1hMlc1nI2CmFRprZM3ngpLCqGzwx2sRc2neOcQuJiRNyr6l//G3iLFr2Ce+ZBANS
	 u88klUOYJfdeQQplZU7q9o3NwjwMLyYgS3wIHD66O/mK4qYYu8Frnuo0m+K4cWSWVJ
	 mhdDqEG9tkKFw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 723428056D; Tue,  7 Jan 2025 13:58:57 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6228036D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="fT394S0R"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 014FB104811F3; Tue,  7 Jan 2025 13:58:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736254732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2EGKqqJ0AB1oi//pNZQQ1amr32KDRQguc8Z6itfO/0=;
 b=fT394S0RD5xHI+NcuQbgCOfQwEdW0aoYIElq+LKxNFKhb0lpgpwAqBdXvI74CHZFcpCH1x
 iP+jC+X7zTRTNzG9q9kKiWwv5TtC/aGHs1R8g5815kktCJdj6FNskeWm8m2sYV723LZ+wl
 EiRSGcBV3F3Az9lYx3Tg8VUAMUY3BSWOUWA6bVhxO3VMZAORFl+GNaHu/mL81KChXIli1J
 s1pLGlfg9Tz3rEhjgn7Z7LWX7W3rtzDOQGysN5GRCGZd3DIRqEaKYN7TjVpVsE7BE5Tcae
 bHByEZDYdzaF9Sefz+zqVo/wUsHXE9cBCsP+Cn/6sp7l3A0NCH72WQ/XiIpKzQ==
Message-ID: <bf669d4c-c0d8-4578-837d-c2f4531273aa@denx.de>
Date: Tue, 7 Jan 2025 13:37:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAz?=
 =?UTF-8?Q?/17=5D_pinctrl=3A_nxp=3A_add_SCMI_pin_control_protocol_driver?=
To: Peng Fan <peng.fan@nxp.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
 <61075a72-7a89-4bcf-8d96-f9fc24dfd5a5@denx.de>
 <PAXPR04MB96440F6976C336998424F176E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <016aa4e5-c33d-4f77-9a12-c218c4123403@denx.de>
 <PAXPR04MB964470D51ACF7CCD08EE87F0E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <7c7ab649-2bda-4693-8e41-c41c8e820c06@denx.de>
 <PAXPR04MB8459F3B1A250609CE5788F3D88112@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB8459F3B1A250609CE5788F3D88112@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On 1/7/25 1:11 PM, Peng Fan wrote:

[...]

>>> You cannot replace System Manager with optee-os.
>>
>> I think optee-os is also capable of being SCMI provider, so I have to
>> wonder, why does NXP use custom hand-written SCMI provider instead
>> of something already available, like that optee-os ?
> 
> System controller is the central controller of the system, and
> i.MX95 needs support safety.
> 
> We need to make sure when A55 crashes, safety core still work
> properly.

I think we are conflating two separate functionalities here:

- SM as the always-running monitor software
- SM as the SCMI provider

... please read on ...

>> And one more question, would it be possible to make U-Boot NOT
>> depend on SCMI at all and instead have regular clock/pinctrl drivers
>> which can configure the hardware using plain register writes, like it is
>> done on MX8M and older SoCs ?
> 
> See https://www.nxp.com/docs/en/data-sheet/IMX95CEC.pdf
> Only one boot mode:
> Low Power Boot (LPB): only M33 core is running after POR

OK

> You may configure TRDC to assign resources to A55, but
> you still need to make sure M33 work proper.
... so, I wonder, can the M33 act as SM, and can U-Boot configure 
whatever it needs via plain register writes, without having to rely on 
SCMI ?
