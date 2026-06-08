Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9B4CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 12:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C2A83EEF;
	Mon,  8 Jun 2026 14:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="C/l3+gjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C9A83FEC; Mon,  8 Jun 2026 14:46:57 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B77AC807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 14:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8ECAC112C66; Mon,  8 Jun 2026 14:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780922814;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KzAhNF2jp6GDWqyd3hpsBw6RuEVQK26b+kjHvEg1KA8=;
 b=C/l3+gjBMR8cZOa9jmaO/5R/DrBXX67/8cEgXyVNauh43Ulv+vp7Qr495k9WqK6TmneXe7
 ubz5H4i8Tm81T2iqubQE3H8+87j3RZ5q8YgmujvCr4/tMjl/b7oQXFnPDHbnxOHECJxbJY
 W8VcEWSHWFuwyQz853pEJHLItzky8ETD+Gn4SBGIrGs3Bs+E24JN13VcMsIkIRBr7itllk
 qbRTBIn5KV9dLfTI3g0JjvAp7IkNbA3AcZLMhsXm5TP5oMRj7RpLLXRN+5fF/1cyCJPFj0
 DLgqwuTeh8Yd01yTIY5AkSNRg6BFWgGEQWQKrcHJAa5EZn7r8k6m4FM5++mQIA==
Message-ID: <01f0ff94-a956-435d-b642-fcde56ebf4f3@nabladev.com>
Date: Mon, 8 Jun 2026 14:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxIDMvM10gbmV0OiBmc2xfZW5ldGM6?=
 =?UTF-8?Q?_Add_SGMII_support_for_i=2EMX95?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>
References: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
 <20260603-sgmii-v1-3-c4a0af0d5d3d@nxp.com>
 <4a12deb6-b10f-4bb3-a6ab-6a4c508dc2a9@nabladev.com>
 <AS8PR04MB8721009281873A84A411AC9BE21C2@AS8PR04MB8721.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <AS8PR04MB8721009281873A84A411AC9BE21C2@AS8PR04MB8721.eurprd04.prod.outlook.com>
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

On 6/8/26 8:58 AM, Alice Guo (OSS) wrote:

Hello Alice,

>>> Add SGMII interface mode configuration for i.MX95 platform in ENETC
>>> driver.
>> Which PHY did you use for the tests here ?
>>
>> Have you also tested this with a 100/Full only (not 1000/Full) capable switch --
>> does this work in 100/Full node or does this work only in 1000/Full mode ?
> 
> Hi Marek,
> 
> I tested this using the Aquantia AQR113C PHY. The interface works correctly in 1000/full mode, but it does not support 100/full mode.
Do you know why is the 100/Full operation not supported ?

I also noticed the same in Linux, and also with DP83867.

I would expect the SGMII to duplicate traffic on the SGMII bus 10x/100x 
in 100/Full and 10/Full modes, is this not the case with MX95 and SGMII 1G ?

Thank you for your help !
