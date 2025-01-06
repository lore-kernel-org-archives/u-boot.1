Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B36CE77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 20:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC1F805EA;
	Mon,  6 Jan 2025 21:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736196682;
	bh=xSIT4/Q7XYS/xptR90HFfv0oJadqKfK0mMwB34qyXrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uWznBxDnN5z5YrjlZT0n3Fukbg/c7f/hhKNBoX73MRhYc9Z9ZLbcShftp/2GR0w9m
	 04eg+CfRmEWcCk/mrfnEf50SBIG94AdoQWYDoVzVpKjt1NxK4C2pl6kpl8XeelsJsk
	 Ow25ECh35OtXoZLuM6sGa7o+pDAEsKPCRquTxu40QXevsVuNFLjdVZfBGeBSuWtf0a
	 pbWoO7Yb0zmd7Ha9x7Qq/c8aRhePA9sLfluadHx9ediMqpjbzA4ciq4JCaFAb5I56I
	 V0tfdls75pM4ZZVc98OCcwtKASR6bpjO5gOvkggQ05OHXYCPkVXwnOiuqJY+VlYORn
	 ofzHE0ys6nqow==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F093805C5; Mon,  6 Jan 2025 21:51:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98620805C5
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 21:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XRLBH23a"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 27EB410A4C6C4; Mon,  6 Jan 2025 21:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736196678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSIT4/Q7XYS/xptR90HFfv0oJadqKfK0mMwB34qyXrQ=;
 b=XRLBH23aQJ8efyt/Jczzowkc+RvIuCFdXlZGAEuUDrzuvHt3AruGixk/4pfbOMQM09ez4g
 CQtVHoUV2uikQ14fBMqqTbXpi7S4GWHplerDlhqofb6vj2pgEoDcyBogiOfIlSUe5Jk45m
 yEy0je/2M9rr1Ma2aaf2MyaOJ46MaM+HzrfbKbYCIsukmsOQG2mS/+65oKGVdUFjKZdggC
 Tpo265aOmvkFhI2YBObLuj63Lq0iNGK6Q8PeqnreFzuVfWJrLItO6vkUWF9NPCxKwAuwGd
 jzbA9IMKrf1ui2nn07Nso28tm+COS4WyMNXhacSV3O9kdzEWC+IqcKiFwMd+lg==
Message-ID: <dbfd7a78-06e3-4e42-961c-5130f1707f26@denx.de>
Date: Mon, 6 Jan 2025 21:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMi8xN10gZmly?=
 =?UTF-8?Q?mware=3A_scmi=3A_smt=3A_Interrupt_communication_enable?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
 <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
 <PAXPR04MB964475AEF1CB007B5949088CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB964475AEF1CB007B5949088CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 1/6/25 7:17 AM, Alice Guo (OSS) wrote:
>> On 1/3/25 7:45 AM, Alice Guo wrote:
>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>
>>> When interrupt driven communication is supported
>>
>> U-Boot does not use interrupts.
>>
>>> , the transport allows
>>> the caller to choose between interrupt and polling driven
>>> communications. To make the choice, the channel flags are used. i.MX95
>>> uses interrupt driven communication so that Channel flags should be
>>> set to 1.
>>
>> How does this work in U-Boot, which does not use interrupts ?
> 
> Hi Marek,
> 
> The clearer explanation will be added in the commit log.
> 
> This is based on Arm® System Control and Management Interface Platform Design Document Version 3.2 (Document number: DEN0056E) 5.1.2. When Bit[0] of Channel flags is 1, the System Manager runs on M core will trigger general-purpose interrupts to A core. U-Boot polls General-purpose Status (GSR) until GIPn is set.
If U-Boot does polling, why does this bit need to be set, shouldn't the 
bit be cleared instead ?
