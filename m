Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F80CCA0EFA
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 12:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCCA782E37;
	Sat, 23 Aug 2025 14:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="k6FtCJzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDEC88304A; Sat, 23 Aug 2025 14:21:23 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB64A82BA7
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 14:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c8GPW6x5mz9tPJ;
 Sat, 23 Aug 2025 14:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755951680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7397MrAYDcaoGJbUNgg6/ozx9MDFZQheI3djLfHs8g=;
 b=k6FtCJzZI2p47LQ8+b3ivpQtQ8Vuk4Xl1UOQu6xtK3J4RNYA6QPu0voKJwSJmpPROlPUDh
 X8pgGRM+tOorpC3SogDvf84Ix+Rh2eQtsHkTp6QDUW7NijCbeqeDQl08hQewBacoV6FtEu
 UFrPiOc2ZWqWlIVoohN08P63P/N8CAol4S5ucIWnDXoLxA9+T3ZqfqyYLGI8yr7RGGdH/T
 bmTEUU9fwwtkgvNuxv1J4TkThnvMGXnlX2O8wF0wmD186jQJw2EzntwVU72+/sstglgwAA
 9dSHRfl4AyvwQse/DYsESql9Wag1/pZT21BRqTMqNX3YhQw3kDcsW0ry/IQGsg==
Message-ID: <24dab90e-b15a-49d6-acbb-3302ae34ac1a@mailbox.org>
Date: Sat, 23 Aug 2025 14:21:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 u-boot@lists.denx.de
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
 <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
 <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
 <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
 <e2257066-ee97-44ff-9338-cec69f8c7f03@ti.com>
 <2ff9412a-795c-422b-9be4-576e64a7f395@mailbox.org>
 <63d6759a-a8be-41d6-8870-72bdc3856c05@ti.com>
 <bf35a459-29dc-48f8-a353-7f75493e959c@mailbox.org>
 <a6bb77e3-2702-469d-a684-0dce753e78b0@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a6bb77e3-2702-469d-a684-0dce753e78b0@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rf7ke8iafzweghpwwmpx9i8zxi6iwgsw
X-MBO-RS-ID: ea841564eba2b3b4ae6
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

On 8/23/25 4:07 AM, Siddharth Vadapalli wrote:

Hi,

>>>>> I was planning to test this patch but the change being made is only
>>>>> applicable to Controller Versions:
>>>>> 	#define DEV_VER_NXP_V1		0x00024502
>>>>> 	#define DEV_VER_TI_V1		0x00024509
>>>>> and not to:
>>>>> 	#define DEV_VER_V2		0x0002450C
>>>>> 	#define DEV_VER_V3		0x0002450d
>>>>>
>>>>> Since I don't have an SoC and a Board with DEV_VER_TI_V1, I cannot test
>>>>> it. However, the change looks correct to me.
>>>>>
>>>>> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> The change does indeed look correct.
>>>>
>>>> Do you know who might still have that board and could test ? (and which
>>>> board/soc is that) ?
>>>
>>> None of the boards that I have worked with have a DEV_VER_TI_V1 version
>>> of the controller. I also tried to use the Linux device-tree to check if
>>> I could identify the SoC/board but I was unable to do so.
>> Do you know which SoC is V2 and V3 ?
> 
> I spent more time on this and found out that J721E SR 1.0 has the
> controller with DEV_VER_TI_V1 version but other revisions of J721E as
> well as all of the following SoCs have DEV_VER_V3 version of the
> controller:
> AM64, AM68, AM69, J7200, J721S2, J722S, J742S2 and J784S4.
> 
> I will try to find an SR 1.0 J721E SoC and test the patch on it and
> share the results here.
This is awesome, thank you !
