Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC48FCA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 15:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02CC83321;
	Thu, 28 Aug 2025 17:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cHYRSMO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A98183327; Thu, 28 Aug 2025 17:47:04 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C59F8328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 17:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cCQkV41kyz9t2M;
 Thu, 28 Aug 2025 17:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756396018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3C8RIGUxa1W2NMGvlphOQ+6+G9vhQnT520xJacCG1I=;
 b=cHYRSMO27/RgVfkSZnYxqabFeWHC7sHpat1B/qPe6pUZNOPo5WSTf0p1DDTH2JbIWW4Vk0
 QFSOl4HNK3Kuo5A5MJjxXMUo1BsNdg9xXpZpG6HM7RL0c9bzTod9gFViGc4NTjVwbIdRYT
 OtQMeCxfkTy3+eI7sdhtaDfITroo6G29gxjs/AOPDnpBc2ZX8nIS0VYqu43EjiWh1HSG/m
 PTKbjBt3ZLtQ8LB/FmK2hJ6OVb3JjRz9rghVT6eXlCUrI6nYT+zYqujQnff96OIU93Hyek
 sEoDu0G1tHPXTE3tZaU+8Iyssdsmb/V/z0xsehBE81zLvHxxnYVGaePL8HZScQ==
Message-ID: <9833dfa9-562a-4f2d-ae65-d00bc4de2c92@mailbox.org>
Date: Thu, 28 Aug 2025 17:46:56 +0200
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
 <24dab90e-b15a-49d6-acbb-3302ae34ac1a@mailbox.org>
 <6e5ccaaa-3ced-440a-abe7-439ef6e7f1db@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6e5ccaaa-3ced-440a-abe7-439ef6e7f1db@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ktzgy3igeedh48xcg5kjd6tn1hfs7co4
X-MBO-RS-ID: acf8be1451381cf8e94
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

On 8/24/25 10:02 AM, Siddharth Vadapalli wrote:
> On Sat, Aug 23, 2025 at 02:21:18PM +0200, Marek Vasut wrote:
>> On 8/23/25 4:07 AM, Siddharth Vadapalli wrote:
>>
>> Hi,
>>
>>>>>>> I was planning to test this patch but the change being made is only
>>>>>>> applicable to Controller Versions:
>>>>>>> 	#define DEV_VER_NXP_V1		0x00024502
>>>>>>> 	#define DEV_VER_TI_V1		0x00024509
>>>>>>> and not to:
>>>>>>> 	#define DEV_VER_V2		0x0002450C
>>>>>>> 	#define DEV_VER_V3		0x0002450d
>>>>>>>
>>>>>>> Since I don't have an SoC and a Board with DEV_VER_TI_V1, I cannot test
>>>>>>> it. However, the change looks correct to me.
>>>>>>>
>>>>>>> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>>> The change does indeed look correct.
>>>>>>
>>>>>> Do you know who might still have that board and could test ? (and which
>>>>>> board/soc is that) ?
>>>>>
>>>>> None of the boards that I have worked with have a DEV_VER_TI_V1 version
>>>>> of the controller. I also tried to use the Linux device-tree to check if
>>>>> I could identify the SoC/board but I was unable to do so.
>>>> Do you know which SoC is V2 and V3 ?
>>>
>>> I spent more time on this and found out that J721E SR 1.0 has the
>>> controller with DEV_VER_TI_V1 version but other revisions of J721E as
>>> well as all of the following SoCs have DEV_VER_V3 version of the
>>> controller:
>>> AM64, AM68, AM69, J7200, J721S2, J722S, J742S2 and J784S4.
>>>
>>> I will try to find an SR 1.0 J721E SoC and test the patch on it and
>>> share the results here.
>> This is awesome, thank you !
> 
> I was able to get an SR 1.0 J721E SoC and also the J721E
> Common-Processor-Board for testing the patch.
> 
> Enabling debug info in the cdns3/gadget.c driver, I see:
> 	cdns-usb3-peripheral usb@6000000: Device Controller version: 00024509
> 	cdns-usb3-peripheral usb@6000000: USB Capabilities:: 09203324
> 	cdns-usb3-peripheral usb@6000000: On-Chip memory cnfiguration: 00000c34
> which confirms the Controller Version.
> 
> However, the code changed by the current patch is only affecting the
> execution of code associated with Workaround 2 which is described in
> detail in the driver. I am summarizing it here for your reference:
> 
> Issue:
> 	Controller for OUT endpoints has shared on-chip buffers for all
> 	incoming packets. The buffer acts as a FIFO, due to which,
> 	missing a DMA descriptor for one packet will block subsequent
> 	transfers/packets meant for other Endpoints that were queued.
> 
> Workaround:
> 	If the Endpoint Status register indicates a Descriptor Miss,
> 	rearm the DMA transfer to complete the missed transfer.
> 
> In order to test the patch, I used USBACM for STDIO/STDOUT to check if I
> could trigger the descriptor miss workaround. The command I ran was:
> setenv stdio usbacm; setenv stdout usbacm;
> /dev/ttyACM0 showed up on my PC and I was also able to access the U-Boot
> prompt via ACM0. While it is functional, I didn't see the code
> associated with the workaround being triggered. Reviewing the driver
> again, I identified that the workaround is being disabled very early on
> within "cdns3_wa2_gadget_ep_queue()" with the comment stating:
> 
> 	 * If transfer was queued before DESCMISS appear than we
> 	 * can disable handling of DESCMISS interrupt. Driver assumes that it
> 	 * can disable special treatment for this endpoint.
> 
> Given the above, it doesn't seem easy to recreate the issue since I
> would have to trigger a descriptor miss event prior to the very first
> USB transfer for the Endpoint. Please let me know if you have any
> suggestions for speeding up testing.
Can you maybe simply force-enable the workaround code and see if that 
itself works, without crashing ? If yes, then I would say let's apply this.
