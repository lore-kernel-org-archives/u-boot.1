Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5828EC28B2F
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 03:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6488281417;
	Mon, 10 Mar 2025 04:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741576062;
	bh=3fIcHGOx/cziPlJ2DED2xMpbM8E8xN2GzdmMuHmUQ8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uxXQsh5s+VGtUUMkU/+jza7H6CiMnEoXZOKEEQRcH5vAPus06QDEwCOqTDD1fxHlY
	 oZNPtHS7w5/q+zUllywx+kvPqwMtszxWKRX+WTcLlSQGNeEQd0aLgewTn6CE8F4g8I
	 5JMHd9o+Jlj5Z9Bl8RnnJcxsl/YwvvEsQ5LdlzorndpHN7FjufwJAvBXQXBQAE1kFk
	 aIlIUw6pkPBHCwhVO+BkbKjWo4G/IHVGa2MJsX8pYucXNqLaCG6IXKR1mv+QZTVFrg
	 Jt/td2NAtpvtR3ZaCweR0Zikd4HhoSnEgeSTwEaLbX8D9OuXoGKXz/bjwdq8c2HhGu
	 FzDuFnlgxMsVg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B818129F; Mon, 10 Mar 2025 04:07:40 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A1F780E93
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 04:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="I3Te98Kt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AFF25102E633E; Mon, 10 Mar 2025 04:07:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741576057; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3fIcHGOx/cziPlJ2DED2xMpbM8E8xN2GzdmMuHmUQ8I=;
 b=I3Te98KtQzfwCk03ehhwwx9V3YHkEfkSrMUGej1Pa6vro2Jl0OBY0+Vhkr4v1cIfOwTfSM
 1Cb2rljpsq0zXbWT7pQN3hknXE/x6HnaGv//TfGMW1rbQ4/Qi5U7WPhYGmNW6SF3DqIeub
 jDkleqv01tLu6FVteUdKY8xPVDvdzYk/MPzRglGVfGOiXj/K77DAILTwJsXKMj9+rxDYqf
 pnPRD/x4NNx12tabLMrHTWuInQBB/Y4pQVyO21b8KIgHHNLsSejLOQMX87TmKF6apOaACY
 4CmSZKf8GzTSru7y9avI0nOq2HdIAdRH8cEL6kTeinhh54GmjnXpCSjvC8k1Dg==
Message-ID: <1d8184ef-7fd3-4ee7-87fd-086a0babb4ee@denx.de>
Date: Mon, 10 Mar 2025 01:11:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjYgMDIvMjBdIGZpcm13?=
 =?UTF-8?Q?are=3A_scmi=3A_smt=3A_Interrupt_communication_enable?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-2-09594e93cc9b@oss.nxp.com>
 <9f02e9b3-a238-4a68-93f7-550bd63dceb2@denx.de>
 <PAXPR04MB964420C8F69517BDE8E406D6E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7dd64a4-2c85-46d7-802f-f55fff445455@denx.de>
 <PAXPR04MB9644C745B5281AA3B94D83C1E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644C745B5281AA3B94D83C1E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 3/4/25 8:10 AM, Alice Guo (OSS) wrote:

Hi,

>>> Do you mean that replace
>> IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR) by checking "arm,scmi"
>> and "mboxes" in device tree?
>> If that is possible, yes.
> 
> I do not think that Bit[0] of channel flags should be set to 1 only when the SCMI node has the compatible "arm,scmi" and the property "mboxes". Whether to set it depends on the implementation of the SCMI callee-side.

Can you think of any other cases when this bit should be set ?

If not, maybe we should start with this heuristics and then extend it 
when other SoCs show up which need some more complex detection ?

Or do you think this heuristics is nonsense ?
