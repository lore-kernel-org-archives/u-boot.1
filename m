Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A725CCFA06
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 15:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AF9838CE;
	Mon,  3 Nov 2025 16:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lKEOokU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8673838D7; Mon,  3 Nov 2025 16:26:44 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A3C836D1
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 16:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d0b683hmVz9sQS;
 Mon,  3 Nov 2025 16:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762183600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kfoGLpJ9YFqQVuTfs6MtMtjGwT3LqJsiPsibKDAeMPc=;
 b=lKEOokU/q3s6S64vAtg18xAgswTwkluQ2X+fDUbFl2PjeaJSpIjZ3Ned2Fx9V/OBzRxAFp
 iB6DXZoDnFHa6/FnmDIds0grvhUFxQS6fXGE2niFMpy3NKQ4uY+u2qr9K5KBl7iSdWEbpj
 fN2W5GO4Nfocp5Rfm0/0yfWkMn3OiwK4Le3i0mIhFZKjmHWdH+Pi/H1OuVGj/JSTUsE0V1
 uH21F2OUWDsbw8+07o6WSgxP4kjrNz4JJbv36QnyzWdlYccQPLcKcSlJP/iZUCkasNHN3j
 GQet4SgZIKVqtOictDOcXQF4pIwIWZiyavoxNBieApMEyGUE17q3S4wSaC8qPA==
Message-ID: <c272350d-7aac-405a-9e61-b1b1f48dedda@mailbox.org>
Date: Mon, 3 Nov 2025 16:26:36 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IOWbnuWkjTog5Zue5aSNOiDlm54=?=
 =?UTF-8?B?5aSNOiBbUEFUQ0hdIGZpcm13YXJlOiBzY21pOiBEcm9wIG1tdV9zZXRfcmVnaW9u?=
 =?UTF-8?Q?=5Fdcache=5Fbehaviour=28=29_misuse?=
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Alice Guo <alice.guo@nxp.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Etienne Carriere <etienne.carriere@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
 <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
 <PAXPR04MB964436F50D41BF186019598FE2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <ad762bb5-fb1d-47db-94ca-b8115f077e6f@mailbox.org>
 <PAXPR04MB96441809F6362E35C7D3E052E2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <6193cdf5-ff52-4c8f-952e-0feb738f5c8f@mailbox.org>
 <189dc72e-a2a3-4081-99df-8ec17cf730ff@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <189dc72e-a2a3-4081-99df-8ec17cf730ff@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: w4z6adtyx6nfwfku1mexg1jfjh5w7obp
X-MBO-RS-ID: cb868c836da3c80aa4b
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

On 11/3/25 2:11 PM, Patrick DELAUNAY wrote:

Hello Patrick,

>> So I think, this now covers
>> - NXP SoCs -- iMX8ULP , iMX95
>> - TI SoCs -- AM6.. ?
>>
>> How about ST SoCs ?
> 
> 
> No impacts for ST SoCs.
> 
> 
> Now ae are using OP-TEE transport for SCMI messages without external 
> shared memory
> 
>              compatible = "linaro,scmi-optee";
>              linaro,optee-channel-id = <0>;
> 
> => the message are managed by only by OP-TEE channel
> 
> Reference:
> 
> - b2fb22396f97 ("ARM: dts: stm32mp15: remove shmem for scmi-optee")
> 
> - 3fce6bf21309 ("ARM: dts: stm32mp13: remove shmem for scmi-optee")
> 
> Moreover the patch is coherent with linux behavior
> 
> (https://lore.kernel.org/r/20211125150730.188487-1-sudeep.holla@arm.com)
> 
> 
> This part was initially introduced by Etienne when OP-TEE transport use 
> a static or dynamic shmem in DDR,
> 
> which was mapped by default as cacheable.
> 
> 
> But it is more the case for STM32 SoCs today or in futur
> 
> (SCMI channel with TF-M use internal memory mapped not ccheable).

Does the MP25 use SCP at all, or does OP-TEE on Cortex-A handle the 
SCMI/hardware interaction ?

>> Anything else left over ?
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Thank you
